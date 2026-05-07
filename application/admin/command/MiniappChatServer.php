<?php

namespace app\admin\command;

use app\common\library\MiniappChat;
use think\Cache;
use think\console\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\input\Option;
use think\console\Output;
use think\Db;

class MiniappChatServer extends Command
{
    protected $server = null;
    protected $clients = [];
    protected $output = null;

    protected function configure()
    {
        $this
            ->setName('miniapp_chat_server')
            ->addArgument('action', Argument::OPTIONAL, 'start', 'start')
            ->addOption('host', null, Option::VALUE_OPTIONAL, 'listen host', '0.0.0.0')
            ->addOption('port', null, Option::VALUE_OPTIONAL, 'listen port', 8282)
            ->setDescription('Miniapp chat WebSocket server');
    }

    protected function execute(Input $input, Output $output)
    {
        $this->output = $output;
        $action = (string)$input->getArgument('action');
        if ($action !== 'start') {
            $output->writeln('Only start action is supported: php think miniapp_chat_server start');
            return;
        }

        $host = (string)$input->getOption('host');
        $port = (int)$input->getOption('port');
        MiniappChat::ensureRooms();

        $this->server = @stream_socket_server('tcp://' . $host . ':' . $port, $errno, $errstr);
        if (!$this->server) {
            $output->writeln('WebSocket server start failed: ' . $errstr . ' (' . $errno . ')');
            return;
        }

        stream_set_blocking($this->server, false);
        $output->writeln('Miniapp chat WebSocket server started at ' . $host . ':' . $port);
        $output->writeln('Room links: /room/1, /room/2, /room/3');

        while (true) {
            $read = [$this->server];
            foreach ($this->clients as $client) {
                $read[] = $client['socket'];
            }

            $write = null;
            $except = null;
            if (@stream_select($read, $write, $except, 1) === false) {
                continue;
            }

            foreach ($read as $socket) {
                if ($socket === $this->server) {
                    $this->acceptClient();
                    continue;
                }

                $this->readClient($socket);
            }
        }
    }

    protected function acceptClient()
    {
        $socket = @stream_socket_accept($this->server, 0);
        if (!$socket) {
            return;
        }
        stream_set_blocking($socket, false);
        $id = (int)$socket;
        $this->clients[$id] = [
            'socket'      => $socket,
            'handshake'   => false,
            'buffer'      => '',
            'room_id'     => 0,
            'authed'      => false,
            'actor_type'  => '',
            'actor_id'    => 0,
            'sender_name' => '',
            'client_ip'   => $this->getClientIp($socket),
        ];
    }

    protected function readClient($socket)
    {
        $id = (int)$socket;
        if (!isset($this->clients[$id])) {
            return;
        }

        $data = @fread($socket, 8192);
        if ($data === '' || $data === false) {
            if (feof($socket)) {
                $this->closeClient($id);
            }
            return;
        }

        if (!$this->clients[$id]['handshake']) {
            $this->clients[$id]['buffer'] .= $data;
            if (strpos($this->clients[$id]['buffer'], "\r\n\r\n") === false) {
                return;
            }
            $this->handshake($id, $this->clients[$id]['buffer']);
            $this->clients[$id]['buffer'] = '';
            return;
        }

        $this->clients[$id]['buffer'] .= $data;
        while (($frame = $this->decodeFrame($this->clients[$id]['buffer'])) !== null) {
            if ($frame['opcode'] === 8) {
                $this->closeClient($id);
                return;
            }
            if ($frame['opcode'] === 9) {
                $this->sendRaw($id, $this->encodeFrame($frame['payload'], 10));
                continue;
            }
            if ($frame['opcode'] !== 1) {
                continue;
            }
            $this->handlePacket($id, $frame['payload']);
        }
    }

    protected function handshake($id, $request)
    {
        $lines = preg_split("/\r\n/", $request);
        $firstLine = $lines[0] ?? '';
        if (!preg_match('#^GET\s+([^\s]+)\s+HTTP/1\.[01]#i', $firstLine, $match)) {
            $this->rejectClient($id, 400, 'Bad Request');
            return;
        }

        $url = parse_url($match[1]);
        $path = $url['path'] ?? '';
        if (!preg_match('#^/room/([1-3])/?$#', $path, $roomMatch)) {
            $this->rejectClient($id, 404, 'Room Not Found');
            return;
        }

        $roomId = (int)$roomMatch[1];
        if (!MiniappChat::getRoom($roomId)) {
            $this->rejectClient($id, 404, 'Room Not Found');
            return;
        }

        $headers = [];
        foreach ($lines as $line) {
            if (strpos($line, ':') === false) {
                continue;
            }
            list($key, $value) = explode(':', $line, 2);
            $headers[strtolower(trim($key))] = trim($value);
        }

        if (empty($headers['sec-websocket-key'])) {
            $this->rejectClient($id, 400, 'Bad Request');
            return;
        }

        $accept = base64_encode(sha1($headers['sec-websocket-key'] . '258EAFA5-E914-47DA-95CA-C5AB0DC85B11', true));
        $response = "HTTP/1.1 101 Switching Protocols\r\n"
            . "Upgrade: websocket\r\n"
            . "Connection: Upgrade\r\n"
            . "Sec-WebSocket-Accept: " . $accept . "\r\n\r\n";
        $this->sendRaw($id, $response);
        $this->clients[$id]['handshake'] = true;
        $this->clients[$id]['room_id'] = $roomId;
        $this->sendPacket($id, ['type' => 'ready', 'room_id' => $roomId]);
    }

    protected function handlePacket($id, $payload)
    {
        $packet = json_decode($payload, true);
        if (!is_array($packet)) {
            $this->sendError($id, '消息格式错误');
            return;
        }

        $type = (string)($packet['type'] ?? '');
        if ($type === 'ping') {
            $this->sendPacket($id, ['type' => 'pong', 'time' => time()]);
            return;
        }

        if ($type === 'auth') {
            $this->handleAuth($id, $packet);
            return;
        }

        if (empty($this->clients[$id]['authed'])) {
            $this->sendError($id, '请先鉴权');
            return;
        }

        if ($type === 'message') {
            $this->handleMessage($id, $packet);
            return;
        }

        $this->sendError($id, '未知消息类型');
    }

    protected function handleAuth($id, array $packet)
    {
        $actorType = (string)($packet['actor_type'] ?? '');
        if ($actorType === MiniappChat::SENDER_USER) {
            $token = trim((string)($packet['token'] ?? ''));
            $user = $token === '' ? null : Db::name('miniapp_user')->where('token', $token)->where('status', 1)->find();
            if (!$user || $this->isMiniappTokenExpired($user)) {
                $this->sendPacket($id, ['type' => 'auth', 'code' => 0, 'msg' => '登录已失效']);
                return;
            }

            $this->clients[$id]['authed'] = true;
            $this->clients[$id]['actor_type'] = MiniappChat::SENDER_USER;
            $this->clients[$id]['actor_id'] = (int)$user['id'];
            $this->clients[$id]['sender_name'] = (string)($user['username'] ?: $user['nickname'] ?: $user['tel'] ?: ('UID:' . $user['id']));
            $this->sendPacket($id, ['type' => 'auth', 'code' => 1, 'msg' => 'ok', 'room_id' => $this->clients[$id]['room_id']]);
            return;
        }

        if ($actorType === MiniappChat::SENDER_ADMIN) {
            $ticket = trim((string)($packet['ticket'] ?? ''));
            $admin = $ticket === '' ? null : Cache::get('miniapp_chat_admin_ws_' . $ticket);
            if (!$admin) {
                $this->sendPacket($id, ['type' => 'auth', 'code' => 0, 'msg' => '后台鉴权失败']);
                return;
            }
            Cache::rm('miniapp_chat_admin_ws_' . $ticket);

            $this->clients[$id]['authed'] = true;
            $this->clients[$id]['actor_type'] = MiniappChat::SENDER_ADMIN;
            $this->clients[$id]['actor_id'] = (int)$admin['id'];
            $this->clients[$id]['sender_name'] = (string)($admin['nickname'] ?: ('Admin:' . $admin['id']));
            $this->sendPacket($id, ['type' => 'auth', 'code' => 1, 'msg' => 'ok', 'room_id' => $this->clients[$id]['room_id']]);
            return;
        }

        $this->sendPacket($id, ['type' => 'auth', 'code' => 0, 'msg' => '身份类型错误']);
    }

    protected function handleMessage($id, array $packet)
    {
        $client = $this->clients[$id];
        try {
            $message = MiniappChat::storeMessage(
                (int)$client['room_id'],
                (string)$client['actor_type'],
                (int)$client['actor_id'],
                (string)$client['sender_name'],
                (string)($packet['content'] ?? ''),
                (string)$client['client_ip']
            );
        } catch (\Throwable $e) {
            $this->sendError($id, $e->getMessage());
            return;
        }

        $this->broadcastRoom((int)$client['room_id'], [
            'type' => 'message',
            'data' => $message,
        ]);
    }

    protected function broadcastRoom($roomId, array $packet)
    {
        foreach ($this->clients as $id => $client) {
            if (!empty($client['authed']) && (int)$client['room_id'] === (int)$roomId) {
                $this->sendPacket($id, $packet);
            }
        }
    }

    protected function decodeFrame(&$buffer)
    {
        $length = strlen($buffer);
        if ($length < 2) {
            return null;
        }

        $b1 = ord($buffer[0]);
        $b2 = ord($buffer[1]);
        $opcode = $b1 & 0x0f;
        $masked = ($b2 & 0x80) === 0x80;
        $payloadLength = $b2 & 0x7f;
        $offset = 2;

        if ($payloadLength === 126) {
            if ($length < 4) {
                return null;
            }
            $payloadLength = unpack('n', substr($buffer, 2, 2))[1];
            $offset = 4;
        } elseif ($payloadLength === 127) {
            if ($length < 10) {
                return null;
            }
            $parts = unpack('N2', substr($buffer, 2, 8));
            if ($parts[1] !== 0) {
                $buffer = '';
                return ['opcode' => 8, 'payload' => ''];
            }
            $payloadLength = $parts[2];
            $offset = 10;
        }

        $mask = '';
        if ($masked) {
            if ($length < $offset + 4) {
                return null;
            }
            $mask = substr($buffer, $offset, 4);
            $offset += 4;
        }

        if ($length < $offset + $payloadLength) {
            return null;
        }

        $payload = substr($buffer, $offset, $payloadLength);
        $buffer = substr($buffer, $offset + $payloadLength);

        if ($masked) {
            $decoded = '';
            for ($i = 0; $i < $payloadLength; $i++) {
                $decoded .= $payload[$i] ^ $mask[$i % 4];
            }
            $payload = $decoded;
        }

        return ['opcode' => $opcode, 'payload' => $payload];
    }

    protected function encodeFrame($payload, $opcode = 1)
    {
        $payload = (string)$payload;
        $length = strlen($payload);
        $head = chr(0x80 | ($opcode & 0x0f));
        if ($length <= 125) {
            return $head . chr($length) . $payload;
        }
        if ($length <= 65535) {
            return $head . chr(126) . pack('n', $length) . $payload;
        }
        return $head . chr(127) . pack('N2', 0, $length) . $payload;
    }

    protected function sendPacket($id, array $packet)
    {
        $this->sendRaw($id, $this->encodeFrame(json_encode($packet, JSON_UNESCAPED_UNICODE)));
    }

    protected function sendError($id, $message)
    {
        $this->sendPacket($id, ['type' => 'error', 'msg' => (string)$message]);
    }

    protected function sendRaw($id, $data)
    {
        if (!isset($this->clients[$id])) {
            return;
        }
        @fwrite($this->clients[$id]['socket'], $data);
    }

    protected function rejectClient($id, $code, $message)
    {
        if (isset($this->clients[$id])) {
            @fwrite($this->clients[$id]['socket'], 'HTTP/1.1 ' . (int)$code . ' ' . $message . "\r\nConnection: close\r\n\r\n");
        }
        $this->closeClient($id);
    }

    protected function closeClient($id)
    {
        if (!isset($this->clients[$id])) {
            return;
        }
        @fclose($this->clients[$id]['socket']);
        unset($this->clients[$id]);
    }

    protected function getClientIp($socket)
    {
        $name = @stream_socket_get_name($socket, true);
        if (!$name) {
            return '';
        }
        $pos = strrpos($name, ':');
        return $pos === false ? $name : substr($name, 0, $pos);
    }

    protected function isMiniappTokenExpired($user)
    {
        $lastLoginTime = isset($user['last_login_time']) ? (int)$user['last_login_time'] : 0;
        return $lastLoginTime <= 0 || ($lastLoginTime + 2592000) <= time();
    }
}
