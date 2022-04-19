/*
 Navicat Premium Data Transfer

 Source Server         : li
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : localhost:3306
 Source Schema         : mhzqx

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 20/04/2022 02:55:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cusorders
-- ----------------------------
DROP TABLE IF EXISTS `cusorders`;
CREATE TABLE `cusorders`  (
  `ORDERID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `CUSID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ORDERTIME` int(0) NULL DEFAULT NULL,
  `ORDERSTATE` int(0) NULL DEFAULT NULL COMMENT '0--临时\r\n            1--下单\r\n            2--正在处理\r\n            3--处理完成',
  `ORDERTOTLEPRICE` decimal(10, 2) NULL DEFAULT NULL,
  `ORDERNUM` int(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `IPHONE` int(0) NULL DEFAULT NULL,
  `BINDID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `FOODJSON` json NULL,
  PRIMARY KEY (`ORDERNUM`) USING BTREE,
  INDEX `FK_Relationship_5`(`CUSID`) USING BTREE,
  CONSTRAINT `FK_Relationship_5` FOREIGN KEY (`CUSID`) REFERENCES `customer` (`CUSID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `CUSID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `OPENID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `NICKNAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`CUSID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '顾客记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('a5c9535e-c704-449b-b52e-3ac55e774c15', 'oprUZ4yKpBw0dFBJWCi-iwPa_mos', '长江小浩ꪜiρ');
INSERT INTO `customer` VALUES ('fe316059-d2f4-44a9-9c71-099c394ba5c3', 'oprUZ44aqNqTGtdF8eO_zV0hb36I', '昼');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `GID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `GTID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `GNAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `GPRICE` decimal(10, 2) NULL DEFAULT NULL,
  `GSTATE` int(0) NULL DEFAULT NULL,
  `GCONTENT` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `GIMG` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `GTIME` int(0) NULL DEFAULT NULL COMMENT '需要时间（单位：分钟）',
  `GCOUNT` int(0) NULL DEFAULT 0,
  `GINFO` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`GID`) USING BTREE,
  INDEX `FK_Relationship_4`(`GTID`) USING BTREE,
  CONSTRAINT `FK_Relationship_4` FOREIGN KEY (`GTID`) REFERENCES `goodstype` (`GTID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('3080b781-c754-489c-884f-3552965a3b77', '2', '鱼香肉丝', 12.00, 1, '周一到周五', 'ncdfRG5LU2Ib6d26bcfed657a3d1f69fd98bd5cde4c7.jpg', 5, 0, '好吃的很呢');
INSERT INTO `goods` VALUES ('8abc9d44-92d9-49d8-8628-08bba23f3d63', '4', '苹果', 1.00, 1, '周一到周五', 'zZs9k7bX2hCWc471e6941eec07af9f50270c0c1c937a.jpg', 5, 0, '新鲜');
INSERT INTO `goods` VALUES ('d0815e8a-ae8d-4bf7-aaeb-08cfac117e61', '1', '米饭', 3.00, 1, '周一到周五', '9JV2O4vRoedw1d320870e88f80d427c8c8b3cc96f2f4.jpg', 5, 0, '白白大米饭，好吃不贵，经济实惠。');

-- ----------------------------
-- Table structure for goodstype
-- ----------------------------
DROP TABLE IF EXISTS `goodstype`;
CREATE TABLE `goodstype`  (
  `GTID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `GTNAME` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `GTSTATE` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`GTID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goodstype
-- ----------------------------
INSERT INTO `goodstype` VALUES ('1', '主食', 1);
INSERT INTO `goodstype` VALUES ('2', '炒菜', 1);
INSERT INTO `goodstype` VALUES ('3', '饮品', 1);
INSERT INTO `goodstype` VALUES ('4', '水果', 1);
INSERT INTO `goodstype` VALUES ('5', '甜点', 1);

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail`  (
  `GID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ORDERID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `GNAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `GCOUNT` decimal(10, 2) NULL DEFAULT NULL,
  `GPRICE` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `GTIME` int(0) NULL DEFAULT NULL,
  INDEX `FK_Relationship_6`(`ORDERID`) USING BTREE,
  INDEX `FK_Relationship_7`(`GID`) USING BTREE,
  CONSTRAINT `FK_Relationship_7` FOREIGN KEY (`GID`) REFERENCES `goods` (`GID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES ('8abc9d44-92d9-49d8-8628-08bba23f3d63', 'fbab13c0-bda1-11ec-805a-233fc87adf2d', '苹果', 2.00, '1', 5);
INSERT INTO `orderdetail` VALUES ('8abc9d44-92d9-49d8-8628-08bba23f3d63', '2f19c660-bda3-11ec-a6e3-b1881811c844', '苹果', 2.00, '1', 5);
INSERT INTO `orderdetail` VALUES ('8abc9d44-92d9-49d8-8628-08bba23f3d63', '817d6380-bda3-11ec-a4cb-2d7d3e3c4f93', '苹果', 2.00, '1', 5);
INSERT INTO `orderdetail` VALUES ('8abc9d44-92d9-49d8-8628-08bba23f3d63', 'bfee6d10-bda5-11ec-870b-cf08426719c5', '苹果', 2.00, '1', 5);
INSERT INTO `orderdetail` VALUES ('8abc9d44-92d9-49d8-8628-08bba23f3d63', 'e303ca60-bda6-11ec-bba2-aff00e1e3363', '苹果', 2.00, '1', 5);
INSERT INTO `orderdetail` VALUES ('8abc9d44-92d9-49d8-8628-08bba23f3d63', 'e45c2e70-bda6-11ec-bba2-aff00e1e3363', '苹果', 2.00, '1', 5);
INSERT INTO `orderdetail` VALUES ('8abc9d44-92d9-49d8-8628-08bba23f3d63', 'e5a8aba0-bda6-11ec-bba2-aff00e1e3363', '苹果', 2.00, '1', 5);

-- ----------------------------
-- Table structure for overorder
-- ----------------------------
DROP TABLE IF EXISTS `overorder`;
CREATE TABLE `overorder`  (
  `ORDERID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `CUSID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ORDERTIME` int(0) NULL DEFAULT NULL,
  `ORDERSTATE` int(0) NULL DEFAULT 3 COMMENT '0--临时\\\\\\\\r\\\\\\\\n            1--下单\\\\\\\\r\\\\\\\\n            2--正在处理\\\\\\\\r\\\\\\\\n            3--处理完成',
  `ORDERTOTLEPRICE` decimal(10, 2) NULL DEFAULT NULL,
  `ORDERNUM` int(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ORDERNUM`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of overorder
-- ----------------------------
INSERT INTO `overorder` VALUES ('29e0fb30-bda0-11ec-93ee-3ff4655aebd2', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 15, 3, 9.00, 0000000038);
INSERT INTO `overorder` VALUES ('308f7dd0-bda0-11ec-93ee-3ff4655aebd2', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 20, 3, 4.00, 0000000039);
INSERT INTO `overorder` VALUES ('fbab13c0-bda1-11ec-805a-233fc87adf2d', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 10, 3, 2.00, 0000000040);
INSERT INTO `overorder` VALUES ('2f19c660-bda3-11ec-a6e3-b1881811c844', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 10, 3, 2.00, 0000000041);
INSERT INTO `overorder` VALUES ('817d6380-bda3-11ec-a4cb-2d7d3e3c4f93', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 10, 3, 2.00, 0000000042);
INSERT INTO `overorder` VALUES ('29e0fb30-bda0-11ec-93ee-3ff4655aebd2', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 15, 3, 9.00, 0000000043);
INSERT INTO `overorder` VALUES ('308f7dd0-bda0-11ec-93ee-3ff4655aebd2', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 20, 3, 4.00, 0000000044);
INSERT INTO `overorder` VALUES ('29e0fb30-bda0-11ec-93ee-3ff4655aebd2', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 15, 3, 9.00, 0000000045);
INSERT INTO `overorder` VALUES ('308f7dd0-bda0-11ec-93ee-3ff4655aebd2', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 20, 3, 4.00, 0000000046);
INSERT INTO `overorder` VALUES ('e303ca60-bda6-11ec-bba2-aff00e1e3363', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 10, 3, 2.00, 0000000047);
INSERT INTO `overorder` VALUES ('e45c2e70-bda6-11ec-bba2-aff00e1e3363', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 10, 3, 2.00, 0000000048);
INSERT INTO `overorder` VALUES ('e5a8aba0-bda6-11ec-bba2-aff00e1e3363', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 10, 3, 2.00, 0000000049);

-- ----------------------------
-- Table structure for roleright
-- ----------------------------
DROP TABLE IF EXISTS `roleright`;
CREATE TABLE `roleright`  (
  `RRID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ROLEID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `FUNID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`RRID`) USING BTREE,
  INDEX `FK_Relationship_1`(`ROLEID`) USING BTREE,
  INDEX `FK_Relationship_2`(`FUNID`) USING BTREE,
  CONSTRAINT `FK_Relationship_1` FOREIGN KEY (`ROLEID`) REFERENCES `sysrole` (`ROLEID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_2` FOREIGN KEY (`FUNID`) REFERENCES `sysfunction` (`FUNID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for savemessage
-- ----------------------------
DROP TABLE IF EXISTS `savemessage`;
CREATE TABLE `savemessage`  (
  `CUSID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `IPHONE` int(0) NULL DEFAULT NULL,
  `BINDID` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`CUSID`) USING BTREE,
  INDEX `FK_Relationship_5`(`CUSID`) USING BTREE,
  CONSTRAINT `FK_Relationship_6` FOREIGN KEY (`CUSID`) REFERENCES `customer` (`CUSID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of savemessage
-- ----------------------------
INSERT INTO `savemessage` VALUES ('a5c9535e-c704-449b-b52e-3ac55e774c15', '嗯嗯嗯', 213123888, '321344');
INSERT INTO `savemessage` VALUES ('fe316059-d2f4-44a9-9c71-099c394ba5c3', '小浩', 2231388, '111000');

-- ----------------------------
-- Table structure for syscus
-- ----------------------------
DROP TABLE IF EXISTS `syscus`;
CREATE TABLE `syscus`  (
  `CUSID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `NICKNAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `LIMITS` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `PASSWORD` int(0) NOT NULL,
  PRIMARY KEY (`CUSID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '管理员设置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of syscus
-- ----------------------------
INSERT INTO `syscus` VALUES ('123', '123', 'false', 123);
INSERT INTO `syscus` VALUES ('a5c9535e-c704-449b-b52e-3ac55e774c15', '李浩', 'true', 123);
INSERT INTO `syscus` VALUES ('qeqweqdsadsaoww', '21', 'false', 123);

-- ----------------------------
-- Table structure for sysfunction
-- ----------------------------
DROP TABLE IF EXISTS `sysfunction`;
CREATE TABLE `sysfunction`  (
  `FUNID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `FUNNAME` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `FUNPID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `FUNURL` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `FUNSTATE` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`FUNID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sysrole
-- ----------------------------
DROP TABLE IF EXISTS `sysrole`;
CREATE TABLE `sysrole`  (
  `ROLEID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ROLENAME` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ROLESTATE` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`ROLEID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sysuser
-- ----------------------------
DROP TABLE IF EXISTS `sysuser`;
CREATE TABLE `sysuser`  (
  `USERID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ROLEID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `USERNAME` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `USERPWD` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `USERSEX` char(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `USERTRUENAME` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `USERSTATE` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`USERID`) USING BTREE,
  INDEX `FK_Relationship_3`(`ROLEID`) USING BTREE,
  CONSTRAINT `FK_Relationship_3` FOREIGN KEY (`ROLEID`) REFERENCES `sysrole` (`ROLEID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
