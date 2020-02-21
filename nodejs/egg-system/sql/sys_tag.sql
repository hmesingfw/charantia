/*
Navicat MySQL Data Transfer

Source Server         : localhost woxihuanni
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : charantia_sys

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2020-02-21 16:54:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_enum
-- ----------------------------
DROP TABLE IF EXISTS `sys_enum`;
CREATE TABLE `sys_enum` (
  `id` varchar(36) NOT NULL,
  `title` varchar(50) NOT NULL COMMENT '枚举名称',
  `value` varchar(50) NOT NULL COMMENT '枚举值',
  `parent_id` varchar(36) NOT NULL,
  `status` varchar(1) DEFAULT NULL COMMENT '0 启用 1禁用',
  `sort` int(11) DEFAULT NULL COMMENT '排序  数值大排前',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_del` varchar(1) DEFAULT '0' COMMENT '0 正常 1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='枚举管理';

-- ----------------------------
-- Records of sys_enum
-- ----------------------------
INSERT INTO `sys_enum` VALUES ('4229c981-6dc4-4d9a-be5e-c61072555089', '选择框', 'el-select', '5728b922-076b-42ac-8a77-772ec9adccad', '0', '9', '2020-02-17 06:57:33', '2020-02-21 03:15:05', null, '选择框', '0');
INSERT INTO `sys_enum` VALUES ('5728b922-076b-42ac-8a77-772ec9adccad', '组件', 'components', '0', '0', '1', '2020-02-11 14:48:19', '2020-02-21 03:00:01', null, '组件枚举', '0');
INSERT INTO `sys_enum` VALUES ('65e16d0e-4736-40f8-a6b9-41ce19768fe3', '计数器', 'el-input-number', '5728b922-076b-42ac-8a77-772ec9adccad', '0', '1', '2020-02-21 03:15:39', '2020-02-21 03:15:39', null, '计数器', '0');
INSERT INTO `sys_enum` VALUES ('b98b5a69-ff48-411c-9a3b-eed78906fdfb', '输入框', 'el-input', '5728b922-076b-42ac-8a77-772ec9adccad', '0', '10', '2020-02-13 06:33:22', '2020-02-21 03:00:15', null, '输入框', '0');
INSERT INTO `sys_enum` VALUES ('e3f818e7-fbe3-444d-8215-0791ab7bd457', '日期时间选择器', 'el-date-picker', '5728b922-076b-42ac-8a77-772ec9adccad', '0', '1', '2020-02-21 03:05:58', '2020-02-21 03:06:22', null, '日期时间选择器', '0');

-- ----------------------------
-- Table structure for sys_tag
-- ----------------------------
DROP TABLE IF EXISTS `sys_tag`;
CREATE TABLE `sys_tag` (
  `id` varchar(36) NOT NULL,
  `title` varchar(32) DEFAULT NULL COMMENT '标题',
  `type` varchar(36) DEFAULT NULL COMMENT '类型',
  `color` varchar(16) DEFAULT NULL COMMENT '颜色',
  `sort` int(8) DEFAULT NULL COMMENT '排序',
  `status` char(1) DEFAULT NULL COMMENT '0 启用 1禁用',
  `details` varchar(255) DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `is_del` varchar(1) DEFAULT '0' COMMENT '0 正常 1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统标签表';

-- ----------------------------
-- Records of sys_tag
-- ----------------------------
INSERT INTO `sys_tag` VALUES ('43eec8ee-b69f-40db-bed4-37ff6795bda9', '颜色', null, null, '1', '0', null, '2020-02-01 08:51:23', '2020-02-01 08:51:23', null, null);
INSERT INTO `sys_tag` VALUES ('49d06b4f-dadb-49fd-96ab-b752a007d384', '你好', null, null, '1', '0', null, '2020-02-01 08:38:50', '2020-02-01 08:38:50', null, null);
