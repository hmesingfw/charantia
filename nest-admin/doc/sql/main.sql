/*
Navicat MySQL Data Transfer

Source Server         : 密码  woxihuanni
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : nest

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2021-06-03 23:23:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dict_key` varchar(32) DEFAULT NULL COMMENT '字典key',
  `dict_label` varchar(32) DEFAULT NULL COMMENT '字典名称',
  `dict_value` varchar(32) DEFAULT NULL COMMENT '字典值',
  `dict_desc` varchar(32) DEFAULT NULL COMMENT '字典描述',
  `is_lock` char(1) DEFAULT NULL COMMENT '是否内置： 1内置， 0非内置',
  `status` char(1) DEFAULT NULL COMMENT '状态： 1 启用 0 禁用',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------

-- ----------------------------
-- Table structure for ums_member
-- ----------------------------
DROP TABLE IF EXISTS `ums_member`;
CREATE TABLE `ums_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_level_id` bigint(20) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `phone` varchar(64) DEFAULT NULL COMMENT '手机号码',
  `status` int(1) DEFAULT NULL COMMENT '帐号启用状态:0->禁用；1->启用',
  `icon` varchar(500) DEFAULT NULL COMMENT '头像',
  `gender` int(1) DEFAULT NULL COMMENT '性别：0->未知；1->男；2->女',
  `birthday` varchar(20) DEFAULT NULL COMMENT '生日',
  `city` varchar(64) DEFAULT NULL COMMENT '所做城市',
  `job` varchar(100) DEFAULT NULL COMMENT '职业',
  `personalized_signature` varchar(200) DEFAULT NULL COMMENT '个性签名',
  `source_type` int(1) DEFAULT NULL COMMENT '用户来源',
  `integration` int(11) DEFAULT NULL COMMENT '积分',
  `growth` int(11) DEFAULT NULL COMMENT '成长值',
  `luckey_count` int(11) DEFAULT NULL COMMENT '剩余抽奖次数',
  `history_integration` int(11) DEFAULT NULL COMMENT '历史积分数量',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`),
  UNIQUE KEY `idx_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of ums_member
-- ----------------------------
INSERT INTO `ums_member` VALUES ('10', null, '张三', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('11', null, '张三1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('12', null, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('13', null, '2', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('14', null, '3', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('15', null, '4', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('16', null, '5', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('17', null, '6', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('18', null, '7', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('19', null, '8', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('20', null, '9', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('21', null, '10', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('22', null, '11', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('23', null, '12', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('24', null, '13', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('25', null, '14', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('26', null, '15', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('27', null, '张三15', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('28', null, '张三16', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('29', null, '张三17', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('30', null, '张三18', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('31', null, '张三19', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('32', null, '张三20', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('33', null, '张三21', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('34', null, '张三22', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('35', null, '张三23', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('36', null, '张三24', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('37', null, '张三25', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('38', null, '张三26', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('39', null, '张三27', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('40', null, '张三28', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('41', null, '张三29', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('42', null, '张三30', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('43', null, '张三31', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('44', null, '张三32', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('45', null, '张三33', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('52', null, '张三34', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('53', null, '张三3', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('54', null, '张三35', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('55', null, '张三36', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('56', null, '张三37', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('57', null, '张三38', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('58', null, '张三39', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ums_member` VALUES ('59', null, '张三40', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL,
  `account` varchar(40) NOT NULL,
  `name` varchar(40) NOT NULL,
  `password` varchar(255) NOT NULL,
  `password_salt` varchar(255) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `role` int(11) NOT NULL,
  `user_status` int(11) NOT NULL,
  `create_by` varchar(13) NOT NULL,
  `create_time` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `update_by` varchar(13) NOT NULL,
  `update_time` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '张三', '123456', '', '13272055845', '0', '0', '', '2021-05-06 14:45:05.000000', '', '2021-05-10 14:00:32.712090');
INSERT INTO `user` VALUES ('2', '', '', '', '', '', '0', '0', '', '2021-05-06 14:45:05.000000', '', '2021-05-26 14:45:11.000000');
