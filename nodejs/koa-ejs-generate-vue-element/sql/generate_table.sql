/*
Navicat MySQL Data Transfer

Source Server         : localhost  chensheng
Source Server Version : 50712
Source Host           : 127.0.0.1:3306
Source Database       : generate_table

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2019-09-16 15:56:09
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

-- ----------------------------
-- Table structure for sys_main
-- ----------------------------
DROP TABLE IF EXISTS `sys_main`;
CREATE TABLE `sys_main` (
  `id` varchar(36) NOT NULL,
  `body_id` varchar(32) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL COMMENT '名称',
  `path` varchar(255) DEFAULT NULL COMMENT '路径',
  `is_cdn` char(1) DEFAULT NULL COMMENT '0 是   1   否',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_main
-- ----------------------------
INSERT INTO `sys_main` VALUES ('1', '1', '测试1', '1', '1', '1', '2019-09-11 10:40:00', '2019-09-11 10:40:04');
INSERT INTO `sys_main` VALUES ('4', '1', '测试4', '1', '1', '1', '2019-09-11 10:40:00', '2019-09-12 10:40:04');
INSERT INTO `sys_main` VALUES ('9919b890-d84a-11e9-97ba-6de424d37f26', null, 'cse', null, '1', null, '2019-09-16 06:24:11', '2019-09-16 06:24:11');
