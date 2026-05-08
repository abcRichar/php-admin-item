<?php

namespace app\admin\model;

use think\Model;

class MiniappSystemConfig extends Model
{
    protected $name = 'miniapp_system_config';

    protected $autoWriteTimestamp = 'int';
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';
}
