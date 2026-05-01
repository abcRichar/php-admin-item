<?php

namespace app\admin\validate;

use think\Validate;

class MiniappGoods extends Validate
{
    protected $rule = [
        'language' => 'require',
        'title' => 'require|max:100',
        'sub_title' => 'max:255',
        'image' => 'require|max:255',
        'price' => 'require|float|egt:0',
        'goods_count' => 'require|integer|egt:1',
        'default_commission_rate' => 'require|float|between:0,100',
        'profit' => 'require|float|egt:0',
        'status' => 'require|in:0,1',
        'sort' => 'integer',
    ];

    protected $scene = [
        'add' => ['language', 'title', 'sub_title', 'image', 'price', 'goods_count', 'default_commission_rate', 'profit', 'status', 'sort'],
        'edit' => ['language', 'title', 'sub_title', 'image', 'price', 'goods_count', 'default_commission_rate', 'profit', 'status', 'sort'],
    ];
}
