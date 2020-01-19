/*
Navicat MySQL Data Transfer

Source Server         : localhost woxihuanni
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : charantia_sys

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2020-01-19 16:41:49
*/

SET FOREIGN_KEY_CHECKS=0;

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
  `details` varchar(255) DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统标签表';

-- ----------------------------
-- Records of sys_tag
-- ----------------------------
INSERT INTO `sys_tag` VALUES ('1', '1', '1', '1', '1', '1', '2020-01-23 16:09:51', '2020-01-28 16:09:55', '1');
