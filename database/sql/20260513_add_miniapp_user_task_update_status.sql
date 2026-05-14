SET @miniapp_user_task_update_status_column_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_user'
    AND COLUMN_NAME = 'task_update_status'
);

SET @miniapp_user_task_update_status_sql := IF(
  @miniapp_user_task_update_status_column_exists = 0,
  'ALTER TABLE `fa_miniapp_user` ADD COLUMN `task_update_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT ''更新任务开关:0=禁止,1=允许'' AFTER `status`',
  'SELECT 1'
);
PREPARE stmt FROM @miniapp_user_task_update_status_sql;
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
