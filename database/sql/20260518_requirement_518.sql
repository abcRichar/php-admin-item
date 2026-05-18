-- 2026-05-18 Requirement 518
-- Manual execution required.

ALTER TABLE `fa_miniapp_withdraw`
  ADD COLUMN `withdraw_address` varchar(255) NOT NULL DEFAULT '' COMMENT '提现地址' AFTER `type`;

CREATE TABLE `fa_miniapp_admin_balance_audit` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT 0 COMMENT '小程序用户ID',
  `admin_id` int unsigned NOT NULL DEFAULT 0 COMMENT '发起管理员ID',
  `audit_admin_id` int unsigned NOT NULL DEFAULT 0 COMMENT '审核管理员ID,0表示超管',
  `type` tinyint unsigned NOT NULL DEFAULT 1 COMMENT '1充值 2提现',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '金额',
  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT '单号',
  `withdraw_type` varchar(50) NOT NULL DEFAULT '' COMMENT '提现类型',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '0待审 1通过 2拒绝',
  `audit_time` int unsigned NOT NULL DEFAULT 0 COMMENT '审核时间',
  `create_time` int unsigned NOT NULL DEFAULT 0,
  `update_time` int unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_audit_admin_id` (`audit_admin_id`),
  KEY `idx_status_type` (`status`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台充值提现审核';
