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

 Date: 23/05/2022 12:33:41
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
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cusorders
-- ----------------------------
INSERT INTO `cusorders` VALUES ('6d8b8890-cdd2-11ec-a613-fb70f3715e77', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 10, 1, 3.00, 0000000063, '李浩', 10086, '12号宿舍4楼', '[{\"num\": 1, \"name\": \"米饭\"}, {\"num\": 1, \"name\": \"馒头\"}]');
INSERT INTO `cusorders` VALUES ('414c5d80-cdd3-11ec-a613-fb70f3715e77', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 5, 1, 2.00, 0000000064, '李浩', 10086, '12号宿舍4楼', '[{\"num\": 1, \"name\": \"米饭\"}]');

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
  `GIMG` json NULL,
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
INSERT INTO `goods` VALUES ('563c455a-ce76-495f-a1a4-cc700dd1d2e1', '4', '橘子', 2.00, 1, '每天', '{\"img\": \"yDznI69J1QzTcaa493d44387eb80dd2ff8af72d4dfec.jpg\", \"imgList\": [\"U4cPGfq0tBhQ55806c35bafa63c7485a6b6166d25b38.webp\", \"op2tfM9ECEPz55806c35bafa63c7485a6b6166d25b38.webp\", \"s8gADR1onZZx1d320870e88f80d427c8c8b3cc96f2f4.jpg\", \"83FNEtn9HIse1d320870e88f80d427c8c8b3cc96f2f4.jpg\", \"05u4mLmPMeq360ac2ac9a41e5d30ca3ca7f0b093a386.webp\", \"VWREMtD09fxYae913418eaff34107926648065f03e88.webp\", \"Yt0Izro2ryPF9bc60e557e17a0aa6f81b22511c24b41.webp\"]}', 5, 0, '新鲜');
INSERT INTO `goods` VALUES ('87614372-7f9b-4b94-9cab-c7be196a69ce', '2', '否跳墙', 99.00, 1, '每天', '{\"img\": \"JOnZRRLlrf1U60ac2ac9a41e5d30ca3ca7f0b093a386.webp\", \"imgList\": [\"U4cPGfq0tBhQ55806c35bafa63c7485a6b6166d25b38.webp\", \"op2tfM9ECEPz55806c35bafa63c7485a6b6166d25b38.webp\", \"s8gADR1onZZx1d320870e88f80d427c8c8b3cc96f2f4.jpg\", \"83FNEtn9HIse1d320870e88f80d427c8c8b3cc96f2f4.jpg\", \"05u4mLmPMeq360ac2ac9a41e5d30ca3ca7f0b093a386.webp\"]}', 5, 0, '否跳墙+米饭');
INSERT INTO `goods` VALUES ('88b026c3-2f8d-4a5b-91f5-a8f9e5e1f736', '1', '米饭', 2.00, 1, '每天', '{\"img\": \"TpTZIVQHZFsU1d320870e88f80d427c8c8b3cc96f2f4.jpg\", \"imgList\": [\"U4cPGfq0tBhQ55806c35bafa63c7485a6b6166d25b38.webp\", \"op2tfM9ECEPz55806c35bafa63c7485a6b6166d25b38.webp\", \"s8gADR1onZZx1d320870e88f80d427c8c8b3cc96f2f4.jpg\"]}', 5, 0, '东北大米');
INSERT INTO `goods` VALUES ('d69fe6ff-47cc-4eaf-b704-ed72f054e745', '2', '宫保鸡丁', 15.00, 1, '每天', '{\"img\": \"W0ttRXzeW9Zz8b22d7df4234419a3f54c4b695bc6d32.webp\", \"imgList\": []}', 5, 0, '好吃');
INSERT INTO `goods` VALUES ('da7511ee-dff6-4cb7-92cc-2e54ee794be5', '1', '馒头', 1.00, 1, '每天', '{\"img\": \"F4GlCp24HHbi55806c35bafa63c7485a6b6166d25b38.webp\", \"imgList\": [\"U4cPGfq0tBhQ55806c35bafa63c7485a6b6166d25b38.webp\", \"op2tfM9ECEPz55806c35bafa63c7485a6b6166d25b38.webp\"]}', 5, 0, '小麦馒头');

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
INSERT INTO `orderdetail` VALUES ('d69fe6ff-47cc-4eaf-b704-ed72f054e745', 'c5290a50-c148-11ec-a34a-21dcfaf08063', '222', 2.00, '222', 5);
INSERT INTO `orderdetail` VALUES ('87614372-7f9b-4b94-9cab-c7be196a69ce', 'a6487180-c151-11ec-a34a-21dcfaf08063', '否跳墙', 1.00, '99', 5);
INSERT INTO `orderdetail` VALUES ('da7511ee-dff6-4cb7-92cc-2e54ee794be5', '936a9b40-cc75-11ec-b7b6-616bc4baed77', '馒头', 1.00, '1', 5);
INSERT INTO `orderdetail` VALUES ('da7511ee-dff6-4cb7-92cc-2e54ee794be5', 'ad44f420-cc75-11ec-b7b6-616bc4baed77', '馒头', 1.00, '1', 5);
INSERT INTO `orderdetail` VALUES ('d69fe6ff-47cc-4eaf-b704-ed72f054e745', 'ad44f420-cc75-11ec-b7b6-616bc4baed77', '宫保鸡丁', 1.00, '15', 5);
INSERT INTO `orderdetail` VALUES ('563c455a-ce76-495f-a1a4-cc700dd1d2e1', 'ad44f420-cc75-11ec-b7b6-616bc4baed77', '橘子', 1.00, '2', 5);
INSERT INTO `orderdetail` VALUES ('88b026c3-2f8d-4a5b-91f5-a8f9e5e1f736', '6d8b8890-cdd2-11ec-a613-fb70f3715e77', '米饭', 1.00, '2', 5);
INSERT INTO `orderdetail` VALUES ('da7511ee-dff6-4cb7-92cc-2e54ee794be5', '6d8b8890-cdd2-11ec-a613-fb70f3715e77', '馒头', 1.00, '1', 5);
INSERT INTO `orderdetail` VALUES ('88b026c3-2f8d-4a5b-91f5-a8f9e5e1f736', '414c5d80-cdd3-11ec-a613-fb70f3715e77', '米饭', 1.00, '2', 5);

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
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

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
INSERT INTO `overorder` VALUES ('7875c450-c085-11ec-b0b8-23fe8e5a4fea', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 5, 3, 3.00, 0000000050);
INSERT INTO `overorder` VALUES ('c5290a50-c148-11ec-a34a-21dcfaf08063', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 10, 3, 444.00, 0000000051);
INSERT INTO `overorder` VALUES ('936a9b40-cc75-11ec-b7b6-616bc4baed77', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 5, 3, 1.00, 0000000052);
INSERT INTO `overorder` VALUES ('ad44f420-cc75-11ec-b7b6-616bc4baed77', 'a5c9535e-c704-449b-b52e-3ac55e774c15', 15, 3, 18.00, 0000000053);

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
INSERT INTO `savemessage` VALUES ('a5c9535e-c704-449b-b52e-3ac55e774c15', '李浩', 10086, '12号宿舍4楼');
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
INSERT INTO `syscus` VALUES ('123', '123', 'false', 456);
INSERT INTO `syscus` VALUES ('a5c9535e-c704-449b-b52e-3ac55e774c15', '李浩', 'true', 123);

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
