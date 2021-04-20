# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.34)
# Database: user
# Generation Time: 2021-04-20 03:12:27 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table account
# ------------------------------------------------------------

CREATE TABLE `account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '账号ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `open_code` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '登录账号,如手机号等',
  `category` tinyint(1) NOT NULL DEFAULT '0' COMMENT '账号类别 不同类型账号如：微信、QQ等',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `edited` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `editor` bigint(20) NOT NULL DEFAULT '0' COMMENT '修改人',
  `deleted` double(1,0) unsigned zerofill DEFAULT '0' COMMENT '逻辑删除:0=未删除,1=已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_member_id` (`user_id`) USING BTREE COMMENT '普通索引',
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='账号';



# Dump of table permission
# ------------------------------------------------------------

CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `parent_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '所属父级权限ID',
  `code` varchar(255) NOT NULL DEFAULT '' COMMENT '权限唯一CODE代码',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '权限名称',
  `intro` varchar(255) NOT NULL DEFAULT '' COMMENT '权限介绍',
  `category` tinyint(1) NOT NULL COMMENT '权限类别',
  `uri` bigint(20) NOT NULL COMMENT 'URL规则',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` bigint(20) NOT NULL COMMENT '创建人',
  `edited` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `editor` bigint(20) NOT NULL COMMENT '修改人',
  `deleted` tinyint(1) unsigned zerofill DEFAULT '0' COMMENT '逻辑删除:0=未删除,1=已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE COMMENT '父级权限ID',
  KEY `code` (`code`) USING BTREE COMMENT '权限CODE代码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限';



# Dump of table role
# ------------------------------------------------------------

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `parent_id` bigint(20) NOT NULL COMMENT '所属父级角色ID',
  `code` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '角色唯一CODE代码',
  `name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '角色名称',
  `intro` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '角色介绍',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `edited` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `editor` bigint(20) NOT NULL DEFAULT '0' COMMENT '修改人',
  `deleted` tinyint(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT '逻辑删除:0=未删除,1=已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE COMMENT '父级权限ID',
  KEY `code` (`code`) USING BTREE COMMENT '权限CODE代码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='角色';



# Dump of table role_permission
# ------------------------------------------------------------

CREATE TABLE `role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `permission_id` bigint(20) NOT NULL COMMENT '权限ID',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `edited` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `editor` bigint(20) NOT NULL DEFAULT '0' COMMENT '修改人',
  `deleted` tinyint(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT '逻辑删除:0=未删除,1=已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `role_id` (`role_id`) USING BTREE COMMENT '角色ID',
  KEY `permission_id` (`permission_id`) USING BTREE COMMENT '权限ID',
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色权限';



# Dump of table user
# ------------------------------------------------------------

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态:0=正常,1=禁用',
  `name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '用户登陆名',
  `nickname` varchar(64) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `avatar` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '头像图片地址',
  `mobile` varchar(11) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '手机号码',
  `salt` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '密码加盐',
  `password` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '登录密码',
  `email` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `edited` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `editor` bigint(20) NOT NULL DEFAULT '0' COMMENT '修改人',
  `deleted` tinyint(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT '逻辑删除:0=未删除,1=已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户';



# Dump of table user_group
# ------------------------------------------------------------

CREATE TABLE `user_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `parent_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '所属父级用户组ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '用户组名称',
  `code` varchar(255) NOT NULL DEFAULT '' COMMENT '用户组CODE唯一代码',
  `intro` varchar(255) NOT NULL DEFAULT '' COMMENT '用户组介绍',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `edited` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `editor` bigint(20) NOT NULL DEFAULT '0' COMMENT '修改人',
  `deleted` tinyint(1) unsigned zerofill DEFAULT '0' COMMENT '逻辑删除:0=未删除,1=已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE COMMENT '父级用户组ID',
  KEY `code` (`code`) USING BTREE COMMENT '用户组CODE代码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户组';



# Dump of table user_group_role
# ------------------------------------------------------------

CREATE TABLE `user_group_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_group_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户组ID',
  `role_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `edited` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `editor` bigint(20) NOT NULL DEFAULT '0' COMMENT '修改人',
  `deleted` tinyint(1) unsigned zerofill DEFAULT '0' COMMENT '逻辑删除:0=未删除,1=已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `member_group_id` (`user_group_id`) USING BTREE COMMENT '用户组ID',
  KEY `role_id` (`role_id`) USING BTREE COMMENT '角色ID',
  CONSTRAINT `user_group_role_ibfk_1` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`),
  CONSTRAINT `user_group_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户组角色';



# Dump of table user_group_user
# ------------------------------------------------------------

CREATE TABLE `user_group_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID说',
  `user_group_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户组ID',
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `edited` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `editor` bigint(20) NOT NULL DEFAULT '0' COMMENT '修改人',
  `deleted` tinyint(1) unsigned zerofill DEFAULT '0' COMMENT '逻辑删除:0=未删除,1=已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `member_group_id` (`user_group_id`) USING BTREE COMMENT '用户组ID',
  KEY `member_id` (`user_id`) USING BTREE COMMENT '用户ID',
  CONSTRAINT `user_group_user_ibfk_1` FOREIGN KEY (`user_group_id`) REFERENCES `user_group` (`id`),
  CONSTRAINT `user_group_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户组成员';



# Dump of table user_role
# ------------------------------------------------------------

CREATE TABLE `user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `edited` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `editor` bigint(20) NOT NULL DEFAULT '0' COMMENT '修改人',
  `deleted` tinyint(1) unsigned zerofill DEFAULT '0' COMMENT '逻辑删除:0=未删除,1=已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `member_id` (`user_id`) USING BTREE COMMENT '用户ID',
  KEY `role_id` (`role_id`) USING BTREE COMMENT '角色ID',
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户角色';




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
