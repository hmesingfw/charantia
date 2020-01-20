/*
Navicat MySQL Data Transfer

Source Server         : localhost woxihuanni
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : charantia_sys

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2020-01-20 15:42:09
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
  `status` char(1) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL COMMENT '备注',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统标签表';

-- ----------------------------
-- Records of sys_tag
-- ----------------------------
INSERT INTO `sys_tag` VALUES ('0b99d960-65c4-4507-9b2f-78de01b7341b', 'sdfsd', null, null, '1', '0', null, '2020-01-20 06:12:25', '2020-01-20 06:12:25', null);
INSERT INTO `sys_tag` VALUES ('19f5bc7d-5a50-4114-9293-ed82581ea321', '你好', null, null, '1', '0', null, '2020-01-20 03:12:18', '2020-01-20 03:12:18', null);
INSERT INTO `sys_tag` VALUES ('32af2e48-438b-4a17-aba3-a545e57fa675', 'hh', null, null, '1', '0', null, '2020-01-20 06:09:12', '2020-01-20 06:09:12', null);
INSERT INTO `sys_tag` VALUES ('ff8d11df-5501-45e1-bdff-32efdebea9c9', 'list', null, null, '1', '0', null, '2020-01-20 06:16:31', '2020-01-20 06:16:31', null);
