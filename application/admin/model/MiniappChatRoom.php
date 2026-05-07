<?php

namespace app\admin\model;

use think\Model;

class MiniappChatRoom extends Model
{
    protected $name = 'miniapp_chat_room';
    protected $autoWriteTimestamp = 'int';
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';

    protected $append = [
        'status_text',
        'last_message_time_text',
    ];

    public function getStatusList()
    {
        return ['0' => __('Disabled'), '1' => __('Normal')];
    }

    public function getStatusTextAttr($value, $data)
    {
        $status = isset($data['status']) ? (string)$data['status'] : '0';
        $list = $this->getStatusList();
        return $list[$status] ?? $status;
    }

    public function getLastMessageTimeTextAttr($value, $data)
    {
        $value = $value ?: ($data['last_message_time'] ?? 0);
        return $value ? date('Y-m-d H:i:s', (int)$value) : '';
    }
}
