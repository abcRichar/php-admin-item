-- 2026-05-19 派单模式增加差额配置
-- 请在数据库中手动执行本文件。

SET @column_exists := (
  SELECT COUNT(*)
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_dispatch_mode'
    AND COLUMN_NAME = 'difference_amount'
);
SET @ddl := IF(
  @column_exists = 0,
  'ALTER TABLE `fa_miniapp_dispatch_mode` ADD COLUMN `difference_amount` varchar(255) NOT NULL DEFAULT '''' COMMENT ''差额序列'' AFTER `dispatch_amount`',
  'SELECT 1'
);
PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @column_exists := (
  SELECT COUNT(*)
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_user'
    AND COLUMN_NAME = 'difference_amount'
);
SET @ddl := IF(
  @column_exists = 0,
  'ALTER TABLE `fa_miniapp_user` ADD COLUMN `difference_amount` varchar(255) NOT NULL DEFAULT '''' COMMENT ''派单差额序列'' AFTER `dispatch_amount`',
  'SELECT 1'
);
PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @column_exists := (
  SELECT COUNT(*)
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_order'
    AND COLUMN_NAME = 'difference_amount'
);
SET @ddl := IF(
  @column_exists = 0,
  'ALTER TABLE `fa_miniapp_order` ADD COLUMN `difference_amount` decimal(12,2) NOT NULL DEFAULT 0.00 COMMENT ''完成前需充值差额'' AFTER `user_freeze_balance`',
  'SELECT 1'
);
PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
