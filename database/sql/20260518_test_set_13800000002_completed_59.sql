-- 2026-05-18 Requirement 518-2 test data
-- Goal: set account 13800000002 to exactly 59 completed tasks under the new manual-reset rule.
-- Safe scope:
--   1. Only deletes/recreates test orders whose order_no starts with T5182_13800000002_.
--   2. Does not delete or modify this user's real orders.
--   3. Moves task_reset_time after the user's existing non-test completed orders,
--      so the current completed count becomes exactly the 59 test orders below.

SET time_zone = '+08:00';

SET @test_tel := '13800000002';
SET @test_prefix := 'T5182_13800000002_';
SET @uid := (
  SELECT `id`
  FROM `fa_miniapp_user`
  WHERE `tel` = @test_tel
  LIMIT 1
);

SET @now := UNIX_TIMESTAMP();
SET @goods_id := COALESCE((SELECT `id` FROM `fa_miniapp_goods` WHERE `status` = 1 ORDER BY `id` ASC LIMIT 1), 0);
SET @goods_name := COALESCE((SELECT `title` FROM `fa_miniapp_goods` WHERE `id` = @goods_id LIMIT 1), 'Test Goods');
SET @goods_price := COALESCE((SELECT `price` FROM `fa_miniapp_goods` WHERE `id` = @goods_id LIMIT 1), 99.00);
SET @goods_pic := COALESCE((SELECT `image` FROM `fa_miniapp_goods` WHERE `id` = @goods_id LIMIT 1), '');

DELETE FROM `fa_miniapp_order`
WHERE `user_id` = @uid
  AND `order_no` LIKE CONCAT(@test_prefix, '%');

SET @last_real_completed_time := COALESCE((
  SELECT MAX(`complete_time`)
  FROM `fa_miniapp_order`
  WHERE `user_id` = @uid
    AND `status` = 2
    AND `order_no` NOT LIKE CONCAT(@test_prefix, '%')
), 0);

SET @reset_time := GREATEST(@last_real_completed_time + 1, @now);

UPDATE `fa_miniapp_user`
SET
  `task_update_status` = 1,
  `task_reset_time` = @reset_time,
  `status` = 1,
  `update_time` = @now
WHERE `id` = @uid;

INSERT INTO `fa_miniapp_order` (
  `user_id`, `uid`, `level_id`, `parent_uid`, `order_no`,
  `goods_id`, `goods_count`, `goods_name`, `shop_name`, `goods_price`,
  `goods_pic`, `today_dan`, `qkon`, `group_id`, `group_rule_num`,
  `group_is_active`, `group_completedornot`, `duorw`, `zhuass`, `time_limit`,
  `goods_image`, `amount`, `num`, `user_balance`, `user_freeze_balance`,
  `addtime`, `term_time`, `endtime`, `is_pay`, `commission`,
  `parent_commission`, `c_status`, `add_id`, `status`, `source`,
  `language`, `remark`, `pay_time`, `complete_time`, `create_time`, `update_time`
)
SELECT
  u.`id`,
  u.`id`,
  COALESCE(u.`level`, 0),
  COALESCE(u.`parent_id`, 0),
  CONCAT(@test_prefix, LPAD(n.n, 2, '0')),
  @goods_id,
  1,
  @goods_name,
  @goods_name,
  @goods_price,
  @goods_pic,
  n.n,
  1,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  @goods_pic,
  @goods_price,
  @goods_price,
  COALESCE(u.`balance`, 0),
  COALESCE(u.`freeze_balance`, 0),
  @reset_time + n.n,
  NULL,
  @reset_time + n.n,
  1,
  ROUND(@goods_price * 0.006, 2),
  0.00,
  1,
  1,
  2,
  'test_completed_59_requirement_518_2',
  '1',
  'test set current completed task count to 59',
  @reset_time + n.n,
  @reset_time + n.n,
  @reset_time + n.n,
  @reset_time + n.n
FROM `fa_miniapp_user` u
CROSS JOIN (
  SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
  UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
  UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15
  UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20
  UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL SELECT 25
  UNION ALL SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL SELECT 30
  UNION ALL SELECT 31 UNION ALL SELECT 32 UNION ALL SELECT 33 UNION ALL SELECT 34 UNION ALL SELECT 35
  UNION ALL SELECT 36 UNION ALL SELECT 37 UNION ALL SELECT 38 UNION ALL SELECT 39 UNION ALL SELECT 40
  UNION ALL SELECT 41 UNION ALL SELECT 42 UNION ALL SELECT 43 UNION ALL SELECT 44 UNION ALL SELECT 45
  UNION ALL SELECT 46 UNION ALL SELECT 47 UNION ALL SELECT 48 UNION ALL SELECT 49 UNION ALL SELECT 50
  UNION ALL SELECT 51 UNION ALL SELECT 52 UNION ALL SELECT 53 UNION ALL SELECT 54 UNION ALL SELECT 55
  UNION ALL SELECT 56 UNION ALL SELECT 57 UNION ALL SELECT 58 UNION ALL SELECT 59
) n
WHERE u.`id` = @uid;

SELECT
  @uid AS `user_id`,
  @test_tel AS `tel`,
  (SELECT `task_update_status` FROM `fa_miniapp_user` WHERE `id` = @uid) AS `task_update_status`,
  (SELECT `task_reset_time` FROM `fa_miniapp_user` WHERE `id` = @uid) AS `task_reset_time`,
  COUNT(*) AS `completed_count_after_reset`
FROM `fa_miniapp_order`
WHERE `user_id` = @uid
  AND `status` = 2
  AND `complete_time` > (SELECT `task_reset_time` FROM `fa_miniapp_user` WHERE `id` = @uid);
