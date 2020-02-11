/*
Navicat MySQL Data Transfer

Source Server         : woxihuanni
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : charantia_sys

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2020-02-11 22:48:52
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
INSERT INTO `sys_enum` VALUES ('5728b922-076b-42ac-8a77-772ec9adccad', '组件', 'components', '0', '0', '2020-02-11 14:48:19', '2020-02-11 14:48:19', null, '组件枚举', '0');
INSERT INTO `sys_enum` VALUES ('7c0f8034-55ee-475f-8ae7-f2e58adae81e', '3', '4', '0', '0', '2020-02-04 03:18:06', '2020-02-11 14:47:42', null, '5', '1');
INSERT INTO `sys_enum` VALUES ('81be368e-2077-47be-b3ed-8b18072a9ab7', '1', '2', '0', '0', '2020-02-04 03:41:27', '2020-02-04 07:39:13', null, '3', '1');
INSERT INTO `sys_enum` VALUES ('8bc6e8ee-7214-400e-b5ba-f0e0ec70f550', '1', 'w', '0', '0', '2020-02-04 03:17:34', '2020-02-11 14:47:42', null, '3', '1');
INSERT INTO `sys_enum` VALUES ('aaa3051a-21a9-4faa-b3b9-dd6e7325ed1e', '2', '3', '0', '0', '2020-02-04 03:17:54', '2020-02-11 14:47:42', null, '4', '1');

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
