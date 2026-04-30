/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80012 (8.0.12)
 Source Host           : localhost:3306
 Source Schema         : www_fa_com

 Target Server Type    : MySQL
 Target Server Version : 80012 (8.0.12)
 File Encoding         : 65001

 Date: 29/04/2026 18:51:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fa_admin
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin`;
CREATE TABLE `fa_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `logintime` bigint(16) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录IP',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_admin
-- ----------------------------
INSERT INTO `fa_admin` VALUES (1, 'admin', 'Admin', 'c13f62012fd6a8fdf06b3452a94430e5', 'rpR6Bv', '/assets/img/avatar.png', 'admin@example.com', '', 0, 1777458002, '127.0.0.1', 1491635035, 1777458002, '155d92d0-c90a-41b9-ba0f-28341f9c151b', 'normal');

-- ----------------------------
-- Table structure for fa_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin_log`;
CREATE TABLE `fa_admin_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_admin_log
-- ----------------------------
INSERT INTO `fa_admin_log` VALUES (1, 0, 'Unknown', '/oqMCrJQItl.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"TNWR\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1776845599);
INSERT INTO `fa_admin_log` VALUES (2, 0, 'Unknown', '/oqMCrJQItl.php/index/login', '', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"TNWR\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1776845605);
INSERT INTO `fa_admin_log` VALUES (3, 0, 'Unknown', '/oqMCrJQItl.php/index/login', '', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"OC4L\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1776845616);
INSERT INTO `fa_admin_log` VALUES (4, 0, 'Unknown', '/oqMCrJQItl.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"hwdm\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1776845622);
INSERT INTO `fa_admin_log` VALUES (5, 0, 'Unknown', '/oqMCrJQItl.php/index/login', '', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"hwdm\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1776845625);
INSERT INTO `fa_admin_log` VALUES (6, 0, 'Unknown', '/oqMCrJQItl.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"7Mfp\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1776845631);
INSERT INTO `fa_admin_log` VALUES (7, 0, 'Unknown', '/oqMCrJQItl.php/index/login', '', '{\"__token__\":\"***\",\"username\":\"admin123\",\"password\":\"***\",\"captcha\":\"7Mfp\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1776845641);
INSERT INTO `fa_admin_log` VALUES (8, 0, 'Unknown', '/oqMCrJQItl.php/index/login', '', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"7Mfp\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1776845660);
INSERT INTO `fa_admin_log` VALUES (9, 0, 'Unknown', '/oqMCrJQItl.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"HVYn\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1776845665);
INSERT INTO `fa_admin_log` VALUES (10, 1, 'admin', '/oqMCrJQItl.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"NWCD\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1776845804);
INSERT INTO `fa_admin_log` VALUES (11, 1, 'admin', '/oqMCrJQItl.php/ajax/upload', '', '{\"category\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1776930656);
INSERT INTO `fa_admin_log` VALUES (12, 1, 'admin', '/oqMCrJQItl.php/miniapp/user_setting/edit/ids/10001?dialog=1', '小程序 / 用户设置 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"template_name\":\"测试\",\"dispatch_order\":\"12\\/24\",\"commission_rate\":\"10\\/10\",\"fixed_commission\":\"\",\"dispatch_amount\":\"10\\/50\"},\"ids\":\"10001\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1777019627);
INSERT INTO `fa_admin_log` VALUES (13, 1, 'admin', '/oqMCrJQItl.php/miniapp/user_setting/edit/ids/1?dialog=1', '小程序 / 用户设置 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"template_name\":\"测试\",\"dispatch_order\":\"1\",\"commission_rate\":\"10\",\"fixed_commission\":\"\",\"dispatch_amount\":\"20\"},\"ids\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 1777022977);
INSERT INTO `fa_admin_log` VALUES (14, 1, 'admin', '/oqMCrJQItl.php/index/login', '登录', '{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"captcha\":\"XQRQ\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777458002);
INSERT INTO `fa_admin_log` VALUES (15, 1, 'admin', '/oqMCrJQItl.php/user/user/edit/ids/2?dialog=1', '会员管理 / 会员管理 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"id\":\"2\",\"group_id\":\"1\",\"username\":\"admin123\",\"nickname\":\"admin123\",\"password\":\"***\",\"email\":\"29585288231@qq.com\",\"mobile\":\"17674179468\",\"avatar\":\"\",\"level\":\"1\",\"gender\":\"0\",\"birthday\":\"\",\"bio\":\"\",\"money\":\"0.00\",\"score\":\"0\",\"successions\":\"1\",\"maxsuccessions\":\"1\",\"prevtime\":\"2026-04-22 03:10:23\",\"logintime\":\"2026-04-22 03:10:23\",\"loginip\":\"127.0.0.1\",\"loginfailure\":\"0\",\"joinip\":\"127.0.0.1\",\"jointime\":\"2026-04-22 03:10:23\",\"status\":\"normal\"},\"ids\":\"2\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459026);
INSERT INTO `fa_admin_log` VALUES (16, 1, 'admin', '/oqMCrJQItl.php/user/user/edit/ids/2?dialog=1', '会员管理 / 会员管理 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"id\":\"2\",\"group_id\":\"1\",\"username\":\"admin123\",\"nickname\":\"admin123\",\"password\":\"***\",\"email\":\"29585288231@qq.com\",\"mobile\":\"17674317946\",\"avatar\":\"\",\"level\":\"1\",\"gender\":\"0\",\"birthday\":\"\",\"bio\":\"\",\"money\":\"0.00\",\"score\":\"0\",\"successions\":\"1\",\"maxsuccessions\":\"1\",\"prevtime\":\"2026-04-22 03:10:23\",\"logintime\":\"2026-04-22 03:10:23\",\"loginip\":\"127.0.0.1\",\"loginfailure\":\"0\",\"joinip\":\"127.0.0.1\",\"jointime\":\"2026-04-22 03:10:23\",\"status\":\"normal\"},\"ids\":\"2\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459031);
INSERT INTO `fa_admin_log` VALUES (17, 1, 'admin', '/oqMCrJQItl.php/miniapp/user_setting/edit/ids/3?dialog=1', '小程序 / 用户设置 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"template_name\":\"\",\"dispatch_order\":\"\",\"commission_rate\":\"\",\"fixed_commission\":\"\",\"dispatch_amount\":\"\"},\"ids\":\"3\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459124);
INSERT INTO `fa_admin_log` VALUES (18, 1, 'admin', '/oqMCrJQItl.php/miniapp/user_setting/withdraw/ids/10005?dialog=1', '小程序 / 小程序用户设置 / 提现', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"amount\":\"100\",\"type\":\"admin\",\"remark\":\"\"},\"ids\":\"10005\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459585);
INSERT INTO `fa_admin_log` VALUES (19, 1, 'admin', '/oqMCrJQItl.php/miniapp/user_setting/recharge/ids/10005?dialog=1', '小程序 / 小程序用户设置 / 充值', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"amount\":\"1\",\"remark\":\"\"},\"ids\":\"10005\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459601);
INSERT INTO `fa_admin_log` VALUES (20, 1, 'admin', '/oqMCrJQItl.php/miniapp/user_setting/withdraw/ids/10005?dialog=1', '小程序 / 小程序用户设置 / 提现', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"amount\":\"1\",\"type\":\"admin\",\"remark\":\"\"},\"ids\":\"10005\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459607);
INSERT INTO `fa_admin_log` VALUES (21, 1, 'admin', '/oqMCrJQItl.php/miniapp/user_setting/recharge/ids/10004?dialog=1', '小程序 / 小程序用户设置 / 充值', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"amount\":\"10\",\"remark\":\"\"},\"ids\":\"10004\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459621);
INSERT INTO `fa_admin_log` VALUES (22, 1, 'admin', '/oqMCrJQItl.php/miniapp/user_setting/withdraw/ids/10005?dialog=1', '小程序 / 小程序用户设置 / 提现', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"amount\":\"1\",\"type\":\"admin1\",\"remark\":\"\"},\"ids\":\"10005\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459627);
INSERT INTO `fa_admin_log` VALUES (23, 1, 'admin', '/oqMCrJQItl.php/ajax/weigh', '', '{\"ids\":\"1,2,3,5,4,66,85,119,89,95,101,107\",\"changeid\":\"119\",\"pid\":\"85\",\"field\":\"weigh\",\"orderway\":\"desc\",\"table\":\"auth_rule\",\"pk\":\"id\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459714);
INSERT INTO `fa_admin_log` VALUES (24, 1, 'admin', '/oqMCrJQItl.php/auth/rule/edit/ids/119?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"85\",\"name\":\"miniapp\\/user_setting\",\"title\":\"小程序用户设置\",\"url\":\"\",\"icon\":\"fa fa-mobile\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"100\",\"status\":\"normal\"},\"ids\":\"119\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459729);
INSERT INTO `fa_admin_log` VALUES (25, 1, 'admin', '/oqMCrJQItl.php/auth/rule/edit/ids/119?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"85\",\"name\":\"miniapp\\/user_setting\",\"title\":\"小程序用户设置\",\"url\":\"\",\"icon\":\"fa fa-user\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"100\",\"status\":\"normal\"},\"ids\":\"119\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459740);
INSERT INTO `fa_admin_log` VALUES (26, 1, 'admin', '/oqMCrJQItl.php/auth/rule/edit/ids/85?dialog=1', '权限管理 / 菜单规则 / 编辑', '{\"dialog\":\"1\",\"__token__\":\"***\",\"row\":{\"ismenu\":\"1\",\"pid\":\"0\",\"name\":\"miniapp\",\"title\":\"小程序\",\"url\":\"\",\"icon\":\"fa fa-html5\",\"condition\":\"\",\"menutype\":\"addtabs\",\"extend\":\"\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"normal\"},\"ids\":\"85\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 1777459871);

-- ----------------------------
-- Table structure for fa_area
-- ----------------------------
DROP TABLE IF EXISTS `fa_area`;
CREATE TABLE `fa_area`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) NULL DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简称',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) NULL DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '地区表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_area
-- ----------------------------

-- ----------------------------
-- Table structure for fa_attachment
-- ----------------------------
DROP TABLE IF EXISTS `fa_attachment`;
CREATE TABLE `fa_attachment`  (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类别',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '宽度',
  `imageheight` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '高度',
  `imagetype` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '图片帧数',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `mimetype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '透传数据',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建日期',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `uploadtime` bigint(16) NULL DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '附件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_attachment
-- ----------------------------
INSERT INTO `fa_attachment` VALUES (1, '', 1, 0, '/assets/img/qrcode.png', 150, 150, 'png', 0, 'qrcode.png', 21859, 'image/png', '', 1491635035, 1491635035, 1491635035, 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');
INSERT INTO `fa_attachment` VALUES (2, '', 1, 0, '/uploads/20260423/b1bf6880edd7d59a698f29bcc3a34fcb.png', 114, 114, 'png', 0, '58035273baf706bc01b6610b5f12779.png', 5500, 'image/png', '', 1776930656, 1776930656, 1776930656, 'local', '3beb16510c7f6962fa835c8deb597aeff1d5b3be');

-- ----------------------------
-- Table structure for fa_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group`;
CREATE TABLE `fa_auth_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父组别',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '规则ID',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_auth_group
-- ----------------------------
INSERT INTO `fa_auth_group` VALUES (1, 0, 'Admin group', '*', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (2, 1, 'Second group', '13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (3, 2, 'Third group', '1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (4, 1, 'Second group 2', '1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES (5, 2, 'Third group 2', '1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34', 1491635035, 1491635035, 'normal');

-- ----------------------------
-- Table structure for fa_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group_access`;
CREATE TABLE `fa_auth_group_access`  (
  `uid` int(10) UNSIGNED NOT NULL COMMENT '会员ID',
  `group_id` int(10) UNSIGNED NOT NULL COMMENT '级别ID',
  UNIQUE INDEX `uid_group_id`(`uid` ASC, `group_id` ASC) USING BTREE,
  INDEX `uid`(`uid` ASC) USING BTREE,
  INDEX `group_id`(`group_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '权限分组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_auth_group_access
-- ----------------------------
INSERT INTO `fa_auth_group_access` VALUES (1, 1);

-- ----------------------------
-- Table structure for fa_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_rule`;
CREATE TABLE `fa_auth_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图标',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规则URL',
  `condition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为菜单',
  `menutype` enum('addtabs','blank','dialog','ajax') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单类型',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展属性',
  `py` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '拼音首字母',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '拼音',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE,
  INDEX `pid`(`pid` ASC) USING BTREE,
  INDEX `weigh`(`weigh` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '节点表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_auth_rule
-- ----------------------------
INSERT INTO `fa_auth_rule` VALUES (1, 'file', 0, 'dashboard', 'Dashboard', 'fa fa-dashboard', '', '', 'Dashboard tips', 1, NULL, '', 'kzt', 'kongzhitai', 1491635035, 1491635035, 143, 'normal');
INSERT INTO `fa_auth_rule` VALUES (2, 'file', 0, 'general', 'General', 'fa fa-cogs', '', '', '', 1, NULL, '', 'cggl', 'changguiguanli', 1491635035, 1491635035, 137, 'normal');
INSERT INTO `fa_auth_rule` VALUES (3, 'file', 0, 'category', 'Category', 'fa fa-leaf', '', '', 'Category tips', 0, NULL, '', 'flgl', 'fenleiguanli', 1491635035, 1491635035, 119, 'normal');
INSERT INTO `fa_auth_rule` VALUES (4, 'file', 0, 'addon', 'Addon', 'fa fa-rocket', '', '', 'Addon tips', 1, NULL, '', 'cjgl', 'chajianguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (5, 'file', 0, 'auth', 'Auth', 'fa fa-group', '', '', '', 1, NULL, '', 'qxgl', 'quanxianguanli', 1491635035, 1491635035, 99, 'normal');
INSERT INTO `fa_auth_rule` VALUES (6, 'file', 2, 'general/config', 'Config', 'fa fa-cog', '', '', 'Config tips', 1, NULL, '', 'xtpz', 'xitongpeizhi', 1491635035, 1491635035, 60, 'normal');
INSERT INTO `fa_auth_rule` VALUES (7, 'file', 2, 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', '', 'Attachment tips', 1, NULL, '', 'fjgl', 'fujianguanli', 1491635035, 1491635035, 53, 'normal');
INSERT INTO `fa_auth_rule` VALUES (8, 'file', 2, 'general/profile', 'Profile', 'fa fa-user', '', '', '', 1, NULL, '', 'grzl', 'gerenziliao', 1491635035, 1491635035, 34, 'normal');
INSERT INTO `fa_auth_rule` VALUES (9, 'file', 5, 'auth/admin', 'Admin', 'fa fa-user', '', '', 'Admin tips', 1, NULL, '', 'glygl', 'guanliyuanguanli', 1491635035, 1491635035, 118, 'normal');
INSERT INTO `fa_auth_rule` VALUES (10, 'file', 5, 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', '', 'Admin log tips', 1, NULL, '', 'glyrz', 'guanliyuanrizhi', 1491635035, 1491635035, 113, 'normal');
INSERT INTO `fa_auth_rule` VALUES (11, 'file', 5, 'auth/group', 'Group', 'fa fa-group', '', '', 'Group tips', 1, NULL, '', 'jsz', 'juesezu', 1491635035, 1491635035, 109, 'normal');
INSERT INTO `fa_auth_rule` VALUES (12, 'file', 5, 'auth/rule', 'Rule', 'fa fa-bars', '', '', 'Rule tips', 1, NULL, '', 'cdgz', 'caidanguize', 1491635035, 1491635035, 104, 'normal');
INSERT INTO `fa_auth_rule` VALUES (13, 'file', 1, 'dashboard/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 136, 'normal');
INSERT INTO `fa_auth_rule` VALUES (14, 'file', 1, 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 135, 'normal');
INSERT INTO `fa_auth_rule` VALUES (15, 'file', 1, 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 133, 'normal');
INSERT INTO `fa_auth_rule` VALUES (16, 'file', 1, 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 134, 'normal');
INSERT INTO `fa_auth_rule` VALUES (17, 'file', 1, 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 132, 'normal');
INSERT INTO `fa_auth_rule` VALUES (18, 'file', 6, 'general/config/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 52, 'normal');
INSERT INTO `fa_auth_rule` VALUES (19, 'file', 6, 'general/config/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 51, 'normal');
INSERT INTO `fa_auth_rule` VALUES (20, 'file', 6, 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 50, 'normal');
INSERT INTO `fa_auth_rule` VALUES (21, 'file', 6, 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 49, 'normal');
INSERT INTO `fa_auth_rule` VALUES (22, 'file', 6, 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 48, 'normal');
INSERT INTO `fa_auth_rule` VALUES (23, 'file', 7, 'general/attachment/index', 'View', 'fa fa-circle-o', '', '', 'Attachment tips', 0, NULL, '', '', '', 1491635035, 1491635035, 59, 'normal');
INSERT INTO `fa_auth_rule` VALUES (24, 'file', 7, 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 58, 'normal');
INSERT INTO `fa_auth_rule` VALUES (25, 'file', 7, 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 57, 'normal');
INSERT INTO `fa_auth_rule` VALUES (26, 'file', 7, 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 56, 'normal');
INSERT INTO `fa_auth_rule` VALUES (27, 'file', 7, 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 55, 'normal');
INSERT INTO `fa_auth_rule` VALUES (28, 'file', 7, 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 54, 'normal');
INSERT INTO `fa_auth_rule` VALUES (29, 'file', 8, 'general/profile/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 33, 'normal');
INSERT INTO `fa_auth_rule` VALUES (30, 'file', 8, 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 32, 'normal');
INSERT INTO `fa_auth_rule` VALUES (31, 'file', 8, 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 31, 'normal');
INSERT INTO `fa_auth_rule` VALUES (32, 'file', 8, 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 30, 'normal');
INSERT INTO `fa_auth_rule` VALUES (33, 'file', 8, 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 29, 'normal');
INSERT INTO `fa_auth_rule` VALUES (34, 'file', 8, 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 28, 'normal');
INSERT INTO `fa_auth_rule` VALUES (35, 'file', 3, 'category/index', 'View', 'fa fa-circle-o', '', '', 'Category tips', 0, NULL, '', '', '', 1491635035, 1491635035, 142, 'normal');
INSERT INTO `fa_auth_rule` VALUES (36, 'file', 3, 'category/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 141, 'normal');
INSERT INTO `fa_auth_rule` VALUES (37, 'file', 3, 'category/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 140, 'normal');
INSERT INTO `fa_auth_rule` VALUES (38, 'file', 3, 'category/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 139, 'normal');
INSERT INTO `fa_auth_rule` VALUES (39, 'file', 3, 'category/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 138, 'normal');
INSERT INTO `fa_auth_rule` VALUES (40, 'file', 9, 'auth/admin/index', 'View', 'fa fa-circle-o', '', '', 'Admin tips', 0, NULL, '', '', '', 1491635035, 1491635035, 117, 'normal');
INSERT INTO `fa_auth_rule` VALUES (41, 'file', 9, 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 116, 'normal');
INSERT INTO `fa_auth_rule` VALUES (42, 'file', 9, 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 115, 'normal');
INSERT INTO `fa_auth_rule` VALUES (43, 'file', 9, 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 114, 'normal');
INSERT INTO `fa_auth_rule` VALUES (44, 'file', 10, 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', '', 'Admin log tips', 0, NULL, '', '', '', 1491635035, 1491635035, 112, 'normal');
INSERT INTO `fa_auth_rule` VALUES (45, 'file', 10, 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 111, 'normal');
INSERT INTO `fa_auth_rule` VALUES (46, 'file', 10, 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 110, 'normal');
INSERT INTO `fa_auth_rule` VALUES (47, 'file', 11, 'auth/group/index', 'View', 'fa fa-circle-o', '', '', 'Group tips', 0, NULL, '', '', '', 1491635035, 1491635035, 108, 'normal');
INSERT INTO `fa_auth_rule` VALUES (48, 'file', 11, 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 107, 'normal');
INSERT INTO `fa_auth_rule` VALUES (49, 'file', 11, 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 106, 'normal');
INSERT INTO `fa_auth_rule` VALUES (50, 'file', 11, 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 105, 'normal');
INSERT INTO `fa_auth_rule` VALUES (51, 'file', 12, 'auth/rule/index', 'View', 'fa fa-circle-o', '', '', 'Rule tips', 0, NULL, '', '', '', 1491635035, 1491635035, 103, 'normal');
INSERT INTO `fa_auth_rule` VALUES (52, 'file', 12, 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 102, 'normal');
INSERT INTO `fa_auth_rule` VALUES (53, 'file', 12, 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 101, 'normal');
INSERT INTO `fa_auth_rule` VALUES (54, 'file', 12, 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 100, 'normal');
INSERT INTO `fa_auth_rule` VALUES (55, 'file', 4, 'addon/index', 'View', 'fa fa-circle-o', '', '', 'Addon tips', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (56, 'file', 4, 'addon/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (57, 'file', 4, 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (58, 'file', 4, 'addon/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (59, 'file', 4, 'addon/downloaded', 'Local addon', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (60, 'file', 4, 'addon/state', 'Update state', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (63, 'file', 4, 'addon/config', 'Setting', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (64, 'file', 4, 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (65, 'file', 4, 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (66, 'file', 0, 'user', 'User', 'fa fa-user-circle', '', '', '', 1, NULL, '', 'hygl', 'huiyuanguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (67, 'file', 66, 'user/user', 'User', 'fa fa-user', '', '', '', 1, NULL, '', 'hygl', 'huiyuanguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (68, 'file', 67, 'user/user/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (69, 'file', 67, 'user/user/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (70, 'file', 67, 'user/user/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (71, 'file', 67, 'user/user/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (72, 'file', 67, 'user/user/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (73, 'file', 66, 'user/group', 'User group', 'fa fa-users', '', '', '', 1, NULL, '', 'hyfz', 'huiyuanfenzu', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (74, 'file', 73, 'user/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (75, 'file', 73, 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (76, 'file', 73, 'user/group/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (77, 'file', 73, 'user/group/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (78, 'file', 73, 'user/group/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (79, 'file', 66, 'user/rule', 'User rule', 'fa fa-circle-o', '', '', '', 1, NULL, '', 'hygz', 'huiyuanguize', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (80, 'file', 79, 'user/rule/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (81, 'file', 79, 'user/rule/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (82, 'file', 79, 'user/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (83, 'file', 79, 'user/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (84, 'file', 79, 'user/rule/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (85, 'file', 0, 'miniapp', '小程序', 'fa fa-html5', '', '', '', 1, 'addtabs', '', 'xcx', 'xiaochengxu', 1777015831, 1777459871, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (89, 'file', 85, 'miniapp/recharge_record', '充值记录', 'fa fa-credit-card', '', '', '', 1, NULL, '', 'czjl', 'chongzhijilu', 1777457496, 1777457496, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (90, 'file', 89, 'miniapp/recharge_record/index', 'Index', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sy', 'shouye', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (91, 'file', 89, 'miniapp/recharge_record/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (92, 'file', 89, 'miniapp/recharge_record/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (93, 'file', 89, 'miniapp/recharge_record/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (94, 'file', 89, 'miniapp/recharge_record/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (95, 'file', 85, 'miniapp/withdraw_record', '提现记录', 'fa fa-bank', '', '', '', 1, NULL, '', 'txjl', 'tixianjilu', 1777457496, 1777457496, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (96, 'file', 95, 'miniapp/withdraw_record/index', 'Index', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sy', 'shouye', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (97, 'file', 95, 'miniapp/withdraw_record/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (98, 'file', 95, 'miniapp/withdraw_record/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (99, 'file', 95, 'miniapp/withdraw_record/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (100, 'file', 95, 'miniapp/withdraw_record/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (101, 'file', 85, 'miniapp/order_action_record', '抢单记录', 'fa fa-list-alt', '', '', '', 1, NULL, '', 'qdjl', 'qiangdanjilu', 1777457496, 1777457496, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (102, 'file', 101, 'miniapp/order_action_record/index', 'Index', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sy', 'shouye', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (103, 'file', 101, 'miniapp/order_action_record/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (104, 'file', 101, 'miniapp/order_action_record/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (105, 'file', 101, 'miniapp/order_action_record/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (106, 'file', 101, 'miniapp/order_action_record/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (107, 'file', 85, 'miniapp/finance_record', '账变记录', 'fa fa-money', '', '', '', 1, NULL, '', 'zbjl', 'zhangbianjilu', 1777457496, 1777457496, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (108, 'file', 107, 'miniapp/finance_record/index', 'Index', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sy', 'shouye', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (109, 'file', 107, 'miniapp/finance_record/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (110, 'file', 107, 'miniapp/finance_record/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (111, 'file', 107, 'miniapp/finance_record/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (112, 'file', 107, 'miniapp/finance_record/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1777457496, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (119, 'file', 85, 'miniapp/user_setting', '小程序用户设置', 'fa fa-user', '', '', '', 1, 'addtabs', '', 'xcxyhsz', 'xiaochengxuyonghushezhi', 1777459182, 1777459740, 100, 'normal');
INSERT INTO `fa_auth_rule` VALUES (120, 'file', 119, 'miniapp/user_setting/index', 'Index', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sy', 'shouye', 1777459182, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (121, 'file', 119, 'miniapp/user_setting/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1777459182, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (122, 'file', 119, 'miniapp/user_setting/selectpage', 'Selectpage', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'S', 'Selectpage', 1777459182, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (123, 'file', 119, 'miniapp/user_setting/recharge', 'Recharge', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'R', 'Recharge', 1777459182, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (124, 'file', 119, 'miniapp/user_setting/withdraw', 'Withdraw', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'W', 'Withdraw', 1777459182, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (125, 'file', 119, 'miniapp/user_setting/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1777459182, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (126, 'file', 119, 'miniapp/user_setting/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1777459182, 1777459182, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (127, 'file', 119, 'miniapp/user_setting/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1777459182, 1777459182, 0, 'normal');

-- ----------------------------
-- Table structure for fa_category
-- ----------------------------
DROP TABLE IF EXISTS `fa_category`;
CREATE TABLE `fa_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `flag` set('hot','index','recommend') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '自定义名称',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `weigh`(`weigh` ASC, `id` ASC) USING BTREE,
  INDEX `pid`(`pid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_category
-- ----------------------------
INSERT INTO `fa_category` VALUES (1, 0, 'page', '官方新闻', 'news', 'recommend', '/assets/img/qrcode.png', '', '', 'news', 1491635035, 1491635035, 1, 'normal');
INSERT INTO `fa_category` VALUES (2, 0, 'page', '移动应用', 'mobileapp', 'hot', '/assets/img/qrcode.png', '', '', 'mobileapp', 1491635035, 1491635035, 2, 'normal');
INSERT INTO `fa_category` VALUES (3, 2, 'page', '微信公众号', 'wechatpublic', 'index', '/assets/img/qrcode.png', '', '', 'wechatpublic', 1491635035, 1491635035, 3, 'normal');
INSERT INTO `fa_category` VALUES (4, 2, 'page', 'Android开发', 'android', 'recommend', '/assets/img/qrcode.png', '', '', 'android', 1491635035, 1491635035, 4, 'normal');
INSERT INTO `fa_category` VALUES (5, 0, 'page', '软件产品', 'software', 'recommend', '/assets/img/qrcode.png', '', '', 'software', 1491635035, 1491635035, 5, 'normal');
INSERT INTO `fa_category` VALUES (6, 5, 'page', '网站建站', 'website', 'recommend', '/assets/img/qrcode.png', '', '', 'website', 1491635035, 1491635035, 6, 'normal');
INSERT INTO `fa_category` VALUES (7, 5, 'page', '企业管理软件', 'company', 'index', '/assets/img/qrcode.png', '', '', 'company', 1491635035, 1491635035, 7, 'normal');
INSERT INTO `fa_category` VALUES (8, 6, 'page', 'PC端', 'website-pc', 'recommend', '/assets/img/qrcode.png', '', '', 'website-pc', 1491635035, 1491635035, 8, 'normal');
INSERT INTO `fa_category` VALUES (9, 6, 'page', '移动端', 'website-mobile', 'recommend', '/assets/img/qrcode.png', '', '', 'website-mobile', 1491635035, 1491635035, 9, 'normal');
INSERT INTO `fa_category` VALUES (10, 7, 'page', 'CRM系统 ', 'company-crm', 'recommend', '/assets/img/qrcode.png', '', '', 'company-crm', 1491635035, 1491635035, 10, 'normal');
INSERT INTO `fa_category` VALUES (11, 7, 'page', 'SASS平台软件', 'company-sass', 'recommend', '/assets/img/qrcode.png', '', '', 'company-sass', 1491635035, 1491635035, 11, 'normal');
INSERT INTO `fa_category` VALUES (12, 0, 'test', '测试1', 'test1', 'recommend', '/assets/img/qrcode.png', '', '', 'test1', 1491635035, 1491635035, 12, 'normal');
INSERT INTO `fa_category` VALUES (13, 0, 'test', '测试2', 'test2', 'recommend', '/assets/img/qrcode.png', '', '', 'test2', 1491635035, 1491635035, 13, 'normal');

-- ----------------------------
-- Table structure for fa_config
-- ----------------------------
DROP TABLE IF EXISTS `fa_config`;
CREATE TABLE `fa_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `visible` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '可见条件',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变量值',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '变量字典数据',
  `rule` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展属性',
  `setting` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_config
-- ----------------------------
INSERT INTO `fa_config` VALUES (1, 'name', 'basic', 'Site name', '请填写站点名称', 'string', '', '我的网站', '', 'required', '', '');
INSERT INTO `fa_config` VALUES (2, 'beian', 'basic', 'Beian', '粤ICP备15000000号-1', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (3, 'cdnurl', 'basic', 'Cdn url', '如果全站静态资源使用第三方云储存请配置该值', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (4, 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '', '1.0.1', '', 'required', '', '');
INSERT INTO `fa_config` VALUES (5, 'timezone', 'basic', 'Timezone', '', 'string', '', 'Asia/Shanghai', '', 'required', '', '');
INSERT INTO `fa_config` VALUES (6, 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (7, 'languages', 'basic', 'Languages', '', 'array', '', '{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}', '', 'required', '', '');
INSERT INTO `fa_config` VALUES (8, 'fixedpage', 'basic', 'Fixed page', '请输入左侧菜单栏存在的链接', 'string', '', 'dashboard', '', 'required', '', '');
INSERT INTO `fa_config` VALUES (9, 'categorytype', 'dictionary', 'Category type', '', 'array', '', '{\"default\":\"Default\",\"page\":\"Page\",\"article\":\"Article\",\"test\":\"Test\"}', '', '', '', '');
INSERT INTO `fa_config` VALUES (10, 'configgroup', 'dictionary', 'Config group', '', 'array', '', '{\"basic\":\"Basic\",\"email\":\"Email\",\"dictionary\":\"Dictionary\",\"user\":\"User\",\"example\":\"Example\"}', '', '', '', '');
INSERT INTO `fa_config` VALUES (11, 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '', '1', '[\"请选择\",\"SMTP\"]', '', '', '');
INSERT INTO `fa_config` VALUES (12, 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', '', 'smtp.qq.com', '', '', '', '');
INSERT INTO `fa_config` VALUES (13, 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '', '465', '', '', '', '');
INSERT INTO `fa_config` VALUES (14, 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (15, 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码或授权码）', 'password', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (16, 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '', '2', '[\"无\",\"TLS\",\"SSL\"]', '', '', '');
INSERT INTO `fa_config` VALUES (17, 'mail_from', 'email', 'Mail from', '', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES (18, 'attachmentcategory', 'dictionary', 'Attachment category', '', 'array', '', '{\"category1\":\"Category1\",\"category2\":\"Category2\",\"custom\":\"Custom\"}', '', '', '', '');

-- ----------------------------
-- Table structure for fa_ems
-- ----------------------------
DROP TABLE IF EXISTS `fa_ems`;
CREATE TABLE `fa_ems`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '事件',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '邮箱验证码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_ems
-- ----------------------------

-- ----------------------------
-- Table structure for fa_miniapp_cashpwd_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_cashpwd_log`;
CREATE TABLE `fa_miniapp_cashpwd_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '地址',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序资金密码修改日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_cashpwd_log
-- ----------------------------
INSERT INTO `fa_miniapp_cashpwd_log` VALUES (1, 10001, 'test', 1776872862);
INSERT INTO `fa_miniapp_cashpwd_log` VALUES (2, 1, '', 1776931707);

-- ----------------------------
-- Table structure for fa_miniapp_config
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_config`;
CREATE TABLE `fa_miniapp_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '配置名',
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '配置值',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '语言',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name_lang`(`name` ASC, `language` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序系统配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_config
-- ----------------------------
INSERT INTO `fa_miniapp_config` VALUES (1, 'desc_info', '<p>Take a closer look at the work rules</p>', '1', 1, 1776878259, 1776878259);
INSERT INTO `fa_miniapp_config` VALUES (2, 'desc_info', '<p>Take a closer look at the work rules</p>', '2', 1, 1776878259, 1776878259);
INSERT INTO `fa_miniapp_config` VALUES (3, 'deal_zhuji_time', '1', '1', 1, 1776878259, 1776878259);
INSERT INTO `fa_miniapp_config` VALUES (4, 'deal_shop_time', '2', '1', 1, 1776878259, 1776878259);
INSERT INTO `fa_miniapp_config` VALUES (5, 'level_bili', '0.006', '1', 1, 1776878259, 1776878259);
INSERT INTO `fa_miniapp_config` VALUES (6, 'order_num', '60', '1', 1, 1776878259, 1776878259);
INSERT INTO `fa_miniapp_config` VALUES (13, 'template_name', '', '1', 1, 1777018987, 1777018987);
INSERT INTO `fa_miniapp_config` VALUES (14, 'dispatch_order', '', '1', 1, 1777018987, 1777018987);
INSERT INTO `fa_miniapp_config` VALUES (15, 'commission_rate', '', '1', 1, 1777018987, 1777018987);
INSERT INTO `fa_miniapp_config` VALUES (16, 'fixed_commission', '', '1', 1, 1777018987, 1777018987);
INSERT INTO `fa_miniapp_config` VALUES (17, 'dispatch_amount', '', '1', 1, 1777018987, 1777018987);
INSERT INTO `fa_miniapp_config` VALUES (18, 'template_name', '', '2', 1, 1777018987, 1777018987);
INSERT INTO `fa_miniapp_config` VALUES (19, 'dispatch_order', '', '2', 1, 1777018987, 1777018987);
INSERT INTO `fa_miniapp_config` VALUES (20, 'commission_rate', '', '2', 1, 1777018987, 1777018987);
INSERT INTO `fa_miniapp_config` VALUES (21, 'fixed_commission', '', '2', 1, 1777018987, 1777018987);
INSERT INTO `fa_miniapp_config` VALUES (22, 'dispatch_amount', '', '2', 1, 1777018987, 1777018987);

-- ----------------------------
-- Table structure for fa_miniapp_finance_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_finance_log`;
CREATE TABLE `fa_miniapp_finance_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '流水ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID(兼容线上)',
  `sid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '来源用户ID',
  `oid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '关联订单号(兼容线上)',
  `num` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '金额(兼容线上num字段)',
  `balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '变更后余额(兼容线上)',
  `addtime` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间(兼容线上)',
  `f_lv` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '层级标记',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '流水类型',
  `amount` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '金额',
  `balance_after` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '变更后余额',
  `related_order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '关联单号',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_type`(`user_id` ASC, `type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序资金流水' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_finance_log
-- ----------------------------
INSERT INTO `fa_miniapp_finance_log` VALUES (1, 10001, 10001, 10001, 'UBTEST000002', 99.00, 1200.50, 1713747600, NULL, 1, 1, 99.00, 1200.50, 'UBTEST000002', 'order complete income', 1713747600);
INSERT INTO `fa_miniapp_finance_log` VALUES (2, 10001, 10001, 10001, 'WDTEST000001', -100.00, 1100.50, 1713751200, NULL, 1, 7, -100.00, 1100.50, 'WDTEST000001', 'withdraw apply', 1713751200);
INSERT INTO `fa_miniapp_finance_log` VALUES (3, 10002, 10002, 10002, 'UBTEST000003', 109.00, 860.00, 1713744000, NULL, 1, 1, 109.00, 860.00, 'UBTEST000003', 'pending demo data', 1713744000);
INSERT INTO `fa_miniapp_finance_log` VALUES (4, 10001, 10001, 10001, 'UBTEST000001', 99.00, 1299.50, 1776872685, NULL, 1, 1, 99.00, 1299.50, 'UBTEST000001', 'order complete income', 1776872685);
INSERT INTO `fa_miniapp_finance_log` VALUES (5, 10001, 10001, 10001, 'WD2604222348316310', -10.00, 1289.50, 1776872911, NULL, 1, 7, -10.00, 1289.50, 'WD2604222348316310', 'withdraw apply', 1776872911);
INSERT INTO `fa_miniapp_finance_log` VALUES (6, 10001, 10001, 10001, 'UB2604230101314239', 99.00, 1388.50, 1776877379, NULL, 1, 1, 99.00, 1388.50, 'UB2604230101314239', 'order complete income', 1776877379);
INSERT INTO `fa_miniapp_finance_log` VALUES (7, 10001, 10001, 10001, 'UB2604222345101902', 0.59, 1389.09, 1776879407, NULL, 1, 3, 0.59, 1389.09, 'UB2604222345101902', 'order complete commission', 1776879407);
INSERT INTO `fa_miniapp_finance_log` VALUES (8, 1, 1, 1, 'UB2604231424493346', 0.59, 0.59, 1776925762, NULL, 1, 3, 0.59, 0.59, 'UB2604231424493346', 'order complete commission', 1776925762);
INSERT INTO `fa_miniapp_finance_log` VALUES (9, 1, 1, 1, 'SEED240423U1A01', 2.56, 802.56, 1776506838, NULL, 1, 3, 2.56, 802.56, 'SEED240423U1A01', 'seed order complete commission', 1776506838);
INSERT INTO `fa_miniapp_finance_log` VALUES (10, 1, 1, 1, 'SEED240423U1A02', 4.72, 824.72, 1776677838, NULL, 1, 3, 4.72, 824.72, 'SEED240423U1A02', 'seed order complete commission', 1776677838);
INSERT INTO `fa_miniapp_finance_log` VALUES (11, 1, 1, 1, 'SEED240423U1A03', 6.30, 906.30, 1776851238, NULL, 1, 3, 6.30, 906.30, 'SEED240423U1A03', 'seed order complete commission', 1776851238);
INSERT INTO `fa_miniapp_finance_log` VALUES (12, 10001, 10001, 10001, 'SEED240423U10001A01', 3.36, 540.60, 1776418038, NULL, 1, 3, 3.36, 540.60, 'SEED240423U10001A01', 'seed order complete commission', 1776418038);
INSERT INTO `fa_miniapp_finance_log` VALUES (13, 10001, 10001, 10001, 'SEED240423U10001A02', 5.96, 543.20, 1776764538, NULL, 1, 3, 5.96, 543.20, 'SEED240423U10001A02', 'seed order complete commission', 1776764538);
INSERT INTO `fa_miniapp_finance_log` VALUES (14, 10001, 10001, 10001, 'SEED240423U10001A03', 9.00, 546.24, 1776852138, NULL, 1, 3, 9.00, 546.24, 'SEED240423U10001A03', 'seed order complete commission', 1776852138);
INSERT INTO `fa_miniapp_finance_log` VALUES (16, 10001, 10001, 10001, 'SEED240423U10001C01', 11.60, 550.52, 1777019525, NULL, 1, 3, 11.60, 550.52, 'SEED240423U10001C01', 'order complete commission', 1777019525);
INSERT INTO `fa_miniapp_finance_log` VALUES (17, 10001, 10001, 10001, 'SEED240423U10001B02', 7.24, 557.76, 1777019684, NULL, 1, 3, 7.24, 557.76, 'SEED240423U10001B02', 'order complete commission', 1777019684);
INSERT INTO `fa_miniapp_finance_log` VALUES (18, 10001, 10001, 10001, 'SEED240423U10001B01', 2.52, 560.28, 1777019702, NULL, 1, 3, 2.52, 560.28, 'SEED240423U10001B01', 'order complete commission', 1777019702);
INSERT INTO `fa_miniapp_finance_log` VALUES (19, 10001, 10001, 10001, 'UB2604230137272402', 0.59, 560.87, 1777019719, NULL, 1, 3, 0.59, 560.87, 'UB2604230137272402', 'order complete commission', 1777019719);
INSERT INTO `fa_miniapp_finance_log` VALUES (20, 10001, 10001, 10001, 'UB2604241635518905', 0.59, 561.46, 1777019759, NULL, 1, 3, 0.59, 561.46, 'UB2604241635518905', 'order complete commission', 1777019759);
INSERT INTO `fa_miniapp_finance_log` VALUES (21, 1, 1, 1, 'SEED240423U1C01', 10.40, 10.99, 1777020037, NULL, 1, 3, 10.40, 10.99, 'SEED240423U1C01', 'order complete commission', 1777020037);
INSERT INTO `fa_miniapp_finance_log` VALUES (22, 1, 1, 1, 'SEED240423U1B02', 8.24, 19.23, 1777020047, NULL, 1, 3, 8.24, 19.23, 'SEED240423U1B02', 'order complete commission', 1777020047);
INSERT INTO `fa_miniapp_finance_log` VALUES (23, 10001, 10001, 10001, 'UB2604241708502055', 0.59, 562.05, 1777022107, NULL, 1, 3, 0.59, 562.05, 'UB2604241708502055', 'order complete commission', 1777022107);
INSERT INTO `fa_miniapp_finance_log` VALUES (24, 1, 1, 1, 'SEED240423U1B01', 3.76, 22.99, 1777023007, NULL, 1, 3, 3.76, 22.99, 'SEED240423U1B01', 'order complete commission', 1777023007);
INSERT INTO `fa_miniapp_finance_log` VALUES (25, 10005, 10005, 10005, 'RC2604290646411384', 1.00, 1.00, 1777459601, NULL, 1, 8, 1.00, 1.00, 'RC2604290646411384', 'admin recharge', 1777459601);
INSERT INTO `fa_miniapp_finance_log` VALUES (26, 10005, 10005, 10005, 'WD2604290646474308', -1.00, 0.00, 1777459607, NULL, 1, 7, -1.00, 0.00, 'WD2604290646474308', 'admin withdraw', 1777459607);
INSERT INTO `fa_miniapp_finance_log` VALUES (27, 10004, 10004, 10004, 'RC2604290647019893', 10.00, 10.00, 1777459621, NULL, 1, 8, 10.00, 10.00, 'RC2604290647019893', 'admin recharge', 1777459621);

-- ----------------------------
-- Table structure for fa_miniapp_finance_log_bak_20260423_seedtest
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_finance_log_bak_20260423_seedtest`;
CREATE TABLE `fa_miniapp_finance_log_bak_20260423_seedtest`  (
  `id` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '流水ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID(兼容线上)',
  `sid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '来源用户ID',
  `oid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '关联订单号(兼容线上)',
  `num` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '金额(兼容线上num字段)',
  `balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '变更后余额(兼容线上)',
  `addtime` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间(兼容线上)',
  `f_lv` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '层级标记',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '流水类型',
  `amount` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '金额',
  `balance_after` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '变更后余额',
  `related_order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '关联单号',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间'
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_finance_log_bak_20260423_seedtest
-- ----------------------------

-- ----------------------------
-- Table structure for fa_miniapp_goods
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_goods`;
CREATE TABLE `fa_miniapp_goods`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'zh_cn' COMMENT '语言',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '商品标题',
  `sub_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '副标题',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '图片',
  `price` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '价格',
  `goods_count` int(11) NOT NULL DEFAULT 1 COMMENT '商品数量',
  `profit` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '收益',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 203 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_goods
-- ----------------------------
INSERT INTO `fa_miniapp_goods` VALUES (201, '1', '中文体验商品', '用于中文环境的下单测试', 'https://cf.shopee.com.my/file/245f0dfdd377d24157b180aae965691d', 99.00, 1, 12.00, 1, 100, 1713744000, 1713744000);
INSERT INTO `fa_miniapp_goods` VALUES (202, '2', 'English Demo Goods', 'Order testing in English locale', 'https://cf.shopee.com.my/file/245f0dfdd377d24157b180aae965691d', 109.00, 1, 15.00, 1, 90, 1713744000, 1713744000);

-- ----------------------------
-- Table structure for fa_miniapp_home
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_home`;
CREATE TABLE `fa_miniapp_home`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'zh_cn' COMMENT '语言',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '首页标题',
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '首页副标题',
  `banner_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '轮播JSON',
  `notice_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '公告JSON',
  `nav_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '导航JSON',
  `recommend_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '推荐JSON',
  `popup_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '弹窗JSON',
  `extra` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '扩展JSON',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `is_default` tinyint(4) NOT NULL DEFAULT 1 COMMENT '默认',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 303 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序首页配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_home
-- ----------------------------
INSERT INTO `fa_miniapp_home` VALUES (301, 'default_cn', '1', '中文首页', '', '[{\"id\":16,\"image\":\"https://back.aliexpressplus.top/upload/bbe5b75975d5b5a8/859d0ad268e92e2f.jpg\",\"title\":null,\"url\":\"https://kele1006.space/obj\"},{\"id\":17,\"image\":\"https://back.aliexpressplus.top/upload/ee18f23e64a146c4/1d57ab0921ff6f97.jpg\",\"title\":null,\"url\":\"https://kele1006.space/obj\"},{\"id\":18,\"image\":\"https://back.aliexpressplus.top/upload/acb56b0630addb59/5d7a554f805d11f2.jpg\",\"title\":null,\"url\":\"https://kele1006.space/obj\"},{\"id\":19,\"image\":\"https://back.aliexpressplus.top/upload/fa5970d3ddfb78f1/1093a56df4e8d8a5.jpg\",\"title\":null,\"url\":\"https://kele1006.space/obj\"}]', '[{\"id\":1,\"title\":\"中文公告\"}]', '[{\"id\":1,\"name\":\"订单\",\"icon\":\"order\",\"path\":\"/pages/order/index\"}]', '[{\"id\":1,\"title\":\"中文推荐商品\",\"price\":99}]', '[]', '{\"theme\":\"cn\"}', 1, 1, 100, 1713744000, 1776937774);
INSERT INTO `fa_miniapp_home` VALUES (302, 'default_en', '2', 'English Home', 'English subtitle', '[{\"id\":16,\"image\":\"https://back.aliexpressplus.top/upload/bbe5b75975d5b5a8/859d0ad268e92e2f.jpg\",\"title\":null,\"url\":\"https://kele1006.space/obj\"},{\"id\":17,\"image\":\"https://back.aliexpressplus.top/upload/ee18f23e64a146c4/1d57ab0921ff6f97.jpg\",\"title\":null,\"url\":\"https://kele1006.space/obj\"},{\"id\":18,\"image\":\"https://back.aliexpressplus.top/upload/acb56b0630addb59/5d7a554f805d11f2.jpg\",\"title\":null,\"url\":\"https://kele1006.space/obj\"},{\"id\":19,\"image\":\"https://back.aliexpressplus.top/upload/fa5970d3ddfb78f1/1093a56df4e8d8a5.jpg\",\"title\":null,\"url\":\"https://kele1006.space/obj\"}]', '[{\"id\":1,\"title\":\"English Notice\"}]', '[{\"id\":1,\"name\":\"Orders\",\"icon\":\"order\",\"path\":\"/pages/order/index\"}]', '[{\"id\":1,\"title\":\"English Demo Goods\",\"price\":109}]', '[]', '{\"theme\":\"en\"}', 1, 1, 90, 1713744000, 1713744000);

-- ----------------------------
-- Table structure for fa_miniapp_home_bak_20260423_homenew
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_home_bak_20260423_homenew`;
CREATE TABLE `fa_miniapp_home_bak_20260423_homenew`  (
  `id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配置ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'zh_cn' COMMENT '语言',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '首页标题',
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '首页副标题',
  `banner_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '轮播JSON',
  `notice_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '公告JSON',
  `nav_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '导航JSON',
  `recommend_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '推荐JSON',
  `popup_list` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '弹窗JSON',
  `extra` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '扩展JSON',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `is_default` tinyint(4) NOT NULL DEFAULT 1 COMMENT '默认',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间'
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_home_bak_20260423_homenew
-- ----------------------------

-- ----------------------------
-- Table structure for fa_miniapp_order
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_order`;
CREATE TABLE `fa_miniapp_order`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID(兼容线上uid字段)',
  `level_id` int(11) NOT NULL DEFAULT 0 COMMENT '等级ID',
  `parent_uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级用户ID',
  `order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `goods_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品ID',
  `goods_count` int(11) NOT NULL DEFAULT 0 COMMENT '商品数量',
  `goods_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '商品名称',
  `shop_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '店铺名称',
  `goods_price` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '商品单价',
  `goods_pic` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '商品图片URL',
  `today_dan` int(11) NOT NULL DEFAULT 0 COMMENT '今日第几单',
  `qkon` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态标记',
  `group_id` int(11) NOT NULL DEFAULT 0 COMMENT '分组ID',
  `group_rule_num` int(11) NOT NULL DEFAULT 0 COMMENT '组规则数',
  `group_is_active` tinyint(4) NOT NULL DEFAULT 0 COMMENT '组是否激活',
  `group_completedornot` tinyint(4) NOT NULL DEFAULT 1 COMMENT '组完成状态',
  `rands` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '随机标记',
  `group_count` int(11) NULL DEFAULT NULL COMMENT '组订单数',
  `duorw` tinyint(4) NOT NULL DEFAULT 0 COMMENT '多任务标记',
  `rwdans` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务答案',
  `zhuass` tinyint(4) NOT NULL DEFAULT 0 COMMENT '助手标记',
  `time_limit` int(11) NOT NULL DEFAULT 0 COMMENT '时间限制(秒)',
  `goods_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '商品图',
  `amount` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '订单金额',
  `num` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '订单金额(兼容线上num字段)',
  `user_balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '下单时用户余额',
  `user_freeze_balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '下单时冻结余额',
  `addtime` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间(兼容线上)',
  `term_time` int(11) NULL DEFAULT NULL COMMENT '期限时间',
  `endtime` int(11) NOT NULL DEFAULT 0 COMMENT '结束时间',
  `is_pay` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否已支付',
  `commission` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '佣金',
  `parent_commission` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '上级佣金',
  `c_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '佣金状态',
  `add_id` int(11) NOT NULL DEFAULT 1 COMMENT '添加来源ID',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '来源',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'zh_cn' COMMENT '语言',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '备注',
  `pay_time` int(11) NOT NULL DEFAULT 0 COMMENT '支付时间',
  `complete_time` int(11) NOT NULL DEFAULT 0 COMMENT '完成时间',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no` ASC) USING BTREE,
  INDEX `idx_user_status`(`user_id` ASC, `status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 526 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序订单主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_order
-- ----------------------------
INSERT INTO `fa_miniapp_order` VALUES (503, 10002, 10002, 0, 0, 'UBTEST000003', 202, 1, 'English Demo Goods', 'English Demo Goods', 109.00, '/uploads/miniapp/goods-en.png', 0, 1, 0, 0, 0, 1, NULL, NULL, 0, NULL, 0, 0, '/uploads/miniapp/goods-en.png', 109.00, 109.00, 0.00, 0.00, 1713744000, NULL, 1713747600, 1, 0.65, 0.11, 0, 1, 1, 'seed', '2', 'Pending order', 1713744000, 0, 1713744000, 1713744000);
INSERT INTO `fa_miniapp_order` VALUES (507, 1, 1, 0, 0, 'UB2604231424493346', 201, 1, '中文体验商品', '中文体验商品', 99.00, '/uploads/miniapp/goods-cn.png', 1, 1, 0, 0, 0, 1, NULL, NULL, 0, NULL, 0, 0, '/uploads/miniapp/goods-cn.png', 99.00, 99.00, 0.00, 0.00, 1776925489, NULL, 1776929089, 1, 0.59, 0.09, 1, 1, 2, 'submit_order', '1', '', 1776925489, 1776925762, 1776925489, 1776925762);
INSERT INTO `fa_miniapp_order` VALUES (508, 1, 1, 0, 0, 'SEED240423U1A01', 901, 1, 'Test Goods A1', 'Test Shop A', 128.00, 'https://dummyimage.com/300x300/f5f5f5/333333&text=U1-A1', 1, 1, 0, 0, 0, 1, NULL, NULL, 0, NULL, 0, 0, 'https://dummyimage.com/300x300/f5f5f5/333333&text=U1-A1', 128.00, 128.00, 800.00, 0.00, 1776503238, NULL, 1776506838, 1, 2.56, 0.38, 1, 1, 2, 'seed_test', '1', '已完成测试订单1', 1776503238, 1776506838, 1776503238, 1776506838);
INSERT INTO `fa_miniapp_order` VALUES (509, 1, 1, 0, 0, 'SEED240423U1A02', 902, 1, 'Test Goods A2', 'Test Shop A', 118.00, 'https://dummyimage.com/300x300/e8f7ff/333333&text=U1-A2', 2, 1, 0, 0, 0, 1, NULL, NULL, 0, NULL, 0, 0, 'https://dummyimage.com/300x300/e8f7ff/333333&text=U1-A2', 236.00, 236.00, 820.00, 0.00, 1776676038, NULL, 1776677838, 1, 4.72, 0.71, 1, 1, 2, 'seed_test', '1', '已完成测试订单2', 1776676038, 1776677838, 1776676038, 1776677838);
INSERT INTO `fa_miniapp_order` VALUES (510, 1, 1, 0, 0, 'SEED240423U1A03', 903, 1, 'Test Goods A3', 'Test Shop A', 105.00, 'https://dummyimage.com/300x300/fff4d6/333333&text=U1-A3', 3, 1, 0, 0, 0, 1, NULL, NULL, 0, NULL, 0, 0, 'https://dummyimage.com/300x300/fff4d6/333333&text=U1-A3', 315.00, 315.00, 900.00, 0.00, 1776848838, NULL, 1776851238, 1, 6.30, 0.95, 1, 1, 2, 'seed_test', '1', '已完成测试订单3', 1776848838, 1776851238, 1776848838, 1776851238);
INSERT INTO `fa_miniapp_order` VALUES (511, 1, 1, 0, 0, 'SEED240423U1B01', 904, 1, 'Test Goods B1', 'Test Shop B', 188.00, 'https://dummyimage.com/300x300/ffe8e8/333333&text=U1-B1', 4, 1, 0, 0, 0, 1, NULL, NULL, 0, NULL, 0, 7200, 'https://dummyimage.com/300x300/ffe8e8/333333&text=U1-B1', 188.00, 188.00, 1200.00, 0.00, 1776913638, NULL, 1776942438, 1, 3.76, 0.56, 1, 1, 2, 'seed_test', '1', '未完成测试订单1', 1776913638, 1777023007, 1776913638, 1777023007);
INSERT INTO `fa_miniapp_order` VALUES (512, 1, 1, 0, 0, 'SEED240423U1B02', 905, 1, 'Test Goods B2', 'Test Shop B', 206.00, 'https://dummyimage.com/300x300/eafbea/333333&text=U1-B2', 5, 1, 0, 0, 0, 1, NULL, NULL, 0, NULL, 0, 14400, 'https://dummyimage.com/300x300/eafbea/333333&text=U1-B2', 412.00, 412.00, 1200.00, 0.00, 1776933438, NULL, 1776949638, 1, 8.24, 1.24, 1, 1, 2, 'seed_test', '1', '未完成测试订单2', 1776933438, 1777020047, 1776933438, 1777020047);
INSERT INTO `fa_miniapp_order` VALUES (513, 1, 1, 0, 0, 'SEED240423U1C01', 906, 1, 'Test Goods C1', 'Test Shop C', 260.00, 'https://dummyimage.com/300x300/f0e8ff/333333&text=U1-C1', 6, 1, 0, 0, 0, 1, NULL, NULL, 0, NULL, 0, 21600, 'https://dummyimage.com/300x300/f0e8ff/333333&text=U1-C1', 520.00, 520.00, 1200.00, 0.00, 1776934338, NULL, 1776956838, 0, 10.40, 1.56, 1, 1, 2, 'seed_test', '1', '未支付测试订单', 0, 1777020037, 1776934338, 1777020037);
INSERT INTO `fa_miniapp_order` VALUES (524, 10001, 10001, 0, 0, 'UB2604241726178571', 201, 5, '中文体验商品', '中文体验商品', 99.00, 'https://cf.shopee.com.my/file/245f0dfdd377d24157b180aae965691d', 1, 1, 0, 0, 0, 1, NULL, NULL, 0, NULL, 0, 0, 'https://cf.shopee.com.my/file/245f0dfdd377d24157b180aae965691d', 495.00, 495.00, 562.05, 0.00, 1777022777, NULL, 1777026377, 1, 2.97, 0.45, 1, 1, 1, 'submit_order', '1', '', 1777022777, 0, 1777022777, 1777022777);
INSERT INTO `fa_miniapp_order` VALUES (525, 1, 1, 0, 0, 'UB2604242143012576', 201, 1, '中文体验商品', '中文体验商品', 99.00, 'https://cf.shopee.com.my/file/245f0dfdd377d24157b180aae965691d', 4, 1, 0, 0, 0, 1, NULL, NULL, 0, NULL, 0, 0, 'https://cf.shopee.com.my/file/245f0dfdd377d24157b180aae965691d', 99.00, 99.00, 22.99, 0.00, 1777038181, NULL, 0, 0, 0.59, 0.09, 0, 1, 0, 'order_info', '1', '', 0, 0, 1777038181, 1777038181);

-- ----------------------------
-- Table structure for fa_miniapp_order_action_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_order_action_log`;
CREATE TABLE `fa_miniapp_order_action_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `order_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单ID',
  `order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '动作',
  `amount` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '金额',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序订单动作日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_order_action_log
-- ----------------------------
INSERT INTO `fa_miniapp_order_action_log` VALUES (1, 10001, 501, 'UBTEST000001', 'submit_order', 99.00, 1, 1713744000);
INSERT INTO `fa_miniapp_order_action_log` VALUES (2, 10001, 502, 'UBTEST000002', 'do_order', 99.00, 1, 1713747600);
INSERT INTO `fa_miniapp_order_action_log` VALUES (3, 10002, 503, 'UBTEST000003', 'submit_order', 109.00, 1, 1713744000);
INSERT INTO `fa_miniapp_order_action_log` VALUES (4, 10001, 501, 'UBTEST000001', 'do_order', 99.00, 1, 1776872685);
INSERT INTO `fa_miniapp_order_action_log` VALUES (5, 10001, 504, 'UB2604222345101902', 'submit_order', 99.00, 1, 1776872710);
INSERT INTO `fa_miniapp_order_action_log` VALUES (6, 10001, 505, 'UB2604230101314239', 'submit_order', 99.00, 1, 1776877291);
INSERT INTO `fa_miniapp_order_action_log` VALUES (7, 10001, 505, 'UB2604230101314239', 'do_order', 99.00, 1, 1776877379);
INSERT INTO `fa_miniapp_order_action_log` VALUES (8, 10001, 504, 'UB2604222345101902', 'do_order', 99.00, 1, 1776879407);
INSERT INTO `fa_miniapp_order_action_log` VALUES (9, 10001, 0, 'UB2604230137272402', 'submit_order', 99.00, 1, 1776879447);
INSERT INTO `fa_miniapp_order_action_log` VALUES (10, 1, 0, 'UB2604231424493346', 'submit_order', 99.00, 1, 1776925489);
INSERT INTO `fa_miniapp_order_action_log` VALUES (11, 1, 507, 'UB2604231424493346', 'do_order', 99.00, 1, 1776925762);
INSERT INTO `fa_miniapp_order_action_log` VALUES (12, 1, 508, 'SEED240423U1A01', 'do_order', 128.00, 1, 1776503238);
INSERT INTO `fa_miniapp_order_action_log` VALUES (13, 1, 509, 'SEED240423U1A02', 'do_order', 236.00, 1, 1776676038);
INSERT INTO `fa_miniapp_order_action_log` VALUES (14, 1, 510, 'SEED240423U1A03', 'do_order', 315.00, 1, 1776848838);
INSERT INTO `fa_miniapp_order_action_log` VALUES (15, 1, 511, 'SEED240423U1B01', 'submit_order', 188.00, 1, 1776913638);
INSERT INTO `fa_miniapp_order_action_log` VALUES (16, 1, 512, 'SEED240423U1B02', 'submit_order', 412.00, 1, 1776933438);
INSERT INTO `fa_miniapp_order_action_log` VALUES (17, 1, 513, 'SEED240423U1C01', 'submit_order', 520.00, 1, 1776934338);
INSERT INTO `fa_miniapp_order_action_log` VALUES (18, 10001, 514, 'SEED240423U10001A01', 'do_order', 168.00, 1, 1776416838);
INSERT INTO `fa_miniapp_order_action_log` VALUES (19, 10001, 515, 'SEED240423U10001A02', 'do_order', 298.00, 1, 1776762438);
INSERT INTO `fa_miniapp_order_action_log` VALUES (20, 10001, 516, 'SEED240423U10001A03', 'do_order', 450.00, 1, 1776848838);
INSERT INTO `fa_miniapp_order_action_log` VALUES (21, 10001, 517, 'SEED240423U10001B01', 'submit_order', 126.00, 1, 1776928038);
INSERT INTO `fa_miniapp_order_action_log` VALUES (22, 10001, 518, 'SEED240423U10001B02', 'submit_order', 362.00, 1, 1776932838);
INSERT INTO `fa_miniapp_order_action_log` VALUES (23, 10001, 519, 'SEED240423U10001C01', 'submit_order', 580.00, 1, 1776934038);
INSERT INTO `fa_miniapp_order_action_log` VALUES (27, 10001, 519, 'SEED240423U10001C01', 'do_order', 580.00, 1, 1777019525);
INSERT INTO `fa_miniapp_order_action_log` VALUES (28, 10001, 518, 'SEED240423U10001B02', 'do_order', 362.00, 1, 1777019684);
INSERT INTO `fa_miniapp_order_action_log` VALUES (29, 10001, 517, 'SEED240423U10001B01', 'do_order', 126.00, 1, 1777019702);
INSERT INTO `fa_miniapp_order_action_log` VALUES (30, 10001, 506, 'UB2604230137272402', 'do_order', 99.00, 1, 1777019719);
INSERT INTO `fa_miniapp_order_action_log` VALUES (31, 10001, 0, 'UB2604241635518905', 'submit_order', 99.00, 1, 1777019751);
INSERT INTO `fa_miniapp_order_action_log` VALUES (32, 10001, 520, 'UB2604241635518905', 'do_order', 99.00, 1, 1777019759);
INSERT INTO `fa_miniapp_order_action_log` VALUES (33, 10001, 0, 'UB2604241639331988', 'submit_order', 99.00, 1, 1777019973);
INSERT INTO `fa_miniapp_order_action_log` VALUES (34, 1, 513, 'SEED240423U1C01', 'do_order', 520.00, 1, 1777020037);
INSERT INTO `fa_miniapp_order_action_log` VALUES (35, 1, 512, 'SEED240423U1B02', 'do_order', 412.00, 1, 1777020047);
INSERT INTO `fa_miniapp_order_action_log` VALUES (36, 10001, 0, 'UB2604241708502055', 'submit_order', 99.00, 1, 1777021730);
INSERT INTO `fa_miniapp_order_action_log` VALUES (37, 10001, 522, 'UB2604241708502055', 'do_order', 99.00, 1, 1777022107);
INSERT INTO `fa_miniapp_order_action_log` VALUES (38, 10001, 0, 'UB2604241717562711', 'submit_order', 495.00, 1, 1777022276);
INSERT INTO `fa_miniapp_order_action_log` VALUES (39, 10001, 0, 'UB2604241726178571', 'submit_order', 495.00, 1, 1777022777);
INSERT INTO `fa_miniapp_order_action_log` VALUES (40, 1, 511, 'SEED240423U1B01', 'do_order', 188.00, 1, 1777023007);
INSERT INTO `fa_miniapp_order_action_log` VALUES (41, 1, 525, 'UB2604242143012576', 'order_info', 99.00, 1, 1777038181);

-- ----------------------------
-- Table structure for fa_miniapp_order_action_log_bak_20260423_seedtest
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_order_action_log_bak_20260423_seedtest`;
CREATE TABLE `fa_miniapp_order_action_log_bak_20260423_seedtest`  (
  `id` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '日志ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `order_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单ID',
  `order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '动作',
  `amount` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '金额',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间'
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_order_action_log_bak_20260423_seedtest
-- ----------------------------

-- ----------------------------
-- Table structure for fa_miniapp_order_bak_20260423_seedtest
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_order_bak_20260423_seedtest`;
CREATE TABLE `fa_miniapp_order_bak_20260423_seedtest`  (
  `id` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID(兼容线上uid字段)',
  `level_id` int(11) NOT NULL DEFAULT 0 COMMENT '等级ID',
  `parent_uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级用户ID',
  `order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `goods_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品ID',
  `goods_count` int(11) NOT NULL DEFAULT 0 COMMENT '商品数量',
  `goods_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '商品名称',
  `shop_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '店铺名称',
  `goods_price` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '商品单价',
  `goods_pic` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '商品图片URL',
  `today_dan` int(11) NOT NULL DEFAULT 0 COMMENT '今日第几单',
  `qkon` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态标记',
  `group_id` int(11) NOT NULL DEFAULT 0 COMMENT '分组ID',
  `group_rule_num` int(11) NOT NULL DEFAULT 0 COMMENT '组规则数',
  `group_is_active` tinyint(4) NOT NULL DEFAULT 0 COMMENT '组是否激活',
  `group_completedornot` tinyint(4) NOT NULL DEFAULT 1 COMMENT '组完成状态',
  `rands` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '随机标记',
  `group_count` int(11) NULL DEFAULT NULL COMMENT '组订单数',
  `duorw` tinyint(4) NOT NULL DEFAULT 0 COMMENT '多任务标记',
  `rwdans` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务答案',
  `zhuass` tinyint(4) NOT NULL DEFAULT 0 COMMENT '助手标记',
  `time_limit` int(11) NOT NULL DEFAULT 0 COMMENT '时间限制(秒)',
  `goods_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '商品图',
  `amount` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '订单金额',
  `num` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '订单金额(兼容线上num字段)',
  `user_balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '下单时用户余额',
  `user_freeze_balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '下单时冻结余额',
  `addtime` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间(兼容线上)',
  `term_time` int(11) NULL DEFAULT NULL COMMENT '期限时间',
  `endtime` int(11) NOT NULL DEFAULT 0 COMMENT '结束时间',
  `is_pay` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否已支付',
  `commission` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '佣金',
  `parent_commission` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '上级佣金',
  `c_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '佣金状态',
  `add_id` int(11) NOT NULL DEFAULT 1 COMMENT '添加来源ID',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '来源',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'zh_cn' COMMENT '语言',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '备注',
  `pay_time` int(11) NOT NULL DEFAULT 0 COMMENT '支付时间',
  `complete_time` int(11) NOT NULL DEFAULT 0 COMMENT '完成时间',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间'
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_order_bak_20260423_seedtest
-- ----------------------------

-- ----------------------------
-- Table structure for fa_miniapp_pay_config
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_pay_config`;
CREATE TABLE `fa_miniapp_pay_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID(0=全局)',
  `usercode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '收款地址/编码',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '支付类型(USDT-TRC20等)',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序充值支付配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_pay_config
-- ----------------------------
INSERT INTO `fa_miniapp_pay_config` VALUES (1, 0, 'TV4pKS2gngbM2Fzjb2RcLNR3prMCYaeWVc', 'USDT-TRC20', 1, 100, 1776878259, 1776878259);
INSERT INTO `fa_miniapp_pay_config` VALUES (2, 0, 'TV4pKS2gngbM2Fzjb2RcLNR3prMCYaeWVc', 'USDT-ERC20', 1, 99, 1776878259, 1776878259);
INSERT INTO `fa_miniapp_pay_config` VALUES (3, 0, 'TV4pKS2gngbM2Fzjb2RcLNR3prMCYaeWVc', 'USDT-TRC20', 1, 100, 1776878358, 1776878358);
INSERT INTO `fa_miniapp_pay_config` VALUES (4, 0, 'TV4pKS2gngbM2Fzjb2RcLNR3prMCYaeWVc', 'USDT-ERC20', 1, 99, 1776878358, 1776878358);

-- ----------------------------
-- Table structure for fa_miniapp_profile
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_profile`;
CREATE TABLE `fa_miniapp_profile`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '资料ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `top_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '顶部标题',
  `top_notice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '顶部公告',
  `service_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '客服链接',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序我的页面配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_profile
-- ----------------------------
INSERT INTO `fa_miniapp_profile` VALUES (1, 10001, '我的中心', '欢迎使用中文测试账号', 'https://example.com/service/cn', 1713744000, 1713744000);
INSERT INTO `fa_miniapp_profile` VALUES (2, 10002, 'My Center', 'Welcome to the English test account', 'https://example.com/service/en', 1713744000, 1713744000);

-- ----------------------------
-- Table structure for fa_miniapp_recharge_channel
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_recharge_channel`;
CREATE TABLE `fa_miniapp_recharge_channel`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '渠道ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '渠道名称',
  `channel_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '渠道编码',
  `min_amount` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '最小金额',
  `max_amount` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '最大金额',
  `fee_rate` decimal(6, 4) NOT NULL DEFAULT 0.0000 COMMENT '费率',
  `notice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '说明',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 403 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序充值渠道' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_recharge_channel
-- ----------------------------
INSERT INTO `fa_miniapp_recharge_channel` VALUES (401, '银行卡充值', 'BANK', 100.00, 5000.00, 0.0150, '工作日 10:00-18:00 审核', 1, 100, 1713744000, 1713744000);
INSERT INTO `fa_miniapp_recharge_channel` VALUES (402, 'USDT Recharge', 'USDT', 50.00, 10000.00, 0.0100, 'TRC20 only', 1, 90, 1713744000, 1713744000);

-- ----------------------------
-- Table structure for fa_miniapp_request_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_request_log`;
CREATE TABLE `fa_miniapp_request_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `module` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '模块',
  `controller` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `action` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '动作',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '语言',
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'token',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '方法',
  `request_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '地址',
  `accept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'accept',
  `accept_language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'accept-language',
  `content_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'content-type',
  `origin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'origin',
  `priority` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'priority',
  `referer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'referer',
  `sec_ch_ua` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'sec-ch-ua',
  `sec_ch_ua_mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'sec-ch-ua-mobile',
  `sec_ch_ua_platform` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'sec-ch-ua-platform',
  `sec_fetch_dest` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'sec-fetch-dest',
  `sec_fetch_mode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'sec-fetch-mode',
  `sec_fetch_site` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'sec-fetch-site',
  `user_agent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'ua',
  `client_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '参数',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 606 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序请求日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_request_log
-- ----------------------------
INSERT INTO `fa_miniapp_request_log` VALUES (1, 'api', 'Miniapp', 'supportindex', 'zh_cn', '', 0, 'GET', '/miniapp/support/index', 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7', 'zh-CN,zh;q=0.9', '', '', '', '', '', '', '', '', '', '', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '127.0.0.1', '[]', 1776848344);
INSERT INTO `fa_miniapp_request_log` VALUES (2, 'api', 'Miniapp', 'supportindex', 'zh_cn', '', 0, 'POST', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776848357);
INSERT INTO `fa_miniapp_request_log` VALUES (3, 'api', 'Miniapp', 'do_register', 'zh_cn', '', 1, 'POST', '/miniapp/user/do_register?tel=13812341234&pwd=123456&confirmPassword=123456&invite_code=1&area_code=+86', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\",\"confirmPassword\":\"123456\",\"invite_code\":\"1\",\"area_code\":\"86\"}', 1776848821);
INSERT INTO `fa_miniapp_request_log` VALUES (4, 'api', 'Miniapp', 'do_login', 'en', '0525c702ece5cc72d93ede78878723cbb83751d4', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'application/x-www-form-urlencoded', '', 'u=1, i', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776849189);
INSERT INTO `fa_miniapp_request_log` VALUES (5, 'api', 'Miniapp', 'do_login', 'zh_cn', '', 1, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '', '', '', '', '', '', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776849465);
INSERT INTO `fa_miniapp_request_log` VALUES (6, 'api', 'Miniapp', 'do_login', 'en', '0525c702ece5cc72d93ede78878723cbb83751d4', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'application/x-www-form-urlencoded', '', 'u=1, i', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776849521);
INSERT INTO `fa_miniapp_request_log` VALUES (7, 'api', 'Miniapp', 'do_login', 'zh_cn', '', 1, 'POST', '/miniapp/user/do_login?tel=13812341234&pwd=123456', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776849600);
INSERT INTO `fa_miniapp_request_log` VALUES (8, 'api', 'Miniapp', 'do_login', 'zh_cn', '', 1, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776849618);
INSERT INTO `fa_miniapp_request_log` VALUES (9, 'api', 'Miniapp', 'do_login', 'zh_cn', '', 1, 'POST', '/miniapp/user/do_login?tel=13812341234&pwd=123456', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776849896);
INSERT INTO `fa_miniapp_request_log` VALUES (10, 'api', 'Miniapp', 'do_register', 'zh_cn', '', 2, 'POST', '/miniapp/user/do_register', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"14113938512\",\"pwd\":\"asd.12345\",\"confirmPassword\":\"asd.12345\",\"invite_code\":\"123456\",\"area_code\":\"+86\"}', 1776850086);
INSERT INTO `fa_miniapp_request_log` VALUES (11, 'api', 'Miniapp', 'do_register', 'zh_cn', '', 3, 'POST', '/miniapp/user/do_register', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"14113938412\",\"pwd\":\"123456\",\"confirmPassword\":\"123456\",\"invite_code\":\"1234\",\"area_code\":\"+86\"}', 1776850293);
INSERT INTO `fa_miniapp_request_log` VALUES (12, 'api', 'Miniapp', 'do_register', 'zh_cn', '', 4, 'POST', '/miniapp/user/do_register', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"14112938412\",\"pwd\":\"123456\",\"confirmPassword\":\"123456\",\"invite_code\":\"12212\",\"area_code\":\"+86\"}', 1776850458);
INSERT INTO `fa_miniapp_request_log` VALUES (13, 'api', 'Miniapp', 'do_register', 'zh_cn', '', 5, 'POST', '/miniapp/user/do_register', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"1411383512\",\"pwd\":\"123456\",\"confirmPassword\":\"123456\",\"invite_code\":\"1234\",\"area_code\":\"+86\"}', 1776850564);
INSERT INTO `fa_miniapp_request_log` VALUES (14, 'api', 'Miniapp', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login?tel=13812341234&pwd=123456', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776853248);
INSERT INTO `fa_miniapp_request_log` VALUES (15, 'api', 'Miniapp', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login?tel=13812341234&pwd=123456', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776855401);
INSERT INTO `fa_miniapp_request_log` VALUES (16, 'api', 'Miniapp', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login?tel=13812341234&pwd=123456', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776856081);
INSERT INTO `fa_miniapp_request_log` VALUES (17, 'api', 'Miniapp', 'homenew', '1', '', 0, 'POST', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776856089);
INSERT INTO `fa_miniapp_request_log` VALUES (18, 'api', 'Miniapp', 'homenew', '1', '', 0, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776856144);
INSERT INTO `fa_miniapp_request_log` VALUES (19, 'api', 'Miniapp', 'supportindex', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776856260);
INSERT INTO `fa_miniapp_request_log` VALUES (20, 'api', 'Miniapp', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login?tel=13812341234&pwd=123456', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776857800);
INSERT INTO `fa_miniapp_request_log` VALUES (21, 'api', 'Miniapp', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login?tel=13812341234&pwd=123456', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776857822);
INSERT INTO `fa_miniapp_request_log` VALUES (22, 'api', 'Miniapp', 'logout', '1', '9fa404d675ef7350b4344bfcba3fd01d', 1, 'POST', '/miniapp/user/logout', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776857834);
INSERT INTO `fa_miniapp_request_log` VALUES (23, 'api', 'Miniapp', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login?tel=13812341234&pwd=123456', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776857843);
INSERT INTO `fa_miniapp_request_log` VALUES (24, 'api', 'Miniapp', 'orderrecord', '1', 'bfcc9fbb7ab600b5f18e3f83f3770ff0', 1, 'GET', '/miniapp/order/orderRecord', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776857861);
INSERT INTO `fa_miniapp_request_log` VALUES (25, 'api', 'Miniapp', 'homenew', '1', '', 0, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776857881);
INSERT INTO `fa_miniapp_request_log` VALUES (26, 'api', 'Miniapp', 'orderrecord', '1', 'bfcc9fbb7ab600b5f18e3f83f3770ff0', 1, 'GET', '/miniapp/order/orderRecord?page&size&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"\",\"size\":\"\",\"status\":\"1\"}', 1776859408);
INSERT INTO `fa_miniapp_request_log` VALUES (27, 'api', 'Miniapp', 'orderrecord', '1', 'bfcc9fbb7ab600b5f18e3f83f3770ff0', 1, 'GET', '/miniapp/order/orderRecord?page&size&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"\",\"size\":\"\",\"status\":\"2\"}', 1776859415);
INSERT INTO `fa_miniapp_request_log` VALUES (28, 'api', 'Miniapp', 'orderrecord', '1', 'bfcc9fbb7ab600b5f18e3f83f3770ff0', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"\",\"status\":\"2\"}', 1776859440);
INSERT INTO `fa_miniapp_request_log` VALUES (29, 'api', 'Miniapp', 'orderrecord', '1', 'bfcc9fbb7ab600b5f18e3f83f3770ff0', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=1&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"1\",\"status\":\"2\"}', 1776859483);
INSERT INTO `fa_miniapp_request_log` VALUES (30, 'api', 'Miniapp', 'orderrecord', '1', 'bfcc9fbb7ab600b5f18e3f83f3770ff0', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=2&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"2\",\"status\":\"2\"}', 1776859489);
INSERT INTO `fa_miniapp_request_log` VALUES (31, 'api', 'Miniapp', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login?tel=13812341234&pwd=123456', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776870144);
INSERT INTO `fa_miniapp_request_log` VALUES (32, 'api', 'Miniapp', 'homenew', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776870150);
INSERT INTO `fa_miniapp_request_log` VALUES (33, 'api', 'Miniapp', 'supportindex', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776870342);
INSERT INTO `fa_miniapp_request_log` VALUES (34, 'api', 'Miniapp', 'orderrecord', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776871041);
INSERT INTO `fa_miniapp_request_log` VALUES (35, 'api', 'Miniapp', 'orderrecord', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776871047);
INSERT INTO `fa_miniapp_request_log` VALUES (36, 'api', 'Miniapp', 'orderrecord', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776871053);
INSERT INTO `fa_miniapp_request_log` VALUES (37, 'api', 'Miniapp', 'orderrecord', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776871056);
INSERT INTO `fa_miniapp_request_log` VALUES (38, 'api', 'Miniapp', 'orderrecord', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"\"}', 1776871068);
INSERT INTO `fa_miniapp_request_log` VALUES (39, 'api', 'Miniapp', 'orderrecord', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776871103);
INSERT INTO `fa_miniapp_request_log` VALUES (40, 'api', 'Miniapp', 'orderrecord', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776871107);
INSERT INTO `fa_miniapp_request_log` VALUES (41, 'api', 'Miniapp', 'orderrecord', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776871401);
INSERT INTO `fa_miniapp_request_log` VALUES (42, 'api', 'Miniapp', 'orderrecord', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776871597);
INSERT INTO `fa_miniapp_request_log` VALUES (43, 'api', 'Miniapp', 'orderrecord', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776871609);
INSERT INTO `fa_miniapp_request_log` VALUES (44, 'api', 'Miniapp.order', 'orderrecord', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776872262);
INSERT INTO `fa_miniapp_request_log` VALUES (45, 'api', 'Miniapp.index', 'homenew', '1', 'ca9786aa489bc3836f09cfff7332254d', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776872266);
INSERT INTO `fa_miniapp_request_log` VALUES (46, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login?tel=13812341234&pwd=123456', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776872269);
INSERT INTO `fa_miniapp_request_log` VALUES (47, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '[]', 1776872515);
INSERT INTO `fa_miniapp_request_log` VALUES (48, 'api', 'Miniapp.support', 'setlanguage', '2', 'miniapp_token_10001', 0, 'POST', '/miniapp/support/setLanguage', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"language\":\"2\"}', 1776872539);
INSERT INTO `fa_miniapp_request_log` VALUES (49, 'api', 'Miniapp.user', 'do_login', '1', '', 10001, 'POST', '/miniapp/user/do_login', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"tel\":\"13800000001\",\"pwd\":\"123456\"}', 1776872562);
INSERT INTO `fa_miniapp_request_log` VALUES (50, 'api', 'Miniapp.index', 'homenew', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '[]', 1776872588);
INSERT INTO `fa_miniapp_request_log` VALUES (51, 'api', 'Miniapp.order', 'orderrecord', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'POST', '/miniapp/order/orderRecord', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"status\":\"0\",\"page\":\"1\",\"size\":\"10\"}', 1776872615);
INSERT INTO `fa_miniapp_request_log` VALUES (52, 'api', 'Miniapp.order', 'order_info', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'POST', '/miniapp/order/order_info', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"id\":\"UBTEST000001\"}', 1776872637);
INSERT INTO `fa_miniapp_request_log` VALUES (53, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '[]', 1776872659);
INSERT INTO `fa_miniapp_request_log` VALUES (54, 'api', 'Miniapp.order', 'do_order', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'POST', '/miniapp/order/do_order', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"oid\":\"UBTEST000001\"}', 1776872685);
INSERT INTO `fa_miniapp_request_log` VALUES (55, 'api', 'Miniapp.rotOrder', 'submit_order', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'POST', '/miniapp/rot_order/submit_order', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '[]', 1776872710);
INSERT INTO `fa_miniapp_request_log` VALUES (56, 'api', 'Miniapp.ctrl', 'teamall', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'POST', '/miniapp/ctrl/teamAll', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '[]', 1776872737);
INSERT INTO `fa_miniapp_request_log` VALUES (57, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '[]', 1776872765);
INSERT INTO `fa_miniapp_request_log` VALUES (58, 'api', 'Miniapp.my', 'indexnew', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'GET', '/miniapp/my/indexNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '[]', 1776872789);
INSERT INTO `fa_miniapp_request_log` VALUES (59, 'api', 'Miniapp.my', 'userinfo', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'GET', '/miniapp/my/userInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '[]', 1776872814);
INSERT INTO `fa_miniapp_request_log` VALUES (60, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776872816);
INSERT INTO `fa_miniapp_request_log` VALUES (61, 'api', 'Miniapp.order', 'orderrecord', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776872821);
INSERT INTO `fa_miniapp_request_log` VALUES (62, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776872824);
INSERT INTO `fa_miniapp_request_log` VALUES (63, 'api', 'Miniapp.my', 'caiwu', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'POST', '/miniapp/my/caiwu', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"type\":\"0\"}', 1776872838);
INSERT INTO `fa_miniapp_request_log` VALUES (64, 'api', 'Miniapp.my', 'setcashpwd', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'POST', '/miniapp/my/setCashPwd', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"pwd\":\"123456\",\"pwd_new\":\"654321\",\"pwd_new_confirm\":\"654321\",\"address\":\"test\"}', 1776872862);
INSERT INTO `fa_miniapp_request_log` VALUES (65, 'api', 'Miniapp.my', 'uinfosave', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'POST', '/miniapp/my/uinfoSave', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"pwd\":\"123456\",\"address\":\"testaddr\"}', 1776872888);
INSERT INTO `fa_miniapp_request_log` VALUES (66, 'api', 'Miniapp.ctrl', 'do_withdraw', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'POST', '/miniapp/ctrl/do_withdraw', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"num\":\"10\",\"type\":\"bank\",\"paypassword\":\"654321\"}', 1776872911);
INSERT INTO `fa_miniapp_request_log` VALUES (67, 'api', 'Miniapp.user', 'logout', '1', '2671d59f6c560f2acce9ad3ac4be3c11', 10001, 'POST', '/miniapp/user/logout', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '[]', 1776872935);
INSERT INTO `fa_miniapp_request_log` VALUES (68, 'api', 'Miniapp.order', 'orderrecord', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776873268);
INSERT INTO `fa_miniapp_request_log` VALUES (69, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776873532);
INSERT INTO `fa_miniapp_request_log` VALUES (70, 'api', 'Miniapp.user', 'do_login', '1', '', 10001, 'POST', '/miniapp/user/do_login', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"tel\":\"13800000001\",\"pwd\":\"123456\"}', 1776873534);
INSERT INTO `fa_miniapp_request_log` VALUES (71, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776873536);
INSERT INTO `fa_miniapp_request_log` VALUES (72, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776873732);
INSERT INTO `fa_miniapp_request_log` VALUES (73, 'api', 'Miniapp.order', 'orderrecord', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776873736);
INSERT INTO `fa_miniapp_request_log` VALUES (74, 'api', 'Miniapp.user', 'do_login', '1', '', 10001, 'POST', '/miniapp/user/do_login', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"tel\":\"13800000001\",\"pwd\":\"123456\"}', 1776873822);
INSERT INTO `fa_miniapp_request_log` VALUES (75, 'api', 'Miniapp.order', 'orderrecord', '1', '39331f1f5bca33ffbd89e9e7a9fd9a8e', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776873851);
INSERT INTO `fa_miniapp_request_log` VALUES (76, 'api', 'Miniapp.order', 'orderrecord', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776873923);
INSERT INTO `fa_miniapp_request_log` VALUES (77, 'api', 'Miniapp.order', 'orderrecord', '1', '39331f1f5bca33ffbd89e9e7a9fd9a8e', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776874475);
INSERT INTO `fa_miniapp_request_log` VALUES (78, 'api', 'Miniapp.order', 'orderrecord', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776874596);
INSERT INTO `fa_miniapp_request_log` VALUES (79, 'api', 'Miniapp.order', 'orderrecord', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776874616);
INSERT INTO `fa_miniapp_request_log` VALUES (80, 'api', 'Miniapp.order', 'orderrecord', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776874619);
INSERT INTO `fa_miniapp_request_log` VALUES (81, 'api', 'Miniapp.order', 'orderrecord', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\"}', 1776874628);
INSERT INTO `fa_miniapp_request_log` VALUES (82, 'api', 'Miniapp.order', 'orderrecord', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\"}', 1776874633);
INSERT INTO `fa_miniapp_request_log` VALUES (83, 'api', 'Miniapp.order', 'orderrecord', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\"}', 1776874660);
INSERT INTO `fa_miniapp_request_log` VALUES (84, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '868839aef861b4389aeadd2228a9813d', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776874761);
INSERT INTO `fa_miniapp_request_log` VALUES (85, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------784450156532680500420626', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776874861);
INSERT INTO `fa_miniapp_request_log` VALUES (86, 'api', 'Miniapp.user', 'logout', '1', '9c33694cbe69b5e1ce3c17d3d69e8f60', 1, 'POST', '/miniapp/user/logout', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776874888);
INSERT INTO `fa_miniapp_request_log` VALUES (87, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------824948955270037230283720', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776874894);
INSERT INTO `fa_miniapp_request_log` VALUES (88, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776874899);
INSERT INTO `fa_miniapp_request_log` VALUES (89, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '2e65c146406b9b5adc79f2add89ddad4', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776874986);
INSERT INTO `fa_miniapp_request_log` VALUES (90, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '2e65c146406b9b5adc79f2add89ddad4', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776875017);
INSERT INTO `fa_miniapp_request_log` VALUES (91, 'api', 'Miniapp.support', 'setlanguage', '2', '', 0, 'POST', '/miniapp/support/setLanguage?language=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"language\":\"2\"}', 1776875065);
INSERT INTO `fa_miniapp_request_log` VALUES (92, 'api', 'Miniapp.index', 'homenew', '1', '2e65c146406b9b5adc79f2add89ddad4', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776875068);
INSERT INTO `fa_miniapp_request_log` VALUES (93, 'api', 'Miniapp.order', 'orderrecord', '1', '2e65c146406b9b5adc79f2add89ddad4', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\"}', 1776875081);
INSERT INTO `fa_miniapp_request_log` VALUES (94, 'api', 'Miniapp.index', 'homenew', '1', '2e65c146406b9b5adc79f2add89ddad4', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776875100);
INSERT INTO `fa_miniapp_request_log` VALUES (95, 'api', 'Miniapp.user', 'logout', '1', '2e65c146406b9b5adc79f2add89ddad4', 1, 'POST', '/miniapp/user/logout', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776875106);
INSERT INTO `fa_miniapp_request_log` VALUES (96, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776875115);
INSERT INTO `fa_miniapp_request_log` VALUES (97, 'api', 'Miniapp.user', 'do_login', '1', '', 10001, 'POST', '/miniapp/user/do_login', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"tel\":\"13800000001\",\"pwd\":\"123456\"}', 1776875273);
INSERT INTO `fa_miniapp_request_log` VALUES (98, 'api', 'Miniapp.support', 'setlanguage', '2', 'bcef88011ee95b58009f298dfcd99b37', 10001, 'POST', '/miniapp/support/setLanguage', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '127.0.0.1', '{\"language\":\"2\"}', 1776875307);
INSERT INTO `fa_miniapp_request_log` VALUES (99, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------856166391893296473251749', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776875604);
INSERT INTO `fa_miniapp_request_log` VALUES (100, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '764d74f4a52a60988916c402f343bacb', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776875880);
INSERT INTO `fa_miniapp_request_log` VALUES (101, 'api', 'Miniapp.support', 'setlanguage', '2', 'test_token_123', 0, 'GET', '/index.php/miniapp/support/setLanguage?language=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"language\":\"2\"}', 1776876436);
INSERT INTO `fa_miniapp_request_log` VALUES (102, 'api', 'Miniapp.support', 'index', '2', 'test_token_123', 0, 'GET', '/index.php/miniapp/support/index?language=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"language\":\"2\"}', 1776876460);
INSERT INTO `fa_miniapp_request_log` VALUES (103, 'api', 'Miniapp.support', 'index', '1', 'test_token_123', 0, 'GET', '/index.php/miniapp/support/index?language=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"language\":\"1\"}', 1776876483);
INSERT INTO `fa_miniapp_request_log` VALUES (104, 'api', 'Miniapp.user', 'do_login', '1', '', 10001, 'POST', '/index.php/miniapp/user/do_login', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"tel\":\"13800000001\",\"pwd\":\"123456\",\"language\":\"1\"}', 1776876533);
INSERT INTO `fa_miniapp_request_log` VALUES (105, 'api', 'Miniapp.order', 'orderrecord', '2', '36bc46c37c0ab9ac0b6d9fb84fc053b8', 10001, 'GET', '/index.php/miniapp/order/orderRecord?language=2&page=1&limit=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"language\":\"2\",\"page\":\"1\",\"limit\":\"10\",\"status\":\"0\"}', 1776876558);
INSERT INTO `fa_miniapp_request_log` VALUES (106, 'api', 'Miniapp.order', 'orderrecord', '1', '36bc46c37c0ab9ac0b6d9fb84fc053b8', 10001, 'GET', '/index.php/miniapp/order/orderRecord?language=1&page=1&limit=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"language\":\"1\",\"page\":\"1\",\"limit\":\"10\",\"status\":\"0\"}', 1776876599);
INSERT INTO `fa_miniapp_request_log` VALUES (107, 'api', 'Miniapp.support', 'setlanguage', '2', '36bc46c37c0ab9ac0b6d9fb84fc053b8', 10001, 'GET', '/index.php/miniapp/support/setLanguage?language=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"language\":\"2\"}', 1776876625);
INSERT INTO `fa_miniapp_request_log` VALUES (108, 'api', 'Miniapp.support', 'setlanguage', '1', '36bc46c37c0ab9ac0b6d9fb84fc053b8', 10001, 'GET', '/index.php/miniapp/support/setLanguage?language=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"language\":\"1\"}', 1776876651);
INSERT INTO `fa_miniapp_request_log` VALUES (109, 'api', 'Miniapp.index', 'homenew', '1', '764d74f4a52a60988916c402f343bacb', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776876666);
INSERT INTO `fa_miniapp_request_log` VALUES (110, 'api', 'Miniapp.user', 'do_login', '1', '', 10001, 'POST', '/index.php/miniapp/user/do_login', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"tel\":\"13800000001\",\"pwd\":\"123456\"}', 1776876864);
INSERT INTO `fa_miniapp_request_log` VALUES (111, 'api', 'Miniapp.index', 'homenew', '1', '9ad5483ffaf6746c73cc4459e72ca615', 10001, 'GET', '/index.php/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776876924);
INSERT INTO `fa_miniapp_request_log` VALUES (112, 'api', 'Miniapp.index', 'homenew', '1', '9ad5483ffaf6746c73cc4459e72ca615', 10001, 'GET', '/index.php/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776877025);
INSERT INTO `fa_miniapp_request_log` VALUES (113, 'api', 'Miniapp.order', 'orderrecord', '1', '9ad5483ffaf6746c73cc4459e72ca615', 10001, 'POST', '/index.php/miniapp/order/orderRecord', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776877115);
INSERT INTO `fa_miniapp_request_log` VALUES (114, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9ad5483ffaf6746c73cc4459e72ca615', 10001, 'GET', '/index.php/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776877179);
INSERT INTO `fa_miniapp_request_log` VALUES (115, 'api', 'Miniapp.rotOrder', 'submit_order', '1', '9ad5483ffaf6746c73cc4459e72ca615', 10001, 'POST', '/index.php/miniapp/rot_order/submit_order', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776877291);
INSERT INTO `fa_miniapp_request_log` VALUES (116, 'api', 'Miniapp.order', 'order_info', '1', '9ad5483ffaf6746c73cc4459e72ca615', 10001, 'POST', '/index.php/miniapp/order/order_info', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"id\":\"UB2604230101314239\"}', 1776877351);
INSERT INTO `fa_miniapp_request_log` VALUES (117, 'api', 'Miniapp.order', 'do_order', '1', '9ad5483ffaf6746c73cc4459e72ca615', 10001, 'POST', '/index.php/miniapp/order/do_order', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"oid\":\"UB2604230101314239\"}', 1776877379);
INSERT INTO `fa_miniapp_request_log` VALUES (118, 'api', 'Miniapp.ctrl', 'teamall', '1', '9ad5483ffaf6746c73cc4459e72ca615', 10001, 'POST', '/index.php/miniapp/ctrl/teamAll', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776877408);
INSERT INTO `fa_miniapp_request_log` VALUES (119, 'api', 'Miniapp.user', 'do_login', '1', '', 10001, 'POST', '/index.php/miniapp/user/do_login', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"tel\":\"13800000001\",\"pwd\":\"123456\"}', 1776878916);
INSERT INTO `fa_miniapp_request_log` VALUES (120, 'api', 'Miniapp.index', 'homenew', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'GET', '/index.php/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879025);
INSERT INTO `fa_miniapp_request_log` VALUES (121, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'GET', '/index.php/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879025);
INSERT INTO `fa_miniapp_request_log` VALUES (122, 'api', 'Miniapp.ctrl', 'teamall', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'POST', '/index.php/miniapp/ctrl/teamAll', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879025);
INSERT INTO `fa_miniapp_request_log` VALUES (123, 'api', 'Miniapp.my', 'indexnew', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'GET', '/index.php/miniapp/my/indexNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879025);
INSERT INTO `fa_miniapp_request_log` VALUES (124, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'GET', '/index.php/miniapp/ctrl/rechargeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879026);
INSERT INTO `fa_miniapp_request_log` VALUES (125, 'api', 'Miniapp.my', 'userinfo', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'GET', '/index.php/miniapp/my/userInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879026);
INSERT INTO `fa_miniapp_request_log` VALUES (126, 'api', 'Miniapp.index', 'homenew', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'GET', '/index.php/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879140);
INSERT INTO `fa_miniapp_request_log` VALUES (127, 'api', 'Miniapp.order', 'orderrecord', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'POST', '/index.php/miniapp/order/orderRecord', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776879140);
INSERT INTO `fa_miniapp_request_log` VALUES (128, 'api', 'Miniapp.order', 'orderrecord', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'POST', '/index.php/miniapp/order/orderRecord', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"-1\"}', 1776879140);
INSERT INTO `fa_miniapp_request_log` VALUES (129, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'GET', '/index.php/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879140);
INSERT INTO `fa_miniapp_request_log` VALUES (130, 'api', 'Miniapp.ctrl', 'teamall', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'POST', '/index.php/miniapp/ctrl/teamAll', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879140);
INSERT INTO `fa_miniapp_request_log` VALUES (131, 'api', 'Miniapp.my', 'indexnew', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'GET', '/index.php/miniapp/my/indexNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879140);
INSERT INTO `fa_miniapp_request_log` VALUES (132, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'GET', '/index.php/miniapp/ctrl/rechargeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879140);
INSERT INTO `fa_miniapp_request_log` VALUES (133, 'api', 'Miniapp.my', 'userinfo', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'GET', '/index.php/miniapp/my/userInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879140);
INSERT INTO `fa_miniapp_request_log` VALUES (134, 'api', 'Miniapp.my', 'caiwu', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'POST', '/index.php/miniapp/my/caiwu', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"page\":\"1\",\"size\":\"10\",\"type\":\"9\"}', 1776879140);
INSERT INTO `fa_miniapp_request_log` VALUES (135, 'api', 'Miniapp.order', 'orderrecord', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'POST', '/index.php/miniapp/order/orderRecord', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776879242);
INSERT INTO `fa_miniapp_request_log` VALUES (136, 'api', 'Miniapp.order', 'orderrecord', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'POST', '/index.php/miniapp/order/orderRecord', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"-1\"}', 1776879338);
INSERT INTO `fa_miniapp_request_log` VALUES (137, 'api', 'Miniapp.order', 'order_info', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'POST', '/index.php/miniapp/order/order_info', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"id\":\"UB2604222345101902\"}', 1776879369);
INSERT INTO `fa_miniapp_request_log` VALUES (138, 'api', 'Miniapp.order', 'do_order', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'POST', '/index.php/miniapp/order/do_order', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"oid\":\"UB2604222345101902\"}', 1776879407);
INSERT INTO `fa_miniapp_request_log` VALUES (139, 'api', 'Miniapp.rotOrder', 'submit_order', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'POST', '/index.php/miniapp/rot_order/submit_order', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '[]', 1776879447);
INSERT INTO `fa_miniapp_request_log` VALUES (140, 'api', 'Miniapp.my', 'uinfosave', '1', '1ebe74c4773f4104c87f5e79cb16045c', 10001, 'POST', '/index.php/miniapp/my/uinfoSave', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.9.1', '0.0.0.0', '{\"pwd\":\"123456\",\"pwd_new\":\"123456\"}', 1776879662);
INSERT INTO `fa_miniapp_request_log` VALUES (141, 'api', 'Miniapp.order', 'orderrecord', '1', '764d74f4a52a60988916c402f343bacb', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\"}', 1776879834);
INSERT INTO `fa_miniapp_request_log` VALUES (142, 'api', 'Miniapp.index', 'homenew', '1', '764d74f4a52a60988916c402f343bacb', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776879838);
INSERT INTO `fa_miniapp_request_log` VALUES (143, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '764d74f4a52a60988916c402f343bacb', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776879886);
INSERT INTO `fa_miniapp_request_log` VALUES (144, 'api', 'Miniapp.support', 'setlanguage', '2', '', 0, 'POST', '/miniapp/support/setLanguage?language=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"language\":\"2\"}', 1776880089);
INSERT INTO `fa_miniapp_request_log` VALUES (145, 'api', 'Miniapp.support', 'setlanguage', '2', '', 0, 'POST', '/miniapp/support/setLanguage?language=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"language\":\"2\"}', 1776880102);
INSERT INTO `fa_miniapp_request_log` VALUES (146, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '764d74f4a52a60988916c402f343bacb', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776880166);
INSERT INTO `fa_miniapp_request_log` VALUES (147, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '764d74f4a52a60988916c402f343bacb', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776880195);
INSERT INTO `fa_miniapp_request_log` VALUES (148, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776880228);
INSERT INTO `fa_miniapp_request_log` VALUES (149, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776880313);
INSERT INTO `fa_miniapp_request_log` VALUES (150, 'api', 'Miniapp.support', 'setlanguage', '1', '', 0, 'POST', '/miniapp/support/setLanguage', '*/*', '', 'multipart/form-data; boundary=--------------------------160604108543616423351223', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"language\":\"1\"}', 1776880328);
INSERT INTO `fa_miniapp_request_log` VALUES (151, 'api', 'Miniapp.support', 'setlanguage', '2', '', 0, 'POST', '/miniapp/support/setLanguage', '*/*', '', 'multipart/form-data; boundary=--------------------------147740946979811068033321', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"language\":\"2\"}', 1776880331);
INSERT INTO `fa_miniapp_request_log` VALUES (152, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776880335);
INSERT INTO `fa_miniapp_request_log` VALUES (153, 'api', 'Miniapp.order', 'orderrecord', '1', '764d74f4a52a60988916c402f343bacb', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\"}', 1776880350);
INSERT INTO `fa_miniapp_request_log` VALUES (154, 'api', 'Miniapp.user', 'logout', '1', '764d74f4a52a60988916c402f343bacb', 1, 'POST', '/miniapp/user/logout', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776880356);
INSERT INTO `fa_miniapp_request_log` VALUES (155, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------444768919212080463236518', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776920994);
INSERT INTO `fa_miniapp_request_log` VALUES (156, 'api', 'Miniapp.index', 'homenew', '1', 'dd6fd9b9f0c2a5d8bb6d69213ad08b50', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776921001);
INSERT INTO `fa_miniapp_request_log` VALUES (157, 'api', 'Miniapp.index', 'homenew', '1', 'dd6fd9b9f0c2a5d8bb6d69213ad08b50', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776921065);
INSERT INTO `fa_miniapp_request_log` VALUES (158, 'api', 'Miniapp.order', 'orderrecord', '1', 'dd6fd9b9f0c2a5d8bb6d69213ad08b50', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776921077);
INSERT INTO `fa_miniapp_request_log` VALUES (159, 'api', 'Miniapp.user', 'logout', '1', 'dd6fd9b9f0c2a5d8bb6d69213ad08b50', 1, 'POST', '/miniapp/user/logout', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776921430);
INSERT INTO `fa_miniapp_request_log` VALUES (160, 'api', 'Miniapp.user', 'do_register', '1', '', 10003, 'POST', '/miniapp/user/do_register', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"14313938451\",\"pwd\":\"123456\",\"confirmPassword\":\"123456\",\"invite_code\":\"1234\",\"area_code\":\"+86\"}', 1776924334);
INSERT INTO `fa_miniapp_request_log` VALUES (161, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------210188967140744784881784', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776924757);
INSERT INTO `fa_miniapp_request_log` VALUES (162, 'api', 'Miniapp.order', 'orderrecord', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776924785);
INSERT INTO `fa_miniapp_request_log` VALUES (163, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776924807);
INSERT INTO `fa_miniapp_request_log` VALUES (164, 'api', 'Miniapp.user', 'do_register', '1', '', 10004, 'POST', '/miniapp/user/do_register', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13113935412\",\"pwd\":\"123456\",\"confirmPassword\":\"123456\",\"invite_code\":\"1234\",\"area_code\":\"+86\"}', 1776925363);
INSERT INTO `fa_miniapp_request_log` VALUES (165, 'api', 'Miniapp.user', 'do_login', '1', '', 10004, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13113935412\",\"pwd\":\"123456\"}', 1776925374);
INSERT INTO `fa_miniapp_request_log` VALUES (166, 'api', 'Miniapp.user', 'do_login', '1', '', 10004, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13113935412\",\"pwd\":\"123456\"}', 1776925445);
INSERT INTO `fa_miniapp_request_log` VALUES (167, 'api', 'Miniapp.rotOrder', 'submit_order', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'POST', '/miniapp/rot_order/submit_order', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776925489);
INSERT INTO `fa_miniapp_request_log` VALUES (168, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776925610);
INSERT INTO `fa_miniapp_request_log` VALUES (169, 'api', 'Miniapp.user', 'do_register', '1', '', 10005, 'POST', '/miniapp/user/do_register', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.18.0', '127.0.0.1', '{\"tel\":\"13927933651\",\"pwd\":\"123456\",\"confirmPassword\":\"123456\",\"invite_code\":\"195951\",\"area_code\":\"+86\"}', 1776925696);
INSERT INTO `fa_miniapp_request_log` VALUES (170, 'api', 'Miniapp.order', 'orderrecord', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776925696);
INSERT INTO `fa_miniapp_request_log` VALUES (171, 'api', 'Miniapp.order', 'orderrecord', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776925700);
INSERT INTO `fa_miniapp_request_log` VALUES (172, 'api', 'Miniapp.order', 'orderrecord', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776925708);
INSERT INTO `fa_miniapp_request_log` VALUES (173, 'api', 'Miniapp.order', 'orderrecord', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776925711);
INSERT INTO `fa_miniapp_request_log` VALUES (174, 'api', 'Miniapp.user', 'do_login', '1', '', 10005, 'POST', '/miniapp/user/do_login', '*/*', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'curl/8.18.0', '127.0.0.1', '{\"tel\":\"13927933651\",\"pwd\":\"123456\"}', 1776925715);
INSERT INTO `fa_miniapp_request_log` VALUES (175, 'api', 'Miniapp.order', 'orderrecord', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776925718);
INSERT INTO `fa_miniapp_request_log` VALUES (176, 'api', 'Miniapp.order', 'order_info', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'GET', '/miniapp/order/order_info?id=UB2604231424493346', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604231424493346\"}', 1776925744);
INSERT INTO `fa_miniapp_request_log` VALUES (177, 'api', 'Miniapp.order', 'do_order', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'POST', '/miniapp/order/do_order', '*/*', '', 'multipart/form-data; boundary=--------------------------260244769165503793225057', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"oid\":\"UB2604231424493346\"}', 1776925762);
INSERT INTO `fa_miniapp_request_log` VALUES (178, 'api', 'Miniapp.order', 'orderrecord', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776925774);
INSERT INTO `fa_miniapp_request_log` VALUES (179, 'api', 'Miniapp.order', 'orderrecord', '1', '44ddfabfbf4fb659c4c6bb5f024cc45d', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776925781);
INSERT INTO `fa_miniapp_request_log` VALUES (180, 'api', 'Miniapp.user', 'do_login', '1', '', 10004, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13113935412\",\"pwd\":\"123456\"}', 1776925802);
INSERT INTO `fa_miniapp_request_log` VALUES (181, 'api', 'Miniapp.order', 'orderrecord', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776925863);
INSERT INTO `fa_miniapp_request_log` VALUES (182, 'api', 'Miniapp.order', 'orderrecord', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776925918);
INSERT INTO `fa_miniapp_request_log` VALUES (183, 'api', 'Miniapp.order', 'orderrecord', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776925936);
INSERT INTO `fa_miniapp_request_log` VALUES (184, 'api', 'Miniapp.order', 'orderrecord', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776925954);
INSERT INTO `fa_miniapp_request_log` VALUES (185, 'api', 'Miniapp.order', 'orderrecord', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776925959);
INSERT INTO `fa_miniapp_request_log` VALUES (186, 'api', 'Miniapp.index', 'homenew', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776925980);
INSERT INTO `fa_miniapp_request_log` VALUES (187, 'api', 'Miniapp.order', 'orderrecord', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776926002);
INSERT INTO `fa_miniapp_request_log` VALUES (188, 'api', 'Miniapp.order', 'orderrecord', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776926014);
INSERT INTO `fa_miniapp_request_log` VALUES (189, 'api', 'Miniapp.order', 'orderrecord', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776926035);
INSERT INTO `fa_miniapp_request_log` VALUES (190, 'api', 'Miniapp.order', 'orderrecord', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776926035);
INSERT INTO `fa_miniapp_request_log` VALUES (191, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776926053);
INSERT INTO `fa_miniapp_request_log` VALUES (192, 'api', 'Miniapp.order', 'orderrecord', '1', 'f9a6eaa1df011c06e5c971bd7c9d206b', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776926144);
INSERT INTO `fa_miniapp_request_log` VALUES (193, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------656886253144090186945307', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776926182);
INSERT INTO `fa_miniapp_request_log` VALUES (194, 'api', 'Miniapp.order', 'orderrecord', '1', 'b0f8ec794449c21aaba75321c1f43e09', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776926188);
INSERT INTO `fa_miniapp_request_log` VALUES (195, 'api', 'Miniapp.order', 'orderrecord', '1', 'b0f8ec794449c21aaba75321c1f43e09', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926200);
INSERT INTO `fa_miniapp_request_log` VALUES (196, 'api', 'Miniapp.order', 'orderrecord', '1', 'b0f8ec794449c21aaba75321c1f43e09', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926342);
INSERT INTO `fa_miniapp_request_log` VALUES (197, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776926430);
INSERT INTO `fa_miniapp_request_log` VALUES (198, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776926436);
INSERT INTO `fa_miniapp_request_log` VALUES (199, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926451);
INSERT INTO `fa_miniapp_request_log` VALUES (200, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926572);
INSERT INTO `fa_miniapp_request_log` VALUES (201, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926577);
INSERT INTO `fa_miniapp_request_log` VALUES (202, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926579);
INSERT INTO `fa_miniapp_request_log` VALUES (203, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926682);
INSERT INTO `fa_miniapp_request_log` VALUES (204, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926682);
INSERT INTO `fa_miniapp_request_log` VALUES (205, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926779);
INSERT INTO `fa_miniapp_request_log` VALUES (206, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776926789);
INSERT INTO `fa_miniapp_request_log` VALUES (207, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776926790);
INSERT INTO `fa_miniapp_request_log` VALUES (208, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926791);
INSERT INTO `fa_miniapp_request_log` VALUES (209, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926800);
INSERT INTO `fa_miniapp_request_log` VALUES (210, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776926800);
INSERT INTO `fa_miniapp_request_log` VALUES (211, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776926820);
INSERT INTO `fa_miniapp_request_log` VALUES (212, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776926820);
INSERT INTO `fa_miniapp_request_log` VALUES (213, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776926823);
INSERT INTO `fa_miniapp_request_log` VALUES (214, 'api', 'Miniapp.ctrl', 'teamall', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776926857);
INSERT INTO `fa_miniapp_request_log` VALUES (215, 'api', 'Miniapp.index', 'homenew', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776927020);
INSERT INTO `fa_miniapp_request_log` VALUES (216, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776927041);
INSERT INTO `fa_miniapp_request_log` VALUES (217, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776927140);
INSERT INTO `fa_miniapp_request_log` VALUES (218, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776927140);
INSERT INTO `fa_miniapp_request_log` VALUES (219, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776927156);
INSERT INTO `fa_miniapp_request_log` VALUES (220, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776927156);
INSERT INTO `fa_miniapp_request_log` VALUES (221, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927374);
INSERT INTO `fa_miniapp_request_log` VALUES (222, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927399);
INSERT INTO `fa_miniapp_request_log` VALUES (223, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927400);
INSERT INTO `fa_miniapp_request_log` VALUES (224, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927493);
INSERT INTO `fa_miniapp_request_log` VALUES (225, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927552);
INSERT INTO `fa_miniapp_request_log` VALUES (226, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927589);
INSERT INTO `fa_miniapp_request_log` VALUES (227, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927591);
INSERT INTO `fa_miniapp_request_log` VALUES (228, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776927599);
INSERT INTO `fa_miniapp_request_log` VALUES (229, 'api', 'Miniapp.ctrl', 'teamall', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776927663);
INSERT INTO `fa_miniapp_request_log` VALUES (230, 'api', 'Miniapp.index', 'homenew', '1', '1adee7ec3b5784bc696fce050d73abd5', 10004, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776927690);
INSERT INTO `fa_miniapp_request_log` VALUES (231, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776927723);
INSERT INTO `fa_miniapp_request_log` VALUES (232, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776927771);
INSERT INTO `fa_miniapp_request_log` VALUES (233, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927773);
INSERT INTO `fa_miniapp_request_log` VALUES (234, 'api', 'Miniapp.my', 'userinfo', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/userInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776927790);
INSERT INTO `fa_miniapp_request_log` VALUES (235, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927795);
INSERT INTO `fa_miniapp_request_log` VALUES (236, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927905);
INSERT INTO `fa_miniapp_request_log` VALUES (237, 'api', 'Miniapp.ctrl', 'teamall', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927922);
INSERT INTO `fa_miniapp_request_log` VALUES (238, 'api', 'Miniapp.ctrl', 'teamall', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927977);
INSERT INTO `fa_miniapp_request_log` VALUES (239, 'api', 'Miniapp.my', 'userinfo', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/userInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776927978);
INSERT INTO `fa_miniapp_request_log` VALUES (240, 'api', 'Miniapp.my', 'userinfo', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/userInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776928001);
INSERT INTO `fa_miniapp_request_log` VALUES (241, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776928149);
INSERT INTO `fa_miniapp_request_log` VALUES (242, 'api', 'Miniapp.my', 'userinfo', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/userInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776928149);
INSERT INTO `fa_miniapp_request_log` VALUES (243, 'api', 'Miniapp.my', 'userinfo', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/userInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776928166);
INSERT INTO `fa_miniapp_request_log` VALUES (244, 'api', 'Miniapp.my', 'userinfo', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/userInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776931658);
INSERT INTO `fa_miniapp_request_log` VALUES (245, 'api', 'Miniapp.my', 'setcashpwd', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/my/setCashPwd', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"pwd\":\"123456\",\"pwd_new\":\"asd12345\",\"pwd_new_confirm\":\"asd12345\"}', 1776931707);
INSERT INTO `fa_miniapp_request_log` VALUES (246, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776931718);
INSERT INTO `fa_miniapp_request_log` VALUES (247, 'api', 'Miniapp.my', 'caiwu', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/caiwu?page=1&size=10&type=9', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"type\":\"9\"}', 1776931769);
INSERT INTO `fa_miniapp_request_log` VALUES (248, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776933799);
INSERT INTO `fa_miniapp_request_log` VALUES (249, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776934669);
INSERT INTO `fa_miniapp_request_log` VALUES (250, 'api', 'Miniapp.ctrl', 'teamall', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776934747);
INSERT INTO `fa_miniapp_request_log` VALUES (251, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776934784);
INSERT INTO `fa_miniapp_request_log` VALUES (252, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776934791);
INSERT INTO `fa_miniapp_request_log` VALUES (253, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776934792);
INSERT INTO `fa_miniapp_request_log` VALUES (254, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776934794);
INSERT INTO `fa_miniapp_request_log` VALUES (255, 'api', 'Miniapp.my', 'indexnew', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776934794);
INSERT INTO `fa_miniapp_request_log` VALUES (256, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776934796);
INSERT INTO `fa_miniapp_request_log` VALUES (257, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776934798);
INSERT INTO `fa_miniapp_request_log` VALUES (258, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776934799);
INSERT INTO `fa_miniapp_request_log` VALUES (259, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776934800);
INSERT INTO `fa_miniapp_request_log` VALUES (260, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776934800);
INSERT INTO `fa_miniapp_request_log` VALUES (261, 'api', 'Miniapp.order', 'orderrecord', '1', '152aba669f6d7bc12edb9496faa05803', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776934801);
INSERT INTO `fa_miniapp_request_log` VALUES (262, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------235301235525996430292593', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776935256);
INSERT INTO `fa_miniapp_request_log` VALUES (263, 'api', 'Miniapp.order', 'orderrecord', '1', 'a4b6d6c388662163aacb7967ae2b8faa', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776935259);
INSERT INTO `fa_miniapp_request_log` VALUES (264, 'api', 'Miniapp.order', 'orderrecord', '1', 'a4b6d6c388662163aacb7967ae2b8faa', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1776935264);
INSERT INTO `fa_miniapp_request_log` VALUES (265, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'a4b6d6c388662163aacb7967ae2b8faa', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776935546);
INSERT INTO `fa_miniapp_request_log` VALUES (266, 'api', 'Miniapp.order', 'order_info', '1', 'a4b6d6c388662163aacb7967ae2b8faa', 1, 'GET', '/miniapp/order/order_info?id=UB2604231424493346', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604231424493346\"}', 1776935554);
INSERT INTO `fa_miniapp_request_log` VALUES (267, 'api', 'Miniapp.order', 'order_info', '1', 'a4b6d6c388662163aacb7967ae2b8faa', 1, 'GET', '/miniapp/order/order_info?id=UB2604231424493346', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604231424493346\"}', 1776935931);
INSERT INTO `fa_miniapp_request_log` VALUES (268, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------939118235307466882434385', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776935959);
INSERT INTO `fa_miniapp_request_log` VALUES (269, 'api', 'Miniapp.ctrl', 'teamall', '1', '6f720b25b546b2c3844b660fb6568340', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776935975);
INSERT INTO `fa_miniapp_request_log` VALUES (270, 'api', 'Miniapp.order', 'orderrecord', '1', '6f720b25b546b2c3844b660fb6568340', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776936155);
INSERT INTO `fa_miniapp_request_log` VALUES (271, 'api', 'Miniapp.index', 'homenew', '1', '6f720b25b546b2c3844b660fb6568340', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776936662);
INSERT INTO `fa_miniapp_request_log` VALUES (272, 'api', 'Miniapp.index', 'homenew', '1', '6f720b25b546b2c3844b660fb6568340', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776937778);
INSERT INTO `fa_miniapp_request_log` VALUES (273, 'api', 'Miniapp.user', 'do_login', '1', '', 10001, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------432497429562354899463864', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13800000001\",\"pwd\":\"123456\"}', 1776938241);
INSERT INTO `fa_miniapp_request_log` VALUES (274, 'api', 'Miniapp.order', 'orderrecord', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776938253);
INSERT INTO `fa_miniapp_request_log` VALUES (275, 'api', 'Miniapp.ctrl', 'teamall', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/ctrl/teamAll', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776938277);
INSERT INTO `fa_miniapp_request_log` VALUES (276, 'api', 'Miniapp.order', 'orderrecord', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776938297);
INSERT INTO `fa_miniapp_request_log` VALUES (277, 'api', 'Miniapp.order', 'orderrecord', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776938330);
INSERT INTO `fa_miniapp_request_log` VALUES (278, 'api', 'Miniapp.order', 'orderrecord', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1776938407);
INSERT INTO `fa_miniapp_request_log` VALUES (279, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776942283);
INSERT INTO `fa_miniapp_request_log` VALUES (280, 'api', 'Miniapp.order', 'order_info', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/order/order_info?id=UB2604231424493346', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604231424493346\"}', 1776942300);
INSERT INTO `fa_miniapp_request_log` VALUES (281, 'api', 'Miniapp.order', 'orderrecord', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776942344);
INSERT INTO `fa_miniapp_request_log` VALUES (282, 'api', 'Miniapp.order', 'orderrecord', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1776943547);
INSERT INTO `fa_miniapp_request_log` VALUES (283, 'api', 'Miniapp.ctrl', 'teamall', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776943609);
INSERT INTO `fa_miniapp_request_log` VALUES (284, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776943615);
INSERT INTO `fa_miniapp_request_log` VALUES (285, 'api', 'Miniapp.my', 'caiwu', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/caiwu?page=1&size=10&type=9', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"type\":\"9\"}', 1776943769);
INSERT INTO `fa_miniapp_request_log` VALUES (286, 'api', 'Miniapp.my', 'caiwu', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/caiwu?page=1&size=10&type=9', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"type\":\"9\"}', 1776943797);
INSERT INTO `fa_miniapp_request_log` VALUES (287, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776943808);
INSERT INTO `fa_miniapp_request_log` VALUES (288, 'api', 'Miniapp.my', 'caiwu', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/caiwu?page=1&size=10&type=1', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"type\":\"1\"}', 1776943810);
INSERT INTO `fa_miniapp_request_log` VALUES (289, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776943817);
INSERT INTO `fa_miniapp_request_log` VALUES (290, 'api', 'Miniapp.my', 'caiwu', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/caiwu?page=1&size=10&type=7', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"type\":\"7\"}', 1776943819);
INSERT INTO `fa_miniapp_request_log` VALUES (291, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776943824);
INSERT INTO `fa_miniapp_request_log` VALUES (292, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776943834);
INSERT INTO `fa_miniapp_request_log` VALUES (293, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776943840);
INSERT INTO `fa_miniapp_request_log` VALUES (294, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776943846);
INSERT INTO `fa_miniapp_request_log` VALUES (295, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776943852);
INSERT INTO `fa_miniapp_request_log` VALUES (296, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944070);
INSERT INTO `fa_miniapp_request_log` VALUES (297, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776944081);
INSERT INTO `fa_miniapp_request_log` VALUES (298, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944091);
INSERT INTO `fa_miniapp_request_log` VALUES (299, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944201);
INSERT INTO `fa_miniapp_request_log` VALUES (300, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944217);
INSERT INTO `fa_miniapp_request_log` VALUES (301, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944254);
INSERT INTO `fa_miniapp_request_log` VALUES (302, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944256);
INSERT INTO `fa_miniapp_request_log` VALUES (303, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944273);
INSERT INTO `fa_miniapp_request_log` VALUES (304, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944280);
INSERT INTO `fa_miniapp_request_log` VALUES (305, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944284);
INSERT INTO `fa_miniapp_request_log` VALUES (306, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944502);
INSERT INTO `fa_miniapp_request_log` VALUES (307, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944503);
INSERT INTO `fa_miniapp_request_log` VALUES (308, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944505);
INSERT INTO `fa_miniapp_request_log` VALUES (309, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944508);
INSERT INTO `fa_miniapp_request_log` VALUES (310, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944513);
INSERT INTO `fa_miniapp_request_log` VALUES (311, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944549);
INSERT INTO `fa_miniapp_request_log` VALUES (312, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944550);
INSERT INTO `fa_miniapp_request_log` VALUES (313, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944709);
INSERT INTO `fa_miniapp_request_log` VALUES (314, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944726);
INSERT INTO `fa_miniapp_request_log` VALUES (315, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944775);
INSERT INTO `fa_miniapp_request_log` VALUES (316, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944781);
INSERT INTO `fa_miniapp_request_log` VALUES (317, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944799);
INSERT INTO `fa_miniapp_request_log` VALUES (318, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944817);
INSERT INTO `fa_miniapp_request_log` VALUES (319, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776944940);
INSERT INTO `fa_miniapp_request_log` VALUES (320, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776945666);
INSERT INTO `fa_miniapp_request_log` VALUES (321, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776945734);
INSERT INTO `fa_miniapp_request_log` VALUES (322, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776945773);
INSERT INTO `fa_miniapp_request_log` VALUES (323, 'api', 'Miniapp.my', 'indexnew', '1', '1e5ad34ea45d6583f39dfafb6ec68e28', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776945885);
INSERT INTO `fa_miniapp_request_log` VALUES (324, 'api', 'Miniapp.index', 'homenew', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776947982);
INSERT INTO `fa_miniapp_request_log` VALUES (325, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776948253);
INSERT INTO `fa_miniapp_request_log` VALUES (326, 'api', 'Miniapp.order', 'order_info', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/order/order_info?id=SEED240423U10001C01', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"SEED240423U10001C01\"}', 1776948285);
INSERT INTO `fa_miniapp_request_log` VALUES (327, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776995258);
INSERT INTO `fa_miniapp_request_log` VALUES (328, 'api', 'Miniapp.my', 'indexnew', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776995276);
INSERT INTO `fa_miniapp_request_log` VALUES (329, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1776995350);
INSERT INTO `fa_miniapp_request_log` VALUES (330, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776996157);
INSERT INTO `fa_miniapp_request_log` VALUES (331, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776996279);
INSERT INTO `fa_miniapp_request_log` VALUES (332, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776996863);
INSERT INTO `fa_miniapp_request_log` VALUES (333, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776996944);
INSERT INTO `fa_miniapp_request_log` VALUES (334, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997052);
INSERT INTO `fa_miniapp_request_log` VALUES (335, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997094);
INSERT INTO `fa_miniapp_request_log` VALUES (336, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997310);
INSERT INTO `fa_miniapp_request_log` VALUES (337, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997325);
INSERT INTO `fa_miniapp_request_log` VALUES (338, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997334);
INSERT INTO `fa_miniapp_request_log` VALUES (339, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997344);
INSERT INTO `fa_miniapp_request_log` VALUES (340, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997359);
INSERT INTO `fa_miniapp_request_log` VALUES (341, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997369);
INSERT INTO `fa_miniapp_request_log` VALUES (342, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997397);
INSERT INTO `fa_miniapp_request_log` VALUES (343, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997548);
INSERT INTO `fa_miniapp_request_log` VALUES (344, 'api', 'Miniapp.ctrl', 'teamall', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997560);
INSERT INTO `fa_miniapp_request_log` VALUES (345, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997561);
INSERT INTO `fa_miniapp_request_log` VALUES (346, 'api', 'Miniapp.my', 'indexnew', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997563);
INSERT INTO `fa_miniapp_request_log` VALUES (347, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776997568);
INSERT INTO `fa_miniapp_request_log` VALUES (348, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776998041);
INSERT INTO `fa_miniapp_request_log` VALUES (349, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999216);
INSERT INTO `fa_miniapp_request_log` VALUES (350, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999239);
INSERT INTO `fa_miniapp_request_log` VALUES (351, 'api', 'Miniapp.ctrl', 'teamall', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999244);
INSERT INTO `fa_miniapp_request_log` VALUES (352, 'api', 'Miniapp.my', 'indexnew', '1', 'de925872838d822062fe11f2ada00a0c', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999244);
INSERT INTO `fa_miniapp_request_log` VALUES (353, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776999326);
INSERT INTO `fa_miniapp_request_log` VALUES (354, 'api', 'Miniapp.my', 'indexnew', '1', '934913d42174f035ad87c259c35d4910', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999330);
INSERT INTO `fa_miniapp_request_log` VALUES (355, 'api', 'Miniapp.user', 'logout', '1', '934913d42174f035ad87c259c35d4910', 1, 'POST', '/miniapp/user/logout', '*/*', 'zh-CN,zh;q=0.9', 'application/json', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999372);
INSERT INTO `fa_miniapp_request_log` VALUES (356, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1776999641);
INSERT INTO `fa_miniapp_request_log` VALUES (357, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999646);
INSERT INTO `fa_miniapp_request_log` VALUES (358, 'api', 'Miniapp.ctrl', 'teamall', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999648);
INSERT INTO `fa_miniapp_request_log` VALUES (359, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999649);
INSERT INTO `fa_miniapp_request_log` VALUES (360, 'api', 'Miniapp.ctrl', 'teamall', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999649);
INSERT INTO `fa_miniapp_request_log` VALUES (361, 'api', 'Miniapp.my', 'indexnew', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999650);
INSERT INTO `fa_miniapp_request_log` VALUES (362, 'api', 'Miniapp.my', 'caiwu', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/my/caiwu?page=1&size=10&type=7', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"type\":\"7\"}', 1776999652);
INSERT INTO `fa_miniapp_request_log` VALUES (363, 'api', 'Miniapp.my', 'indexnew', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999653);
INSERT INTO `fa_miniapp_request_log` VALUES (364, 'api', 'Miniapp.my', 'caiwu', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/my/caiwu?page=1&size=10&type=1', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"type\":\"1\"}', 1776999654);
INSERT INTO `fa_miniapp_request_log` VALUES (365, 'api', 'Miniapp.my', 'indexnew', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999655);
INSERT INTO `fa_miniapp_request_log` VALUES (366, 'api', 'Miniapp.my', 'userinfo', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/my/userInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999659);
INSERT INTO `fa_miniapp_request_log` VALUES (367, 'api', 'Miniapp.my', 'indexnew', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999662);
INSERT INTO `fa_miniapp_request_log` VALUES (368, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999663);
INSERT INTO `fa_miniapp_request_log` VALUES (369, 'api', 'Miniapp.my', 'indexnew', '1', '3582ba80793b91ef50098012faceae36', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1776999666);
INSERT INTO `fa_miniapp_request_log` VALUES (370, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1777011094);
INSERT INTO `fa_miniapp_request_log` VALUES (371, 'api', 'Miniapp.index', 'homenew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777011466);
INSERT INTO `fa_miniapp_request_log` VALUES (372, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777012248);
INSERT INTO `fa_miniapp_request_log` VALUES (373, 'api', 'Miniapp.index', 'homenew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/index/homeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777012327);
INSERT INTO `fa_miniapp_request_log` VALUES (374, 'api', 'Miniapp.index', 'homenew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/index/homeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777012396);
INSERT INTO `fa_miniapp_request_log` VALUES (375, 'api', 'Miniapp.my', 'indexnew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777012431);
INSERT INTO `fa_miniapp_request_log` VALUES (376, 'api', 'Miniapp.my', 'indexnew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777012629);
INSERT INTO `fa_miniapp_request_log` VALUES (377, 'api', 'Miniapp.my', 'indexnew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014179);
INSERT INTO `fa_miniapp_request_log` VALUES (378, 'api', 'Miniapp.my', 'userinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/my/userInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014200);
INSERT INTO `fa_miniapp_request_log` VALUES (379, 'api', 'Miniapp.my', 'indexnew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014202);
INSERT INTO `fa_miniapp_request_log` VALUES (380, 'api', 'Miniapp.my', 'caiwu', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/my/caiwu?page=1&size=10&type=1', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"type\":\"1\"}', 1777014203);
INSERT INTO `fa_miniapp_request_log` VALUES (381, 'api', 'Miniapp.my', 'indexnew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014207);
INSERT INTO `fa_miniapp_request_log` VALUES (382, 'api', 'Miniapp.my', 'caiwu', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/my/caiwu?page=1&size=10&type=9', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"type\":\"9\"}', 1777014432);
INSERT INTO `fa_miniapp_request_log` VALUES (383, 'api', 'Miniapp.my', 'indexnew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014435);
INSERT INTO `fa_miniapp_request_log` VALUES (384, 'api', 'Miniapp.index', 'homenew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/index/homeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014437);
INSERT INTO `fa_miniapp_request_log` VALUES (385, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1777014445);
INSERT INTO `fa_miniapp_request_log` VALUES (386, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1777014462);
INSERT INTO `fa_miniapp_request_log` VALUES (387, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1777014469);
INSERT INTO `fa_miniapp_request_log` VALUES (388, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1777014471);
INSERT INTO `fa_miniapp_request_log` VALUES (389, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777014496);
INSERT INTO `fa_miniapp_request_log` VALUES (390, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777014500);
INSERT INTO `fa_miniapp_request_log` VALUES (391, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777014502);
INSERT INTO `fa_miniapp_request_log` VALUES (392, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777014507);
INSERT INTO `fa_miniapp_request_log` VALUES (393, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777014509);
INSERT INTO `fa_miniapp_request_log` VALUES (394, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777014512);
INSERT INTO `fa_miniapp_request_log` VALUES (395, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777014542);
INSERT INTO `fa_miniapp_request_log` VALUES (396, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777014548);
INSERT INTO `fa_miniapp_request_log` VALUES (397, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777014552);
INSERT INTO `fa_miniapp_request_log` VALUES (398, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777014556);
INSERT INTO `fa_miniapp_request_log` VALUES (399, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777014563);
INSERT INTO `fa_miniapp_request_log` VALUES (400, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014565);
INSERT INTO `fa_miniapp_request_log` VALUES (401, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014592);
INSERT INTO `fa_miniapp_request_log` VALUES (402, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014773);
INSERT INTO `fa_miniapp_request_log` VALUES (403, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014775);
INSERT INTO `fa_miniapp_request_log` VALUES (404, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014780);
INSERT INTO `fa_miniapp_request_log` VALUES (405, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014791);
INSERT INTO `fa_miniapp_request_log` VALUES (406, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014806);
INSERT INTO `fa_miniapp_request_log` VALUES (407, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014816);
INSERT INTO `fa_miniapp_request_log` VALUES (408, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014836);
INSERT INTO `fa_miniapp_request_log` VALUES (409, 'api', 'Miniapp.order', 'orderrecord', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777014852);
INSERT INTO `fa_miniapp_request_log` VALUES (410, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777014875);
INSERT INTO `fa_miniapp_request_log` VALUES (411, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777015430);
INSERT INTO `fa_miniapp_request_log` VALUES (412, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777015442);
INSERT INTO `fa_miniapp_request_log` VALUES (413, 'api', 'Miniapp.order', 'orderrecord', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777015856);
INSERT INTO `fa_miniapp_request_log` VALUES (414, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777015861);
INSERT INTO `fa_miniapp_request_log` VALUES (415, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777015894);
INSERT INTO `fa_miniapp_request_log` VALUES (416, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1C01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1C01\"}', 1777015894);
INSERT INTO `fa_miniapp_request_log` VALUES (417, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777015920);
INSERT INTO `fa_miniapp_request_log` VALUES (418, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1C01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1C01\"}', 1777015921);
INSERT INTO `fa_miniapp_request_log` VALUES (419, 'api', 'Miniapp.order', 'order_info', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/order/order_info?id=SEED240423U10001C01', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"SEED240423U10001C01\"}', 1777018223);
INSERT INTO `fa_miniapp_request_log` VALUES (420, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777018793);
INSERT INTO `fa_miniapp_request_log` VALUES (421, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1C01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1C01\"}', 1777018793);
INSERT INTO `fa_miniapp_request_log` VALUES (422, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777018800);
INSERT INTO `fa_miniapp_request_log` VALUES (423, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777018960);
INSERT INTO `fa_miniapp_request_log` VALUES (424, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1C01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1C01\"}', 1777018960);
INSERT INTO `fa_miniapp_request_log` VALUES (425, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777018994);
INSERT INTO `fa_miniapp_request_log` VALUES (426, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '44969509e5d8e408c274e5bb8294a1d5', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019009);
INSERT INTO `fa_miniapp_request_log` VALUES (427, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777019305);
INSERT INTO `fa_miniapp_request_log` VALUES (428, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1C01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1C01\"}', 1777019306);
INSERT INTO `fa_miniapp_request_log` VALUES (429, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777019325);
INSERT INTO `fa_miniapp_request_log` VALUES (430, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1C01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1C01\"}', 1777019326);
INSERT INTO `fa_miniapp_request_log` VALUES (431, 'api', 'Miniapp.user', 'do_login', '1', '', 10001, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------984262851984143139169662', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13800000001\",\"pwd\":\"123456\"}', 1777019422);
INSERT INTO `fa_miniapp_request_log` VALUES (432, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019428);
INSERT INTO `fa_miniapp_request_log` VALUES (433, 'api', 'Miniapp.order', 'do_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/order/do_order', '*/*', '', 'multipart/form-data; boundary=--------------------------475033063104490250264048', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"oid\":\"SEED240423U10001C01\"}', 1777019525);
INSERT INTO `fa_miniapp_request_log` VALUES (434, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777019548);
INSERT INTO `fa_miniapp_request_log` VALUES (435, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019639);
INSERT INTO `fa_miniapp_request_log` VALUES (436, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777019679);
INSERT INTO `fa_miniapp_request_log` VALUES (437, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1C01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1C01\"}', 1777019680);
INSERT INTO `fa_miniapp_request_log` VALUES (438, 'api', 'Miniapp.order', 'do_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/order/do_order', '*/*', '', 'multipart/form-data; boundary=--------------------------561511096296313061548956', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"oid\":\"SEED240423U10001B02\"}', 1777019684);
INSERT INTO `fa_miniapp_request_log` VALUES (439, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019690);
INSERT INTO `fa_miniapp_request_log` VALUES (440, 'api', 'Miniapp.order', 'do_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/order/do_order', '*/*', '', 'multipart/form-data; boundary=--------------------------716916058346990614898257', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"oid\":\"SEED240423U10001B01\"}', 1777019702);
INSERT INTO `fa_miniapp_request_log` VALUES (441, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019708);
INSERT INTO `fa_miniapp_request_log` VALUES (442, 'api', 'Miniapp.order', 'do_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/order/do_order', '*/*', '', 'multipart/form-data; boundary=--------------------------114258778012279639405041', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"oid\":\"UB2604230137272402\"}', 1777019719);
INSERT INTO `fa_miniapp_request_log` VALUES (443, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019724);
INSERT INTO `fa_miniapp_request_log` VALUES (444, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019743);
INSERT INTO `fa_miniapp_request_log` VALUES (445, 'api', 'Miniapp.rotOrder', 'submit_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/rot_order/submit_order', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019751);
INSERT INTO `fa_miniapp_request_log` VALUES (446, 'api', 'Miniapp.order', 'do_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/order/do_order', '*/*', '', 'multipart/form-data; boundary=--------------------------199440337933581579109108', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"oid\":\"UB2604241635518905\"}', 1777019759);
INSERT INTO `fa_miniapp_request_log` VALUES (447, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019766);
INSERT INTO `fa_miniapp_request_log` VALUES (448, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777019874);
INSERT INTO `fa_miniapp_request_log` VALUES (449, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1C01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1C01\"}', 1777019875);
INSERT INTO `fa_miniapp_request_log` VALUES (450, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777019900);
INSERT INTO `fa_miniapp_request_log` VALUES (451, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1C01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1C01\"}', 1777019900);
INSERT INTO `fa_miniapp_request_log` VALUES (452, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019959);
INSERT INTO `fa_miniapp_request_log` VALUES (453, 'api', 'Miniapp.rotOrder', 'submit_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/rot_order/submit_order', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019973);
INSERT INTO `fa_miniapp_request_log` VALUES (454, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019988);
INSERT INTO `fa_miniapp_request_log` VALUES (455, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777019994);
INSERT INTO `fa_miniapp_request_log` VALUES (456, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777020009);
INSERT INTO `fa_miniapp_request_log` VALUES (457, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1C01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1C01\"}', 1777020010);
INSERT INTO `fa_miniapp_request_log` VALUES (458, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777020033);
INSERT INTO `fa_miniapp_request_log` VALUES (459, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1C01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1C01\"}', 1777020033);
INSERT INTO `fa_miniapp_request_log` VALUES (460, 'api', 'Miniapp.order', 'do_order', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/do_order', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"oid\":\"SEED240423U1C01\"}', 1777020037);
INSERT INTO `fa_miniapp_request_log` VALUES (461, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777020037);
INSERT INTO `fa_miniapp_request_log` VALUES (462, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1B02', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1B02\"}', 1777020037);
INSERT INTO `fa_miniapp_request_log` VALUES (463, 'api', 'Miniapp.order', 'do_order', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/do_order', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"oid\":\"SEED240423U1B02\"}', 1777020047);
INSERT INTO `fa_miniapp_request_log` VALUES (464, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777020047);
INSERT INTO `fa_miniapp_request_log` VALUES (465, 'api', 'Miniapp.order', 'order_info', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/order/order_info?id=SEED240423U1B01', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"id\":\"SEED240423U1B01\"}', 1777020048);
INSERT INTO `fa_miniapp_request_log` VALUES (466, 'api', 'Miniapp.ctrl', 'teamall', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777020055);
INSERT INTO `fa_miniapp_request_log` VALUES (467, 'api', 'Miniapp.my', 'indexnew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777020057);
INSERT INTO `fa_miniapp_request_log` VALUES (468, 'api', 'Miniapp.ctrl', 'teamall', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777020057);
INSERT INTO `fa_miniapp_request_log` VALUES (469, 'api', 'Miniapp.my', 'indexnew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777020058);
INSERT INTO `fa_miniapp_request_log` VALUES (470, 'api', 'Miniapp.ctrl', 'teamall', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777020059);
INSERT INTO `fa_miniapp_request_log` VALUES (471, 'api', 'Miniapp.index', 'homenew', '1', '74015d77689981b2617d1ba99583835c', 1, 'GET', '/miniapp/index/homeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777020060);
INSERT INTO `fa_miniapp_request_log` VALUES (472, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777020064);
INSERT INTO `fa_miniapp_request_log` VALUES (473, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777020070);
INSERT INTO `fa_miniapp_request_log` VALUES (474, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777020086);
INSERT INTO `fa_miniapp_request_log` VALUES (475, 'api', 'Miniapp.order', 'order_info', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/order_info?id=SEED240423U10001C01', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"SEED240423U10001C01\"}', 1777020281);
INSERT INTO `fa_miniapp_request_log` VALUES (476, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777020360);
INSERT INTO `fa_miniapp_request_log` VALUES (477, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777020529);
INSERT INTO `fa_miniapp_request_log` VALUES (478, 'api', 'Miniapp.order', 'order_info', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/order_info?id=SEED240423U10001C01', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"SEED240423U10001C01\"}', 1777020533);
INSERT INTO `fa_miniapp_request_log` VALUES (479, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777020544);
INSERT INTO `fa_miniapp_request_log` VALUES (480, 'api', 'Miniapp.rotOrder', 'submit_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/rot_order/submit_order', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777020558);
INSERT INTO `fa_miniapp_request_log` VALUES (481, 'api', 'Miniapp.rotOrder', 'submit_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/rot_order/submit_order', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777020566);
INSERT INTO `fa_miniapp_request_log` VALUES (482, 'api', 'Miniapp.order', 'order_info', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/order_info?id=SEED240423U10001C01', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"SEED240423U10001C01\"}', 1777020714);
INSERT INTO `fa_miniapp_request_log` VALUES (483, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777020935);
INSERT INTO `fa_miniapp_request_log` VALUES (484, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=2&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"2\",\"size\":\"10\",\"status\":\"2\"}', 1777020982);
INSERT INTO `fa_miniapp_request_log` VALUES (485, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=2&size=10&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"2\",\"size\":\"10\",\"status\":\"1\"}', 1777021000);
INSERT INTO `fa_miniapp_request_log` VALUES (486, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777021004);
INSERT INTO `fa_miniapp_request_log` VALUES (487, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777021008);
INSERT INTO `fa_miniapp_request_log` VALUES (488, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777021358);
INSERT INTO `fa_miniapp_request_log` VALUES (489, 'api', 'Miniapp.order', 'order_info', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/order_info?id=SEED240423U10001C01', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"SEED240423U10001C01\"}', 1777021413);
INSERT INTO `fa_miniapp_request_log` VALUES (490, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777021420);
INSERT INTO `fa_miniapp_request_log` VALUES (491, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777021441);
INSERT INTO `fa_miniapp_request_log` VALUES (492, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777021559);
INSERT INTO `fa_miniapp_request_log` VALUES (493, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777021668);
INSERT INTO `fa_miniapp_request_log` VALUES (494, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777021685);
INSERT INTO `fa_miniapp_request_log` VALUES (495, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777021702);
INSERT INTO `fa_miniapp_request_log` VALUES (496, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777021717);
INSERT INTO `fa_miniapp_request_log` VALUES (497, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777021720);
INSERT INTO `fa_miniapp_request_log` VALUES (498, 'api', 'Miniapp.rotOrder', 'submit_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/rot_order/submit_order', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777021730);
INSERT INTO `fa_miniapp_request_log` VALUES (499, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777021745);
INSERT INTO `fa_miniapp_request_log` VALUES (500, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777021978);
INSERT INTO `fa_miniapp_request_log` VALUES (501, 'api', 'Miniapp.order', 'do_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/order/do_order', '*/*', '', 'multipart/form-data; boundary=--------------------------062372006039246066983082', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"oid\":\"UB2604241708502055\"}', 1777022107);
INSERT INTO `fa_miniapp_request_log` VALUES (502, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777022117);
INSERT INTO `fa_miniapp_request_log` VALUES (503, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777022138);
INSERT INTO `fa_miniapp_request_log` VALUES (504, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777022170);
INSERT INTO `fa_miniapp_request_log` VALUES (505, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777022223);
INSERT INTO `fa_miniapp_request_log` VALUES (506, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777022228);
INSERT INTO `fa_miniapp_request_log` VALUES (507, 'api', 'Miniapp.rotOrder', 'submit_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/rot_order/submit_order', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777022276);
INSERT INTO `fa_miniapp_request_log` VALUES (508, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777022290);
INSERT INTO `fa_miniapp_request_log` VALUES (509, 'api', 'Miniapp.order', 'order_info', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/order_info?id=UB2604241717562711', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604241717562711\"}', 1777022307);
INSERT INTO `fa_miniapp_request_log` VALUES (510, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777022313);
INSERT INTO `fa_miniapp_request_log` VALUES (511, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777022321);
INSERT INTO `fa_miniapp_request_log` VALUES (512, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777022334);
INSERT INTO `fa_miniapp_request_log` VALUES (513, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777022369);
INSERT INTO `fa_miniapp_request_log` VALUES (514, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1777022406);
INSERT INTO `fa_miniapp_request_log` VALUES (515, 'api', 'Miniapp.order', 'orderrecord', '1', '74015d77689981b2617d1ba99583835c', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777022479);
INSERT INTO `fa_miniapp_request_log` VALUES (516, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1777022556);
INSERT INTO `fa_miniapp_request_log` VALUES (517, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777022564);
INSERT INTO `fa_miniapp_request_log` VALUES (518, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1777022607);
INSERT INTO `fa_miniapp_request_log` VALUES (519, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777022609);
INSERT INTO `fa_miniapp_request_log` VALUES (520, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777022701);
INSERT INTO `fa_miniapp_request_log` VALUES (521, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777022728);
INSERT INTO `fa_miniapp_request_log` VALUES (522, 'api', 'Miniapp.rotOrder', 'submit_order', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'POST', '/miniapp/rot_order/submit_order', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777022777);
INSERT INTO `fa_miniapp_request_log` VALUES (523, 'api', 'Miniapp.order', 'order_info', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/order_info?id=UB2604241726178571', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604241726178571\"}', 1777022786);
INSERT INTO `fa_miniapp_request_log` VALUES (524, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777022809);
INSERT INTO `fa_miniapp_request_log` VALUES (525, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777022865);
INSERT INTO `fa_miniapp_request_log` VALUES (526, 'api', 'Miniapp.order', 'order_info', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/order_info?id=UB2604241726178571', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604241726178571\"}', 1777022896);
INSERT INTO `fa_miniapp_request_log` VALUES (527, 'api', 'Miniapp.order', 'orderrecord', '1', '9107fefdd3470aa1370e2f2815df9665', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777022909);
INSERT INTO `fa_miniapp_request_log` VALUES (528, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------313951391409035857330773', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1777022986);
INSERT INTO `fa_miniapp_request_log` VALUES (529, 'api', 'Miniapp.order', 'orderrecord', '1', '5a3d28629d723ebd6c518aa9df28ad7c', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777022993);
INSERT INTO `fa_miniapp_request_log` VALUES (530, 'api', 'Miniapp.order', 'do_order', '1', '5a3d28629d723ebd6c518aa9df28ad7c', 1, 'POST', '/miniapp/order/do_order', '*/*', '', 'multipart/form-data; boundary=--------------------------179969613338145599392096', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"oid\":\"SEED240423U1B01\"}', 1777023007);
INSERT INTO `fa_miniapp_request_log` VALUES (531, 'api', 'Miniapp.order', 'orderrecord', '1', '5a3d28629d723ebd6c518aa9df28ad7c', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777023027);
INSERT INTO `fa_miniapp_request_log` VALUES (532, 'api', 'Miniapp.order', 'orderrecord', '1', '5a3d28629d723ebd6c518aa9df28ad7c', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777023033);
INSERT INTO `fa_miniapp_request_log` VALUES (533, 'api', 'Miniapp.order', 'orderrecord', '1', '5a3d28629d723ebd6c518aa9df28ad7c', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777023040);
INSERT INTO `fa_miniapp_request_log` VALUES (534, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '5a3d28629d723ebd6c518aa9df28ad7c', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777023080);
INSERT INTO `fa_miniapp_request_log` VALUES (535, 'api', 'Miniapp.order', 'orderrecord', '1', '5a3d28629d723ebd6c518aa9df28ad7c', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=2', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"2\"}', 1777023293);
INSERT INTO `fa_miniapp_request_log` VALUES (536, 'api', 'Miniapp.order', 'orderrecord', '1', '5a3d28629d723ebd6c518aa9df28ad7c', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1777023298);
INSERT INTO `fa_miniapp_request_log` VALUES (537, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1777023593);
INSERT INTO `fa_miniapp_request_log` VALUES (538, 'api', 'Miniapp.index', 'homenew', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/index/homeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777023594);
INSERT INTO `fa_miniapp_request_log` VALUES (539, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777023597);
INSERT INTO `fa_miniapp_request_log` VALUES (540, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777023600);
INSERT INTO `fa_miniapp_request_log` VALUES (541, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777023645);
INSERT INTO `fa_miniapp_request_log` VALUES (542, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777023645);
INSERT INTO `fa_miniapp_request_log` VALUES (543, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777023654);
INSERT INTO `fa_miniapp_request_log` VALUES (544, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777023654);
INSERT INTO `fa_miniapp_request_log` VALUES (545, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777023689);
INSERT INTO `fa_miniapp_request_log` VALUES (546, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777023701);
INSERT INTO `fa_miniapp_request_log` VALUES (547, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777023729);
INSERT INTO `fa_miniapp_request_log` VALUES (548, 'api', 'Miniapp.my', 'indexnew', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/my/indexNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777023732);
INSERT INTO `fa_miniapp_request_log` VALUES (549, 'api', 'Miniapp.ctrl', 'teamall', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/ctrl/teamAll', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777023734);
INSERT INTO `fa_miniapp_request_log` VALUES (550, 'api', 'Miniapp.index', 'homenew', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/index/homeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777023735);
INSERT INTO `fa_miniapp_request_log` VALUES (551, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777023738);
INSERT INTO `fa_miniapp_request_log` VALUES (552, 'api', 'Miniapp.index', 'homenew', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/index/homeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777023739);
INSERT INTO `fa_miniapp_request_log` VALUES (553, 'api', 'Miniapp.index', 'homenew', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/index/homeNew', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777023741);
INSERT INTO `fa_miniapp_request_log` VALUES (554, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777023746);
INSERT INTO `fa_miniapp_request_log` VALUES (555, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777023797);
INSERT INTO `fa_miniapp_request_log` VALUES (556, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777023801);
INSERT INTO `fa_miniapp_request_log` VALUES (557, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777023823);
INSERT INTO `fa_miniapp_request_log` VALUES (558, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777024422);
INSERT INTO `fa_miniapp_request_log` VALUES (559, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777024424);
INSERT INTO `fa_miniapp_request_log` VALUES (560, 'api', 'Miniapp.user', 'do_login', '1', '', 10001, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------467924932611041756969158', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13800000001\",\"pwd\":\"123456\"}', 1777024913);
INSERT INTO `fa_miniapp_request_log` VALUES (561, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74daf785513e723aaba10470f36cc54e', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777024917);
INSERT INTO `fa_miniapp_request_log` VALUES (562, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777025018);
INSERT INTO `fa_miniapp_request_log` VALUES (563, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777025020);
INSERT INTO `fa_miniapp_request_log` VALUES (564, 'api', 'Miniapp.order', 'orderrecord', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'POST', '/miniapp/order/orderRecord', '*/*', 'zh-CN,zh;q=0.9', 'application/x-www-form-urlencoded', 'http://localhost:5173', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"1\"}', 1777025050);
INSERT INTO `fa_miniapp_request_log` VALUES (565, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777025051);
INSERT INTO `fa_miniapp_request_log` VALUES (566, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777025127);
INSERT INTO `fa_miniapp_request_log` VALUES (567, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777025131);
INSERT INTO `fa_miniapp_request_log` VALUES (568, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '7ecb8727c96d7f7917398e12d6569402', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', 'zh-CN,zh;q=0.9', 'application/json', '', '', 'http://localhost:5173/', '\"Google Chrome\";v=\"147\", \"Not.A/Brand\";v=\"8\", \"Chromium\";v=\"147\"', '?1', '\"Android\"', 'empty', 'cors', 'same-origin', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '127.0.0.1', '[]', 1777025156);
INSERT INTO `fa_miniapp_request_log` VALUES (569, 'api', 'Miniapp.order', 'order_info', '1', '74daf785513e723aaba10470f36cc54e', 10001, 'GET', '/miniapp/order/order_info?id=UB2604241726178571', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604241726178571\"}', 1777025216);
INSERT INTO `fa_miniapp_request_log` VALUES (570, 'api', 'Miniapp.order', 'orderrecord', '1', '74daf785513e723aaba10470f36cc54e', 10001, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1777025255);
INSERT INTO `fa_miniapp_request_log` VALUES (571, 'api', 'Miniapp.order', 'order_info', '1', '74daf785513e723aaba10470f36cc54e', 10001, 'GET', '/miniapp/order/order_info?id=UB2604241726178571', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604241726178571\"}', 1777025269);
INSERT INTO `fa_miniapp_request_log` VALUES (572, 'api', 'Miniapp.order', 'order_info', '1', '74daf785513e723aaba10470f36cc54e', 10001, 'GET', '/miniapp/order/order_info?id=UB2604241726178571', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604241726178571\"}', 1777029590);
INSERT INTO `fa_miniapp_request_log` VALUES (573, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '74daf785513e723aaba10470f36cc54e', 10001, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777029749);
INSERT INTO `fa_miniapp_request_log` VALUES (574, 'api', 'Miniapp.order', 'order_info', '1', '74daf785513e723aaba10470f36cc54e', 10001, 'GET', '/miniapp/order/order_info?id=UB2604241726178571', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604241726178571\"}', 1777029767);
INSERT INTO `fa_miniapp_request_log` VALUES (575, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------390413087356042709951832', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1777030083);
INSERT INTO `fa_miniapp_request_log` VALUES (576, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777030086);
INSERT INTO `fa_miniapp_request_log` VALUES (577, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777030164);
INSERT INTO `fa_miniapp_request_log` VALUES (578, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777030408);
INSERT INTO `fa_miniapp_request_log` VALUES (579, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777030503);
INSERT INTO `fa_miniapp_request_log` VALUES (580, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '', '', '', '', '', '', '', '', '', '', '', '', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; zh-CN) WindowsPowerShell/5.1.22621.4249', '127.0.0.1', '[]', 1777030911);
INSERT INTO `fa_miniapp_request_log` VALUES (581, 'api', 'Miniapp.user', 'do_login', '1', '', 10001, 'POST', '/miniapp/user/do_login', '', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; zh-CN) WindowsPowerShell/5.1.22621.4249', '127.0.0.1', '{\"tel\":\"13800000001\",\"pwd\":\"123456\"}', 1777037277);
INSERT INTO `fa_miniapp_request_log` VALUES (582, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '0704fc79325d2d942441cebd9c7b0824', 10001, 'GET', '/miniapp/rot_order/orderInfo', '', '', '', '', '', '', '', '', '', '', '', '', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; zh-CN) WindowsPowerShell/5.1.22621.4249', '127.0.0.1', '[]', 1777037277);
INSERT INTO `fa_miniapp_request_log` VALUES (583, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '', '', '', '', '', '', '', '', '', '', '', '', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; zh-CN) WindowsPowerShell/5.1.22621.4249', '127.0.0.1', '[]', 1777037353);
INSERT INTO `fa_miniapp_request_log` VALUES (584, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777037395);
INSERT INTO `fa_miniapp_request_log` VALUES (585, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '', '', '', '', '', '', '', '', '', '', '', '', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; zh-CN) WindowsPowerShell/5.1.22621.4249', '127.0.0.1', '[]', 1777037842);
INSERT INTO `fa_miniapp_request_log` VALUES (586, 'api', 'Miniapp.order', 'order_info', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'POST', '/miniapp/order/order_info', '', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; zh-CN) WindowsPowerShell/5.1.22621.4249', '127.0.0.1', '{\"id\":\"UBP1_201_4_1\"}', 1777037842);
INSERT INTO `fa_miniapp_request_log` VALUES (587, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777037887);
INSERT INTO `fa_miniapp_request_log` VALUES (588, 'api', 'Miniapp.order', 'order_info', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/order/order_info?id=UBP1_201_4_1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UBP1_201_4_1\"}', 1777037953);
INSERT INTO `fa_miniapp_request_log` VALUES (589, 'api', 'Miniapp.order', 'order_info', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/order/order_info?id=UBP1_201_4_1', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UBP1_201_4_1\"}', 1777038174);
INSERT INTO `fa_miniapp_request_log` VALUES (590, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777038181);
INSERT INTO `fa_miniapp_request_log` VALUES (591, 'api', 'Miniapp.order', 'order_info', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/order/order_info?id=UB2604242143012576', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604242143012576\"}', 1777038193);
INSERT INTO `fa_miniapp_request_log` VALUES (592, 'api', 'Miniapp.order', 'orderrecord', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/order/orderRecord?page=1&size=10&status=0', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"page\":\"1\",\"size\":\"10\",\"status\":\"0\"}', 1777038199);
INSERT INTO `fa_miniapp_request_log` VALUES (593, 'api', 'Miniapp.support', 'index', '1', '', 0, 'GET', '/miniapp/support/index', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777040127);
INSERT INTO `fa_miniapp_request_log` VALUES (594, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777040135);
INSERT INTO `fa_miniapp_request_log` VALUES (595, 'api', 'Miniapp.index', 'homenew', '1', '0704fc79325d2d942441cebd9c7b0824', 10001, 'GET', '/miniapp/index/homeNew', '', '', '', '', '', '', '', '', '', '', '', '', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; zh-CN) WindowsPowerShell/5.1.22621.4249', '127.0.0.1', '[]', 1777041484);
INSERT INTO `fa_miniapp_request_log` VALUES (596, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '0704fc79325d2d942441cebd9c7b0824', 10001, 'GET', '/miniapp/rot_order/orderInfo', '', '', '', '', '', '', '', '', '', '', '', '', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; zh-CN) WindowsPowerShell/5.1.22621.4249', '127.0.0.1', '[]', 1777041484);
INSERT INTO `fa_miniapp_request_log` VALUES (597, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', '0704fc79325d2d942441cebd9c7b0824', 10001, 'GET', '/miniapp/rot_order/orderInfo', '', '', '', '', '', '', '', '', '', '', '', '', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; zh-CN) WindowsPowerShell/5.1.22621.4249', '127.0.0.1', '[]', 1777041757);
INSERT INTO `fa_miniapp_request_log` VALUES (598, 'api', 'Miniapp.order', 'order_info', '1', '0704fc79325d2d942441cebd9c7b0824', 10001, 'POST', '/miniapp/order/order_info', '', '', 'application/x-www-form-urlencoded', '', '', '', '', '', '', '', '', '', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; zh-CN) WindowsPowerShell/5.1.22621.4249', '127.0.0.1', '{\"id\":\"UB2604241726178571\"}', 1777041757);
INSERT INTO `fa_miniapp_request_log` VALUES (599, 'api', 'Miniapp.order', 'order_info', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/order/order_info?id=UB2604242143012576', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"id\":\"UB2604242143012576\"}', 1777041848);
INSERT INTO `fa_miniapp_request_log` VALUES (600, 'api', 'Miniapp.rotOrder', 'orderinfo', '1', 'c14c9f5a20e2afe05de0c2269bbb573b', 1, 'GET', '/miniapp/rot_order/orderInfo', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777041896);
INSERT INTO `fa_miniapp_request_log` VALUES (601, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------304958431634759896604154', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1777456878);
INSERT INTO `fa_miniapp_request_log` VALUES (602, 'api', 'Miniapp.user', 'do_login', '1', '', 1, 'POST', '/miniapp/user/do_login', '*/*', '', 'multipart/form-data; boundary=--------------------------859245630755475815328064', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '{\"tel\":\"13812341234\",\"pwd\":\"123456\"}', 1777456894);
INSERT INTO `fa_miniapp_request_log` VALUES (603, 'api', 'Miniapp.index', 'homenew', '1', '0ac33039a8d0164d3999cf954a0e96fa', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777456897);
INSERT INTO `fa_miniapp_request_log` VALUES (604, 'api', 'Miniapp.index', 'homenew', '1', '0ac33039a8d0164d3999cf954a0e96fa', 1, 'GET', '/miniapp/index/homeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777457974);
INSERT INTO `fa_miniapp_request_log` VALUES (605, 'api', 'Miniapp.ctrl', 'rechargenew', '1', '0ac33039a8d0164d3999cf954a0e96fa', 1, 'GET', '/miniapp/ctrl/rechargeNew', '*/*', '', '', '', '', '', '', '', '', '', '', '', 'Apifox/1.0.0 (https://apifox.com)', '127.0.0.1', '[]', 1777458194);

-- ----------------------------
-- Table structure for fa_miniapp_scroll_list
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_scroll_list`;
CREATE TABLE `fa_miniapp_scroll_list`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户名/手机号',
  `today_income` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '今日收益',
  `addtime` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '日期',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '语言',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序首页滚动列表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_scroll_list
-- ----------------------------
INSERT INTO `fa_miniapp_scroll_list` VALUES (11, '5230463026', 288.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (12, '5251845479', 278.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (13, '5289179031', 140.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (14, '5262385237', 184.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (15, '5236654388', 242.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (16, '5298564025', 420.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (17, '5291744859', 377.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (18, '5241837773', 335.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (19, '5293957846', 399.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (20, '5271568191', 55.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (21, '5255297013', 21.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (22, '5211995334', 370.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (23, '5226871082', 488.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (24, '5241112711', 103.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (25, '5208603444', 405.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (26, '5245894229', 402.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (27, '5212179865', 288.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (28, '5200005495', 470.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (29, '5281524999', 167.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (30, '5289987809', 448.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (31, '5289858666', 469.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (32, '5208600278', 409.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (33, '5294796685', 106.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (34, '5231579354', 283.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (35, '5294468772', 160.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (36, '5250115770', 218.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (37, '5264502461', 333.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (38, '5258746069', 383.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (39, '5279069516', 280.00, '04-23', '1', 1, 1776937774);
INSERT INTO `fa_miniapp_scroll_list` VALUES (40, '5293689376', 421.00, '04-23', '1', 1, 1776937774);

-- ----------------------------
-- Table structure for fa_miniapp_scroll_list_bak_20260423_homenew
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_scroll_list_bak_20260423_homenew`;
CREATE TABLE `fa_miniapp_scroll_list_bak_20260423_homenew`  (
  `id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户名/手机号',
  `today_income` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '今日收益',
  `addtime` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '日期',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '语言',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间'
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_scroll_list_bak_20260423_homenew
-- ----------------------------

-- ----------------------------
-- Table structure for fa_miniapp_support
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_support`;
CREATE TABLE `fa_miniapp_support`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '客服ID',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'zh_cn' COMMENT '语言',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `contact_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '联系类型',
  `contact_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '联系方式',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序客服配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_support
-- ----------------------------
INSERT INTO `fa_miniapp_support` VALUES (101, '1', '在线客服', '如有问题请联系中文客服。', 'whatsapp', '+86-13800000001', 1, 100, 1713744000, 1713744000);
INSERT INTO `fa_miniapp_support` VALUES (102, '2', 'Online Support', 'Contact English support if you need help.', 'telegram', '@miniapp_support_en', 1, 90, 1713744000, 1713744000);

-- ----------------------------
-- Table structure for fa_miniapp_support_language_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_support_language_log`;
CREATE TABLE `fa_miniapp_support_language_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'zh_cn' COMMENT '语言',
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'token',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序语言设置日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_support_language_log
-- ----------------------------
INSERT INTO `fa_miniapp_support_language_log` VALUES (1, 10001, '1', 'miniapp_token_10001', 1713744000);
INSERT INTO `fa_miniapp_support_language_log` VALUES (2, 10002, '2', 'miniapp_token_10002', 1713744000);
INSERT INTO `fa_miniapp_support_language_log` VALUES (3, 0, '2', 'miniapp_token_10001', 1776872539);
INSERT INTO `fa_miniapp_support_language_log` VALUES (4, 0, '2', '', 1776875065);
INSERT INTO `fa_miniapp_support_language_log` VALUES (5, 10001, '2', 'bcef88011ee95b58009f298dfcd99b37', 1776875306);
INSERT INTO `fa_miniapp_support_language_log` VALUES (6, 0, '2', 'test_token_123', 1776876436);
INSERT INTO `fa_miniapp_support_language_log` VALUES (7, 10001, '2', '36bc46c37c0ab9ac0b6d9fb84fc053b8', 1776876625);
INSERT INTO `fa_miniapp_support_language_log` VALUES (8, 10001, '1', '36bc46c37c0ab9ac0b6d9fb84fc053b8', 1776876650);
INSERT INTO `fa_miniapp_support_language_log` VALUES (9, 0, '2', '', 1776880089);
INSERT INTO `fa_miniapp_support_language_log` VALUES (10, 0, '2', '', 1776880102);
INSERT INTO `fa_miniapp_support_language_log` VALUES (11, 0, '1', '', 1776880328);
INSERT INTO `fa_miniapp_support_language_log` VALUES (12, 0, '2', '', 1776880331);

-- ----------------------------
-- Table structure for fa_miniapp_team
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_team`;
CREATE TABLE `fa_miniapp_team`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '团队ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `team_balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '团队余额',
  `notice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '说明',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序团队汇总' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_team
-- ----------------------------
INSERT INTO `fa_miniapp_team` VALUES (1, 10001, 1688.88, '中文团队测试数据', 1713744000, 1713744000);
INSERT INTO `fa_miniapp_team` VALUES (2, 10002, 999.99, 'English team test data', 1713744000, 1713744000);

-- ----------------------------
-- Table structure for fa_miniapp_team_member
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_team_member`;
CREATE TABLE `fa_miniapp_team_member`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '成员ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属用户ID',
  `member_user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '成员用户ID',
  `member_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '成员昵称',
  `level` tinyint(4) NOT NULL DEFAULT 1 COMMENT '层级',
  `contribution` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '贡献值',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序团队成员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_team_member
-- ----------------------------
INSERT INTO `fa_miniapp_team_member` VALUES (1, 10001, 10002, '下级用户B', 1, 35.00, 1713744000);
INSERT INTO `fa_miniapp_team_member` VALUES (2, 10002, 10001, 'Leader A', 1, 88.00, 1713744000);

-- ----------------------------
-- Table structure for fa_miniapp_user
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_user`;
CREATE TABLE `fa_miniapp_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `tel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `area_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '地区码',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '登录密码(md5)',
  `cash_password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '资金密码(md5)',
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '登录token',
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '头像',
  `headpic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '头像URL',
  `balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '余额',
  `freeze_balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '冻结余额',
  `team_income` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '团队收益',
  `invite_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '邀请码',
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级用户ID',
  `level` tinyint(4) NOT NULL DEFAULT 0 COMMENT '用户等级',
  `deal_num` int(11) NOT NULL DEFAULT 0 COMMENT '交易笔数',
  `group_id` int(11) NOT NULL DEFAULT 0 COMMENT '分组ID',
  `show_td` tinyint(4) NOT NULL DEFAULT 1 COMMENT '是否显示团队',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `last_login_time` int(11) NOT NULL DEFAULT 0 COMMENT '最后登录时间',
  `last_login_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  `template_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '模版名称',
  `dispatch_order` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '派单订单序列',
  `commission_rate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '佣金比例序列',
  `fixed_commission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '固定佣金序列',
  `dispatch_amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '派单金额序列',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tel`(`tel` ASC) USING BTREE,
  INDEX `idx_token`(`token` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10006 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序用户主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_user
-- ----------------------------
INSERT INTO `fa_miniapp_user` VALUES (1, '13812341234', '86', 'e10adc3949ba59abbe56e057f20f883e', '297ff4a97fcda4bc0ecf0bb18168034a', '0ac33039a8d0164d3999cf954a0e96fa', 'U1234', '', '', '', 22.99, 0.00, 0.00, '15B47330', 0, 0, 0, 0, 1, 1, 1777456894, '127.0.0.1', 1776848821, 1777456894, '测试', '1', '10', '', '20');
INSERT INTO `fa_miniapp_user` VALUES (2, '14113938512', '+86', 'cd4d77de8d3783439c7168c43ace70ec', 'cd4d77de8d3783439c7168c43ace70ec', 'c65bedc5a7c2272673240de8622100f2', 'U8512', '', '', '', 0.00, 0.00, 0.00, '443C5994', 0, 0, 0, 0, 1, 1, 1776850086, '127.0.0.1', 1776850086, 1776850086, '', '', '', '', '');
INSERT INTO `fa_miniapp_user` VALUES (3, '14113938412', '+86', 'e10adc3949ba59abbe56e057f20f883e', 'e10adc3949ba59abbe56e057f20f883e', '2fd7f421d9f6f8c2fe1d2870e2cdc88a', 'U8412', '', '', '', 0.00, 0.00, 0.00, 'C96198ED', 0, 0, 0, 0, 1, 1, 1776850293, '127.0.0.1', 1776850293, 1776850293, '', '', '', '', '');
INSERT INTO `fa_miniapp_user` VALUES (4, '14112938412', '+86', 'e10adc3949ba59abbe56e057f20f883e', 'e10adc3949ba59abbe56e057f20f883e', '9d8de0328d43e6d5cb10759211a7ae21', 'U8412', '', '', '', 0.00, 0.00, 0.00, '966722A9', 0, 0, 0, 0, 1, 1, 1776850457, '127.0.0.1', 1776850457, 1776850457, '', '', '', '', '');
INSERT INTO `fa_miniapp_user` VALUES (5, '1411383512', '+86', 'e10adc3949ba59abbe56e057f20f883e', 'e10adc3949ba59abbe56e057f20f883e', '3f6b68ed7bd63a94601c2b61335df93a', 'U3512', '', '', '', 0.00, 0.00, 0.00, '1872B942', 0, 0, 0, 0, 1, 1, 1776850564, '127.0.0.1', 1776850564, 1776850564, '', '', '', '', '');
INSERT INTO `fa_miniapp_user` VALUES (10001, '13800000001', '+86', 'e10adc3949ba59abbe56e057f20f883e', 'c33367701511b4f6020ec61ded352059', '0704fc79325d2d942441cebd9c7b0824', '测试用户A', '', '', '', 562.05, 0.00, 88.00, 'INVITEA1', 0, 0, 0, 0, 1, 1, 1777037277, '127.0.0.1', 1713744000, 1777037277, '测试', '12/24', '10/10', '', '10/50');
INSERT INTO `fa_miniapp_user` VALUES (10002, '13800000002', '+86', 'e10adc3949ba59abbe56e057f20f883e', 'e10adc3949ba59abbe56e057f20f883e', 'miniapp_token_10002', 'TestUserB', '', '', '', 860.00, 0.00, 35.00, 'INVITEB2', 10001, 0, 0, 0, 1, 1, 1713744000, '127.0.0.1', 1713744000, 1713744000, '', '', '', '', '');
INSERT INTO `fa_miniapp_user` VALUES (10003, '14313938451', '+86', 'e10adc3949ba59abbe56e057f20f883e', 'e10adc3949ba59abbe56e057f20f883e', '22af4288ada8c589964e862b4b8df20e', 'U8451', '', '', '', 0.00, 0.00, 0.00, '5B78C264', 0, 0, 0, 0, 1, 1, 1776924334, '127.0.0.1', 1776924334, 1776924334, '', '', '', '', '');
INSERT INTO `fa_miniapp_user` VALUES (10004, '13113935412', '+86', 'e10adc3949ba59abbe56e057f20f883e', 'e10adc3949ba59abbe56e057f20f883e', '1adee7ec3b5784bc696fce050d73abd5', 'U5412', '', '', '', 10.00, 0.00, 0.00, '07575CEB', 0, 0, 0, 0, 1, 1, 1776925802, '127.0.0.1', 1776925363, 1777459621, '', '', '', '', '');
INSERT INTO `fa_miniapp_user` VALUES (10005, '13927933651', '+86', 'e10adc3949ba59abbe56e057f20f883e', 'e10adc3949ba59abbe56e057f20f883e', '84a7e545228734717be4ce88c42e400f', 'U3651', '', '', '', 0.00, 0.00, 0.00, '2762EC1C', 0, 0, 0, 0, 1, 1, 1776925715, '127.0.0.1', 1776925696, 1777459607, '', '', '', '', '');

-- ----------------------------
-- Table structure for fa_miniapp_user_bak_20260423_homenew
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_user_bak_20260423_homenew`;
CREATE TABLE `fa_miniapp_user_bak_20260423_homenew`  (
  `id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `tel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `area_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '地区码',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '登录密码(md5)',
  `cash_password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '资金密码(md5)',
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '登录token',
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '头像',
  `headpic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '头像URL',
  `balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '余额',
  `freeze_balance` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '冻结余额',
  `team_income` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '团队收益',
  `invite_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '邀请码',
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级用户ID',
  `level` tinyint(4) NOT NULL DEFAULT 0 COMMENT '用户等级',
  `deal_num` int(11) NOT NULL DEFAULT 0 COMMENT '交易笔数',
  `group_id` int(11) NOT NULL DEFAULT 0 COMMENT '分组ID',
  `show_td` tinyint(4) NOT NULL DEFAULT 1 COMMENT '是否显示团队',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `last_login_time` int(11) NOT NULL DEFAULT 0 COMMENT '最后登录时间',
  `last_login_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间'
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_user_bak_20260423_homenew
-- ----------------------------

-- ----------------------------
-- Table structure for fa_miniapp_user_info
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_user_info`;
CREATE TABLE `fa_miniapp_user_info`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '信息ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `realname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '地址',
  `bank_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '银行名',
  `bank_account` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '银行账号',
  `usdt_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'USDT地址',
  `usdt_diz` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'USDT地址(线上字段)',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序用户资料' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_user_info
-- ----------------------------
INSERT INTO `fa_miniapp_user_info` VALUES (1, 1, '', '', '', '', '', '', 1776848821, 1776848821);
INSERT INTO `fa_miniapp_user_info` VALUES (2, 2, '', '', '', '', '', '', 1776850086, 1776850086);
INSERT INTO `fa_miniapp_user_info` VALUES (3, 3, '', '', '', '', '', '', 1776850293, 1776850293);
INSERT INTO `fa_miniapp_user_info` VALUES (4, 4, '', '', '', '', '', '', 1776850457, 1776850457);
INSERT INTO `fa_miniapp_user_info` VALUES (5, 5, '', '', '', '', '', '', 1776850564, 1776850564);
INSERT INTO `fa_miniapp_user_info` VALUES (6, 10001, '张三', 'testaddr', '招商银行', '6225888888888888', 'TRON_TEST_ADDRESS_10001', '', 1713744000, 1776879662);
INSERT INTO `fa_miniapp_user_info` VALUES (7, 10002, 'John Smith', 'Room 802, Test Building, London', 'HSBC', '123456789012', 'TRON_TEST_ADDRESS_10002', '', 1713744000, 1713744000);
INSERT INTO `fa_miniapp_user_info` VALUES (8, 10003, '', '', '', '', '', '', 1776924334, 1776924334);
INSERT INTO `fa_miniapp_user_info` VALUES (9, 10004, '', '', '', '', '', '', 1776925363, 1776925363);
INSERT INTO `fa_miniapp_user_info` VALUES (10, 10005, '', '', '', '', '', '', 1776925696, 1776925696);

-- ----------------------------
-- Table structure for fa_miniapp_user_info_save_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_user_info_save_log`;
CREATE TABLE `fa_miniapp_user_info_save_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '地址',
  `has_new_pwd` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否修改密码',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序用户资料修改日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_user_info_save_log
-- ----------------------------
INSERT INTO `fa_miniapp_user_info_save_log` VALUES (1, 10001, 'testaddr', 0, 1776872888);
INSERT INTO `fa_miniapp_user_info_save_log` VALUES (2, 10001, '', 1, 1776879662);

-- ----------------------------
-- Table structure for fa_miniapp_user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_user_login_log`;
CREATE TABLE `fa_miniapp_user_login_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `tel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'token',
  `client_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序登录日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_user_login_log
-- ----------------------------
INSERT INTO `fa_miniapp_user_login_log` VALUES (1, 1, '13812341234', '1c6bbcc46e939e8b299d764d575e5b76', '127.0.0.1', 1776849188);
INSERT INTO `fa_miniapp_user_login_log` VALUES (2, 1, '13812341234', '1b1b8af3b4ffee3788a97f7915166019', '127.0.0.1', 1776849465);
INSERT INTO `fa_miniapp_user_login_log` VALUES (3, 1, '13812341234', '2e205121ec8ad5ecf2464b6737726687', '127.0.0.1', 1776849521);
INSERT INTO `fa_miniapp_user_login_log` VALUES (4, 1, '13812341234', '38e2ba8a0ec9eabbc84ed6fe3066aa11', '127.0.0.1', 1776849600);
INSERT INTO `fa_miniapp_user_login_log` VALUES (5, 1, '13812341234', '59ec892dd704ccb2ba843b4682803b33', '127.0.0.1', 1776849618);
INSERT INTO `fa_miniapp_user_login_log` VALUES (6, 1, '13812341234', '43894b2c4c9d3c8e7a15dd3a13636950', '127.0.0.1', 1776849896);
INSERT INTO `fa_miniapp_user_login_log` VALUES (7, 1, '13812341234', '8e04b7504cb081b78630947ae6e6f98a', '127.0.0.1', 1776853248);
INSERT INTO `fa_miniapp_user_login_log` VALUES (8, 1, '13812341234', '0dd8007cc968cde4dae46ba289c3c890', '127.0.0.1', 1776855401);
INSERT INTO `fa_miniapp_user_login_log` VALUES (9, 1, '13812341234', 'f1f23a14df2490ac6c88c5ddb20abd62', '127.0.0.1', 1776856081);
INSERT INTO `fa_miniapp_user_login_log` VALUES (10, 1, '13812341234', 'e9721e9d8f98d82e124cd80a7aa1f7fc', '127.0.0.1', 1776857800);
INSERT INTO `fa_miniapp_user_login_log` VALUES (11, 1, '13812341234', '9fa404d675ef7350b4344bfcba3fd01d', '127.0.0.1', 1776857822);
INSERT INTO `fa_miniapp_user_login_log` VALUES (12, 1, '13812341234', 'bfcc9fbb7ab600b5f18e3f83f3770ff0', '127.0.0.1', 1776857843);
INSERT INTO `fa_miniapp_user_login_log` VALUES (13, 1, '13812341234', 'ca9786aa489bc3836f09cfff7332254d', '127.0.0.1', 1776870144);
INSERT INTO `fa_miniapp_user_login_log` VALUES (14, 1, '13812341234', '868839aef861b4389aeadd2228a9813d', '127.0.0.1', 1776872269);
INSERT INTO `fa_miniapp_user_login_log` VALUES (15, 10001, '13800000001', '2671d59f6c560f2acce9ad3ac4be3c11', '127.0.0.1', 1776872562);
INSERT INTO `fa_miniapp_user_login_log` VALUES (16, 10001, '13800000001', '49fdabad4249039f659741cd24eea93b', '127.0.0.1', 1776873534);
INSERT INTO `fa_miniapp_user_login_log` VALUES (17, 10001, '13800000001', '39331f1f5bca33ffbd89e9e7a9fd9a8e', '127.0.0.1', 1776873822);
INSERT INTO `fa_miniapp_user_login_log` VALUES (18, 1, '13812341234', '9c33694cbe69b5e1ce3c17d3d69e8f60', '127.0.0.1', 1776874861);
INSERT INTO `fa_miniapp_user_login_log` VALUES (19, 1, '13812341234', '2e65c146406b9b5adc79f2add89ddad4', '127.0.0.1', 1776874894);
INSERT INTO `fa_miniapp_user_login_log` VALUES (20, 10001, '13800000001', 'bcef88011ee95b58009f298dfcd99b37', '127.0.0.1', 1776875273);
INSERT INTO `fa_miniapp_user_login_log` VALUES (21, 1, '13812341234', '764d74f4a52a60988916c402f343bacb', '127.0.0.1', 1776875603);
INSERT INTO `fa_miniapp_user_login_log` VALUES (22, 10001, '13800000001', '36bc46c37c0ab9ac0b6d9fb84fc053b8', '0.0.0.0', 1776876533);
INSERT INTO `fa_miniapp_user_login_log` VALUES (23, 10001, '13800000001', '9ad5483ffaf6746c73cc4459e72ca615', '0.0.0.0', 1776876864);
INSERT INTO `fa_miniapp_user_login_log` VALUES (24, 10001, '13800000001', '1ebe74c4773f4104c87f5e79cb16045c', '0.0.0.0', 1776878916);
INSERT INTO `fa_miniapp_user_login_log` VALUES (25, 1, '13812341234', 'dd6fd9b9f0c2a5d8bb6d69213ad08b50', '127.0.0.1', 1776920994);
INSERT INTO `fa_miniapp_user_login_log` VALUES (26, 1, '13812341234', '44ddfabfbf4fb659c4c6bb5f024cc45d', '127.0.0.1', 1776924757);
INSERT INTO `fa_miniapp_user_login_log` VALUES (27, 10004, '13113935412', 'beb0d3862e7e8f511f3e5bec65b73bcf', '127.0.0.1', 1776925374);
INSERT INTO `fa_miniapp_user_login_log` VALUES (28, 10004, '13113935412', '82620f28522d1b2d334d01fe6230986a', '127.0.0.1', 1776925445);
INSERT INTO `fa_miniapp_user_login_log` VALUES (29, 10005, '13927933651', '84a7e545228734717be4ce88c42e400f', '127.0.0.1', 1776925715);
INSERT INTO `fa_miniapp_user_login_log` VALUES (30, 10004, '13113935412', '1adee7ec3b5784bc696fce050d73abd5', '127.0.0.1', 1776925802);
INSERT INTO `fa_miniapp_user_login_log` VALUES (31, 1, '13812341234', 'f9a6eaa1df011c06e5c971bd7c9d206b', '127.0.0.1', 1776926052);
INSERT INTO `fa_miniapp_user_login_log` VALUES (32, 1, '13812341234', 'b0f8ec794449c21aaba75321c1f43e09', '127.0.0.1', 1776926182);
INSERT INTO `fa_miniapp_user_login_log` VALUES (33, 1, '13812341234', '152aba669f6d7bc12edb9496faa05803', '127.0.0.1', 1776926430);
INSERT INTO `fa_miniapp_user_login_log` VALUES (34, 1, '13812341234', 'a4b6d6c388662163aacb7967ae2b8faa', '127.0.0.1', 1776935256);
INSERT INTO `fa_miniapp_user_login_log` VALUES (35, 1, '13812341234', '6f720b25b546b2c3844b660fb6568340', '127.0.0.1', 1776935959);
INSERT INTO `fa_miniapp_user_login_log` VALUES (36, 10001, '13800000001', '44969509e5d8e408c274e5bb8294a1d5', '127.0.0.1', 1776938241);
INSERT INTO `fa_miniapp_user_login_log` VALUES (37, 1, '13812341234', '1e5ad34ea45d6583f39dfafb6ec68e28', '127.0.0.1', 1776942283);
INSERT INTO `fa_miniapp_user_login_log` VALUES (38, 1, '13812341234', 'de925872838d822062fe11f2ada00a0c', '127.0.0.1', 1776995258);
INSERT INTO `fa_miniapp_user_login_log` VALUES (39, 1, '13812341234', '934913d42174f035ad87c259c35d4910', '127.0.0.1', 1776999326);
INSERT INTO `fa_miniapp_user_login_log` VALUES (40, 1, '13812341234', '3582ba80793b91ef50098012faceae36', '127.0.0.1', 1776999641);
INSERT INTO `fa_miniapp_user_login_log` VALUES (41, 1, '13812341234', '74015d77689981b2617d1ba99583835c', '127.0.0.1', 1777011094);
INSERT INTO `fa_miniapp_user_login_log` VALUES (42, 10001, '13800000001', '9107fefdd3470aa1370e2f2815df9665', '127.0.0.1', 1777019422);
INSERT INTO `fa_miniapp_user_login_log` VALUES (43, 1, '13812341234', '5a3d28629d723ebd6c518aa9df28ad7c', '127.0.0.1', 1777022986);
INSERT INTO `fa_miniapp_user_login_log` VALUES (44, 1, '13812341234', '7ecb8727c96d7f7917398e12d6569402', '127.0.0.1', 1777023593);
INSERT INTO `fa_miniapp_user_login_log` VALUES (45, 10001, '13800000001', '74daf785513e723aaba10470f36cc54e', '127.0.0.1', 1777024913);
INSERT INTO `fa_miniapp_user_login_log` VALUES (46, 1, '13812341234', 'c14c9f5a20e2afe05de0c2269bbb573b', '127.0.0.1', 1777030082);
INSERT INTO `fa_miniapp_user_login_log` VALUES (47, 10001, '13800000001', '0704fc79325d2d942441cebd9c7b0824', '127.0.0.1', 1777037277);
INSERT INTO `fa_miniapp_user_login_log` VALUES (48, 1, '13812341234', '34d288a9454dd500bf8d11adc64853a9', '127.0.0.1', 1777456878);
INSERT INTO `fa_miniapp_user_login_log` VALUES (49, 1, '13812341234', '0ac33039a8d0164d3999cf954a0e96fa', '127.0.0.1', 1777456894);

-- ----------------------------
-- Table structure for fa_miniapp_user_logout_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_user_logout_log`;
CREATE TABLE `fa_miniapp_user_logout_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'token',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序登出日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_user_logout_log
-- ----------------------------
INSERT INTO `fa_miniapp_user_logout_log` VALUES (1, 1, '9fa404d675ef7350b4344bfcba3fd01d', 1776857834);
INSERT INTO `fa_miniapp_user_logout_log` VALUES (2, 10001, '2671d59f6c560f2acce9ad3ac4be3c11', 1776872935);
INSERT INTO `fa_miniapp_user_logout_log` VALUES (3, 1, '9c33694cbe69b5e1ce3c17d3d69e8f60', 1776874888);
INSERT INTO `fa_miniapp_user_logout_log` VALUES (4, 1, '2e65c146406b9b5adc79f2add89ddad4', 1776875106);
INSERT INTO `fa_miniapp_user_logout_log` VALUES (5, 1, '764d74f4a52a60988916c402f343bacb', 1776880356);
INSERT INTO `fa_miniapp_user_logout_log` VALUES (6, 1, 'dd6fd9b9f0c2a5d8bb6d69213ad08b50', 1776921430);
INSERT INTO `fa_miniapp_user_logout_log` VALUES (7, 1, '934913d42174f035ad87c259c35d4910', 1776999372);

-- ----------------------------
-- Table structure for fa_miniapp_user_register_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_user_register_log`;
CREATE TABLE `fa_miniapp_user_register_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `tel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'token',
  `invite_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '邀请码',
  `area_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '地区码',
  `confirm_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '确认密码',
  `client_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序注册日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_user_register_log
-- ----------------------------
INSERT INTO `fa_miniapp_user_register_log` VALUES (1, 1, '13812341234', 'bc53b870ad52b6c35260756ecd889f03', '1', '86', '123456', '127.0.0.1', 1776848821);
INSERT INTO `fa_miniapp_user_register_log` VALUES (2, 2, '14113938512', 'c65bedc5a7c2272673240de8622100f2', '123456', '+86', 'asd.12345', '127.0.0.1', 1776850086);
INSERT INTO `fa_miniapp_user_register_log` VALUES (3, 3, '14113938412', '2fd7f421d9f6f8c2fe1d2870e2cdc88a', '1234', '+86', '123456', '127.0.0.1', 1776850293);
INSERT INTO `fa_miniapp_user_register_log` VALUES (4, 4, '14112938412', '9d8de0328d43e6d5cb10759211a7ae21', '12212', '+86', '123456', '127.0.0.1', 1776850457);
INSERT INTO `fa_miniapp_user_register_log` VALUES (5, 5, '1411383512', '3f6b68ed7bd63a94601c2b61335df93a', '1234', '+86', '123456', '127.0.0.1', 1776850564);
INSERT INTO `fa_miniapp_user_register_log` VALUES (6, 10003, '14313938451', '22af4288ada8c589964e862b4b8df20e', '1234', '+86', '123456', '127.0.0.1', 1776924334);
INSERT INTO `fa_miniapp_user_register_log` VALUES (7, 10004, '13113935412', '25268fd3561fac632474e237c88a0e3a', '1234', '+86', '123456', '127.0.0.1', 1776925363);
INSERT INTO `fa_miniapp_user_register_log` VALUES (8, 10005, '13927933651', '2898e795b6598b9179e2447ecbfb67ee', '195951', '+86', '123456', '127.0.0.1', 1776925696);

-- ----------------------------
-- Table structure for fa_miniapp_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `fa_miniapp_withdraw`;
CREATE TABLE `fa_miniapp_withdraw`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '提现ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `withdraw_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '提现单号',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '提现类型',
  `amount` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '提现金额',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态',
  `create_time` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_withdraw_no`(`withdraw_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 604 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '小程序提现记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_miniapp_withdraw
-- ----------------------------
INSERT INTO `fa_miniapp_withdraw` VALUES (601, 10001, 'WDTEST000001', 'bank', 100.00, 1, 1713751200, 1713751200);
INSERT INTO `fa_miniapp_withdraw` VALUES (602, 10001, 'WD2604222348316310', 'bank', 10.00, 1, 1776872911, 1776872911);
INSERT INTO `fa_miniapp_withdraw` VALUES (603, 10005, 'WD2604290646474308', 'admin', 1.00, 1, 1777459607, 1777459607);

-- ----------------------------
-- Table structure for fa_sms
-- ----------------------------
DROP TABLE IF EXISTS `fa_sms`;
CREATE TABLE `fa_sms`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证码',
  `times` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '验证次数',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '短信验证码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_sms
-- ----------------------------

-- ----------------------------
-- Table structure for fa_test
-- ----------------------------
DROP TABLE IF EXISTS `fa_test`;
CREATE TABLE `fa_test`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) NULL DEFAULT 0 COMMENT '会员ID',
  `admin_id` int(10) NULL DEFAULT 0 COMMENT '管理员ID',
  `category_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '分类ID(单选)',
  `category_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类ID(多选)',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签',
  `week` enum('monday','tuesday','wednesday') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片',
  `images` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '附件',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '省市',
  `array` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '数组:value=值',
  `json` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置:key=名称,value=值',
  `multiplejson` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '二维数组:title=标题,intro=介绍,author=作者,age=年龄',
  `price` decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '价格',
  `views` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '点击',
  `workrange` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '时间区间',
  `startdate` date NULL DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime NULL DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year NULL DEFAULT NULL COMMENT '年',
  `times` time NULL DEFAULT NULL COMMENT '时间',
  `refreshtime` bigint(16) NULL DEFAULT NULL COMMENT '刷新时间',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) NULL DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `switch` tinyint(1) NULL DEFAULT 0 COMMENT '开关',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '测试表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_test
-- ----------------------------
INSERT INTO `fa_test` VALUES (1, 1, 1, 12, '12,13', '互联网,计算机', 'monday', 'hot,index', 'male', 'music,reading', '我是一篇测试文章', '<p>我是测试内容</p>', '/assets/img/avatar.png', '/assets/img/avatar.png,/assets/img/qrcode.png', '/assets/img/avatar.png', '关键字', '我是一篇测试文章描述，内容过多时将自动隐藏', '广西壮族自治区/百色市/平果县', '[\"a\",\"b\"]', '{\"a\":\"1\",\"b\":\"2\"}', '[{\"title\":\"标题一\",\"intro\":\"介绍一\",\"author\":\"小明\",\"age\":\"21\"}]', 0.00, 0, '2020-10-01 00:00:00 - 2021-10-31 23:59:59', '2017-07-10', '2017-07-10 18:24:45', 2017, '18:24:45', 1491635035, 1491635035, 1491635035, NULL, 0, 1, 'normal', '1');

-- ----------------------------
-- Table structure for fa_user
-- ----------------------------
DROP TABLE IF EXISTS `fa_user`;
CREATE TABLE `fa_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '组别ID',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `level` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '等级',
  `gender` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '格言',
  `money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '余额',
  `score` int(10) NOT NULL DEFAULT 0 COMMENT '积分',
  `successions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '连续登录天数',
  `maxsuccessions` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '最大连续登录天数',
  `prevtime` bigint(16) NULL DEFAULT NULL COMMENT '上次登录时间',
  `logintime` bigint(16) NULL DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `loginfailuretime` bigint(16) NULL DEFAULT NULL COMMENT '最后登录失败时间',
  `joinip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '加入IP',
  `jointime` bigint(16) NULL DEFAULT NULL COMMENT '加入时间',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Token',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  `verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username` ASC) USING BTREE,
  INDEX `email`(`email` ASC) USING BTREE,
  INDEX `mobile`(`mobile` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user
-- ----------------------------
INSERT INTO `fa_user` VALUES (1, 1, 'admin', 'admin', '', '', 'admin@163.com', '13000000000', '', 0, 0, '2017-04-08', '', 0.00, 0, 1, 1, 1491635035, 1491635035, '127.0.0.1', 2, 1776841792, '127.0.0.1', 1491635035, 0, 1776841792, '', 'normal', '');
INSERT INTO `fa_user` VALUES (2, 1, 'admin123', 'admin123', '4d775aaf4fa551bdce05f95778d16d74', 'DmclFj', '29585288231@qq.com', '17674317946', '', 1, 0, NULL, '', 0.00, 0, 1, 1, 1776841823, 1776841823, '127.0.0.1', 0, NULL, '127.0.0.1', 1776841823, 1776841823, 1777459031, '', 'normal', '');

-- ----------------------------
-- Table structure for fa_user_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_group`;
CREATE TABLE `fa_user_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '权限节点',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user_group
-- ----------------------------
INSERT INTO `fa_user_group` VALUES (1, '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', 1491635035, 1491635035, 'normal');

-- ----------------------------
-- Table structure for fa_user_money_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_money_log`;
CREATE TABLE `fa_user_money_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `money` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更余额',
  `before` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更前余额',
  `after` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '变更后余额',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员余额变动表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user_money_log
-- ----------------------------

-- ----------------------------
-- Table structure for fa_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_rule`;
CREATE TABLE `fa_user_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) NULL DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) NULL DEFAULT NULL COMMENT '是否菜单',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NULL DEFAULT 0 COMMENT '权重',
  `status` enum('normal','hidden') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user_rule
-- ----------------------------
INSERT INTO `fa_user_rule` VALUES (1, 0, 'index', 'Frontend', '', 1, 1491635035, 1491635035, 1, 'normal');
INSERT INTO `fa_user_rule` VALUES (2, 0, 'api', 'API Interface', '', 1, 1491635035, 1491635035, 2, 'normal');
INSERT INTO `fa_user_rule` VALUES (3, 1, 'user', 'User Module', '', 1, 1491635035, 1491635035, 12, 'normal');
INSERT INTO `fa_user_rule` VALUES (4, 2, 'user', 'User Module', '', 1, 1491635035, 1491635035, 11, 'normal');
INSERT INTO `fa_user_rule` VALUES (5, 3, 'index/user/login', 'Login', '', 0, 1491635035, 1491635035, 5, 'normal');
INSERT INTO `fa_user_rule` VALUES (6, 3, 'index/user/register', 'Register', '', 0, 1491635035, 1491635035, 7, 'normal');
INSERT INTO `fa_user_rule` VALUES (7, 3, 'index/user/index', 'User Center', '', 0, 1491635035, 1491635035, 9, 'normal');
INSERT INTO `fa_user_rule` VALUES (8, 3, 'index/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 4, 'normal');
INSERT INTO `fa_user_rule` VALUES (9, 4, 'api/user/login', 'Login', '', 0, 1491635035, 1491635035, 6, 'normal');
INSERT INTO `fa_user_rule` VALUES (10, 4, 'api/user/register', 'Register', '', 0, 1491635035, 1491635035, 8, 'normal');
INSERT INTO `fa_user_rule` VALUES (11, 4, 'api/user/index', 'User Center', '', 0, 1491635035, 1491635035, 10, 'normal');
INSERT INTO `fa_user_rule` VALUES (12, 4, 'api/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 3, 'normal');

-- ----------------------------
-- Table structure for fa_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_score_log`;
CREATE TABLE `fa_user_score_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT 0 COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT 0 COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT 0 COMMENT '变更后积分',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员积分变动表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user_score_log
-- ----------------------------

-- ----------------------------
-- Table structure for fa_user_token
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_token`;
CREATE TABLE `fa_user_token`  (
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Token',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `expiretime` bigint(16) NULL DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员Token表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_user_token
-- ----------------------------

-- ----------------------------
-- Table structure for fa_version
-- ----------------------------
DROP TABLE IF EXISTS `fa_version`;
CREATE TABLE `fa_version`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '包大小',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '强制更新',
  `createtime` bigint(16) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) NULL DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '版本表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_version
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
