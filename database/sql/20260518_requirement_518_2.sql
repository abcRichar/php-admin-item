-- 2026-05-18 Requirement 518-2
-- 手动执行：任务开关改为手动控制，新增任务完成数手动归零时间点。

SET @miniapp_user_task_update_status_column_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_user'
    AND COLUMN_NAME = 'task_update_status'
);

SET @miniapp_user_task_update_status_sql := IF(
  @miniapp_user_task_update_status_column_exists = 0,
  'ALTER TABLE `fa_miniapp_user` ADD COLUMN `task_update_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT ''任务开关:0=禁止抢单,1=允许抢单'' AFTER `status`',
  'ALTER TABLE `fa_miniapp_user` MODIFY COLUMN `task_update_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT ''任务开关:0=禁止抢单,1=允许抢单'''
);
PREPARE stmt FROM @miniapp_user_task_update_status_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @miniapp_user_task_reset_time_column_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_user'
    AND COLUMN_NAME = 'task_reset_time'
);

SET @miniapp_user_task_reset_time_sql := IF(
  @miniapp_user_task_reset_time_column_exists = 0,
  'ALTER TABLE `fa_miniapp_user` ADD COLUMN `task_reset_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT ''任务完成数手动归零时间'' AFTER `task_update_status`',
  'SELECT 1'
);
PREPARE stmt FROM @miniapp_user_task_reset_time_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @miniapp_user_task_update_status_index_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_user'
    AND INDEX_NAME = 'idx_task_update_status'
);

SET @miniapp_user_task_update_status_index_sql := IF(
  @miniapp_user_task_update_status_index_exists = 0,
  'ALTER TABLE `fa_miniapp_user` ADD INDEX `idx_task_update_status` (`task_update_status`)',
  'SELECT 1'
);
PREPARE stmt FROM @miniapp_user_task_update_status_index_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @miniapp_user_task_reset_time_index_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_user'
    AND INDEX_NAME = 'idx_task_reset_time'
);

SET @miniapp_user_task_reset_time_index_sql := IF(
  @miniapp_user_task_reset_time_index_exists = 0,
  'ALTER TABLE `fa_miniapp_user` ADD INDEX `idx_task_reset_time` (`task_reset_time`)',
  'SELECT 1'
);
PREPARE stmt FROM @miniapp_user_task_reset_time_index_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
