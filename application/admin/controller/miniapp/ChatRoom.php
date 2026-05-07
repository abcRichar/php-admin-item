<?php

namespace app\admin\controller\miniapp;

use app\common\controller\Backend;
use app\common\library\MiniappChat;
use fast\Random;
use think\Db;
use think\Session;

/**
 * 聊天室
 *
 * @icon fa fa-comments
 */
class ChatRoom extends Backend
{
    protected $model = null;
    protected $noNeedRight = ['messages', 'wsTicket'];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappChatRoom;
    }

    public function index()
    {
        MiniappChat::ensureRooms();
        $rooms = array_map(function ($room) {
            $row = MiniappChat::formatRoom($room);
            $row['ws_url'] = $this->buildRoomWsUrl((int)$row['id']);
            return $row;
        }, MiniappChat::getRooms());

        $this->assignconfig('rooms', $rooms);
        $this->assignconfig('heartbeat', 25);
        $this->view->assign('rooms', $rooms);
        return $this->view->fetch();
    }

    public function messages()
    {
        $roomId = (int)$this->request->param('room_id', 0);
        $beforeId = (int)$this->request->param('before_id', 0);
        $limit = (int)$this->request->param('limit', 50);
        $limit = max(1, min(100, $limit));

        if (!MiniappChat::getRoom($roomId)) {
            $this->error('聊天室不存在');
        }

        $query = Db::name('miniapp_chat_message')
            ->where('room_id', $roomId)
            ->where('status', 1);
        if ($beforeId > 0) {
            $query->where('id', '<', $beforeId);
        }

        $rows = $query->order('id desc')->limit($limit)->select();
        $rows = array_reverse($rows);
        $messages = array_map(function ($message) {
            return MiniappChat::formatMessage($message);
        }, $rows);

        $this->success('', null, [
            'room_id'  => $roomId,
            'messages' => $messages,
        ]);
    }

    public function wsTicket()
    {
        $admin = Session::get('admin');
        if (!$admin) {
            $this->error('请先登录');
        }

        $ticket = Random::uuid();
        cache('miniapp_chat_admin_ws_' . $ticket, [
            'id'       => (int)$admin['id'],
            'nickname' => (string)($admin['nickname'] ?: $admin['username']),
        ], 300);

        $this->success('', null, [
            'ticket' => $ticket,
        ]);
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
