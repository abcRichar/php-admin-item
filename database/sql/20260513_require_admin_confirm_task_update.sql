-- 关闭更新任务开关：用户后续生成新任务前，必须后台重新确认开启
-- 默认测试用户：fa_miniapp_user.id = 1

UPDATE `fa_miniapp_user`
SET
  `task_update_status` = 0,
  `update_time` = UNIX_TIMESTAMP()
WHERE `id` = 1;

-- 如果你要按手机号执行，使用下面这段，替换手机号后执行：
-- UPDATE `fa_miniapp_user`
-- SET
--   `task_update_status` = 0,
--   `update_time` = UNIX_TIMESTAMP()
-- WHERE `tel` = '13812341234';
