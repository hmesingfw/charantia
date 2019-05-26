/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1  密码 woxihuanni
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : charantia

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2019-05-26 21:46:12
*/

SET FOREIGN_KEY_CHECKS=0;

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
INSERT INTO `sys_menu` VALUES ('15576700139391557670013939155760', '0', 'path', '系统', 'system', null, '1', '2', null, null, '2019-05-12 14:06:53', '2019-05-12 14:06:53', null);
INSERT INTO `sys_menu` VALUES ('15576700139391557670013939155761', '0', 'path', '首页', 'index', null, '1', '999', null, null, '2019-05-12 14:06:53', '2019-05-12 14:06:53', null);
INSERT INTO `sys_menu` VALUES ('15576700139391557670013939155767', '15576700139391557670013939155760', 'path', '菜单', 'menus', null, '1', '2', null, null, '2019-05-12 14:06:53', '2019-05-26 13:19:25', null);
INSERT INTO `sys_menu` VALUES ('15576700139391557670013939155768', '15576700139391557670013939155760', 'path', '测试', 'demo2', null, '1', '3', null, null, '2019-05-12 14:06:53', '2019-05-26 13:02:13', null);
INSERT INTO `sys_menu` VALUES ('15588758182411558875818241155887', '0', 'path', '测试', 'test', null, '1', '1', '', null, '2019-05-26 13:03:38', '2019-05-26 13:03:38', null);
INSERT INTO `sys_menu` VALUES ('15588761119961558876111996155887', '0', 'path', '测试', 'test', null, '1', '1', '', null, '2019-05-26 13:08:31', '2019-05-26 13:08:31', null);
INSERT INTO `sys_menu` VALUES ('15588761514751558876151475155887', '0', 'path', '测试', 'test', null, '1', '1', '', null, '2019-05-26 13:09:11', '2019-05-26 13:09:11', null);
INSERT INTO `sys_menu` VALUES ('15588762920741558876292074155887', '0', 'path', '测试', 'test', null, '1', '1', '', null, '2019-05-26 13:11:32', '2019-05-26 13:11:32', null);
INSERT INTO `sys_menu` VALUES ('15588765620191558876562019155887', '0', 'path', '测试', 'test', null, '1', '1', '', null, '2019-05-26 13:16:02', '2019-05-26 13:16:02', null);

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
