/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1  密码 woxihuanni
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : generate_table

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2019-10-23 22:57:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_body
-- ----------------------------
DROP TABLE IF EXISTS `sys_body`;
CREATE TABLE `sys_body` (
  `id` varchar(36) NOT NULL,
  `body` mediumtext COMMENT '主体内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_body
-- ----------------------------
INSERT INTO `sys_body` VALUES ('48ceaf30-d9df-11e9-99e7-13b3ae4ad8f7', null);

-- ----------------------------
-- Table structure for sys_enum
-- ----------------------------
DROP TABLE IF EXISTS `sys_enum`;
CREATE TABLE `sys_enum` (
  `id` varchar(36) NOT NULL,
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `value` varchar(50) DEFAULT NULL COMMENT '值',
  `group` varchar(50) DEFAULT NULL COMMENT '所属组',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='枚举管理';

-- ----------------------------
-- Records of sys_enum
-- ----------------------------
INSERT INTO `sys_enum` VALUES ('00c03980-ef5f-11e9-b7cd-6d62c79a0f67', '研发部', '2', 'department', null);
INSERT INTO `sys_enum` VALUES ('1f2e4580-e391-11e9-8b23-cb1106f3da48', '男', '1', 'sex', null);
INSERT INTO `sys_enum` VALUES ('88490280-e391-11e9-8b23-cb1106f3da48', '女', '0', 'sex', null);
INSERT INTO `sys_enum` VALUES ('db8b1400-ef5e-11e9-b7cd-6d62c79a0f67', '开发部', '1', 'department', null);

-- ----------------------------
-- Table structure for sys_main
-- ----------------------------
DROP TABLE IF EXISTS `sys_main`;
CREATE TABLE `sys_main` (
  `id` varchar(36) NOT NULL,
  `body_id` varchar(36) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL COMMENT '名称',
  `path` varchar(255) DEFAULT NULL COMMENT '路径',
  `is_cdn` char(1) DEFAULT NULL COMMENT '0 是   1   否',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `main_body` (`body_id`),
  CONSTRAINT `main_body` FOREIGN KEY (`body_id`) REFERENCES `sys_body` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_main
-- ----------------------------
INSERT INTO `sys_main` VALUES ('48ceaf30-d9df-11e9-99e7-13b3ae4ad8f7', '48ceaf30-d9df-11e9-99e7-13b3ae4ad8f7', '测试功能', null, '1', null, '2019-09-18 06:41:03', '2019-09-18 06:41:03');
