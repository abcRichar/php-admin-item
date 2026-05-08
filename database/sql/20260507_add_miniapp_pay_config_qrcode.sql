-- 2026-05-07 充值配置二维码
-- 请在数据库中手动执行本文件。

SET @column_exists := (
  SELECT COUNT(*)
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_pay_config'
    AND COLUMN_NAME = 'qrcode'
);
SET @ddl := IF(
  @column_exists = 0,
  'ALTER TABLE `fa_miniapp_pay_config` ADD COLUMN `qrcode` varchar(255) NOT NULL DEFAULT '''' COMMENT ''二维码图片'' AFTER `usercode`',
  'SELECT 1'
);
PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

INSERT INTO `fa_miniapp_pay_config`
  (`user_id`, `usercode`, `qrcode`, `type`, `status`, `sort`, `create_time`, `update_time`)
SELECT 0, '', '', 'USDT-TRC20', 1, 100, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
WHERE NOT EXISTS (
  SELECT 1 FROM `fa_miniapp_pay_config` WHERE `user_id` = 0 AND `type` = 'USDT-TRC20'
);

INSERT INTO `fa_miniapp_pay_config`
  (`user_id`, `usercode`, `qrcode`, `type`, `status`, `sort`, `create_time`, `update_time`)
SELECT 0, '', '', 'USDT-ERC20', 1, 99, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()
WHERE NOT EXISTS (
  SELECT 1 FROM `fa_miniapp_pay_config` WHERE `user_id` = 0 AND `type` = 'USDT-ERC20'
);
