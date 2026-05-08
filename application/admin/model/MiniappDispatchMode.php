<?php

namespace app\admin\model;

use think\Model;

class MiniappDispatchMode extends Model
{
    protected $name = 'miniapp_dispatch_mode';

    protected $autoWriteTimestamp = 'int';
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';

    protected $append = [
        'status_text',
        'create_time_text',
        'update_time_text',
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

    public function getCreateTimeTextAttr($value, $data)
    {
        $value = $value ?: ($data['create_time'] ?? 0);
        return $value ? date('Y-m-d H:i:s', (int)$value) : '';
    }

    public function getUpdateTimeTextAttr($value, $data)
    {
        $value = $value ?: ($data['update_time'] ?? 0);
        return $value ? date('Y-m-d H:i:s', (int)$value) : '';
    }
}
