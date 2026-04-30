<?php

namespace app\admin\model;

use think\Model;

class MiniappFinanceLog extends Model
{
    protected $name = 'miniapp_finance_log';

    protected $append = [
        'create_time_text',
        'addtime_text',
        'type_text',
        'status_text',
    ];

    public function getTypeList()
    {
        return [
            '1' => __('Order income'),
            '3' => __('Order commission'),
            '4' => __('Team commission'),
            '7' => __('Withdraw apply'),
            '8' => __('Admin recharge'),
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

    public function getAddtimeTextAttr($value, $data)
    {
        $value = $value ?: ($data['addtime'] ?? 0);
        return $value ? date('Y-m-d H:i:s', (int)$value) : '';
    }

    public function getTypeTextAttr($value, $data)
    {
        $type = isset($data['type']) ? (string)$data['type'] : '';
        $list = $this->getTypeList();
        return $list[$type] ?? $type;
    }

    public function getStatusTextAttr($value, $data)
    {
        $status = isset($data['status']) ? (string)$data['status'] : '0';
        $list = $this->getStatusList();
        return $list[$status] ?? $status;
    }
}
