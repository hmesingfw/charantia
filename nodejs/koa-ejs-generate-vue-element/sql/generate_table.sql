/*
Navicat MySQL Data Transfer

Source Server         : localhost  chensheng
Source Server Version : 50712
Source Host           : 127.0.0.1:3306
Source Database       : generate_table

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2019-09-18 17:36:28
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
