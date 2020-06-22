/*
Navicat MySQL Data Transfer

Source Server         : 172.18.15.5 jeff1234
Source Server Version : 50723
Source Host           : 172.18.15.5:3306
Source Database       : coc_platform

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2020-06-22 17:41:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for biz_album
-- ----------------------------
DROP TABLE IF EXISTS `biz_album`;
CREATE TABLE `biz_album` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `album_title` varchar(32) DEFAULT NULL COMMENT '相册标题',
  `album_desc` varchar(255) DEFAULT NULL COMMENT '相册描述',
  `album_cover` bigint(20) NOT NULL COMMENT '封面图片',
  `allow_comment` tinyint(1) DEFAULT NULL COMMENT '0 不开启 1 开启',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`album_title`,`created_time`,`created_by`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='相册表';

-- ----------------------------
-- Records of biz_album
-- ----------------------------
INSERT INTO `biz_album` VALUES ('1', '1', '1', '1', '1', '1', '2020-06-12 15:11:11', '1', '2020-06-12 15:11:11', '1', '1');
INSERT INTO `biz_album` VALUES ('2', '2', '2', '2', '2', '1', '2020-06-12 15:11:26', '1', '2020-06-12 15:11:26', '1', '1');

-- ----------------------------
-- Table structure for biz_album_file
-- ----------------------------
DROP TABLE IF EXISTS `biz_album_file`;
CREATE TABLE `biz_album_file` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `album_id` bigint(20) NOT NULL COMMENT '相册ID',
  `file_id` bigint(20) NOT NULL COMMENT '文件ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`album_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='相册文件表';

-- ----------------------------
-- Records of biz_album_file
-- ----------------------------

-- ----------------------------
-- Table structure for biz_article
-- ----------------------------
DROP TABLE IF EXISTS `biz_article`;
CREATE TABLE `biz_article` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(32) DEFAULT NULL COMMENT '标题',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `category_id` bigint(20) NOT NULL COMMENT '分类',
  `cover_id` bigint(20) NOT NULL COMMENT '封面',
  `author` varchar(32) DEFAULT NULL COMMENT '作者',
  `view_count` int(11) DEFAULT '0' COMMENT '阅读数',
  `comment_count` int(11) DEFAULT '0' COMMENT '评论数',
  `collection_count` int(11) DEFAULT '0' COMMENT '收藏数',
  `post_time` datetime DEFAULT NULL COMMENT '发布时间',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `is_top` tinyint(1) DEFAULT '0' COMMENT '置顶',
  `is_open_comment` tinyint(1) DEFAULT '0' COMMENT '开启评论',
  `is_original` tinyint(1) DEFAULT '0' COMMENT '原创',
  `is_recommend` tinyint(1) DEFAULT '0' COMMENT '推荐',
  `post_status` tinyint(1) DEFAULT '1' COMMENT '发布状态',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`title`,`category_id`,`post_time`,`status`,`sort`,`post_status`,`created_time`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='资讯表';

-- ----------------------------
-- Records of biz_article
-- ----------------------------
INSERT INTO `biz_article` VALUES ('1', '商会在线', '描述', '2', '1', '作者', '0', '0', '0', '2020-06-18 10:30:20', '99', '0', '0', '0', '0', '1', '1', '2020-06-18 11:24:13', null, '2020-06-18 11:24:13', null, '1');
INSERT INTO `biz_article` VALUES ('2', '商会简介', '描述', '2', '1', '作者', '0', '0', '0', '2020-06-18 10:30:20', '99', '0', '0', '0', '0', '1', '1', '2020-06-18 11:25:13', null, '2020-06-18 11:25:13', null, '1');

-- ----------------------------
-- Table structure for biz_article_category
-- ----------------------------
DROP TABLE IF EXISTS `biz_article_category`;
CREATE TABLE `biz_article_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(32) DEFAULT NULL COMMENT '分类名称',
  `parent_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '父ID',
  `can_post` tinyint(1) DEFAULT '0' COMMENT '前台是否可以投稿',
  `need_audit` tinyint(1) DEFAULT '0' COMMENT '是否需要审核',
  `icon_id` bigint(20) NOT NULL COMMENT '图标',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `is_show` tinyint(1) DEFAULT '1' COMMENT '是否显示',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`title`,`parent_id`,`sort`,`is_show`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='资讯分类表';

-- ----------------------------
-- Records of biz_article_category
-- ----------------------------
INSERT INTO `biz_article_category` VALUES ('1', '商会', '0', '0', '0', '1', '99', '1', '2020-06-18 10:52:52', null, '2020-06-18 10:52:52', null, '1', '1');
INSERT INTO `biz_article_category` VALUES ('2', '商会在线', '1', '0', '0', '1', '99', '1', '2020-06-18 10:53:24', null, '2020-06-18 10:53:24', null, '1', '1');

-- ----------------------------
-- Table structure for biz_article_detail
-- ----------------------------
DROP TABLE IF EXISTS `biz_article_detail`;
CREATE TABLE `biz_article_detail` (
  `article_id` bigint(20) NOT NULL COMMENT '资讯ID',
  `content` text COMMENT '内容',
  `template` text COMMENT '模板',
  `images` varchar(1024) DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资讯详情表';

-- ----------------------------
-- Records of biz_article_detail
-- ----------------------------

-- ----------------------------
-- Table structure for biz_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `biz_article_tag`;
CREATE TABLE `biz_article_tag` (
  `article_id` bigint(20) unsigned NOT NULL COMMENT '资讯ID',
  `tag_id` bigint(20) unsigned NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`article_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资讯标签表';

-- ----------------------------
-- Records of biz_article_tag
-- ----------------------------

-- ----------------------------
-- Table structure for biz_event
-- ----------------------------
DROP TABLE IF EXISTS `biz_event`;
CREATE TABLE `biz_event` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(32) DEFAULT NULL COMMENT '活动名称',
  `cover_id` bigint(20) unsigned NOT NULL COMMENT '封面ID',
  `description` text COMMENT '活动内容',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `province` int(11) DEFAULT NULL COMMENT '省',
  `city` int(11) DEFAULT NULL COMMENT '市',
  `country` int(11) DEFAULT NULL COMMENT '县',
  `address` varchar(128) DEFAULT NULL COMMENT '活动地点',
  `limit_count` int(11) DEFAULT '0' COMMENT '活动人数',
  `images` varchar(512) DEFAULT NULL COMMENT '宣传图片json',
  `attention_count` int(11) DEFAULT '0' COMMENT '报名人数',
  `view_count` int(11) DEFAULT '0' COMMENT '查看人数',
  `sign_count` int(11) DEFAULT '0' COMMENT '签到人数',
  `is_recommend` tinyint(1) DEFAULT '0' COMMENT '是否推荐',
  `is_top` tinyint(1) DEFAULT '0' COMMENT '是否置顶',
  `is_verify` tinyint(1) DEFAULT '0' COMMENT '开启签到验证码',
  `is_public` tinyint(1) DEFAULT '1' COMMENT '是否公开',
  `is_free` tinyint(1) DEFAULT '0' COMMENT '是否收费',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_id` (`tenant_id`,`start_time`,`end_time`,`title`,`expire_time`,`status`,`created_time`,`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动信息表';

-- ----------------------------
-- Records of biz_event
-- ----------------------------

-- ----------------------------
-- Table structure for biz_event_attend
-- ----------------------------
DROP TABLE IF EXISTS `biz_event_attend`;
CREATE TABLE `biz_event_attend` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `event_id` bigint(20) NOT NULL COMMENT '活动ID',
  `attend_time` datetime NOT NULL COMMENT '报名时间',
  `name` varchar(64) NOT NULL COMMENT '姓名',
  `mobile` varchar(32) NOT NULL COMMENT '手机',
  `remark` varchar(32) DEFAULT NULL COMMENT '说明',
  `ticket_id` bigint(20) NOT NULL COMMENT '收费ID',
  `ticket_name` varchar(32) DEFAULT NULL COMMENT '收费名称',
  `ticket_price` int(11) DEFAULT NULL COMMENT '单价',
  `order_no` varchar(16) DEFAULT NULL COMMENT '订单编号',
  `custom_data` varchar(2048) DEFAULT NULL COMMENT '扩展数据json',
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '审核状态',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `auditor` bigint(20) NOT NULL COMMENT '审核人',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`event_id`,`attend_time`,`name`,`mobile`,`audit_status`,`order_no`,`status`,`created_time`,`created_by`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报名表';

-- ----------------------------
-- Records of biz_event_attend
-- ----------------------------

-- ----------------------------
-- Table structure for biz_event_comment
-- ----------------------------
DROP TABLE IF EXISTS `biz_event_comment`;
CREATE TABLE `biz_event_comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `event_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '活动id',
  `content` varchar(512) DEFAULT NULL COMMENT '评论内容',
  `pid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父节点ID',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `idx_comment` (`tenant_id`,`event_id`,`pid`,`created_time`,`created_by`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动评论表';

-- ----------------------------
-- Records of biz_event_comment
-- ----------------------------

-- ----------------------------
-- Table structure for biz_event_follow
-- ----------------------------
DROP TABLE IF EXISTS `biz_event_follow`;
CREATE TABLE `biz_event_follow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `event_id` bigint(20) unsigned NOT NULL COMMENT '活动ID',
  `view_time` datetime DEFAULT NULL COMMENT '查看时间',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`event_id`,`view_time`,`uid`,`created_time`,`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动关注表';

-- ----------------------------
-- Records of biz_event_follow
-- ----------------------------

-- ----------------------------
-- Table structure for biz_event_sign
-- ----------------------------
DROP TABLE IF EXISTS `biz_event_sign`;
CREATE TABLE `biz_event_sign` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `attend_id` bigint(20) NOT NULL COMMENT '报名号',
  `event_id` bigint(20) NOT NULL COMMENT '活动ID',
  `name` varchar(64) DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机',
  `lat` varchar(32) DEFAULT NULL COMMENT '签到经度',
  `lng` varchar(32) DEFAULT NULL COMMENT '签到纬度',
  `browser` varchar(32) DEFAULT NULL COMMENT '浏览器',
  `os` varchar(32) DEFAULT NULL COMMENT '操作系统',
  `ip` varchar(32) DEFAULT NULL COMMENT 'IP地址',
  `source` varchar(32) DEFAULT NULL COMMENT '邮件/手机/app/二维码',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_2` (`tenant_id`,`event_id`,`attend_id`,`name`,`mobile`,`status`,`created_by`,`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='签到表';

-- ----------------------------
-- Records of biz_event_sign
-- ----------------------------

-- ----------------------------
-- Table structure for biz_event_tag
-- ----------------------------
DROP TABLE IF EXISTS `biz_event_tag`;
CREATE TABLE `biz_event_tag` (
  `event_id` bigint(20) unsigned NOT NULL COMMENT '活动ID',
  `tag_id` bigint(20) unsigned NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`event_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动标签表';

-- ----------------------------
-- Records of biz_event_tag
-- ----------------------------

-- ----------------------------
-- Table structure for biz_event_ticket
-- ----------------------------
DROP TABLE IF EXISTS `biz_event_ticket`;
CREATE TABLE `biz_event_ticket` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `event_id` bigint(20) unsigned NOT NULL COMMENT '活动ID',
  `ticket_title` varchar(32) DEFAULT NULL COMMENT '收费名称',
  `ticket_price` int(11) DEFAULT NULL COMMENT '价格',
  `ticket_stock` int(11) DEFAULT NULL COMMENT '库存数量',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`event_id`,`ticket_title`,`ticket_stock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动收费';

-- ----------------------------
-- Records of biz_event_ticket
-- ----------------------------

-- ----------------------------
-- Table structure for biz_feed
-- ----------------------------
DROP TABLE IF EXISTS `biz_feed`;
CREATE TABLE `biz_feed` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(32) DEFAULT NULL COMMENT '标题',
  `content` varchar(512) DEFAULT NULL COMMENT '内容',
  `images` varchar(512) DEFAULT NULL COMMENT '图片(json 9张图片)',
  `like_count` int(10) DEFAULT '0' COMMENT '点赞数',
  `comment_count` int(10) DEFAULT '0' COMMENT '评论数',
  `view_count` int(10) DEFAULT '0' COMMENT '浏览数',
  `collect_count` int(10) DEFAULT '0' COMMENT '收藏数',
  `is_recommend` tinyint(1) DEFAULT '0' COMMENT '是否推荐',
  `is_top` tinyint(1) DEFAULT '0' COMMENT '是否置顶',
  `pid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父节点ID',
  `is_pub` tinyint(1) DEFAULT '1' COMMENT '是否公开',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_2` (`tenant_id`,`pid`,`created_by`,`title`,`created_time`,`updated_time`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商会圈(个人动态)表';

-- ----------------------------
-- Records of biz_feed
-- ----------------------------
INSERT INTO `biz_feed` VALUES ('1', '流年', '光阴似箭,岁月如梭', null, '0', '0', '0', '0', '0', '0', '0', '1', '1', '2020-06-22 16:30:41', null, '2020-06-22 16:30:41', null, '1');
INSERT INTO `biz_feed` VALUES ('2', '流年', '光阴似箭,岁月如梭', '[aad,bb,ccc]', '0', '0', '0', '0', '0', '0', '0', '1', '1', '2020-06-22 16:38:04', null, '2020-06-22 16:38:04', null, '1');

-- ----------------------------
-- Table structure for biz_feed_tag
-- ----------------------------
DROP TABLE IF EXISTS `biz_feed_tag`;
CREATE TABLE `biz_feed_tag` (
  `feeds_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '圈子ID',
  `tag_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '标签ID',
  PRIMARY KEY (`feeds_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='圈子标签表';

-- ----------------------------
-- Records of biz_feed_tag
-- ----------------------------

-- ----------------------------
-- Table structure for biz_netdisk_capacity
-- ----------------------------
DROP TABLE IF EXISTS `biz_netdisk_capacity`;
CREATE TABLE `biz_netdisk_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `capacity` int(10) DEFAULT NULL COMMENT '总容量',
  `used_capacity` int(10) DEFAULT NULL COMMENT '已经使用容量',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网盘容量表';

-- ----------------------------
-- Records of biz_netdisk_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for biz_netdisk_capacity_log
-- ----------------------------
DROP TABLE IF EXISTS `biz_netdisk_capacity_log`;
CREATE TABLE `biz_netdisk_capacity_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `capacity` int(10) DEFAULT NULL COMMENT '变化容量',
  `left_capacity` varchar(32) DEFAULT NULL COMMENT '剩余容量',
  `remark` varchar(32) DEFAULT NULL COMMENT '说明',
  `type` tinyint(1) DEFAULT NULL COMMENT '增/减',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`uid`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网盘容量日志表';

-- ----------------------------
-- Records of biz_netdisk_capacity_log
-- ----------------------------

-- ----------------------------
-- Table structure for biz_netdisk_category
-- ----------------------------
DROP TABLE IF EXISTS `biz_netdisk_category`;
CREATE TABLE `biz_netdisk_category` (
  `code` varchar(16) NOT NULL COMMENT 'documnet/picture/other',
  `name` varchar(32) DEFAULT NULL COMMENT '文档  图片  其他',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网盘文件分类';

-- ----------------------------
-- Records of biz_netdisk_category
-- ----------------------------

-- ----------------------------
-- Table structure for biz_netdisk_file
-- ----------------------------
DROP TABLE IF EXISTS `biz_netdisk_file`;
CREATE TABLE `biz_netdisk_file` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `moudle_code` varchar(16) DEFAULT NULL COMMENT '模块code',
  `file_name` varchar(128) DEFAULT NULL COMMENT '文件名',
  `save_name` varchar(128) DEFAULT NULL COMMENT '存储文件名',
  `file_url` varchar(512) DEFAULT NULL COMMENT '文件访问路径',
  `size` int(11) DEFAULT NULL COMMENT '文件大小',
  `suffix` varchar(32) DEFAULT NULL COMMENT '文件后缀',
  `type` tinyint(1) DEFAULT NULL COMMENT '0 目录 1 文件',
  `md5` varchar(128) DEFAULT NULL COMMENT '文件MD5',
  `pid` bigint(20) DEFAULT NULL COMMENT '上级ID',
  `width` int(10) DEFAULT NULL COMMENT '图片宽度',
  `height` int(10) DEFAULT NULL COMMENT '图片高度',
  `category_code` varchar(32) DEFAULT NULL COMMENT '文档分类',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`created_by`,`category_code`,`created_time`,`file_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网盘文件表';

-- ----------------------------
-- Records of biz_netdisk_file
-- ----------------------------

-- ----------------------------
-- Table structure for biz_netdisk_module
-- ----------------------------
DROP TABLE IF EXISTS `biz_netdisk_module`;
CREATE TABLE `biz_netdisk_module` (
  `code` varchar(16) NOT NULL COMMENT '模块code',
  `name` varchar(32) DEFAULT NULL COMMENT '模块名称',
  `description` varchar(32) DEFAULT NULL COMMENT '模块描述',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网盘模块表';

-- ----------------------------
-- Records of biz_netdisk_module
-- ----------------------------

-- ----------------------------
-- Table structure for biz_netdisk_share
-- ----------------------------
DROP TABLE IF EXISTS `biz_netdisk_share`;
CREATE TABLE `biz_netdisk_share` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `file_id` bigint(20) unsigned NOT NULL COMMENT '文件ID',
  `to_uid` bigint(20) unsigned NOT NULL COMMENT '分享给谁',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`created_by`,`created_time`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网盘分享表';

-- ----------------------------
-- Records of biz_netdisk_share
-- ----------------------------

-- ----------------------------
-- Table structure for biz_netdisk_suffix
-- ----------------------------
DROP TABLE IF EXISTS `biz_netdisk_suffix`;
CREATE TABLE `biz_netdisk_suffix` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `category_code` varchar(16) DEFAULT NULL COMMENT '分类标识',
  `suffix` varchar(32) DEFAULT NULL COMMENT '文件后缀',
  `name` varchar(32) DEFAULT NULL COMMENT '中文名称',
  `icon` longtext COMMENT '存储图片数据',
  `bigicon` longtext COMMENT '存储图片数据',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网盘文件分类对应表';

-- ----------------------------
-- Records of biz_netdisk_suffix
-- ----------------------------

-- ----------------------------
-- Table structure for biz_page
-- ----------------------------
DROP TABLE IF EXISTS `biz_page`;
CREATE TABLE `biz_page` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `page_type` varchar(32) DEFAULT NULL COMMENT '单页类型',
  `title` varchar(32) DEFAULT NULL COMMENT '标题',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `content` varchar(2048) DEFAULT NULL COMMENT '内容',
  `page_group` varchar(32) DEFAULT NULL COMMENT '分组',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`page_group`,`page_type`,`title`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='单页表';

-- ----------------------------
-- Records of biz_page
-- ----------------------------
INSERT INTO `biz_page` VALUES ('1', 'xtxy', '系统协议', '1', '系统协议', '1', '1', '2020-06-12 15:42:42', '1', '2020-06-12 15:42:42', '1', '1');
INSERT INTO `biz_page` VALUES ('2', 'rhsq', '入会申请', '2', '入会申请', '2', '1', '2020-06-12 15:42:52', '2', '2020-06-12 15:42:52', '2', '2');

-- ----------------------------
-- Table structure for biz_revenue
-- ----------------------------
DROP TABLE IF EXISTS `biz_revenue`;
CREATE TABLE `biz_revenue` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `category_id` bigint(20) NOT NULL COMMENT '会计科目ID',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 增加 0 减少',
  `amount` int(11) DEFAULT NULL COMMENT '金额',
  `reg_date` datetime DEFAULT NULL COMMENT '登记日期',
  `organize` varchar(128) DEFAULT NULL COMMENT '收款单位',
  `remark` varchar(64) DEFAULT NULL COMMENT '摘要',
  `bill_images` varchar(512) DEFAULT NULL COMMENT '支付凭证',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`reg_date`,`category_id`,`type`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收支明细表';

-- ----------------------------
-- Records of biz_revenue
-- ----------------------------

-- ----------------------------
-- Table structure for biz_revenue_category
-- ----------------------------
DROP TABLE IF EXISTS `biz_revenue_category`;
CREATE TABLE `biz_revenue_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  `description` varchar(32) DEFAULT NULL COMMENT '描述',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `pid` int(10) unsigned DEFAULT '0' COMMENT '父节点ID',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收支科目表';

-- ----------------------------
-- Records of biz_revenue_category
-- ----------------------------

-- ----------------------------
-- Table structure for biz_vote
-- ----------------------------
DROP TABLE IF EXISTS `biz_vote`;
CREATE TABLE `biz_vote` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(32) DEFAULT NULL COMMENT '标题',
  `thumb` varchar(128) DEFAULT NULL COMMENT '缩略图',
  `keywords` varchar(32) DEFAULT NULL COMMENT '关键字',
  `description` varchar(512) DEFAULT NULL COMMENT '投票介绍',
  `content` text COMMENT '内容',
  `background` varchar(128) DEFAULT NULL COMMENT '背景图json',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `vote_num` int(11) DEFAULT '0' COMMENT '投票数',
  `is_public` tinyint(1) DEFAULT '1' COMMENT '是否公开',
  `is_recommend` tinyint(1) DEFAULT '0' COMMENT '是否推荐',
  `is_top` tinyint(1) DEFAULT '0' COMMENT '是否置顶',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `idx_vote` (`tenant_id`,`created_by`,`created_time`,`title`,`start_time`,`end_time`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票表';

-- ----------------------------
-- Records of biz_vote
-- ----------------------------

-- ----------------------------
-- Table structure for biz_vote_config
-- ----------------------------
DROP TABLE IF EXISTS `biz_vote_config`;
CREATE TABLE `biz_vote_config` (
  `vote_id` bigint(20) NOT NULL COMMENT '投票主题ID',
  `vote_time_number` int(4) DEFAULT '60' COMMENT '投票时间间隔',
  `allow_vertify` tinyint(1) DEFAULT '0' COMMENT '是否开启验证码',
  `allow_view` tinyint(1) DEFAULT '0' COMMENT '完成后查看结果',
  `allow_guest` tinyint(1) DEFAULT '0' COMMENT '是否游客投票',
  `vote_limit` int(4) DEFAULT '1' COMMENT '每天可投票数',
  `allow_login` tinyint(1) DEFAULT '0' COMMENT '是否需要登陆',
  `allow_wechat` tinyint(1) DEFAULT '0' COMMENT '是否开启微信',
  `vote_template` varchar(1024) DEFAULT NULL COMMENT '主题模板',
  `detail_template` varchar(1024) DEFAULT NULL COMMENT '详情模板',
  PRIMARY KEY (`vote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票配置表';

-- ----------------------------
-- Records of biz_vote_config
-- ----------------------------

-- ----------------------------
-- Table structure for biz_vote_follow
-- ----------------------------
DROP TABLE IF EXISTS `biz_vote_follow`;
CREATE TABLE `biz_vote_follow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `vote_id` bigint(20) NOT NULL COMMENT '投票ID',
  `view_time` datetime DEFAULT NULL COMMENT '查看时间',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`uid`,`vote_id`,`view_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票关注表';

-- ----------------------------
-- Records of biz_vote_follow
-- ----------------------------

-- ----------------------------
-- Table structure for biz_vote_item
-- ----------------------------
DROP TABLE IF EXISTS `biz_vote_item`;
CREATE TABLE `biz_vote_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `vote_id` bigint(20) NOT NULL COMMENT '投票ID',
  `title` varchar(128) DEFAULT NULL COMMENT '问题标题',
  `description` varchar(512) DEFAULT NULL COMMENT '问题描述',
  `is_must` tinyint(1) DEFAULT NULL COMMENT '是否必填',
  `item_type` varchar(32) DEFAULT NULL COMMENT '题目类型文字/图片',
  `option_type` tinyint(1) DEFAULT NULL COMMENT '选项类型(单选/多选)',
  `sort` int(10) unsigned DEFAULT NULL COMMENT '排序',
  `options` varchar(2048) DEFAULT NULL COMMENT '选项json',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`vote_id`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票项表';

-- ----------------------------
-- Records of biz_vote_item
-- ----------------------------

-- ----------------------------
-- Table structure for biz_vote_result
-- ----------------------------
DROP TABLE IF EXISTS `biz_vote_result`;
CREATE TABLE `biz_vote_result` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `vote_id` bigint(20) NOT NULL COMMENT '投票ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `name` varchar(32) DEFAULT NULL COMMENT '投票姓名',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机号码',
  `vote_time` datetime DEFAULT NULL COMMENT '投票时间',
  `browser` varchar(32) DEFAULT NULL COMMENT '浏览器',
  `os` varchar(32) DEFAULT NULL COMMENT '操作系统',
  `ip` varchar(32) DEFAULT NULL COMMENT 'ip地址',
  `source` varchar(32) DEFAULT NULL COMMENT '投票来源',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`uid`,`vote_id`,`vote_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票结果表';

-- ----------------------------
-- Records of biz_vote_result
-- ----------------------------

-- ----------------------------
-- Table structure for biz_vote_result_detail
-- ----------------------------
DROP TABLE IF EXISTS `biz_vote_result_detail`;
CREATE TABLE `biz_vote_result_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `result_id` bigint(20) NOT NULL COMMENT '结果ID',
  `item_id` bigint(20) NOT NULL COMMENT '选项ID',
  `options_value` varchar(32) DEFAULT NULL COMMENT '投票结果',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`result_id`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票结果明细表';

-- ----------------------------
-- Records of biz_vote_result_detail
-- ----------------------------

-- ----------------------------
-- Table structure for biz_vote_tag
-- ----------------------------
DROP TABLE IF EXISTS `biz_vote_tag`;
CREATE TABLE `biz_vote_tag` (
  `vote_id` bigint(20) NOT NULL COMMENT '活动ID',
  `tag_id` bigint(20) NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`vote_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票标签表';

-- ----------------------------
-- Records of biz_vote_tag
-- ----------------------------

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(32) DEFAULT NULL COMMENT '消息标题',
  `content` varchar(1024) DEFAULT NULL COMMENT '消息内容',
  `type` tinyint(1) DEFAULT NULL COMMENT '1 公告 2 提醒 3 消息',
  `target` varchar(32) DEFAULT NULL COMMENT '目标数据表',
  `target_id` bigint(20) unsigned DEFAULT NULL COMMENT '数据ID',
  `action` varchar(16) DEFAULT NULL COMMENT '提醒动作',
  `sender` bigint(20) unsigned NOT NULL COMMENT '发送者',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_3` (`type`),
  KEY `Index_2` (`target`,`target_id`),
  KEY `Index_1` (`created_time`),
  KEY `Index_4` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息表';

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for message_action
-- ----------------------------
DROP TABLE IF EXISTS `message_action`;
CREATE TABLE `message_action` (
  `action` varchar(16) NOT NULL COMMENT '动作标识',
  `cn_action` varchar(32) DEFAULT NULL COMMENT '动作名称',
  PRIMARY KEY (`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户行为表';

-- ----------------------------
-- Records of message_action
-- ----------------------------
INSERT INTO `message_action` VALUES ('POST', '报名');
INSERT INTO `message_action` VALUES ('put', 'lj');

-- ----------------------------
-- Table structure for message_category
-- ----------------------------
DROP TABLE IF EXISTS `message_category`;
CREATE TABLE `message_category` (
  `code` varchar(16) NOT NULL COMMENT '分类标识',
  `title` varchar(20) DEFAULT NULL COMMENT '标题',
  `target` varchar(32) DEFAULT NULL COMMENT '目标表',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息分类表';

-- ----------------------------
-- Records of message_category
-- ----------------------------
INSERT INTO `message_category` VALUES ('001', null, null, '1');
INSERT INTO `message_category` VALUES ('EVENT_NOTIY', '活动通知', 'biz_event', '1');

-- ----------------------------
-- Table structure for message_config
-- ----------------------------
DROP TABLE IF EXISTS `message_config`;
CREATE TABLE `message_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(32) DEFAULT NULL COMMENT '消息标题',
  `msg_code` varchar(16) DEFAULT NULL COMMENT '消息分类',
  `action` varchar(16) DEFAULT NULL COMMENT '动作标识',
  `channel_code` varchar(16) DEFAULT NULL COMMENT '通知渠道',
  `use_template` varchar(32) DEFAULT NULL COMMENT '启用模板',
  `template_id` varchar(32) DEFAULT NULL COMMENT '消息模板ID',
  `jump_to` varchar(32) DEFAULT NULL COMMENT '跳转路径',
  `content` varchar(32) DEFAULT NULL COMMENT '模板内容',
  `example` varchar(32) DEFAULT NULL COMMENT '模板样例',
  `result` varchar(32) DEFAULT NULL COMMENT '配置结果',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_2` (`id`,`msg_code`,`action`,`channel_code`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1273530236247474178 DEFAULT CHARSET=utf8 COMMENT='消息配置表';

-- ----------------------------
-- Records of message_config
-- ----------------------------
INSERT INTO `message_config` VALUES ('1273205400572801025', '活动通知', 'EVENT_NOTIFY', 'POST', 'wechat', '1', 'wx10214512awe', 'www.purete.cn', '', '', '', '1', '2020-06-17 18:45:59', null, '2020-06-17 18:45:59', null, '1');
INSERT INTO `message_config` VALUES ('1273530236247474177', '活动通知', 'EVENT_NOTIFY', 'POST', 'wechat', '1', 'wx10214512awe', 'www.purete.cn', '', '', '', '1', '2020-06-18 16:16:49', null, '2020-06-18 16:16:49', null, '1');

-- ----------------------------
-- Table structure for message_dict
-- ----------------------------
DROP TABLE IF EXISTS `message_dict`;
CREATE TABLE `message_dict` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `msg_code` varchar(32) DEFAULT NULL COMMENT '消息分类',
  `name` varchar(32) DEFAULT NULL COMMENT '中文名称 如{用户名}',
  `param_name` varchar(32) DEFAULT NULL COMMENT '参数名称 name',
  `param_value` varchar(32) DEFAULT NULL COMMENT '参数值',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`id`,`msg_code`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='消息数据字典表';

-- ----------------------------
-- Records of message_dict
-- ----------------------------
INSERT INTO `message_dict` VALUES ('1', '123', 'a123', '123', 'a123', '1');

-- ----------------------------
-- Table structure for message_send
-- ----------------------------
DROP TABLE IF EXISTS `message_send`;
CREATE TABLE `message_send` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `msg_id` bigint(20) NOT NULL COMMENT '消息ID',
  `to_uid` bigint(20) NOT NULL COMMENT '接收用户',
  `to_username` varchar(64) DEFAULT NULL COMMENT '用户姓名',
  `notify_channel` varchar(16) DEFAULT NULL COMMENT '通知渠道',
  `is_read` tinyint(1) DEFAULT '0' COMMENT '是否阅读',
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`msg_id`),
  KEY `Index_2` (`to_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息发送表';

-- ----------------------------
-- Records of message_send
-- ----------------------------

-- ----------------------------
-- Table structure for oa_report
-- ----------------------------
DROP TABLE IF EXISTS `oa_report`;
CREATE TABLE `oa_report` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(32) DEFAULT NULL COMMENT '报告标题',
  `report_type` tinyint(1) DEFAULT '0' COMMENT '日报 周报 月报',
  `start_date` date DEFAULT NULL COMMENT '起始日期',
  `end_date` date DEFAULT NULL COMMENT '终止日期',
  `work_summary` varchar(1024) DEFAULT NULL COMMENT '工作总结',
  `work_plan` varchar(1024) DEFAULT NULL COMMENT '工作计划',
  `report_status` varchar(16) DEFAULT '0' COMMENT '状态',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`created_by`,`title`,`report_type`,`start_date`,`end_date`,`report_status`,`status`,`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作报告表';

-- ----------------------------
-- Records of oa_report
-- ----------------------------

-- ----------------------------
-- Table structure for oa_report_attachment
-- ----------------------------
DROP TABLE IF EXISTS `oa_report_attachment`;
CREATE TABLE `oa_report_attachment` (
  `report_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '报告ID',
  `file_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '文件ID',
  PRIMARY KEY (`report_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作报告附件表';

-- ----------------------------
-- Records of oa_report_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for oa_report_follow
-- ----------------------------
DROP TABLE IF EXISTS `oa_report_follow`;
CREATE TABLE `oa_report_follow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `report_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '报告ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `is_manager` tinyint(1) DEFAULT '0' COMMENT '是否负责人',
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '批阅状态',
  `audit_comment` varchar(1024) DEFAULT NULL COMMENT '批阅意见',
  `audit_time` datetime DEFAULT NULL COMMENT '批阅时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`report_id`,`uid`,`is_manager`,`status`,`created_time`,`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作报告关注表';

-- ----------------------------
-- Records of oa_report_follow
-- ----------------------------

-- ----------------------------
-- Table structure for oa_task
-- ----------------------------
DROP TABLE IF EXISTS `oa_task`;
CREATE TABLE `oa_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(32) DEFAULT NULL COMMENT '任务标题',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `task_status` varchar(16) DEFAULT '0' COMMENT '任务状态',
  `important` varchar(16) DEFAULT '0' COMMENT '紧要程度',
  `description` varchar(32) DEFAULT NULL COMMENT '任务描述',
  `color` varchar(16) DEFAULT NULL COMMENT '任务标记',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`title`,`start_time`,`end_time`,`task_status`,`created_time`,`created_by`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作任务表';

-- ----------------------------
-- Records of oa_task
-- ----------------------------

-- ----------------------------
-- Table structure for oa_task_follow
-- ----------------------------
DROP TABLE IF EXISTS `oa_task_follow`;
CREATE TABLE `oa_task_follow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `task_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `is_manager` tinyint(1) DEFAULT '0' COMMENT '是否负责人',
  `read_status` tinyint(1) DEFAULT '0' COMMENT '阅读状态',
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`task_id`,`uid`,`is_manager`,`read_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作任务关注表';

-- ----------------------------
-- Records of oa_task_follow
-- ----------------------------

-- ----------------------------
-- Table structure for oa_task_item
-- ----------------------------
DROP TABLE IF EXISTS `oa_task_item`;
CREATE TABLE `oa_task_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `task_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `progress` int(11) DEFAULT '0' COMMENT '进度',
  `comment` varchar(512) DEFAULT NULL COMMENT '评论内容',
  `images` varchar(1024) DEFAULT NULL COMMENT '评论图片json',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`task_id`,`created_by`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作任务动态表';

-- ----------------------------
-- Records of oa_task_item
-- ----------------------------

-- ----------------------------
-- Table structure for pub_admin
-- ----------------------------
DROP TABLE IF EXISTS `pub_admin`;
CREATE TABLE `pub_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account` varchar(64) DEFAULT NULL COMMENT '用户账号',
  `password` varchar(128) DEFAULT NULL COMMENT '密码',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(32) DEFAULT NULL COMMENT '登录IP',
  `login_count` int(11) DEFAULT '0' COMMENT '登录次数',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`account`,`created_time`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='平台账号表';

-- ----------------------------
-- Records of pub_admin
-- ----------------------------
INSERT INTO `pub_admin` VALUES ('1', 'admin', '123456', '2020-06-22 16:47:11', '127.0.0.1', '29', '1', '2020-06-15 16:32:43', '0', '2020-06-15 16:32:43', '0');
INSERT INTO `pub_admin` VALUES ('3', 'user', '1234567', null, null, '0', '1', '2020-06-18 15:01:43', '1', '2020-06-18 15:01:43', null);

-- ----------------------------
-- Table structure for pub_area
-- ----------------------------
DROP TABLE IF EXISTS `pub_area`;
CREATE TABLE `pub_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) DEFAULT NULL COMMENT '名称',
  `level` tinyint(1) DEFAULT NULL COMMENT '级别',
  `pid` int(11) DEFAULT '0' COMMENT '父ID',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='地区表';

-- ----------------------------
-- Records of pub_area
-- ----------------------------

-- ----------------------------
-- Table structure for pub_banner_position
-- ----------------------------
DROP TABLE IF EXISTS `pub_banner_position`;
CREATE TABLE `pub_banner_position` (
  `pos_code` varchar(32) NOT NULL COMMENT '位置标识',
  `title` varchar(128) DEFAULT NULL COMMENT '位置名称',
  `type` char(1) DEFAULT NULL COMMENT '0 展示1张',
  `width` int(11) DEFAULT NULL COMMENT '宽度',
  `height` int(11) DEFAULT NULL COMMENT '高度',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`pos_code`),
  KEY `Index_1` (`title`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告位置表';

-- ----------------------------
-- Records of pub_banner_position
-- ----------------------------

-- ----------------------------
-- Table structure for pub_config
-- ----------------------------
DROP TABLE IF EXISTS `pub_config`;
CREATE TABLE `pub_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(32) DEFAULT NULL COMMENT '参数名称',
  `title` varchar(32) DEFAULT NULL COMMENT '参数标题',
  `remark` varchar(128) DEFAULT NULL COMMENT '参数说明',
  `type` varchar(16) DEFAULT NULL COMMENT '输入类型',
  `options` varchar(512) DEFAULT NULL COMMENT '选项',
  `value` varchar(32) DEFAULT NULL COMMENT '参数值',
  `can_extend` tinyint(1) DEFAULT NULL COMMENT '是否可扩展',
  `category` varchar(32) DEFAULT NULL COMMENT '分组',
  `sort` int(10) unsigned DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`name`,`category`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='配置表';

-- ----------------------------
-- Records of pub_config
-- ----------------------------
INSERT INTO `pub_config` VALUES ('11', '12', '123', '123', 'input', null, null, null, 'official', '199', '1', '2020-06-19 15:49:16', null, '2020-06-19 15:49:16', null);

-- ----------------------------
-- Table structure for pub_config_third_nouse
-- ----------------------------
DROP TABLE IF EXISTS `pub_config_third_nouse`;
CREATE TABLE `pub_config_third_nouse` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `app_id` varchar(32) DEFAULT NULL COMMENT '平台AppID',
  `app_secret` varchar(32) DEFAULT NULL COMMENT '平台',
  `token` varchar(32) DEFAULT NULL COMMENT 'token',
  `aes_key` varchar(32) DEFAULT NULL COMMENT 'aes_key',
  `api_domain` varchar(32) DEFAULT NULL COMMENT '服务器域名',
  `component_ticket` varchar(32) DEFAULT NULL COMMENT '平台ticket',
  `component_access_token` varchar(32) DEFAULT NULL COMMENT '平台access_token',
  `expire_in` int(11) DEFAULT NULL COMMENT '令牌过期时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='第三方平台配置表';

-- ----------------------------
-- Records of pub_config_third_nouse
-- ----------------------------

-- ----------------------------
-- Table structure for pub_dict
-- ----------------------------
DROP TABLE IF EXISTS `pub_dict`;
CREATE TABLE `pub_dict` (
  `dict_code` varchar(32) NOT NULL COMMENT '编码',
  `dict_name` varchar(32) DEFAULT NULL COMMENT '名称',
  `description` varchar(32) DEFAULT NULL COMMENT '描述',
  `sort` int(10) unsigned DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`dict_code`),
  KEY `Index_1` (`dict_name`),
  KEY `Index_2` (`sort`),
  KEY `Index_3` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据字典表';

-- ----------------------------
-- Records of pub_dict
-- ----------------------------
INSERT INTO `pub_dict` VALUES ('00', '00', '00', null, '-1', '2020-06-18 10:58:16', '1', '2020-06-18 10:58:16', '1');
INSERT INTO `pub_dict` VALUES ('7', '77', '77', '1', '-1', '2020-06-18 12:05:37', '1', '2020-06-18 12:05:37', '1');
INSERT INTO `pub_dict` VALUES ('ABOUT_US', '关于我们', '关于我们', '99', '1', '2020-06-16 16:09:20', '1', '2020-06-16 16:09:20', '1');
INSERT INTO `pub_dict` VALUES ('SINGLE_PAGE_GROUP', '单页分组', '单页分组', '99', '1', '2020-06-16 15:48:19', '1', '2020-06-16 15:48:19', '1');

-- ----------------------------
-- Table structure for pub_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `pub_dict_item`;
CREATE TABLE `pub_dict_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `dict_code` varchar(32) DEFAULT NULL COMMENT '字典id',
  `item_label` varchar(32) DEFAULT NULL COMMENT '文本label',
  `item_value` varchar(32) DEFAULT NULL COMMENT '数据值',
  `description` varchar(32) DEFAULT NULL COMMENT '描述',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`dict_code`),
  KEY `Index_2` (`item_label`),
  KEY `Index_3` (`created_time`),
  KEY `Index_4` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='数据字典详情表';

-- ----------------------------
-- Records of pub_dict_item
-- ----------------------------
INSERT INTO `pub_dict_item` VALUES ('1', 'ABOUT_US', '联系我们', '133', null, '-1', '2020-06-18 11:43:13', '1', '2020-06-18 11:43:13');
INSERT INTO `pub_dict_item` VALUES ('2', 'ABOUT_US', '1', '2', null, '-1', '2020-06-18 11:43:37', '1', '2020-06-18 11:43:37');
INSERT INTO `pub_dict_item` VALUES ('3', 'ABOUT_US', '3', '3', null, '-1', '2020-06-18 12:05:49', '1', '2020-06-18 12:05:49');
INSERT INTO `pub_dict_item` VALUES ('4', 'ABOUT_US', '11', '11', null, '-1', '2020-06-18 12:07:45', '1', '2020-06-18 12:07:45');
INSERT INTO `pub_dict_item` VALUES ('5', 'ABOUT_US', '12', '12', null, '-1', '2020-06-18 12:07:55', '1', '2020-06-18 12:07:55');
INSERT INTO `pub_dict_item` VALUES ('6', 'ABOUT_US', '1', '2', null, '-1', '2020-06-18 12:08:02', '1', '2020-06-18 12:08:02');
INSERT INTO `pub_dict_item` VALUES ('7', 'SINGLE_PAGE_GROUP', '123', '12', null, '-1', '2020-06-18 13:45:04', '1', '2020-06-18 13:45:04');
INSERT INTO `pub_dict_item` VALUES ('8', 'SINGLE_PAGE_GROUP', 'zz', 'zz', null, '-1', '2020-06-18 13:45:08', '1', '2020-06-18 13:45:08');
INSERT INTO `pub_dict_item` VALUES ('9', 'ABOUT_US', '联系方式', 'PHONE', null, '1', '2020-06-19 18:21:45', '1', '2020-06-19 18:21:45');
INSERT INTO `pub_dict_item` VALUES ('10', 'ABOUT_US', '联系地址', 'ADDRESS', null, '1', '2020-06-19 18:22:00', '1', '2020-06-19 18:22:00');

-- ----------------------------
-- Table structure for pub_menu
-- ----------------------------
DROP TABLE IF EXISTS `pub_menu`;
CREATE TABLE `pub_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `module_code` varchar(32) DEFAULT NULL COMMENT '模块code',
  `title` varchar(32) DEFAULT NULL COMMENT '菜单标题',
  `perms` varchar(64) DEFAULT NULL COMMENT '权限标识',
  `path` varchar(128) DEFAULT NULL COMMENT 'url',
  `component` varchar(255) DEFAULT NULL COMMENT '菜单组件',
  `pid` int(11) unsigned DEFAULT '0' COMMENT '父节点',
  `url` varchar(128) DEFAULT NULL COMMENT '资源地址',
  `path_method` varchar(16) DEFAULT NULL COMMENT '路径方法',
  `icon` varchar(32) DEFAULT NULL COMMENT '图标32*32',
  `big_icon` varchar(32) DEFAULT NULL COMMENT '大图标128*128',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `menu_type` tinyint(1) DEFAULT NULL COMMENT '类型(目录 菜单 按钮)',
  `description` varchar(32) DEFAULT NULL COMMENT '描述',
  `is_hidden` tinyint(1) DEFAULT NULL COMMENT '隐藏',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `is_system` tinyint(1) DEFAULT NULL COMMENT '是否为系统默认参数',
  `app` varchar(16) DEFAULT NULL COMMENT '后台admin小程序app',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`module_code`,`title`,`pid`,`sort`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='系统菜单表';

-- ----------------------------
-- Records of pub_menu
-- ----------------------------
INSERT INTO `pub_menu` VALUES ('1', null, '系统管理', null, '/sys', 'Layout', '0', null, null, 'wechat', null, '1', '1', null, '1', '1', null, 'platform', '2020-06-18 09:59:22', null, '2020-06-18 09:59:22', null);
INSERT INTO `pub_menu` VALUES ('3', null, '菜单管理', null, 'menu', '/sys/menu/index', '1', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'platform', '2020-06-18 10:14:50', null, '2020-06-18 10:14:50', null);
INSERT INTO `pub_menu` VALUES ('4', null, '资讯', '', '/article', 'Layout', '0', null, null, 'documentation', null, '1', '1', null, '1', '1', null, 'admin', '2020-06-18 10:41:07', null, '2020-06-18 10:41:07', null);
INSERT INTO `pub_menu` VALUES ('5', null, '数据字典', null, 'enum', '/sys/enum/index', '1', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'platform', '2020-06-18 10:43:01', null, '2020-06-18 10:43:01', null);
INSERT INTO `pub_menu` VALUES ('6', null, '单页配置', null, 'biz-page', '/sys/biz-page', '1', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'platform', '2020-06-18 10:43:37', null, '2020-06-18 10:43:37', null);
INSERT INTO `pub_menu` VALUES ('7', null, '账号管理', null, 'user', '/sys/user/index', '1', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'platform', '2020-06-18 10:43:55', null, '2020-06-18 10:43:55', null);
INSERT INTO `pub_menu` VALUES ('8', null, '配置管理', null, 'config', '/sys/config/index', '1', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'platform', '2020-06-18 10:44:17', null, '2020-06-18 10:44:17', null);
INSERT INTO `pub_menu` VALUES ('9', null, '更新日志', null, 'update-log', '/sys/update-log/index', '1', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'platform', '2020-06-18 10:45:29', null, '2020-06-18 10:45:29', null);
INSERT INTO `pub_menu` VALUES ('10', null, '租户管理', null, '/tenant', 'Layout', '0', null, null, 'guide', null, '1', '1', null, '1', '1', null, 'platform', '2020-06-18 10:45:56', null, '2020-06-18 10:45:56', null);
INSERT INTO `pub_menu` VALUES ('11', null, '租户信息', null, 'info', '/tenant/index', '10', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'platform', '2020-06-18 10:47:48', null, '2020-06-18 10:47:48', null);
INSERT INTO `pub_menu` VALUES ('12', null, '详细信息', null, 'detail', '/tenant/page/index', '10', null, null, 'guide', null, '1', '2', null, '0', '1', null, 'platform', '2020-06-18 10:48:29', null, '2020-06-18 10:48:29', null);
INSERT INTO `pub_menu` VALUES ('13', null, '标签管理', null, 'tag', '/sys/tag/index', '1', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'platform', '2020-06-18 14:15:16', null, '2020-06-18 14:15:16', null);
INSERT INTO `pub_menu` VALUES ('14', null, '消息管理', null, '/message', 'Layout', '0', null, null, 'guide', null, '1', '1', null, '1', '1', null, 'platform', '2020-06-18 14:58:42', null, '2020-06-18 14:58:42', null);
INSERT INTO `pub_menu` VALUES ('15', null, '消息字典', null, 'dict', '/message/dict/index', '14', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'platform', '2020-06-18 14:59:06', null, '2020-06-18 14:59:06', null);
INSERT INTO `pub_menu` VALUES ('16', null, '消息分类', null, 'category', '/message/category/index', '14', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'platform', '2020-06-18 15:01:18', null, '2020-06-18 15:01:18', null);
INSERT INTO `pub_menu` VALUES ('17', null, '消息动作', null, 'action', '/message/action/index', '14', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'platform', '2020-06-19 14:11:28', null, '2020-06-19 14:11:28', null);
INSERT INTO `pub_menu` VALUES ('18', null, '系统管理', null, '/sys', 'Layout', '0', null, null, 'guide', null, '1', '1', null, '1', '1', null, 'admin', '2020-06-19 15:52:20', null, '2020-06-19 15:52:20', null);
INSERT INTO `pub_menu` VALUES ('19', null, '活动管理', null, '/article', 'Layout', '0', null, null, 'guide', null, '1', '1', null, '1', '1', null, 'admin', '2020-06-19 15:52:37', null, '2020-06-19 15:52:37', null);
INSERT INTO `pub_menu` VALUES ('20', null, '资讯信息', null, 'info', '/article/info/index', '4', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'admin', '2020-06-22 10:36:02', null, '2020-06-22 10:36:02', null);
INSERT INTO `pub_menu` VALUES ('21', null, '投票管理', null, '/vote', 'Layout', '0', null, null, 'guide', null, '1', '1', null, '1', '1', null, 'admin', '2020-06-22 16:48:37', null, '2020-06-22 16:48:37', null);
INSERT INTO `pub_menu` VALUES ('22', null, '标签管理', null, 'tag', '/sys/tag/index', '18', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'admin', '2020-06-22 16:49:01', null, '2020-06-22 16:49:01', null);
INSERT INTO `pub_menu` VALUES ('23', null, '投票信息', null, 'info', '/vote/info/index', '21', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'admin', '2020-06-22 16:49:29', null, '2020-06-22 16:49:29', null);
INSERT INTO `pub_menu` VALUES ('24', null, '活动信息', null, 'info', '/article', '19', null, null, 'guide', null, '1', '2', null, '1', '1', null, 'admin', '2020-06-22 16:49:51', null, '2020-06-22 16:49:51', null);

-- ----------------------------
-- Table structure for pub_tenant
-- ----------------------------
DROP TABLE IF EXISTS `pub_tenant`;
CREATE TABLE `pub_tenant` (
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `name` varchar(128) DEFAULT NULL COMMENT '租户名称',
  `logo` bigint(20) DEFAULT NULL COMMENT 'logo',
  `conact` varchar(32) DEFAULT NULL COMMENT '联系人',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(32) DEFAULT NULL COMMENT '电子邮箱',
  `address` varchar(128) DEFAULT NULL COMMENT '公司地址',
  `domain` varchar(128) DEFAULT NULL COMMENT '域名前缀',
  `reg_type` tinyint(1) DEFAULT NULL COMMENT '注册类型(0 自主注册 1 平台注册)',
  `start_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '授权时间',
  `end_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '授权结束时间',
  `account_limit` int(10) DEFAULT '0' COMMENT '账号限制数',
  `disk_capacity` int(10) DEFAULT NULL COMMENT '网盘容量',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`tenant_id`),
  KEY `Index_3` (`tenant_id`,`name`,`status`,`created_time`),
  KEY `Index_1` (`name`),
  KEY `Index_2` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='租户表';

-- ----------------------------
-- Records of pub_tenant
-- ----------------------------
INSERT INTO `pub_tenant` VALUES ('1', '广州商会', '123456123', 'jiangchao', '15074917947', '187312123@qq.com', '玉兰路湘邮科技园', 'www.purete.cn', '1', '2020-06-18 16:40:29', '2020-06-18 16:40:29', '200', '500', '1', '2020-06-16 14:21:56', '1', '2020-06-16 14:21:56', '1');
INSERT INTO `pub_tenant` VALUES ('2', '衡阳商会', '123456125', 'heming', '15074917948', '187312123@qq.com', '玉兰路湘邮科技园', 'www.purete.cn', '1', '2020-06-18 16:40:13', '2020-06-18 16:40:13', '200', '500', '1', '2020-06-16 14:55:34', '1', '2020-06-16 14:55:34', '1');
INSERT INTO `pub_tenant` VALUES ('3', '湖南商会', '123456125', '杨涛', '15074917968', '187312148@qq.com', '玉兰路湘邮科技园', 'www.purete.cn', '1', '2020-06-18 16:40:02', '2020-06-18 16:40:02', '200', '500', '1', '2020-06-16 15:04:59', '1', '2020-06-16 15:04:59', '1');
INSERT INTO `pub_tenant` VALUES ('4', '长沙商会', '1545673', '龚凤', '17374917968', '187654148@qq.com', '玉兰路湘邮科技园', 'www.purete.cn', '1', '2020-06-18 16:39:51', '2020-06-18 16:39:51', '200', '500', '1', '2020-06-16 15:15:42', '1', '2020-06-16 15:15:42', '1');
INSERT INTO `pub_tenant` VALUES ('5', '河南商会', '1545673', '王修远', '17374917965', '187654148@qq.com', '玉兰路湘邮科技园', 'www.purete.cn', '1', '2020-06-18 16:39:40', '2020-06-18 16:39:40', '200', '500', '1', '2020-06-16 15:16:51', '1', '2020-06-16 15:16:51', '1');
INSERT INTO `pub_tenant` VALUES ('6', '石门商会', null, '赫敏', '13272055845', '812@qq.com', '石门县', '123456', '1', '2020-06-18 16:35:42', '2020-06-18 16:35:42', '200', '500', '1', '2020-06-18 16:35:07', '1', '2020-06-18 16:35:07', '1');

-- ----------------------------
-- Table structure for sys_announce
-- ----------------------------
DROP TABLE IF EXISTS `sys_announce`;
CREATE TABLE `sys_announce` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(64) DEFAULT NULL COMMENT '公告标题',
  `content` varchar(1024) DEFAULT NULL COMMENT '公告内容',
  `url` varchar(128) DEFAULT NULL COMMENT '链接地址',
  `end_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '结束时间',
  `sort` int(10) unsigned DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`title`,`sort`,`status`,`created_time`,`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=1273089738370228226 DEFAULT CHARSET=utf8 COMMENT='公告表';

-- ----------------------------
-- Records of sys_announce
-- ----------------------------
INSERT INTO `sys_announce` VALUES ('1273088689521598465', '端午节', '“端”起夏日的清凉，“午”动快乐节拍;“端”起美味的粽子，快乐随风而“午”;“端”起祝福的酒杯，喜悦满天飞“午”', '', '2020-06-17 11:02:14', '99', '1', '2020-06-17 11:02:14', '1', '2020-06-17 11:02:14', '1', '1');
INSERT INTO `sys_announce` VALUES ('1273089662579154945', '端午节', '祝福“粽”动员，愿你笑开颜。薪水“粽”是上涨，干活“粽”是不忙，前途“粽”是辉煌，爱情“粽”是如糖，身体“粽”是健康!', '', '2020-06-17 11:06:04', '99', '1', '2020-06-17 11:06:04', '1', '2020-06-17 11:06:04', '1', '1');
INSERT INTO `sys_announce` VALUES ('1273089700327890946', '端午节', '好酒清清淡淡，越久越醇;好朋友简简单单，越久越真;好缘份久久长长，地老天荒。真诚的友谊叫人终身难忘，祝端午节快乐!', '', '2020-06-17 11:06:13', '99', '1', '2020-06-17 11:06:13', '1', '2020-06-17 11:06:13', '1', '1');
INSERT INTO `sys_announce` VALUES ('1273089738370228225', '端午节', '糯米价格坚挺，端午粽子走高。朋友短信送粽子，欲与天公试比高。愿你烦恼不长高，事业步步高。血压不升高，快乐高乐高。', '', '2020-06-17 11:06:22', '99', '1', '2020-06-17 11:06:22', '1', '2020-06-17 11:06:22', '1', '1');

-- ----------------------------
-- Table structure for sys_app_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_app_menu`;
CREATE TABLE `sys_app_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(32) DEFAULT NULL COMMENT '菜单标题',
  `icon` longtext COMMENT '菜单图标',
  `big_icon` longtext COMMENT 'bigIcon',
  `pid` int(10) unsigned DEFAULT '0' COMMENT '父节点ID',
  `menu_type` tinyint(1) DEFAULT NULL COMMENT '目录 链接',
  `moudule_id` bigint(20) NOT NULL COMMENT 'pub_menu_ID',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `sort` int(10) unsigned DEFAULT NULL COMMENT '排序',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`title`,`created_time`,`sort`,`pid`,`menu_type`,`moudule_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='应用菜单表';

-- ----------------------------
-- Records of sys_app_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_attachment
-- ----------------------------
DROP TABLE IF EXISTS `sys_attachment`;
CREATE TABLE `sys_attachment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `file_name` varchar(64) DEFAULT NULL COMMENT '原始文件名',
  `save_name` varchar(32) DEFAULT NULL COMMENT '保存文件名',
  `save_path` varchar(255) DEFAULT NULL COMMENT '文件保存路径',
  `ext` varchar(5) DEFAULT NULL COMMENT '文件后缀',
  `mime` varchar(32) DEFAULT NULL COMMENT 'mime类型',
  `description` varchar(64) DEFAULT NULL COMMENT '描述',
  `size` bigint(20) DEFAULT NULL COMMENT '大小',
  `md5` varchar(32) DEFAULT NULL COMMENT 'md5码',
  `url` varchar(255) DEFAULT NULL COMMENT '文件链接',
  `is_img` tinyint(1) DEFAULT '0' COMMENT '是否图片',
  `width` int(10) DEFAULT NULL COMMENT '图片宽度',
  `height` int(10) DEFAULT NULL COMMENT '图片高度',
  `driver` varchar(32) DEFAULT NULL COMMENT '存储类型(本地/七牛/阿里)',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`file_name`,`created_time`,`created_by`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统附件信息表';

-- ----------------------------
-- Records of sys_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for sys_banner
-- ----------------------------
DROP TABLE IF EXISTS `sys_banner`;
CREATE TABLE `sys_banner` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `title` varchar(32) DEFAULT NULL COMMENT '广告标题',
  `description` varchar(512) DEFAULT NULL COMMENT '描述',
  `position_id` varchar(16) DEFAULT NULL COMMENT '广告位置ID',
  `images` bigint(20) NOT NULL COMMENT '图片地址',
  `advs_text` varchar(64) DEFAULT NULL COMMENT '文字广告内容',
  `link` varchar(255) DEFAULT NULL COMMENT '广告链接',
  `level` int(11) DEFAULT NULL COMMENT '优先级',
  `sort` int(10) unsigned DEFAULT NULL COMMENT '排序',
  `start_date` datetime DEFAULT NULL COMMENT '开始日期',
  `end_date` datetime DEFAULT NULL COMMENT '结束日期',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_2` (`tenant_id`,`position_id`,`title`,`level`,`sort`,`start_date`,`end_date`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告表';

-- ----------------------------
-- Records of sys_banner
-- ----------------------------

-- ----------------------------
-- Table structure for sys_collect
-- ----------------------------
DROP TABLE IF EXISTS `sys_collect`;
CREATE TABLE `sys_collect` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `target` varchar(32) DEFAULT NULL COMMENT '数据表',
  `target_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '数据id',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`created_by`,`target`,`target_id`,`status`,`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏表';

-- ----------------------------
-- Records of sys_collect
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `conf_id` bigint(20) NOT NULL COMMENT '配置ID',
  `conf_value` varchar(32) DEFAULT NULL COMMENT '配置值',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`conf_id`,`conf_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------

-- ----------------------------
-- Table structure for sys_custom_form
-- ----------------------------
DROP TABLE IF EXISTS `sys_custom_form`;
CREATE TABLE `sys_custom_form` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `target` varchar(32) NOT NULL COMMENT '目标数据表',
  `target_id` bigint(20) NOT NULL COMMENT '目标数据ID',
  `field_name` varchar(16) DEFAULT NULL COMMENT '字段英文名称',
  `field_cname` varchar(32) DEFAULT NULL COMMENT '字段中文名称',
  `field_type` tinyint(1) DEFAULT NULL COMMENT '单行文本/多选/单选/下拉/附件',
  `field_option` varchar(256) DEFAULT NULL COMMENT '内容选项json 单选/多选/下拉',
  `is_must` tinyint(1) DEFAULT '0' COMMENT '是否必填',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`target`,`target_id`,`field_name`,`status`,`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自定义表单';

-- ----------------------------
-- Records of sys_custom_form
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(32) DEFAULT NULL COMMENT '部门名称',
  `status` tinyint(1) DEFAULT '0' COMMENT '数据状态',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `sort` int(10) unsigned DEFAULT NULL COMMENT '排序',
  `pid` bigint(20) unsigned DEFAULT NULL COMMENT '上级部门',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_digg
-- ----------------------------
DROP TABLE IF EXISTS `sys_digg`;
CREATE TABLE `sys_digg` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `target` varchar(32) DEFAULT NULL COMMENT '数据表',
  `target_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '数据id',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态(0 已经取消赞 1 有效赞)',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `idx_digg` (`tenant_id`,`target`,`target_id`,`created_by`,`status`,`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='点赞表';

-- ----------------------------
-- Records of sys_digg
-- ----------------------------

-- ----------------------------
-- Table structure for sys_link
-- ----------------------------
DROP TABLE IF EXISTS `sys_link`;
CREATE TABLE `sys_link` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `type` int(11) DEFAULT NULL COMMENT '1 图片 2 普通',
  `title` varchar(32) DEFAULT NULL COMMENT '站点名称',
  `cover_id` bigint(20) NOT NULL COMMENT '图片ID',
  `link` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `level` int(11) DEFAULT NULL COMMENT '优先级',
  `sort` int(10) unsigned DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`type`,`title`,`level`,`sort`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Records of sys_link
-- ----------------------------

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `action_ip` varchar(16) DEFAULT NULL COMMENT '操作IP',
  `action_type` tinyint(1) DEFAULT NULL COMMENT '操作类型 1 操作 2 异常',
  `action_user` varchar(16) DEFAULT NULL COMMENT '操作人姓名',
  `action_descrition` varchar(255) DEFAULT NULL COMMENT '操作描述',
  `action_method` varchar(16) DEFAULT NULL COMMENT '操作方法',
  `action_url` varchar(255) DEFAULT NULL COMMENT '操作链接',
  `request_param` varchar(1024) DEFAULT NULL COMMENT '请求参数',
  `browser` varchar(32) DEFAULT NULL COMMENT '浏览器',
  `class_path` varchar(512) DEFAULT NULL COMMENT '类路径',
  `request_method` varchar(32) DEFAULT NULL COMMENT '请求方法',
  `action_time` int(10) DEFAULT NULL COMMENT '执行时间',
  `err_info` varchar(512) DEFAULT NULL COMMENT '异常信息',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`action_type`,`created_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1273129941084448097 DEFAULT CHARSET=utf8 COMMENT='日志表';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1273070898403909634', '127.0.0.1', '0', null, null, '操作类型', null, null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '97', null, '2020-06-17 09:52:09', null, '2020-06-17 09:51:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273088711457808386', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'save', '2224', null, '2020-06-17 11:02:56', null, '2020-06-17 11:02:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273089663246049282', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'save', '156', null, '2020-06-17 11:06:43', null, '2020-06-17 11:06:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273089704392171522', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'save', '969', null, '2020-06-17 11:06:53', null, '2020-06-17 11:06:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273089738768687105', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'save', '95', null, '2020-06-17 11:07:01', null, '2020-06-17 11:06:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273089969031782401', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'update', '40', null, '2020-06-17 11:07:56', null, '2020-06-17 11:07:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273089997955702785', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'update', '11', null, '2020-06-17 11:08:03', null, '2020-06-17 11:07:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273090014770667522', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'update', '7', null, '2020-06-17 11:08:07', null, '2020-06-17 11:07:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273090030193123330', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'update', '6', null, '2020-06-17 11:08:11', null, '2020-06-17 11:07:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273098285652942849', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce/list', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'treeGrid', '1894', null, '2020-06-17 11:40:59', null, '2020-06-17 11:40:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273128650174144514', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce/list', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'treeGrid', '149', null, '2020-06-17 13:41:38', null, '2020-06-17 13:41:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273128650216087553', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce/list', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'treeGrid', '178', null, '2020-06-17 13:41:38', null, '2020-06-17 13:41:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273128701495648258', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce/list', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'treeGrid', '26', null, '2020-06-17 13:41:51', null, '2020-06-17 13:41:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273128728284667906', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce/list', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'treeGrid', '20', null, '2020-06-17 13:41:57', null, '2020-06-17 13:41:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273128782059839489', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce/list', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'treeGrid', '30', null, '2020-06-17 13:42:10', null, '2020-06-17 13:41:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446722', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/sys/sysAnnounce/list', null, null, 'com.purete.coc.sys.controller.SysAnnounceController', 'treeGrid', '81', null, '2020-06-17 13:46:46', null, '2020-06-17 13:46:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446723', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'save', '4914', null, '2020-06-17 14:37:20', null, '2020-06-17 14:36:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446724', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/message/action', null, null, 'com.purete.coc.message.controller.MessageActionController', 'save', '3059', null, '2020-06-17 15:40:21', null, '2020-06-17 15:39:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446725', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/message/config', null, null, 'com.purete.coc.message.controller.MessageConfigController', 'save', '622', null, '2020-06-17 18:46:38', null, '2020-06-17 18:46:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446726', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu/list', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '2620', null, '2020-06-18 09:31:47', null, '2020-06-18 09:31:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446727', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu/list', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '19', null, '2020-06-18 09:32:43', null, '2020-06-18 09:32:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446728', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu/list', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '76', null, '2020-06-18 09:38:35', null, '2020-06-18 09:37:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446729', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu/list', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '69', null, '2020-06-18 09:40:33', null, '2020-06-18 09:39:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446730', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu/list', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '101', null, '2020-06-18 09:41:39', null, '2020-06-18 09:41:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446731', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '2155', null, '2020-06-18 09:44:07', null, '2020-06-18 09:43:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446732', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '33', null, '2020-06-18 09:44:41', null, '2020-06-18 09:44:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446733', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '56', null, '2020-06-18 09:48:36', null, '2020-06-18 09:47:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446734', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '81', null, '2020-06-18 09:52:35', null, '2020-06-18 09:51:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446735', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-18 09:52:36', null, '2020-06-18 09:51:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446736', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '13', null, '2020-06-18 09:52:58', null, '2020-06-18 09:52:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446737', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '50', null, '2020-06-18 09:53:59', null, '2020-06-18 09:53:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446738', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-18 09:55:00', null, '2020-06-18 09:54:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446739', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '4134', null, '2020-06-18 10:00:01', null, '2020-06-18 09:59:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446740', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '2855', null, '2020-06-18 10:02:28', null, '2020-06-18 10:01:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446741', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '123', null, '2020-06-18 10:02:29', null, '2020-06-18 10:01:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446742', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '62', null, '2020-06-18 10:07:40', null, '2020-06-18 10:07:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446743', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '34', null, '2020-06-18 10:07:59', null, '2020-06-18 10:07:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446744', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '61', null, '2020-06-18 10:09:15', null, '2020-06-18 10:08:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446745', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'update', '63', null, '2020-06-18 10:09:27', null, '2020-06-18 10:08:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446746', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '15', null, '2020-06-18 10:09:27', null, '2020-06-18 10:08:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446747', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '87', null, '2020-06-18 10:11:30', null, '2020-06-18 10:10:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446748', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '95', null, '2020-06-18 10:14:47', null, '2020-06-18 10:14:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446749', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-18 10:14:50', null, '2020-06-18 10:14:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446750', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '879', null, '2020-06-18 10:15:28', null, '2020-06-18 10:14:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446751', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '20', null, '2020-06-18 10:15:28', null, '2020-06-18 10:14:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446752', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '49', null, '2020-06-18 10:18:53', null, '2020-06-18 10:18:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446753', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '72', null, '2020-06-18 10:21:57', null, '2020-06-18 10:21:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446754', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '61', null, '2020-06-18 10:23:49', null, '2020-06-18 10:23:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446755', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '49', null, '2020-06-18 10:26:21', null, '2020-06-18 10:25:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446756', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '53', null, '2020-06-18 10:28:08', null, '2020-06-18 10:27:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446757', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '31', null, '2020-06-18 10:29:11', null, '2020-06-18 10:28:34', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446758', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'delete', '7153', null, '2020-06-18 10:29:23', null, '2020-06-18 10:28:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446759', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-18 10:29:23', null, '2020-06-18 10:28:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446760', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '66', null, '2020-06-18 10:35:55', null, '2020-06-18 10:35:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446761', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '97', null, '2020-06-18 10:37:42', null, '2020-06-18 10:37:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446762', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '106', null, '2020-06-18 10:41:24', null, '2020-06-18 10:40:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446763', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '130', null, '2020-06-18 10:41:24', null, '2020-06-18 10:40:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446764', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '7', null, '2020-06-18 10:41:29', null, '2020-06-18 10:40:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446765', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '837', null, '2020-06-18 10:41:45', null, '2020-06-18 10:41:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446766', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '15', null, '2020-06-18 10:41:45', null, '2020-06-18 10:41:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446767', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '8', null, '2020-06-18 10:41:47', null, '2020-06-18 10:41:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446768', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '7', null, '2020-06-18 10:41:48', null, '2020-06-18 10:41:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446769', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '8', null, '2020-06-18 10:41:49', null, '2020-06-18 10:41:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446770', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '6', null, '2020-06-18 10:41:49', null, '2020-06-18 10:41:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446771', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-18 10:41:50', null, '2020-06-18 10:41:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446772', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '8', null, '2020-06-18 10:41:51', null, '2020-06-18 10:41:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446773', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '8', null, '2020-06-18 10:41:52', null, '2020-06-18 10:41:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446774', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '77', null, '2020-06-18 10:43:10', null, '2020-06-18 10:42:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446775', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '87', null, '2020-06-18 10:43:10', null, '2020-06-18 10:42:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446776', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '36', null, '2020-06-18 10:43:38', null, '2020-06-18 10:43:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446777', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-18 10:43:38', null, '2020-06-18 10:43:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446778', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '448', null, '2020-06-18 10:44:15', null, '2020-06-18 10:43:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446779', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-18 10:44:15', null, '2020-06-18 10:43:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446780', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '1032', null, '2020-06-18 10:44:33', null, '2020-06-18 10:43:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446781', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-18 10:44:33', null, '2020-06-18 10:43:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446782', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '1187', null, '2020-06-18 10:44:56', null, '2020-06-18 10:44:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446783', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '8', null, '2020-06-18 10:44:56', null, '2020-06-18 10:44:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446784', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-18 10:45:27', null, '2020-06-18 10:44:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446785', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '8', null, '2020-06-18 10:45:27', null, '2020-06-18 10:44:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446786', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-18 10:45:36', null, '2020-06-18 10:44:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446787', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-18 10:45:44', null, '2020-06-18 10:45:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446788', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-18 10:45:46', null, '2020-06-18 10:45:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446789', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-18 10:45:47', null, '2020-06-18 10:45:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446790', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '8', null, '2020-06-18 10:45:54', null, '2020-06-18 10:45:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446791', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '7', null, '2020-06-18 10:45:55', null, '2020-06-18 10:45:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446792', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '6', null, '2020-06-18 10:45:55', null, '2020-06-18 10:45:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446793', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '8', null, '2020-06-18 10:45:56', null, '2020-06-18 10:45:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446794', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '203', null, '2020-06-18 10:46:06', null, '2020-06-18 10:45:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446795', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-18 10:46:06', null, '2020-06-18 10:45:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446796', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '42', null, '2020-06-18 10:46:34', null, '2020-06-18 10:45:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446797', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '13', null, '2020-06-18 10:46:34', null, '2020-06-18 10:45:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446798', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '64', null, '2020-06-18 10:48:26', null, '2020-06-18 10:47:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446799', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '13', null, '2020-06-18 10:48:26', null, '2020-06-18 10:47:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446800', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '1048', null, '2020-06-18 10:49:08', null, '2020-06-18 10:48:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446801', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-18 10:49:08', null, '2020-06-18 10:48:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446802', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/biz/article-category', null, null, 'com.purete.coc.biz.controller.BizArticleCategoryController', 'save', '62', null, '2020-06-18 10:50:13', null, '2020-06-18 10:49:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446803', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '491', null, '2020-06-18 10:51:46', null, '2020-06-18 10:51:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446804', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '11', null, '2020-06-18 10:51:47', null, '2020-06-18 10:51:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446805', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/biz/article-category', null, null, 'com.purete.coc.biz.controller.BizArticleCategoryController', 'save', '2612', null, '2020-06-18 10:53:31', null, '2020-06-18 10:52:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446806', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/biz/article-category', null, null, 'com.purete.coc.biz.controller.BizArticleCategoryController', 'save', '429', null, '2020-06-18 10:54:02', null, '2020-06-18 10:53:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446807', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '305', null, '2020-06-18 10:54:46', null, '2020-06-18 10:54:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446808', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '13', null, '2020-06-18 10:54:46', null, '2020-06-18 10:54:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446809', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '54', null, '2020-06-18 10:56:10', null, '2020-06-18 10:55:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446810', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '22', null, '2020-06-18 10:56:21', null, '2020-06-18 10:55:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446811', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '58', null, '2020-06-18 10:57:27', null, '2020-06-18 10:56:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446812', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '12', null, '2020-06-18 10:58:09', null, '2020-06-18 10:57:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446813', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '12', null, '2020-06-18 10:58:10', null, '2020-06-18 10:57:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446814', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'save', '3442', null, '2020-06-18 10:58:55', null, '2020-06-18 10:58:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446815', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '10', null, '2020-06-18 10:58:55', null, '2020-06-18 10:58:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446816', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'delete', '18', null, '2020-06-18 10:58:59', null, '2020-06-18 10:58:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446817', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '8', null, '2020-06-18 10:59:00', null, '2020-06-18 10:58:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446818', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '125', null, '2020-06-18 11:00:45', null, '2020-06-18 11:00:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446819', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '42', null, '2020-06-18 11:01:50', null, '2020-06-18 11:01:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446820', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '11', null, '2020-06-18 11:01:50', null, '2020-06-18 11:01:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446821', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '12', null, '2020-06-18 11:01:51', null, '2020-06-18 11:01:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446822', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'delete', '335', null, '2020-06-18 11:01:57', null, '2020-06-18 11:01:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446823', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '10', null, '2020-06-18 11:01:57', null, '2020-06-18 11:01:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446824', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '46', null, '2020-06-18 11:04:51', null, '2020-06-18 11:04:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446825', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'update', '1', null, '2020-06-18 11:05:31', null, '2020-06-18 11:04:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446826', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'update', '0', null, '2020-06-18 11:05:32', null, '2020-06-18 11:04:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446827', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-18 11:05:33', null, '2020-06-18 11:04:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446828', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-18 11:05:33', null, '2020-06-18 11:04:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446829', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '2062', null, '2020-06-18 11:06:26', null, '2020-06-18 11:05:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446830', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '78', null, '2020-06-18 11:10:43', null, '2020-06-18 11:10:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446831', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-18 11:10:44', null, '2020-06-18 11:10:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446832', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'update', '0', null, '2020-06-18 11:10:48', null, '2020-06-18 11:10:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446833', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '12', null, '2020-06-18 11:10:48', null, '2020-06-18 11:10:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446834', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '82', null, '2020-06-18 11:14:30', null, '2020-06-18 11:13:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446835', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '15', null, '2020-06-18 11:14:33', null, '2020-06-18 11:13:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446836', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '13', null, '2020-06-18 11:14:34', null, '2020-06-18 11:13:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446837', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'update', '993', null, '2020-06-18 11:14:44', null, '2020-06-18 11:14:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446838', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '13', null, '2020-06-18 11:14:44', null, '2020-06-18 11:14:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446839', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'update', '44', null, '2020-06-18 11:14:47', null, '2020-06-18 11:14:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446840', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '10', null, '2020-06-18 11:14:47', null, '2020-06-18 11:14:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446841', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '50', null, '2020-06-18 11:16:05', null, '2020-06-18 11:15:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446842', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '81', null, '2020-06-18 11:16:06', null, '2020-06-18 11:15:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446843', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '50', null, '2020-06-18 11:18:23', null, '2020-06-18 11:17:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446844', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '11', null, '2020-06-18 11:18:24', null, '2020-06-18 11:17:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446845', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '90', null, '2020-06-18 11:20:49', null, '2020-06-18 11:20:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446846', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '26', null, '2020-06-18 11:20:50', null, '2020-06-18 11:20:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446847', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '60', null, '2020-06-18 11:23:53', null, '2020-06-18 11:23:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446848', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/biz/article', null, null, 'com.purete.coc.biz.controller.BizArticleController', 'save', '2436', null, '2020-06-18 11:24:52', null, '2020-06-18 11:24:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446849', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '222', null, '2020-06-18 11:25:27', null, '2020-06-18 11:24:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446850', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-18 11:25:28', null, '2020-06-18 11:24:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446851', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/biz/article', null, null, 'com.purete.coc.biz.controller.BizArticleController', 'save', '35', null, '2020-06-18 11:25:51', null, '2020-06-18 11:25:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446852', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '58', null, '2020-06-18 11:26:52', null, '2020-06-18 11:26:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446853', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '2593', null, '2020-06-18 11:33:48', null, '2020-06-18 11:33:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446854', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '19', null, '2020-06-18 11:33:55', null, '2020-06-18 11:33:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446855', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '60', null, '2020-06-18 11:33:55', null, '2020-06-18 11:33:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446856', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 11:34:27', null, '2020-06-18 11:33:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446857', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '13', null, '2020-06-18 11:34:27', null, '2020-06-18 11:33:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446858', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 11:34:29', null, '2020-06-18 11:33:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446859', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '47', null, '2020-06-18 11:35:41', null, '2020-06-18 11:35:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446860', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 11:36:18', null, '2020-06-18 11:35:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446861', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 11:36:18', null, '2020-06-18 11:35:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446862', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-18 11:36:18', null, '2020-06-18 11:35:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446863', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-18 11:36:31', null, '2020-06-18 11:35:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446864', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '49', null, '2020-06-18 11:37:25', null, '2020-06-18 11:36:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446865', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-18 11:37:28', null, '2020-06-18 11:36:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446866', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-18 11:37:35', null, '2020-06-18 11:36:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446867', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '14', null, '2020-06-18 11:38:16', null, '2020-06-18 11:37:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446868', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '20', null, '2020-06-18 11:38:16', null, '2020-06-18 11:37:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446869', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '124', null, '2020-06-18 11:38:16', null, '2020-06-18 11:37:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446870', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '12', null, '2020-06-18 11:38:18', null, '2020-06-18 11:37:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446871', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '11', null, '2020-06-18 11:38:18', null, '2020-06-18 11:37:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446872', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-18 11:38:18', null, '2020-06-18 11:37:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446873', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '8', null, '2020-06-18 11:38:20', null, '2020-06-18 11:37:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446874', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '8', null, '2020-06-18 11:38:21', null, '2020-06-18 11:37:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446875', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '5', null, '2020-06-18 11:38:21', null, '2020-06-18 11:37:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446876', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '16', null, '2020-06-18 11:39:01', null, '2020-06-18 11:38:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446877', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-18 11:39:03', null, '2020-06-18 11:38:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446878', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '8', null, '2020-06-18 11:39:03', null, '2020-06-18 11:38:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446879', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-18 11:39:04', null, '2020-06-18 11:38:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446880', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-18 11:39:06', null, '2020-06-18 11:38:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446881', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-18 11:39:08', null, '2020-06-18 11:38:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446882', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-18 11:39:08', null, '2020-06-18 11:38:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446883', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 11:39:23', null, '2020-06-18 11:38:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446884', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2092', null, '2020-06-18 11:41:16', null, '2020-06-18 11:40:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446885', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '84', null, '2020-06-18 11:42:32', null, '2020-06-18 11:41:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446886', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'save', '2012', null, '2020-06-18 11:43:52', null, '2020-06-18 11:43:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446887', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '281', null, '2020-06-18 11:43:52', null, '2020-06-18 11:43:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446888', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 11:43:56', null, '2020-06-18 11:43:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446889', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '18', null, '2020-06-18 11:43:57', null, '2020-06-18 11:43:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446890', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-18 11:44:00', null, '2020-06-18 11:43:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446891', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 11:44:04', null, '2020-06-18 11:43:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446892', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'save', '202', null, '2020-06-18 11:44:15', null, '2020-06-18 11:43:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446893', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 11:44:15', null, '2020-06-18 11:43:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446894', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '83', null, '2020-06-18 12:05:55', null, '2020-06-18 12:05:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446895', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '93', null, '2020-06-18 12:05:55', null, '2020-06-18 12:05:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446896', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '99', null, '2020-06-18 12:05:55', null, '2020-06-18 12:05:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446897', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '98', null, '2020-06-18 12:05:55', null, '2020-06-18 12:05:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446898', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '35', null, '2020-06-18 12:05:56', null, '2020-06-18 12:05:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446899', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 12:05:57', null, '2020-06-18 12:05:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446900', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'save', '146', null, '2020-06-18 12:06:12', null, '2020-06-18 12:05:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446901', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-18 12:06:12', null, '2020-06-18 12:05:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446902', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'update', '37', null, '2020-06-18 12:06:16', null, '2020-06-18 12:05:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446903', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '10', null, '2020-06-18 12:06:16', null, '2020-06-18 12:05:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446904', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'delete', '35', null, '2020-06-18 12:06:20', null, '2020-06-18 12:05:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446905', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '8', null, '2020-06-18 12:06:20', null, '2020-06-18 12:05:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446906', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 12:06:21', null, '2020-06-18 12:05:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446907', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'save', '44', null, '2020-06-18 12:06:25', null, '2020-06-18 12:05:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446908', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-18 12:06:25', null, '2020-06-18 12:05:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446909', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '57', null, '2020-06-18 12:07:57', null, '2020-06-18 12:07:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446910', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-18 12:07:57', null, '2020-06-18 12:07:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446911', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '15', null, '2020-06-18 12:07:57', null, '2020-06-18 12:07:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446912', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '8', null, '2020-06-18 12:07:59', null, '2020-06-18 12:07:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446913', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '10', null, '2020-06-18 12:08:00', null, '2020-06-18 12:07:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446914', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 12:08:00', null, '2020-06-18 12:07:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446915', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 12:08:02', null, '2020-06-18 12:07:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446916', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'delete', '35', null, '2020-06-18 12:08:04', null, '2020-06-18 12:07:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446917', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 12:08:04', null, '2020-06-18 12:07:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446918', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'delete', '32', null, '2020-06-18 12:08:06', null, '2020-06-18 12:07:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446919', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 12:08:06', null, '2020-06-18 12:07:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446920', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'update', '37', null, '2020-06-18 12:08:10', null, '2020-06-18 12:07:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446921', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 12:08:11', null, '2020-06-18 12:07:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446922', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-18 12:08:15', null, '2020-06-18 12:07:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446923', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'save', '35', null, '2020-06-18 12:08:20', null, '2020-06-18 12:07:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446924', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 12:08:20', null, '2020-06-18 12:07:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446925', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 12:08:22', null, '2020-06-18 12:07:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446926', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'delete', '32', null, '2020-06-18 12:08:26', null, '2020-06-18 12:07:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446927', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 12:08:26', null, '2020-06-18 12:07:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446928', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'save', '33', null, '2020-06-18 12:08:31', null, '2020-06-18 12:07:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446929', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 12:08:31', null, '2020-06-18 12:07:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446930', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'delete', '34', null, '2020-06-18 12:08:34', null, '2020-06-18 12:07:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446931', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '5', null, '2020-06-18 12:08:34', null, '2020-06-18 12:07:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446932', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'save', '65', null, '2020-06-18 12:08:38', null, '2020-06-18 12:08:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446933', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 12:08:38', null, '2020-06-18 12:08:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446934', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '26', null, '2020-06-18 13:39:57', null, '2020-06-18 13:39:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446935', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 13:39:57', null, '2020-06-18 13:39:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446936', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '20', null, '2020-06-18 13:39:57', null, '2020-06-18 13:39:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446937', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '31', null, '2020-06-18 13:41:20', null, '2020-06-18 13:40:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446938', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '41', null, '2020-06-18 13:41:21', null, '2020-06-18 13:40:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446939', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-18 13:41:22', null, '2020-06-18 13:40:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446940', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '8', null, '2020-06-18 13:41:24', null, '2020-06-18 13:40:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446941', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '6', null, '2020-06-18 13:41:25', null, '2020-06-18 13:40:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446942', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-18 13:41:25', null, '2020-06-18 13:40:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446943', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 13:42:08', null, '2020-06-18 13:41:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446944', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '38', null, '2020-06-18 13:43:08', null, '2020-06-18 13:42:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446945', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '52', null, '2020-06-18 13:43:08', null, '2020-06-18 13:42:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446946', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 13:43:10', null, '2020-06-18 13:42:34', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446947', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 13:44:06', null, '2020-06-18 13:43:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446948', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '11', null, '2020-06-18 13:44:06', null, '2020-06-18 13:43:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446949', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-18 13:44:06', null, '2020-06-18 13:43:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446950', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 13:44:07', null, '2020-06-18 13:43:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446951', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 13:44:08', null, '2020-06-18 13:43:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446952', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '7', null, '2020-06-18 13:44:08', null, '2020-06-18 13:43:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446953', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 13:44:08', null, '2020-06-18 13:43:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446954', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-18 13:44:10', null, '2020-06-18 13:43:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446955', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-18 13:44:21', null, '2020-06-18 13:43:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446956', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 13:44:25', null, '2020-06-18 13:43:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446957', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-18 13:44:30', null, '2020-06-18 13:43:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446958', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-18 13:44:31', null, '2020-06-18 13:43:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446959', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 13:44:32', null, '2020-06-18 13:43:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446960', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-18 13:44:50', null, '2020-06-18 13:44:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446961', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 13:44:58', null, '2020-06-18 13:44:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446962', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-18 13:45:01', null, '2020-06-18 13:44:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446963', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-18 13:45:08', null, '2020-06-18 13:44:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446964', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'save', '47', null, '2020-06-18 13:45:39', null, '2020-06-18 13:45:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446965', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-18 13:45:39', null, '2020-06-18 13:45:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446966', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'save', '31', null, '2020-06-18 13:45:44', null, '2020-06-18 13:45:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446967', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 13:45:44', null, '2020-06-18 13:45:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446968', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'update', '314', null, '2020-06-18 13:45:49', null, '2020-06-18 13:45:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446969', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 13:45:49', null, '2020-06-18 13:45:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446970', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '18', null, '2020-06-18 13:46:57', null, '2020-06-18 13:46:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446971', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-18 13:46:58', null, '2020-06-18 13:46:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446972', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-18 13:46:58', null, '2020-06-18 13:46:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446973', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '40', null, '2020-06-18 13:56:27', null, '2020-06-18 13:55:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446974', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 13:56:29', null, '2020-06-18 13:55:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446975', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '7', null, '2020-06-18 13:56:30', null, '2020-06-18 13:55:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446976', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '34', null, '2020-06-18 13:56:30', null, '2020-06-18 13:55:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446977', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '51', null, '2020-06-18 13:57:57', null, '2020-06-18 13:57:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446978', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '7', null, '2020-06-18 13:57:57', null, '2020-06-18 13:57:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446979', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '26', null, '2020-06-18 13:57:58', null, '2020-06-18 13:57:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446980', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '30', null, '2020-06-18 13:59:16', null, '2020-06-18 13:58:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446981', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-18 13:59:17', null, '2020-06-18 13:58:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446982', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '92', null, '2020-06-18 14:00:52', null, '2020-06-18 14:00:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446983', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '7', null, '2020-06-18 14:00:52', null, '2020-06-18 14:00:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446984', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 14:01:29', null, '2020-06-18 14:00:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446985', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '8', null, '2020-06-18 14:01:30', null, '2020-06-18 14:00:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446986', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '48', null, '2020-06-18 14:06:05', null, '2020-06-18 14:05:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446987', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '9', null, '2020-06-18 14:06:46', null, '2020-06-18 14:06:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446988', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '17', null, '2020-06-18 14:06:46', null, '2020-06-18 14:06:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446989', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '27', null, '2020-06-18 14:06:46', null, '2020-06-18 14:06:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446990', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '8', null, '2020-06-18 14:06:46', null, '2020-06-18 14:06:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446991', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '8', null, '2020-06-18 14:06:47', null, '2020-06-18 14:06:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446992', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '53', null, '2020-06-18 14:09:36', null, '2020-06-18 14:09:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446993', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '59', null, '2020-06-18 14:09:36', null, '2020-06-18 14:09:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446994', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '10', null, '2020-06-18 14:09:48', null, '2020-06-18 14:09:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446995', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '37', null, '2020-06-18 14:11:37', null, '2020-06-18 14:11:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446996', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '43', null, '2020-06-18 14:11:37', null, '2020-06-18 14:11:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446997', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '54', null, '2020-06-18 14:13:01', null, '2020-06-18 14:12:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446998', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '65', null, '2020-06-18 14:13:01', null, '2020-06-18 14:12:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084446999', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '196', null, '2020-06-18 14:14:52', null, '2020-06-18 14:14:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447000', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '196', null, '2020-06-18 14:14:52', null, '2020-06-18 14:14:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447001', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '350', null, '2020-06-18 14:15:51', null, '2020-06-18 14:15:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447002', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '14', null, '2020-06-18 14:15:52', null, '2020-06-18 14:15:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447003', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '52', null, '2020-06-18 14:19:02', null, '2020-06-18 14:18:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447004', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '31', null, '2020-06-18 14:19:03', null, '2020-06-18 14:18:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447005', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '37', null, '2020-06-18 14:19:03', null, '2020-06-18 14:18:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447006', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '46', null, '2020-06-18 14:21:27', null, '2020-06-18 14:20:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447007', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-18 14:21:28', null, '2020-06-18 14:20:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447008', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '17', null, '2020-06-18 14:21:28', null, '2020-06-18 14:20:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447009', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'update', '228', null, '2020-06-18 14:21:36', null, '2020-06-18 14:21:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447010', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '13', null, '2020-06-18 14:21:36', null, '2020-06-18 14:21:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447011', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '58', null, '2020-06-18 14:23:32', null, '2020-06-18 14:22:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447012', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '50', null, '2020-06-18 14:23:33', null, '2020-06-18 14:22:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447013', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '59', null, '2020-06-18 14:23:33', null, '2020-06-18 14:22:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447014', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '53', null, '2020-06-18 14:27:37', null, '2020-06-18 14:27:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447015', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-18 14:27:38', null, '2020-06-18 14:27:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447016', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '25', null, '2020-06-18 14:27:38', null, '2020-06-18 14:27:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447017', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '33', null, '2020-06-18 14:28:36', null, '2020-06-18 14:28:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447018', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-18 14:28:37', null, '2020-06-18 14:28:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447019', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '18', null, '2020-06-18 14:28:37', null, '2020-06-18 14:28:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447020', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '95', null, '2020-06-18 14:30:19', null, '2020-06-18 14:29:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447021', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '84', null, '2020-06-18 14:30:19', null, '2020-06-18 14:29:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447022', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '84', null, '2020-06-18 14:30:19', null, '2020-06-18 14:29:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447023', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '98', null, '2020-06-18 14:30:19', null, '2020-06-18 14:29:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447024', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '92', null, '2020-06-18 14:30:19', null, '2020-06-18 14:29:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447025', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '89', null, '2020-06-18 14:30:19', null, '2020-06-18 14:29:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447026', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '81', null, '2020-06-18 14:31:40', null, '2020-06-18 14:31:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447027', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '14', null, '2020-06-18 14:31:57', null, '2020-06-18 14:31:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447028', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '241', null, '2020-06-18 14:35:58', null, '2020-06-18 14:35:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447029', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '92', null, '2020-06-18 14:42:53', null, '2020-06-18 14:42:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447030', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '109', null, '2020-06-18 14:42:53', null, '2020-06-18 14:42:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447031', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '58', null, '2020-06-18 14:42:55', null, '2020-06-18 14:42:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447032', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '65', null, '2020-06-18 14:42:55', null, '2020-06-18 14:42:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447033', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '32', null, '2020-06-18 14:45:46', null, '2020-06-18 14:45:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447034', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '17', null, '2020-06-18 14:45:46', null, '2020-06-18 14:45:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447035', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 14:45:48', null, '2020-06-18 14:45:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447036', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-18 14:45:49', null, '2020-06-18 14:45:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447037', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '27', null, '2020-06-18 14:45:49', null, '2020-06-18 14:45:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447038', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '44', null, '2020-06-18 14:49:26', null, '2020-06-18 14:48:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447039', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '28', null, '2020-06-18 14:49:26', null, '2020-06-18 14:48:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447040', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 14:49:29', null, '2020-06-18 14:48:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447041', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '37', null, '2020-06-18 14:56:32', null, '2020-06-18 14:55:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447042', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '20', null, '2020-06-18 14:56:48', null, '2020-06-18 14:56:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447043', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '31', null, '2020-06-18 14:56:48', null, '2020-06-18 14:56:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447044', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '11', null, '2020-06-18 14:56:50', null, '2020-06-18 14:56:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447045', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 14:56:50', null, '2020-06-18 14:56:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447046', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '22', null, '2020-06-18 14:58:52', null, '2020-06-18 14:58:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447047', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '34', null, '2020-06-18 14:58:52', null, '2020-06-18 14:58:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447048', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 14:58:54', null, '2020-06-18 14:58:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447049', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '17', null, '2020-06-18 14:58:54', null, '2020-06-18 14:58:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447050', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '55', null, '2020-06-18 14:59:17', null, '2020-06-18 14:58:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447051', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '15', null, '2020-06-18 14:59:17', null, '2020-06-18 14:58:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447052', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '54', null, '2020-06-18 14:59:41', null, '2020-06-18 14:59:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447053', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '27', null, '2020-06-18 14:59:42', null, '2020-06-18 14:59:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447054', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '2090', null, '2020-06-18 15:01:54', null, '2020-06-18 15:01:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447055', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '82', null, '2020-06-18 15:01:54', null, '2020-06-18 15:01:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447056', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '334', null, '2020-06-18 15:01:59', null, '2020-06-18 15:01:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447057', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'save', '146', null, '2020-06-18 15:02:06', null, '2020-06-18 15:01:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447058', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '19', null, '2020-06-18 15:02:06', null, '2020-06-18 15:01:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447059', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'delete', '39', null, '2020-06-18 15:02:09', null, '2020-06-18 15:01:34', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447060', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '19', null, '2020-06-18 15:02:10', null, '2020-06-18 15:01:34', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447061', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'save', '531', null, '2020-06-18 15:02:19', null, '2020-06-18 15:01:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447062', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '17', null, '2020-06-18 15:02:20', null, '2020-06-18 15:01:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447063', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '64', null, '2020-06-18 15:04:58', null, '2020-06-18 15:04:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447064', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '51', null, '2020-06-18 15:06:00', null, '2020-06-18 15:05:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447065', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '14', null, '2020-06-18 15:06:00', null, '2020-06-18 15:05:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447066', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 15:06:01', null, '2020-06-18 15:05:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447067', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict/list', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '26', null, '2020-06-18 15:06:17', null, '2020-06-18 15:05:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447068', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '2696', null, '2020-06-18 15:18:22', null, '2020-06-18 15:17:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447069', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2803', null, '2020-06-18 15:18:22', null, '2020-06-18 15:17:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447070', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-18 15:18:23', null, '2020-06-18 15:17:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447071', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '25', null, '2020-06-18 15:18:37', null, '2020-06-18 15:18:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447072', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '40', null, '2020-06-18 15:20:43', null, '2020-06-18 15:20:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447073', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '31', null, '2020-06-18 15:20:43', null, '2020-06-18 15:20:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447074', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '41', null, '2020-06-18 15:24:22', null, '2020-06-18 15:23:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447075', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '15', null, '2020-06-18 15:24:23', null, '2020-06-18 15:23:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447076', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '64', null, '2020-06-18 15:25:29', null, '2020-06-18 15:24:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447077', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '17987', null, '2020-06-18 15:27:55', null, '2020-06-18 15:27:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447078', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/password', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'modifyPassword', '6364', null, '2020-06-18 15:37:40', null, '2020-06-18 15:37:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447079', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/password', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'modifyPassword', '2776', null, '2020-06-18 15:37:49', null, '2020-06-18 15:37:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447080', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/admin/password', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'modifyPassword', '110', null, '2020-06-18 15:39:24', null, '2020-06-18 15:38:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447081', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/password', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'modifyPassword', '58', null, '2020-06-18 15:39:40', null, '2020-06-18 15:39:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447082', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '316', null, '2020-06-18 15:39:41', null, '2020-06-18 15:39:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447083', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '20', null, '2020-06-18 15:39:41', null, '2020-06-18 15:39:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447084', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/password', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'modifyPassword', '83', null, '2020-06-18 15:39:43', null, '2020-06-18 15:39:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447085', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '63', null, '2020-06-18 15:41:37', null, '2020-06-18 15:41:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447086', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '82', null, '2020-06-18 15:41:37', null, '2020-06-18 15:41:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447087', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '24', null, '2020-06-18 15:42:23', null, '2020-06-18 15:41:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447088', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '89', null, '2020-06-18 15:42:24', null, '2020-06-18 15:41:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447089', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-18 15:42:28', null, '2020-06-18 15:41:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447090', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '17', null, '2020-06-18 15:42:29', null, '2020-06-18 15:41:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447091', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '16', null, '2020-06-18 15:42:30', null, '2020-06-18 15:41:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447092', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '41', null, '2020-06-18 15:43:58', null, '2020-06-18 15:43:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447093', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '62', null, '2020-06-18 15:43:58', null, '2020-06-18 15:43:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447094', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '22', null, '2020-06-18 15:44:41', null, '2020-06-18 15:44:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447095', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '17', null, '2020-06-18 15:45:22', null, '2020-06-18 15:44:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447096', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '32', null, '2020-06-18 15:45:23', null, '2020-06-18 15:44:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447097', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '328', null, '2020-06-18 15:45:23', null, '2020-06-18 15:44:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447098', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '15', null, '2020-06-18 15:45:24', null, '2020-06-18 15:44:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447099', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '25', null, '2020-06-18 15:47:08', null, '2020-06-18 15:46:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447100', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '21', null, '2020-06-18 15:47:08', null, '2020-06-18 15:46:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447101', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 15:47:09', null, '2020-06-18 15:46:34', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447102', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '72', null, '2020-06-18 15:47:16', null, '2020-06-18 15:46:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447103', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '12', null, '2020-06-18 15:47:38', null, '2020-06-18 15:47:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447104', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '13318', null, '2020-06-18 15:48:05', null, '2020-06-18 15:47:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447105', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '1350', null, '2020-06-18 15:48:52', null, '2020-06-18 15:48:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447106', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-18 15:49:30', null, '2020-06-18 15:48:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447107', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 15:49:31', null, '2020-06-18 15:48:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447108', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '3489', null, '2020-06-18 15:49:37', null, '2020-06-18 15:49:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447109', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '736', null, '2020-06-18 15:54:19', null, '2020-06-18 15:53:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447110', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '19', null, '2020-06-18 15:55:01', null, '2020-06-18 15:54:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447111', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-18 15:55:03', null, '2020-06-18 15:54:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447112', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '122', null, '2020-06-18 15:55:08', null, '2020-06-18 15:54:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447113', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-18 15:55:08', null, '2020-06-18 15:54:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447114', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '807', null, '2020-06-18 15:56:18', null, '2020-06-18 15:55:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447115', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 15:56:20', null, '2020-06-18 15:55:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447116', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 15:56:21', null, '2020-06-18 15:55:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447117', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '45', null, '2020-06-18 15:56:31', null, '2020-06-18 15:55:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447118', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '58', null, '2020-06-18 15:56:34', null, '2020-06-18 15:55:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447119', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '19', null, '2020-06-18 15:56:34', null, '2020-06-18 15:55:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447120', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '16', null, '2020-06-18 15:56:43', null, '2020-06-18 15:56:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447121', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 15:57:26', null, '2020-06-18 15:56:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447122', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '4', null, '2020-06-18 15:57:26', null, '2020-06-18 15:56:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447123', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 15:58:22', null, '2020-06-18 15:57:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447124', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '5', null, '2020-06-18 15:58:22', null, '2020-06-18 15:57:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447125', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 15:59:15', null, '2020-06-18 15:58:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447126', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '5', null, '2020-06-18 15:59:16', null, '2020-06-18 15:58:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447127', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '6', null, '2020-06-18 15:59:44', null, '2020-06-18 15:59:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447128', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '30', null, '2020-06-18 15:59:49', null, '2020-06-18 15:59:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447129', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '42', null, '2020-06-18 15:59:49', null, '2020-06-18 15:59:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447130', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-18 16:00:07', null, '2020-06-18 15:59:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447131', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '15', null, '2020-06-18 16:00:12', null, '2020-06-18 15:59:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447132', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-18 16:00:16', null, '2020-06-18 15:59:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447133', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-18 16:00:16', null, '2020-06-18 15:59:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447134', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'update', '56', null, '2020-06-18 16:00:19', null, '2020-06-18 15:59:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447135', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-18 16:00:19', null, '2020-06-18 15:59:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447136', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '7', null, '2020-06-18 16:00:21', null, '2020-06-18 15:59:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447137', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 16:00:34', null, '2020-06-18 15:59:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447138', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '7', null, '2020-06-18 16:00:35', null, '2020-06-18 16:00:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447139', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-18 16:00:49', null, '2020-06-18 16:00:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447140', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '23', null, '2020-06-18 16:00:49', null, '2020-06-18 16:00:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447141', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'update', '1068', null, '2020-06-18 16:01:01', null, '2020-06-18 16:00:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447142', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-18 16:01:01', null, '2020-06-18 16:00:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447143', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '6', null, '2020-06-18 16:01:03', null, '2020-06-18 16:00:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447144', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '6', null, '2020-06-18 16:01:11', null, '2020-06-18 16:00:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447145', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'save', '320', null, '2020-06-18 16:01:24', null, '2020-06-18 16:00:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447146', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '11', null, '2020-06-18 16:01:24', null, '2020-06-18 16:00:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447147', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '56', null, '2020-06-18 16:02:03', null, '2020-06-18 16:01:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447148', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-18 16:02:04', null, '2020-06-18 16:01:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447149', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '9', null, '2020-06-18 16:02:45', null, '2020-06-18 16:02:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447150', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'save', '1044', null, '2020-06-18 16:02:52', null, '2020-06-18 16:02:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447151', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '10', null, '2020-06-18 16:02:52', null, '2020-06-18 16:02:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447152', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'update', '12', null, '2020-06-18 16:03:29', null, '2020-06-18 16:02:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447153', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '9', null, '2020-06-18 16:03:29', null, '2020-06-18 16:02:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447154', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'update', '8', null, '2020-06-18 16:03:45', null, '2020-06-18 16:03:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447155', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '10', null, '2020-06-18 16:03:45', null, '2020-06-18 16:03:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447156', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'update', '5', null, '2020-06-18 16:03:45', null, '2020-06-18 16:03:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447157', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '7', null, '2020-06-18 16:03:45', null, '2020-06-18 16:03:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447158', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '42', null, '2020-06-18 16:05:31', null, '2020-06-18 16:04:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447159', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'save', '38', null, '2020-06-18 16:05:34', null, '2020-06-18 16:04:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447160', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '10', null, '2020-06-18 16:05:34', null, '2020-06-18 16:04:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447161', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'update', '11', null, '2020-06-18 16:05:41', null, '2020-06-18 16:05:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447162', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '8', null, '2020-06-18 16:05:41', null, '2020-06-18 16:05:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447163', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '7', null, '2020-06-18 16:05:49', null, '2020-06-18 16:05:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447164', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'save', '2274', null, '2020-06-18 16:06:54', null, '2020-06-18 16:06:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447165', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '231', null, '2020-06-18 16:07:35', null, '2020-06-18 16:07:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447166', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '68', null, '2020-06-18 16:08:16', null, '2020-06-18 16:07:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447167', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '10', null, '2020-06-18 16:08:16', null, '2020-06-18 16:07:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447168', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 16:08:18', null, '2020-06-18 16:07:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447169', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '11', null, '2020-06-18 16:08:19', null, '2020-06-18 16:07:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447170', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'save', '971', null, '2020-06-18 16:08:51', null, '2020-06-18 16:08:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447171', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '8', null, '2020-06-18 16:08:51', null, '2020-06-18 16:08:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447172', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'update', '44', null, '2020-06-18 16:08:57', null, '2020-06-18 16:08:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447173', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '6', null, '2020-06-18 16:08:57', null, '2020-06-18 16:08:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447174', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '35', null, '2020-06-18 16:09:08', null, '2020-06-18 16:08:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447175', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '9', null, '2020-06-18 16:09:19', null, '2020-06-18 16:08:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447176', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'delete', '765', null, '2020-06-18 16:09:48', null, '2020-06-18 16:09:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447177', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '6', null, '2020-06-18 16:09:48', null, '2020-06-18 16:09:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447178', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'save', '36', null, '2020-06-18 16:09:54', null, '2020-06-18 16:09:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447179', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '7', null, '2020-06-18 16:09:54', null, '2020-06-18 16:09:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447180', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'delete', '29', null, '2020-06-18 16:09:56', null, '2020-06-18 16:09:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447181', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '7', null, '2020-06-18 16:09:56', null, '2020-06-18 16:09:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447182', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'update', '56', null, '2020-06-18 16:10:00', null, '2020-06-18 16:09:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447183', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '7', null, '2020-06-18 16:10:01', null, '2020-06-18 16:09:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447184', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '10', null, '2020-06-18 16:10:48', null, '2020-06-18 16:10:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447185', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '6', null, '2020-06-18 16:10:49', null, '2020-06-18 16:10:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447186', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'save', '85', null, '2020-06-18 16:11:12', null, '2020-06-18 16:10:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447187', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '9', null, '2020-06-18 16:11:12', null, '2020-06-18 16:10:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447188', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'update', '8', null, '2020-06-18 16:11:21', null, '2020-06-18 16:10:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447189', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '10', null, '2020-06-18 16:11:21', null, '2020-06-18 16:10:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447190', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '39', null, '2020-06-18 16:12:34', null, '2020-06-18 16:11:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447191', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '31', null, '2020-06-18 16:13:29', null, '2020-06-18 16:12:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447192', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '34', null, '2020-06-18 16:13:29', null, '2020-06-18 16:12:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447193', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 16:13:31', null, '2020-06-18 16:12:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447194', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '7', null, '2020-06-18 16:13:31', null, '2020-06-18 16:12:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447195', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '29', null, '2020-06-18 16:16:32', null, '2020-06-18 16:15:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447196', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '8', null, '2020-06-18 16:16:34', null, '2020-06-18 16:15:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447197', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '7', null, '2020-06-18 16:16:36', null, '2020-06-18 16:16:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447198', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '7', null, '2020-06-18 16:16:41', null, '2020-06-18 16:16:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447199', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'update', '40', null, '2020-06-18 16:16:48', null, '2020-06-18 16:16:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447200', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '7159', null, '2020-06-18 16:16:55', null, '2020-06-18 16:16:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447201', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'delete', '8', null, '2020-06-18 16:17:00', null, '2020-06-18 16:16:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447202', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '2736', null, '2020-06-18 16:17:03', null, '2020-06-18 16:16:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447203', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/message/config', null, null, 'com.purete.coc.message.controller.MessageConfigController', 'save', '82', null, '2020-06-18 16:17:24', null, '2020-06-18 16:16:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447204', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'delete', '7', null, '2020-06-18 16:18:02', null, '2020-06-18 16:17:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447205', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '4415', null, '2020-06-18 16:18:07', null, '2020-06-18 16:17:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447206', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '961', null, '2020-06-18 16:18:07', null, '2020-06-18 16:17:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447207', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'delete', '3', null, '2020-06-18 16:18:10', null, '2020-06-18 16:17:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447208', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '1523', null, '2020-06-18 16:18:12', null, '2020-06-18 16:17:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447209', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'delete', '3', null, '2020-06-18 16:18:19', null, '2020-06-18 16:17:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447210', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '1519', null, '2020-06-18 16:18:21', null, '2020-06-18 16:17:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447211', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '5953', null, '2020-06-18 16:18:38', null, '2020-06-18 16:18:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447212', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '742', null, '2020-06-18 16:18:54', null, '2020-06-18 16:18:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447213', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2145', null, '2020-06-18 16:18:54', null, '2020-06-18 16:18:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447214', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'delete', '4', null, '2020-06-18 16:18:56', null, '2020-06-18 16:18:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447215', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '1656', null, '2020-06-18 16:18:58', null, '2020-06-18 16:18:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447216', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '4194', null, '2020-06-18 16:20:45', null, '2020-06-18 16:20:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447217', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '4185', null, '2020-06-18 16:20:45', null, '2020-06-18 16:20:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447218', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'delete', '40', null, '2020-06-18 16:20:50', null, '2020-06-18 16:20:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447219', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '1703', null, '2020-06-18 16:20:52', null, '2020-06-18 16:20:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447220', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '4198', null, '2020-06-18 16:21:01', null, '2020-06-18 16:20:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447221', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '3982', null, '2020-06-18 16:21:26', null, '2020-06-18 16:20:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447222', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '1110', null, '2020-06-18 16:21:41', null, '2020-06-18 16:21:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447223', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '82', null, '2020-06-18 16:21:50', null, '2020-06-18 16:21:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447224', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '82', null, '2020-06-18 16:21:50', null, '2020-06-18 16:21:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447225', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '2477', null, '2020-06-18 16:21:59', null, '2020-06-18 16:21:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447226', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'update', '72', null, '2020-06-18 16:22:07', null, '2020-06-18 16:21:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447227', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '18', null, '2020-06-18 16:22:07', null, '2020-06-18 16:21:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447228', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '3149', null, '2020-06-18 16:22:14', null, '2020-06-18 16:21:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447229', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2154', null, '2020-06-18 16:22:17', null, '2020-06-18 16:21:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447230', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '14', null, '2020-06-18 16:22:32', null, '2020-06-18 16:21:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447231', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 16:22:38', null, '2020-06-18 16:22:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447232', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '5588', null, '2020-06-18 16:24:48', null, '2020-06-18 16:24:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447233', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '5620', null, '2020-06-18 16:24:48', null, '2020-06-18 16:24:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447234', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '709', null, '2020-06-18 16:24:49', null, '2020-06-18 16:24:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447235', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '51', null, '2020-06-18 16:24:56', null, '2020-06-18 16:24:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447236', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-18 16:24:57', null, '2020-06-18 16:24:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447237', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '47', null, '2020-06-18 16:25:02', null, '2020-06-18 16:24:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447238', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '63', null, '2020-06-18 16:25:02', null, '2020-06-18 16:24:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447239', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '15', null, '2020-06-18 16:25:03', null, '2020-06-18 16:24:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447240', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-18 16:25:09', null, '2020-06-18 16:24:34', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447241', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '17', null, '2020-06-18 16:25:14', null, '2020-06-18 16:24:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447242', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '73', null, '2020-06-18 16:25:26', null, '2020-06-18 16:24:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447243', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '1149', null, '2020-06-18 16:25:53', null, '2020-06-18 16:25:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447244', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 16:25:54', null, '2020-06-18 16:25:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447245', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '50', null, '2020-06-18 16:28:29', null, '2020-06-18 16:27:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447246', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 16:28:31', null, '2020-06-18 16:27:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447247', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '66', null, '2020-06-18 16:31:07', null, '2020-06-18 16:30:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447248', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '78', null, '2020-06-18 16:31:07', null, '2020-06-18 16:30:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447249', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '89', null, '2020-06-18 16:31:07', null, '2020-06-18 16:30:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447250', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '23', null, '2020-06-18 16:31:07', null, '2020-06-18 16:30:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447251', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '34398', null, '2020-06-18 16:33:03', null, '2020-06-18 16:32:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447252', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '14', null, '2020-06-18 16:33:03', null, '2020-06-18 16:32:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447253', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '11', null, '2020-06-18 16:33:38', null, '2020-06-18 16:33:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447254', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'save', '546', null, '2020-06-18 16:35:43', null, '2020-06-18 16:35:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447255', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '10', null, '2020-06-18 16:35:43', null, '2020-06-18 16:35:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447256', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '62', null, '2020-06-18 16:38:45', null, '2020-06-18 16:38:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447257', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '14', null, '2020-06-18 16:38:47', null, '2020-06-18 16:38:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447258', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '22', null, '2020-06-18 16:38:48', null, '2020-06-18 16:38:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447259', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '15', null, '2020-06-18 16:39:01', null, '2020-06-18 16:38:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447260', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '12', null, '2020-06-18 16:39:45', null, '2020-06-18 16:39:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447261', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '10', null, '2020-06-18 16:39:46', null, '2020-06-18 16:39:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447262', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '12', null, '2020-06-18 16:39:56', null, '2020-06-18 16:39:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447263', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '2085', null, '2020-06-18 16:43:22', null, '2020-06-18 16:42:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447264', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '22', null, '2020-06-18 16:43:27', null, '2020-06-18 16:42:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447265', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '36', null, '2020-06-18 16:46:37', null, '2020-06-18 16:46:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447266', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '15', null, '2020-06-18 16:46:37', null, '2020-06-18 16:46:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447267', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '15', null, '2020-06-18 16:46:38', null, '2020-06-18 16:46:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447268', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '94', null, '2020-06-18 16:47:45', null, '2020-06-18 16:47:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447269', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '27', null, '2020-06-18 16:47:45', null, '2020-06-18 16:47:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447270', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '37', null, '2020-06-18 16:49:20', null, '2020-06-18 16:48:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447271', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '13', null, '2020-06-18 16:49:30', null, '2020-06-18 16:48:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447272', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '15', null, '2020-06-18 16:49:45', null, '2020-06-18 16:49:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447273', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '36', null, '2020-06-18 16:49:46', null, '2020-06-18 16:49:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447274', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '36', null, '2020-06-18 16:49:47', null, '2020-06-18 16:49:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447275', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '8', null, '2020-06-18 16:49:48', null, '2020-06-18 16:49:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447276', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '8', null, '2020-06-18 16:49:49', null, '2020-06-18 16:49:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447277', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '9', null, '2020-06-18 16:50:28', null, '2020-06-18 16:49:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447278', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-18 16:51:14', null, '2020-06-18 16:50:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447279', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '33', null, '2020-06-18 16:52:21', null, '2020-06-18 16:51:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447280', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '15', null, '2020-06-18 16:53:24', null, '2020-06-18 16:52:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447281', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '20', null, '2020-06-18 16:53:25', null, '2020-06-18 16:52:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447282', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '10', null, '2020-06-18 16:53:31', null, '2020-06-18 16:52:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447283', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '68', null, '2020-06-18 16:53:41', null, '2020-06-18 16:53:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447284', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '17', null, '2020-06-18 16:53:41', null, '2020-06-18 16:53:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447285', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-18 16:53:43', null, '2020-06-18 16:53:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447286', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '53', null, '2020-06-18 16:53:43', null, '2020-06-18 16:53:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447287', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-18 16:53:44', null, '2020-06-18 16:53:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447288', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-18 16:53:44', null, '2020-06-18 16:53:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447289', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-18 16:53:45', null, '2020-06-18 16:53:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447290', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '7', null, '2020-06-18 16:53:47', null, '2020-06-18 16:53:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447291', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-18 16:53:48', null, '2020-06-18 16:53:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447292', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-18 16:53:51', null, '2020-06-18 16:53:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447293', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-18 16:54:04', null, '2020-06-18 16:53:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447294', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '41', null, '2020-06-18 16:54:58', null, '2020-06-18 16:54:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447295', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '30', null, '2020-06-18 16:54:58', null, '2020-06-18 16:54:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447296', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '33', null, '2020-06-18 16:54:58', null, '2020-06-18 16:54:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447297', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '37', null, '2020-06-18 16:54:58', null, '2020-06-18 16:54:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447298', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '21', null, '2020-06-18 16:54:59', null, '2020-06-18 16:54:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447299', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '18', null, '2020-06-18 16:56:33', null, '2020-06-18 16:55:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447300', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '7', null, '2020-06-18 16:56:37', null, '2020-06-18 16:56:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447301', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '46', null, '2020-06-18 16:58:09', null, '2020-06-18 16:57:34', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447302', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '7120', null, '2020-06-18 17:01:28', null, '2020-06-18 17:00:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447303', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '229', null, '2020-06-18 17:01:28', null, '2020-06-18 17:00:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447304', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '4843', null, '2020-06-18 17:01:45', null, '2020-06-18 17:01:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447305', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-18 17:01:45', null, '2020-06-18 17:01:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447306', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '52', null, '2020-06-18 17:02:12', null, '2020-06-18 17:01:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447307', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '2076', null, '2020-06-18 17:04:15', null, '2020-06-18 17:03:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447308', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/1', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '2640', null, '2020-06-18 17:04:23', null, '2020-06-18 17:03:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447309', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '26', null, '2020-06-18 17:04:30', null, '2020-06-18 17:03:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447310', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/1', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '4966', null, '2020-06-18 17:04:37', null, '2020-06-18 17:04:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447311', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '56', null, '2020-06-18 17:05:13', null, '2020-06-18 17:04:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447312', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '4', null, '2020-06-18 17:05:14', null, '2020-06-18 17:04:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447313', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '47', null, '2020-06-18 17:09:08', null, '2020-06-18 17:08:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447314', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '12', null, '2020-06-18 17:09:09', null, '2020-06-18 17:08:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447315', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'update', '84', null, '2020-06-18 17:12:45', null, '2020-06-18 17:12:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447316', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'update', '64', null, '2020-06-18 17:15:25', null, '2020-06-18 17:14:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447317', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '60', null, '2020-06-18 17:15:34', null, '2020-06-18 17:14:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447318', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '14', null, '2020-06-18 17:15:35', null, '2020-06-18 17:15:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447319', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '8', null, '2020-06-18 17:15:38', null, '2020-06-18 17:15:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447320', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '30', null, '2020-06-18 17:20:40', null, '2020-06-18 17:20:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447321', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-18 17:20:40', null, '2020-06-18 17:20:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447322', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '33', null, '2020-06-18 17:26:53', null, '2020-06-18 17:26:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447323', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '39', null, '2020-06-18 17:26:53', null, '2020-06-18 17:26:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447324', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'update', '31', null, '2020-06-18 17:27:18', null, '2020-06-18 17:26:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447325', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '34', null, '2020-06-18 17:29:41', null, '2020-06-18 17:29:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447326', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '24', null, '2020-06-18 17:29:42', null, '2020-06-18 17:29:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447327', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '33', null, '2020-06-18 17:32:34', null, '2020-06-18 17:31:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447328', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-18 17:32:35', null, '2020-06-18 17:32:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447329', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2739', null, '2020-06-18 17:39:21', null, '2020-06-18 17:38:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447330', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '69', null, '2020-06-18 17:39:23', null, '2020-06-18 17:38:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447331', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '8', null, '2020-06-18 17:39:26', null, '2020-06-18 17:38:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447332', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '6901', null, '2020-06-18 17:39:42', null, '2020-06-18 17:39:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447333', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '17', null, '2020-06-18 17:39:43', null, '2020-06-18 17:39:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447334', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '15', null, '2020-06-18 17:39:45', null, '2020-06-18 17:39:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447335', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '8', null, '2020-06-18 17:39:53', null, '2020-06-18 17:39:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447336', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '23', null, '2020-06-18 17:45:04', null, '2020-06-18 17:44:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447337', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '14', null, '2020-06-18 17:46:02', null, '2020-06-18 17:45:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447338', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '19', null, '2020-06-18 17:46:03', null, '2020-06-18 17:45:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447339', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '22', null, '2020-06-18 17:48:59', null, '2020-06-18 17:48:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447340', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-18 17:49:43', null, '2020-06-18 17:49:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447341', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '6', null, '2020-06-18 17:49:44', null, '2020-06-18 17:49:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447342', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '71', null, '2020-06-18 17:51:46', null, '2020-06-18 17:51:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447343', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '20', null, '2020-06-18 17:53:08', null, '2020-06-18 17:52:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447344', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '27', null, '2020-06-18 17:54:44', null, '2020-06-18 17:54:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447345', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '7', null, '2020-06-18 17:54:45', null, '2020-06-18 17:54:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447346', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '6', null, '2020-06-18 17:54:48', null, '2020-06-18 17:54:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447347', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'save', '45', null, '2020-06-18 17:55:03', null, '2020-06-18 17:54:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447348', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '13', null, '2020-06-18 17:55:03', null, '2020-06-18 17:54:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447349', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '23', null, '2020-06-18 17:58:18', null, '2020-06-18 17:57:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447350', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '2114', null, '2020-06-18 17:59:59', null, '2020-06-18 17:59:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447351', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '56', null, '2020-06-18 18:00:02', null, '2020-06-18 17:59:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447352', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '32', null, '2020-06-18 18:00:03', null, '2020-06-18 17:59:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447353', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '11', null, '2020-06-18 18:00:18', null, '2020-06-18 17:59:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447354', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '15', null, '2020-06-18 18:00:32', null, '2020-06-18 17:59:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447355', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '23', null, '2020-06-18 18:02:34', null, '2020-06-18 18:01:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447356', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '8', null, '2020-06-18 18:02:36', null, '2020-06-18 18:02:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447357', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'save', '36', null, '2020-06-18 18:03:08', null, '2020-06-18 18:02:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447358', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '8', null, '2020-06-18 18:03:08', null, '2020-06-18 18:02:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447359', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '25', null, '2020-06-18 18:06:13', null, '2020-06-18 18:05:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447360', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-18 18:06:18', null, '2020-06-18 18:05:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447361', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-18 18:06:18', null, '2020-06-18 18:05:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447362', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '10', null, '2020-06-18 18:06:30', null, '2020-06-18 18:05:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447363', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'save', '34', null, '2020-06-18 18:06:36', null, '2020-06-18 18:06:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447364', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '11', null, '2020-06-18 18:06:36', null, '2020-06-18 18:06:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447365', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'update', '34', null, '2020-06-18 18:06:41', null, '2020-06-18 18:06:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447366', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '8', null, '2020-06-18 18:06:41', null, '2020-06-18 18:06:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447367', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'update', '30', null, '2020-06-18 18:06:43', null, '2020-06-18 18:06:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447368', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-18 18:06:44', null, '2020-06-18 18:06:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447369', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'update', '45', null, '2020-06-18 18:06:47', null, '2020-06-18 18:06:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447370', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '8', null, '2020-06-18 18:06:47', null, '2020-06-18 18:06:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447371', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '35', null, '2020-06-18 18:07:44', null, '2020-06-18 18:07:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447372', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-18 18:07:49', null, '2020-06-18 18:07:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447373', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-18 18:07:53', null, '2020-06-18 18:07:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447374', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '21', null, '2020-06-18 18:10:10', null, '2020-06-18 18:09:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447375', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '8', null, '2020-06-18 18:10:12', null, '2020-06-18 18:09:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447376', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '33', null, '2020-06-18 18:10:39', null, '2020-06-18 18:10:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447377', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '34', null, '2020-06-18 18:10:41', null, '2020-06-18 18:10:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447378', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '11', null, '2020-06-18 18:10:44', null, '2020-06-18 18:10:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447379', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '11', null, '2020-06-18 18:10:57', null, '2020-06-18 18:10:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447380', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '4', null, '2020-06-18 18:10:59', null, '2020-06-18 18:10:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447381', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '8', null, '2020-06-18 18:11:46', null, '2020-06-18 18:11:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447382', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '23', null, '2020-06-18 18:13:50', null, '2020-06-18 18:13:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447383', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '49', null, '2020-06-18 18:13:50', null, '2020-06-18 18:13:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447384', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-18 18:13:58', null, '2020-06-18 18:13:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447385', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-18 18:13:58', null, '2020-06-18 18:13:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447386', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '23', null, '2020-06-18 18:16:56', null, '2020-06-18 18:16:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447387', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '23', null, '2020-06-18 18:19:24', null, '2020-06-18 18:18:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447388', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '43', null, '2020-06-18 18:27:54', null, '2020-06-18 18:27:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447389', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '6', null, '2020-06-18 18:27:57', null, '2020-06-18 18:27:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447390', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '35', null, '2020-06-18 18:31:19', null, '2020-06-18 18:30:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447391', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '7', null, '2020-06-18 18:31:19', null, '2020-06-18 18:30:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447392', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '13', null, '2020-06-18 18:31:38', null, '2020-06-18 18:31:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447393', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '120', null, '2020-06-18 18:31:38', null, '2020-06-18 18:31:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447394', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '36', null, '2020-06-18 18:32:49', null, '2020-06-18 18:32:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447395', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-18 18:33:12', null, '2020-06-18 18:32:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447396', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '18', null, '2020-06-18 18:33:13', null, '2020-06-18 18:32:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447397', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '10', null, '2020-06-18 18:33:20', null, '2020-06-18 18:32:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447398', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '26', null, '2020-06-18 18:37:15', null, '2020-06-18 18:36:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447399', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '7', null, '2020-06-18 18:37:16', null, '2020-06-18 18:36:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447400', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '22', null, '2020-06-18 18:38:56', null, '2020-06-18 18:38:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447401', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '43', null, '2020-06-18 18:38:56', null, '2020-06-18 18:38:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447402', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '28', null, '2020-06-18 18:40:29', null, '2020-06-18 18:39:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447403', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '2254', null, '2020-06-18 18:42:02', null, '2020-06-18 18:41:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447404', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '252', null, '2020-06-18 18:43:58', null, '2020-06-18 18:43:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447405', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '39', null, '2020-06-18 18:43:59', null, '2020-06-18 18:43:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447406', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '8', null, '2020-06-18 18:44:15', null, '2020-06-18 18:43:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447407', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '71', null, '2020-06-18 18:47:21', null, '2020-06-18 18:46:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447408', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2220', null, '2020-06-19 14:10:40', null, '2020-06-19 14:10:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447409', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '2220', null, '2020-06-19 14:10:40', null, '2020-06-19 14:10:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447410', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '31', null, '2020-06-19 14:10:46', null, '2020-06-19 14:10:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447411', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '52', null, '2020-06-19 14:10:53', null, '2020-06-19 14:10:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447412', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '17', null, '2020-06-19 14:10:53', null, '2020-06-19 14:10:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447413', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '94', null, '2020-06-19 14:12:02', null, '2020-06-19 14:11:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447414', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '16', null, '2020-06-19 14:12:03', null, '2020-06-19 14:11:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447415', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '6734', null, '2020-06-19 14:12:13', null, '2020-06-19 14:11:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447416', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '31', null, '2020-06-19 14:12:13', null, '2020-06-19 14:11:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447417', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '13', null, '2020-06-19 14:12:30', null, '2020-06-19 14:11:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447418', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-19 14:12:33', null, '2020-06-19 14:11:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447419', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-19 14:12:33', null, '2020-06-19 14:11:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447420', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'update', '458', null, '2020-06-19 14:12:48', null, '2020-06-19 14:12:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447421', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-19 14:12:49', null, '2020-06-19 14:12:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447422', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '53', null, '2020-06-19 14:12:53', null, '2020-06-19 14:12:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447423', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 14:12:54', null, '2020-06-19 14:12:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447424', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-19 14:13:11', null, '2020-06-19 14:12:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447425', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 14:13:17', null, '2020-06-19 14:12:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447426', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '58', null, '2020-06-19 14:13:17', null, '2020-06-19 14:12:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447427', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-19 14:13:55', null, '2020-06-19 14:13:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447428', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '11', null, '2020-06-19 14:13:58', null, '2020-06-19 14:13:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447429', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-19 14:14:07', null, '2020-06-19 14:13:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447430', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-19 14:14:07', null, '2020-06-19 14:13:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447431', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-19 14:14:11', null, '2020-06-19 14:13:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447432', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '17', null, '2020-06-19 14:14:11', null, '2020-06-19 14:13:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447433', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '15', null, '2020-06-19 14:14:12', null, '2020-06-19 14:13:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447434', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 14:14:22', null, '2020-06-19 14:13:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447435', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '58', null, '2020-06-19 14:14:23', null, '2020-06-19 14:13:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447436', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '6', null, '2020-06-19 14:14:26', null, '2020-06-19 14:13:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447437', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '7', null, '2020-06-19 14:14:27', null, '2020-06-19 14:13:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447438', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '37', null, '2020-06-19 14:19:42', null, '2020-06-19 14:19:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447439', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 14:19:43', null, '2020-06-19 14:19:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447440', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '10', null, '2020-06-19 14:19:44', null, '2020-06-19 14:19:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447441', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 14:19:47', null, '2020-06-19 14:19:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447442', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 14:19:48', null, '2020-06-19 14:19:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447443', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/action', null, null, 'com.purete.coc.message.controller.MessageActionController', 'treeGrid', '39', null, '2020-06-19 14:19:48', null, '2020-06-19 14:19:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447444', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/action', null, null, 'com.purete.coc.message.controller.MessageActionController', 'save', '562', null, '2020-06-19 14:19:58', null, '2020-06-19 14:19:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447445', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/action', null, null, 'com.purete.coc.message.controller.MessageActionController', 'treeGrid', '9', null, '2020-06-19 14:19:58', null, '2020-06-19 14:19:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447446', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 14:20:03', null, '2020-06-19 14:19:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447447', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '34', null, '2020-06-19 14:22:29', null, '2020-06-19 14:21:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447448', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 14:22:31', null, '2020-06-19 14:21:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447449', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '36', null, '2020-06-19 14:22:31', null, '2020-06-19 14:21:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447450', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '28', null, '2020-06-19 14:22:34', null, '2020-06-19 14:22:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447451', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '11', null, '2020-06-19 14:22:36', null, '2020-06-19 14:22:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447452', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '2031', null, '2020-06-19 14:26:35', null, '2020-06-19 14:26:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447453', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '541', null, '2020-06-19 14:26:35', null, '2020-06-19 14:26:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447454', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2031', null, '2020-06-19 14:26:35', null, '2020-06-19 14:26:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447455', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '62', null, '2020-06-19 14:31:59', null, '2020-06-19 14:31:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447456', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '78', null, '2020-06-19 14:31:59', null, '2020-06-19 14:31:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447457', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-19 14:32:06', null, '2020-06-19 14:31:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447458', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '42', null, '2020-06-19 14:38:30', null, '2020-06-19 14:37:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447459', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '68', null, '2020-06-19 14:40:42', null, '2020-06-19 14:40:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447460', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '51', null, '2020-06-19 14:42:11', null, '2020-06-19 14:41:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447461', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '154', null, '2020-06-19 14:43:36', null, '2020-06-19 14:43:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447462', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '2115', null, '2020-06-19 14:46:38', null, '2020-06-19 14:46:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447463', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '59', null, '2020-06-19 14:49:19', null, '2020-06-19 14:48:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447464', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '18', null, '2020-06-19 14:50:10', null, '2020-06-19 14:49:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447465', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '8', null, '2020-06-19 14:50:38', null, '2020-06-19 14:50:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447466', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '7', null, '2020-06-19 14:50:40', null, '2020-06-19 14:50:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447467', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '8', null, '2020-06-19 14:50:40', null, '2020-06-19 14:50:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447468', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '7', null, '2020-06-19 14:50:41', null, '2020-06-19 14:50:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447469', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 14:50:42', null, '2020-06-19 14:50:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447470', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '7', null, '2020-06-19 14:50:43', null, '2020-06-19 14:50:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447471', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 14:50:44', null, '2020-06-19 14:50:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447472', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '7', null, '2020-06-19 14:50:45', null, '2020-06-19 14:50:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447473', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 14:50:46', null, '2020-06-19 14:50:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447474', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '7', null, '2020-06-19 14:50:47', null, '2020-06-19 14:50:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447475', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '28', null, '2020-06-19 14:53:11', null, '2020-06-19 14:52:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447476', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '231', null, '2020-06-19 14:53:21', null, '2020-06-19 14:52:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447477', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 14:53:22', null, '2020-06-19 14:52:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447478', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 14:53:30', null, '2020-06-19 14:52:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447479', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 14:53:31', null, '2020-06-19 14:52:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447480', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '4', null, '2020-06-19 14:53:33', null, '2020-06-19 14:52:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447481', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '4', null, '2020-06-19 14:53:34', null, '2020-06-19 14:52:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447482', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '4', null, '2020-06-19 14:53:34', null, '2020-06-19 14:53:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447483', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '241', null, '2020-06-19 14:54:58', null, '2020-06-19 14:54:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447484', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '28', null, '2020-06-19 14:56:43', null, '2020-06-19 14:56:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447485', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '36', null, '2020-06-19 15:01:11', null, '2020-06-19 15:00:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447486', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-19 15:01:22', null, '2020-06-19 15:00:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447487', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:01:23', null, '2020-06-19 15:00:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447488', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '14', null, '2020-06-19 15:01:57', null, '2020-06-19 15:01:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447489', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '7', null, '2020-06-19 15:01:58', null, '2020-06-19 15:01:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447490', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '35', null, '2020-06-19 15:05:23', null, '2020-06-19 15:04:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447491', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:05:24', null, '2020-06-19 15:04:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447492', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:05:33', null, '2020-06-19 15:04:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447493', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '12', null, '2020-06-19 15:06:49', null, '2020-06-19 15:06:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447494', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 15:06:57', null, '2020-06-19 15:06:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447495', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '4', null, '2020-06-19 15:06:58', null, '2020-06-19 15:06:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447496', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '2048', null, '2020-06-19 15:10:43', null, '2020-06-19 15:10:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447497', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2405', null, '2020-06-19 15:10:43', null, '2020-06-19 15:10:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447498', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'save', '6688', null, '2020-06-19 15:18:59', null, '2020-06-19 15:18:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447499', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-19 15:19:13', null, '2020-06-19 15:18:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447500', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '8', null, '2020-06-19 15:19:14', null, '2020-06-19 15:18:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447501', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '7', null, '2020-06-19 15:20:07', null, '2020-06-19 15:19:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447502', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'save', '1653', null, '2020-06-19 15:20:13', null, '2020-06-19 15:19:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447503', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '2264', null, '2020-06-19 15:22:22', null, '2020-06-19 15:21:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447504', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2264', null, '2020-06-19 15:22:22', null, '2020-06-19 15:21:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447505', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 15:22:24', null, '2020-06-19 15:21:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447506', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '80', null, '2020-06-19 15:22:25', null, '2020-06-19 15:21:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447507', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '7', null, '2020-06-19 15:22:25', null, '2020-06-19 15:21:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447508', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:22:28', null, '2020-06-19 15:21:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447509', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:22:28', null, '2020-06-19 15:21:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447510', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:22:29', null, '2020-06-19 15:21:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447511', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:22:29', null, '2020-06-19 15:21:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447512', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'save', '1964', null, '2020-06-19 15:23:14', null, '2020-06-19 15:22:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447513', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '15', null, '2020-06-19 15:23:25', null, '2020-06-19 15:22:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447514', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '8', null, '2020-06-19 15:23:26', null, '2020-06-19 15:22:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447515', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '22', null, '2020-06-19 15:23:40', null, '2020-06-19 15:23:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447516', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'save', '4438', null, '2020-06-19 15:23:40', null, '2020-06-19 15:23:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447517', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '89', null, '2020-06-19 15:23:40', null, '2020-06-19 15:23:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447518', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 15:23:56', null, '2020-06-19 15:23:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447519', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '7', null, '2020-06-19 15:23:56', null, '2020-06-19 15:23:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447520', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'save', '3095', null, '2020-06-19 15:24:08', null, '2020-06-19 15:23:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447521', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '24', null, '2020-06-19 15:25:13', null, '2020-06-19 15:24:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447522', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:25:13', null, '2020-06-19 15:24:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447523', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '18', null, '2020-06-19 15:25:25', null, '2020-06-19 15:24:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447524', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:25:25', null, '2020-06-19 15:24:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447525', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 15:25:51', null, '2020-06-19 15:25:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447526', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '7', null, '2020-06-19 15:25:51', null, '2020-06-19 15:25:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447527', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-19 15:26:12', null, '2020-06-19 15:25:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447528', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:26:13', null, '2020-06-19 15:25:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447529', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '27', null, '2020-06-19 15:36:41', null, '2020-06-19 15:36:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447530', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '7', null, '2020-06-19 15:36:42', null, '2020-06-19 15:36:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447531', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '30', null, '2020-06-19 15:39:16', null, '2020-06-19 15:38:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447532', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-19 15:39:20', null, '2020-06-19 15:38:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447533', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:39:21', null, '2020-06-19 15:38:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447534', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config/official', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'delete', '74', null, '2020-06-19 15:39:35', null, '2020-06-19 15:39:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447535', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:39:35', null, '2020-06-19 15:39:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447536', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 15:39:42', null, '2020-06-19 15:39:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447537', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '17', null, '2020-06-19 15:39:43', null, '2020-06-19 15:39:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447538', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'save', '50', null, '2020-06-19 15:39:50', null, '2020-06-19 15:39:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447539', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '1641', null, '2020-06-19 15:48:56', null, '2020-06-19 15:48:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447540', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2113', null, '2020-06-19 15:48:56', null, '2020-06-19 15:48:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447541', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'update', '148', null, '2020-06-19 15:49:12', null, '2020-06-19 15:48:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447542', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'update', '78', null, '2020-06-19 15:49:16', null, '2020-06-19 15:48:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447543', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'update', '83', null, '2020-06-19 15:49:21', null, '2020-06-19 15:48:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447544', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config/official', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'delete', '687', null, '2020-06-19 15:49:27', null, '2020-06-19 15:48:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447545', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:49:27', null, '2020-06-19 15:48:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447546', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:49:32', null, '2020-06-19 15:48:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447547', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'save', '37', null, '2020-06-19 15:49:38', null, '2020-06-19 15:49:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447548', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:49:41', null, '2020-06-19 15:49:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447549', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:49:42', null, '2020-06-19 15:49:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447550', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:49:43', null, '2020-06-19 15:49:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447551', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'save', '433', null, '2020-06-19 15:49:50', null, '2020-06-19 15:49:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447552', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:49:52', null, '2020-06-19 15:49:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447553', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:49:53', null, '2020-06-19 15:49:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447554', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:49:54', null, '2020-06-19 15:49:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447555', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'save', '35', null, '2020-06-19 15:49:59', null, '2020-06-19 15:49:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447556', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:50:01', null, '2020-06-19 15:49:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447557', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:50:02', null, '2020-06-19 15:49:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447558', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:50:03', null, '2020-06-19 15:49:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447559', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config/pay', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'delete', '47', null, '2020-06-19 15:50:07', null, '2020-06-19 15:49:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447560', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:50:07', null, '2020-06-19 15:49:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447561', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:50:07', null, '2020-06-19 15:49:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447562', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config/mini', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'delete', '36', null, '2020-06-19 15:50:11', null, '2020-06-19 15:49:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447563', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:50:11', null, '2020-06-19 15:49:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447564', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '36', null, '2020-06-19 15:50:14', null, '2020-06-19 15:49:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447565', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '6', null, '2020-06-19 15:50:17', null, '2020-06-19 15:49:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447566', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '36', null, '2020-06-19 15:50:18', null, '2020-06-19 15:49:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447567', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '29', null, '2020-06-19 15:51:34', null, '2020-06-19 15:50:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447568', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '40', null, '2020-06-19 15:51:34', null, '2020-06-19 15:50:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447569', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '28', null, '2020-06-19 15:51:34', null, '2020-06-19 15:51:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447570', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '10', null, '2020-06-19 15:52:25', null, '2020-06-19 15:51:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447571', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'treeGrid', '70', null, '2020-06-19 15:52:32', null, '2020-06-19 15:51:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447572', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '56', null, '2020-06-19 15:52:33', null, '2020-06-19 15:51:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447573', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-19 15:52:33', null, '2020-06-19 15:51:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447574', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-19 15:52:35', null, '2020-06-19 15:52:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447575', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '244', null, '2020-06-19 15:52:55', null, '2020-06-19 15:52:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447576', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-19 15:52:55', null, '2020-06-19 15:52:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447577', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:53:11', null, '2020-06-19 15:52:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447578', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '35', null, '2020-06-19 15:53:12', null, '2020-06-19 15:52:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447579', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '7', null, '2020-06-19 15:53:12', null, '2020-06-19 15:52:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447580', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '11', null, '2020-06-19 15:53:12', null, '2020-06-19 15:52:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447581', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-19 15:53:13', null, '2020-06-19 15:52:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447582', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '5', null, '2020-06-19 15:53:14', null, '2020-06-19 15:52:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447583', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '42', null, '2020-06-19 15:55:07', null, '2020-06-19 15:54:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447584', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '6', null, '2020-06-19 15:55:21', null, '2020-06-19 15:54:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447585', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '8', null, '2020-06-19 15:55:23', null, '2020-06-19 15:54:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447586', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '16', null, '2020-06-19 15:55:23', null, '2020-06-19 15:54:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447587', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 15:56:09', null, '2020-06-19 15:55:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447588', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '55', null, '2020-06-19 15:56:09', null, '2020-06-19 15:55:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447589', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-19 15:56:10', null, '2020-06-19 15:55:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447590', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '8', null, '2020-06-19 15:56:10', null, '2020-06-19 15:55:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447591', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '12', null, '2020-06-19 15:56:28', null, '2020-06-19 15:55:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447592', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '6', null, '2020-06-19 15:56:29', null, '2020-06-19 15:55:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447593', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '11', null, '2020-06-19 15:56:31', null, '2020-06-19 15:55:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447594', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '7', null, '2020-06-19 15:56:31', null, '2020-06-19 15:55:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447595', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '34', null, '2020-06-19 15:57:38', null, '2020-06-19 15:57:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447596', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '27', null, '2020-06-19 15:57:38', null, '2020-06-19 15:57:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447597', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-19 15:58:16', null, '2020-06-19 15:57:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447598', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '4', null, '2020-06-19 15:58:18', null, '2020-06-19 15:57:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447599', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '8', null, '2020-06-19 15:58:21', null, '2020-06-19 15:57:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447600', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '8', null, '2020-06-19 15:58:21', null, '2020-06-19 15:57:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447601', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '25', null, '2020-06-19 16:01:25', null, '2020-06-19 16:00:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447602', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 16:01:30', null, '2020-06-19 16:00:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447603', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-19 16:01:31', null, '2020-06-19 16:00:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447604', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '52', null, '2020-06-19 16:06:48', null, '2020-06-19 16:06:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447605', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-19 16:06:49', null, '2020-06-19 16:06:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447606', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '6', null, '2020-06-19 16:06:50', null, '2020-06-19 16:06:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447607', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '5', null, '2020-06-19 16:06:51', null, '2020-06-19 16:06:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447608', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '28', null, '2020-06-19 16:08:12', null, '2020-06-19 16:07:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447609', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '26', null, '2020-06-19 16:09:45', null, '2020-06-19 16:09:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447610', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '4', null, '2020-06-19 16:09:46', null, '2020-06-19 16:09:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447611', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '27', null, '2020-06-19 16:13:33', null, '2020-06-19 16:12:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447612', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '42', null, '2020-06-19 16:13:33', null, '2020-06-19 16:12:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447613', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '20', null, '2020-06-19 16:13:40', null, '2020-06-19 16:13:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447614', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '10', null, '2020-06-19 16:13:40', null, '2020-06-19 16:13:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447615', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '39', null, '2020-06-19 16:14:49', null, '2020-06-19 16:14:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447616', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '52', null, '2020-06-19 16:14:49', null, '2020-06-19 16:14:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447617', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '14', null, '2020-06-19 16:15:02', null, '2020-06-19 16:14:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447618', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '12', null, '2020-06-19 16:15:02', null, '2020-06-19 16:14:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447619', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '30', null, '2020-06-19 16:16:04', null, '2020-06-19 16:15:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447620', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2785', null, '2020-06-19 16:23:28', null, '2020-06-19 16:22:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447621', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-19 16:23:28', null, '2020-06-19 16:22:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447622', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '32', null, '2020-06-19 16:23:29', null, '2020-06-19 16:22:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447623', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '66', null, '2020-06-19 16:27:07', null, '2020-06-19 16:26:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447624', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '105', null, '2020-06-19 16:27:07', null, '2020-06-19 16:26:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447625', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '33', null, '2020-06-19 16:28:14', null, '2020-06-19 16:27:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447626', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '16', null, '2020-06-19 16:28:15', null, '2020-06-19 16:27:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447627', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '7', null, '2020-06-19 16:28:16', null, '2020-06-19 16:27:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447628', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '34', null, '2020-06-19 16:30:44', null, '2020-06-19 16:30:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447629', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '44', null, '2020-06-19 16:30:44', null, '2020-06-19 16:30:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447630', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2162', null, '2020-06-19 16:34:01', null, '2020-06-19 16:33:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447631', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '1715', null, '2020-06-19 16:34:01', null, '2020-06-19 16:33:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447632', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '46', null, '2020-06-19 16:34:02', null, '2020-06-19 16:33:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447633', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '87', null, '2020-06-19 16:34:02', null, '2020-06-19 16:33:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447634', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '94', null, '2020-06-19 16:34:08', null, '2020-06-19 16:33:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447635', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '36', null, '2020-06-19 16:35:30', null, '2020-06-19 16:34:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447636', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-19 16:35:31', null, '2020-06-19 16:34:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447637', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '25', null, '2020-06-19 16:35:35', null, '2020-06-19 16:35:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447638', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '32', null, '2020-06-19 16:35:35', null, '2020-06-19 16:35:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447639', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '5', null, '2020-06-19 16:35:41', null, '2020-06-19 16:35:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447640', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '38', null, '2020-06-19 16:37:10', null, '2020-06-19 16:36:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447641', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '4', null, '2020-06-19 16:37:10', null, '2020-06-19 16:36:36', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447642', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '38', null, '2020-06-19 16:38:05', null, '2020-06-19 16:37:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447643', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '49', null, '2020-06-19 16:38:05', null, '2020-06-19 16:37:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447644', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '4', null, '2020-06-19 16:38:08', null, '2020-06-19 16:37:34', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447645', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '22', null, '2020-06-19 16:43:04', null, '2020-06-19 16:42:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447646', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '59', null, '2020-06-19 16:44:49', null, '2020-06-19 16:44:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447647', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-19 16:45:33', null, '2020-06-19 16:44:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447648', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '7', null, '2020-06-19 16:45:33', null, '2020-06-19 16:44:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447649', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '13', null, '2020-06-19 16:45:44', null, '2020-06-19 16:45:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447650', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '44', null, '2020-06-19 16:45:44', null, '2020-06-19 16:45:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447651', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '4', null, '2020-06-19 16:45:46', null, '2020-06-19 16:45:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447652', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'update', '0', null, '2020-06-19 16:45:51', null, '2020-06-19 16:45:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447653', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-19 16:45:51', null, '2020-06-19 16:45:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447654', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '5', null, '2020-06-19 16:46:03', null, '2020-06-19 16:45:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447655', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '5', null, '2020-06-19 16:46:05', null, '2020-06-19 16:45:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447656', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '4', null, '2020-06-19 16:46:13', null, '2020-06-19 16:45:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447657', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '1911', null, '2020-06-19 16:47:23', null, '2020-06-19 16:46:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447658', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '9', null, '2020-06-19 16:47:25', null, '2020-06-19 16:46:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447659', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '5', null, '2020-06-19 16:47:27', null, '2020-06-19 16:46:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447660', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'update', '79', null, '2020-06-19 16:47:30', null, '2020-06-19 16:46:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447661', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '238', null, '2020-06-19 16:47:31', null, '2020-06-19 16:46:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447662', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '5', null, '2020-06-19 16:47:37', null, '2020-06-19 16:47:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447663', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '5', null, '2020-06-19 16:47:43', null, '2020-06-19 16:47:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447664', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '6', null, '2020-06-19 16:47:45', null, '2020-06-19 16:47:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447665', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '6', null, '2020-06-19 16:47:49', null, '2020-06-19 16:47:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447666', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu/1', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'delete', '33', null, '2020-06-19 16:48:07', null, '2020-06-19 16:47:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447667', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '10', null, '2020-06-19 16:48:07', null, '2020-06-19 16:47:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447668', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '4', null, '2020-06-19 16:48:11', null, '2020-06-19 16:47:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447669', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'update', '41', null, '2020-06-19 16:48:14', null, '2020-06-19 16:47:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447670', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '14', null, '2020-06-19 16:48:15', null, '2020-06-19 16:47:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447671', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '5', null, '2020-06-19 16:48:16', null, '2020-06-19 16:47:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447672', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '38', null, '2020-06-19 16:48:20', null, '2020-06-19 16:47:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447673', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-19 16:48:21', null, '2020-06-19 16:47:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447674', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '44', null, '2020-06-19 16:48:21', null, '2020-06-19 16:47:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447675', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-19 16:48:22', null, '2020-06-19 16:47:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447676', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '17', null, '2020-06-19 16:48:22', null, '2020-06-19 16:47:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447677', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '7', null, '2020-06-19 16:48:23', null, '2020-06-19 16:47:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447678', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '79', null, '2020-06-19 16:49:24', null, '2020-06-19 16:48:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447679', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '15', null, '2020-06-19 16:49:24', null, '2020-06-19 16:48:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447680', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '33', null, '2020-06-19 16:49:25', null, '2020-06-19 16:48:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447681', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-19 16:49:29', null, '2020-06-19 16:48:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447682', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '18', null, '2020-06-19 16:49:29', null, '2020-06-19 16:48:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447683', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '14', null, '2020-06-19 16:49:30', null, '2020-06-19 16:48:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447684', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '6', null, '2020-06-19 16:49:30', null, '2020-06-19 16:48:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447685', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '5', null, '2020-06-19 16:49:33', null, '2020-06-19 16:48:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447686', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/1', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-19 16:49:34', null, '2020-06-19 16:48:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447687', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '5', null, '2020-06-19 16:49:34', null, '2020-06-19 16:49:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447688', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '6', null, '2020-06-19 16:49:36', null, '2020-06-19 16:49:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447689', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-19 16:49:37', null, '2020-06-19 16:49:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447690', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-19 16:49:37', null, '2020-06-19 16:49:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447691', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '5', null, '2020-06-19 16:49:38', null, '2020-06-19 16:49:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447692', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '7', null, '2020-06-19 16:49:47', null, '2020-06-19 16:49:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447693', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '32', null, '2020-06-19 16:51:13', null, '2020-06-19 16:50:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447694', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-menu', null, null, 'com.purete.coc.sys.controller.SysRoleMenuController', 'info', '5', null, '2020-06-19 16:51:15', null, '2020-06-19 16:50:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447695', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '22', null, '2020-06-19 16:52:04', null, '2020-06-19 16:51:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447696', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/1', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '9', null, '2020-06-19 16:52:04', null, '2020-06-19 16:51:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447697', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 16:52:05', null, '2020-06-19 16:51:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447698', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '6', null, '2020-06-19 16:52:06', null, '2020-06-19 16:51:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447699', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '31', null, '2020-06-19 16:52:59', null, '2020-06-19 16:52:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447700', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '15', null, '2020-06-19 16:52:59', null, '2020-06-19 16:52:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447701', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '8', null, '2020-06-19 16:53:15', null, '2020-06-19 16:52:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447702', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '16', null, '2020-06-19 16:53:16', null, '2020-06-19 16:52:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447703', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '13', null, '2020-06-19 16:53:16', null, '2020-06-19 16:52:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447704', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '5', null, '2020-06-19 16:53:16', null, '2020-06-19 16:52:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447705', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '8', null, '2020-06-19 16:53:18', null, '2020-06-19 16:52:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447706', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-19 16:53:18', null, '2020-06-19 16:52:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447707', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '12', null, '2020-06-19 16:53:20', null, '2020-06-19 16:52:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447708', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/1', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '7', null, '2020-06-19 16:53:23', null, '2020-06-19 16:52:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447709', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '5', null, '2020-06-19 16:53:24', null, '2020-06-19 16:52:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447710', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '13', null, '2020-06-19 16:53:26', null, '2020-06-19 16:52:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447711', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '6', null, '2020-06-19 16:53:27', null, '2020-06-19 16:52:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447712', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '6', null, '2020-06-19 16:53:29', null, '2020-06-19 16:52:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447713', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '35', null, '2020-06-19 16:56:25', null, '2020-06-19 16:55:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447714', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '23', null, '2020-06-19 17:00:35', null, '2020-06-19 17:00:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447715', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 17:01:30', null, '2020-06-19 17:00:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447716', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '6', null, '2020-06-19 17:01:31', null, '2020-06-19 17:00:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447717', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-19 17:01:31', null, '2020-06-19 17:00:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447718', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-19 17:01:32', null, '2020-06-19 17:00:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447719', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '27', null, '2020-06-19 17:04:29', null, '2020-06-19 17:03:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447720', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '32', null, '2020-06-19 17:09:09', null, '2020-06-19 17:08:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447721', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '4', null, '2020-06-19 17:09:13', null, '2020-06-19 17:08:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447722', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '5', null, '2020-06-19 17:09:15', null, '2020-06-19 17:08:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447723', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '7', null, '2020-06-19 17:09:16', null, '2020-06-19 17:08:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447724', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '18', null, '2020-06-19 17:11:21', null, '2020-06-19 17:10:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447725', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '26', null, '2020-06-19 17:13:25', null, '2020-06-19 17:12:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447726', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 17:13:29', null, '2020-06-19 17:12:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447727', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '4', null, '2020-06-19 17:13:29', null, '2020-06-19 17:12:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447728', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '10', null, '2020-06-19 17:13:32', null, '2020-06-19 17:12:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447729', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '8', null, '2020-06-19 17:13:32', null, '2020-06-19 17:12:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447730', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '26', null, '2020-06-19 17:16:38', null, '2020-06-19 17:16:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447731', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-19 17:16:39', null, '2020-06-19 17:16:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447732', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '4', null, '2020-06-19 17:16:40', null, '2020-06-19 17:16:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447733', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-19 17:17:23', null, '2020-06-19 17:16:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447734', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '14', null, '2020-06-19 17:17:23', null, '2020-06-19 17:16:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447735', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '32', null, '2020-06-19 17:18:13', null, '2020-06-19 17:17:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447736', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/version-log', null, null, 'com.purete.coc.pub.controller.PubVersionLogController', 'treeGrid', '28', null, '2020-06-19 17:24:14', null, '2020-06-19 17:23:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447737', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '382', null, '2020-06-19 17:25:36', null, '2020-06-19 17:25:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447738', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 17:25:38', null, '2020-06-19 17:25:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447739', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '48', null, '2020-06-19 17:25:39', null, '2020-06-19 17:25:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447740', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '35', null, '2020-06-19 17:25:41', null, '2020-06-19 17:25:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447741', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '87', null, '2020-06-19 17:25:41', null, '2020-06-19 17:25:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447742', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '23', null, '2020-06-19 17:25:51', null, '2020-06-19 17:25:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447743', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '68', null, '2020-06-19 17:28:37', null, '2020-06-19 17:28:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447744', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 17:28:40', null, '2020-06-19 17:28:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447745', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-19 17:28:40', null, '2020-06-19 17:28:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447746', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '16', null, '2020-06-19 17:28:49', null, '2020-06-19 17:28:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447747', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '22', null, '2020-06-19 17:28:49', null, '2020-06-19 17:28:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447748', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '5', null, '2020-06-19 17:28:50', null, '2020-06-19 17:28:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447749', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '40', null, '2020-06-19 17:30:27', null, '2020-06-19 17:29:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447750', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '4', null, '2020-06-19 17:30:28', null, '2020-06-19 17:29:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447751', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '20', null, '2020-06-19 17:30:35', null, '2020-06-19 17:30:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447752', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '24', null, '2020-06-19 17:30:35', null, '2020-06-19 17:30:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447753', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '4', null, '2020-06-19 17:30:42', null, '2020-06-19 17:30:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447754', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '27', null, '2020-06-19 17:32:23', null, '2020-06-19 17:31:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447755', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 17:32:26', null, '2020-06-19 17:31:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447756', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '12', null, '2020-06-19 17:33:14', null, '2020-06-19 17:32:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447757', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '16', null, '2020-06-19 17:33:14', null, '2020-06-19 17:32:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447758', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '22', null, '2020-06-19 17:33:14', null, '2020-06-19 17:32:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447759', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 17:33:49', null, '2020-06-19 17:33:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447760', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-19 17:33:50', null, '2020-06-19 17:33:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447761', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '5', null, '2020-06-19 17:33:53', null, '2020-06-19 17:33:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447762', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '8', null, '2020-06-19 17:33:53', null, '2020-06-19 17:33:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447763', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '4', null, '2020-06-19 17:33:55', null, '2020-06-19 17:33:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447764', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'update', '10', null, '2020-06-19 17:34:02', null, '2020-06-19 17:33:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447765', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '31', null, '2020-06-19 17:36:00', null, '2020-06-19 17:35:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447766', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '54', null, '2020-06-19 17:38:03', null, '2020-06-19 17:37:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447767', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-19 17:38:04', null, '2020-06-19 17:37:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447768', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '8', null, '2020-06-19 17:38:06', null, '2020-06-19 17:37:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447769', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '17', null, '2020-06-19 17:38:06', null, '2020-06-19 17:37:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447770', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '3', null, '2020-06-19 17:38:07', null, '2020-06-19 17:37:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447771', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'update', '6', null, '2020-06-19 17:38:11', null, '2020-06-19 17:37:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447772', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '5', null, '2020-06-19 17:38:18', null, '2020-06-19 17:37:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447773', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'update', '6', null, '2020-06-19 17:38:26', null, '2020-06-19 17:37:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447774', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '4', null, '2020-06-19 17:38:39', null, '2020-06-19 17:38:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447775', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '24', null, '2020-06-19 17:39:40', null, '2020-06-19 17:39:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447776', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 17:39:45', null, '2020-06-19 17:39:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447777', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '4', null, '2020-06-19 17:39:47', null, '2020-06-19 17:39:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447778', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '34', null, '2020-06-19 17:40:44', null, '2020-06-19 17:40:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447779', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '3', null, '2020-06-19 17:40:44', null, '2020-06-19 17:40:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447780', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '37', null, '2020-06-19 17:40:51', null, '2020-06-19 17:40:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447781', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '45', null, '2020-06-19 17:40:51', null, '2020-06-19 17:40:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447782', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '18', null, '2020-06-19 17:41:08', null, '2020-06-19 17:40:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447783', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'update', '75', null, '2020-06-19 17:41:10', null, '2020-06-19 17:40:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447784', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '7', null, '2020-06-19 17:41:21', null, '2020-06-19 17:40:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447785', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '39', null, '2020-06-19 17:42:17', null, '2020-06-19 17:41:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447786', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '27', null, '2020-06-19 17:42:17', null, '2020-06-19 17:41:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447787', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '15', null, '2020-06-19 17:42:40', null, '2020-06-19 17:42:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447788', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '8', null, '2020-06-19 17:42:41', null, '2020-06-19 17:42:07', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447789', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '9', null, '2020-06-19 17:42:44', null, '2020-06-19 17:42:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447790', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '11', null, '2020-06-19 17:42:44', null, '2020-06-19 17:42:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447791', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '5', null, '2020-06-19 17:42:45', null, '2020-06-19 17:42:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447792', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '41', null, '2020-06-19 17:44:48', null, '2020-06-19 17:44:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447793', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 17:44:51', null, '2020-06-19 17:44:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447794', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '7', null, '2020-06-19 17:44:52', null, '2020-06-19 17:44:17', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447795', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '13', null, '2020-06-19 17:44:57', null, '2020-06-19 17:44:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447796', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '24', null, '2020-06-19 17:44:57', null, '2020-06-19 17:44:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447797', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '6', null, '2020-06-19 17:45:00', null, '2020-06-19 17:44:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447798', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '22', null, '2020-06-19 17:46:26', null, '2020-06-19 17:45:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447799', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '58', null, '2020-06-19 17:46:26', null, '2020-06-19 17:45:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447800', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '8', null, '2020-06-19 17:47:08', null, '2020-06-19 17:46:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447801', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '6', null, '2020-06-19 17:47:15', null, '2020-06-19 17:46:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447802', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '17', null, '2020-06-19 17:48:16', null, '2020-06-19 17:47:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447803', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '21', null, '2020-06-19 17:48:16', null, '2020-06-19 17:47:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447804', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '4', null, '2020-06-19 17:48:17', null, '2020-06-19 17:47:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447805', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'update', '78', null, '2020-06-19 17:48:19', null, '2020-06-19 17:47:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447806', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-19 17:48:28', null, '2020-06-19 17:47:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447807', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '6', null, '2020-06-19 17:48:29', null, '2020-06-19 17:47:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447808', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '6', null, '2020-06-19 17:48:34', null, '2020-06-19 17:48:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447809', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-19 17:48:34', null, '2020-06-19 17:48:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447810', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '4', null, '2020-06-19 17:48:36', null, '2020-06-19 17:48:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447811', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '20', null, '2020-06-19 17:51:00', null, '2020-06-19 17:50:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447812', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '34', null, '2020-06-19 17:51:02', null, '2020-06-19 17:50:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447813', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 17:51:04', null, '2020-06-19 17:50:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447814', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '5', null, '2020-06-19 17:51:04', null, '2020-06-19 17:50:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447815', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '7', null, '2020-06-19 17:51:06', null, '2020-06-19 17:50:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447816', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '16', null, '2020-06-19 17:51:06', null, '2020-06-19 17:50:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447817', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '5', null, '2020-06-19 17:51:31', null, '2020-06-19 17:50:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447818', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '18', null, '2020-06-19 17:53:54', null, '2020-06-19 17:53:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447819', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '27', null, '2020-06-19 17:53:54', null, '2020-06-19 17:53:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447820', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '9', null, '2020-06-19 17:53:58', null, '2020-06-19 17:53:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447821', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '9', null, '2020-06-19 17:53:58', null, '2020-06-19 17:53:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447822', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '5', null, '2020-06-19 17:54:00', null, '2020-06-19 17:53:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447823', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '5', null, '2020-06-19 17:54:04', null, '2020-06-19 17:53:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447824', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'update', '87', null, '2020-06-19 17:54:08', null, '2020-06-19 17:53:34', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447825', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '9', null, '2020-06-19 17:54:15', null, '2020-06-19 17:53:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447826', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 17:54:19', null, '2020-06-19 17:53:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447827', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/6', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '6', null, '2020-06-19 17:54:21', null, '2020-06-19 17:53:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447828', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '9', null, '2020-06-19 17:54:26', null, '2020-06-19 17:53:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447829', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '11', null, '2020-06-19 17:54:26', null, '2020-06-19 17:53:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447830', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role-user', null, null, 'com.purete.coc.sys.controller.SysRoleUserController', 'info', '4', null, '2020-06-19 17:54:27', null, '2020-06-19 17:53:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447831', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '22', null, '2020-06-19 17:55:59', null, '2020-06-19 17:55:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447832', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 17:56:01', null, '2020-06-19 17:55:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447833', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/version-log', null, null, 'com.purete.coc.pub.controller.PubVersionLogController', 'treeGrid', '1', null, '2020-06-19 17:56:54', null, '2020-06-19 17:56:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447834', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/version-log', null, null, 'com.purete.coc.pub.controller.PubVersionLogController', 'treeGrid', '0', null, '2020-06-19 17:56:54', null, '2020-06-19 17:56:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447835', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/version-log', null, null, 'com.purete.coc.pub.controller.PubVersionLogController', 'treeGrid', '1', null, '2020-06-19 18:07:06', null, '2020-06-19 18:06:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447836', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/version-log', null, null, 'com.purete.coc.pub.controller.PubVersionLogController', 'treeGrid', '0', null, '2020-06-19 18:07:06', null, '2020-06-19 18:06:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447837', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '31', null, '2020-06-19 18:10:24', null, '2020-06-19 18:09:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447838', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/version-log', null, null, 'com.purete.coc.pub.controller.PubVersionLogController', 'treeGrid', '0', null, '2020-06-19 18:10:25', null, '2020-06-19 18:09:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447839', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '23', null, '2020-06-19 18:13:00', null, '2020-06-19 18:12:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447840', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/version-log', null, null, 'com.purete.coc.pub.controller.PubVersionLogController', 'treeGrid', '0', null, '2020-06-19 18:13:00', null, '2020-06-19 18:12:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447841', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-19 18:13:04', null, '2020-06-19 18:12:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447842', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/version-log', null, null, 'com.purete.coc.pub.controller.PubVersionLogController', 'treeGrid', '0', null, '2020-06-19 18:13:04', null, '2020-06-19 18:12:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447843', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '86', null, '2020-06-19 18:14:01', null, '2020-06-19 18:13:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447844', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '53', null, '2020-06-19 18:14:02', null, '2020-06-19 18:13:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447845', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 18:14:02', null, '2020-06-19 18:13:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447846', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '17', null, '2020-06-19 18:14:46', null, '2020-06-19 18:14:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447847', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-19 18:14:48', null, '2020-06-19 18:14:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447848', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '47', null, '2020-06-19 18:18:12', null, '2020-06-19 18:17:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447849', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'delete', '1091', null, '2020-06-19 18:21:56', null, '2020-06-19 18:21:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447850', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 18:21:56', null, '2020-06-19 18:21:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447851', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'delete', '38', null, '2020-06-19 18:21:57', null, '2020-06-19 18:21:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447852', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '6', null, '2020-06-19 18:21:57', null, '2020-06-19 18:21:22', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447853', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 18:21:59', null, '2020-06-19 18:21:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447854', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'delete', '34', null, '2020-06-19 18:22:01', null, '2020-06-19 18:21:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447855', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-19 18:22:01', null, '2020-06-19 18:21:27', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447856', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'save', '845', null, '2020-06-19 18:22:21', null, '2020-06-19 18:21:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447857', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 18:22:21', null, '2020-06-19 18:21:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447858', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'save', '461', null, '2020-06-19 18:22:35', null, '2020-06-19 18:22:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447859', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '14', null, '2020-06-19 18:22:35', null, '2020-06-19 18:22:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447860', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-19 18:22:48', null, '2020-06-19 18:22:13', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447861', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 18:22:59', null, '2020-06-19 18:22:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447862', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '26', null, '2020-06-19 18:26:14', null, '2020-06-19 18:25:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447863', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '33', null, '2020-06-19 18:30:50', null, '2020-06-19 18:30:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447864', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-19 18:31:15', null, '2020-06-19 18:30:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447865', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '33', null, '2020-06-19 18:32:53', null, '2020-06-19 18:32:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447866', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '34', null, '2020-06-19 18:34:40', null, '2020-06-19 18:34:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447867', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '44', null, '2020-06-19 18:34:40', null, '2020-06-19 18:34:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447868', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '39', null, '2020-06-19 18:35:44', null, '2020-06-19 18:35:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447869', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '28', null, '2020-06-19 18:37:16', null, '2020-06-19 18:36:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447870', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/version-log', null, null, 'com.purete.coc.pub.controller.PubVersionLogController', 'treeGrid', '0', null, '2020-06-19 18:37:16', null, '2020-06-19 18:36:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447871', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 18:37:17', null, '2020-06-19 18:36:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447872', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 18:37:42', null, '2020-06-19 18:37:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447873', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '38', null, '2020-06-19 18:46:25', null, '2020-06-19 18:45:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447874', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '10', null, '2020-06-19 18:46:29', null, '2020-06-19 18:45:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447875', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '15', null, '2020-06-19 18:46:29', null, '2020-06-19 18:45:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447876', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '33', null, '2020-06-19 18:53:26', null, '2020-06-19 18:52:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447877', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 18:53:26', null, '2020-06-19 18:52:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447878', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-19 18:53:45', null, '2020-06-19 18:53:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447879', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '10', null, '2020-06-19 18:53:46', null, '2020-06-19 18:53:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447880', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 18:53:47', null, '2020-06-19 18:53:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447881', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-19 18:54:19', null, '2020-06-19 18:53:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447882', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-19 18:54:20', null, '2020-06-19 18:53:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447883', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 18:54:20', null, '2020-06-19 18:53:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447884', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '32', null, '2020-06-19 18:55:42', null, '2020-06-19 18:55:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447885', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '9', null, '2020-06-19 18:55:43', null, '2020-06-19 18:55:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447886', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 18:55:44', null, '2020-06-19 18:55:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447887', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '38', null, '2020-06-19 18:57:04', null, '2020-06-19 18:56:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447888', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-19 18:57:05', null, '2020-06-19 18:56:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447889', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '31', null, '2020-06-19 18:59:27', null, '2020-06-19 18:58:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447890', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 18:59:32', null, '2020-06-19 18:58:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447891', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '11', null, '2020-06-19 18:59:33', null, '2020-06-19 18:58:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447892', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 18:59:33', null, '2020-06-19 18:58:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447893', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '31', null, '2020-06-19 19:00:54', null, '2020-06-19 19:00:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447894', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-19 19:00:54', null, '2020-06-19 19:00:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447895', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '15', null, '2020-06-19 19:01:04', null, '2020-06-19 19:00:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447896', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '31', null, '2020-06-19 19:01:05', null, '2020-06-19 19:00:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447897', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 19:01:05', null, '2020-06-19 19:00:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447898', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '19', null, '2020-06-19 19:02:07', null, '2020-06-19 19:01:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447899', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 19:02:07', null, '2020-06-19 19:01:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447900', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '23', null, '2020-06-19 19:13:35', null, '2020-06-19 19:13:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447901', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/version-log', null, null, 'com.purete.coc.pub.controller.PubVersionLogController', 'treeGrid', '0', null, '2020-06-19 19:13:35', null, '2020-06-19 19:13:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447902', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-19 19:13:37', null, '2020-06-19 19:13:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447903', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '8', null, '2020-06-19 19:13:38', null, '2020-06-19 19:13:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447904', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '7', null, '2020-06-19 19:13:38', null, '2020-06-19 19:13:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447905', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '2203', null, '2020-06-19 19:17:13', null, '2020-06-19 19:16:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447906', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2541', null, '2020-06-19 19:17:13', null, '2020-06-19 19:16:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447907', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 19:17:13', null, '2020-06-19 19:16:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447908', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '55', null, '2020-06-19 19:19:24', null, '2020-06-19 19:18:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447909', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '10', null, '2020-06-19 19:19:25', null, '2020-06-19 19:18:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447910', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 19:19:25', null, '2020-06-19 19:18:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447911', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/biz/page', null, null, 'com.purete.coc.biz.controller.BizPageController', 'treeGrid', '132', null, '2020-06-19 19:19:25', null, '2020-06-19 19:18:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447912', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2183', null, '2020-06-19 19:22:57', null, '2020-06-19 19:22:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447913', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '2060', null, '2020-06-19 19:22:57', null, '2020-06-19 19:22:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447914', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-19 19:22:58', null, '2020-06-19 19:22:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447915', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/biz/page', null, null, 'com.purete.coc.biz.controller.BizPageController', 'treeGrid', '96', null, '2020-06-19 19:22:58', null, '2020-06-19 19:22:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447916', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '1131', null, '2020-06-19 19:26:46', null, '2020-06-19 19:26:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447917', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2045', null, '2020-06-19 19:26:46', null, '2020-06-19 19:26:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447918', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '9', null, '2020-06-19 19:26:46', null, '2020-06-19 19:26:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447919', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2689', null, '2020-06-22 09:08:58', null, '2020-06-22 09:08:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447920', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '15', null, '2020-06-22 09:08:58', null, '2020-06-22 09:08:28', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447921', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '48', null, '2020-06-22 09:12:19', null, '2020-06-22 09:11:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447922', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'treeGrid', '74', null, '2020-06-22 09:12:24', null, '2020-06-22 09:11:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447923', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/1', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '8', null, '2020-06-22 09:12:27', null, '2020-06-22 09:11:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447924', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '61', null, '2020-06-22 09:12:29', null, '2020-06-22 09:11:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447925', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '105', null, '2020-06-22 09:12:29', null, '2020-06-22 09:11:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447926', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '10', null, '2020-06-22 09:12:30', null, '2020-06-22 09:12:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447927', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '90', null, '2020-06-22 09:12:30', null, '2020-06-22 09:12:00', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447928', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/admin', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'getTenantAdmin', '8', null, '2020-06-22 09:12:31', null, '2020-06-22 09:12:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447929', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/sys/role', null, null, 'com.purete.coc.sys.controller.SysRoleController', 'treeGrid', '15', null, '2020-06-22 09:12:31', null, '2020-06-22 09:12:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447930', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '37', null, '2020-06-22 09:20:12', null, '2020-06-22 09:19:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447931', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '41', null, '2020-06-22 09:20:12', null, '2020-06-22 09:19:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447932', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '11', null, '2020-06-22 09:20:18', null, '2020-06-22 09:19:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447933', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-22 09:20:19', null, '2020-06-22 09:19:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447934', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-22 09:20:35', null, '2020-06-22 09:20:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447935', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '8', null, '2020-06-22 09:20:36', null, '2020-06-22 09:20:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447936', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-22 09:20:36', null, '2020-06-22 09:20:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447937', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '73', null, '2020-06-22 09:25:46', null, '2020-06-22 09:25:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447938', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/tenant/1', null, null, 'com.purete.coc.pub.controller.PubTenantController', 'info', '8', null, '2020-06-22 09:25:46', null, '2020-06-22 09:25:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447939', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-22 09:25:49', null, '2020-06-22 09:25:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447940', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '66', null, '2020-06-22 09:28:28', null, '2020-06-22 09:27:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447941', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '25', null, '2020-06-22 09:29:39', null, '2020-06-22 09:29:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447942', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-22 09:30:02', null, '2020-06-22 09:29:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447943', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '31', null, '2020-06-22 09:30:04', null, '2020-06-22 09:29:34', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447944', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '83', null, '2020-06-22 09:33:21', null, '2020-06-22 09:32:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447945', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-22 09:33:23', null, '2020-06-22 09:32:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447946', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '4', null, '2020-06-22 09:33:24', null, '2020-06-22 09:32:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447947', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '4', null, '2020-06-22 09:33:25', null, '2020-06-22 09:32:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447948', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '4', null, '2020-06-22 09:33:26', null, '2020-06-22 09:32:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447949', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '4', null, '2020-06-22 09:33:27', null, '2020-06-22 09:32:57', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447950', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/dict', null, null, 'com.purete.coc.message.controller.MessageDictController', 'treeGrid', '106', null, '2020-06-22 09:33:35', null, '2020-06-22 09:33:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447951', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '57', null, '2020-06-22 09:33:36', null, '2020-06-22 09:33:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447952', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-22 09:33:39', null, '2020-06-22 09:33:09', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447953', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '6', null, '2020-06-22 09:33:40', null, '2020-06-22 09:33:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447954', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '4', null, '2020-06-22 09:33:41', null, '2020-06-22 09:33:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447955', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/config', null, null, 'com.purete.coc.pub.controller.PubConfigController', 'treeGrid', '4', null, '2020-06-22 09:33:41', null, '2020-06-22 09:33:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447956', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '66', null, '2020-06-22 09:50:53', null, '2020-06-22 09:50:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447957', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2523', null, '2020-06-22 10:12:20', null, '2020-06-22 10:11:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447958', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '8583', null, '2020-06-22 10:17:15', null, '2020-06-22 10:16:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447959', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '273', null, '2020-06-22 10:17:15', null, '2020-06-22 10:16:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447960', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/dashboard', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '9495', null, '2020-06-22 10:18:34', null, '2020-06-22 10:18:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447961', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/dashboard', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '8344', null, '2020-06-22 10:19:45', null, '2020-06-22 10:19:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447962', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '1977', null, '2020-06-22 10:31:11', null, '2020-06-22 10:30:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447963', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '19', null, '2020-06-22 10:31:11', null, '2020-06-22 10:30:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447964', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '13', null, '2020-06-22 10:31:25', null, '2020-06-22 10:30:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447965', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'update', '119', null, '2020-06-22 10:35:32', null, '2020-06-22 10:35:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447966', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '22', null, '2020-06-22 10:35:33', null, '2020-06-22 10:35:03', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447967', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '79', null, '2020-06-22 10:36:32', null, '2020-06-22 10:36:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447968', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-22 10:36:32', null, '2020-06-22 10:36:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447969', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '4431', null, '2020-06-22 10:38:42', null, '2020-06-22 10:38:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447970', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '46', null, '2020-06-22 10:45:22', null, '2020-06-22 10:44:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447971', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '265', null, '2020-06-22 10:45:22', null, '2020-06-22 10:44:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447972', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '17', null, '2020-06-22 10:45:25', null, '2020-06-22 10:44:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447973', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '13', null, '2020-06-22 10:45:26', null, '2020-06-22 10:44:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447974', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-22 10:45:26', null, '2020-06-22 10:44:56', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447975', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '79', null, '2020-06-22 10:47:20', null, '2020-06-22 10:46:50', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447976', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '76', null, '2020-06-22 10:48:28', null, '2020-06-22 10:47:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447977', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '19', null, '2020-06-22 10:48:29', null, '2020-06-22 10:47:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447978', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '15', null, '2020-06-22 10:48:29', null, '2020-06-22 10:47:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447979', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '29', null, '2020-06-22 10:55:55', null, '2020-06-22 10:55:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447980', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '18', null, '2020-06-22 10:55:55', null, '2020-06-22 10:55:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447981', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '13', null, '2020-06-22 10:55:55', null, '2020-06-22 10:55:25', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447982', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '38', null, '2020-06-22 11:02:13', null, '2020-06-22 11:01:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447983', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '13', null, '2020-06-22 11:02:13', null, '2020-06-22 11:01:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447984', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '34', null, '2020-06-22 11:02:14', null, '2020-06-22 11:01:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447985', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '16', null, '2020-06-22 11:02:14', null, '2020-06-22 11:01:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447986', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-22 11:02:14', null, '2020-06-22 11:01:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447987', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '27', null, '2020-06-22 11:09:40', null, '2020-06-22 11:09:10', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447988', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-22 11:09:41', null, '2020-06-22 11:09:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447989', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-22 11:09:41', null, '2020-06-22 11:09:11', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447990', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '58', null, '2020-06-22 11:14:10', null, '2020-06-22 11:13:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447991', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '70', null, '2020-06-22 11:14:10', null, '2020-06-22 11:13:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447992', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '18', null, '2020-06-22 11:14:10', null, '2020-06-22 11:13:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447993', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '31', null, '2020-06-22 11:18:25', null, '2020-06-22 11:17:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447994', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '39', null, '2020-06-22 11:18:25', null, '2020-06-22 11:17:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447995', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-22 11:18:25', null, '2020-06-22 11:17:55', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447996', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '41', null, '2020-06-22 11:27:11', null, '2020-06-22 11:26:41', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447997', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-22 11:27:12', null, '2020-06-22 11:26:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447998', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '10', null, '2020-06-22 11:27:12', null, '2020-06-22 11:26:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084447999', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '25', null, '2020-06-22 11:33:03', null, '2020-06-22 11:32:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448000', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-22 11:33:03', null, '2020-06-22 11:32:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448001', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-22 11:33:03', null, '2020-06-22 11:32:34', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448002', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '151', null, '2020-06-22 11:37:59', null, '2020-06-22 11:37:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448003', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '42', null, '2020-06-22 11:44:10', null, '2020-06-22 11:43:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448004', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '18', null, '2020-06-22 11:44:10', null, '2020-06-22 11:43:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448005', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '66', null, '2020-06-22 13:44:56', null, '2020-06-22 13:44:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448006', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '68', null, '2020-06-22 13:44:56', null, '2020-06-22 13:44:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448007', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '35', null, '2020-06-22 13:50:41', null, '2020-06-22 13:50:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448008', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '51', null, '2020-06-22 13:50:41', null, '2020-06-22 13:50:12', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448009', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-22 13:50:44', null, '2020-06-22 13:50:15', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448010', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '15', null, '2020-06-22 13:50:47', null, '2020-06-22 13:50:18', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448011', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '7202', null, '2020-06-22 13:50:59', null, '2020-06-22 13:50:30', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448012', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-22 13:51:00', null, '2020-06-22 13:50:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448013', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '18', null, '2020-06-22 13:51:00', null, '2020-06-22 13:50:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448014', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '31', null, '2020-06-22 13:55:13', null, '2020-06-22 13:54:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448015', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '34', null, '2020-06-22 13:55:13', null, '2020-06-22 13:54:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448016', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '14', null, '2020-06-22 13:56:02', null, '2020-06-22 13:55:32', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448017', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '21', null, '2020-06-22 13:56:03', null, '2020-06-22 13:55:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448018', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-22 13:56:05', null, '2020-06-22 13:55:35', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448019', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '16', null, '2020-06-22 13:56:08', null, '2020-06-22 13:55:38', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448020', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '24', null, '2020-06-22 13:57:43', null, '2020-06-22 13:57:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448021', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '48', null, '2020-06-22 13:57:46', null, '2020-06-22 13:57:16', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448022', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '32', null, '2020-06-22 14:08:53', null, '2020-06-22 14:08:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448023', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '78', null, '2020-06-22 14:08:53', null, '2020-06-22 14:08:24', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448024', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '21', null, '2020-06-22 14:16:23', null, '2020-06-22 14:15:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448025', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '10', null, '2020-06-22 14:16:23', null, '2020-06-22 14:15:53', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448026', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-22 14:16:23', null, '2020-06-22 14:15:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448027', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '36', null, '2020-06-22 14:31:13', null, '2020-06-22 14:30:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448028', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '8', null, '2020-06-22 14:31:13', null, '2020-06-22 14:30:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448029', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-22 14:31:14', null, '2020-06-22 14:30:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448030', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-22 14:31:14', null, '2020-06-22 14:30:45', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448031', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '7', null, '2020-06-22 14:31:17', null, '2020-06-22 14:30:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448032', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2306', null, '2020-06-22 14:45:07', null, '2020-06-22 14:44:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448033', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '2331', null, '2020-06-22 14:47:12', null, '2020-06-22 14:46:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448034', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '29', null, '2020-06-22 14:47:13', null, '2020-06-22 14:46:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448035', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '2529', null, '2020-06-22 14:47:13', null, '2020-06-22 14:46:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448036', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '60', null, '2020-06-22 14:47:13', null, '2020-06-22 14:46:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448037', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '16', null, '2020-06-22 14:47:14', null, '2020-06-22 14:46:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448038', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '18', null, '2020-06-22 14:47:23', null, '2020-06-22 14:46:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448039', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '14', null, '2020-06-22 14:47:24', null, '2020-06-22 14:46:54', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448040', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '32', null, '2020-06-22 14:48:32', null, '2020-06-22 14:48:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448041', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '22', null, '2020-06-22 14:55:13', null, '2020-06-22 14:54:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448042', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '14', null, '2020-06-22 14:55:13', null, '2020-06-22 14:54:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448043', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-22 14:55:13', null, '2020-06-22 14:54:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448044', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '14', null, '2020-06-22 14:55:18', null, '2020-06-22 14:54:48', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448045', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-22 14:55:18', null, '2020-06-22 14:54:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448046', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-22 14:55:19', null, '2020-06-22 14:54:49', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448047', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/message/category', null, null, 'com.purete.coc.message.controller.MessageCategoryController', 'treeGrid', '2248', null, '2020-06-22 15:00:08', null, '2020-06-22 14:59:39', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448048', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '7917', null, '2020-06-22 16:22:49', null, '2020-06-22 16:22:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448049', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/biz/feed', null, null, 'com.purete.coc.biz.controller.BizFeedController', 'treeGrid', '2304', null, '2020-06-22 16:28:00', null, '2020-06-22 16:27:31', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448050', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/biz/feed', null, null, 'com.purete.coc.biz.controller.BizFeedController', 'treeGrid', '10', null, '2020-06-22 16:28:09', null, '2020-06-22 16:27:40', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448051', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '85', null, '2020-06-22 16:28:16', null, '2020-06-22 16:27:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448052', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '25', null, '2020-06-22 16:30:21', null, '2020-06-22 16:29:52', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448053', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '1029', null, '2020-06-22 16:30:33', null, '2020-06-22 16:30:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448054', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '27', null, '2020-06-22 16:30:33', null, '2020-06-22 16:30:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448055', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11926', null, '2020-06-22 16:30:33', null, '2020-06-22 16:30:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448056', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '11560', null, '2020-06-22 16:30:33', null, '2020-06-22 16:30:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448057', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '15', null, '2020-06-22 16:30:34', null, '2020-06-22 16:30:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448058', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '12', null, '2020-06-22 16:30:49', null, '2020-06-22 16:30:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448059', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-22 16:30:52', null, '2020-06-22 16:30:23', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448060', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/biz/feed', null, null, 'com.purete.coc.biz.controller.BizFeedController', 'save', '1357', null, '2020-06-22 16:31:11', null, '2020-06-22 16:30:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448061', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '30', null, '2020-06-22 16:34:43', null, '2020-06-22 16:34:14', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448062', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '39', null, '2020-06-22 16:37:13', null, '2020-06-22 16:36:44', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448063', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/biz/feed', null, null, 'com.purete.coc.biz.controller.BizFeedController', 'save', '9308', null, '2020-06-22 16:38:36', null, '2020-06-22 16:38:06', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448064', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '253', null, '2020-06-22 16:39:03', null, '2020-06-22 16:38:33', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448065', '127.0.0.1', '0', null, null, '操作类型', 'http://127.0.0.1:8081/api/biz/feed', null, null, 'com.purete.coc.biz.controller.BizFeedController', 'update', '24', null, '2020-06-22 16:39:31', null, '2020-06-22 16:39:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448066', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '67', null, '2020-06-22 16:42:28', null, '2020-06-22 16:41:58', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448067', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '40', null, '2020-06-22 16:46:50', null, '2020-06-22 16:46:21', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448068', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '17', null, '2020-06-22 16:46:56', null, '2020-06-22 16:46:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448069', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '5037', null, '2020-06-22 16:46:56', null, '2020-06-22 16:46:26', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448070', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/admin/login', null, null, 'com.purete.coc.pub.controller.PubAdminController', 'login', '6680', null, '2020-06-22 16:47:15', null, '2020-06-22 16:46:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448071', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '11', null, '2020-06-22 16:47:16', null, '2020-06-22 16:46:46', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448072', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dashboard/chart', null, null, 'com.purete.coc.pub.controller.PubDashboardController', 'getDashboardInfo', '17', null, '2020-06-22 16:47:16', null, '2020-06-22 16:46:47', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448073', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '37', null, '2020-06-22 16:47:29', null, '2020-06-22 16:46:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448074', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '16', null, '2020-06-22 16:47:29', null, '2020-06-22 16:46:59', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448075', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '10', null, '2020-06-22 16:47:31', null, '2020-06-22 16:47:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448076', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict', null, null, 'com.purete.coc.pub.controller.PubDictController', 'treeGrid', '110', null, '2020-06-22 16:47:31', null, '2020-06-22 16:47:02', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448077', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-22 16:47:33', null, '2020-06-22 16:47:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448078', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '13', null, '2020-06-22 16:47:33', null, '2020-06-22 16:47:04', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448079', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '17', null, '2020-06-22 16:47:34', null, '2020-06-22 16:47:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448080', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-22 16:47:35', null, '2020-06-22 16:47:05', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448081', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'update', '60', null, '2020-06-22 16:47:50', null, '2020-06-22 16:47:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448082', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '8', null, '2020-06-22 16:47:50', null, '2020-06-22 16:47:20', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448083', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'update', '41', null, '2020-06-22 16:48:37', null, '2020-06-22 16:48:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448084', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-22 16:48:37', null, '2020-06-22 16:48:08', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448085', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '42', null, '2020-06-22 16:49:07', null, '2020-06-22 16:48:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448086', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '11', null, '2020-06-22 16:49:07', null, '2020-06-22 16:48:37', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448087', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '49', null, '2020-06-22 16:49:30', null, '2020-06-22 16:49:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448088', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '9', null, '2020-06-22 16:49:30', null, '2020-06-22 16:49:01', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448089', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '75', null, '2020-06-22 16:49:59', null, '2020-06-22 16:49:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448090', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-22 16:49:59', null, '2020-06-22 16:49:29', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448091', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'save', '39', null, '2020-06-22 16:50:20', null, '2020-06-22 16:49:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448092', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/menu', null, null, 'com.purete.coc.pub.controller.PubMenuController', 'treeGrid', '12', null, '2020-06-22 16:50:20', null, '2020-06-22 16:49:51', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448093', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '47', null, '2020-06-22 16:57:12', null, '2020-06-22 16:56:42', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448094', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '14', null, '2020-06-22 16:57:12', null, '2020-06-22 16:56:43', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448095', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '17', null, '2020-06-22 16:57:48', null, '2020-06-22 16:57:19', null, '1');
INSERT INTO `sys_log` VALUES ('1273129941084448096', '192.168.31.110', '0', null, null, '操作类型', 'http://192.168.31.135:8081/api/pub/dict-item', null, null, 'com.purete.coc.pub.controller.PubDictItemController', 'treeGrid', '35', null, '2020-06-22 17:05:04', null, '2020-06-22 17:04:35', null, '1');

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `order_no` varchar(32) NOT NULL COMMENT '订单编号程序生成',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `biz_type` varchar(16) NOT NULL COMMENT '业务类型会费/活动费用',
  `amount` int(11) DEFAULT NULL COMMENT '应收金额',
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '审核状态',
  `audit_time` varchar(32) DEFAULT NULL COMMENT '审核时间',
  `audit_user` varchar(32) DEFAULT NULL COMMENT '审核人',
  `pay_status` tinyint(1) DEFAULT '0' COMMENT '支付状态',
  `pay_type` varchar(32) DEFAULT NULL COMMENT '支付方式',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `pay_amount` int(11) DEFAULT NULL COMMENT '支付金额',
  `pay_no` varchar(32) DEFAULT NULL COMMENT '支付流水号',
  `pay_result` varchar(1024) DEFAULT NULL COMMENT '返回结果json',
  `pay_voucher` varchar(64) DEFAULT NULL COMMENT '支付凭证',
  `bill_no` bigint(20) unsigned NOT NULL COMMENT '记帐单号',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`order_no`,`uid`,`biz_type`,`pay_status`,`pay_time`,`status`,`created_time`,`created_by`,`audit_status`,`audit_time`,`bill_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of sys_order
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `code` varchar(32) DEFAULT NULL COMMENT '标识',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `is_system` tinyint(1) DEFAULT NULL COMMENT '是否平台添加',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_2` (`code`,`name`,`tenant_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', 'code', '超级管理员', null, '1', '1', null, '2020-06-18 17:54:28', null, '2020-06-18 17:54:28', null, '6');
INSERT INTO `sys_role` VALUES ('2', '1', '1', '1', '1', '1', null, '2020-06-18 18:02:33', null, '2020-06-18 18:02:33', null, '6');
INSERT INTO `sys_role` VALUES ('3', '34', '34', '34', '1', '1', null, '2020-06-18 18:06:01', null, '2020-06-18 18:06:01', null, '6');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT 'role_id',
  `dept_id` bigint(20) NOT NULL COMMENT 'dept_id',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色部门表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT 'role_id',
  `menu_id` bigint(20) NOT NULL COMMENT 'menu_id',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统角色菜单表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '4');
INSERT INTO `sys_role_menu` VALUES ('1', '18');
INSERT INTO `sys_role_menu` VALUES ('1', '19');

-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user` (
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`uid`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户角色表';

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES ('6', '3');

-- ----------------------------
-- Table structure for sys_tag
-- ----------------------------
DROP TABLE IF EXISTS `sys_tag`;
CREATE TABLE `sys_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `pid` int(10) unsigned DEFAULT '0' COMMENT '父节点ID',
  `tag_target` varchar(16) DEFAULT NULL COMMENT '分类( user 会员 1投票 article资讯 活动)',
  `title` varchar(32) DEFAULT NULL COMMENT '标题',
  `color` varchar(8) DEFAULT NULL COMMENT '颜色',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_2` (`tenant_id`,`tag_target`,`title`,`pid`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标签表';

-- ----------------------------
-- Records of sys_tag
-- ----------------------------

-- ----------------------------
-- Table structure for sys_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_token`;
CREATE TABLE `sys_token` (
  `uuid` varchar(64) NOT NULL COMMENT '唯一ID(用户openID/appID)',
  `access_token` varchar(64) DEFAULT NULL COMMENT 'access_token',
  `expire_in` int(11) DEFAULT NULL COMMENT 'expire_in',
  `ticket` varchar(64) DEFAULT NULL COMMENT 'ticket',
  `refresh_token` varchar(64) DEFAULT NULL COMMENT 'refresh_token',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访问token表';

-- ----------------------------
-- Records of sys_token
-- ----------------------------

-- ----------------------------
-- Table structure for ums_account
-- ----------------------------
DROP TABLE IF EXISTS `ums_account`;
CREATE TABLE `ums_account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `account` varchar(128) DEFAULT NULL COMMENT '用户账号',
  `password` varchar(128) DEFAULT NULL COMMENT '密码',
  `type` tinyint(1) DEFAULT '0' COMMENT '账号类型(0 普通账号 1 手机 2 微信  3 邮箱)',
  `is_verify` tinyint(1) DEFAULT '0' COMMENT '是否已经验证',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(32) DEFAULT NULL COMMENT '最后登录IP',
  `login_count` int(11) DEFAULT '0' COMMENT '登录次数',
  `is_admin` tinyint(1) DEFAULT '0' COMMENT '是否后台1后台0小程序',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`uid`,`account`,`type`,`is_admin`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='会员账号表';

-- ----------------------------
-- Records of ums_account
-- ----------------------------
INSERT INTO `ums_account` VALUES ('1', '1', 'admin', '15074917947', '0', '1', null, null, '0', '1', '1', '2020-06-16 14:21:57', '0', '2020-06-16 14:21:57', '0', '1');
INSERT INTO `ums_account` VALUES ('2', '2', 'admin', '15074917948', '0', '1', null, null, '0', '1', '1', '2020-06-16 14:55:34', '0', '2020-06-16 14:55:34', '0', '2');
INSERT INTO `ums_account` VALUES ('3', '3', 'admin', '15074917968', '0', '1', null, null, '0', '1', '1', '2020-06-16 15:04:59', '0', '2020-06-16 15:04:59', '0', '3');
INSERT INTO `ums_account` VALUES ('4', '4', 'admin', '17374917968', '0', '1', null, null, '0', '1', '1', '2020-06-16 15:15:42', '0', '2020-06-16 15:15:42', '0', '4');
INSERT INTO `ums_account` VALUES ('5', '5', 'admin', '17374917965', '0', '1', null, null, '0', '1', '1', '2020-06-16 15:16:51', '0', '2020-06-16 15:16:51', '0', '5');
INSERT INTO `ums_account` VALUES ('6', '6', 'admin', '13272055845', '0', '1', null, null, '0', '1', '1', '2020-06-18 16:35:07', '0', '2020-06-18 16:35:07', '0', '6');

-- ----------------------------
-- Table structure for ums_apply
-- ----------------------------
DROP TABLE IF EXISTS `ums_apply`;
CREATE TABLE `ums_apply` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `name` varchar(64) DEFAULT NULL COMMENT '姓名',
  `company_name` varchar(128) DEFAULT NULL COMMENT '单位',
  `job` varchar(16) DEFAULT NULL COMMENT '职务',
  `user_level` tinyint(1) DEFAULT '0' COMMENT '申请级别',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '审核状态',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_result` varchar(64) DEFAULT NULL COMMENT '审核结果',
  `auditor` bigint(20) unsigned NOT NULL COMMENT '审核人',
  `custom_data` longtext COMMENT '自定义数据',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`audit_time`,`uid`,`name`,`company_name`,`apply_time`,`auditor`,`audit_status`,`status`,`created_time`,`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员申请表';

-- ----------------------------
-- Records of ums_apply
-- ----------------------------

-- ----------------------------
-- Table structure for ums_apply_custom_nouse
-- ----------------------------
DROP TABLE IF EXISTS `ums_apply_custom_nouse`;
CREATE TABLE `ums_apply_custom_nouse` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `field_name` varchar(16) DEFAULT NULL COMMENT '字段英文名称',
  `field_cname` varchar(32) DEFAULT NULL COMMENT '字段中文名称',
  `field_type` tinyint(1) DEFAULT NULL COMMENT '单行文本/多选/单选/下拉/附件',
  `field_option` varchar(256) DEFAULT NULL COMMENT '内容选项json 单选/多选/下拉',
  `is_must` tinyint(1) DEFAULT NULL COMMENT '是否必填',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='入会申请自定义表';

-- ----------------------------
-- Records of ums_apply_custom_nouse
-- ----------------------------

-- ----------------------------
-- Table structure for ums_company
-- ----------------------------
DROP TABLE IF EXISTS `ums_company`;
CREATE TABLE `ums_company` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `logo` bigint(20) NOT NULL COMMENT '公司图标',
  `name` varchar(64) DEFAULT NULL COMMENT '公司名称',
  `code` varchar(32) DEFAULT NULL COMMENT '信用代码',
  `reg_date` date DEFAULT NULL COMMENT '成立日期',
  `company_type` tinyint(1) DEFAULT NULL COMMENT '单位性质',
  `industry` tinyint(1) DEFAULT NULL COMMENT '所属行业',
  `city` int(11) DEFAULT NULL COMMENT '所在地市',
  `province` int(11) DEFAULT NULL COMMENT '所在省份',
  `country` int(11) DEFAULT NULL COMMENT '所在区县',
  `address` varchar(128) DEFAULT NULL COMMENT '公司地址',
  `website` varchar(32) DEFAULT NULL COMMENT '公司网址',
  `scope` varchar(512) DEFAULT NULL COMMENT '经营范围',
  `company_info` varchar(2048) DEFAULT NULL COMMENT '公司简介',
  `company_picture` varchar(1024) DEFAULT NULL COMMENT '公司图片(json)',
  `telephone` varchar(16) DEFAULT NULL COMMENT '公司电话',
  `conactor` varchar(32) DEFAULT NULL COMMENT '联系人',
  `job` varchar(32) DEFAULT NULL COMMENT '联系人职位',
  `mobile` varchar(16) DEFAULT NULL COMMENT '联系人手机',
  `is_public` tinyint(1) DEFAULT '1' COMMENT '是否公开',
  `is_defatul` tinyint(1) DEFAULT '1' COMMENT '是否默认',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`name`,`uid`,`code`,`status`,`created_time`,`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司信息表';

-- ----------------------------
-- Records of ums_company
-- ----------------------------

-- ----------------------------
-- Table structure for ums_company_tag
-- ----------------------------
DROP TABLE IF EXISTS `ums_company_tag`;
CREATE TABLE `ums_company_tag` (
  `company_id` bigint(20) NOT NULL COMMENT '公司ID',
  `tag_id` bigint(20) NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`company_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员公司标签表';

-- ----------------------------
-- Records of ums_company_tag
-- ----------------------------

-- ----------------------------
-- Table structure for ums_consignee
-- ----------------------------
DROP TABLE IF EXISTS `ums_consignee`;
CREATE TABLE `ums_consignee` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `province` int(11) DEFAULT NULL COMMENT '省份',
  `city` int(11) DEFAULT NULL COMMENT '城市',
  `country` int(11) DEFAULT NULL COMMENT '地区',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `postcode` varchar(6) DEFAULT NULL COMMENT '邮编',
  `consignee` varchar(50) DEFAULT NULL COMMENT '收货人',
  `telephone` varchar(30) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机',
  `email` varchar(50) DEFAULT NULL COMMENT 'Email',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_mid` (`mobile`,`email`,`uid`,`is_default`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通讯地址表';

-- ----------------------------
-- Records of ums_consignee
-- ----------------------------

-- ----------------------------
-- Table structure for ums_fee
-- ----------------------------
DROP TABLE IF EXISTS `ums_fee`;
CREATE TABLE `ums_fee` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `year` int(4) DEFAULT NULL COMMENT '年份',
  `order_no` bigint(20) NOT NULL COMMENT '订单编号',
  `user_level` bigint(20) NOT NULL COMMENT '会员级别',
  `expire_time` date DEFAULT NULL COMMENT '有效期',
  `description` varchar(32) DEFAULT NULL COMMENT '订单描述',
  `order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `amount` int(11) DEFAULT NULL COMMENT '应付金额',
  `apply_id` int(11) unsigned DEFAULT NULL COMMENT '发票申请ID',
  `bill_no` bigint(20) unsigned NOT NULL COMMENT '记账单号',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`year`,`uid`,`order_no`,`order_time`,`user_level`,`expire_time`,`apply_id`,`bill_no`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='缴纳记录表';

-- ----------------------------
-- Records of ums_fee
-- ----------------------------

-- ----------------------------
-- Table structure for ums_friend
-- ----------------------------
DROP TABLE IF EXISTS `ums_friend`;
CREATE TABLE `ums_friend` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `friend_uid` bigint(20) unsigned NOT NULL COMMENT '好友ID',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `apply_text` varchar(32) DEFAULT NULL COMMENT '申请消息',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态(-1 删除 0 申请 1 通过 2 拒绝)',
  `deny_reson` varchar(32) DEFAULT NULL COMMENT '拒绝理由',
  `remark` varchar(32) DEFAULT NULL COMMENT '好友备注',
  `allow_feed` tinyint(1) DEFAULT '1' COMMENT '允许查看个人动态',
  `allow_personal` tinyint(1) DEFAULT '1' COMMENT '允许查看个人信息',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`uid`,`apply_time`,`friend_uid`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='好友表';

-- ----------------------------
-- Records of ums_friend
-- ----------------------------

-- ----------------------------
-- Table structure for ums_friend_tag
-- ----------------------------
DROP TABLE IF EXISTS `ums_friend_tag`;
CREATE TABLE `ums_friend_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `tag_name` varchar(32) DEFAULT NULL COMMENT '标签名称',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`id`,`uid`,`tag_name`,`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='好友标签表';

-- ----------------------------
-- Records of ums_friend_tag
-- ----------------------------

-- ----------------------------
-- Table structure for ums_friend_tag_relation
-- ----------------------------
DROP TABLE IF EXISTS `ums_friend_tag_relation`;
CREATE TABLE `ums_friend_tag_relation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `tag_id` bigint(20) NOT NULL COMMENT '标签ID',
  `data_id` bigint(20) NOT NULL COMMENT '好友表id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='好友标签关联表';

-- ----------------------------
-- Records of ums_friend_tag_relation
-- ----------------------------

-- ----------------------------
-- Table structure for ums_invoice
-- ----------------------------
DROP TABLE IF EXISTS `ums_invoice`;
CREATE TABLE `ums_invoice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `title` varchar(64) DEFAULT NULL COMMENT '发票抬头',
  `invoice_type` varchar(8) DEFAULT '0' COMMENT '发票类型( 0 增票/1普票)',
  `type` varchar(32) DEFAULT '0' COMMENT '抬头类型(0 单位 1 个人)',
  `tax_num` varchar(32) DEFAULT NULL COMMENT '税号',
  `address` varchar(128) DEFAULT NULL COMMENT '单位地址',
  `mobile` varchar(32) DEFAULT NULL COMMENT '电话号码',
  `bank` varchar(32) DEFAULT NULL COMMENT '银行账号',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '默认标志',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`uid`,`title`,`invoice_type`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发票信息表';

-- ----------------------------
-- Records of ums_invoice
-- ----------------------------

-- ----------------------------
-- Table structure for ums_invoice_apply
-- ----------------------------
DROP TABLE IF EXISTS `ums_invoice_apply`;
CREATE TABLE `ums_invoice_apply` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `order_no` bigint(20) NOT NULL COMMENT '订单编号',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `apply_amount` int(11) DEFAULT NULL COMMENT '申请金额',
  `invoice_item` varchar(32) DEFAULT NULL COMMENT '开票项目',
  `invoice_id` bigint(20) NOT NULL COMMENT '开票信息ID',
  `consignee_id` bigint(20) NOT NULL COMMENT '通讯地址ID',
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '审核状态',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `auditor` int(11) DEFAULT NULL COMMENT '审核人',
  `amount` int(11) DEFAULT NULL COMMENT '发票金额',
  `images` varchar(512) DEFAULT NULL COMMENT '上传图片',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`uid`,`order_no`,`audit_status`,`apply_time`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员发票申请表';

-- ----------------------------
-- Records of ums_invoice_apply
-- ----------------------------

-- ----------------------------
-- Table structure for ums_user
-- ----------------------------
DROP TABLE IF EXISTS `ums_user`;
CREATE TABLE `ums_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `name` varchar(32) DEFAULT NULL COMMENT '真实姓名',
  `avatar` bigint(20) NOT NULL COMMENT '头像ID',
  `idcard` varchar(32) DEFAULT NULL COMMENT '身份证号',
  `gender` tinyint(1) DEFAULT '0' COMMENT '0  未知 1 男 2 女',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机号码',
  `birthday_type` tinyint(1) DEFAULT '0' COMMENT '生日类型0农历1阳历',
  `birthday` date DEFAULT NULL COMMENT '生日(年月)',
  `spell_first` varchar(32) DEFAULT NULL COMMENT '拼音首字母',
  `spell` varchar(32) DEFAULT NULL COMMENT '拼音全',
  `province` int(11) DEFAULT NULL COMMENT '省份',
  `city` int(11) DEFAULT NULL COMMENT '城市',
  `country` int(11) DEFAULT NULL COMMENT '地区',
  `user_type` tinyint(1) DEFAULT '0' COMMENT '用户类型(0 浏览会员 1工作人员 2正式会员)',
  `user_level` tinyint(1) DEFAULT NULL COMMENT '会员级别',
  `sign` varchar(32) DEFAULT NULL COMMENT '个性签名',
  `openid` varchar(128) DEFAULT NULL COMMENT '微信openID',
  `unionid` varchar(128) DEFAULT NULL COMMENT '微信unionID',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_2` (`tenant_id`,`openid`,`unionid`,`name`,`nickname`,`idcard`,`mobile`,`birthday_type`,`spell_first`,`spell`,`user_type`,`user_level`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of ums_user
-- ----------------------------
INSERT INTO `ums_user` VALUES ('1', 'jiangchao', 'jiangchao', '0', '', '0', '15074917947', '1', '2020-06-16', 'jiangchao', 'jiangchao', '0', '0', '0', '1', '0', '', '', '', '1', '2020-06-16 14:21:56', '1', '2020-06-16 14:21:56', '1', '1');
INSERT INTO `ums_user` VALUES ('2', 'heming', 'heming', '0', '', '0', '15074917948', '1', '2020-06-16', 'heming', 'heming', '0', '0', '0', '1', '0', '', '', '', '1', '2020-06-16 14:55:34', '2', '2020-06-16 14:55:34', '2', '2');
INSERT INTO `ums_user` VALUES ('3', '杨涛', '杨涛', '0', '', '0', '15074917968', '1', '2020-06-16', '杨涛', '杨涛', '0', '0', '0', '1', '0', '', '', '', '1', '2020-06-16 15:04:59', '3', '2020-06-16 15:04:59', '3', '3');
INSERT INTO `ums_user` VALUES ('4', '龚凤', '龚凤', '0', '', '0', '17374917968', '1', '2020-06-16', '龚凤', '龚凤', '0', '0', '0', '1', '0', '', '', '', '1', '2020-06-16 15:15:42', '4', '2020-06-16 15:15:42', '4', '4');
INSERT INTO `ums_user` VALUES ('5', '王修远', '王修远', '0', '', '0', '17374917965', '1', '2020-06-16', '王修远', '王修远', '0', '0', '0', '1', '0', '', '', '', '1', '2020-06-16 15:16:51', '5', '2020-06-16 15:16:51', '5', '5');
INSERT INTO `ums_user` VALUES ('6', '赫敏', '赫敏', '0', '', '0', '13272055845', '1', '2020-06-18', '赫敏', '赫敏', '0', '0', '0', '3', '0', '', '', '', '1', '2020-06-18 16:35:07', '6', '2020-06-18 16:35:07', '6', '6');

-- ----------------------------
-- Table structure for ums_user_dept
-- ----------------------------
DROP TABLE IF EXISTS `ums_user_dept`;
CREATE TABLE `ums_user_dept` (
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`dept_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员部门表';

-- ----------------------------
-- Records of ums_user_dept
-- ----------------------------

-- ----------------------------
-- Table structure for ums_user_tag
-- ----------------------------
DROP TABLE IF EXISTS `ums_user_tag`;
CREATE TABLE `ums_user_tag` (
  `uid` bigint(20) NOT NULL COMMENT '会员ID',
  `tag_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '标签ID',
  PRIMARY KEY (`tag_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员标签对应表';

-- ----------------------------
-- Records of ums_user_tag
-- ----------------------------

-- ----------------------------
-- Table structure for user_fee_config
-- ----------------------------
DROP TABLE IF EXISTS `user_fee_config`;
CREATE TABLE `user_fee_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `year` int(4) DEFAULT NULL COMMENT '年份',
  `user_level` tinyint(1) DEFAULT '0' COMMENT '会员级别',
  `amount` int(11) DEFAULT NULL COMMENT '缴费金额',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_ids` (`id`,`year`,`user_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员会费设置表';

-- ----------------------------
-- Records of user_fee_config
-- ----------------------------

-- ----------------------------
-- Table structure for wx_app
-- ----------------------------
DROP TABLE IF EXISTS `wx_app`;
CREATE TABLE `wx_app` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `app_type` varchar(16) DEFAULT NULL COMMENT '1 管理  2 会员)',
  `is_empower` varchar(32) DEFAULT NULL COMMENT '是否授权',
  `name` varchar(64) DEFAULT NULL COMMENT '名称',
  `logo` varchar(32) DEFAULT NULL COMMENT '图标',
  `app_id` varchar(64) DEFAULT NULL COMMENT 'appid',
  `verify_type_info` varchar(32) DEFAULT NULL COMMENT '认证类型-1未认证 0 认证',
  `user_name` varchar(32) DEFAULT NULL COMMENT '原始ID',
  `principal_name` varchar(32) DEFAULT NULL COMMENT '主题名称',
  `serve_domain` varchar(32) DEFAULT NULL COMMENT '服务器域名',
  `signature` varchar(32) DEFAULT NULL COMMENT '账号介绍',
  `func_info` varchar(32) DEFAULT NULL COMMENT '权限集',
  `is_service` tinyint(1) DEFAULT NULL COMMENT '是否客服按钮',
  `service_icon` bigint(20) NOT NULL COMMENT '客服图标',
  `is_phone` tinyint(1) DEFAULT NULL COMMENT '电话客服',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话号码',
  `phone_icon` bigint(20) NOT NULL COMMENT '电话图标',
  `mchid` varchar(128) DEFAULT NULL COMMENT '微信商户号ID',
  `apikey` varchar(128) DEFAULT NULL COMMENT '微信支付密钥',
  `cert_pem` longtext COMMENT '微信支付证书cert',
  `key_pem` longtext COMMENT '微信支付证书key',
  `access_token` varchar(32) DEFAULT NULL COMMENT '访问令牌(2小时)',
  `expire` int(11) DEFAULT NULL COMMENT '访问令牌过期',
  `refresh_token` varchar(32) DEFAULT NULL COMMENT '刷新令牌(每月)',
  `copyright` varchar(32) DEFAULT NULL COMMENT '版权',
  `template_id` varchar(32) DEFAULT NULL COMMENT '当前小程序版本',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`app_type`,`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='租户小程序表';

-- ----------------------------
-- Records of wx_app
-- ----------------------------

-- ----------------------------
-- Table structure for wx_app_navbar
-- ----------------------------
DROP TABLE IF EXISTS `wx_app_navbar`;
CREATE TABLE `wx_app_navbar` (
  `wxapp_id` int(11) DEFAULT NULL COMMENT '租户小程序ID',
  `title` varchar(32) DEFAULT NULL COMMENT '标题',
  `top_text_color` varchar(32) DEFAULT NULL COMMENT '顶部导航文字颜色',
  `top_backgroud_color` varchar(32) DEFAULT NULL COMMENT '顶部导航背景色',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信小程序菜单';

-- ----------------------------
-- Records of wx_app_navbar
-- ----------------------------

-- ----------------------------
-- Table structure for wx_app_reg
-- ----------------------------
DROP TABLE IF EXISTS `wx_app_reg`;
CREATE TABLE `wx_app_reg` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `wxapp_id` varchar(32) DEFAULT NULL COMMENT '租户小程序ID',
  `name` varchar(32) DEFAULT NULL COMMENT '企业名称',
  `code` varchar(32) DEFAULT NULL COMMENT '企业代码',
  `code_type` varchar(32) DEFAULT NULL COMMENT '企业代码类型（信用 2组织结构 3营业执照）',
  `legal_persona_wechat` varchar(32) DEFAULT NULL COMMENT '法人个人微信',
  `legal_persona_name` varchar(32) DEFAULT NULL COMMENT '法人姓名',
  `legal_persona_mobile` varchar(32) DEFAULT NULL COMMENT '法人电话',
  `biz_license` varchar(32) DEFAULT NULL COMMENT '营业执照',
  `id_front` varchar(32) DEFAULT NULL COMMENT '身份证正面',
  `id_backend` varchar(32) DEFAULT NULL COMMENT '身份证反面',
  `reject` varchar(32) DEFAULT NULL COMMENT '驳回原因',
  `audit_status` varchar(32) DEFAULT NULL COMMENT '状态( 待审核 验证中 已审核 已驳回)',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`wxapp_id`,`name`,`audit_status`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='租户小程序注册表';

-- ----------------------------
-- Records of wx_app_reg
-- ----------------------------

-- ----------------------------
-- Table structure for wx_template_audit
-- ----------------------------
DROP TABLE IF EXISTS `wx_template_audit`;
CREATE TABLE `wx_template_audit` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `wxapp_id` bigint(20) NOT NULL COMMENT '租户小程序ID',
  `publish_id` bigint(20) NOT NULL COMMENT '发布ID',
  `release_status` tinyint(1) DEFAULT NULL COMMENT '发布状态0 新版本1 待发布 2 已发布',
  `audit_id` varchar(64) DEFAULT NULL COMMENT '审核编号',
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '审核状态',
  `reason` varchar(512) DEFAULT NULL COMMENT '拒绝原因',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`wxapp_id`,`publish_id`,`release_status`,`audit_id`,`audit_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='小程序提交审核表';

-- ----------------------------
-- Records of wx_template_audit
-- ----------------------------

-- ----------------------------
-- Table structure for wx_template_message
-- ----------------------------
DROP TABLE IF EXISTS `wx_template_message`;
CREATE TABLE `wx_template_message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `template_id` varchar(32) DEFAULT NULL COMMENT '模板ID',
  `title` varchar(64) DEFAULT NULL COMMENT '模板标题',
  `primary_industry` varchar(64) DEFAULT NULL COMMENT '一级行业',
  `deputy_industry` varchar(64) DEFAULT NULL COMMENT '二级行业',
  `content` varchar(32) DEFAULT NULL COMMENT '模板内容',
  `example` varchar(32) DEFAULT NULL COMMENT '模板示列',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='wx-微信模板消息配置表（暂时不用）';

-- ----------------------------
-- Records of wx_template_message
-- ----------------------------

-- ----------------------------
-- Table structure for wx_template_publish
-- ----------------------------
DROP TABLE IF EXISTS `wx_template_publish`;
CREATE TABLE `wx_template_publish` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `app_type` varchar(16) DEFAULT NULL COMMENT '应用类型',
  `template_id` varchar(32) DEFAULT NULL COMMENT '服务端模板ID',
  `user_version` varchar(32) DEFAULT NULL COMMENT '版本号',
  `user_desc` varchar(32) DEFAULT NULL COMMENT '版本描述',
  `developer` varchar(32) DEFAULT NULL COMMENT '开发者',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` bigint(20) DEFAULT NULL COMMENT '更新人',
  `deleted_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`app_type`,`template_id`,`status`,`created_by`,`updated_time`,`updated_by`,`deleted_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='小程序模板发布表';

-- ----------------------------
-- Records of wx_template_publish
-- ----------------------------

-- ----------------------------
-- Table structure for wx_wechat_menu
-- ----------------------------
DROP TABLE IF EXISTS `wx_wechat_menu`;
CREATE TABLE `wx_wechat_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `pid` int(10) unsigned DEFAULT '0' COMMENT '父节点ID',
  `name` varchar(32) DEFAULT NULL COMMENT '菜单名称',
  `menu_key` varchar(32) DEFAULT NULL COMMENT '菜单key',
  `menu_type` tinyint(1) DEFAULT NULL COMMENT '菜单类型1url2图文3功能',
  `url` varchar(255) DEFAULT NULL COMMENT '网页链接',
  `msg_type` varchar(16) DEFAULT NULL COMMENT '消息类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `media_id` bigint(20) NOT NULL COMMENT '素材ID',
  `app_id` varchar(64) DEFAULT NULL COMMENT '小程序appid',
  `app_path` varchar(255) DEFAULT NULL COMMENT '小程序路径',
  `regdate` int(11) unsigned DEFAULT NULL COMMENT '登记日期',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '数据状态',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `Index_1` (`tenant_id`,`menu_type`,`msg_type`,`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信公众号菜单表';

-- ----------------------------
-- Records of wx_wechat_menu
-- ----------------------------
