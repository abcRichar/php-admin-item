<?php

namespace app\admin\model;

use think\Model;

class MiniappOrderActionLog extends Model
{
    protected $name = 'miniapp_order_action_log';

    protected $append = [
        'create_time_text',
        'action_text',
        'status_text',
    ];

    public function getActionList()
    {
        return [
            'submit_order' => __('Submit order'),
            'do_order'     => __('Do order'),
            'order_info'   => __('Order info'),
        ];
    }

    public function getStatusList()
    {
        return ['0' => __('Disabled'), '1' => __('Normal')];
    }

    public function getCreateTimeTextAttr($value, $data)
    {
        $value = $value ?: ($data['create_time'] ?? 0);
        return $value ? date('Y-m-d H:i:s', (int)$value) : '';
    }

    public function getActionTextAttr($value, $data)
    {
        $action = isset($data['action']) ? (string)$data['action'] : '';
        $list = $this->getActionList();
        return $list[$action] ?? $action;
    }

    public function getStatusTextAttr($value, $data)
    {
        $status = isset($data['status']) ? (string)$data['status'] : '0';
        $list = $this->getStatusList();
        return $list[$status] ?? $status;
    }
}
