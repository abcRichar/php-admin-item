ALTER TABLE `fa_miniapp_goods`
  ADD COLUMN `default_commission_rate` decimal(8,2) NOT NULL DEFAULT 0.00 COMMENT '默认佣金比例(%)' AFTER `goods_count`;
