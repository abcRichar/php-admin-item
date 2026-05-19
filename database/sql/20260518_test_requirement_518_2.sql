-- 2026-05-18 Requirement 518-2 test data
-- 使用前请先执行：20260518_requirement_518_2.sql
-- 测试用户：13800000002 / token=miniapp_token_10002

SET @test_tel := '13800000002';
SET @test_user_id := (SELECT `id` FROM `fa_miniapp_user` WHERE `tel` = @test_tel LIMIT 1);
SET @now := UNIX_TIMESTAMP();
SET @reset_time := @now - 3600;

UPDATE `fa_miniapp_user`
SET
  `task_update_status` = 1,
  `task_reset_time` = @reset_time,
  `status` = 1,
  `update_time` = @now
WHERE `id` = @test_user_id;

DELETE FROM `fa_miniapp_order`
WHERE `user_id` = @test_user_id
  AND `order_no` LIKE 'T5182%';

-- 构造上次手动归零后的 60 个已完成订单：应达到封顶，不再返回新商品。
INSERT INTO `fa_miniapp_order` (
  `user_id`, `uid`, `level_id`, `parent_uid`, `order_no`,
  `goods_id`, `goods_count`, `goods_name`, `shop_name`, `goods_price`, `goods_pic`, `goods_image`,
  `amount`, `num`, `user_balance`, `user_freeze_balance`,
  `addtime`, `endtime`, `is_pay`, `commission`, `parent_commission`,
  `c_status`, `add_id`, `today_dan`, `qkon`, `group_completedornot`,
  `source`, `language`, `remark`, `pay_time`, `complete_time`, `status`,
  `create_time`, `update_time`
)
SELECT
  @test_user_id, @test_user_id, 0, 0, CONCAT('T5182', LPAD(seq.n, 4, '0')),
  COALESCE((SELECT `id` FROM `fa_miniapp_goods` WHERE `status` = 1 ORDER BY `id` ASC LIMIT 1), 0),
  1, 'test goods', 'test goods', 1.00, '', '',
  1.00, 1.00, 1000.00, 0.00,
  @reset_time + seq.n, @reset_time + seq.n + 60, 1, 0.01, 0.00,
  1, 1, seq.n, 1, 1,
  'test_518_2', '1', '', @reset_time + seq.n, @reset_time + seq.n, 2,
  @reset_time + seq.n, @reset_time + seq.n
FROM (
  SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
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
  UNION ALL SELECT 56 UNION ALL SELECT 57 UNION ALL SELECT 58 UNION ALL SELECT 59 UNION ALL SELECT 60
) seq;

-- 当前完成数应为 60。
SELECT
  COUNT(*) AS `completed_count_after_reset`
FROM `fa_miniapp_order`
WHERE `user_id` = @test_user_id
  AND `status` = 2
  AND `complete_time` > (SELECT `task_reset_time` FROM `fa_miniapp_user` WHERE `id` = @test_user_id);

-- 模拟后台点击“归零”：执行后当前完成数应为 0，任务开关仍为开启。
UPDATE `fa_miniapp_user`
SET
  `task_reset_time` = UNIX_TIMESTAMP(),
  `update_time` = UNIX_TIMESTAMP()
WHERE `id` = @test_user_id;

SELECT
  `task_update_status`,
  `task_reset_time`,
  (
    SELECT COUNT(*)
    FROM `fa_miniapp_order`
    WHERE `user_id` = @test_user_id
      AND `status` = 2
      AND `complete_time` > `fa_miniapp_user`.`task_reset_time`
  ) AS `completed_count_after_manual_reset`
FROM `fa_miniapp_user`
WHERE `id` = @test_user_id;

-- 随机商品口径：只限制启用状态，不限制 language。
SELECT `id`, `title`, `language`
FROM `fa_miniapp_goods`
WHERE `status` = 1
ORDER BY RAND()
LIMIT 1;
