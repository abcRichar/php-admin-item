<?php

namespace app\common\library;

use think\Db;

class MiniappChat
{
    const SENDER_USER = 'user';
    const SENDER_ADMIN = 'admin';
    const MESSAGE_TYPE_TEXT = 'text';
    const MAX_CONTENT_LENGTH = 1000;

    public static function ensureRooms()
    {
        $now = time();
        $rooms = [
            ['id' => 1, 'name' => '聊天室1', 'sort' => 3],
            ['id' => 2, 'name' => '聊天室2', 'sort' => 2],
            ['id' => 3, 'name' => '聊天室3', 'sort' => 1],
        ];

        foreach ($rooms as $room) {
            $exists = Db::name('miniapp_chat_room')->where('id', (int)$room['id'])->find();
            if ($exists) {
                Db::name('miniapp_chat_room')->where('id', (int)$room['id'])->update([
                    'name'        => $room['name'],
                    'sort'        => $room['sort'],
                    'status'      => 1,
                    'update_time' => $now,
                ]);
                continue;
            }

            Db::name('miniapp_chat_room')->insert([
                'id'          => (int)$room['id'],
                'name'        => $room['name'],
                'sort'        => $room['sort'],
                'status'      => 1,
                'create_time' => $now,
                'update_time' => $now,
            ]);
        }
    }

    public static function getRooms()
    {
        return Db::name('miniapp_chat_room')
            ->where('status', 1)
            ->order('sort desc,id asc')
            ->select();
    }

    public static function getRoom($roomId)
    {
        return Db::name('miniapp_chat_room')
            ->where('id', (int)$roomId)
            ->where('status', 1)
            ->find();
    }

    public static function normalizeContent($content)
    {
        $content = trim((string)$content);
        if ($content === '') {
            return '';
        }
        if (function_exists('mb_substr')) {
            return mb_substr($content, 0, self::MAX_CONTENT_LENGTH, 'UTF-8');
        }
        return substr($content, 0, self::MAX_CONTENT_LENGTH * 4);
    }

    public static function validateContent($content)
    {
        $content = self::normalizeContent($content);
        if ($content === '') {
            return [false, '', '消息内容不能为空'];
        }
        return [true, $content, ''];
    }

    public static function storeMessage($roomId, $senderType, $senderId, $senderName, $content, $clientIp = '')
    {
        list($valid, $content, $error) = self::validateContent($content);
        if (!$valid) {
            throw new \InvalidArgumentException($error);
        }

        $room = self::getRoom($roomId);
        if (!$room) {
            throw new \InvalidArgumentException('聊天室不存在');
        }

        $now = time();
        $messageId = Db::name('miniapp_chat_message')->insertGetId([
            'room_id'      => (int)$roomId,
            'sender_type'  => (string)$senderType,
            'sender_id'    => (int)$senderId,
            'sender_name'  => (string)$senderName,
            'message_type' => self::MESSAGE_TYPE_TEXT,
            'content'      => $content,
            'client_ip'    => (string)$clientIp,
            'status'       => 1,
            'create_time'  => $now,
            'update_time'  => $now,
        ]);

        Db::name('miniapp_chat_room')->where('id', (int)$roomId)->update([
            'last_message_id'   => (int)$messageId,
            'last_message_time' => $now,
            'update_time'       => $now,
        ]);

        $message = Db::name('miniapp_chat_message')->where('id', (int)$messageId)->find();
        return self::formatMessage($message);
    }

    public static function formatRoom($room)
    {
        return [
            'id'                => (int)$room['id'],
            'name'              => (string)$room['name'],
            'sort'              => (int)$room['sort'],
            'last_message_id'   => (int)($room['last_message_id'] ?? 0),
            'last_message_time' => (int)($room['last_message_time'] ?? 0),
            'status'            => (int)$room['status'],
        ];
    }

    public static function formatMessage($message)
    {
        if (!$message) {
            return null;
        }

        return [
            'id'           => (int)$message['id'],
            'room_id'      => (int)$message['room_id'],
            'sender_type'  => (string)$message['sender_type'],
            'sender_id'    => (int)$message['sender_id'],
            'sender_name'  => (string)$message['sender_name'],
            'message_type' => (string)$message['message_type'],
            'content'      => (string)$message['content'],
            'create_time'  => (int)$message['create_time'],
            'time_text'    => !empty($message['create_time']) ? date('Y-m-d H:i:s', (int)$message['create_time']) : '',
        ];
    }
}
