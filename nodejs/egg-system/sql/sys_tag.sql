/*
Navicat MySQL Data Transfer

Source Server         : localhost woxihuanni
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : charantia_sys

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2020-04-27 18:02:49
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
  `status` char(1) DEFAULT NULL COMMENT '0 启用 1禁用',
  `sort` int(11) DEFAULT NULL COMMENT '排序  数值大排前',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_del` char(1) DEFAULT '0' COMMENT '0 正常 1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='枚举管理';

-- ----------------------------
-- Records of sys_enum
-- ----------------------------
INSERT INTO `sys_enum` VALUES ('11dffbfc-ef9f-45ec-9700-4608576f3806', '启用', '0', '5524af64-f0a3-46c5-a52a-9ffa1d7cd843', '0', '1', '2020-03-13 14:11:47', '2020-03-13 14:11:47', null, null, '0');
INSERT INTO `sys_enum` VALUES ('4229c981-6dc4-4d9a-be5e-c61072555089', '选择框', 'el-select', '5728b922-076b-42ac-8a77-772ec9adccad', '0', '9', '2020-02-17 06:57:33', '2020-02-21 03:15:05', null, '选择框', '0');
INSERT INTO `sys_enum` VALUES ('5524af64-f0a3-46c5-a52a-9ffa1d7cd843', '状态', 'statusList', '0', '0', '1', '2020-03-13 14:11:38', '2020-03-13 14:11:38', null, null, '0');
INSERT INTO `sys_enum` VALUES ('5728b922-076b-42ac-8a77-772ec9adccad', '组件', 'components', '0', '0', '1', '2020-02-11 14:48:19', '2020-02-24 06:05:33', null, '组件枚举', '0');
INSERT INTO `sys_enum` VALUES ('65e16d0e-4736-40f8-a6b9-41ce19768fe3', '计数器', 'el-input-number', '5728b922-076b-42ac-8a77-772ec9adccad', '0', '1', '2020-02-21 03:15:39', '2020-02-21 03:15:39', null, '计数器', '0');
INSERT INTO `sys_enum` VALUES ('738b71b2-d21b-423d-9577-7dfc93655609', '禁用', '1', '5524af64-f0a3-46c5-a52a-9ffa1d7cd843', '0', '1', '2020-03-13 14:11:53', '2020-03-13 14:11:53', null, null, '0');
INSERT INTO `sys_enum` VALUES ('ac00d2c9-316d-46b0-b5ae-216caf55f9bc', '开关选择器', 'el-switch', '5728b922-076b-42ac-8a77-772ec9adccad', '0', '1', '2020-03-14 06:31:47', '2020-03-14 06:31:55', null, '开关选择器', '0');
INSERT INTO `sys_enum` VALUES ('b98b5a69-ff48-411c-9a3b-eed78906fdfb', '输入框', 'el-input', '5728b922-076b-42ac-8a77-772ec9adccad', '0', '10', '2020-02-13 06:33:22', '2020-02-21 03:00:15', null, '输入框', '0');
INSERT INTO `sys_enum` VALUES ('d755cfee-b6e4-40a8-a47a-b2f7740a9441', '单选框', 'el-radio', '5728b922-076b-42ac-8a77-772ec9adccad', '0', '3', '2020-03-14 07:06:58', '2020-03-14 07:07:06', null, '单选框', '0');
INSERT INTO `sys_enum` VALUES ('e3f818e7-fbe3-444d-8215-0791ab7bd457', '日期选择器', 'el-date-picker', '5728b922-076b-42ac-8a77-772ec9adccad', '0', '1', '2020-02-21 03:05:58', '2020-03-14 07:14:50', null, '日期选择器', '0');

-- ----------------------------
-- Table structure for sys_generate_table
-- ----------------------------
DROP TABLE IF EXISTS `sys_generate_table`;
CREATE TABLE `sys_generate_table` (
  `id` varchar(36) NOT NULL,
  `table_name` varchar(128) DEFAULT NULL COMMENT '表名',
  `table_class` varchar(128) DEFAULT NULL COMMENT '实体名称',
  `comment` varchar(255) DEFAULT NULL COMMENT '说明',
  `author` varchar(32) DEFAULT NULL COMMENT '作者',
  `field_list` text COMMENT '字段列表',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` varchar(36) CHARACTER SET utf8 DEFAULT NULL,
  `details` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  `is_del` char(1) CHARACTER SET utf8 DEFAULT '0' COMMENT '0 正常 1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成表';

-- ----------------------------
-- Records of sys_generate_table
-- ----------------------------
INSERT INTO `sys_generate_table` VALUES ('1dfabf32-ec13-4671-a1de-8c3692766b37', 'sys_role', 'sysRole', '角色表', 'charantia', '[{\"field\":\"id\",\"type\":\"varchar(36)\",\"alias\":\"id\",\"comment\":\"\",\"key\":true,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"36\"],\"isHidden\":false,\"isNull\":true,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isTableHanlde\":false,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"code\",\"type\":\"varchar(32)\",\"alias\":\"code\",\"comment\":\"标识\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"32\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":true,\"isSort\":false,\"isTable\":true,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"name\",\"type\":\"varchar(32)\",\"alias\":\"name\",\"comment\":\"名称\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"32\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":true,\"isSort\":false,\"isTable\":true,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"status\",\"type\":\"char(1)\",\"alias\":\"status\",\"comment\":\"状态\",\"key\":false,\"component\":\"el-switch\",\"fieldType\":[\"char\"],\"maxlength\":[\"1\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":true,\"isSort\":false,\"isTable\":true,\"isTableHanlde\":true,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"statusList\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"remark\",\"type\":\"varchar(200)\",\"alias\":\"remark\",\"comment\":\"备注\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"200\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":true,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"created_at\",\"type\":\"datetime\",\"alias\":\"createdAt\",\"comment\":\"\",\"key\":false,\"component\":\"el-date-picker\",\"fieldType\":[\"datetime\"],\"maxlength\":null,\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isTableHanlde\":false,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"updated_at\",\"type\":\"datetime\",\"alias\":\"updatedAt\",\"comment\":\"更新时间\",\"key\":false,\"component\":\"el-date-picker\",\"fieldType\":[\"datetime\"],\"maxlength\":null,\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":true,\"isTable\":true,\"isTableHanlde\":false,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"user_id\",\"type\":\"varchar(36)\",\"alias\":\"userId\",\"comment\":\"\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"36\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isTableHanlde\":false,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"details\",\"type\":\"varchar(255)\",\"alias\":\"details\",\"comment\":\"\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"255\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isTableHanlde\":false,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"is_del\",\"type\":\"char(1)\",\"alias\":\"isDel\",\"comment\":\"\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"char\"],\"maxlength\":[\"1\"],\"isHidden\":true,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isTableHanlde\":false,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"0\"}]', '2020-04-23 01:59:48', '2020-04-23 06:35:10', null, null, '0');
INSERT INTO `sys_generate_table` VALUES ('51d3ec21-f2d2-477b-a4e1-a3a0b85aab01', 'sys_enum', 'sysEnum', '枚举表', '张三', '[{\"field\":\"id\",\"type\":\"varchar(36)\",\"alias\":\"id\",\"comment\":\"编号\",\"key\":true,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"36\"],\"isHidden\":true,\"isNull\":true,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"enumType\":\"\",\"matchType\":\"=\"},{\"field\":\"title\",\"type\":\"varchar(50)\",\"alias\":\"title\",\"comment\":\"枚举名称\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"50\"],\"isHidden\":false,\"isNull\":true,\"isQuery\":true,\"isSort\":false,\"isTable\":true,\"enumType\":\"\",\"matchType\":\"=\",\"isWriteonly\":true},{\"field\":\"value\",\"type\":\"varchar(50)\",\"alias\":\"value\",\"comment\":\"枚举值\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"50\"],\"isHidden\":false,\"isNull\":true,\"isQuery\":true,\"isSort\":false,\"isTable\":true,\"enumType\":\"\",\"matchType\":\"=\",\"isWriteonly\":true,\"isReadonly\":true},{\"field\":\"parent_id\",\"type\":\"varchar(36)\",\"alias\":\"parentId\",\"comment\":\"\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"36\"],\"isHidden\":false,\"isNull\":true,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"enumType\":\"\",\"matchType\":\"=\"},{\"field\":\"status\",\"type\":\"varchar(1)\",\"alias\":\"status\",\"comment\":\"状态\",\"key\":false,\"component\":\"el-radio\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"1\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":true,\"isSort\":false,\"isTable\":true,\"enumType\":\"statusList\",\"matchType\":\"=\",\"isWriteonly\":true,\"isReadonly\":false},{\"field\":\"sort\",\"type\":\"int(11)\",\"alias\":\"sort\",\"comment\":\"排序\",\"key\":false,\"component\":\"el-input-number\",\"fieldType\":[\"int\"],\"maxlength\":[\"11\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":true,\"isTable\":true,\"enumType\":\"\",\"matchType\":\"=\",\"isWriteonly\":true,\"isReadonly\":false},{\"field\":\"created_at\",\"type\":\"datetime\",\"alias\":\"createdAt\",\"comment\":\"创建时间\",\"key\":false,\"component\":\"el-date-picker\",\"fieldType\":[\"datetime\"],\"maxlength\":null,\"isHidden\":true,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"enumType\":\"\",\"matchType\":\"=\"},{\"field\":\"updated_at\",\"type\":\"datetime\",\"alias\":\"updatedAt\",\"comment\":\"更新时间\",\"key\":false,\"component\":\"el-date-picker\",\"fieldType\":[\"datetime\"],\"maxlength\":null,\"isHidden\":true,\"isNull\":false,\"isQuery\":false,\"isSort\":true,\"isTable\":true,\"enumType\":\"\",\"matchType\":\"=\",\"isWriteonly\":true},{\"field\":\"user_id\",\"type\":\"varchar(36)\",\"alias\":\"userId\",\"comment\":\"\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"36\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"enumType\":\"\",\"matchType\":\"=\"},{\"field\":\"details\",\"type\":\"varchar(255)\",\"alias\":\"details\",\"comment\":\"备注\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"255\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":true,\"enumType\":\"\",\"matchType\":\"=\",\"isWriteonly\":true},{\"field\":\"is_del\",\"type\":\"varchar(1)\",\"alias\":\"isDel\",\"comment\":\"删除标识\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"1\"],\"isHidden\":true,\"isNull\":false,\"isQuery\":true,\"isSort\":false,\"isTable\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"0\"}]', '2020-02-25 02:34:05', '2020-03-14 07:18:35', null, '你好啊', '0');
INSERT INTO `sys_generate_table` VALUES ('5eb6a025-cf4c-4b03-9cc1-f2c27a14cefb', null, null, null, null, '[{\"field\":\"id\",\"type\":\"varchar(36)\",\"alias\":\"id\",\"comment\":\"\",\"key\":true,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"36\"],\"isHidden\":true,\"isNull\":true,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"code\",\"type\":\"varchar(32)\",\"alias\":\"code\",\"comment\":\"标识\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"32\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":true,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"name\",\"type\":\"varchar(32)\",\"alias\":\"name\",\"comment\":\"名称\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"32\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":true,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"status\",\"type\":\"char(1)\",\"alias\":\"status\",\"comment\":\"状态\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"char\"],\"maxlength\":[\"1\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":true,\"isTableHanlde\":true,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"remark\",\"type\":\"varchar(200)\",\"alias\":\"remark\",\"comment\":\"\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"200\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":true,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"created_at\",\"type\":\"datetime\",\"alias\":\"createdAt\",\"comment\":\"\",\"key\":false,\"component\":\"el-date-picker\",\"fieldType\":[\"datetime\"],\"maxlength\":null,\"isHidden\":true,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"updated_at\",\"type\":\"datetime\",\"alias\":\"updatedAt\",\"comment\":\"\",\"key\":false,\"component\":\"el-date-picker\",\"fieldType\":[\"datetime\"],\"maxlength\":null,\"isHidden\":true,\"isNull\":false,\"isQuery\":false,\"isSort\":true,\"isTable\":false,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"user_id\",\"type\":\"varchar(36)\",\"alias\":\"userId\",\"comment\":\"\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"36\"],\"isHidden\":true,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"details\",\"type\":\"varchar(255)\",\"alias\":\"details\",\"comment\":\"\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"255\"],\"isHidden\":true,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"is_del\",\"type\":\"char(1)\",\"alias\":\"isDel\",\"comment\":\"\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"char\"],\"maxlength\":[\"1\"],\"isHidden\":true,\"isNull\":false,\"isQuery\":true,\"isSort\":false,\"isTable\":false,\"isTableHanlde\":false,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"0\"}]', '2020-04-23 02:00:10', '2020-04-23 02:00:22', null, null, '1');
INSERT INTO `sys_generate_table` VALUES ('6ff1818a-4615-41d3-b2df-5be5442edbc8', 'sys_user', 'sysUser', '用户表', 'charantia', '[{\"field\":\"id\",\"type\":\"varchar(36)\",\"alias\":\"id\",\"comment\":\"编号\",\"key\":true,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"36\"],\"isHidden\":false,\"isNull\":true,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"phone\",\"type\":\"varchar(16)\",\"alias\":\"phone\",\"comment\":\"手机号\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"16\"],\"isHidden\":false,\"isNull\":true,\"isQuery\":true,\"isSort\":false,\"isTable\":true,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"password\",\"type\":\"varchar(32)\",\"alias\":\"password\",\"comment\":\"密码\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"32\"],\"isHidden\":false,\"isNull\":true,\"isQuery\":false,\"isSort\":false,\"isTable\":true,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"name\",\"type\":\"varchar(128)\",\"alias\":\"name\",\"comment\":\"姓名\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"128\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":true,\"isSort\":false,\"isTable\":true,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"status\",\"type\":\"varchar(1)\",\"alias\":\"status\",\"comment\":\"状态\",\"key\":false,\"component\":\"el-switch\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"1\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":true,\"isSort\":false,\"isTable\":true,\"isWriteonly\":true,\"isReadonly\":false,\"enumType\":\"statusList\",\"matchType\":\"=\",\"defaultValue\":\"\",\"isTableHanlde\":true},{\"field\":\"created_at\",\"type\":\"datetime\",\"alias\":\"createdAt\",\"comment\":\"创建时间\",\"key\":false,\"component\":\"el-date-picker\",\"fieldType\":[\"datetime\"],\"maxlength\":null,\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"updated_at\",\"type\":\"datetime\",\"alias\":\"updatedAt\",\"comment\":\"更新时间\",\"key\":false,\"component\":\"el-date-picker\",\"fieldType\":[\"datetime\"],\"maxlength\":null,\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":true,\"isTable\":false,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"user_id\",\"type\":\"varchar(36)\",\"alias\":\"userId\",\"comment\":\"操作人\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"36\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"details\",\"type\":\"varchar(255)\",\"alias\":\"details\",\"comment\":\"备注\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"255\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":true,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"\"},{\"field\":\"is_del\",\"type\":\"varchar(1)\",\"alias\":\"isDel\",\"comment\":\"删除标识\",\"key\":false,\"component\":\"el-input\",\"fieldType\":[\"varchar\"],\"maxlength\":[\"1\"],\"isHidden\":false,\"isNull\":false,\"isQuery\":false,\"isSort\":false,\"isTable\":false,\"isWriteonly\":false,\"isReadonly\":false,\"enumType\":\"\",\"matchType\":\"=\",\"defaultValue\":\"0\"}]', '2020-03-17 14:44:54', '2020-04-24 03:36:20', null, null, '0');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` varchar(36) NOT NULL,
  `parent_id` varchar(36) DEFAULT '0',
  `path` varchar(255) DEFAULT '' COMMENT '菜单路径',
  `title` varchar(128) DEFAULT NULL COMMENT '标题',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `type` char(1) DEFAULT NULL,
  `par` varchar(64) DEFAULT NULL,
  `status` char(10) DEFAULT NULL COMMENT '状态',
  `show` char(1) DEFAULT NULL COMMENT '隐藏与显示',
  `sort` int(13) DEFAULT NULL COMMENT '权重',
  `icon` varchar(255) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `user_id` varchar(64) DEFAULT NULL COMMENT '用户',
  `is_del` char(1) DEFAULT NULL COMMENT '删除标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统菜单';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('17e4dc18-9e75-44af-97b0-b9344fcf0f23', '59ac6726-375f-4a84-9a8a-7fee50a3ca11', 'enum', '数据字典', '/sys/enum/index', '2', null, '0', '0', '1', 'guide', null, '2020-03-17 02:09:40', '2020-04-21 03:02:32', null, '0');
INSERT INTO `sys_menu` VALUES ('2aeaab86-bb3e-451b-818d-43adb9511fe9', '59ac6726-375f-4a84-9a8a-7fee50a3ca11', 'user', '用户管理', '/sys/user/index', '2', null, '0', '0', '30', 'guide', null, '2020-03-17 15:12:52', '2020-04-20 06:57:18', null, '0');
INSERT INTO `sys_menu` VALUES ('3001b9a9-b6c5-4bb7-a668-67f012458b61', '59ac6726-375f-4a84-9a8a-7fee50a3ca11', 'role', '角色管理', '/sys/role/index', '2', null, '0', '0', '1', 'guide', null, '2020-04-21 02:05:15', '2020-04-21 02:06:07', null, '0');
INSERT INTO `sys_menu` VALUES ('59ac6726-375f-4a84-9a8a-7fee50a3ca11', '0', '/sys', '系统管理', 'Layout', '1', null, '0', '0', '13', 'guide', '系统管理', '2020-03-15 14:27:20', '2020-04-20 06:57:12', null, '0');
INSERT INTO `sys_menu` VALUES ('6a9b4508-03ae-4f2a-9052-197f1948fc4e', 'ad387565-caa5-4235-8bea-33fd6b082c6f', 'table-detail', '基本配置', '/generate/table-detail', null, null, '0', '1', '1', 'guide', null, '2020-03-17 07:29:55', '2020-03-17 07:29:55', null, '0');
INSERT INTO `sys_menu` VALUES ('7ccc8e96-d5f1-4c06-9e6f-413458a6d055', 'ad387565-caa5-4235-8bea-33fd6b082c6f', 'index', '生成配置', '/generate/index', null, null, '0', '0', '2', 'guide', null, '2020-03-17 07:28:39', '2020-03-17 07:30:07', null, '0');
INSERT INTO `sys_menu` VALUES ('ad387565-caa5-4235-8bea-33fd6b082c6f', '0', '/generate', '生成管理', 'Layout', '1', null, '0', '0', '2', 'guide', null, '2020-03-17 07:26:53', '2020-04-20 06:57:34', null, '0');
INSERT INTO `sys_menu` VALUES ('e38e4cda-f3d7-44b9-9870-e6fea45c17a0', '59ac6726-375f-4a84-9a8a-7fee50a3ca11', 'tag', '标签管理', '/sys/tag/index', '2', null, '0', '0', '3', 'guide', null, '2020-03-17 01:58:03', '2020-04-20 06:57:22', null, '0');
INSERT INTO `sys_menu` VALUES ('fd3da9a9-a87f-4c82-9098-530e79877d03', '0', '/icon', '图标', '/icons/index', null, null, '0', '1', '1', 'icon', null, '2020-03-17 07:33:17', '2020-04-20 06:57:54', null, '0');
INSERT INTO `sys_menu` VALUES ('fd3da9a9-ccqd-4c82-9098-530e79877d03', '59ac6726-375f-4a84-9a8a-7fee50a3ca11', 'menu', '菜单管理', '/sys/menu/index', '2', null, '0', '0', '1', 'guide', null, '2020-03-17 07:33:17', '2020-04-20 06:57:30', null, '0');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(36) NOT NULL,
  `code` varchar(32) DEFAULT NULL COMMENT '标识',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  `status` char(1) DEFAULT '0' COMMENT '状态',
  `remark` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` varchar(36) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `is_del` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Index_1` (`id`,`code`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('7a6dc67d-20b6-4ee1-97a1-f49a7f400d85', '00020', '普通会员', '0', 'kkk', '2020-04-21 14:14:32', '2020-04-27 10:02:08', '4634424d-109a-4d51-9a53-cb900644ccd3', null, '0');
INSERT INTO `sys_role` VALUES ('bb837cb2-829c-4397-b0b3-3e061a2dd292', '0032', '部门', '0', null, '2020-04-22 02:42:33', '2020-04-22 06:17:26', '4634424d-109a-4d51-9a53-cb900644ccd3', null, '1');
INSERT INTO `sys_role` VALUES ('fa27bc3a-c5c7-472d-9b60-2dd26bf4b7b3', '0001', '超级管理员', '0', '43我5', '2020-04-21 02:54:40', '2020-04-27 09:02:56', '4634424d-109a-4d51-9a53-cb900644ccd3', null, '0');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` varchar(36) NOT NULL,
  `menu_id` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('fa27bc3a-c5c7-472d-9b60-2dd26bf4b7b3', '[\"59ac6726-375f-4a84-9a8a-7fee50a3ca11\",\"ad387565-caa5-4235-8bea-33fd6b082c6f\",\"2aeaab86-bb3e-451b-818d-43adb9511fe9\",\"e38e4cda-f3d7-44b9-9870-e6fea45c17a0\",\"17e4dc18-9e75-44af-97b0-b9344fcf0f23\",\"3001b9a9-b6c5-4bb7-a668-67f012458b61\",\"fd3da9a9-ccqd-4c82-9098-530e79877d03\",\"7ccc8e96-d5f1-4c06-9e6f-413458a6d055\",\"6a9b4508-03ae-4f2a-9052-197f1948fc4e\"]');

-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user` (
  `role_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES ('fa27bc3a-c5c7-472d-9b60-2dd26bf4b7b3', '4634424d-109a-4d51-9a53-cb900644ccd3');

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
  `is_del` char(1) DEFAULT '0' COMMENT '0 正常 1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统标签表';

-- ----------------------------
-- Records of sys_tag
-- ----------------------------
INSERT INTO `sys_tag` VALUES ('43eec8ee-b69f-40db-bed4-37ff6795bda9', '颜色', null, null, '1', '1', null, '2020-02-01 08:51:23', '2020-03-13 15:31:47', null, '0');
INSERT INTO `sys_tag` VALUES ('49d06b4f-dadb-49fd-96ab-b752a007d384', '你好', null, null, '1', '0', null, '2020-02-01 08:38:50', '2020-02-01 08:38:50', null, '0');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(36) NOT NULL,
  `phone` varchar(16) NOT NULL COMMENT '手机号',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `name` varchar(128) DEFAULT NULL COMMENT '姓名',
  `status` char(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `is_del` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('4634424d-109a-4d51-9a53-cb900644ccd3', 'admin', '123456', 'admin', '0', '2020-03-17 15:29:28', '2020-04-20 09:23:29', null, null, '0');
