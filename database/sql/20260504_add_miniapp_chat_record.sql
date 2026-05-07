-- 聊天记录后台菜单
-- 执行前请确认数据库表前缀为 fa_

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT
  'file', 85, 'miniapp/chat_record', '聊天记录', 'fa fa-history', '', '', '', 1, 'addtabs', '', 'ltjl', 'liaotianjilu', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 89, 'normal'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/chat_record');

SET @miniapp_chat_record_pid := (SELECT `id` FROM `fa_auth_rule` WHERE `name` = 'miniapp/chat_record' LIMIT 1);

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT
  'file', @miniapp_chat_record_pid, 'miniapp/chat_record/index', 'Index', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sy', 'shouye', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 'normal'
FROM DUAL
WHERE @miniapp_chat_record_pid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/chat_record/index');
