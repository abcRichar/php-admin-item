-- 2026-05-10 上级返佣比例、创建下级账号权限
-- 请在数据库中手动执行本文件。

CREATE TABLE IF NOT EXISTS `fa_miniapp_system_config` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `recharge_address` varchar(255) NOT NULL DEFAULT '' COMMENT '充值地址',
  `fixed_commission_rate` decimal(8,2) NOT NULL DEFAULT 0.00 COMMENT '固定佣金比例(%)',
  `parent_rebate_rate` decimal(8,2) NOT NULL DEFAULT 15.00 COMMENT '上级返佣比例(%)',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='小程序系统管理配置';

SET @column_exists := (
  SELECT COUNT(*)
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_system_config'
    AND COLUMN_NAME = 'parent_rebate_rate'
);
SET @ddl := IF(
  @column_exists = 0,
  'ALTER TABLE `fa_miniapp_system_config` ADD COLUMN `parent_rebate_rate` decimal(8,2) NOT NULL DEFAULT 15.00 COMMENT ''上级返佣比例(%)'' AFTER `fixed_commission_rate`',
  'SELECT 1'
);
PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

INSERT INTO `fa_miniapp_system_config`
  (`id`, `recharge_address`, `fixed_commission_rate`, `parent_rebate_rate`, `status`, `create_time`, `update_time`)
SELECT 1, '', 0.00, 15.00, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
WHERE NOT EXISTS (SELECT 1 FROM `fa_miniapp_system_config` WHERE `id` = 1);

SET @index_exists := (
  SELECT COUNT(*)
  FROM information_schema.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_user'
    AND INDEX_NAME = 'idx_parent_id'
);
SET @ddl := IF(
  @index_exists = 0,
  'ALTER TABLE `fa_miniapp_user` ADD INDEX `idx_parent_id` (`parent_id`)',
  'SELECT 1'
);
PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @index_exists := (
  SELECT COUNT(*)
  FROM information_schema.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_finance_log'
    AND INDEX_NAME = 'idx_user_type_order_sid'
);
SET @ddl := IF(
  @index_exists = 0,
  'ALTER TABLE `fa_miniapp_finance_log` ADD INDEX `idx_user_type_order_sid` (`user_id`, `type`, `related_order_no`, `sid`)',
  'SELECT 1'
);
PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @miniapp_user_setting_pid := (SELECT `id` FROM `fa_auth_rule` WHERE `name` = 'miniapp/user_setting' LIMIT 1);

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT 'file', @miniapp_user_setting_pid, 'miniapp/user_setting/create_subordinate', 'Create subordinate', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'cjxjzh', 'chuangjianxiajizhanghao', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 'normal'
WHERE @miniapp_user_setting_pid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/user_setting/create_subordinate');
