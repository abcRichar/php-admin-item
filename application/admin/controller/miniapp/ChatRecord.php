<?php

namespace app\admin\controller\miniapp;

use app\common\controller\Backend;
use app\common\library\MiniappChat;

/**
 * 聊天记录
 *
 * @icon fa fa-history
 */
class ChatRecord extends Backend
{
    protected $model = null;
    protected $searchFields = 'record.id,record.room_id,room.name,record.sender_type,record.sender_id,record.sender_name,record.message_type,record.content,record.client_ip,user.tel,user.username,user.nickname';

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\MiniappChatMessage;

        MiniappChat::ensureRooms();
        $rooms = MiniappChat::getRooms();
        $roomList = [];
        foreach ($rooms as $room) {
            $roomList[(string)$room['id']] = (string)$room['name'];
        }

        $this->assignconfig('roomList', $roomList);
        $this->assignconfig('senderTypeList', $this->model->getSenderTypeList());
        $this->assignconfig('messageTypeList', $this->model->getMessageTypeList());
        $this->assignconfig('statusList', $this->model->getStatusList());
    }

    public function index()
    {
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }

            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $query = $this->model
                ->alias('record')
                ->join('fa_miniapp_chat_room room', 'room.id = record.room_id', 'LEFT')
                ->join('fa_miniapp_user user', "user.id = record.sender_id AND record.sender_type = 'user'", 'LEFT')
                ->field('record.*,room.name as room_name,user.tel,user.username,user.nickname')
                ->where($where);
            $list = $query->order($sort, $order)->paginate($limit);

            $rows = [];
            foreach ($list->items() as $row) {
                $row = is_array($row) ? $row : $row->toArray();
                $row['room_name'] = (string)($row['room_name'] ?? ('#' . ($row['room_id'] ?? 0)));
                $row['sender_display_name'] = (string)((string)($row['sender_type'] ?? '') === 'user'
                    ? ($row['username'] ?: $row['nickname'] ?: $row['tel'] ?: ('UID:' . ($row['sender_id'] ?? 0)))
                    : ($row['sender_name'] ?: ('Admin:' . ($row['sender_id'] ?? 0)))
                );
                $row['sender_type_text'] = $this->model->getSenderTypeList()[$row['sender_type'] ?? ''] ?? ($row['sender_type'] ?? '');
                $row['message_type_text'] = $this->model->getMessageTypeList()[$row['message_type'] ?? ''] ?? ($row['message_type'] ?? '');
                $row['status_text'] = $this->model->getStatusList()[(string)($row['status'] ?? '0')] ?? (string)($row['status'] ?? '0');
                $content = (string)($row['content'] ?? '');
                $row['content_preview'] = function_exists('mb_substr') ? mb_substr($content, 0, 80, 'UTF-8') : substr($content, 0, 320);
                $rows[] = $row;
            }

            return json([
                'total' => $list->total(),
                'rows'  => $rows,
            ]);
        }

        return $this->view->fetch();
    }
}
