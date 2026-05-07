-- 聊天室模块：3 个固定 WebSocket 房间 + 聊天记录
-- 执行前请确认数据库表前缀为 fa_

CREATE TABLE IF NOT EXISTS `fa_miniapp_chat_room` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '聊天室ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '聊天室名称',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `last_message_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '最后消息ID',
  `last_message_time` int(11) NOT NULL DEFAULT 0 COMMENT '最后消息时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态:0=禁用,1=正常',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_status_sort` (`status`,`sort`,`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='小程序聊天室';

CREATE TABLE IF NOT EXISTS `fa_miniapp_chat_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `room_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '聊天室ID',
  `sender_type` varchar(20) NOT NULL DEFAULT '' COMMENT '发送人类型:user=小程序用户,admin=后台人员',
  `sender_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '发送人ID',
  `sender_name` varchar(100) NOT NULL DEFAULT '' COMMENT '发送人名称',
  `message_type` varchar(20) NOT NULL DEFAULT 'text' COMMENT '消息类型:text=文字',
  `content` text NOT NULL COMMENT '消息内容',
  `client_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '客户端IP',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态:0=隐藏,1=正常',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_room_id_id` (`room_id`,`id`) USING BTREE,
  KEY `idx_room_time` (`room_id`,`create_time`) USING BTREE,
  KEY `idx_sender` (`sender_type`,`sender_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='小程序聊天室消息';

INSERT INTO `fa_miniapp_chat_room`
  (`id`, `name`, `sort`, `last_message_id`, `last_message_time`, `status`, `create_time`, `update_time`)
VALUES
  (1, '聊天室1', 3, 0, 0, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
  (2, '聊天室2', 2, 0, 0, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()),
  (3, '聊天室3', 1, 0, 0, 1, UNIX_TIMESTAMP(), UNIX_TIMESTAMP())
ON DUPLICATE KEY UPDATE
  `name` = VALUES(`name`),
  `sort` = VALUES(`sort`),
  `status` = 1,
  `update_time` = UNIX_TIMESTAMP();

-- 后台菜单权限：小程序 / 聊天室
INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT
  'file', 85, 'miniapp/chat_room', '聊天室', 'fa fa-comments', '', '', '', 1, 'addtabs', '', 'lts', 'liaotianshi', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 90, 'normal'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/chat_room');

SET @miniapp_chat_room_pid := (SELECT `id` FROM `fa_auth_rule` WHERE `name` = 'miniapp/chat_room' LIMIT 1);

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT
  'file', @miniapp_chat_room_pid, 'miniapp/chat_room/index', 'Index', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sy', 'shouye', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 'normal'
FROM DUAL
WHERE @miniapp_chat_room_pid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/chat_room/index');

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT
  'file', @miniapp_chat_room_pid, 'miniapp/chat_room/messages', 'Messages', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'M', 'Messages', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 'normal'
FROM DUAL
WHERE @miniapp_chat_room_pid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/chat_room/messages');

INSERT INTO `fa_auth_rule`
  (`type`, `pid`, `name`, `title`, `icon`, `url`, `condition`, `remark`, `ismenu`, `menutype`, `extend`, `py`, `pinyin`, `createtime`, `updatetime`, `weigh`, `status`)
SELECT
  'file', @miniapp_chat_room_pid, 'miniapp/chat_room/wsticket', 'WsTicket', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'W', 'WsTicket', UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0, 'normal'
FROM DUAL
WHERE @miniapp_chat_room_pid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `fa_auth_rule` WHERE `name` = 'miniapp/chat_room/wsticket');
