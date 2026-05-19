-- 2026-05-19 将现有小程序用户语言设置为英文
-- 请在数据库中手动执行本文件。
-- 说明：系统按 fa_miniapp_support_language_log 最新记录判断用户语言，所以给每个用户追加一条英文记录。

INSERT INTO `fa_miniapp_support_language_log`
  (`user_id`, `language`, `token`, `create_time`)
SELECT
  `id`,
  '2',
  COALESCE(`token`, ''),
  UNIX_TIMESTAMP()
FROM `fa_miniapp_user`;
