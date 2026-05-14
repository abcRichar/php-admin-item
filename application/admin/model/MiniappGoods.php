<?php

namespace app\admin\model;

use think\Model;

class MiniappGoods extends Model
{
    protected $name = 'miniapp_goods';

    protected $autoWriteTimestamp = 'int';
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';

    protected $append = [
        'create_time_text',
        'update_time_text',
        'status_text',
        'language_text',
    ];

    public function getStatusList()
    {
        return ['0' => __('Disabled'), '1' => __('Normal')];
    }

    public function getLanguageList()
    {
        return [
            '1' => __('Chinese'),
            '2' => __('English'),
            'zh_cn' => __('Chinese'),
            'en' => __('English'),
            'en_us' => __('English'),
        ];
    }

    public function setLanguageAttr($value)
    {
        $language = strtolower(trim((string)$value));
        $map = [
            'zh_cn' => '1',
            'zh-cn' => '1',
            'zh' => '1',
            'cn' => '1',
            'en' => '2',
            'en_us' => '2',
            'en-us' => '2',
        ];

        return $map[$language] ?? (string)$value;
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

    public function getStatusTextAttr($value, $data)
    {
        $status = isset($data['status']) ? (string)$data['status'] : '0';
        $list = $this->getStatusList();
        return $list[$status] ?? $status;
    }

    public function getLanguageTextAttr($value, $data)
    {
        $language = isset($data['language']) ? (string)$data['language'] : '';
        $list = $this->getLanguageList();
        return $list[$language] ?? $language;
    }
}
