-- 2026-05-14 下发小程序用户设置编辑权限
-- 解决代理商账号能看到下级账号但无法编辑的问题。
-- 执行后建议代理商账号退出后台重新登录一次。

SET @miniapp_user_setting_pid := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/user_setting'
  LIMIT 1
);

SET @miniapp_user_setting_index_id := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/user_setting/index'
  LIMIT 1
);

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT 'file', CAST(@miniapp_user_setting_pid AS UNSIGNED), 'miniapp/user_setting/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 'normal'
WHERE @miniapp_user_setting_pid IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/user_setting/edit'
  );

SET @edit_rule_id := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/user_setting/edit'
  LIMIT 1
);

-- 给已有“小程序代理”权限组补上编辑权限。
UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @edit_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP()
WHERE @edit_rule_id IS NOT NULL
  AND `name` = '小程序代理'
  AND `rules` <> '*'
  AND FIND_IN_SET(@edit_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0;

-- 给已拥有“小程序用户设置”或其首页权限的其它普通权限组也补上编辑权限。
UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @edit_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP()
WHERE @edit_rule_id IS NOT NULL
  AND `rules` <> '*'
  AND FIND_IN_SET(@edit_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0
  AND (
    (@miniapp_user_setting_pid IS NOT NULL AND FIND_IN_SET(@miniapp_user_setting_pid COLLATE utf8mb4_general_ci, `rules`) > 0)
    OR (@miniapp_user_setting_index_id IS NOT NULL AND FIND_IN_SET(@miniapp_user_setting_index_id COLLATE utf8mb4_general_ci, `rules`) > 0)
  );
