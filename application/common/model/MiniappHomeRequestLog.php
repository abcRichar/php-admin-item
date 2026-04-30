<?php

namespace app\common\model;

use think\Model;

class MiniappHomeRequestLog extends Model
{
    protected $name = 'miniapp_home_request_log';
    protected $autoWriteTimestamp = 'int';
    protected $createTime = 'create_time';
    protected $updateTime = false;
}
