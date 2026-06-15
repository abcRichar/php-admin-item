-- 2026-06-09 派单模式创建人归属
-- 请手动执行本文件；历史数据 creator_admin_id=0，按超管模式处理。

SET @dispatch_mode_creator_column_exists := (
  SELECT COUNT(*)
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_dispatch_mode'
    AND COLUMN_NAME = 'creator_admin_id'
);

SET @dispatch_mode_creator_sql := IF(
  @dispatch_mode_creator_column_exists = 0,
  'ALTER TABLE `fa_miniapp_dispatch_mode` ADD COLUMN `creator_admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT ''创建管理员ID,0=超管模式'' AFTER `id`',
  'SELECT 1'
);
PREPARE stmt FROM @dispatch_mode_creator_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @dispatch_mode_creator_index_exists := (
  SELECT COUNT(*)
  FROM information_schema.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fa_miniapp_dispatch_mode'
    AND INDEX_NAME = 'idx_creator_admin_id'
);

SET @dispatch_mode_creator_index_sql := IF(
  @dispatch_mode_creator_index_exists = 0,
  'ALTER TABLE `fa_miniapp_dispatch_mode` ADD INDEX `idx_creator_admin_id` (`creator_admin_id`)',
  'SELECT 1'
);
PREPARE stmt FROM @dispatch_mode_creator_index_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @miniapp_user_setting_pid := (
  SELECT `id`
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/user_setting'
  LIMIT 1
);

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT 'file', @miniapp_user_setting_pid, 'miniapp/user_setting/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 'normal'
WHERE @miniapp_user_setting_pid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/user_setting/del');

SET @miniapp_user_setting_del_id := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/user_setting/del'
  LIMIT 1
);

-- 用户设置删除权限下放给“小程序代理”权限组；后端仍按代理商下级用户范围校验。
UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @miniapp_user_setting_del_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP(),
    `status` = 'normal'
WHERE @miniapp_user_setting_del_id IS NOT NULL
  AND `name` = '小程序代理'
  AND `rules` <> '*'
  AND FIND_IN_SET(@miniapp_user_setting_del_id COLLATE utf8mb4_general_ci, `rules`) = 0;

SET @miniapp_dispatch_mode_pid := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/dispatch_mode'
  LIMIT 1
);

SET @miniapp_dispatch_mode_index_id := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/dispatch_mode/index'
  LIMIT 1
);

SET @dispatch_mode_add_rule_id := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/dispatch_mode/add'
  LIMIT 1
);

SET @dispatch_mode_edit_rule_id := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/dispatch_mode/edit'
  LIMIT 1
);

SET @dispatch_mode_del_rule_id := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/dispatch_mode/del'
  LIMIT 1
);

SET @dispatch_mode_selectpage_rule_id := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/dispatch_mode/selectpage'
  LIMIT 1
);

-- 派单模式管理页面下放给“小程序代理”权限组。
UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @miniapp_dispatch_mode_pid COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP(),
    `status` = 'normal'
WHERE @miniapp_dispatch_mode_pid IS NOT NULL
  AND `name` = '小程序代理'
  AND `rules` <> '*'
  AND FIND_IN_SET(@miniapp_dispatch_mode_pid COLLATE utf8mb4_general_ci, `rules`) = 0;

UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @miniapp_dispatch_mode_index_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP(),
    `status` = 'normal'
WHERE @miniapp_dispatch_mode_index_id IS NOT NULL
  AND `name` = '小程序代理'
  AND `rules` <> '*'
  AND FIND_IN_SET(@miniapp_dispatch_mode_index_id COLLATE utf8mb4_general_ci, `rules`) = 0;

UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @dispatch_mode_add_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP(),
    `status` = 'normal'
WHERE @dispatch_mode_add_rule_id IS NOT NULL
  AND `name` = '小程序代理'
  AND `rules` <> '*'
  AND FIND_IN_SET(@dispatch_mode_add_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0;

UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @dispatch_mode_edit_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP(),
    `status` = 'normal'
WHERE @dispatch_mode_edit_rule_id IS NOT NULL
  AND `name` = '小程序代理'
  AND `rules` <> '*'
  AND FIND_IN_SET(@dispatch_mode_edit_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0;

UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @dispatch_mode_del_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP(),
    `status` = 'normal'
WHERE @dispatch_mode_del_rule_id IS NOT NULL
  AND `name` = '小程序代理'
  AND `rules` <> '*'
  AND FIND_IN_SET(@dispatch_mode_del_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0;

UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @dispatch_mode_selectpage_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP(),
    `status` = 'normal'
WHERE @dispatch_mode_selectpage_rule_id IS NOT NULL
  AND `name` = '小程序代理'
  AND `rules` <> '*'
  AND FIND_IN_SET(@dispatch_mode_selectpage_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0;

-- 权限下放：已有“派单模式管理”或其首页权限的普通权限组，补齐新增/编辑/删除/selectpage 权限。
UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @dispatch_mode_add_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP()
WHERE @dispatch_mode_add_rule_id IS NOT NULL
  AND `rules` <> '*'
  AND FIND_IN_SET(@dispatch_mode_add_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0
  AND (
    (@miniapp_dispatch_mode_pid IS NOT NULL AND FIND_IN_SET(@miniapp_dispatch_mode_pid COLLATE utf8mb4_general_ci, `rules`) > 0)
    OR (@miniapp_dispatch_mode_index_id IS NOT NULL AND FIND_IN_SET(@miniapp_dispatch_mode_index_id COLLATE utf8mb4_general_ci, `rules`) > 0)
  );

UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @dispatch_mode_edit_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP()
WHERE @dispatch_mode_edit_rule_id IS NOT NULL
  AND `rules` <> '*'
  AND FIND_IN_SET(@dispatch_mode_edit_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0
  AND (
    (@miniapp_dispatch_mode_pid IS NOT NULL AND FIND_IN_SET(@miniapp_dispatch_mode_pid COLLATE utf8mb4_general_ci, `rules`) > 0)
    OR (@miniapp_dispatch_mode_index_id IS NOT NULL AND FIND_IN_SET(@miniapp_dispatch_mode_index_id COLLATE utf8mb4_general_ci, `rules`) > 0)
  );

UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @dispatch_mode_del_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP()
WHERE @dispatch_mode_del_rule_id IS NOT NULL
  AND `rules` <> '*'
  AND FIND_IN_SET(@dispatch_mode_del_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0
  AND (
    (@miniapp_dispatch_mode_pid IS NOT NULL AND FIND_IN_SET(@miniapp_dispatch_mode_pid COLLATE utf8mb4_general_ci, `rules`) > 0)
    OR (@miniapp_dispatch_mode_index_id IS NOT NULL AND FIND_IN_SET(@miniapp_dispatch_mode_index_id COLLATE utf8mb4_general_ci, `rules`) > 0)
  );

UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @dispatch_mode_selectpage_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP()
WHERE @dispatch_mode_selectpage_rule_id IS NOT NULL
  AND `rules` <> '*'
  AND FIND_IN_SET(@dispatch_mode_selectpage_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0
  AND (
    (@miniapp_dispatch_mode_pid IS NOT NULL AND FIND_IN_SET(@miniapp_dispatch_mode_pid COLLATE utf8mb4_general_ci, `rules`) > 0)
    OR (@miniapp_dispatch_mode_index_id IS NOT NULL AND FIND_IN_SET(@miniapp_dispatch_mode_index_id COLLATE utf8mb4_general_ci, `rules`) > 0)
  );
