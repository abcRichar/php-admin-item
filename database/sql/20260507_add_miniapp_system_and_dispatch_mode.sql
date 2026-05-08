-- 2026-05-07 小程序系统管理、派单模式管理
-- 请在数据库中手动执行本文件。

CREATE TABLE IF NOT EXISTS `fa_miniapp_system_config` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `recharge_address` varchar(255) NOT NULL DEFAULT '' COMMENT '充值地址',
  `fixed_commission_rate` decimal(8,2) NOT NULL DEFAULT 0.00 COMMENT '固定佣金比例(%)',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='小程序系统管理配置';

INSERT INTO `fa_miniapp_system_config`
  (`id`, `recharge_address`, `fixed_commission_rate`, `status`, `create_time`, `update_time`)
SELECT 1,
       COALESCE((SELECT `usercode` FROM `fa_miniapp_pay_config` WHERE `user_id` = 0 AND `status` = 1 ORDER BY `sort` DESC, `id` DESC LIMIT 1), ''),
       ROUND(COALESCE((SELECT CAST(`value` AS DECIMAL(10,6)) FROM `fa_miniapp_config` WHERE `name` = 'level_bili' ORDER BY `id` ASC LIMIT 1), 0) * 100, 2),
       1,
       UNIX_TIMESTAMP(),
       UNIX_TIMESTAMP()
WHERE NOT EXISTS (SELECT 1 FROM `fa_miniapp_system_config` WHERE `id` = 1);

CREATE TABLE IF NOT EXISTS `fa_miniapp_dispatch_mode` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `template_name` varchar(100) NOT NULL DEFAULT '' COMMENT '模版名称',
  `dispatch_order` varchar(255) NOT NULL DEFAULT '' COMMENT '派单订单序列',
  `commission_rate` varchar(255) NOT NULL DEFAULT '' COMMENT '佣金比例序列',
  `fixed_commission` varchar(255) NOT NULL DEFAULT '' COMMENT '固定佣金序列',
  `dispatch_amount` varchar(255) NOT NULL DEFAULT '' COMMENT '派单金额序列',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_status_sort` (`status`, `sort`, `id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='小程序派单模式';

SET @column_exists := (
  SELECT COUNT(*)
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_user'
    AND COLUMN_NAME = 'dispatch_mode_id'
);
SET @ddl := IF(
  @column_exists = 0,
  'ALTER TABLE `fa_miniapp_user` ADD COLUMN `dispatch_mode_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT ''派单模式ID'' AFTER `show_td`, ADD INDEX `idx_dispatch_mode_id` (`dispatch_mode_id`)',
  'SELECT 1'
);
PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT 'file', (SELECT `id` FROM `fa_auth_rule` WHERE `name` = 'miniapp' LIMIT 1), 'miniapp/system_config', '小程序系统管理', 'fa fa-cog', '', '', '', 1, 'addtabs', '', 'xcxxtgl', 'xiaochengxuxitongguanli', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 98, 'normal'
WHERE NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/system_config');

SET @miniapp_system_config_pid := (SELECT `id` FROM `fa_auth_rule` WHERE `name` = 'miniapp/system_config' LIMIT 1);

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT 'file', @miniapp_system_config_pid, 'miniapp/system_config/index', 'Index', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sy', 'shouye', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 'normal'
WHERE @miniapp_system_config_pid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/system_config/index');

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT 'file', (SELECT `id` FROM `fa_auth_rule` WHERE `name` = 'miniapp' LIMIT 1), 'miniapp/dispatch_mode', '派单模式管理', 'fa fa-list', '', '', '', 1, 'addtabs', '', 'pdmsgl', 'paidanmoshiguanli', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 97, 'normal'
WHERE NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/dispatch_mode');

SET @miniapp_dispatch_mode_pid := (SELECT `id` FROM `fa_auth_rule` WHERE `name` = 'miniapp/dispatch_mode' LIMIT 1);

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT 'file', @miniapp_dispatch_mode_pid, CONCAT('miniapp/dispatch_mode/', `action`), `title`, 'fa fa-circle-o', '', '', '', 0, NULL, '', `py`, `pinyin`, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 'normal'
FROM (
  SELECT 'index' AS `action`, 'Index' AS `title`, 'sy' AS `py`, 'shouye' AS `pinyin`
  UNION ALL SELECT 'add', 'Add', 'tj', 'tianjia'
  UNION ALL SELECT 'edit', 'Edit', 'bj', 'bianji'
  UNION ALL SELECT 'del', 'Delete', 'sc', 'shanchu'
  UNION ALL SELECT 'multi', 'Multi', 'plgx', 'pilianggengxin'
  UNION ALL SELECT 'selectpage', 'Selectpage', 'S', 'Selectpage'
) AS rules
WHERE @miniapp_dispatch_mode_pid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = CONCAT('miniapp/dispatch_mode/', rules.`action`));
