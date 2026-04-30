<?php

// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

return [
    //别名配置,别名只能是映射到控制器且访问时必须加上请求的方法
    '__alias__'   => [],
    //变量规则
    '__pattern__' => [],
    // 小程序模块化路由（miniapp/子控制器/方法）
    'miniapp/support/index'          => 'api/miniapp.support/index',
    'miniapp/support/setLanguage'    => 'api/miniapp.support/setLanguage',
    'miniapp/user/do_login'          => 'api/miniapp.user/do_login',
    'miniapp/user/do_register'       => 'api/miniapp.user/do_register',
    'miniapp/user/logout'            => 'api/miniapp.user/logout',
    'miniapp/index/homeNew'          => 'api/miniapp.index/homeNew',
    'miniapp/order/orderRecord'      => 'api/miniapp.order/orderRecord',
    'miniapp/order/order_info'       => 'api/miniapp.order/order_info',
    'miniapp/order/do_order'         => 'api/miniapp.order/do_order',
    'miniapp/rot_order/orderInfo'    => 'api/miniapp.rot_order/orderInfo',
    'miniapp/rot_order/submit_order' => 'api/miniapp.rot_order/submit_order',
    'miniapp/ctrl/teamAll'           => 'api/miniapp.ctrl/teamAll',
    'miniapp/ctrl/do_withdraw'       => 'api/miniapp.ctrl/do_withdraw',
    'miniapp/ctrl/rechargeNew'       => 'api/miniapp.ctrl/rechargeNew',
    'miniapp/my/indexNew'            => 'api/miniapp.my/indexNew',
    'miniapp/my/userInfo'            => 'api/miniapp.my/userInfo',
    'miniapp/my/uinfoSave'           => 'api/miniapp.my/uinfoSave',
    'miniapp/my/setCashPwd'          => 'api/miniapp.my/setCashPwd',
    'miniapp/my/caiwu'               => 'api/miniapp.my/caiwu',
    //        域名绑定到模块
    //        '__domain__'  => [
    //            'admin' => 'admin',
    //            'api'   => 'api',
    //        ],
];
