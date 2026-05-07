<?php

namespace app\admin\model;

use think\Model;

class MiniappChatMessage extends Model
{
    protected $name = 'miniapp_chat_message';
    protected $autoWriteTimestamp = 'int';
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';

    protected $append = [
        'sender_type_text',
        'message_type_text',
        'status_text',
        'create_time_text',
    ];

    public function getSenderTypeList()
    {
        return ['user' => __('Miniapp user'), 'admin' => __('Backend user')];
    }

    public function getMessageTypeList()
    {
        return ['text' => __('Text')];
    }

    public function getStatusList()
    {
        return ['0' => __('Hidden'), '1' => __('Visible')];
    }

    public function getSenderTypeTextAttr($value, $data)
    {
        $type = isset($data['sender_type']) ? (string)$data['sender_type'] : '';
        $list = $this->getSenderTypeList();
        return $list[$type] ?? $type;
    }

    public function getMessageTypeTextAttr($value, $data)
    {
        $type = isset($data['message_type']) ? (string)$data['message_type'] : '';
        $list = $this->getMessageTypeList();
        return $list[$type] ?? $type;
    }

    public function getStatusTextAttr($value, $data)
    {
        $status = isset($data['status']) ? (string)$data['status'] : '0';
        $list = $this->getStatusList();
        return $list[$status] ?? $status;
    }

    public function getCreateTimeTextAttr($value, $data)
    {
        $value = $value ?: ($data['create_time'] ?? 0);
        return $value ? date('Y-m-d H:i:s', (int)$value) : '';
    }
}
