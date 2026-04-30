FastAdmin项目目录
├── addons                  //插件存放目录
├── application             //应用目录
│   ├── admin               //后台管理应用模块
│   ├── api                 //API应用模块
│   ├── common              //通用应用模块
│   ├── extra               //扩展配置目录
│   ├── index               //前台应用模块
│   ├── build.php
│   ├── command.php         //命令行配置
│   ├── common.php          //通用辅助函数
│   ├── config.php          //基础配置
│   ├── database.php        //数据库配置
│   ├── route.php           //路由配置
│   ├── tags.php            //行为配置
├── extend
│   └── fast                //FastAdmin扩展辅助类目录
├── public                  //框架入口目录
│   ├── assets
│   │   ├── addons         //插件前端资源目录
│   │   ├── build           //打包JS、CSS的资源目录
│   │   ├── css             //CSS样式目录
│   │   ├── fonts           //字体目录
│   │   ├── img             //图片资源目录
│   │   ├── js
│   │   │   ├── backend     //后台功能模块JS文件存放目录
│   │   │   └── frontend    //前台功能模块JS文件存放目录
│   │   ├── libs            //Bower资源包位置（只读，通过 bower 更新）
│   │   └── less            //Less资源目录
│   └── uploads             //上传文件目录
│   ├── index.php           //应用入口主文件
│   ├── install.php         //FastAdmin安装引导（安装完成后会自动删除）
│   ├── admin.php           //后台入口文件(自动安装后会被修改为随机文件名）
│   ├── robots.txt
│   └── router.php
├── runtime                 //缓存目录
├── thinkphp                //ThinkPHP框架核心目录（只读，通过 composer 更新）
├── vendor                  //Compposer资源包位置（只读，通过 composer 更新）
├── .bowerrc                //Bower目录配置文件
├── .env.sample             //环境配置模板（可复制一份为 .env 生效）
├── LICENSE
├── README.md               //项目介绍
├── bower.json              //Bower前端包配置
├── build.php
├── composer.json           //Composer包配置
└── think                   //命令行控制台入口（使用 php think 命令进入）
