-- 2026-05-24 小程序多设备登录 token 会话表
-- 手动执行：创建后，新登录会写入本表；旧 fa_miniapp_user.token 仍保留为最近一次登录 token 兼容旧逻辑。

CREATE TABLE IF NOT EXISTS `fa_miniapp_user_token` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '会话ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `token` varchar(64) NOT NULL DEFAULT '' COMMENT '登录token',
  `expire_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '过期时间',
  `login_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '登录IP',
  `user_agent` varchar(255) NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态:0=失效,1=有效',
  `logout_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '退出时间',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_token` (`token`),
  KEY `idx_user_status` (`user_id`, `status`),
  KEY `idx_expire_time` (`expire_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='小程序用户登录token会话表';
