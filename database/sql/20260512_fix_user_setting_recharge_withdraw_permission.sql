-- 2026-05-12 Fix backend permission for user_setting recharge/withdraw.
-- This script only changes FastAdmin backend auth rules/groups.
-- It does not change miniapp API routes or API controllers.

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
SELECT 'file', CAST(@miniapp_user_setting_pid AS UNSIGNED), 'miniapp/user_setting/recharge', 'Recharge', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'cz', 'chongzhi', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 'normal'
WHERE @miniapp_user_setting_pid IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/user_setting/recharge'
  );

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT 'file', CAST(@miniapp_user_setting_pid AS UNSIGNED), 'miniapp/user_setting/withdraw', 'Withdraw', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tx', 'tixian', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 'normal'
WHERE @miniapp_user_setting_pid IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/user_setting/withdraw'
  );

SET @recharge_rule_id := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/user_setting/recharge'
  LIMIT 1
);

SET @withdraw_rule_id := (
  SELECT CAST(`id` AS CHAR CHARACTER SET utf8mb4) COLLATE utf8mb4_general_ci
  FROM `fa_auth_rule`
  WHERE `name` = 'miniapp/user_setting/withdraw'
  LIMIT 1
);

UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @recharge_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP()
WHERE @recharge_rule_id IS NOT NULL
  AND `rules` <> '*'
  AND FIND_IN_SET(@recharge_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0
  AND (
    (@miniapp_user_setting_pid IS NOT NULL AND FIND_IN_SET(@miniapp_user_setting_pid COLLATE utf8mb4_general_ci, `rules`) > 0)
    OR (@miniapp_user_setting_index_id IS NOT NULL AND FIND_IN_SET(@miniapp_user_setting_index_id COLLATE utf8mb4_general_ci, `rules`) > 0)
  );

UPDATE `fa_auth_group`
SET `rules` = TRIM(BOTH ',' FROM CONCAT_WS(',', NULLIF(`rules`, ''), @withdraw_rule_id COLLATE utf8mb4_general_ci)),
    `updatetime` = UNIX_TIMESTAMP()
WHERE @withdraw_rule_id IS NOT NULL
  AND `rules` <> '*'
  AND FIND_IN_SET(@withdraw_rule_id COLLATE utf8mb4_general_ci, `rules`) = 0
  AND (
    (@miniapp_user_setting_pid IS NOT NULL AND FIND_IN_SET(@miniapp_user_setting_pid COLLATE utf8mb4_general_ci, `rules`) > 0)
    OR (@miniapp_user_setting_index_id IS NOT NULL AND FIND_IN_SET(@miniapp_user_setting_index_id COLLATE utf8mb4_general_ci, `rules`) > 0)
  );
