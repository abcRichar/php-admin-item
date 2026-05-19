-- 2026-05-19 小程序系统管理增加客服链接
-- 请在数据库中手动执行本文件。

SET @column_exists := (
  SELECT COUNT(*)
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_system_config'
    AND COLUMN_NAME = 'customer_service_link'
);

SET @ddl := IF(
  @column_exists = 0,
  'ALTER TABLE `fa_miniapp_system_config` ADD COLUMN `customer_service_link` varchar(500) NOT NULL DEFAULT '''' COMMENT ''客服链接'' AFTER `recharge_address`',
  'SELECT 1'
);

PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

INSERT INTO `fa_miniapp_system_config`
  (`id`, `recharge_address`, `customer_service_link`, `fixed_commission_rate`, `parent_rebate_rate`, `status`, `create_time`, `update_time`)
SELECT 1, '', '', 0.00, 15.00, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
WHERE NOT EXISTS (SELECT 1 FROM `fa_miniapp_system_config` WHERE `id` = 1);
