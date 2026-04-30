
小程序接口目录结构：

application/api/controller/miniapp/
├── MiniappBase.php   -- 基类（常量、初始化、鉴权、语言、日志、响应）
├── Support.php       -- index、setLanguage
├── User.php          -- do_login、do_register、logout
├── Index.php         -- homeNew
├── Order.php         -- orderRecord、order_info、do_order
├── RotOrder.php      -- orderInfo、submit_order
├── Ctrl.php          -- teamAll、do_withdraw、rechargeNew
└── My.php            -- indexNew、userInfo、uinfoSave、caiwu、setCashPwd

