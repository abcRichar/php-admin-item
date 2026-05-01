ALTER TABLE `fa_admin`
  ADD COLUMN `admin_type` varchar(20) NOT NULL DEFAULT 'admin' COMMENT '管理员类型：admin=后台管理员，agent=小程序代理' AFTER `status`,
  ADD COLUMN `miniapp_user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关联小程序用户ID' AFTER `admin_type`,
  ADD INDEX `idx_miniapp_agent_user` (`miniapp_user_id`, `admin_type`);

-- 小程序代理权限组由代码在代理首次登录时自动创建/刷新，商品管理不会加入代理权限。
