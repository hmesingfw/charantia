/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1  密码 woxihuanni
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : charantia

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2019-07-02 17:09:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_demo
-- ----------------------------
DROP TABLE IF EXISTS `sys_demo`;
CREATE TABLE `sys_demo` (
  `id` varchar(64) NOT NULL,
  `name` varchar(40) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(10) DEFAULT NULL COMMENT '年龄',
  `adress` varchar(100) DEFAULT NULL COMMENT '地址',
  `code` varchar(30) DEFAULT NULL COMMENT '编码',
  `create_user` varchar(64) DEFAULT NULL COMMENT '创建者',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(64) DEFAULT NULL COMMENT '更新者',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='例样';

-- ----------------------------
-- Records of sys_demo
-- ----------------------------
INSERT INTO `sys_demo` VALUES ('1', null, null, null, null, null, null, null, null, null, '0');

-- ----------------------------
-- Table structure for sys_enum
-- ----------------------------
DROP TABLE IF EXISTS `sys_enum`;
CREATE TABLE `sys_enum` (
  `id` varchar(32) NOT NULL,
  `label_zh` varchar(100) NOT NULL COMMENT '枚举名称',
  `label_en` varchar(100) NOT NULL COMMENT '枚举名称 英文',
  `value` varchar(50) NOT NULL COMMENT '枚举名称',
  `type` varchar(50) NOT NULL COMMENT '枚举类型',
  `created_at` datetime DEFAULT NULL,
  `updated_user` varchar(32) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='枚举管理';

-- ----------------------------
-- Records of sys_enum
-- ----------------------------
INSERT INTO `sys_enum` VALUES ('15611233640261561123364026156112', '男', 'man', '1', 'sex', '2019-06-21 13:22:44', null, '2019-06-21 13:43:20', null);
INSERT INTO `sys_enum` VALUES ('15611245885791561124588579156112', '女', 'woman', '2', 'sex', '2019-06-21 13:43:08', null, '2019-06-25 07:56:36', null);
INSERT INTO `sys_enum` VALUES ('15611247429901561124742990156112', '输入', 'el-input', '1', 'componentType', '2019-06-21 13:45:42', null, '2019-06-21 13:45:42', null);
INSERT INTO `sys_enum` VALUES ('15611247429901561124742990156113', '选择', 'el-select', '2', 'componentType', '2019-06-21 13:45:42', null, '2019-06-21 13:45:42', null);
INSERT INTO `sys_enum` VALUES ('15611247429901561124742990156114', '日期时间', 'el-date-picker', '3', 'componentType', '2019-06-21 13:45:42', null, '2019-06-21 13:45:42', null);
INSERT INTO `sys_enum` VALUES ('15615302178801561530217880156153', '数字', 'el-input-number', '4', 'componentType', '2019-06-26 06:23:37', null, '2019-06-26 06:23:37', null);
INSERT INTO `sys_enum` VALUES ('15615303077391561530307739156153', '必填', 'required', '1', 'validate', '2019-06-26 06:25:07', null, '2019-06-26 06:26:21', null);
INSERT INTO `sys_enum` VALUES ('15615304011881561530401188156153', '数字', 'number', '2', 'validate', '2019-06-26 06:26:41', null, '2019-06-26 06:26:59', null);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` varchar(32) NOT NULL,
  `parentid` varchar(32) DEFAULT '0',
  `path` varchar(255) DEFAULT '' COMMENT '菜单路径',
  `title_zh` varchar(128) DEFAULT NULL COMMENT '标题',
  `title_en` varchar(128) DEFAULT NULL,
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `status` varchar(10) DEFAULT NULL,
  `show` varchar(1) DEFAULT NULL COMMENT '隐藏与显示',
  `sort` int(13) DEFAULT NULL COMMENT '权重',
  `icon` varchar(255) DEFAULT NULL,
  `user` varchar(64) DEFAULT NULL COMMENT '用户',
  `created_at` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统菜单';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('15576700139391557670013939155760', '0', '/sys', '系统', 'system', 'layout', '1', '1', '2', 'el-icon-document', null, '2019-05-12 14:06:53', '2019-06-04 02:32:13', null);
INSERT INTO `sys_menu` VALUES ('15576700139391557670013939155761', '0', '/index', '首页', 'index', 'layout', '1', '1', '999', 'el-icon-document', null, '2019-05-12 14:06:53', '2019-06-04 02:32:11', null);
INSERT INTO `sys_menu` VALUES ('15576700139391557670013939155767', '15576700139391557670013939155760', 'menus', '菜单', 'menus', '/menus/index', '1', '1', '2', 'el-icon-document', null, '2019-05-12 14:06:53', '2019-06-04 02:32:16', null);
INSERT INTO `sys_menu` VALUES ('15596160228141559616022814155961', '0', '/login', '登陆', 'login', '/login/index', '1', '0', '1', 'document', null, '2019-06-04 02:40:22', '2019-06-18 11:16:25', null);
INSERT INTO `sys_menu` VALUES ('15610206946541561020694654156102', '15576700139391557670013939155760', 'producer', '页面生成', 'PageProducer', '/producer/index', '1', '1', '1', 'el-icon-document', null, '2019-06-20 08:51:34', '2019-06-20 08:56:26', null);
INSERT INTO `sys_menu` VALUES ('15611038566801561103856680156110', '15576700139391557670013939155760', 'enum', '枚举', 'enum', '/enum/index', '1', '1', '1', 'el-icon-document', null, '2019-06-21 07:57:36', '2019-06-28 04:44:28', null);
INSERT INTO `sys_menu` VALUES ('15620566410181562056641018156205', '15576700139391557670013939155760', 'demo', '样例', 'demo', '/demo/index', '1', '1', '1', 'el-icon-document', null, '2019-07-02 08:37:21', '2019-07-02 08:37:36', null);

-- ----------------------------
-- Table structure for sys_office
-- ----------------------------
DROP TABLE IF EXISTS `sys_office`;
CREATE TABLE `sys_office` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `area_id` varchar(64) NOT NULL COMMENT '归属区域',
  `code` varchar(100) DEFAULT NULL COMMENT '区域编码',
  `type` char(1) NOT NULL COMMENT '机构类型',
  `grade` char(1) NOT NULL COMMENT '机构等级',
  `address` varchar(255) DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) DEFAULT NULL COMMENT '传真',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `USEABLE` varchar(64) DEFAULT NULL COMMENT '是否启用',
  `PRIMARY_PERSON` varchar(64) DEFAULT NULL COMMENT '主负责人',
  `DEPUTY_PERSON` varchar(64) DEFAULT NULL COMMENT '副负责人',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构表';

-- ----------------------------
-- Records of sys_office
-- ----------------------------
