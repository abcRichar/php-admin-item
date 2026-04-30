<?php

namespace app\common\model;

use think\Model;

class MiniappHome extends Model
{
    protected $name = 'miniapp_home';
    protected $autoWriteTimestamp = 'int';
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';

    public static function getActiveHome($language = 1)
    {
        $language = $language ?: 1;

        $home = self::where('status', 1)
            ->where('language', $language)
            ->order('is_default desc,id desc')
            ->find();

        if (!$home && (int)$language !== 1) {
            $home = self::where('status', 1)
                ->where('language', 1)
                ->order('is_default desc,id desc')
                ->find();
        }

        return $home;
    }

    public function getBannerListAttr($value)
    {
        return $this->decodeJsonField($value);
    }

    public function getNoticeListAttr($value)
    {
        return $this->decodeJsonField($value);
    }

    public function getNavListAttr($value)
    {
        return $this->decodeJsonField($value);
    }

    public function getRecommendListAttr($value)
    {
        return $this->decodeJsonField($value);
    }

    public function getPopupListAttr($value)
    {
        return $this->decodeJsonField($value);
    }

    public function getExtraAttr($value)
    {
        return $this->decodeJsonField($value);
    }

    public function setBannerListAttr($value)
    {
        return $this->encodeJsonField($value);
    }

    public function setNoticeListAttr($value)
    {
        return $this->encodeJsonField($value);
    }

    public function setNavListAttr($value)
    {
        return $this->encodeJsonField($value);
    }

    public function setRecommendListAttr($value)
    {
        return $this->encodeJsonField($value);
    }

    public function setPopupListAttr($value)
    {
        return $this->encodeJsonField($value);
    }

    public function setExtraAttr($value)
    {
        return $this->encodeJsonField($value);
    }

    protected function decodeJsonField($value)
    {
        if ($value === null || $value === '') {
            return [];
        }
        if (is_array($value)) {
            return $value;
        }
        if (!is_string($value)) {
            return [];
        }

        $result = json_decode($value, true);
        return is_array($result) ? $result : [];
    }

    protected function encodeJsonField($value)
    {
        if ($value === null || $value === '') {
            return json_encode([], JSON_UNESCAPED_UNICODE);
        }

        return is_string($value) ? $value : json_encode($value, JSON_UNESCAPED_UNICODE);
    }
}
