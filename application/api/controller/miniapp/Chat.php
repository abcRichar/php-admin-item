<?php

namespace app\api\controller\miniapp;

use app\common\library\MiniappChat;
use think\Db;
use think\Exception;

class Chat extends MiniappBase
{
    public function rooms()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            MiniappChat::ensureRooms();
            $rooms = array_map(function ($room) {
                $row = MiniappChat::formatRoom($room);
                $row['ws_url'] = $this->buildRoomWsUrl((int)$row['id']);
                return $row;
            }, MiniappChat::getRooms());

            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), ['rooms' => $rooms]);
        });
    }

    public function messages()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $roomId = (int)$this->request->param('room_id', 0);
            $page = max(1, (int)$this->request->param('page', 1));
            $size = (int)$this->request->param('size', 20);
            $size = max(1, min(100, $size));

            if (!MiniappChat::getRoom($roomId)) {
                $this->apiError(__('miniapp.chat_room_not_found'), null, 404);
            }

            $total = Db::name('miniapp_chat_message')
                ->where('room_id', $roomId)
                ->where('status', 1)
                ->count();
            $rows = Db::name('miniapp_chat_message')
                ->where('room_id', $roomId)
                ->where('status', 1)
                ->order('id desc')
                ->page($page, $size)
                ->select();
            $rows = array_reverse($rows);
            $messages = array_map(function ($message) {
                return MiniappChat::formatMessage($message);
            }, $rows);

            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), [
                'room_id'  => $roomId,
                'page'     => $page,
                'size'     => $size,
                'total'    => (int)$total,
                'messages' => $messages,
            ]);
        });
    }

    public function wsConfig()
    {
        $this->execute(function () {
            $user = $this->getMiniappUser();
            $this->logRequest((int)$user['id']);
            $this->apiSuccess(__('miniapp.success'), [
                'rooms'     => array_map(function ($room) {
                    return [
                        'room_id' => (int)$room['id'],
                        'name'    => (string)$room['name'],
                        'ws_url'  => $this->buildRoomWsUrl((int)$room['id']),
                    ];
                }, MiniappChat::getRooms()),
                'token'     => $this->getToken(),
                'heartbeat' => 25,
                'protocol'  => [
                    'auth'    => ['type' => 'auth', 'actor_type' => 'user', 'token' => $this->getToken()],
                    'message' => ['type' => 'message', 'content' => 'hello'],
                ],
            ]);
        });
    }

    private function buildRoomWsUrl($roomId)
    {
        $configured = (string)\think\Config::get('site.miniapp_chat_ws_url');
        if ($configured !== '') {
            if (strpos($configured, '{room_id}') !== false) {
                return str_replace('{room_id}', (int)$roomId, $configured);
            }
            return rtrim($configured, '/') . '/room/' . (int)$roomId;
        }

        $host = (string)$this->request->host();
        $host = preg_replace('/:\d+$/', '', $host);
        $scheme = $this->request->isSsl() ? 'wss' : 'ws';
        return $scheme . '://' . $host . '/wss/room/' . (int)$roomId;
    }
}
