-- 2026-05-11 后台管理员代理上下级

SET @admin_parent_column_exists := (
  SELECT COUNT(1)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_admin'
    AND COLUMN_NAME = 'parent_admin_id'
);

SET @admin_miniapp_user_column_exists := (
  SELECT COUNT(1)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_admin'
    AND COLUMN_NAME = 'miniapp_user_id'
);

SET @sql := IF(
  @admin_parent_column_exists = 0,
  CONCAT(
    'ALTER TABLE `fa_admin` ADD COLUMN `parent_admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT ''上级管理员ID''',
    IF(@admin_miniapp_user_column_exists > 0, ' AFTER `miniapp_user_id`', ' AFTER `status`')
  ),
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @admin_parent_index_exists := (
  SELECT COUNT(1)
  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_admin'
    AND INDEX_NAME = 'idx_parent_admin_id'
);

SET @sql := IF(
  @admin_parent_index_exists = 0,
  'ALTER TABLE `fa_admin` ADD INDEX `idx_parent_admin_id` (`parent_admin_id`)',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @admin_invite_column_exists := (
  SELECT COUNT(1)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_admin'
    AND COLUMN_NAME = 'invite_code'
);

SET @sql := IF(
  @admin_invite_column_exists = 0,
  'ALTER TABLE `fa_admin` ADD COLUMN `invite_code` varchar(32) NOT NULL DEFAULT '''' COMMENT ''管理员邀请码'' AFTER `parent_admin_id`',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @admin_invite_index_exists := (
  SELECT COUNT(1)
  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_admin'
    AND INDEX_NAME = 'idx_admin_invite_code'
);

SET @sql := IF(
  @admin_invite_index_exists = 0,
  'ALTER TABLE `fa_admin` ADD INDEX `idx_admin_invite_code` (`invite_code`)',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

CREATE TABLE IF NOT EXISTS `fa_admin_miniapp_user` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '小程序用户ID',
  `invite_code` varchar(32) NOT NULL DEFAULT '' COMMENT '注册使用的邀请码',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`),
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_invite_code` (`invite_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台管理员邀请小程序用户关系';
