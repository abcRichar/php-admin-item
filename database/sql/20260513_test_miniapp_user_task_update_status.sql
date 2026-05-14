-- 测试用户开关数据
-- 使用前请先执行：20260513_add_miniapp_user_task_update_status.sql
-- 默认使用测试账号：13812341234，对应 fa_miniapp_user.id = 1

-- 1. 开启登录 + 开启一次更新任务
-- 执行后：该用户可以登录小程序；进入抢单页/提交抢单生成新任务后，task_update_status 会自动变回 0
UPDATE `fa_miniapp_user`
SET
  `status` = 1,
  `task_update_status` = 1,
  `update_time` = UNIX_TIMESTAMP()
WHERE `id` = 1;

-- 2. 清理该用户未完成订单，方便测试“生成新任务”
-- 如果你想保留当前未完成订单，请不要执行这一段。
UPDATE `fa_miniapp_order`
SET
  `status` = 2,
  `complete_time` = UNIX_TIMESTAMP(),
  `update_time` = UNIX_TIMESTAMP(),
  `remark` = CONCAT(IFNULL(`remark`, ''), ' test close unfinished order')
WHERE `user_id` = 1
  AND `status` IN (0, 1);

-- 3. 查看当前开关状态
SELECT
  `id`,
  `tel`,
  `status`,
  `task_update_status`,
  `balance`,
  `update_time`
FROM `fa_miniapp_user`
WHERE `id` = 1;

-- 4. 可选：测试禁止登录
-- 执行后该用户不能登录，并且已有 token 也不能继续访问接口。
-- UPDATE `fa_miniapp_user`
-- SET
--   `status` = 0,
--   `update_time` = UNIX_TIMESTAMP()
-- WHERE `id` = 1;

-- 5. 可选：测试禁止更新任务
-- 执行后该用户没有未完成订单时，不能生成新任务。
-- UPDATE `fa_miniapp_user`
-- SET
--   `status` = 1,
--   `task_update_status` = 0,
--   `update_time` = UNIX_TIMESTAMP()
-- WHERE `id` = 1;
