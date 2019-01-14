/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : ecrmdb

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2018-01-06 01:08:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activity_bet_record
-- ----------------------------
DROP TABLE IF EXISTS `activity_bet_record`;
CREATE TABLE `activity_bet_record` (
  `betrecordcode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `employeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '用户编码',
  `ecactivitycode` int(11) DEFAULT NULL COMMENT '定制活动编码',
  `mustbet` decimal(16,2) DEFAULT NULL COMMENT '需完成打码',
  `alreadybet` decimal(16,2) DEFAULT '0.00' COMMENT '已完成打码',
  `betrecordstatus` char(2) COLLATE utf8_bin DEFAULT NULL COMMENT '是否完成 0未完成 1已完成',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `finishtime` datetime DEFAULT NULL COMMENT '完成时间',
  `loginaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT '用户账号',
  `recharge` decimal(16,2) DEFAULT '0.00' COMMENT '充值金额',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL,
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL,
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL,
  `parentemployeeaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `ordernumber` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`betrecordcode`),
  KEY `FK_activity_bet_record_enterprise_activity_customization` (`ecactivitycode`) USING BTREE,
  KEY `FK_activity_bet_record_enterprise_employee` (`employeecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=55106 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='活动打码记录';

-- ----------------------------
-- Records of activity_bet_record
-- ----------------------------

-- ----------------------------
-- Table structure for activity_but_bonus
-- ----------------------------
DROP TABLE IF EXISTS `activity_but_bonus`;
CREATE TABLE `activity_but_bonus` (
  `lsh` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键流水号',
  `createdate` int(11) DEFAULT NULL COMMENT '创建日期 yyyyMMdd',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `pay_type` char(2) DEFAULT NULL COMMENT '业务分类 请看枚举分类',
  `enterprisebrandactivitycode` int(11) DEFAULT NULL COMMENT '企业绑定的活动编码',
  `enterprisecode` char(8) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `loginaccount` varchar(50) DEFAULT NULL COMMENT '员工账号',
  `butmoney` double DEFAULT NULL COMMENT '有效投注额',
  `bonusrand` double DEFAULT NULL COMMENT '注投返利比例',
  `bonusmoney` double DEFAULT NULL COMMENT '返利金额',
  `bonustime` datetime DEFAULT NULL COMMENT '返利时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '注备说明 请记录游戏大类或小类代码',
  `status` char(2) DEFAULT '0' COMMENT '发放状态 0=未发放 1=已发放',
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB AUTO_INCREMENT=2518 DEFAULT CHARSET=utf8 COMMENT='投注返水记录';

-- ----------------------------
-- Records of activity_but_bonus
-- ----------------------------

-- ----------------------------
-- Table structure for activity_deposit_bonus
-- ----------------------------
DROP TABLE IF EXISTS `activity_deposit_bonus`;
CREATE TABLE `activity_deposit_bonus` (
  `ordernumber` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '订单ID',
  `employeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) COLLATE utf8_bin NOT NULL COMMENT '用户账号',
  `depositType` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT '充值活动类型',
  `depositamount` decimal(16,2) NOT NULL COMMENT '充值金额',
  `returnratio` decimal(16,2) NOT NULL COMMENT '返奖比率',
  `returnamount` decimal(16,2) NOT NULL COMMENT '返奖金额',
  `deposittime` datetime NOT NULL COMMENT '充值时间',
  `gettime` datetime NOT NULL COMMENT '领取时间',
  `uniqueinfo` text COLLATE utf8_bin NOT NULL COMMENT '身份认证信息',
  PRIMARY KEY (`ordernumber`),
  KEY `FK_activity_reg_bonus_enterprise_employee_1` (`employeecode`) USING BTREE,
  KEY `FK_activity_reg_bonus_enterprise_employee_2` (`parentemployeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='充值返利';

-- ----------------------------
-- Records of activity_deposit_bonus
-- ----------------------------

-- ----------------------------
-- Table structure for activity_lose_bonus
-- ----------------------------
DROP TABLE IF EXISTS `activity_lose_bonus`;
CREATE TABLE `activity_lose_bonus` (
  `losebonuscode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `employeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) COLLATE utf8_bin NOT NULL COMMENT '用户账号',
  `loseamount` decimal(16,2) NOT NULL COMMENT '上月输钱金额',
  `returnratio` smallint(6) NOT NULL COMMENT '返奖比率',
  `returnamount` decimal(16,2) NOT NULL COMMENT '返奖金额',
  `gettime` datetime NOT NULL COMMENT '领取时间',
  `losebonusstatus` char(1) COLLATE utf8_bin NOT NULL COMMENT '是否派发 0未派发 1已派发',
  `uniqueinfo` text COLLATE utf8_bin NOT NULL COMMENT '身份认证信息',
  PRIMARY KEY (`losebonuscode`),
  KEY `FK_activity_reg_bonus_enterprise_employee_1` (`employeecode`) USING BTREE,
  KEY `FK_activity_reg_bonus_enterprise_employee_2` (`parentemployeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='输钱返利';

-- ----------------------------
-- Records of activity_lose_bonus
-- ----------------------------

-- ----------------------------
-- Table structure for activity_raffle_control
-- ----------------------------
DROP TABLE IF EXISTS `activity_raffle_control`;
CREATE TABLE `activity_raffle_control` (
  `rafflecontrolcode` int(11) NOT NULL AUTO_INCREMENT,
  `employeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT '用户账号',
  `availabletimes` smallint(6) NOT NULL DEFAULT '0' COMMENT '当前可用抽奖次数',
  `finishtimes` smallint(6) NOT NULL DEFAULT '0' COMMENT '已完成抽奖次数',
  `donatedate` datetime NOT NULL COMMENT '赠送时间',
  `ecactivitycode` int(11) DEFAULT '0',
  `createtime` datetime DEFAULT NULL,
  `createdate` int(11) DEFAULT '0',
  `fingerprintcode` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `loginip` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`rafflecontrolcode`),
  KEY `index1` (`employeecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='抽奖控制统计表';

-- ----------------------------
-- Records of activity_raffle_control
-- ----------------------------

-- ----------------------------
-- Table structure for activity_raffle_record
-- ----------------------------
DROP TABLE IF EXISTS `activity_raffle_record`;
CREATE TABLE `activity_raffle_record` (
  `rafflecontrolcode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `employeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT '用户账号',
  `reffletime` datetime NOT NULL COMMENT '抽奖时间',
  `reffleprizes` char(50) COLLATE utf8_bin NOT NULL COMMENT '中奖奖项',
  `fingerprintcode` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `loginip` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `ecactivitycode` int(11) DEFAULT NULL,
  PRIMARY KEY (`rafflecontrolcode`),
  KEY `FK_activity_reg_bonus_enterprise_employee_1` (`employeecode`) USING BTREE,
  KEY `FK_activity_reg_bonus_enterprise_employee_2` (`parentemployeecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='抽奖记录表';

-- ----------------------------
-- Records of activity_raffle_record
-- ----------------------------

-- ----------------------------
-- Table structure for activity_raffle_signin
-- ----------------------------
DROP TABLE IF EXISTS `activity_raffle_signin`;
CREATE TABLE `activity_raffle_signin` (
  `rafflesignincode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `employeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '用户编码',
  `signintime` datetime NOT NULL COMMENT '签到时间',
  `depositamount` decimal(16,2) NOT NULL COMMENT '充值金额',
  `betamount` decimal(16,2) NOT NULL COMMENT '打码金额',
  `isexpires` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否在有效期内(1:是，0:否)',
  PRIMARY KEY (`rafflesignincode`),
  KEY `FK_activity_reg_bonus_enterprise_employee` (`employeecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='签到登记表';


-- ----------------------------
-- Table structure for activity_redbag
-- ----------------------------
DROP TABLE IF EXISTS `activity_redbag`;
CREATE TABLE `activity_redbag` (
  `lsh` varchar(36) NOT NULL DEFAULT '',
  `enterprisecode` char(8) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(20) DEFAULT NULL,
  `money` double DEFAULT NULL,
  `logindate` varchar(8) DEFAULT NULL,
  `loginip` varchar(20) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `audittime` datetime DEFAULT NULL,
  `auditer` varchar(20) DEFAULT NULL,
  `paytyime` datetime DEFAULT NULL,
  `auditremark` varchar(500) DEFAULT NULL,
  `payer` varchar(20) DEFAULT NULL,
  `lsbs` varchar(2) DEFAULT NULL,
  `ectivityname` varchar(100) DEFAULT NULL,
  `enterprisebrandactivitycode` varchar(20) DEFAULT NULL,
  `redbagtype` int(11) DEFAULT '1',
  `fingerprintcode` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`lsh`),
  KEY `index_activity_redbag_2` (`enterprisecode`) USING BTREE,
  KEY `activity_redbag_ix2` (`employeecode`) USING BTREE,
  KEY `activity_redbag_ix3` (`logindate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activity_redbag
-- ----------------------------

-- ----------------------------
-- Table structure for activity_reg_bonus
-- ----------------------------
DROP TABLE IF EXISTS `activity_reg_bonus`;
CREATE TABLE `activity_reg_bonus` (
  `regbonuscode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `employeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) COLLATE utf8_bin NOT NULL COMMENT '用户账号',
  `regbonus` decimal(16,2) NOT NULL COMMENT '奖金金额',
  `gettime` datetime NOT NULL COMMENT '领取时间',
  `uniqueinfo` text COLLATE utf8_bin NOT NULL COMMENT '身份认证信息',
  PRIMARY KEY (`regbonuscode`),
  KEY `FK_activity_reg_bonus_enterprise_employee_1` (`employeecode`) USING BTREE,
  KEY `FK_activity_reg_bonus_enterprise_employee_2` (`parentemployeecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='注册彩金';

-- ----------------------------
-- Records of activity_reg_bonus
-- ----------------------------

-- ----------------------------
-- Table structure for activity_template
-- ----------------------------
DROP TABLE IF EXISTS `activity_template`;
CREATE TABLE `activity_template` (
  `activitycode` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动编码',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '活动名称',
  `activitydesc` text COLLATE utf8_bin COMMENT '活动描述',
  `activitynature` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '活动特性，0：常规活动 1：特殊活动',
  `status` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '状态 (1启用，2禁用)',
  `datastatus` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`activitycode`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='活动模板';

-- ----------------------------
-- Records of activity_template
-- ----------------------------
INSERT INTO `activity_template` VALUES ('1', '注册彩金', 0xE794A8E688B7E6B3A8E5868CE5908EE58FAFE4BBA5E9A286E58F96E6B3A8E5868CE5BDA9E98791EFBC8CE5BDA9E98791E98791E9A29DE59CA8E99990E588B6E4B88AE99990E58685E99A8FE69CBAE7949FE68890E68896E88085E59BBAE5AE9A, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('2', '推荐有礼', 0xE68EA8E88D90E4BC9AE59198E8BF9BE8A18CE6B3A8E5868CE5908EE9A696E6ACA1E58585E580BCE58FAFE4BBA5E9A286E58F96E7A4BCE98791, '0', '1', '-1');
INSERT INTO `activity_template` VALUES ('3', '充值赠送', 0xE794A8E688B7E6AF8FE6ACA1E58585E580BCE8B5A0E98081E4B880E5AE9AE6AF94E4BE8BE98791E9A29D, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('4', '输钱返利', 0xE6AF8FE69C88E5AFB9E8BE93E992B1E4BC9AE59198E8BF9BE8A18CE8BF94E588A9, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('5', '幸运抽奖', 0xE6BBA1E8B6B3E69DA1E4BBB6E79A84E794A8E688B7E58FAFE4BBA5E8BF9BE8A18CE68ABDE5A596, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('6', '充值大抽奖', 0xE4BBA5E58585E580BCE98791E9A29DE88C83E59BB4E4B8BAE59FBAE58786EFBC8CE68EA7E588B6E59084E5A596E9A1B9E4B8ADE5A596E6A682E78E87EFBC8CE58F8AE58581E8AEB8E4B8ADE5A596E4B88AE99990E6ACA1E695B0, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('7', '充值赠送高级版', 0xE58585E580BCE8B5A0E98081E4B880E5AE9AE6AF94E4BE8BE79A84E8BF94E588A9E78EB0E98791E380820D0AE28094E58FAFE8AEBEE5AE9AE69C80E4BD8EE99990E9A29DEFBC9B0D0AE28094E58FAFE8AEBEE5AE9AE6AF8FE4B8AAE58585E580BCE88C83E59BB4E79A84E8BF94E588A9E6AF94E4BE8BEFBC9B0D0AE28094E58FAFE8AEBEE5AE9AE58FAAE69C89E68C87E5AE9AE79A84E58585E580BCE6B8A0E98193E6898DE883BDE8BF94E588A9EFBC9B0D0AE28094E58FAFE8AEBEE5AE9AE6B581E6B0B4E5808DE695B0EFBC9B, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('8', '日投注返水高级版', 0xE697A5E68A95E6B3A8E8BF94E6B0B4E9AB98E7BAA7E78988, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('9', '代理自定义活动', 0xE4BBA3E79086E887AAE5AE9AE4B989E6B4BBE58AA8EFBC8CE6898BE58AA8E7BB93E7AE97, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('10', 'PT首存送30%', 0xE5AE98E696B9E59BBAE4BBB6E58D87E7BAA7E5BC80E58F91E59586EFBC9BE5958AE5908EE69DA5E68993E5A5BDE4BA86E8B083E8998EE7A6BBE5B1B1E989B2E5A5BDE79C8BE69292E59388E68B8920E5958AE5908EE69DA5E989B2E5A5BDE79C8BE4BA86E5958AE5A5BDE5A4A7E5A5BDE5A4A7E595A6E68CA5E6B492E5BE88E5A4A72061646B686B616C68646C6168646B616E6C2F646C61686461736520E79A84E59388E59388E4BD9BE9B384207520E4BF845549E58DB3E58FAFE6B688E999A4, '0', '1', '-1');
INSERT INTO `activity_template` VALUES ('11', '签到领红包', 0xE6B4BBE58AA8E58FAFE4BBA5E8AEBEE5AE9AE697B6E997B4E88C83E59BB4E58685EFBC8CE6AF8FE5A4A9E799BBE5BD95E4B880E6ACA1E9A286E58F96E4B880E6ACA1E7BAA2E58C85EFBC8CE6AF8FE5A4A9E69C80E5A49AE4B880E6ACA1E380820D0AE58FAFE4BBA5E8AEBEE5AE9AE9A286E58F96E8A681E6B182EFBC9A0D0A31E38081E698AFE590A6E8A681E6B182E69C89E8BF87E5AD98E6ACBEE58F8AE6ACA1E695B0E380820D0A32E38081E698AFE590A6E8A681E6B182E5AD98E6ACBEE69C80E4BD8EE99990E9A29DE380820D0A33E38081E698AFE590A6E887AAE58AA8E58F91E694BEE68896E5AEA2E69C8DE5AEA1E6A0B8E6898DE883BDE58F91E694BEE38082, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('12', '首存赠送', 0xE9A696E6ACA1E58585E580BCE8B5A0E98081E4B880E5AE9AE6AF94E4BE8BE79A84E8BF94E588A9E78EB0E98791E380820D0AE28094E58FAFE8AEBEE5AE9AE69C80E4BD8EE99990E9A29DEFBC9B0D0AE28094E58FAFE8AEBEE5AE9AE6AF8FE4B8AAE58585E580BCE88C83E59BB4E79A84E8BF94E588A9E6AF94E4BE8BEFBC9B0D0AE28094E58FAFE8AEBEE5AE9AE8BF94E588A9E4B88AE99990E5B081E9A1B6EFBC9B0D0AE28094E58FAFE8AEBEE5AE9AE6B581E6B0B4E5808DE695B0EFBC9B, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('13', '注册领红包', 0xE696B0E6B3A8E5868CE794A8E688B7EFBC8CE58FAFE4BBA5E9A286E58F96E99A8FE69CBAE7BAA2E58C85E380820D0AE58FAFE4BBA5E8AEBEE5AE9AE9A286E58F96E8A681E6B182EFBC9A0D0A31E38081E698AFE590A6E887AAE58AA8E58F91E694BEE68896E5AEA2E69C8DE5AEA1E6A0B8E6898DE883BDE58F91E694BEE38082, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('14', '完善资料领红包', 0xE4BBBBE6848FE794A8E688B7EFBC8CE58FAFE4BBA5E9A286E58F96E99A8FE69CBAE7BAA2E58C85E380820D0AE58FAFE4BBA5E8AEBEE5AE9AE9A286E58F96E8A681E6B182EFBC9A0D0A31E38081E698AFE590A6E887AAE58AA8E58F91E694BEE68896E5AEA2E69C8DE5AEA1E6A0B8E6898DE883BDE58F91E694BEE38082, '0', '1', '1');
INSERT INTO `activity_template` VALUES ('15', '每日充值享受抽奖', 0xE99288E5AFB9E4BC9AE59198E6AF8FE697A5E58585E580BCE6BBA1E8B6B3E69DA1E4BBB6E697B6E58FAFE4BBA5E68ABDE5A596E4B880E6ACA1EFBC9A0D0A31E38081E58585E580BCE98791E9A29DE8BEBEE588B0E8AEBEE5AE9AE580BCE697B6E380820D0A32E38081E5B9B6E4B894E5BD93E697A5E6B2A1E69C89E68ABDE5A596E8BF87E380820D0A33E38081E99990E5AE9AE6AF8FE697A5E68ABDE5A596E4BABAE695B0E38082, '0', '1', '1');

-- ----------------------------
-- Table structure for activity_template_setting
-- ----------------------------
DROP TABLE IF EXISTS `activity_template_setting`;
CREATE TABLE `activity_template_setting` (
  `activitysettingcode` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动配置编码',
  `activitycode` int(11) NOT NULL COMMENT '活动模板编码',
  `agementname` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '参数',
  `agementdesc` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '参数描述',
  PRIMARY KEY (`activitysettingcode`),
  KEY `FK_activity_template_setting_activity_template_activitycode` (`activitycode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='活动配置';

-- ----------------------------
-- Records of activity_template_setting
-- ----------------------------
INSERT INTO `activity_template_setting` VALUES ('6', '1', 'HBSX', '红包上限');
INSERT INTO `activity_template_setting` VALUES ('7', '1', 'HBXX', '红包下限');
INSERT INTO `activity_template_setting` VALUES ('8', '1', 'LSBS', '流水倍数');
INSERT INTO `activity_template_setting` VALUES ('9', '3', 'FLBFB', '返利百分比');
INSERT INTO `activity_template_setting` VALUES ('10', '3', 'LSBS', '流水倍数');
INSERT INTO `activity_template_setting` VALUES ('11', '4', 'FLBFB', '返利百分比');
INSERT INTO `activity_template_setting` VALUES ('12', '4', 'DUTYHJE', '是否扣除优惠');
INSERT INTO `activity_template_setting` VALUES ('13', '4', 'LSBS', '流水倍数');
INSERT INTO `activity_template_setting` VALUES ('14', '5', 'QDCJYS', '签到抽奖映射');
INSERT INTO `activity_template_setting` VALUES ('15', '5', 'JJJLYS', '奖金几率映射');
INSERT INTO `activity_template_setting` VALUES ('16', '6', 'MONEY_RAND', '充值范围、中奖几率及奖项');
INSERT INTO `activity_template_setting` VALUES ('17', '6', 'PRIZE_NUM', '各奖项允许中奖次数等设置');
INSERT INTO `activity_template_setting` VALUES ('18', '6', 'MONEY_PRE', '充值金额满足多少时可以获得抽奖机会');
INSERT INTO `activity_template_setting` VALUES ('19', '6', 'IS_PRIZE_NUM_GET', '获取抽奖次数是否可以以充值金额平均（1是 其他否）');
INSERT INTO `activity_template_setting` VALUES ('20', '6', 'LSBS', '提款需流水倍数（0表示不要求）');
INSERT INTO `activity_template_setting` VALUES ('21', '6', 'PRIZE_LIST', '奖项列表（重要。其他参数均按此参数顺序配置）');
INSERT INTO `activity_template_setting` VALUES ('22', '7', 'MIN_MONEY', '最低限额');
INSERT INTO `activity_template_setting` VALUES ('23', '7', 'RAND_MONEY', '各充值范围的返利比例');
INSERT INTO `activity_template_setting` VALUES ('24', '7', 'LSBS', '提款流水倍数（可设0）');
INSERT INTO `activity_template_setting` VALUES ('25', '7', 'PAY_MENT_KEY', '限定的充值渠道（不填表示不限定）');
INSERT INTO `activity_template_setting` VALUES ('26', '7', 'BANK_CODE', '限定的银行代码（结合支付渠道）');
INSERT INTO `activity_template_setting` VALUES ('27', '8', 'START_TIME', '返水开始时间（默认18点开始。当天统计昨日的日投注量）');
INSERT INTO `activity_template_setting` VALUES ('28', '8', 'RAND_MONEY', '日投注量与返点比例配置');
INSERT INTO `activity_template_setting` VALUES ('29', '8', 'IS_AUTO_PAY', '是否自动付款（0=非自动 1=自动）非自动时，只生成统计数据报表，不会直接增加余额（注意：仅限测试时观察数据使用。测试情况下，务必设置为0）');
INSERT INTO `activity_template_setting` VALUES ('30', '7', 'IS_AUTO_PAY', '是否自动付款（0=非自动 1=自动）非自动时，只生成统计数据报表，不会直接增加余额（注意：仅限测试时观察数据使用。测试情况下，务必设置为0）');
INSERT INTO `activity_template_setting` VALUES ('31', '8', 'TOTAL_DEPOSIT_MONEY', '用户历史充值总额要求（无要求填写0）');
INSERT INTO `activity_template_setting` VALUES ('32', '8', 'TODAY_DEPOSIT_MONEY', '用户当日充值总额要求（无要求填写0）');
INSERT INTO `activity_template_setting` VALUES ('33', '8', 'LSBS', '提款需流水倍数（无要求填写0）');
INSERT INTO `activity_template_setting` VALUES ('35', '11', 'RECHARGE_NUM', '至少存款次数（可为0）');
INSERT INTO `activity_template_setting` VALUES ('36', '11', 'RECHARGE_MONEY', '至少存款金额（可为0）');
INSERT INTO `activity_template_setting` VALUES ('37', '11', 'REDBAG_RATE', '红包大小及概率（必填）');
INSERT INTO `activity_template_setting` VALUES ('38', '11', 'GET_FUNCTION', '领取方式（1=接口手动，2=登录自动领取）');
INSERT INTO `activity_template_setting` VALUES ('39', '11', 'IS_AUTO_PAY', '是否自动发放（1=自动，2=人工审核）');
INSERT INTO `activity_template_setting` VALUES ('40', '11', 'LSBS', '流水倍数（可为0）');
INSERT INTO `activity_template_setting` VALUES ('41', '7', 'TOP_MONEY', '最高上限额（填写0即不限封顶）');
INSERT INTO `activity_template_setting` VALUES ('42', '12', 'MIN_MONEY', '最低限额');
INSERT INTO `activity_template_setting` VALUES ('43', '12', 'RAND_MONEY', '各充值范围的返利比例');
INSERT INTO `activity_template_setting` VALUES ('44', '12', 'LSBS', '提款流水倍数（可设0）');
INSERT INTO `activity_template_setting` VALUES ('45', '12', 'IS_AUTO_PAY', '是否自动付款（0=非自动 1=自动）非自动时，只生成统计数据报表，不会直接增加余额（注意：仅限测试时观察数据使用。测试情况下，务必设置为0）');
INSERT INTO `activity_template_setting` VALUES ('46', '12', 'TOP_MONEY', '赠送金额上限（设为0即不封顶）');
INSERT INTO `activity_template_setting` VALUES ('47', '13', 'REDBAG_RATE', '红包大小及概率（必填）');
INSERT INTO `activity_template_setting` VALUES ('48', '13', 'IS_AUTO_PAY', '是否自动发放（1=自动，2=人工审核）');
INSERT INTO `activity_template_setting` VALUES ('49', '13', 'GET_FUNCTION', '领取方式（1=接口手动，2=登录自动领取）');
INSERT INTO `activity_template_setting` VALUES ('50', '13', 'LSBS', '流水倍数（可为0）');
INSERT INTO `activity_template_setting` VALUES ('51', '14', 'LSBS', '流水倍数（可为0）');
INSERT INTO `activity_template_setting` VALUES ('52', '14', 'GET_FUNCTION', '领取方式（1=接口手动，2=登录自动领取）');
INSERT INTO `activity_template_setting` VALUES ('53', '14', 'IS_AUTO_PAY', '是否自动发放（1=自动，2=人工审核）');
INSERT INTO `activity_template_setting` VALUES ('54', '14', 'REDBAG_RATE', '红包大小及概率（必填）');
INSERT INTO `activity_template_setting` VALUES ('55', '15', 'LSBS', '流水倍数（可为0）');
INSERT INTO `activity_template_setting` VALUES ('56', '15', 'REDBAG_RATE', '红包大小及概率（必填）');
INSERT INTO `activity_template_setting` VALUES ('57', '15', 'DAY_COUNT', '每日抽奖总人数（为0不限制）');
INSERT INTO `activity_template_setting` VALUES ('58', '15', 'START_MONEY', '单笔最低充值金额（为0不限制）');
INSERT INTO `activity_template_setting` VALUES ('59', '15', 'DAY_MONEY', '当天累计满');

-- ----------------------------
-- Table structure for agent_banner_info
-- ----------------------------
DROP TABLE IF EXISTS `agent_banner_info`;
CREATE TABLE `agent_banner_info` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键, 自增',
  `enterprisecode` char(8) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '品牌编码',
  `bannertype` char(10) DEFAULT NULL COMMENT 'banner类型:PC/H5',
  `imgpath` varchar(500) DEFAULT NULL COMMENT 'banner图片地址',
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='代理推广系统 - banner表';

-- ----------------------------
-- Records of agent_banner_info
-- ----------------------------
INSERT INTO `agent_banner_info` VALUES ('1', null, null, 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305910091.png');
INSERT INTO `agent_banner_info` VALUES ('2', null, null, 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305937378.png');
INSERT INTO `agent_banner_info` VALUES ('3', null, null, 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305958770.png');
INSERT INTO `agent_banner_info` VALUES ('4', null, null, 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305971044.png');
INSERT INTO `agent_banner_info` VALUES ('5', 'EN0000', 'EB00001L', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305910091.png');
INSERT INTO `agent_banner_info` VALUES ('6', 'EN0000', 'EB00001L', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305937378.png');
INSERT INTO `agent_banner_info` VALUES ('7', 'EN0000', 'EB00001L', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305958770.png');
INSERT INTO `agent_banner_info` VALUES ('8', 'EN0000', 'EB00001L', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305971044.png');
INSERT INTO `agent_banner_info` VALUES ('12', 'EN0000', 'EB00001M', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305910091.png');
INSERT INTO `agent_banner_info` VALUES ('13', 'EN0000', 'EB00001M', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305937378.png');
INSERT INTO `agent_banner_info` VALUES ('14', 'EN0000', 'EB00001M', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305958770.png');
INSERT INTO `agent_banner_info` VALUES ('15', 'EN0000', 'EB00001M', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305971044.png');
INSERT INTO `agent_banner_info` VALUES ('19', 'EN0000', 'EB000029', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305910091.png');
INSERT INTO `agent_banner_info` VALUES ('20', 'EN0000', 'EB000029', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305937378.png');
INSERT INTO `agent_banner_info` VALUES ('21', 'EN0000', 'EB000029', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305958770.png');
INSERT INTO `agent_banner_info` VALUES ('22', 'EN0000', 'EB000029', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305971044.png');
INSERT INTO `agent_banner_info` VALUES ('23', 'EN003A', 'EB0000B7', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305910091.png');
INSERT INTO `agent_banner_info` VALUES ('24', 'EN003A', 'EB0000B7', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305937378.png');
INSERT INTO `agent_banner_info` VALUES ('25', 'EN003A', 'EB0000B7', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305958770.png');
INSERT INTO `agent_banner_info` VALUES ('26', 'EN003A', 'EB0000B7', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305971044.png');
INSERT INTO `agent_banner_info` VALUES ('30', 'EN003A', 'EB0000BN', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305910091.png');
INSERT INTO `agent_banner_info` VALUES ('31', 'EN003A', 'EB0000BN', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305937378.png');
INSERT INTO `agent_banner_info` VALUES ('32', 'EN003A', 'EB0000BN', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305958770.png');
INSERT INTO `agent_banner_info` VALUES ('33', 'EN003A', 'EB0000BN', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305971044.png');
INSERT INTO `agent_banner_info` VALUES ('37', 'EN003K', 'EB0000BD', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305910091.png');
INSERT INTO `agent_banner_info` VALUES ('38', 'EN003K', 'EB0000BD', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305937378.png');
INSERT INTO `agent_banner_info` VALUES ('39', 'EN003K', 'EB0000BD', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305958770.png');
INSERT INTO `agent_banner_info` VALUES ('40', 'EN003K', 'EB0000BD', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305971044.png');
INSERT INTO `agent_banner_info` VALUES ('44', 'EN003Y', 'EB0000BI', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305910091.png');
INSERT INTO `agent_banner_info` VALUES ('45', 'EN003Y', 'EB0000BI', 'PC', 'https://img.hyzonghe.net/uploadfiles/1508305937378.png');
INSERT INTO `agent_banner_info` VALUES ('46', 'EN003Y', 'EB0000BI', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305958770.png');
INSERT INTO `agent_banner_info` VALUES ('47', 'EN003Y', 'EB0000BI', 'H5', 'https://img.hyzonghe.net/uploadfiles/1508305971044.png');

-- ----------------------------
-- Table structure for agent_item_info
-- ----------------------------
DROP TABLE IF EXISTS `agent_item_info`;
CREATE TABLE `agent_item_info` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键, 自增',
  `enterprisecode` char(8) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '品牌编码',
  `iconpath` varchar(500) DEFAULT NULL COMMENT '栏目图标地址',
  `title` varchar(100) DEFAULT NULL COMMENT '栏目标题',
  `content` varchar(5000) DEFAULT NULL COMMENT '栏目内容',
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='代理推广系统 - 栏目表';

-- ----------------------------
-- Records of agent_item_info
-- ----------------------------
INSERT INTO `agent_item_info` VALUES ('1', null, null, 'https://img.hyzonghe.net/uploadfiles/1508306223483.png', '合营模式', '<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title\" style=\"color:#6C6B6B;font-size:26px;font-family:\"background-color:#E2E2E2;\">\r\n	合营模式\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n</span>');
INSERT INTO `agent_item_info` VALUES ('2', null, null, 'https://img.hyzonghe.net/uploadfiles/1508306911931.png', '平台介绍', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们拥有强大和丰富经验的娱乐经営団队， 提供有亚洲最多元，专业，顶尖，公正，安全的线上娱乐产品服务。 HY平台、火星棋牌、 鼎丰棋牌、人人彩，BBIN、OG、AG、PT、IDN扑克、GG扑克等知名平台，为玩家提供真人娱乐、老虎机、棋牌、彩票、体育等 多样化娱乐休闲的选择。现金网前端我们提供多套模板任代理商选择，可以满足不同用户群体喜好，给予代理多元化模式 运行。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无论你拥有的是网络资源，或是人脉资源， 都欢迎你加入我们合作伙伴的行列，无须负担任何费用，就可以开始无上限的收入。我们绝对是你最聪明的选择!\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('3', null, null, 'https://img.hyzonghe.net/uploadfiles/1508306943976.png', '关于我们', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	       直营HY真人视讯、棋牌游戏、彩票游戏，OG、BBIN、PT、MG、TTG、AG，IDN扑克、GG扑克。我们的产品、 市场运作模式、客户服务、商业信誉，在整个行业中，属于一个成功的典范，都为大家所推崇。我们的优势在于我们有高效快 捷的开发团队；并有创新的市场营销策略和营销工具，其信誉一流的博彩产品更是不容置疑，我们的棋牌网站、真人视讯网站 的趣味新颖使得我们处在潮流的最前沿，你还在等什么呢，来与我们一道，共赢天下吧！\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·庞大的顶级开发团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高效专业快捷的代理服务团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高佣金比例的合作模式，你可以赚的比我们还多\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·亚洲最强棋牌游戏，真人现场，彩票游戏，让客户玩的更尽兴\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·十余年行业信誉积累，优质的公信力，不容置疑\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·独创三阶式合营模式，彻底解决你的后顾之忧\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·详细的分析报表功能，让你钱途无量，事事顺利\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('4', null, null, 'https://img.hyzonghe.net/uploadfiles/1508307085496.png', '代理协议', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	一、我们的权利与义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      我们的客服部会登记代理和会员信息，并会观察他们的投注状况。加盟代理及会员必须同意并 遵守我们的会员案条例， 政策及操作程式。我们保留拒绝或冻结加盟与会员帐户权利加盟代理可随时登入管理界面观察旗下会员的下注状况及线下 代理在网站的活动概况。我们的客服部会根据加盟代理的会员案计算所得的佣金。我们保留可以修改合约书上的任何 条例，包括: 现有的佣金范围、佣金计划、付款程式、及参考计划条例的权力，我们会以电邮、网站公告等方法通知加盟 代理。 加盟代理对于所做的修改有异议，加盟代理可选择终止合约，或洽客服人员反映意见。 如修改后加盟代理无任何异议， 便视作默认合约修改，加盟代理必须遵守更改后的相关规定。\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	二、加盟代理的权力及义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      加盟代理应尽其所能，广泛地宣传、销售及推广我们，使代理本身及我们的利润最大化。 加盟代理可在不违反法律下， 以正面形象宣传、销售及推广我们，并有责任义务告知旗下会员所有我们的相关优惠条件及产品。加盟代理选择的推广手法若需付费，则代理应承担该费用。任何我们相关资讯包括: 标志、报表、游戏画面、图样、文案等，加盟 代理不得私自复制、公开、分发有关材料，我们保留法律追诉权。 如代理在做业务推广有相关需要，请随时洽我们。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	三、规则条款\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      各阶层加盟代理不可在未经我们许可情况下开设双/多个的代理帐号， 也不可从我们帐户或相关人士赚取佣金。请谨记任何阶层代理不能用代理帐户下注，我们有权终止并封存帐号及所有在游戏 中赚取的佣金。为确保所有我们会员账号隐私与权益，我们不会提供任何会员密码，或会员个人资料。各阶层加盟代理亦不 得以任何方式取得会员资料， 或任意登入下层会员账号，如发现加盟代理有侵害我们会员隐私行为，我们有权取消加盟代理 红利，并取消加盟代理账号。加盟代理旗下的会员不得开设多于一个的帐户。我们有权要求会员提供有效的身份证明以验证会员的 身份，并保留以IP判定是否重复会员的权利。如违反上述事项，我们有权终止玩家进行游戏并封存帐号及所有于游戏中赚取的佣金 加盟代理不可为自己或其他加盟下的有效投注会员,只能是公司直属下的有效投注会员, 代理每月需有５个下线有效投注会员（每月至少 上线3次进行正常投注），如有违反加盟协议我们有权终止并封存帐号及所有在游戏中赚取的佣金。如加盟代理旗下的会员因为 违反条例而被禁止享用我们的游戏，或我们退回存款给会员，我们将不会分配相应的佣金给加盟代理。如加盟代 理旗下会员存款用的信用卡、银行资料须经审核，我们保留相关佣金直至审核完成。合约内的条件会以我们通知接受 加盟代理加入后开始执行。我们及加盟代理可随时终止此合约，在任何情况下，加盟代理如果想终止合 约，都必须以书面 /电邮方式提早于七日内通知我们。 加盟代理的表现会3个月审核一次，如加盟代理已不是现有的合作成员则本合约书可以 在任何时间终止。如合作伙伴违反合约条例，我们有权立即终止 合约。在没有我们许可下，加盟代理不能透露及授权 我们相关密资料，包括加盟代理所获得的回馈、佣金报表、计算等;加盟代理有义务在合约终止后仍执行机密档及资料的保密。 在合约终止后，加盟代理及我们将不须要履行双方的权利及义务。终止合约并不会解除加盟代理于终止合约前应履行的义务。\r\n</p>\r\n	</p>');
INSERT INTO `agent_item_info` VALUES ('5', null, null, 'https://img.hyzonghe.net/uploadfiles/1508307116081.png', '运作方式', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	如何推荐玩家赚取佣金？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      点击右上角 “登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现 金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以 继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	常见的推广方式有哪些？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      最简单的就 是把你的现金网链接直接发给客户。当然最普遍的合作模式是设立一个网站或者在其他 网站投放现金网广告，并把广告的链接设置为我们为你提供的现金网链接。网民透过浏 览你的广告进入现金网平台。你链接过来的玩家越多，你所赚取的佣金越多！\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('6', null, null, 'https://img.hyzonghe.net/uploadfiles/1508307156242.png', '联系方式', '<p class=\"p_txt_1\" id=\"connect_phone\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	手机号码:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_skype\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	SKYPE:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_qq\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	QQ:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_email\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	邮箱:\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('7', 'EN0000', 'EB00001L', 'https://img.hyzonghe.net/uploadfiles/1508306223483.png', '合营模式', '<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title\" style=\"color:#6C6B6B;font-size:26px;font-family:\"background-color:#E2E2E2;\">\r\n	合营模式\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n</span>');
INSERT INTO `agent_item_info` VALUES ('8', 'EN0000', 'EB00001L', 'https://img.hyzonghe.net/uploadfiles/1508306911931.png', '平台介绍', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们拥有强大和丰富经验的娱乐经営団队， 提供有亚洲最多元，专业，顶尖，公正，安全的线上娱乐产品服务。 HY平台、火星棋牌、 鼎丰棋牌、人人彩，BBIN、OG、AG、PT、IDN扑克、GG扑克等知名平台，为玩家提供真人娱乐、老虎机、棋牌、彩票、体育等 多样化娱乐休闲的选择。现金网前端我们提供多套模板任代理商选择，可以满足不同用户群体喜好，给予代理多元化模式 运行。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无论你拥有的是网络资源，或是人脉资源， 都欢迎你加入我们合作伙伴的行列，无须负担任何费用，就可以开始无上限的收入。我们绝对是你最聪明的选择!\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('9', 'EN0000', 'EB00001L', 'https://img.hyzonghe.net/uploadfiles/1508306943976.png', '关于我们', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	       直营HY真人视讯、棋牌游戏、彩票游戏，OG、BBIN、PT、MG、TTG、AG，IDN扑克、GG扑克。我们的产品、 市场运作模式、客户服务、商业信誉，在整个行业中，属于一个成功的典范，都为大家所推崇。我们的优势在于我们有高效快 捷的开发团队；并有创新的市场营销策略和营销工具，其信誉一流的博彩产品更是不容置疑，我们的棋牌网站、真人视讯网站 的趣味新颖使得我们处在潮流的最前沿，你还在等什么呢，来与我们一道，共赢天下吧！\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·庞大的顶级开发团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高效专业快捷的代理服务团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高佣金比例的合作模式，你可以赚的比我们还多\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·亚洲最强棋牌游戏，真人现场，彩票游戏，让客户玩的更尽兴\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·十余年行业信誉积累，优质的公信力，不容置疑\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·独创三阶式合营模式，彻底解决你的后顾之忧\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·详细的分析报表功能，让你钱途无量，事事顺利\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('10', 'EN0000', 'EB00001L', 'https://img.hyzonghe.net/uploadfiles/1508307085496.png', '代理协议', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	一、我们的权利与义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      我们的客服部会登记代理和会员信息，并会观察他们的投注状况。加盟代理及会员必须同意并 遵守我们的会员案条例， 政策及操作程式。我们保留拒绝或冻结加盟与会员帐户权利加盟代理可随时登入管理界面观察旗下会员的下注状况及线下 代理在网站的活动概况。我们的客服部会根据加盟代理的会员案计算所得的佣金。我们保留可以修改合约书上的任何 条例，包括: 现有的佣金范围、佣金计划、付款程式、及参考计划条例的权力，我们会以电邮、网站公告等方法通知加盟 代理。 加盟代理对于所做的修改有异议，加盟代理可选择终止合约，或洽客服人员反映意见。 如修改后加盟代理无任何异议， 便视作默认合约修改，加盟代理必须遵守更改后的相关规定。\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	二、加盟代理的权力及义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      加盟代理应尽其所能，广泛地宣传、销售及推广我们，使代理本身及我们的利润最大化。 加盟代理可在不违反法律下， 以正面形象宣传、销售及推广我们，并有责任义务告知旗下会员所有我们的相关优惠条件及产品。加盟代理选择的推广手法若需付费，则代理应承担该费用。任何我们相关资讯包括: 标志、报表、游戏画面、图样、文案等，加盟 代理不得私自复制、公开、分发有关材料，我们保留法律追诉权。 如代理在做业务推广有相关需要，请随时洽我们。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	三、规则条款\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      各阶层加盟代理不可在未经我们许可情况下开设双/多个的代理帐号， 也不可从我们帐户或相关人士赚取佣金。请谨记任何阶层代理不能用代理帐户下注，我们有权终止并封存帐号及所有在游戏 中赚取的佣金。为确保所有我们会员账号隐私与权益，我们不会提供任何会员密码，或会员个人资料。各阶层加盟代理亦不 得以任何方式取得会员资料， 或任意登入下层会员账号，如发现加盟代理有侵害我们会员隐私行为，我们有权取消加盟代理 红利，并取消加盟代理账号。加盟代理旗下的会员不得开设多于一个的帐户。我们有权要求会员提供有效的身份证明以验证会员的 身份，并保留以IP判定是否重复会员的权利。如违反上述事项，我们有权终止玩家进行游戏并封存帐号及所有于游戏中赚取的佣金 加盟代理不可为自己或其他加盟下的有效投注会员,只能是公司直属下的有效投注会员, 代理每月需有５个下线有效投注会员（每月至少 上线3次进行正常投注），如有违反加盟协议我们有权终止并封存帐号及所有在游戏中赚取的佣金。如加盟代理旗下的会员因为 违反条例而被禁止享用我们的游戏，或我们退回存款给会员，我们将不会分配相应的佣金给加盟代理。如加盟代 理旗下会员存款用的信用卡、银行资料须经审核，我们保留相关佣金直至审核完成。合约内的条件会以我们通知接受 加盟代理加入后开始执行。我们及加盟代理可随时终止此合约，在任何情况下，加盟代理如果想终止合 约，都必须以书面 /电邮方式提早于七日内通知我们。 加盟代理的表现会3个月审核一次，如加盟代理已不是现有的合作成员则本合约书可以 在任何时间终止。如合作伙伴违反合约条例，我们有权立即终止 合约。在没有我们许可下，加盟代理不能透露及授权 我们相关密资料，包括加盟代理所获得的回馈、佣金报表、计算等;加盟代理有义务在合约终止后仍执行机密档及资料的保密。 在合约终止后，加盟代理及我们将不须要履行双方的权利及义务。终止合约并不会解除加盟代理于终止合约前应履行的义务。\r\n</p>\r\n	</p>');
INSERT INTO `agent_item_info` VALUES ('11', 'EN0000', 'EB00001L', 'https://img.hyzonghe.net/uploadfiles/1508307116081.png', '运作方式', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	如何推荐玩家赚取佣金？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      点击右上角 “登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现 金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以 继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	常见的推广方式有哪些？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      最简单的就 是把你的现金网链接直接发给客户。当然最普遍的合作模式是设立一个网站或者在其他 网站投放现金网广告，并把广告的链接设置为我们为你提供的现金网链接。网民透过浏 览你的广告进入现金网平台。你链接过来的玩家越多，你所赚取的佣金越多！\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('12', 'EN0000', 'EB00001L', 'https://img.hyzonghe.net/uploadfiles/1508307156242.png', '联系方式', '<p class=\"p_txt_1\" id=\"connect_phone\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	手机号码:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_skype\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	SKYPE:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_qq\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	QQ:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_email\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	邮箱:\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('14', 'EN0000', 'EB00001M', 'https://img.hyzonghe.net/uploadfiles/1508306223483.png', '合营模式', '<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title\" style=\"color:#6C6B6B;font-size:26px;font-family:\"background-color:#E2E2E2;\">\r\n	合营模式\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n</span>');
INSERT INTO `agent_item_info` VALUES ('15', 'EN0000', 'EB00001M', 'https://img.hyzonghe.net/uploadfiles/1508306911931.png', '平台介绍', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们拥有强大和丰富经验的娱乐经営団队， 提供有亚洲最多元，专业，顶尖，公正，安全的线上娱乐产品服务。 HY平台、火星棋牌、 鼎丰棋牌、人人彩，BBIN、OG、AG、PT、IDN扑克、GG扑克等知名平台，为玩家提供真人娱乐、老虎机、棋牌、彩票、体育等 多样化娱乐休闲的选择。现金网前端我们提供多套模板任代理商选择，可以满足不同用户群体喜好，给予代理多元化模式 运行。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无论你拥有的是网络资源，或是人脉资源， 都欢迎你加入我们合作伙伴的行列，无须负担任何费用，就可以开始无上限的收入。我们绝对是你最聪明的选择!\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('16', 'EN0000', 'EB00001M', 'https://img.hyzonghe.net/uploadfiles/1508306943976.png', '关于我们', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	       直营HY真人视讯、棋牌游戏、彩票游戏，OG、BBIN、PT、MG、TTG、AG，IDN扑克、GG扑克。我们的产品、 市场运作模式、客户服务、商业信誉，在整个行业中，属于一个成功的典范，都为大家所推崇。我们的优势在于我们有高效快 捷的开发团队；并有创新的市场营销策略和营销工具，其信誉一流的博彩产品更是不容置疑，我们的棋牌网站、真人视讯网站 的趣味新颖使得我们处在潮流的最前沿，你还在等什么呢，来与我们一道，共赢天下吧！\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·庞大的顶级开发团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高效专业快捷的代理服务团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高佣金比例的合作模式，你可以赚的比我们还多\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·亚洲最强棋牌游戏，真人现场，彩票游戏，让客户玩的更尽兴\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·十余年行业信誉积累，优质的公信力，不容置疑\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·独创三阶式合营模式，彻底解决你的后顾之忧\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·详细的分析报表功能，让你钱途无量，事事顺利\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('17', 'EN0000', 'EB00001M', 'https://img.hyzonghe.net/uploadfiles/1508307085496.png', '代理协议', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	一、我们的权利与义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      我们的客服部会登记代理和会员信息，并会观察他们的投注状况。加盟代理及会员必须同意并 遵守我们的会员案条例， 政策及操作程式。我们保留拒绝或冻结加盟与会员帐户权利加盟代理可随时登入管理界面观察旗下会员的下注状况及线下 代理在网站的活动概况。我们的客服部会根据加盟代理的会员案计算所得的佣金。我们保留可以修改合约书上的任何 条例，包括: 现有的佣金范围、佣金计划、付款程式、及参考计划条例的权力，我们会以电邮、网站公告等方法通知加盟 代理。 加盟代理对于所做的修改有异议，加盟代理可选择终止合约，或洽客服人员反映意见。 如修改后加盟代理无任何异议， 便视作默认合约修改，加盟代理必须遵守更改后的相关规定。\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	二、加盟代理的权力及义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      加盟代理应尽其所能，广泛地宣传、销售及推广我们，使代理本身及我们的利润最大化。 加盟代理可在不违反法律下， 以正面形象宣传、销售及推广我们，并有责任义务告知旗下会员所有我们的相关优惠条件及产品。加盟代理选择的推广手法若需付费，则代理应承担该费用。任何我们相关资讯包括: 标志、报表、游戏画面、图样、文案等，加盟 代理不得私自复制、公开、分发有关材料，我们保留法律追诉权。 如代理在做业务推广有相关需要，请随时洽我们。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	三、规则条款\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      各阶层加盟代理不可在未经我们许可情况下开设双/多个的代理帐号， 也不可从我们帐户或相关人士赚取佣金。请谨记任何阶层代理不能用代理帐户下注，我们有权终止并封存帐号及所有在游戏 中赚取的佣金。为确保所有我们会员账号隐私与权益，我们不会提供任何会员密码，或会员个人资料。各阶层加盟代理亦不 得以任何方式取得会员资料， 或任意登入下层会员账号，如发现加盟代理有侵害我们会员隐私行为，我们有权取消加盟代理 红利，并取消加盟代理账号。加盟代理旗下的会员不得开设多于一个的帐户。我们有权要求会员提供有效的身份证明以验证会员的 身份，并保留以IP判定是否重复会员的权利。如违反上述事项，我们有权终止玩家进行游戏并封存帐号及所有于游戏中赚取的佣金 加盟代理不可为自己或其他加盟下的有效投注会员,只能是公司直属下的有效投注会员, 代理每月需有５个下线有效投注会员（每月至少 上线3次进行正常投注），如有违反加盟协议我们有权终止并封存帐号及所有在游戏中赚取的佣金。如加盟代理旗下的会员因为 违反条例而被禁止享用我们的游戏，或我们退回存款给会员，我们将不会分配相应的佣金给加盟代理。如加盟代 理旗下会员存款用的信用卡、银行资料须经审核，我们保留相关佣金直至审核完成。合约内的条件会以我们通知接受 加盟代理加入后开始执行。我们及加盟代理可随时终止此合约，在任何情况下，加盟代理如果想终止合 约，都必须以书面 /电邮方式提早于七日内通知我们。 加盟代理的表现会3个月审核一次，如加盟代理已不是现有的合作成员则本合约书可以 在任何时间终止。如合作伙伴违反合约条例，我们有权立即终止 合约。在没有我们许可下，加盟代理不能透露及授权 我们相关密资料，包括加盟代理所获得的回馈、佣金报表、计算等;加盟代理有义务在合约终止后仍执行机密档及资料的保密。 在合约终止后，加盟代理及我们将不须要履行双方的权利及义务。终止合约并不会解除加盟代理于终止合约前应履行的义务。\r\n</p>\r\n	</p>');
INSERT INTO `agent_item_info` VALUES ('18', 'EN0000', 'EB00001M', 'https://img.hyzonghe.net/uploadfiles/1508307116081.png', '运作方式', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	如何推荐玩家赚取佣金？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      点击右上角 “登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现 金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以 继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	常见的推广方式有哪些？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      最简单的就 是把你的现金网链接直接发给客户。当然最普遍的合作模式是设立一个网站或者在其他 网站投放现金网广告，并把广告的链接设置为我们为你提供的现金网链接。网民透过浏 览你的广告进入现金网平台。你链接过来的玩家越多，你所赚取的佣金越多！\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('19', 'EN0000', 'EB00001M', 'https://img.hyzonghe.net/uploadfiles/1508307156242.png', '联系方式', '<p class=\"p_txt_1\" id=\"connect_phone\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	手机号码:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_skype\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	SKYPE:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_qq\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	QQ:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_email\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	邮箱:\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('21', 'EN0000', 'EB000029', 'https://img.hyzonghe.net/uploadfiles/1508306223483.png', '合营模式', '<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title\" style=\"color:#6C6B6B;font-size:26px;font-family:\"background-color:#E2E2E2;\">\r\n	合营模式\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n</span>');
INSERT INTO `agent_item_info` VALUES ('22', 'EN0000', 'EB000029', 'https://img.hyzonghe.net/uploadfiles/1508306911931.png', '平台介绍', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们拥有强大和丰富经验的娱乐经営団队， 提供有亚洲最多元，专业，顶尖，公正，安全的线上娱乐产品服务。 HY平台、火星棋牌、 鼎丰棋牌、人人彩，BBIN、OG、AG、PT、IDN扑克、GG扑克等知名平台，为玩家提供真人娱乐、老虎机、棋牌、彩票、体育等 多样化娱乐休闲的选择。现金网前端我们提供多套模板任代理商选择，可以满足不同用户群体喜好，给予代理多元化模式 运行。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无论你拥有的是网络资源，或是人脉资源， 都欢迎你加入我们合作伙伴的行列，无须负担任何费用，就可以开始无上限的收入。我们绝对是你最聪明的选择!\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('23', 'EN0000', 'EB000029', 'https://img.hyzonghe.net/uploadfiles/1508306943976.png', '关于我们', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	       直营HY真人视讯、棋牌游戏、彩票游戏，OG、BBIN、PT、MG、TTG、AG，IDN扑克、GG扑克。我们的产品、 市场运作模式、客户服务、商业信誉，在整个行业中，属于一个成功的典范，都为大家所推崇。我们的优势在于我们有高效快 捷的开发团队；并有创新的市场营销策略和营销工具，其信誉一流的博彩产品更是不容置疑，我们的棋牌网站、真人视讯网站 的趣味新颖使得我们处在潮流的最前沿，你还在等什么呢，来与我们一道，共赢天下吧！\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·庞大的顶级开发团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高效专业快捷的代理服务团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高佣金比例的合作模式，你可以赚的比我们还多\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·亚洲最强棋牌游戏，真人现场，彩票游戏，让客户玩的更尽兴\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·十余年行业信誉积累，优质的公信力，不容置疑\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·独创三阶式合营模式，彻底解决你的后顾之忧\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·详细的分析报表功能，让你钱途无量，事事顺利\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('24', 'EN0000', 'EB000029', 'https://img.hyzonghe.net/uploadfiles/1508307085496.png', '代理协议', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	一、我们的权利与义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      我们的客服部会登记代理和会员信息，并会观察他们的投注状况。加盟代理及会员必须同意并 遵守我们的会员案条例， 政策及操作程式。我们保留拒绝或冻结加盟与会员帐户权利加盟代理可随时登入管理界面观察旗下会员的下注状况及线下 代理在网站的活动概况。我们的客服部会根据加盟代理的会员案计算所得的佣金。我们保留可以修改合约书上的任何 条例，包括: 现有的佣金范围、佣金计划、付款程式、及参考计划条例的权力，我们会以电邮、网站公告等方法通知加盟 代理。 加盟代理对于所做的修改有异议，加盟代理可选择终止合约，或洽客服人员反映意见。 如修改后加盟代理无任何异议， 便视作默认合约修改，加盟代理必须遵守更改后的相关规定。\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	二、加盟代理的权力及义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      加盟代理应尽其所能，广泛地宣传、销售及推广我们，使代理本身及我们的利润最大化。 加盟代理可在不违反法律下， 以正面形象宣传、销售及推广我们，并有责任义务告知旗下会员所有我们的相关优惠条件及产品。加盟代理选择的推广手法若需付费，则代理应承担该费用。任何我们相关资讯包括: 标志、报表、游戏画面、图样、文案等，加盟 代理不得私自复制、公开、分发有关材料，我们保留法律追诉权。 如代理在做业务推广有相关需要，请随时洽我们。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	三、规则条款\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      各阶层加盟代理不可在未经我们许可情况下开设双/多个的代理帐号， 也不可从我们帐户或相关人士赚取佣金。请谨记任何阶层代理不能用代理帐户下注，我们有权终止并封存帐号及所有在游戏 中赚取的佣金。为确保所有我们会员账号隐私与权益，我们不会提供任何会员密码，或会员个人资料。各阶层加盟代理亦不 得以任何方式取得会员资料， 或任意登入下层会员账号，如发现加盟代理有侵害我们会员隐私行为，我们有权取消加盟代理 红利，并取消加盟代理账号。加盟代理旗下的会员不得开设多于一个的帐户。我们有权要求会员提供有效的身份证明以验证会员的 身份，并保留以IP判定是否重复会员的权利。如违反上述事项，我们有权终止玩家进行游戏并封存帐号及所有于游戏中赚取的佣金 加盟代理不可为自己或其他加盟下的有效投注会员,只能是公司直属下的有效投注会员, 代理每月需有５个下线有效投注会员（每月至少 上线3次进行正常投注），如有违反加盟协议我们有权终止并封存帐号及所有在游戏中赚取的佣金。如加盟代理旗下的会员因为 违反条例而被禁止享用我们的游戏，或我们退回存款给会员，我们将不会分配相应的佣金给加盟代理。如加盟代 理旗下会员存款用的信用卡、银行资料须经审核，我们保留相关佣金直至审核完成。合约内的条件会以我们通知接受 加盟代理加入后开始执行。我们及加盟代理可随时终止此合约，在任何情况下，加盟代理如果想终止合 约，都必须以书面 /电邮方式提早于七日内通知我们。 加盟代理的表现会3个月审核一次，如加盟代理已不是现有的合作成员则本合约书可以 在任何时间终止。如合作伙伴违反合约条例，我们有权立即终止 合约。在没有我们许可下，加盟代理不能透露及授权 我们相关密资料，包括加盟代理所获得的回馈、佣金报表、计算等;加盟代理有义务在合约终止后仍执行机密档及资料的保密。 在合约终止后，加盟代理及我们将不须要履行双方的权利及义务。终止合约并不会解除加盟代理于终止合约前应履行的义务。\r\n</p>\r\n	</p>');
INSERT INTO `agent_item_info` VALUES ('25', 'EN0000', 'EB000029', 'https://img.hyzonghe.net/uploadfiles/1508307116081.png', '运作方式', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	如何推荐玩家赚取佣金？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      点击右上角 “登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现 金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以 继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	常见的推广方式有哪些？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      最简单的就 是把你的现金网链接直接发给客户。当然最普遍的合作模式是设立一个网站或者在其他 网站投放现金网广告，并把广告的链接设置为我们为你提供的现金网链接。网民透过浏 览你的广告进入现金网平台。你链接过来的玩家越多，你所赚取的佣金越多！\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('26', 'EN0000', 'EB000029', 'https://img.hyzonghe.net/uploadfiles/1508307156242.png', '联系方式', '<p class=\"p_txt_1\" id=\"connect_phone\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	手机号码:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_skype\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	SKYPE:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_qq\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	QQ:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_email\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	邮箱:\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('27', 'EN003A', 'EB0000B7', 'https://img.hyzonghe.net/uploadfiles/1508306223483.png', '合营模式', '<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title\" style=\"color:#6C6B6B;font-size:26px;font-family:\"background-color:#E2E2E2;\">\r\n	合营模式\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n</span>');
INSERT INTO `agent_item_info` VALUES ('28', 'EN003A', 'EB0000B7', 'https://img.hyzonghe.net/uploadfiles/1508306911931.png', '平台介绍', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们拥有强大和丰富经验的娱乐经営団队， 提供有亚洲最多元，专业，顶尖，公正，安全的线上娱乐产品服务。 HY平台、火星棋牌、 鼎丰棋牌、人人彩，BBIN、OG、AG、PT、IDN扑克、GG扑克等知名平台，为玩家提供真人娱乐、老虎机、棋牌、彩票、体育等 多样化娱乐休闲的选择。现金网前端我们提供多套模板任代理商选择，可以满足不同用户群体喜好，给予代理多元化模式 运行。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无论你拥有的是网络资源，或是人脉资源， 都欢迎你加入我们合作伙伴的行列，无须负担任何费用，就可以开始无上限的收入。我们绝对是你最聪明的选择!\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('29', 'EN003A', 'EB0000B7', 'https://img.hyzonghe.net/uploadfiles/1508306943976.png', '关于我们', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	       直营HY真人视讯、棋牌游戏、彩票游戏，OG、BBIN、PT、MG、TTG、AG，IDN扑克、GG扑克。我们的产品、 市场运作模式、客户服务、商业信誉，在整个行业中，属于一个成功的典范，都为大家所推崇。我们的优势在于我们有高效快 捷的开发团队；并有创新的市场营销策略和营销工具，其信誉一流的博彩产品更是不容置疑，我们的棋牌网站、真人视讯网站 的趣味新颖使得我们处在潮流的最前沿，你还在等什么呢，来与我们一道，共赢天下吧！\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·庞大的顶级开发团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高效专业快捷的代理服务团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高佣金比例的合作模式，你可以赚的比我们还多\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·亚洲最强棋牌游戏，真人现场，彩票游戏，让客户玩的更尽兴\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·十余年行业信誉积累，优质的公信力，不容置疑\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·独创三阶式合营模式，彻底解决你的后顾之忧\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·详细的分析报表功能，让你钱途无量，事事顺利\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('30', 'EN003A', 'EB0000B7', 'https://img.hyzonghe.net/uploadfiles/1508307085496.png', '代理协议', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	一、我们的权利与义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      我们的客服部会登记代理和会员信息，并会观察他们的投注状况。加盟代理及会员必须同意并 遵守我们的会员案条例， 政策及操作程式。我们保留拒绝或冻结加盟与会员帐户权利加盟代理可随时登入管理界面观察旗下会员的下注状况及线下 代理在网站的活动概况。我们的客服部会根据加盟代理的会员案计算所得的佣金。我们保留可以修改合约书上的任何 条例，包括: 现有的佣金范围、佣金计划、付款程式、及参考计划条例的权力，我们会以电邮、网站公告等方法通知加盟 代理。 加盟代理对于所做的修改有异议，加盟代理可选择终止合约，或洽客服人员反映意见。 如修改后加盟代理无任何异议， 便视作默认合约修改，加盟代理必须遵守更改后的相关规定。\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	二、加盟代理的权力及义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      加盟代理应尽其所能，广泛地宣传、销售及推广我们，使代理本身及我们的利润最大化。 加盟代理可在不违反法律下， 以正面形象宣传、销售及推广我们，并有责任义务告知旗下会员所有我们的相关优惠条件及产品。加盟代理选择的推广手法若需付费，则代理应承担该费用。任何我们相关资讯包括: 标志、报表、游戏画面、图样、文案等，加盟 代理不得私自复制、公开、分发有关材料，我们保留法律追诉权。 如代理在做业务推广有相关需要，请随时洽我们。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	三、规则条款\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      各阶层加盟代理不可在未经我们许可情况下开设双/多个的代理帐号， 也不可从我们帐户或相关人士赚取佣金。请谨记任何阶层代理不能用代理帐户下注，我们有权终止并封存帐号及所有在游戏 中赚取的佣金。为确保所有我们会员账号隐私与权益，我们不会提供任何会员密码，或会员个人资料。各阶层加盟代理亦不 得以任何方式取得会员资料， 或任意登入下层会员账号，如发现加盟代理有侵害我们会员隐私行为，我们有权取消加盟代理 红利，并取消加盟代理账号。加盟代理旗下的会员不得开设多于一个的帐户。我们有权要求会员提供有效的身份证明以验证会员的 身份，并保留以IP判定是否重复会员的权利。如违反上述事项，我们有权终止玩家进行游戏并封存帐号及所有于游戏中赚取的佣金 加盟代理不可为自己或其他加盟下的有效投注会员,只能是公司直属下的有效投注会员, 代理每月需有５个下线有效投注会员（每月至少 上线3次进行正常投注），如有违反加盟协议我们有权终止并封存帐号及所有在游戏中赚取的佣金。如加盟代理旗下的会员因为 违反条例而被禁止享用我们的游戏，或我们退回存款给会员，我们将不会分配相应的佣金给加盟代理。如加盟代 理旗下会员存款用的信用卡、银行资料须经审核，我们保留相关佣金直至审核完成。合约内的条件会以我们通知接受 加盟代理加入后开始执行。我们及加盟代理可随时终止此合约，在任何情况下，加盟代理如果想终止合 约，都必须以书面 /电邮方式提早于七日内通知我们。 加盟代理的表现会3个月审核一次，如加盟代理已不是现有的合作成员则本合约书可以 在任何时间终止。如合作伙伴违反合约条例，我们有权立即终止 合约。在没有我们许可下，加盟代理不能透露及授权 我们相关密资料，包括加盟代理所获得的回馈、佣金报表、计算等;加盟代理有义务在合约终止后仍执行机密档及资料的保密。 在合约终止后，加盟代理及我们将不须要履行双方的权利及义务。终止合约并不会解除加盟代理于终止合约前应履行的义务。\r\n</p>\r\n	</p>');
INSERT INTO `agent_item_info` VALUES ('31', 'EN003A', 'EB0000B7', 'https://img.hyzonghe.net/uploadfiles/1508307116081.png', '运作方式', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	如何推荐玩家赚取佣金？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      点击右上角 “登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现 金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以 继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	常见的推广方式有哪些？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      最简单的就 是把你的现金网链接直接发给客户。当然最普遍的合作模式是设立一个网站或者在其他 网站投放现金网广告，并把广告的链接设置为我们为你提供的现金网链接。网民透过浏 览你的广告进入现金网平台。你链接过来的玩家越多，你所赚取的佣金越多！\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('32', 'EN003A', 'EB0000B7', 'https://img.hyzonghe.net/uploadfiles/1508307156242.png', '联系方式', '&lt;p class=\"p_txt_1\" id=\"connect_phone\" style=\"color:#6C6C6B;font-family:\" font-size:medium;background-color:#e2e2e2;\"=\"\"&gt;\r\n	手机号码: +63917 906 1336\r\n	&lt;/p&gt;\r\n&lt;p class=\"p_txt_1\" id=\"connect_skype\" style=\"color:#6C6C6B;font-family:\" font-size:medium;background-color:#e2e2e2;\"=\"\"&gt;Q Q号码: 133 938 2536\r\n&lt;/p&gt;\r\n&lt;p class=\"p_txt_1\" id=\"connect_email\" style=\"color:#6C6C6B;font-family:\" font-size:medium;background-color:#e2e2e2;\"=\"\"&gt;电子邮箱: dwguoji6868@gmail.com\r\n	&lt;/p&gt;');
INSERT INTO `agent_item_info` VALUES ('34', 'EN003A', 'EB0000BN', 'https://img.hyzonghe.net/uploadfiles/1508306223483.png', '合营模式', '<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title\" style=\"color:#6C6B6B;font-size:26px;font-family:\"background-color:#E2E2E2;\">\r\n	合营模式\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n</span>');
INSERT INTO `agent_item_info` VALUES ('35', 'EN003A', 'EB0000BN', 'https://img.hyzonghe.net/uploadfiles/1508306911931.png', '平台介绍', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们拥有强大和丰富经验的娱乐经営団队， 提供有亚洲最多元，专业，顶尖，公正，安全的线上娱乐产品服务。 HY平台、火星棋牌、 鼎丰棋牌、人人彩，BBIN、OG、AG、PT、IDN扑克、GG扑克等知名平台，为玩家提供真人娱乐、老虎机、棋牌、彩票、体育等 多样化娱乐休闲的选择。现金网前端我们提供多套模板任代理商选择，可以满足不同用户群体喜好，给予代理多元化模式 运行。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无论你拥有的是网络资源，或是人脉资源， 都欢迎你加入我们合作伙伴的行列，无须负担任何费用，就可以开始无上限的收入。我们绝对是你最聪明的选择!\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('36', 'EN003A', 'EB0000BN', 'https://img.hyzonghe.net/uploadfiles/1508306943976.png', '关于我们', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	       直营HY真人视讯、棋牌游戏、彩票游戏，OG、BBIN、PT、MG、TTG、AG，IDN扑克、GG扑克。我们的产品、 市场运作模式、客户服务、商业信誉，在整个行业中，属于一个成功的典范，都为大家所推崇。我们的优势在于我们有高效快 捷的开发团队；并有创新的市场营销策略和营销工具，其信誉一流的博彩产品更是不容置疑，我们的棋牌网站、真人视讯网站 的趣味新颖使得我们处在潮流的最前沿，你还在等什么呢，来与我们一道，共赢天下吧！\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·庞大的顶级开发团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高效专业快捷的代理服务团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高佣金比例的合作模式，你可以赚的比我们还多\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·亚洲最强棋牌游戏，真人现场，彩票游戏，让客户玩的更尽兴\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·十余年行业信誉积累，优质的公信力，不容置疑\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·独创三阶式合营模式，彻底解决你的后顾之忧\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·详细的分析报表功能，让你钱途无量，事事顺利\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('37', 'EN003A', 'EB0000BN', 'https://img.hyzonghe.net/uploadfiles/1508307085496.png', '代理协议', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	一、我们的权利与义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      我们的客服部会登记代理和会员信息，并会观察他们的投注状况。加盟代理及会员必须同意并 遵守我们的会员案条例， 政策及操作程式。我们保留拒绝或冻结加盟与会员帐户权利加盟代理可随时登入管理界面观察旗下会员的下注状况及线下 代理在网站的活动概况。我们的客服部会根据加盟代理的会员案计算所得的佣金。我们保留可以修改合约书上的任何 条例，包括: 现有的佣金范围、佣金计划、付款程式、及参考计划条例的权力，我们会以电邮、网站公告等方法通知加盟 代理。 加盟代理对于所做的修改有异议，加盟代理可选择终止合约，或洽客服人员反映意见。 如修改后加盟代理无任何异议， 便视作默认合约修改，加盟代理必须遵守更改后的相关规定。\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	二、加盟代理的权力及义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      加盟代理应尽其所能，广泛地宣传、销售及推广我们，使代理本身及我们的利润最大化。 加盟代理可在不违反法律下， 以正面形象宣传、销售及推广我们，并有责任义务告知旗下会员所有我们的相关优惠条件及产品。加盟代理选择的推广手法若需付费，则代理应承担该费用。任何我们相关资讯包括: 标志、报表、游戏画面、图样、文案等，加盟 代理不得私自复制、公开、分发有关材料，我们保留法律追诉权。 如代理在做业务推广有相关需要，请随时洽我们。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	三、规则条款\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      各阶层加盟代理不可在未经我们许可情况下开设双/多个的代理帐号， 也不可从我们帐户或相关人士赚取佣金。请谨记任何阶层代理不能用代理帐户下注，我们有权终止并封存帐号及所有在游戏 中赚取的佣金。为确保所有我们会员账号隐私与权益，我们不会提供任何会员密码，或会员个人资料。各阶层加盟代理亦不 得以任何方式取得会员资料， 或任意登入下层会员账号，如发现加盟代理有侵害我们会员隐私行为，我们有权取消加盟代理 红利，并取消加盟代理账号。加盟代理旗下的会员不得开设多于一个的帐户。我们有权要求会员提供有效的身份证明以验证会员的 身份，并保留以IP判定是否重复会员的权利。如违反上述事项，我们有权终止玩家进行游戏并封存帐号及所有于游戏中赚取的佣金 加盟代理不可为自己或其他加盟下的有效投注会员,只能是公司直属下的有效投注会员, 代理每月需有５个下线有效投注会员（每月至少 上线3次进行正常投注），如有违反加盟协议我们有权终止并封存帐号及所有在游戏中赚取的佣金。如加盟代理旗下的会员因为 违反条例而被禁止享用我们的游戏，或我们退回存款给会员，我们将不会分配相应的佣金给加盟代理。如加盟代 理旗下会员存款用的信用卡、银行资料须经审核，我们保留相关佣金直至审核完成。合约内的条件会以我们通知接受 加盟代理加入后开始执行。我们及加盟代理可随时终止此合约，在任何情况下，加盟代理如果想终止合 约，都必须以书面 /电邮方式提早于七日内通知我们。 加盟代理的表现会3个月审核一次，如加盟代理已不是现有的合作成员则本合约书可以 在任何时间终止。如合作伙伴违反合约条例，我们有权立即终止 合约。在没有我们许可下，加盟代理不能透露及授权 我们相关密资料，包括加盟代理所获得的回馈、佣金报表、计算等;加盟代理有义务在合约终止后仍执行机密档及资料的保密。 在合约终止后，加盟代理及我们将不须要履行双方的权利及义务。终止合约并不会解除加盟代理于终止合约前应履行的义务。\r\n</p>\r\n	</p>');
INSERT INTO `agent_item_info` VALUES ('38', 'EN003A', 'EB0000BN', 'https://img.hyzonghe.net/uploadfiles/1508307116081.png', '运作方式', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	如何推荐玩家赚取佣金？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      点击右上角 “登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现 金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以 继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	常见的推广方式有哪些？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      最简单的就 是把你的现金网链接直接发给客户。当然最普遍的合作模式是设立一个网站或者在其他 网站投放现金网广告，并把广告的链接设置为我们为你提供的现金网链接。网民透过浏 览你的广告进入现金网平台。你链接过来的玩家越多，你所赚取的佣金越多！\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('39', 'EN003A', 'EB0000BN', 'https://img.hyzonghe.net/uploadfiles/1508307156242.png', '联系方式', '<p class=\"p_txt_1\" id=\"connect_phone\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	手机号码:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_skype\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	SKYPE:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_qq\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	QQ:\r\n</p>\r\n<p class=\"p_txt_1\" id=\"connect_email\" style=\"color:#6C6C6B;font-family:\"font-size:medium;background-color:#E2E2E2;\">\r\n	邮箱:\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('41', 'EN003K', 'EB0000BD', 'https://img.hyzonghe.net/uploadfiles/1508306223483.png', '合营模式', '<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title\" style=\"color:#6C6B6B;font-size:26px;font-family:\"background-color:#E2E2E2;\">\r\n	合营模式\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n</span>');
INSERT INTO `agent_item_info` VALUES ('42', 'EN003K', 'EB0000BD', 'https://img.hyzonghe.net/uploadfiles/1508306911931.png', '平台介绍', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们拥有强大和丰富经验的娱乐经営団队， 提供有亚洲最多元，专业，顶尖，公正，安全的线上娱乐产品服务。 HY平台、火星棋牌、 鼎丰棋牌、人人彩，BBIN、OG、AG、PT、IDN扑克、GG扑克等知名平台，为玩家提供真人娱乐、老虎机、棋牌、彩票、体育等 多样化娱乐休闲的选择。现金网前端我们提供多套模板任代理商选择，可以满足不同用户群体喜好，给予代理多元化模式 运行。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无论你拥有的是网络资源，或是人脉资源， 都欢迎你加入我们合作伙伴的行列，无须负担任何费用，就可以开始无上限的收入。我们绝对是你最聪明的选择!\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('43', 'EN003K', 'EB0000BD', 'https://img.hyzonghe.net/uploadfiles/1508306943976.png', '关于我们', '<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	       直营HY真人视讯、棋牌游戏、彩票游戏，OG、BBIN、PT、MG、TTG、AG，IDN扑克、GG扑克。我们的产品、 市场运作模式、客户服务、商业信誉，在整个行业中，属于一个成功的典范，都为大家所推崇。我们的优势在于我们有高效快 捷的开发团队；并有创新的市场营销策略和营销工具，其信誉一流的博彩产品更是不容置疑，我们的棋牌网站、真人视讯网站 的趣味新颖使得我们处在潮流的最前沿，你还在等什么呢，来与我们一道，共赢天下吧！\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·庞大的顶级开发团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高效专业快捷的代理服务团队\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·高佣金比例的合作模式，你可以赚的比我们还多\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·亚洲最强棋牌游戏，真人现场，彩票游戏，让客户玩的更尽兴\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·十余年行业信誉积累，优质的公信力，不容置疑\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·独创三阶式合营模式，彻底解决你的后顾之忧\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	·详细的分析报表功能，让你钱途无量，事事顺利\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('44', 'EN003K', 'EB0000BD', 'https://img.hyzonghe.net/uploadfiles/1508307085496.png', '代理协议', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	一、我们的权利与义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      我们的客服部会登记代理和会员信息，并会观察他们的投注状况。加盟代理及会员必须同意并 遵守我们的会员案条例， 政策及操作程式。我们保留拒绝或冻结加盟与会员帐户权利加盟代理可随时登入管理界面观察旗下会员的下注状况及线下 代理在网站的活动概况。我们的客服部会根据加盟代理的会员案计算所得的佣金。我们保留可以修改合约书上的任何 条例，包括: 现有的佣金范围、佣金计划、付款程式、及参考计划条例的权力，我们会以电邮、网站公告等方法通知加盟 代理。 加盟代理对于所做的修改有异议，加盟代理可选择终止合约，或洽客服人员反映意见。 如修改后加盟代理无任何异议， 便视作默认合约修改，加盟代理必须遵守更改后的相关规定。\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	二、加盟代理的权力及义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      加盟代理应尽其所能，广泛地宣传、销售及推广我们，使代理本身及我们的利润最大化。 加盟代理可在不违反法律下， 以正面形象宣传、销售及推广我们，并有责任义务告知旗下会员所有我们的相关优惠条件及产品。加盟代理选择的推广手法若需付费，则代理应承担该费用。任何我们相关资讯包括: 标志、报表、游戏画面、图样、文案等，加盟 代理不得私自复制、公开、分发有关材料，我们保留法律追诉权。 如代理在做业务推广有相关需要，请随时洽我们。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	三、规则条款\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      各阶层加盟代理不可在未经我们许可情况下开设双/多个的代理帐号， 也不可从我们帐户或相关人士赚取佣金。请谨记任何阶层代理不能用代理帐户下注，我们有权终止并封存帐号及所有在游戏 中赚取的佣金。为确保所有我们会员账号隐私与权益，我们不会提供任何会员密码，或会员个人资料。各阶层加盟代理亦不 得以任何方式取得会员资料， 或任意登入下层会员账号，如发现加盟代理有侵害我们会员隐私行为，我们有权取消加盟代理 红利，并取消加盟代理账号。加盟代理旗下的会员不得开设多于一个的帐户。我们有权要求会员提供有效的身份证明以验证会员的 身份，并保留以IP判定是否重复会员的权利。如违反上述事项，我们有权终止玩家进行游戏并封存帐号及所有于游戏中赚取的佣金 加盟代理不可为自己或其他加盟下的有效投注会员,只能是公司直属下的有效投注会员, 代理每月需有５个下线有效投注会员（每月至少 上线3次进行正常投注），如有违反加盟协议我们有权终止并封存帐号及所有在游戏中赚取的佣金。如加盟代理旗下的会员因为 违反条例而被禁止享用我们的游戏，或我们退回存款给会员，我们将不会分配相应的佣金给加盟代理。如加盟代 理旗下会员存款用的信用卡、银行资料须经审核，我们保留相关佣金直至审核完成。合约内的条件会以我们通知接受 加盟代理加入后开始执行。我们及加盟代理可随时终止此合约，在任何情况下，加盟代理如果想终止合 约，都必须以书面 /电邮方式提早于七日内通知我们。 加盟代理的表现会3个月审核一次，如加盟代理已不是现有的合作成员则本合约书可以 在任何时间终止。如合作伙伴违反合约条例，我们有权立即终止 合约。在没有我们许可下，加盟代理不能透露及授权 我们相关密资料，包括加盟代理所获得的回馈、佣金报表、计算等;加盟代理有义务在合约终止后仍执行机密档及资料的保密。 在合约终止后，加盟代理及我们将不须要履行双方的权利及义务。终止合约并不会解除加盟代理于终止合约前应履行的义务。\r\n</p>\r\n	</p>');
INSERT INTO `agent_item_info` VALUES ('45', 'EN003K', 'EB0000BD', 'https://img.hyzonghe.net/uploadfiles/1508307116081.png', '运作方式', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	如何推荐玩家赚取佣金？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      点击右上角 “登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现 金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以 继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	常见的推广方式有哪些？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      最简单的就 是把你的现金网链接直接发给客户。当然最普遍的合作模式是设立一个网站或者在其他 网站投放现金网广告，并把广告的链接设置为我们为你提供的现金网链接。网民透过浏 览你的广告进入现金网平台。你链接过来的玩家越多，你所赚取的佣金越多！\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('46', 'EN003K', 'EB0000BD', 'https://img.hyzonghe.net/uploadfiles/1508307156242.png', '联系方式', '&lt;p class=\"p_txt_1\" id=\"connect_phone\" style=\"color:#6C6C6B;font-family:\" font-size:medium;background-color:#e2e2e2;\"=\"\"&gt;\r\n	手机号码:&nbsp;15546700390\r\n	&lt;/p&gt;\r\n&lt;p class=\"p_txt_1\" id=\"connect_qq\" style=\"color:#6C6C6B;font-family:\" font-size:medium;background-color:#e2e2e2;\"=\"\"&gt;加盟联系 QQ:&nbsp;2179971059\r\n&lt;/p&gt;\r\n&lt;p class=\"p_txt_1\" id=\"connect_qq\" style=\"color:#6C6C6B;font-family:\" font-size:medium;background-color:#e2e2e2;\"=\"\"&gt;加盟微信：br_sig\r\n	&lt;/p&gt;\r\n&lt;p class=\"p_txt_1\" id=\"connect_email\" style=\"color:#6C6C6B;font-family:\" font-size:medium;background-color:#e2e2e2;\"=\"\"&gt;\r\n	邮箱:&nbsp;aff@jintaa.com\r\n&lt;/p&gt;');
INSERT INTO `agent_item_info` VALUES ('48', 'EN003Y', 'EB0000BI', 'https://img.hyzonghe.net/uploadfiles/1508306223483.png', '合营模式', '<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title\" style=\"color:#6C6B6B;font-size:26px;font-family:\"background-color:#E2E2E2;\">\r\n	合营模式\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n<span style=\"color:#6C6B6B;font-family:\" font-size:26px;background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      我们产品团队根据多年来行业经验积累，结合当今市场形势，从不同代理商的实际需求出发，独创三阶式合营模式（加盟代理、品牌代理、企业代理）力图既方便代理轻松盈利，又能快速累积客户，打造出代理自己的品牌，我们愿与你共同成长，在博彩版图上开疆拓土！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	加盟代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      无需任何费用和接入条件，点击右上角“登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	品牌代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      如果你想打造属于自己的现金网品牌，而且拥有足够的资金和客户资源，品牌代理无疑是个不错的选择。品牌代理除了拥有加盟代理所具备的能力外，还可以自定义品牌名称、访问链接。立即注册申请成为我们的品牌代理吧！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	企业代理\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      企业代理除了拥有品牌代理所具备的能力外，还将拥有专属的企业级管理后台，随心打造自己的博彩帝国。成为企业代理需要经过我们资质审核。\r\n</p>\r\n</span>');
INSERT INTO `agent_item_info` VALUES ('49', 'EN003Y', 'EB0000BI', 'https://img.hyzonghe.net/uploadfiles/1508306911931.png', '平台介绍', '&lt;p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\"&gt;\r\n	      我们拥有强大和丰富经验的娱乐经営団队， 提供有亚洲最多元，专业，顶尖，公正，安全的线上娱乐产品服务。 HY平台、火星棋牌、 鼎丰棋牌、人人彩，BBIN、OG、AG、PT、IDN扑克、GG扑克等知名平台，为玩家提供真人娱乐、老虎机、棋牌、彩票、体育等 多样化娱乐休闲的选择。现金网前端我们提供多套模板任代理商选择，可以满足不同用户群体喜好，给予代理多元化模式 运行。\r\n&lt;/p&gt;\r\n&lt;p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\"&gt;\r\n	      无论你拥有的是网络资源，或是人脉资源， 都欢迎你加入我们合作伙伴的行列，无须负担任何费用，就可以开始无上限的收入。我们绝对是你最聪明的选择!\r\n&lt;/p&gt;');
INSERT INTO `agent_item_info` VALUES ('50', 'EN003Y', 'EB0000BI', 'https://img.hyzonghe.net/uploadfiles/1508306943976.png', '关于我们', '&lt;p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\"&gt;\r\n	       直营HY真人视讯、棋牌游戏、彩票游戏，OG、BBIN、PT、MG、TTG、AG，IDN扑克、GG扑克。我们的产品、 市场运作模式、客户服务、商业信誉，在整个行业中，属于一个成功的典范，都为大家所推崇。我们的优势在于我们有高效快 捷的开发团队；并有创新的市场营销策略和营销工具，其信誉一流的博彩产品更是不容置疑，我们的棋牌网站、真人视讯网站 的趣味新颖使得我们处在潮流的最前沿，你还在等什么呢，来与我们一道，共赢天下吧！\r\n&lt;/p&gt;\r\n&lt;p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\"&gt;\r\n	·庞大的顶级开发团队\r\n&lt;/p&gt;\r\n&lt;p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\"&gt;\r\n	·高效专业快捷的代理服务团队\r\n&lt;/p&gt;\r\n&lt;p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\"&gt;\r\n	·高佣金比例的合作模式，你可以赚的比我们还多\r\n&lt;/p&gt;\r\n&lt;p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\"&gt;\r\n	·亚洲最强棋牌游戏，真人现场，彩票游戏，让客户玩的更尽兴\r\n&lt;/p&gt;\r\n&lt;p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\"&gt;\r\n	·十余年行业信誉积累，优质的公信力，不容置疑\r\n&lt;/p&gt;\r\n&lt;p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\"&gt;\r\n	·独创三阶式合营模式，彻底解决你的后顾之忧\r\n&lt;/p&gt;\r\n&lt;p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\"&gt;\r\n	·详细的分析报表功能，让你钱途无量，事事顺利\r\n&lt;/p&gt;');
INSERT INTO `agent_item_info` VALUES ('51', 'EN003Y', 'EB0000BI', 'https://img.hyzonghe.net/uploadfiles/1508307085496.png', '代理协议', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	一、我们的权利与义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      我们的客服部会登记代理和会员信息，并会观察他们的投注状况。加盟代理及会员必须同意并 遵守我们的会员案条例， 政策及操作程式。我们保留拒绝或冻结加盟与会员帐户权利加盟代理可随时登入管理界面观察旗下会员的下注状况及线下 代理在网站的活动概况。我们的客服部会根据加盟代理的会员案计算所得的佣金。我们保留可以修改合约书上的任何 条例，包括: 现有的佣金范围、佣金计划、付款程式、及参考计划条例的权力，我们会以电邮、网站公告等方法通知加盟 代理。 加盟代理对于所做的修改有异议，加盟代理可选择终止合约，或洽客服人员反映意见。 如修改后加盟代理无任何异议， 便视作默认合约修改，加盟代理必须遵守更改后的相关规定。\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	二、加盟代理的权力及义务\r\n	</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n	      加盟代理应尽其所能，广泛地宣传、销售及推广我们，使代理本身及我们的利润最大化。 加盟代理可在不违反法律下， 以正面形象宣传、销售及推广我们，并有责任义务告知旗下会员所有我们的相关优惠条件及产品。加盟代理选择的推广手法若需付费，则代理应承担该费用。任何我们相关资讯包括: 标志、报表、游戏画面、图样、文案等，加盟 代理不得私自复制、公开、分发有关材料，我们保留法律追诉权。 如代理在做业务推广有相关需要，请随时洽我们。\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\" background-color:#e2e2e2;\"=\"\">\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	三、规则条款\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      各阶层加盟代理不可在未经我们许可情况下开设双/多个的代理帐号， 也不可从我们帐户或相关人士赚取佣金。请谨记任何阶层代理不能用代理帐户下注，我们有权终止并封存帐号及所有在游戏 中赚取的佣金。为确保所有我们会员账号隐私与权益，我们不会提供任何会员密码，或会员个人资料。各阶层加盟代理亦不 得以任何方式取得会员资料， 或任意登入下层会员账号，如发现加盟代理有侵害我们会员隐私行为，我们有权取消加盟代理 红利，并取消加盟代理账号。加盟代理旗下的会员不得开设多于一个的帐户。我们有权要求会员提供有效的身份证明以验证会员的 身份，并保留以IP判定是否重复会员的权利。如违反上述事项，我们有权终止玩家进行游戏并封存帐号及所有于游戏中赚取的佣金 加盟代理不可为自己或其他加盟下的有效投注会员,只能是公司直属下的有效投注会员, 代理每月需有５个下线有效投注会员（每月至少 上线3次进行正常投注），如有违反加盟协议我们有权终止并封存帐号及所有在游戏中赚取的佣金。如加盟代理旗下的会员因为 违反条例而被禁止享用我们的游戏，或我们退回存款给会员，我们将不会分配相应的佣金给加盟代理。如加盟代 理旗下会员存款用的信用卡、银行资料须经审核，我们保留相关佣金直至审核完成。合约内的条件会以我们通知接受 加盟代理加入后开始执行。我们及加盟代理可随时终止此合约，在任何情况下，加盟代理如果想终止合 约，都必须以书面 /电邮方式提早于七日内通知我们。 加盟代理的表现会3个月审核一次，如加盟代理已不是现有的合作成员则本合约书可以 在任何时间终止。如合作伙伴违反合约条例，我们有权立即终止 合约。在没有我们许可下，加盟代理不能透露及授权 我们相关密资料，包括加盟代理所获得的回馈、佣金报表、计算等;加盟代理有义务在合约终止后仍执行机密档及资料的保密。 在合约终止后，加盟代理及我们将不须要履行双方的权利及义务。终止合约并不会解除加盟代理于终止合约前应履行的义务。\r\n</p>\r\n	</p>');
INSERT INTO `agent_item_info` VALUES ('52', 'EN003Y', 'EB0000BI', 'https://img.hyzonghe.net/uploadfiles/1508307116081.png', '运作方式', '<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	如何推荐玩家赚取佣金？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      点击右上角 “登录注册”按钮完成注册后即可立即成为我们的加盟代理。加盟代理将拥有专属的现 金网链接、代理推广链接，所有点击此链接注册游戏的用户都将是你的客户，你亦可以 继续发展下级代理，无限发展无限获利！\r\n</p>\r\n<p class=\"p_title_1\" style=\"color:#6C6B6B;font-size:22px;font-family:\"background-color:#E2E2E2;\">\r\n	常见的推广方式有哪些？\r\n</p>\r\n<p class=\"p_txt\" style=\"color:#6C6B6B;font-size:medium;font-family:\"background-color:#E2E2E2;\">\r\n	      最简单的就 是把你的现金网链接直接发给客户。当然最普遍的合作模式是设立一个网站或者在其他 网站投放现金网广告，并把广告的链接设置为我们为你提供的现金网链接。网民透过浏 览你的广告进入现金网平台。你链接过来的玩家越多，你所赚取的佣金越多！\r\n</p>');
INSERT INTO `agent_item_info` VALUES ('53', 'EN003Y', 'EB0000BI', 'https://img.hyzonghe.net/uploadfiles/1508307156242.png', '联系方式', '&lt;p class=\"p_txt_1\" id=\"connect_phone\" style=\"color:#6C6C6B;font-family:\" font-size:medium;background-color:#e2e2e2;\"=\"\"&gt;\r\n	手机号码:\r\n	&lt;/p&gt;\r\n&lt;p class=\"p_txt_1\" id=\"connect_skype\" style=\"color:#6C6C6B;font-family:\" font-size:medium;background-color:#e2e2e2;\"=\"\"&gt;\r\n	SKYPE:\r\n&lt;/p&gt;\r\n&lt;p class=\"p_txt_1\" id=\"connect_qq\" style=\"color:#6C6C6B;font-family:\" font-size:medium;background-color:#e2e2e2;\"=\"\"&gt;\r\n	QQ:1258066611\r\n	&lt;/p&gt;\r\n&lt;p class=\"p_txt_1\" id=\"connect_email\" style=\"color:#6C6C6B;font-family:\" font-size:medium;background-color:#e2e2e2;\"=\"\"&gt;\r\n	邮箱:\r\n&lt;/p&gt;');

-- ----------------------------
-- Table structure for agent_site_contact
-- ----------------------------
DROP TABLE IF EXISTS `agent_site_contact`;
CREATE TABLE `agent_site_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `domaincode` int(11) NOT NULL COMMENT '站点编码',
  `qq` varchar(50) DEFAULT NULL COMMENT 'QQ ',
  `skype` varchar(50) DEFAULT NULL COMMENT 'Skype',
  `vchat` varchar(50) DEFAULT NULL COMMENT '微信',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(50) DEFAULT NULL COMMENT '手机号码',
  PRIMARY KEY (`id`),
  KEY `FK_agent_site_contact_brand_domain_domaincode` (`domaincode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COMMENT='代理站点联系方式';

-- ----------------------------
-- Records of agent_site_contact
-- ----------------------------

-- ----------------------------
-- Table structure for api_aoi_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_aoi_gameinfo`;
CREATE TABLE `api_aoi_gameinfo` (
  `aoi_ProductID` varchar(32) NOT NULL,
  `aoi_UserName` varchar(32) DEFAULT NULL,
  `aoi_GameRecordID` varchar(32) DEFAULT NULL,
  `aoi_OrderNumber` varchar(32) DEFAULT NULL,
  `aoi_TableID` varchar(32) DEFAULT NULL,
  `aoi_Stage` varchar(32) DEFAULT NULL,
  `aoi_Inning` varchar(32) DEFAULT NULL,
  `aoi_GameNameID` varchar(32) DEFAULT NULL,
  `aoi_GameBettingKind` varchar(32) DEFAULT NULL,
  `aoi_GameBettingContent` text,
  `aoi_ResultType` varchar(32) DEFAULT NULL,
  `aoi_BettingAmount` decimal(11,2) DEFAULT NULL,
  `aoi_CompensateRate` varchar(32) DEFAULT NULL,
  `aoi_WinLoseAmount` decimal(11,2) DEFAULT NULL,
  `aoi_Balance` decimal(11,2) DEFAULT NULL,
  `aoi_AddTime` datetime DEFAULT NULL,
  `aoi_VendorId` varchar(32) DEFAULT NULL,
  `aoi_ValidAmount` decimal(11,2) DEFAULT NULL,
  `aoi_createtime` datetime DEFAULT NULL,
  `aoi_PlatformID` varchar(5) DEFAULT NULL,
  `Platformflag` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`aoi_ProductID`),
  KEY `ix_aoi_gameinfo_aoi_UserName` (`aoi_UserName`) USING BTREE,
  KEY `api_aoi_gameinfo_ix2` (`aoi_AddTime`) USING BTREE,
  KEY `api_aoi_gameinfo_ix3` (`aoi_createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_aoi_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_av_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_av_gameinfo`;
CREATE TABLE `api_av_gameinfo` (
  `tid` varchar(20) NOT NULL DEFAULT '',
  `transType` varchar(20) DEFAULT NULL,
  `amount` double(10,2) DEFAULT NULL,
  `transType2` varchar(20) DEFAULT NULL,
  `amount2` double(10,2) DEFAULT NULL,
  `provider` varchar(20) DEFAULT NULL,
  `roundID` varchar(20) DEFAULT NULL,
  `gameInfo` varchar(20) DEFAULT NULL,
  `history` varchar(255) DEFAULT NULL,
  `isRoundFinished` varchar(10) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `userID` varchar(20) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tid`),
  KEY `api_av_gameinfo_ix1` (`time`) USING BTREE,
  KEY `api_av_gameinfo_ix2` (`userID`) USING BTREE,
  KEY `api_av_gameinfo_ix3` (`createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_av_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_bbin_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_bbin_gameinfo`;
CREATE TABLE `api_bbin_gameinfo` (
  `bbin_WagersID` varchar(32) NOT NULL,
  `bbin_UserName` varchar(32) DEFAULT NULL,
  `bbin_WagersDate` datetime DEFAULT NULL,
  `bbin_GameType` varchar(32) DEFAULT NULL,
  `bbin_Result` text,
  `bbin_BetAmount` decimal(11,2) DEFAULT NULL,
  `bbin_Payoff` decimal(11,2) DEFAULT NULL,
  `bbin_Currency` varchar(32) DEFAULT NULL,
  `bbin_Commissionable` decimal(11,2) DEFAULT NULL,
  `bbin_SerialID` varchar(32) DEFAULT NULL,
  `bbin_RoundNo` varchar(32) DEFAULT NULL,
  `bbin_GameCode` varchar(32) DEFAULT NULL,
  `bbin_ResultType` varchar(32) DEFAULT NULL,
  `bbin_Card` varchar(100) DEFAULT NULL,
  `bbin_ExchangeRate` decimal(11,4) DEFAULT NULL,
  `bbin_Commission` decimal(11,4) DEFAULT NULL,
  `bbin_Origin` varchar(50) DEFAULT NULL,
  `bbin_IsPaid` varchar(32) DEFAULT NULL,
  `bbin_createtime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  `bbin_WagerDetail` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`bbin_WagersID`),
  KEY `ix_bbin_gameinfo_bbin_UserName` (`bbin_UserName`) USING BTREE,
  KEY `ix_bbin_gameinfo_bbin_WagersDate` (`bbin_WagersDate`) USING BTREE,
  KEY `api_bbin_gameinfo_ix3` (`bbin_createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_bbin_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_data_log
-- ----------------------------
DROP TABLE IF EXISTS `api_data_log`;
CREATE TABLE `api_data_log` (
  `datalog_id` varchar(32) NOT NULL,
  `datalog_count` int(11) DEFAULT NULL,
  `datalog_gametype` varchar(225) DEFAULT NULL,
  `datalog_starttime` datetime DEFAULT NULL,
  `datalog_endtime` datetime DEFAULT NULL,
  `datalog_flag` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`datalog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_data_log
-- ----------------------------

-- ----------------------------
-- Table structure for api_dzpk_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_dzpk_gameinfo`;
CREATE TABLE `api_dzpk_gameinfo` (
  `gameID` varchar(50) NOT NULL COMMENT '游戏流水号，唯一',
  `accounts` varchar(50) DEFAULT NULL COMMENT '玩家账号',
  `serverName` varchar(50) DEFAULT NULL COMMENT '房间名',
  `tableID` varchar(50) DEFAULT NULL COMMENT '桌子号',
  `chairID` varchar(50) DEFAULT NULL COMMENT '椅子号',
  `userCount` varchar(50) DEFAULT NULL COMMENT '玩家数量',
  `handCard` varchar(50) DEFAULT NULL COMMENT '手牌',
  `cellScore` varchar(50) DEFAULT NULL COMMENT '盲注',
  `allBet` varchar(50) DEFAULT NULL COMMENT '下注',
  `profit` varchar(50) DEFAULT NULL COMMENT '盈利',
  `Revenue` varchar(50) DEFAULT NULL COMMENT '税收（抽水）',
  `GameStartTime` varchar(50) DEFAULT NULL COMMENT '一局开始时间',
  `GameEndTime` varchar(50) DEFAULT NULL COMMENT '一局结束时间',
  `channelId` varchar(50) DEFAULT NULL COMMENT '渠道ID',
  `createtime` datetime DEFAULT NULL COMMENT '创建日期',
  `Platformflag` varchar(50) DEFAULT NULL COMMENT '代理标志',
  PRIMARY KEY (`gameID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='德州扑克游戏表';

-- ----------------------------
-- Records of api_dzpk_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_ebet_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_ebet_gameinfo`;
CREATE TABLE `api_ebet_gameinfo` (
  `bethistoryid` varchar(50) NOT NULL,
  `gametype` varchar(10) DEFAULT NULL,
  `gamename` varchar(20) DEFAULT NULL,
  `betmap` varchar(2000) DEFAULT NULL,
  `judgeresult` varchar(2000) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `payouttime` varchar(50) DEFAULT NULL,
  `gametime` varchar(50) DEFAULT NULL,
  `roundno` varchar(50) DEFAULT NULL,
  `subchannelid` varchar(10) DEFAULT NULL,
  `validbet` varchar(10) DEFAULT NULL,
  `payout` varchar(10) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `bankercards` varchar(2000) DEFAULT NULL,
  `tigercard` varchar(2000) DEFAULT NULL,
  `dragoncard` varchar(2000) DEFAULT NULL,
  `numbercard` varchar(2000) DEFAULT NULL,
  `alldices` varchar(2000) DEFAULT NULL,
  `playercards` varchar(2000) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  PRIMARY KEY (`bethistoryid`),
  KEY `api_ebet_gameinfo_ix1` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_ebet_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_eibc_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_eibc_gameinfo`;
CREATE TABLE `api_eibc_gameinfo` (
  `transid` varchar(50) NOT NULL DEFAULT '',
  `playername` varchar(50) DEFAULT NULL,
  `transactiontime` varchar(30) DEFAULT NULL,
  `matchid` varchar(20) DEFAULT NULL,
  `leagueid` varchar(20) DEFAULT NULL,
  `leaguename` varchar(1000) DEFAULT NULL,
  `sporttype` varchar(20) DEFAULT NULL,
  `awayid` varchar(20) DEFAULT NULL,
  `awayidname` varchar(1000) DEFAULT NULL,
  `homeid` varchar(20) DEFAULT NULL,
  `homeidname` varchar(1000) DEFAULT NULL,
  `matchdatetime` varchar(50) DEFAULT NULL,
  `bettype` varchar(20) DEFAULT NULL,
  `parlayrefno` varchar(20) DEFAULT NULL,
  `betteam` varchar(100) DEFAULT NULL,
  `hdp` varchar(20) DEFAULT NULL,
  `awayhdp` varchar(20) DEFAULT NULL,
  `homehdp` varchar(20) DEFAULT NULL,
  `odds` varchar(20) DEFAULT NULL,
  `oddstype` varchar(20) DEFAULT NULL,
  `awayscore` varchar(20) DEFAULT NULL,
  `homescore` varchar(20) DEFAULT NULL,
  `islive` varchar(20) DEFAULT NULL,
  `lastballno` varchar(20) DEFAULT NULL,
  `ticketstatus` varchar(20) DEFAULT NULL,
  `stake` varchar(20) DEFAULT NULL,
  `winloseamount` varchar(20) DEFAULT NULL,
  `winlostdatetime` varchar(30) DEFAULT NULL,
  `currency` varchar(20) DEFAULT NULL,
  `versionkey` varchar(20) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `nettime` datetime DEFAULT NULL,
  PRIMARY KEY (`transid`),
  KEY `index1` (`playername`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_eibc_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_gametype
-- ----------------------------
DROP TABLE IF EXISTS `api_gametype`;
CREATE TABLE `api_gametype` (
  `gametype_id` varchar(32) NOT NULL,
  `gametype_name` varchar(20) DEFAULT NULL,
  `gametype_code` varchar(8) DEFAULT NULL,
  `gametype_state` tinyint(1) DEFAULT NULL,
  `gametype_createtime` datetime DEFAULT NULL,
  `gametype_createuser` varchar(12) DEFAULT NULL,
  `gametype_remarks` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`gametype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_gametype
-- ----------------------------

-- ----------------------------
-- Table structure for api_gb_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_gb_gameinfo`;
CREATE TABLE `api_gb_gameinfo` (
  `settleid` varchar(20) NOT NULL,
  `betid` varchar(20) DEFAULT NULL,
  `betgrpno` varchar(30) DEFAULT NULL,
  `tpcode` varchar(20) DEFAULT NULL,
  `gbsn` varchar(20) DEFAULT NULL,
  `memberid` varchar(20) DEFAULT NULL,
  `curcode` varchar(20) DEFAULT NULL,
  `betdt` varchar(30) DEFAULT NULL,
  `bettype` varchar(20) DEFAULT NULL,
  `bettypeparam1` varchar(20) DEFAULT NULL,
  `bettypeparam2` varchar(20) DEFAULT NULL,
  `wintype` varchar(20) DEFAULT NULL,
  `hxmguid` varchar(20) DEFAULT NULL,
  `initbetamt` varchar(20) DEFAULT NULL,
  `realbetamt` varchar(20) DEFAULT NULL,
  `holdingamt` varchar(20) DEFAULT NULL,
  `initbetrate` varchar(20) DEFAULT NULL,
  `realbetrate` varchar(20) DEFAULT NULL,
  `prewinamt` varchar(20) DEFAULT NULL,
  `betresult` varchar(20) DEFAULT NULL,
  `wlamt` varchar(20) DEFAULT NULL,
  `refundbetamt` varchar(20) DEFAULT NULL,
  `ticketbetamt` varchar(20) DEFAULT NULL,
  `ticketresult` varchar(20) DEFAULT NULL,
  `ticketwlamt` varchar(20) DEFAULT NULL,
  `settledt` varchar(30) DEFAULT NULL,
  `kenolist` text,
  `lottolist` text,
  `ssclist` text,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `pkxlist` text,
  PRIMARY KEY (`settleid`),
  KEY `api_gb_gameinfo_ix1` (`memberid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_gb_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_ggp_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_ggp_gameinfo`;
CREATE TABLE `api_ggp_gameinfo` (
  `lsh` varchar(36) NOT NULL,
  `gamedate` varchar(10) NOT NULL,
  `username` varchar(50) NOT NULL DEFAULT '',
  `ngr` varchar(10) NOT NULL,
  PRIMARY KEY (`lsh`),
  UNIQUE KEY `index1` (`gamedate`,`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_ggp_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_gg_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_gg_gameinfo`;
CREATE TABLE `api_gg_gameinfo` (
  `autoid` bigint(20) NOT NULL DEFAULT '0' COMMENT '游戏编码',
  `gameId` varchar(10) DEFAULT NULL COMMENT '游戏编码',
  `cuuency` varchar(10) DEFAULT NULL COMMENT '货币',
  `linkId` varchar(20) DEFAULT NULL COMMENT '局号',
  `accountno` varchar(20) DEFAULT NULL COMMENT '用户名',
  `betmoney` double DEFAULT NULL COMMENT '投注金额',
  `netmoney` double DEFAULT NULL COMMENT '输赢',
  `bettime` datetime DEFAULT NULL COMMENT '投注时间',
  `createtime` datetime DEFAULT NULL COMMENT '创建记录时间',
  `Platformflag` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`autoid`),
  KEY `api_gg_gameinfo_ix1` (`accountno`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_gg_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_hab_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_hab_gameinfo`;
CREATE TABLE `api_hab_gameinfo` (
  `friendlygameinstanceid` varchar(36) NOT NULL,
  `playerid` varchar(36) DEFAULT NULL,
  `brandid` varchar(36) DEFAULT NULL,
  `username` varchar(36) DEFAULT NULL,
  `brandgameid` varchar(36) DEFAULT NULL,
  `gamekeyname` varchar(36) DEFAULT NULL,
  `gametypeid` varchar(36) DEFAULT NULL,
  `dtstarted` datetime DEFAULT NULL,
  `dtcompleted` datetime DEFAULT NULL,
  `gameinstanceid` varchar(36) DEFAULT NULL,
  `stake` double DEFAULT NULL,
  `payout` double DEFAULT NULL,
  `jackpotwin` double DEFAULT NULL,
  `jackpotcontribution` double DEFAULT NULL,
  `currencycode` varchar(10) DEFAULT NULL,
  `channeltypeid` varchar(10) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  PRIMARY KEY (`friendlygameinstanceid`),
  KEY `index_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_hab_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_ibc_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_ibc_gameinfo`;
CREATE TABLE `api_ibc_gameinfo` (
  `ibc_rowguid` varchar(100) NOT NULL,
  `ibc_ballid` varchar(100) DEFAULT NULL,
  `ibc_balltime` datetime DEFAULT NULL,
  `ibc_content` text,
  `ibc_curpl` varchar(20) DEFAULT NULL,
  `ibc_ds` varchar(100) DEFAULT NULL,
  `ibc_dxc` varchar(100) DEFAULT NULL,
  `ibc_isbk` varchar(100) DEFAULT NULL,
  `ibc_iscancel` varchar(20) DEFAULT NULL,
  `ibc_isdanger` varchar(20) DEFAULT NULL,
  `ibc_isjs` varchar(20) DEFAULT NULL,
  `ibc_lose` double(11,2) DEFAULT NULL,
  `ibc_matchid` varchar(100) DEFAULT NULL,
  `ibc_moneyrate` varchar(100) DEFAULT NULL,
  `ibc_orderid` varchar(100) DEFAULT NULL,
  `ibc_recard` varchar(100) DEFAULT NULL,
  `ibc_result` varchar(100) DEFAULT NULL,
  `ibc_rqc` varchar(100) DEFAULT NULL,
  `ibc_rqteam` varchar(100) DEFAULT NULL,
  `ibc_sportid` varchar(100) DEFAULT NULL,
  `ibc_tballtime` varchar(32) DEFAULT NULL,
  `ibc_thisdate` varchar(32) DEFAULT NULL,
  `ibc_truewin` varchar(100) DEFAULT NULL,
  `ibc_tzip` varchar(100) DEFAULT NULL,
  `ibc_tzmoney` double(11,2) DEFAULT NULL,
  `ibc_tzteam` varchar(100) DEFAULT NULL,
  `ibc_tztype` varchar(100) DEFAULT NULL,
  `ibc_updatetime` datetime DEFAULT NULL,
  `ibc_username` varchar(100) DEFAULT NULL,
  `ibc_win` double(11,2) DEFAULT NULL,
  `ibc_zdbf` varchar(100) DEFAULT NULL,
  `ibc_vendorid` varchar(100) DEFAULT NULL,
  `ibc_createtime` datetime DEFAULT NULL,
  `Platformflag` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ibc_rowguid`),
  KEY `ix_ibc_gameinfo_ibc_username` (`ibc_username`) USING BTREE,
  KEY `api_ibc_gameinfo_ix2` (`ibc_balltime`) USING BTREE,
  KEY `api_ibc_gameinfo_ix4` (`ibc_createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_ibc_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_idn2_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_idn2_gameinfo`;
CREATE TABLE `api_idn2_gameinfo` (
  `lsh` varchar(36) NOT NULL,
  `turnoverdate` datetime NOT NULL,
  `userid` varchar(50) NOT NULL,
  `totalturnover` varchar(50) DEFAULT NULL,
  `turnoverpoker` varchar(50) DEFAULT NULL,
  `turnoverdomino` varchar(50) DEFAULT NULL,
  `turnoverceme` varchar(50) DEFAULT NULL,
  `turnoverblackjack` varchar(50) DEFAULT NULL,
  `turnovercapsa` varchar(50) DEFAULT NULL,
  `turnoverlivepoker` varchar(50) DEFAULT NULL,
  `texaspoker` varchar(50) DEFAULT NULL,
  `domino` varchar(50) DEFAULT NULL,
  `ceme` varchar(50) DEFAULT NULL,
  `blackjack` varchar(50) DEFAULT NULL,
  `capsa` varchar(50) DEFAULT NULL,
  `livepoker` varchar(50) DEFAULT NULL,
  `pokertournament` varchar(50) DEFAULT NULL,
  `agentcommission` varchar(50) DEFAULT NULL,
  `agentbill` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`turnoverdate`,`userid`),
  KEY `index1` (`lsh`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_idn2_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_idn_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_idn_gameinfo`;
CREATE TABLE `api_idn_gameinfo` (
  `transactionno` varchar(50) NOT NULL,
  `tableno` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `betdate` varchar(50) DEFAULT NULL,
  `game` varchar(50) DEFAULT NULL,
  `bettable` varchar(50) DEFAULT NULL,
  `periode` varchar(50) DEFAULT NULL,
  `room` varchar(50) DEFAULT NULL,
  `bet` varchar(20) DEFAULT NULL,
  `currbet` varchar(50) DEFAULT NULL,
  `rbet` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `card` varchar(50) DEFAULT NULL,
  `hand` varchar(50) DEFAULT NULL,
  `prize` varchar(50) DEFAULT NULL,
  `curr` varchar(50) DEFAULT NULL,
  `currplayer` varchar(50) DEFAULT NULL,
  `curramount` varchar(50) DEFAULT NULL,
  `amount` varchar(50) DEFAULT NULL,
  `total` varchar(50) DEFAULT NULL,
  `agentcomission` varchar(50) DEFAULT NULL,
  `agentbill` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  PRIMARY KEY (`transactionno`),
  KEY `api_idn_gameinfo_ix1` (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_idn_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_im_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_im_gameinfo`;
CREATE TABLE `api_im_gameinfo` (
  `betid` varchar(50) NOT NULL,
  `providername` varchar(50) DEFAULT NULL,
  `gameid` varchar(50) DEFAULT NULL,
  `wagercreationdatetime` varchar(50) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `playerid` varchar(50) DEFAULT NULL,
  `stakeamount` double(50,0) DEFAULT NULL,
  `memberexposure` double(50,0) DEFAULT NULL,
  `payoutamount` double(50,0) DEFAULT NULL,
  `winloss` double(50,0) DEFAULT NULL,
  `oddstype` varchar(50) DEFAULT NULL,
  `wagertype` varchar(50) DEFAULT NULL,
  `platform` varchar(50) DEFAULT NULL,
  `issettled` varchar(50) DEFAULT NULL,
  `isconfirmed` varchar(50) DEFAULT NULL,
  `iscancelled` varchar(50) DEFAULT NULL,
  `bettradestatus` varchar(50) DEFAULT NULL,
  `bettradecommission` varchar(50) DEFAULT NULL,
  `bettradebuybackamount` varchar(50) DEFAULT NULL,
  `combotype` varchar(50) DEFAULT NULL,
  `lastupdateddate` varchar(50) DEFAULT NULL,
  `detailitems` text,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `nettime` datetime DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `platformflag` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`betid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_im_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_jdb_file
-- ----------------------------
DROP TABLE IF EXISTS `api_jdb_file`;
CREATE TABLE `api_jdb_file` (
  `lsh` char(32) NOT NULL COMMENT '流水号，主键，file值的MD5',
  `parent` varchar(50) NOT NULL COMMENT '上级账号',
  `date` char(8) NOT NULL COMMENT '日期',
  `file` varchar(100) NOT NULL COMMENT '文件路径',
  `times` bigint(20) NOT NULL COMMENT '插入时间，时间戳13位',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '文件解析状态：0-未解析 1-已解析',
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='JDB游戏数据FTP文件列表';

-- ----------------------------
-- Records of api_jdb_file
-- ----------------------------

-- ----------------------------
-- Table structure for api_jdb_ftp
-- ----------------------------
DROP TABLE IF EXISTS `api_jdb_ftp`;
CREATE TABLE `api_jdb_ftp` (
  `configid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `ftpname` varchar(20) NOT NULL COMMENT 'FTP登录账号',
  `ftppswd` varchar(30) NOT NULL COMMENT 'FTP登录密码',
  `ftpip` char(15) NOT NULL COMMENT 'FTP登录地址',
  `ftpport` int(11) NOT NULL COMMENT 'FTP登录端口',
  `datefolder` char(8) DEFAULT NULL COMMENT '上一次下载的文件目录，下次执行会+1',
  `endfolder` char(8) DEFAULT NULL COMMENT '结束下载的日期',
  `localfolder` varchar(20) DEFAULT 'D:/jdb168' COMMENT '本地存储文件的主文件夹，生成文件路径${localfolder}/${ftpname}/${datefolder}/gamename/filename',
  `updatetime` datetime DEFAULT NULL COMMENT '上一次完成下载的时间',
  `lastnum` int(11) DEFAULT '0' COMMENT '上一次下载的数量',
  `totalnum` int(11) DEFAULT '0' COMMENT '下载总量',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：1-正常，0-停止',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`configid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='JDB168 FTP配置信息';

-- ----------------------------
-- Records of api_jdb_ftp
-- ----------------------------

-- ----------------------------
-- Table structure for api_jdb_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_jdb_gameinfo`;
CREATE TABLE `api_jdb_gameinfo` (
  `seqNo` bigint(20) NOT NULL COMMENT '游戏序号，主键',
  `playerId` varchar(19) NOT NULL COMMENT '玩家账号',
  `mtype` int(11) DEFAULT NULL COMMENT '机台类型',
  `gameDate` char(19) DEFAULT NULL COMMENT '游戏时间',
  `bet` double DEFAULT NULL COMMENT '押注金额',
  `gambleBet` double DEFAULT NULL COMMENT '博取游戏押注金额',
  `win` double DEFAULT NULL COMMENT '游戏输赢',
  `total` double DEFAULT NULL COMMENT '总输赢',
  `currency` char(2) DEFAULT NULL COMMENT '货币编码',
  `denom` double DEFAULT NULL COMMENT '投注面额',
  `lastModifyTime` char(19) DEFAULT NULL COMMENT '最后修改时间',
  `playerIp` char(15) DEFAULT NULL COMMENT '玩家IP',
  `clientType` varchar(20) DEFAULT NULL COMMENT '客户端类型',
  `gType` int(11) DEFAULT NULL COMMENT '游戏类型：0-老虎机，7-捕鱼机，9-水果机',
  `hasGamble` int(11) DEFAULT NULL COMMENT '是否博取游戏：0-否，1-是【老虎鱼&水果机】',
  `hasBonusGame` int(11) DEFAULT NULL COMMENT '是否奖金游戏：0-否，1-是【水果机专属】',
  `hasFreegame` int(11) DEFAULT NULL COMMENT '是否免费游戏：0-否，1-是【老虎机专属】',
  `roomType` int(11) DEFAULT NULL COMMENT '捕鱼机房间类型：0-欢乐区，1-富豪区【捕鱼机专属】',
  `systemTakeWin` int(11) DEFAULT NULL COMMENT '标记该笔为游戏中断线，由系统结算：0-否，1-是【老虎机专属】',
  `jackpot` double DEFAULT NULL COMMENT '赢得彩金金额【老虎机专属】',
  `jackpotContribute` double DEFAULT NULL COMMENT '彩金贡献值【老虎机专属】',
  `beforeBalance` double DEFAULT NULL COMMENT '进场金额【捕鱼机专属】',
  `afterBalance` double DEFAULT NULL COMMENT '离场金额【捕鱼机专属】',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `bettime` datetime DEFAULT NULL COMMENT '投注时间',
  `betmoney` double DEFAULT NULL COMMENT '投注金额',
  `netmoney` double DEFAULT NULL COMMENT '输赢金额',
  PRIMARY KEY (`seqNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='JDB168接口游戏数据';

-- ----------------------------
-- Records of api_jdb_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_login_log
-- ----------------------------
DROP TABLE IF EXISTS `api_login_log`;
CREATE TABLE `api_login_log` (
  `loginlog_id` varchar(32) NOT NULL DEFAULT '',
  `loginlog_name` varchar(20) DEFAULT NULL,
  `loginlog_ip` varchar(32) DEFAULT NULL,
  `loginlog_createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`loginlog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for api_logmsg
-- ----------------------------
DROP TABLE IF EXISTS `api_logmsg`;
CREATE TABLE `api_logmsg` (
  `log_id` varchar(32) NOT NULL,
  `platform_id` varchar(32) DEFAULT NULL,
  `log_createtime` datetime DEFAULT NULL,
  `log_type` varchar(20) DEFAULT NULL,
  `log_result` text,
  `log_state` varchar(15) DEFAULT NULL,
  `log_gametype` varchar(20) DEFAULT NULL,
  `log_username` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `FK_Relationship_8` (`platform_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_logmsg
-- ----------------------------

-- ----------------------------
-- Table structure for api_m88_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_m88_gameinfo`;
CREATE TABLE `api_m88_gameinfo` (
  `transid` varchar(36) NOT NULL,
  `memberid` varchar(36) DEFAULT NULL,
  `operatorid` varchar(50) DEFAULT NULL,
  `sitecode` varchar(36) DEFAULT NULL,
  `leagueid` varchar(36) DEFAULT NULL,
  `homeid` varchar(36) DEFAULT NULL,
  `awayid` varchar(36) DEFAULT NULL,
  `matchdatetime` varchar(36) DEFAULT NULL,
  `bettype` varchar(36) DEFAULT NULL,
  `parlayrefno` varchar(36) DEFAULT NULL,
  `odds` varchar(36) DEFAULT NULL,
  `currency` varchar(36) DEFAULT NULL,
  `stake` varchar(36) DEFAULT NULL,
  `winlostamount` varchar(36) DEFAULT NULL,
  `transactiontime` varchar(36) DEFAULT NULL,
  `ticketstatus` varchar(36) DEFAULT NULL,
  `versionkey` varchar(36) DEFAULT NULL,
  `winlostdatetime` varchar(36) DEFAULT NULL,
  `oddstype` varchar(36) DEFAULT NULL,
  `sportstype` varchar(36) DEFAULT NULL,
  `betteam` varchar(255) DEFAULT NULL,
  `homehdp` varchar(36) DEFAULT NULL,
  `awayhdp` varchar(36) DEFAULT NULL,
  `matchid` varchar(36) DEFAULT NULL,
  `islive` varchar(36) DEFAULT NULL,
  `homescore` varchar(36) DEFAULT NULL,
  `awayscore` varchar(36) DEFAULT NULL,
  `choicecode` varchar(255) DEFAULT NULL,
  `choicename` varchar(255) DEFAULT NULL,
  `txntype` varchar(36) DEFAULT NULL,
  `lastupdate` varchar(36) DEFAULT NULL,
  `leaguename` varchar(255) DEFAULT NULL,
  `homename` varchar(255) DEFAULT NULL,
  `awayname` varchar(255) DEFAULT NULL,
  `sportname` varchar(255) DEFAULT NULL,
  `oddsname` varchar(255) DEFAULT NULL,
  `bettypename` varchar(255) DEFAULT NULL,
  `winloststatus` varchar(36) DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `nettime` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`transid`),
  KEY `api_m88_gameinfo_ix1` (`memberid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_m88_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_mg_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_mg_gameinfo`;
CREATE TABLE `api_mg_gameinfo` (
  `mg_transId` varchar(50) NOT NULL COMMENT '????',
  `mg_key` varchar(50) DEFAULT NULL COMMENT '????(????)',
  `mg_colId` varchar(50) DEFAULT NULL COMMENT '???????(????)',
  `mg_agentId` varchar(50) DEFAULT NULL COMMENT '????',
  `mg_mbrId` varchar(50) DEFAULT NULL COMMENT '????',
  `mg_mbrCode` varchar(50) DEFAULT NULL COMMENT '????',
  `mg_gameId` varchar(50) DEFAULT NULL COMMENT '????',
  `mg_transType` varchar(50) DEFAULT NULL COMMENT '?????[?? -> "bet", ? -> "win", ?? -> "refund"]',
  `mg_transTime` varchar(50) DEFAULT NULL COMMENT '????????UTC+0???',
  `mg_mgsGameId` varchar(50) DEFAULT NULL COMMENT 'MG ???????',
  `mg_mgsActionId` varchar(50) DEFAULT NULL COMMENT 'MG ????????',
  `mg_amnt` varchar(50) DEFAULT NULL COMMENT '?????(????????????????)',
  `mg_clrngAmnt` varchar(50) DEFAULT NULL COMMENT '?????(????????????????)',
  `mg_balance` varchar(50) DEFAULT NULL COMMENT '??????',
  `mg_refTransId` varchar(50) DEFAULT NULL COMMENT '???????? ??????????, ???????????????transId?',
  `mg_refTransType` varchar(50) DEFAULT NULL COMMENT '?????????. [?? -> "bet", ? -> "win"]',
  `mg_win` varchar(50) DEFAULT NULL COMMENT '??????',
  `mg_createtime` datetime DEFAULT NULL COMMENT '????',
  `Platformflag` varchar(50) DEFAULT NULL COMMENT '????',
  PRIMARY KEY (`mg_transId`),
  KEY `api_mg_gameinfo_ix1` (`mg_createtime`) USING BTREE,
  KEY `api_mg_gameinfo_ix2` (`mg_mbrId`,`mg_gameId`,`mg_mgsGameId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='MG?????';

-- ----------------------------
-- Records of api_mg_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_nhq_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_nhq_gameinfo`;
CREATE TABLE `api_nhq_gameinfo` (
  `BettingCredits` double(15,2) DEFAULT NULL,
  `PreCreditsPoint` double(20,2) DEFAULT NULL,
  `GameResult` text,
  `GameRoomName` varchar(50) DEFAULT NULL,
  `AgentAccount` varchar(20) DEFAULT NULL,
  `GamblingCode` varchar(32) DEFAULT NULL,
  `AfterPayoutCredits` double(20,2) DEFAULT NULL,
  `UserAccount` varchar(20) DEFAULT NULL,
  `GameType` varchar(5) DEFAULT NULL,
  `BettingDate` datetime DEFAULT NULL,
  `BettingNO` varchar(20) DEFAULT '',
  `DealerName` varchar(100) DEFAULT NULL,
  `GameName` varchar(20) DEFAULT NULL,
  `SetGameNo` varchar(20) DEFAULT NULL,
  `IsPayout` tinyint(4) DEFAULT NULL,
  `ParentUserID` varchar(10) DEFAULT NULL,
  `WinningCredits` double(15,2) DEFAULT NULL,
  `BettingPoint` varchar(20) DEFAULT NULL,
  `TableName` varchar(20) DEFAULT NULL,
  `TrackIP` varchar(30) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `WashCodeCredits` double(20,2) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `BettingID` varchar(32) NOT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`BettingID`),
  KEY `api_nhq_gameinfo_ix1` (`UserAccount`) USING BTREE,
  KEY `api_nhq_gameinfo_ix2` (`BettingDate`) USING BTREE,
  KEY `api_nhq_gameinfo_ix3` (`CreateTime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_nhq_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_platform
-- ----------------------------
DROP TABLE IF EXISTS `api_platform`;
CREATE TABLE `api_platform` (
  `platform_id` varchar(32) NOT NULL,
  `platform_name` varchar(20) DEFAULT NULL,
  `platform_deskey` varchar(8) DEFAULT NULL,
  `platform_md5key` varchar(8) DEFAULT NULL,
  `platform_createtime` datetime DEFAULT NULL,
  `platform_createuser` varchar(12) DEFAULT NULL,
  `platform_username` varchar(12) DEFAULT NULL,
  `platform_password` varchar(32) DEFAULT NULL,
  `platform_remarks` varchar(500) DEFAULT NULL,
  `platform_ip` varchar(500) DEFAULT NULL,
  `platform_state` tinyint(1) DEFAULT NULL,
  `platform_type` varchar(12) DEFAULT NULL,
  `platform_parentid` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_platform
-- ----------------------------

-- ----------------------------
-- Table structure for api_platform_money
-- ----------------------------
DROP TABLE IF EXISTS `api_platform_money`;
CREATE TABLE `api_platform_money` (
  `money_id` varchar(32) NOT NULL,
  `platform_id` varchar(32) DEFAULT NULL,
  `money_money` decimal(20,2) DEFAULT NULL,
  `money_gametype` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`money_id`),
  KEY `FK_Relationship_6` (`platform_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_platform_money
-- ----------------------------

-- ----------------------------
-- Table structure for api_platform_moneyinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_platform_moneyinfo`;
CREATE TABLE `api_platform_moneyinfo` (
  `pmoney_id` varchar(32) NOT NULL,
  `platform_id` varchar(32) DEFAULT NULL,
  `pmoney_money` decimal(20,2) DEFAULT NULL,
  `pmoney_gametype` varchar(8) DEFAULT NULL,
  `pmoney_createtime` datetime DEFAULT NULL,
  `pmoney_createuser` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`pmoney_id`),
  KEY `FK_Relationship_7` (`platform_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_platform_moneyinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_platform_webservice
-- ----------------------------
DROP TABLE IF EXISTS `api_platform_webservice`;
CREATE TABLE `api_platform_webservice` (
  `webservice_id` varchar(32) NOT NULL,
  `platform_id` varchar(32) DEFAULT NULL,
  `webservice_name` varchar(20) DEFAULT NULL,
  `webservice_password` varchar(32) DEFAULT NULL,
  `webservice_key` varchar(100) DEFAULT NULL,
  `webservice_key2` varchar(100) DEFAULT NULL,
  `webservice_gametype` varchar(8) DEFAULT NULL,
  `webservice_url` varchar(200) DEFAULT NULL,
  `webservice_url2` varchar(200) DEFAULT NULL,
  `webservice_state` tinyint(1) DEFAULT NULL,
  `webservice_createuser` varchar(12) DEFAULT NULL,
  `webservice_createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`webservice_id`),
  KEY `FK_Relationship_9` (`platform_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_platform_webservice
-- ----------------------------

-- ----------------------------
-- Table structure for api_ptgame
-- ----------------------------
DROP TABLE IF EXISTS `api_ptgame`;
CREATE TABLE `api_ptgame` (
  `code` varchar(20) NOT NULL DEFAULT '',
  `ename` varchar(200) DEFAULT NULL,
  `cname` varchar(200) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_ptgame
-- ----------------------------

-- ----------------------------
-- Table structure for api_pt_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_pt_gameinfo`;
CREATE TABLE `api_pt_gameinfo` (
  `pt_gamecode` varchar(32) NOT NULL,
  `pt_username` varchar(32) DEFAULT NULL,
  `pt_windowcode` varchar(32) DEFAULT NULL,
  `pt_gameid` varchar(32) DEFAULT NULL,
  `pt_gametype` varchar(32) DEFAULT NULL,
  `pt_gamename` varchar(200) DEFAULT NULL,
  `pt_bet` decimal(11,2) DEFAULT NULL,
  `pt_win` decimal(11,2) DEFAULT NULL,
  `pt_balance` decimal(11,2) DEFAULT NULL,
  `pt_gamedate` datetime DEFAULT NULL,
  `pt_info` varchar(1000) DEFAULT NULL,
  `pt_sessionid` varchar(32) DEFAULT NULL,
  `pt_progressivebet` varchar(32) DEFAULT NULL,
  `pt_progressivewin` varchar(32) DEFAULT NULL,
  `pt_currentbet` varchar(32) DEFAULT NULL,
  `pt_livenetwork` varchar(32) DEFAULT NULL,
  `pt_rnum` varchar(32) DEFAULT NULL,
  `pt_createtime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pt_gamecode`),
  KEY `ix_pt_gameinfo_pt_username` (`pt_username`) USING BTREE,
  KEY `ix_pt_gameinfo_pt_gamedate` (`pt_gamedate`) USING BTREE,
  KEY `api_pt_gameinfo_ix3` (`pt_createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_pt_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_qp_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_qp_gameinfo`;
CREATE TABLE `api_qp_gameinfo` (
  `TurnNumber` varchar(50) NOT NULL COMMENT '游戏局号',
  `ServerID` varchar(50) DEFAULT NULL COMMENT '游戏类型',
  `KindID` varchar(50) DEFAULT NULL COMMENT '房间类型',
  `RoomName` varchar(50) DEFAULT NULL COMMENT '游戏房间名称',
  `StartTime` varchar(50) DEFAULT NULL COMMENT '下注时间',
  `EndTime` varchar(50) DEFAULT NULL COMMENT '派彩时间',
  `Score` varchar(50) DEFAULT NULL COMMENT '投注金额',
  `TurnScore` varchar(50) DEFAULT NULL COMMENT '输赢',
  `Account` varchar(50) DEFAULT NULL COMMENT '玩家账号',
  `createtime` datetime DEFAULT NULL COMMENT '创建日期',
  `Platformflag` varchar(50) DEFAULT NULL COMMENT '标志',
  `Revenue` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`TurnNumber`),
  KEY `api_mg_gameinfo_ix1` (`createtime`) USING BTREE,
  KEY `api_qp_gameinfo_ix2` (`Account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='棋牌游戏表';

-- ----------------------------
-- Records of api_qp_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_qt_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_qt_gameinfo`;
CREATE TABLE `api_qt_gameinfo` (
  `id` varchar(36) NOT NULL DEFAULT '',
  `playergameroundid` varchar(36) DEFAULT NULL,
  `gameid` varchar(36) DEFAULT NULL,
  `amount` varchar(10) DEFAULT NULL,
  `balance` varchar(10) DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `gameprovider` varchar(36) DEFAULT NULL,
  `gtype` varchar(10) DEFAULT NULL,
  `gameclienttype` varchar(36) DEFAULT NULL,
  `gamecategory` varchar(36) DEFAULT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `playerdevice` varchar(36) DEFAULT NULL,
  `operatorid` varchar(36) DEFAULT NULL,
  `playerid` varchar(36) DEFAULT NULL,
  `wallettransactionid` varchar(36) DEFAULT NULL,
  `roundstatus` varchar(36) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index1` (`playergameroundid`) USING BTREE,
  KEY `api_qt_gameinfo_ix2` (`playerid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_qt_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_qwp_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_qwp_gameinfo`;
CREATE TABLE `api_qwp_gameinfo` (
  `TurnNumber` bigint(20) NOT NULL COMMENT '局号',
  `ServerId` int(11) NOT NULL COMMENT '房间Id',
  `KindId` int(11) NOT NULL COMMENT '游戏Id',
  `RoomName` varchar(100) DEFAULT NULL COMMENT '房间名称',
  `StartTime` datetime DEFAULT NULL COMMENT '开始时间',
  `EndTime` datetime DEFAULT NULL COMMENT '结束时间',
  `RecordTime` datetime DEFAULT NULL COMMENT '记录时间',
  `CardData` varchar(100) DEFAULT NULL COMMENT '牌型',
  `Account` varchar(50) DEFAULT NULL COMMENT '玩家账号',
  `Score` double DEFAULT NULL COMMENT '输赢',
  `TurnScore` double DEFAULT NULL COMMENT '底分',
  `Revenue` double DEFAULT NULL COMMENT '抽水',
  PRIMARY KEY (`TurnNumber`,`ServerId`,`KindId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='去玩棋牌接口游戏数据';

-- ----------------------------
-- Records of api_qwp_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_sa_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_sa_gameinfo`;
CREATE TABLE `api_sa_gameinfo` (
  `BetTime` datetime DEFAULT NULL,
  `PayoutTime` datetime DEFAULT NULL,
  `Username` varchar(20) DEFAULT NULL,
  `HostID` varchar(10) DEFAULT NULL,
  `GameID` varchar(32) DEFAULT NULL,
  `Round` varchar(10) DEFAULT NULL,
  `Sets` varchar(10) DEFAULT NULL,
  `BetID` varchar(32) NOT NULL DEFAULT '',
  `BetAmount` double(10,2) DEFAULT NULL,
  `ResultAmount` double(10,2) DEFAULT NULL,
  `GameType` varchar(15) DEFAULT NULL,
  `BetType` varchar(10) DEFAULT NULL,
  `BetSource` varchar(10) DEFAULT NULL,
  `State` varchar(10) DEFAULT NULL,
  `Detail` varchar(32) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  `validbet` double(10,2) DEFAULT '0.00',
  PRIMARY KEY (`BetID`),
  KEY `api_sa_gameinfo_ix1` (`BetTime`) USING BTREE,
  KEY `api_sa_gameinfo_ix2` (`PayoutTime`) USING BTREE,
  KEY `api_sa_gameinfo_ix3` (`Username`) USING BTREE,
  KEY `api_sa_gameinfo_ix4` (`createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_sa_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_sgs_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_sgs_gameinfo`;
CREATE TABLE `api_sgs_gameinfo` (
  `ugsbetid` varchar(50) NOT NULL,
  `txid` varchar(50) DEFAULT NULL,
  `betid` varchar(50) DEFAULT NULL,
  `beton` datetime DEFAULT NULL,
  `betclosedon` datetime DEFAULT NULL,
  `betupdatedon` datetime DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `roundid` varchar(50) DEFAULT NULL,
  `roundstatus` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `riskamt` double DEFAULT NULL,
  `winamt` double DEFAULT NULL,
  `winloss` double DEFAULT NULL,
  `beforebal` double DEFAULT NULL,
  `postbal` double DEFAULT NULL,
  `cur` varchar(10) DEFAULT NULL,
  `gameprovider` varchar(50) DEFAULT NULL,
  `gamename` varchar(50) DEFAULT NULL,
  `gameid` varchar(50) DEFAULT NULL,
  `platformtype` varchar(50) DEFAULT NULL,
  `ipaddress` varchar(50) DEFAULT NULL,
  `bettype` varchar(50) DEFAULT NULL,
  `playtype` varchar(50) DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `validmoney` double DEFAULT '0',
  PRIMARY KEY (`ugsbetid`),
  KEY `api_sgs_gameinfo_ix1` (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_sgs_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_solt_gametype
-- ----------------------------
DROP TABLE IF EXISTS `api_solt_gametype`;
CREATE TABLE `api_solt_gametype` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `biggametype` varchar(10) DEFAULT NULL,
  `enname` varchar(100) DEFAULT NULL,
  `cnname` varchar(100) DEFAULT NULL,
  `trname` varchar(100) DEFAULT NULL,
  `japname` varchar(100) DEFAULT NULL,
  `krname` varchar(100) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `category2` varchar(100) DEFAULT NULL,
  `category3` varchar(100) DEFAULT NULL,
  `imagename` varchar(100) DEFAULT NULL,
  `gamecodeweb` varchar(50) DEFAULT NULL,
  `gamecodeh5` varchar(50) DEFAULT NULL,
  `isweb` varchar(10) DEFAULT NULL,
  `ish5` varchar(10) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `stype` varchar(50) DEFAULT NULL,
  `ord` varchar(10) DEFAULT '999',
  PRIMARY KEY (`lsh`),
  KEY `api_solt_gametype_ix1` (`biggametype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_solt_gametype
-- ----------------------------

-- ----------------------------
-- Table structure for api_solt_gametype_enterprise
-- ----------------------------
DROP TABLE IF EXISTS `api_solt_gametype_enterprise`;
CREATE TABLE `api_solt_gametype_enterprise` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `enterprisecode` char(8) DEFAULT NULL,
  `biggametype` varchar(10) DEFAULT NULL,
  `gametype_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_solt_gametype_enterprise
-- ----------------------------

-- ----------------------------
-- Table structure for api_tag_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_tag_gameinfo`;
CREATE TABLE `api_tag_gameinfo` (
  `billNo` varchar(32) NOT NULL,
  `playerName` varchar(32) DEFAULT NULL,
  `agentCode` varchar(32) DEFAULT NULL,
  `gameCode` varchar(32) DEFAULT NULL,
  `netAmount` decimal(15,2) DEFAULT NULL,
  `betTime` datetime DEFAULT NULL,
  `gameType` varchar(32) DEFAULT NULL,
  `betAmount` decimal(15,2) DEFAULT NULL,
  `validBetAmount` decimal(8,2) DEFAULT NULL,
  `flag` varchar(5) DEFAULT NULL,
  `playType` varchar(50) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `tableCode` varchar(32) DEFAULT NULL,
  `loginIP` varchar(32) DEFAULT NULL,
  `recalcuTime` datetime DEFAULT NULL,
  `platformId` varchar(32) DEFAULT NULL,
  `platformType` varchar(32) DEFAULT NULL,
  `stringex` varchar(32) DEFAULT NULL,
  `remark` text,
  `round` varchar(32) DEFAULT NULL,
  `result` text,
  `beforeCredit` decimal(15,2) DEFAULT NULL,
  `deviceType` varchar(32) DEFAULT NULL,
  `betAmountBase` decimal(15,2) DEFAULT NULL,
  `betAmountBonus` decimal(15,2) DEFAULT NULL,
  `netAmountBase` decimal(15,2) DEFAULT NULL,
  `netAmountBonus` decimal(15,2) DEFAULT NULL,
  `slottype` varchar(32) DEFAULT NULL,
  `mainbillno` varchar(32) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`billNo`),
  KEY `api_tag_gameinfo_ix1` (`playerName`) USING BTREE,
  KEY `api_tag_gameinfo_ix2` (`betTime`) USING BTREE,
  KEY `api_tag_gameinfo_ix3` (`createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_tag_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_tag_xml_record
-- ----------------------------
DROP TABLE IF EXISTS `api_tag_xml_record`;
CREATE TABLE `api_tag_xml_record` (
  `agentcode` varchar(10) NOT NULL,
  `platformtype` varchar(10) NOT NULL COMMENT '平台类型：AGIN/HUNTER/XIN',
  `filenumber` bigint(12) NOT NULL,
  `xmltype` varchar(20) NOT NULL DEFAULT 'normal' COMMENT 'normal/lostAndfound',
  `filepath` varchar(100) NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '0=未处理 1=已解析',
  PRIMARY KEY (`agentcode`,`platformtype`,`filenumber`,`xmltype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_tag_xml_record
-- ----------------------------

-- ----------------------------
-- Table structure for api_tag_xml_timer
-- ----------------------------
DROP TABLE IF EXISTS `api_tag_xml_timer`;
CREATE TABLE `api_tag_xml_timer` (
  `agentcode` varchar(10) NOT NULL,
  `platformtype` varchar(10) NOT NULL COMMENT '平台类型：AGIN/HUNTER/XIN',
  `xmltype` varchar(20) NOT NULL COMMENT 'normal/lostAndfound',
  `updatetime` varchar(20) DEFAULT NULL COMMENT '确精到分钟',
  PRIMARY KEY (`agentcode`,`platformtype`,`xmltype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_tag_xml_timer
-- ----------------------------

-- ----------------------------
-- Table structure for api_tb_game
-- ----------------------------
DROP TABLE IF EXISTS `api_tb_game`;
CREATE TABLE `api_tb_game` (
  `GAME_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号，自动增长',
  `GAME_NAME` varchar(50) NOT NULL COMMENT '名称',
  PRIMARY KEY (`GAME_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='游戏表';

-- ----------------------------
-- Records of api_tb_game
-- ----------------------------
INSERT INTO `api_tb_game` VALUES ('1', '东方');
INSERT INTO `api_tb_game` VALUES ('2', '沙巴体育');
INSERT INTO `api_tb_game` VALUES ('3', '波音OG');
INSERT INTO `api_tb_game` VALUES ('4', '新环球');
INSERT INTO `api_tb_game` VALUES ('5', '沙龙');
INSERT INTO `api_tb_game` VALUES ('6', 'TAG');
INSERT INTO `api_tb_game` VALUES ('7', 'AV游戏');
INSERT INTO `api_tb_game` VALUES ('8', 'PT游戏');
INSERT INTO `api_tb_game` VALUES ('9', 'ZJ游戏');
INSERT INTO `api_tb_game` VALUES ('10', 'MG游戏');
INSERT INTO `api_tb_game` VALUES ('11', 'XCP游戏');
INSERT INTO `api_tb_game` VALUES ('12', 'TTG游戏');
INSERT INTO `api_tb_game` VALUES ('13', '棋牌游戏');
INSERT INTO `api_tb_game` VALUES ('14', '波音EVEB');
INSERT INTO `api_tb_game` VALUES ('15', '德州扑克');
INSERT INTO `api_tb_game` VALUES ('16', '游行天下GG');
INSERT INTO `api_tb_game` VALUES ('17', '申博SGS');
INSERT INTO `api_tb_game` VALUES ('18', 'IDN游戏');
INSERT INTO `api_tb_game` VALUES ('19', 'M88沙巴体育');
INSERT INTO `api_tb_game` VALUES ('20', 'HAB哈巴电子');
INSERT INTO `api_tb_game` VALUES ('21', 'QT电子');
INSERT INTO `api_tb_game` VALUES ('22', 'GB彩票');
INSERT INTO `api_tb_game` VALUES ('23', 'EBet');
INSERT INTO `api_tb_game` VALUES ('24', 'TGPlayer');
INSERT INTO `api_tb_game` VALUES ('25', 'GGPoker');
INSERT INTO `api_tb_game` VALUES ('26', 'WIN88');
INSERT INTO `api_tb_game` VALUES ('27', 'IBC沙巴体育');
INSERT INTO `api_tb_game` VALUES ('28', 'YoPLAY');
INSERT INTO `api_tb_game` VALUES ('30', 'IM体育');
INSERT INTO `api_tb_game` VALUES ('31', '去玩棋牌');
INSERT INTO `api_tb_game` VALUES ('32', 'JDB168');

-- ----------------------------
-- Table structure for api_tb_game_kind
-- ----------------------------
DROP TABLE IF EXISTS `api_tb_game_kind`;
CREATE TABLE `api_tb_game_kind` (
  `GAME_KIND_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号，自动增长',
  `GAME_ID` int(11) NOT NULL COMMENT '所属游戏编号',
  `GAME_KIND_NO` varchar(50) NOT NULL COMMENT '编码',
  `GAME_KIND_PARENT` int(11) NOT NULL DEFAULT '0' COMMENT '上级编号（默认为0，顶级）',
  `GAME_KIND_NAME` varchar(50) NOT NULL COMMENT '名称',
  PRIMARY KEY (`GAME_KIND_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='游戏种类开';

-- ----------------------------
-- Records of api_tb_game_kind
-- ----------------------------
INSERT INTO `api_tb_game_kind` VALUES ('1', '3', '1', '0', 'BB体育');
INSERT INTO `api_tb_game_kind` VALUES ('2', '3', '3', '0', '视讯');
INSERT INTO `api_tb_game_kind` VALUES ('3', '3', '5', '0', '机率');
INSERT INTO `api_tb_game_kind` VALUES ('4', '3', '12', '0', '彩票');
INSERT INTO `api_tb_game_kind` VALUES ('5', '3', '15', '0', '3D厅');
INSERT INTO `api_tb_game_kind` VALUES ('6', '3', '1', '5', '其它');
INSERT INTO `api_tb_game_kind` VALUES ('7', '3', '2', '5', '糖果派对');
INSERT INTO `api_tb_game_kind` VALUES ('8', '3', '3', '5', '连环夺宝');
INSERT INTO `api_tb_game_kind` VALUES ('9', '6', 'AGIN', '0', '真人');
INSERT INTO `api_tb_game_kind` VALUES ('10', '6', 'XIN', '0', '电子');
INSERT INTO `api_tb_game_kind` VALUES ('11', '6', 'HUNTER', '0', '捕鱼');
INSERT INTO `api_tb_game_kind` VALUES ('13', '28', 'YOPLAY', '0', 'YOPLAY');
INSERT INTO `api_tb_game_kind` VALUES ('14', '3', '5', '5', '糖果派對2 ');
INSERT INTO `api_tb_game_kind` VALUES ('15', '6', 'YOPLAY', '0', 'YOPLAY');

-- ----------------------------
-- Table structure for api_tb_game_type
-- ----------------------------
DROP TABLE IF EXISTS `api_tb_game_type`;
CREATE TABLE `api_tb_game_type` (
  `GAME_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号，自动增长',
  `GAME_ID` int(11) NOT NULL COMMENT '所属游戏编号',
  `GAME_TYPE_NAME` varchar(50) NOT NULL COMMENT '名称',
  `GAME_TYPE_DESC` varchar(50) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`GAME_TYPE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='游戏类型表';

-- ----------------------------
-- Records of api_tb_game_type
-- ----------------------------
INSERT INTO `api_tb_game_type` VALUES ('1', '3', 'LT', '六合彩');
INSERT INTO `api_tb_game_type` VALUES ('2', '3', 'BJ3D', '3D彩');
INSERT INTO `api_tb_game_type` VALUES ('3', '3', 'PL3D', '排列三');
INSERT INTO `api_tb_game_type` VALUES ('4', '3', 'BBPK', '波音PK3');
INSERT INTO `api_tb_game_type` VALUES ('5', '3', 'BB3D', '波音3D');
INSERT INTO `api_tb_game_type` VALUES ('6', '3', 'BBKN', '波音快乐彩');
INSERT INTO `api_tb_game_type` VALUES ('7', '3', 'BBRB', '波音滚球王');
INSERT INTO `api_tb_game_type` VALUES ('8', '3', 'SH3D', '上海时时乐');
INSERT INTO `api_tb_game_type` VALUES ('9', '3', 'CQSC', '重庆时时彩');
INSERT INTO `api_tb_game_type` VALUES ('10', '3', 'JXSC', '江西时时彩');
INSERT INTO `api_tb_game_type` VALUES ('11', '3', 'XJSC', '新疆时时彩');
INSERT INTO `api_tb_game_type` VALUES ('12', '3', 'CQSF', '重庆幸运农场');
INSERT INTO `api_tb_game_type` VALUES ('13', '3', 'GXSF', '广西十分彩');
INSERT INTO `api_tb_game_type` VALUES ('14', '3', 'GDSF', '广东十分彩');
INSERT INTO `api_tb_game_type` VALUES ('15', '3', 'TJSF', '天津十分彩');
INSERT INTO `api_tb_game_type` VALUES ('16', '3', 'BJPK', '北京PK拾');
INSERT INTO `api_tb_game_type` VALUES ('17', '3', 'BJKN', '北京快乐8');
INSERT INTO `api_tb_game_type` VALUES ('18', '3', 'CAKN', '加拿大卑斯');
INSERT INTO `api_tb_game_type` VALUES ('19', '3', 'AUKN', '澳大利亚卑斯');
INSERT INTO `api_tb_game_type` VALUES ('20', '3', 'GDE5', '广东11选5');
INSERT INTO `api_tb_game_type` VALUES ('21', '3', 'JXE5', '江西11选5');
INSERT INTO `api_tb_game_type` VALUES ('22', '3', 'SDE5', '山东十一运夺金');
INSERT INTO `api_tb_game_type` VALUES ('23', '3', 'CQWC', '重庆百变王牌');
INSERT INTO `api_tb_game_type` VALUES ('24', '3', 'JLQ3', '吉林快3');
INSERT INTO `api_tb_game_type` VALUES ('25', '3', 'JSQ3', '江苏快3');
INSERT INTO `api_tb_game_type` VALUES ('26', '3', 'AHQ3', '安徽快3');
INSERT INTO `api_tb_game_type` VALUES ('27', '3', 'RDPK', 'BB雷電PK');
INSERT INTO `api_tb_game_type` VALUES ('28', '3', 'LDDR', '梯子遊戲');
INSERT INTO `api_tb_game_type` VALUES ('29', '3', 'BCRA', 'BB百家彩票-A');
INSERT INTO `api_tb_game_type` VALUES ('30', '3', 'BCRB', 'BB百家彩票-B');
INSERT INTO `api_tb_game_type` VALUES ('31', '3', 'BCRC', 'BB百家彩票-C');
INSERT INTO `api_tb_game_type` VALUES ('32', '3', 'RCRD', 'BB百家彩票-D');
INSERT INTO `api_tb_game_type` VALUES ('33', '3', 'RCRE', 'BB百家彩票-E');

-- ----------------------------
-- Table structure for api_tb_max_log
-- ----------------------------
DROP TABLE IF EXISTS `api_tb_max_log`;
CREATE TABLE `api_tb_max_log` (
  `MAX_LOG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号，自动增长',
  `MAX_LOG_FLAG` varchar(50) DEFAULT NULL COMMENT '代理标志',
  `MAX_LOG_KIND` varchar(50) DEFAULT NULL COMMENT '游戏种类',
  `MAX_LOG_SUBKIND` varchar(50) DEFAULT NULL COMMENT '游戏子种类',
  `MAX_LOG_TYPE` varchar(50) DEFAULT NULL COMMENT '游戏类型',
  `MAX_LOG_VALUE` varchar(50) DEFAULT NULL COMMENT '最大值',
  PRIMARY KEY (`MAX_LOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='最大数据记录表';

-- ----------------------------
-- Records of api_tb_max_log
-- ----------------------------

-- ----------------------------
-- Table structure for api_tb_proxy
-- ----------------------------
DROP TABLE IF EXISTS `api_tb_proxy`;
CREATE TABLE `api_tb_proxy` (
  `PROXY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号，自动增长',
  `PROXY_NAME` varchar(50) NOT NULL COMMENT '名称',
  `PROXY_SITE` varchar(50) DEFAULT NULL COMMENT '网站',
  `PROXY_KEY1` varchar(50) DEFAULT NULL COMMENT '备选KEY1',
  `PROXY_KEY2` varchar(50) DEFAULT NULL COMMENT '备选KEY2',
  `PROXY_CODE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`PROXY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='代理表';

-- ----------------------------
-- Records of api_tb_proxy
-- ----------------------------
INSERT INTO `api_tb_proxy` VALUES ('4', 'HYLDWGJ88', '帝王国际（NHQ）', 'ahGToE66', '39f4SOMh', 'EN003A');
INSERT INTO `api_tb_proxy` VALUES ('7', 'R48_AGIN', '帝王国际（AG）', '21', 'xb.gdcapi.com', 'EN003A');
INSERT INTO `api_tb_proxy` VALUES ('15', 'SACNYHYI', '帝王国际（SA）', 'GgaIMaiNNtg', 'g9G16nTs', 'EN003A');
INSERT INTO `api_tb_proxy` VALUES ('19', 'VBETCNYHYL', '帝王国际（PT）', 'iQ3xuZrS', 'c:/p12/vbet.1114721.p12', 'EN003A');
INSERT INTO `api_tb_proxy` VALUES ('54', 'HYEGG88', '金蛋娱乐（NHQ）', 'gMUXdkE4', 'Bj9Y4ult', 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('65', 'dddf8', '金蛋娱乐（BBIN）', 'apivebet', null, 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('66', 'SACNYHYF', '金蛋娱乐（SA）', 'GgaIMaiNNtg', 'g9G16nTs', 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('68', 'HYFCNYA', '金蛋娱乐（MG）', '99852227', null, 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('72', 'OGCNYHYFF', '金蛋娱乐（OG）', '', null, 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('75', 'HYOLDBY', '博亚娱乐（NHQ）', 'MwiWGfDt', 'svooM9pS', 'EN003Y');
INSERT INTO `api_tb_proxy` VALUES ('76', 'T77_AGIN', '博亚娱乐（AG）', '21', 'xb.gdcapi.com', 'EN003Y');
INSERT INTO `api_tb_proxy` VALUES ('86', 'BY8ADMIN', '博亚娱乐（WIN88）', 'changeit', 'c:/p12/play.p12', 'EN003Y');
INSERT INTO `api_tb_proxy` VALUES ('87', 'ddby8', '博亚娱乐（BBIN）', 'apivebet', null, 'EN003Y');
INSERT INTO `api_tb_proxy` VALUES ('89', 'jintabet', '金蛋娱乐（GGP）', 'jintabet', 'rt8bp2ecj4d', 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('90', 'eBET1247', '金蛋娱乐（eBET）', '201', '1247', 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('91', 'HYECN', '金蛋娱乐（IBC）', 'HYECN', 'SKWENXKK2032SD1', 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('95', 'HYLCN', '帝王国际（IBC）', 'HYLCN', 'SKXGHS223SDXGS92J', 'EN003A');
INSERT INTO `api_tb_proxy` VALUES ('96', 'GB彩票914', '帝王国际（GB）', '914', '560522', 'EN003A');
INSERT INTO `api_tb_proxy` VALUES ('97', 'HYLCNYA', '帝王国际（MG）', '93980368', null, 'EN003A');
INSERT INTO `api_tb_proxy` VALUES ('98', 'GB彩票917', '博亚娱乐（GB）', '917', '848782', 'EN003Y');
INSERT INTO `api_tb_proxy` VALUES ('99', 'OGCNYHYL', '帝王国际（OG）', null, null, 'EN003A');
INSERT INTO `api_tb_proxy` VALUES ('100', 'GB彩票920', '金蛋娱乐（GB）', '920', '151234', 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('101', 'BK2_AGIN', '金蛋娱乐（AG）', '21', 'xb.gdcapi.com', 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('102', 'Y09', '金蛋娱乐（YOPLAY）', '21', 'xml.yoplay.com', 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('104', 'diwangguojiprod', '帝王国际（IM）', 'O9BPE3BUwBgfD8D44A8Ulx9sMpDTJfRa', null, 'EN003A');
INSERT INTO `api_tb_proxy` VALUES ('105', 'hygameadmin', 'HY自营（NHQ）', '6aAaqdrW', '1R9YI0vb', 'EN0040');
INSERT INTO `api_tb_proxy` VALUES ('106', 'HYNTTG', '金蛋娱乐（TTG）', null, null, 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('107', 'hqag', '帝王国际（JDB）', 'w73nxygercy9qdju', '4yscetx5gnsuuavk', 'EN003A');
INSERT INTO `api_tb_proxy` VALUES ('108', 'HBW_M88', '金蛋娱乐（M88）', null, 'D28C7DA7-5E73-4197-9D5A-311DC60023E2', 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('109', 'HYEADMIN', '金蛋娱乐（WIN88）', 'changeit', 'c:/p12/play.p12', 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('110', 'dwqwp', '帝王国际（QWP）', 'B0sWhycz4ybdIvVU8uxi79gm1PQl6Fza', '', 'EN003A');
INSERT INTO `api_tb_proxy` VALUES ('111', 'jtyl', '金蛋娱乐（QWP）', 'ax6QGShqV1jFc7yof17gcKfabUZkUtyi', null, 'EN003K');
INSERT INTO `api_tb_proxy` VALUES ('112', 'jintayuleprod', '金蛋娱乐（IM）', 'O4IF1PGpNDQd8WyUijUgj6MLupiJULCZ', null, 'EN003K');

-- ----------------------------
-- Table structure for api_tb_proxy_key
-- ----------------------------
DROP TABLE IF EXISTS `api_tb_proxy_key`;
CREATE TABLE `api_tb_proxy_key` (
  `PROXY_KEY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号，自动增长',
  `PROXY_ID` int(11) NOT NULL COMMENT '所属代理编号',
  `GAME_ID` int(11) NOT NULL COMMENT '所属游戏游戏编号',
  `PROXY_MD5_KEY` varchar(2000) NOT NULL COMMENT 'MD5密钥',
  `PROXY_API_URL` varchar(200) NOT NULL COMMENT '接口URL',
  PRIMARY KEY (`PROXY_KEY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8 COMMENT='代理密钥表';

-- ----------------------------
-- Records of api_tb_proxy_key
-- ----------------------------
INSERT INTO `api_tb_proxy_key` VALUES ('4', '4', '4', 'rld2fQei', 'http://www.hy95.net/web');
INSERT INTO `api_tb_proxy_key` VALUES ('7', '7', '6', 'R48.diwang', 'b&JtGS4gcG');
INSERT INTO `api_tb_proxy_key` VALUES ('16', '15', '5', '09607A45CCC343DCAA316BA35F017296', 'http://api.sa-gaming.net/api/api.aspx');
INSERT INTO `api_tb_proxy_key` VALUES ('20', '19', '8', '89dc8ff432ed6faaae48838443dc90f069c9917c1ac4338cf118939096b5fc963606df58f94322d6fbada2bc07c05ef8add46d5962eab64b8efacfb280c3a2ec', 'https://kioskpublicapi.redhorse88.com/customreport/getdata/reportname/PlayerGames');
INSERT INTO `api_tb_proxy_key` VALUES ('61', '54', '4', 'em5d8Rty', 'http://www.hy95.net/web');
INSERT INTO `api_tb_proxy_key` VALUES ('72', '65', '3', 'oxC73Q6dq', 'http://linkapi.77777f.com/app/WebService/JSON/display.php/BetRecord');
INSERT INTO `api_tb_proxy_key` VALUES ('73', '66', '5', 'F6D7ED442C874CF699455F1572026927', 'http://api.sa-gaming.net/api/api.aspx');
INSERT INTO `api_tb_proxy_key` VALUES ('75', '68', '10', 'jinta8800', 'https://ag.adminserv88.com/lps');
INSERT INTO `api_tb_proxy_key` VALUES ('77', '72', '1', 'hq@-@688*$-$*!&88$dshxeh', 'http://cashapi.dg20mu.com/cashapi/getdata.aspx');
INSERT INTO `api_tb_proxy_key` VALUES ('80', '75', '4', 'ymGrlueN', 'http://www.hy95.net/web');
INSERT INTO `api_tb_proxy_key` VALUES ('81', '76', '6', 'T77.BYBET', '&8RqRnj7AG');
INSERT INTO `api_tb_proxy_key` VALUES ('91', '86', '26', '2da74c2a2338a536644995d0b716fa6425620713388dfac09cef1401516a96dc3a41b9582e48d2645e1dcdeaa12303bf7802abb78022de49f4df78426ae28cc2', 'https://kioskpublicapi.grandmandarin88.com/customreport/getdata/reportname/PlayerGames');
INSERT INTO `api_tb_proxy_key` VALUES ('92', '87', '3', 'oxC73Q6dq', 'http://linkapi.77777f.com/app/WebService/JSON/display.php/BetRecord');
INSERT INTO `api_tb_proxy_key` VALUES ('94', '89', '25', ' ', 'http://api.ggpoker.site/integration/api/site');
INSERT INTO `api_tb_proxy_key` VALUES ('95', '90', '23', 'MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJCflAeD1DFKBYfCCLV6r1IuaCi3J8udjDVFZC4Z07UA2TWMD79a+TA4IWqKNApG7xUFj4pCPClyb9E6pcM2BUA9j35TmDTduvUiJr/cbxkXdeSz9PTDLeudPp2PVjdDwIGdwAOgSS8+cdJBuX/LXzmjnOZj480x4nGruTrdi+uNAgMBAAECgYBupfjeiwjksQpsJJL/Lh9G1ASS6haDXUVxWGbeMppcCIsmwcMml1bBgqBmX9iS6FRxE/EPSb+3wjs0rBc4tHLs3emP8pl41iYwcO5lvNGMfXIgFvsLgoup/vj8IpRmi4Y+E7eiqTuPBwftbGB/2iN9KMCMD+l0ZzlMROyiCqw0zQJBAMUAGH7/5tERDr3bcZ8DD8NBdTUnzVJK182oNOyfWqbBBxH+8dzQn/X0weOyUkO//kCiXKm4fYpVJDZ+gKJhx+cCQQC778RIg/eQAANdjjtG0Jricuj47Twz0risMhKo0/0Uhru1e9XivynrKycGP3C/MykBVzNVPn3FGs6Shp4IA/JrAkByzlB4SsgIFOnDaUy4/37DKrWUqcJ1b9p+JsXZFDEvNxTYvvvS1N4z51TLTpO0mgIhRr27xyGaaW32OBjdCSEHAkEApYdiL6ikVN3eGPncddvof4lMb2usecygwXH9A1xr7Tdaf1eKJIPRLQO+BH++E3nBJSAj43H+Hqwkw+PzrwWi7wJBAIy0ljB4mfSOgFOK+HbUfQBUtSGHEGtndWG3IX1iqUZpow7+cVAE7xG3tv4vAhLEXe+YqxNdnkLT5FX0218p+Mk=', 'http://haoying.ebet.im:8888/api/userbethistory');
INSERT INTO `api_tb_proxy_key` VALUES ('96', '91', '27', ' ', 'http://api.prod.ib.gsoft88.net/api/');
INSERT INTO `api_tb_proxy_key` VALUES ('100', '95', '27', ' ', 'http://api.prod.ib.gsoft88.net/api/');
INSERT INTO `api_tb_proxy_key` VALUES ('101', '96', '22', ' ', 'http://api.gbfine.com/GBGameAPI/API.aspx');
INSERT INTO `api_tb_proxy_key` VALUES ('102', '97', '10', 'dIXdfUMBAjj3', 'https://ag.adminserv88.com/lps');
INSERT INTO `api_tb_proxy_key` VALUES ('103', '98', '22', ' ', 'http://api.gbfine.com/GBGameAPI/API.aspx');
INSERT INTO `api_tb_proxy_key` VALUES ('104', '99', '1', 'hq@-@688*$-$*!&88$dshxeh', 'http://cashapi.dg20mu.com/cashapi/getdata.aspx');
INSERT INTO `api_tb_proxy_key` VALUES ('105', '100', '22', ' ', 'http://api.gbfine.com/GBGameAPI/API.aspx');
INSERT INTO `api_tb_proxy_key` VALUES ('106', '101', '6', 'BK2.jindan', 'VdVfYqK9w%');
INSERT INTO `api_tb_proxy_key` VALUES ('107', '102', '28', 'Y09.jinta', 'DFCkvRwVRA');
INSERT INTO `api_tb_proxy_key` VALUES ('109', '104', '30', ' ', 'http://imone.imaegisapi.com');
INSERT INTO `api_tb_proxy_key` VALUES ('110', '105', '4', 'dLDYglgy', 'http://www.hy95.net/web');
INSERT INTO `api_tb_proxy_key` VALUES ('111', '106', '12', ' ', 'https://ams5-api.ttms.co:7443/dataservice/datafeed/transaction/current');
INSERT INTO `api_tb_proxy_key` VALUES ('112', '107', '32', 'HQ', 'http://api.jdb1688.net/apiRequest.do');
INSERT INTO `api_tb_proxy_key` VALUES ('113', '108', '19', ' ', 'http://api.coolres.com/');
INSERT INTO `api_tb_proxy_key` VALUES ('114', '109', '26', 'f016b449979320537f12907723845839c406ce3d20f1d4add8ffc80d51af4ebcee38b623885efb9ff976de00f03018f85eaa6193f0133c3e317d220129bf1edd', 'https://kioskpublicapi.grandmandarin88.com/customreport/getdata/reportname/PlayerGames');
INSERT INTO `api_tb_proxy_key` VALUES ('115', '110', '31', ' ', 'http://api.ggp88.net');
INSERT INTO `api_tb_proxy_key` VALUES ('116', '111', '31', ' ', 'http://api.ggp88.net');
INSERT INTO `api_tb_proxy_key` VALUES ('117', '112', '30', ' ', 'http://imone.imaegisapi.com');

-- ----------------------------
-- Table structure for api_tgp_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_tgp_gameinfo`;
CREATE TABLE `api_tgp_gameinfo` (
  `ugsbetid` varchar(50) NOT NULL DEFAULT '',
  `txid` varchar(50) DEFAULT NULL,
  `betid` varchar(50) DEFAULT NULL,
  `beton` datetime DEFAULT NULL,
  `betclosedon` datetime DEFAULT NULL,
  `betupdatedon` datetime DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `roundid` varchar(50) DEFAULT NULL,
  `roundstatus` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `riskamt` double DEFAULT NULL,
  `winamt` double DEFAULT NULL,
  `winloss` double DEFAULT NULL,
  `beforebal` double DEFAULT NULL,
  `postbal` double DEFAULT NULL,
  `cur` varchar(10) DEFAULT NULL,
  `gameprovider` varchar(50) DEFAULT NULL,
  `gamename` varchar(50) DEFAULT NULL,
  `gameid` varchar(50) DEFAULT NULL,
  `platformtype` varchar(50) DEFAULT NULL,
  `ipaddress` varchar(50) DEFAULT NULL,
  `bettype` varchar(50) DEFAULT NULL,
  `playtype` varchar(50) DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `validmoney` double DEFAULT '0',
  PRIMARY KEY (`ugsbetid`),
  KEY `api_tgp_gameinfo_ix1` (`userid`,`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_tgp_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_ttg_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_ttg_gameinfo`;
CREATE TABLE `api_ttg_gameinfo` (
  `transactionId` bigint(20) NOT NULL DEFAULT '0' COMMENT '交易ID',
  `requestId` varchar(50) DEFAULT NULL COMMENT '请求ID',
  `partnerId` varchar(50) DEFAULT NULL COMMENT '同伴ID',
  `playerId` varchar(50) DEFAULT NULL COMMENT '玩家ID',
  `amount` varchar(50) DEFAULT NULL COMMENT '总额',
  `handId` varchar(50) DEFAULT NULL COMMENT '游戏独特的手Id',
  `transactionType` varchar(50) DEFAULT NULL COMMENT '交易类型',
  `transactionSubType` varchar(50) DEFAULT NULL COMMENT '子交易类型',
  `currency` varchar(50) DEFAULT NULL COMMENT '货币类型',
  `game` varchar(50) DEFAULT NULL COMMENT '游戏名称',
  `transactionDate` varchar(50) DEFAULT NULL COMMENT '交易日期',
  `createtime` datetime DEFAULT NULL COMMENT '创建日期',
  `Platformflag` varchar(50) DEFAULT NULL COMMENT '标志',
  PRIMARY KEY (`transactionId`),
  KEY `api_ttg_gameinfo_ix1` (`createtime`) USING BTREE,
  KEY `api_ttg_gameinfo_ix2` (`playerId`) USING BTREE,
  KEY `idx_api_ttg_gameinfo_handId_transactionId` (`handId`,`transactionId`) USING BTREE,
  KEY `idx_api_ttg_gameinfo_handId_transactionSubType_amount` (`handId`,`transactionSubType`,`amount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='TTG游戏表';

-- ----------------------------
-- Records of api_ttg_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_user
-- ----------------------------
DROP TABLE IF EXISTS `api_user`;
CREATE TABLE `api_user` (
  `user_id` varchar(32) NOT NULL,
  `platform_id` varchar(32) DEFAULT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `user_createtime` datetime DEFAULT NULL,
  `user_code` varchar(32) DEFAULT NULL,
  `user_parentcode` varchar(32) DEFAULT NULL,
  `user_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `FK_Relationship_10` (`platform_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_user
-- ----------------------------

-- ----------------------------
-- Table structure for api_user_game
-- ----------------------------
DROP TABLE IF EXISTS `api_user_game`;
CREATE TABLE `api_user_game` (
  `usergame_id` varchar(32) NOT NULL,
  `user_id` varchar(32) NOT NULL,
  `usergame_name` varchar(20) DEFAULT NULL,
  `usergame_password` varchar(15) DEFAULT NULL,
  `usergame_gametype` varchar(12) DEFAULT NULL,
  `usergame_time` datetime DEFAULT NULL,
  PRIMARY KEY (`usergame_id`),
  KEY `FK_Relationship_59` (`user_id`) USING BTREE,
  KEY `ix_user_game_usergame_name` (`usergame_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_user_game
-- ----------------------------

-- ----------------------------
-- Table structure for api_user_moneyinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_user_moneyinfo`;
CREATE TABLE `api_user_moneyinfo` (
  `moneyinfo_id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `moneyinfo_type` varchar(12) DEFAULT NULL,
  `moneyinfo_money` decimal(15,2) DEFAULT NULL,
  `moneyinfo_createtime` datetime DEFAULT NULL,
  `moneyinfo_gametype` varchar(15) DEFAULT NULL,
  `moneyinfo_ordernum` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`moneyinfo_id`),
  KEY `FK_Relationship_3` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_user_moneyinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_win88_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_win88_gameinfo`;
CREATE TABLE `api_win88_gameinfo` (
  `pt_gamecode` varchar(32) NOT NULL,
  `pt_username` varchar(32) DEFAULT NULL,
  `pt_windowcode` varchar(32) DEFAULT NULL,
  `pt_gameid` varchar(32) DEFAULT NULL,
  `pt_gametype` varchar(32) DEFAULT NULL,
  `pt_gamename` varchar(200) DEFAULT NULL,
  `pt_bet` decimal(11,2) DEFAULT NULL,
  `pt_win` decimal(11,2) DEFAULT NULL,
  `pt_balance` decimal(11,2) DEFAULT NULL,
  `pt_gamedate` datetime DEFAULT NULL,
  `pt_info` varchar(1000) DEFAULT NULL,
  `pt_sessionid` varchar(32) DEFAULT NULL,
  `pt_progressivebet` varchar(32) DEFAULT NULL,
  `pt_progressivewin` varchar(32) DEFAULT NULL,
  `pt_currentbet` varchar(32) DEFAULT NULL,
  `pt_livenetwork` varchar(32) DEFAULT NULL,
  `pt_rnum` varchar(32) DEFAULT NULL,
  `pt_createtime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pt_gamecode`),
  KEY `ix_pt_gameinfo_pt_username` (`pt_username`) USING BTREE,
  KEY `ix_pt_gameinfo_pt_gamedate` (`pt_gamedate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_win88_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_xcp_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_xcp_gameinfo`;
CREATE TABLE `api_xcp_gameinfo` (
  `xcp_projectid` varchar(32) NOT NULL,
  `xcp_lotteryid` varchar(32) DEFAULT NULL,
  `xcp_username` varchar(32) DEFAULT NULL,
  `xcp_issue` varchar(32) DEFAULT NULL,
  `xcp_isgetprize` varchar(32) DEFAULT NULL,
  `xcp_updatetime` datetime DEFAULT NULL,
  `xcp_writetime` datetime DEFAULT NULL,
  `xcp_totalprice` double(11,4) DEFAULT NULL,
  `xcp_code` text,
  `xcp_bonus` double(11,4) DEFAULT NULL,
  `xcp_codetimes` double(11,2) DEFAULT NULL,
  `xcp_prize` double(11,4) DEFAULT NULL,
  `xcp_createtime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`xcp_projectid`),
  KEY `ix_xcp_gameinfo_xcp_username` (`xcp_username`) USING BTREE,
  KEY `api_xcp_gameinfo_ix2` (`xcp_writetime`) USING BTREE,
  KEY `api_xcp_gameinfo_ix3` (`xcp_createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_xcp_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_yag_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_yag_gameinfo`;
CREATE TABLE `api_yag_gameinfo` (
  `betId` varchar(32) NOT NULL DEFAULT '',
  `user` varchar(25) DEFAULT NULL,
  `gameId` varchar(20) DEFAULT NULL,
  `gameName` varchar(100) DEFAULT NULL,
  `money` double(10,2) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `result` double(10,2) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `validMoney` double(10,0) DEFAULT NULL,
  PRIMARY KEY (`betId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_yag_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_yoplay_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_yoplay_gameinfo`;
CREATE TABLE `api_yoplay_gameinfo` (
  `billNo` varchar(50) NOT NULL,
  `playerName` varchar(50) DEFAULT NULL,
  `agentCode` varchar(50) DEFAULT NULL,
  `gameCode` varchar(200) DEFAULT NULL,
  `netAmount` varchar(50) DEFAULT NULL,
  `betTime` datetime DEFAULT NULL,
  `gameType` varchar(50) DEFAULT NULL,
  `betAmount` varchar(50) DEFAULT NULL,
  `validBetAmount` varchar(50) DEFAULT NULL,
  `flag` varchar(50) DEFAULT NULL,
  `playType` varchar(50) DEFAULT NULL,
  `currency` varchar(50) DEFAULT NULL,
  `tableCode` varchar(50) DEFAULT NULL,
  `loginIP` varchar(50) DEFAULT NULL,
  `recalcuTime` varchar(50) DEFAULT NULL,
  `platformType` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `round` varchar(50) DEFAULT NULL,
  `slottype` varchar(50) DEFAULT NULL,
  `result` varchar(2048) DEFAULT NULL,
  `mainbillno` varchar(50) DEFAULT NULL,
  `beforeCredit` varchar(50) DEFAULT NULL,
  `deviceType` varchar(50) DEFAULT NULL,
  `betAmountBase` varchar(50) DEFAULT NULL,
  `betAmountBonus` varchar(50) DEFAULT NULL,
  `netAmountBase` varchar(50) DEFAULT NULL,
  `netAmountBonus` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `validmoney` double DEFAULT NULL,
  PRIMARY KEY (`billNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_yoplay_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for api_zj_gameinfo
-- ----------------------------
DROP TABLE IF EXISTS `api_zj_gameinfo`;
CREATE TABLE `api_zj_gameinfo` (
  `id` bigint(20) NOT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `gameType` varchar(20) DEFAULT NULL,
  `tableInfoId` varchar(20) DEFAULT NULL,
  `shoeInfoId` varchar(20) DEFAULT NULL,
  `gameInfoId` varchar(10) DEFAULT NULL,
  `tableName` varchar(10) DEFAULT NULL,
  `issueNo` varchar(10) DEFAULT NULL,
  `bankerResult` varchar(100) DEFAULT NULL,
  `resultList` varchar(100) DEFAULT NULL,
  `pokerList` varchar(100) DEFAULT NULL,
  `stakeAmount` double(8,2) DEFAULT NULL,
  `validStake` double(8,2) DEFAULT NULL,
  `winLoss` double(8,2) DEFAULT NULL,
  `comm` double(8,2) DEFAULT NULL,
  `balanceAfter` double(8,2) DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `Details` text,
  `betTime` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `api_zj_gameinfo_ix1` (`userName`) USING BTREE,
  KEY `api_zj_gameinfo_ix2` (`betTime`) USING BTREE,
  KEY `api_zj_gameinfo_ix3` (`createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of api_zj_gameinfo
-- ----------------------------

-- ----------------------------
-- Table structure for baccarath5_balance
-- ----------------------------
DROP TABLE IF EXISTS `baccarath5_balance`;
CREATE TABLE `baccarath5_balance` (
  `employeecode` char(8) NOT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `balance` double DEFAULT '0',
  `updatetime` datetime DEFAULT NULL,
  `levelcode` int(2) DEFAULT '1',
  PRIMARY KEY (`employeecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of baccarath5_balance
-- ----------------------------

-- ----------------------------
-- Table structure for baccarath5_exchange
-- ----------------------------
DROP TABLE IF EXISTS `baccarath5_exchange`;
CREATE TABLE `baccarath5_exchange` (
  `lsh` varchar(36) NOT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `exchange_in` double DEFAULT NULL,
  `exchange_out` double DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `exchange_time` datetime DEFAULT NULL,
  `exchange_status` char(2) DEFAULT '0' COMMENT '0=处理中 1=成功 2=失败',
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`lsh`),
  KEY `index1` (`employeecode`) USING BTREE,
  KEY `index2` (`loginaccount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of baccarath5_exchange
-- ----------------------------

-- ----------------------------
-- Table structure for baccarath5_rebate
-- ----------------------------
DROP TABLE IF EXISTS `baccarath5_rebate`;
CREATE TABLE `baccarath5_rebate` (
  `lsh` varchar(36) NOT NULL,
  `patchno` varchar(20) DEFAULT NULL COMMENT '批次号',
  `ordernumber` varchar(36) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '充值代理账号',
  `money` double DEFAULT NULL COMMENT '充值元宝数',
  `orderamount` double DEFAULT NULL COMMENT '充值金额',
  `orderdate` datetime DEFAULT NULL,
  `currenlevel` varchar(10) DEFAULT NULL COMMENT '代理当前等级',
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` char(8) DEFAULT NULL,
  `employeecurrenlevel` varchar(10) DEFAULT NULL COMMENT '当前返现代理的等级',
  `rebate` double(10,2) DEFAULT NULL COMMENT '返现比例',
  `rebatemoney` double(16,2) DEFAULT NULL COMMENT '返现金额',
  `rebatestatus` int(11) DEFAULT '1' COMMENT '1=待处理 2=返现成功 3=返现失败',
  `rebatetime` datetime DEFAULT NULL COMMENT '返现处理时间',
  `rebatedesc` varchar(252) DEFAULT NULL COMMENT '返现处理结果说明',
  `remark` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of baccarath5_rebate
-- ----------------------------

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank` (
  `bankcode` char(4) COLLATE utf8_bin NOT NULL COMMENT '银行代码',
  `bankname` varchar(16) CHARACTER SET utf8 NOT NULL COMMENT '银行名称',
  `logopath` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图片网址',
  `banklogo` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '银行LOGO',
  `bankurl` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '银行URL',
  `displayorder` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`bankcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of bank
-- ----------------------------
INSERT INTO `bank` VALUES ('B001', '上海银行', null, '/icon/bank/SHANGHAI_OUT.jpg', 'http://www.bankofshanghai.com/', '9');
INSERT INTO `bank` VALUES ('B002', '北京银行', null, '/icon/bank/BEIJING_OUT.jpg', 'http://www.bankofbeijing.com.cn/', '8');
INSERT INTO `bank` VALUES ('B003', '交通银行', null, '/icon/bank/COMM_OUT.gif', 'http://www.bankcomm.com/BankCommSite/default.shtml', '6');
INSERT INTO `bank` VALUES ('B004', '中国银行', null, '/icon/bank/BOC_OUT.gif', 'http://www.boc.cn/', '5');
INSERT INTO `bank` VALUES ('B005', '中国农业银行', null, '/icon/bank/ABC_OUT.gif', 'http://www.abchina.com/cn/', '3');
INSERT INTO `bank` VALUES ('B006', '中国工商银行', null, '/icon/bank/ICBC_OUT.gif', 'http://www.icbc.com.cn/icbc/', '1');
INSERT INTO `bank` VALUES ('B007', '兴业银行', null, '/icon/bank/CIB_OUT.gif', 'http://www.cib.com.cn/cn/index.html', '10');
INSERT INTO `bank` VALUES ('B008', '中国光大银行', null, '/icon/bank/CEB_OUT.gif', 'http://www.cib.com.cn/cn/index.html', '11');
INSERT INTO `bank` VALUES ('B009', '广发银行', null, '/icon/bank/GDB_OUT.gif', 'http://www.cgbchina.com.cn/', '12');
INSERT INTO `bank` VALUES ('B010', '平安银行', null, '/icon/bank/ban_pingan.png', 'http://bank.pingan.com/index.shtml', '13');
INSERT INTO `bank` VALUES ('B011', '华夏银行', null, '/icon/bank/hx.jpg', 'http://www.hxb.com.cn/', '14');
INSERT INTO `bank` VALUES ('B012', '浦发银行', null, '/icon/bank/pf.jpg', 'http://www.spdb.com.cn/', '16');
INSERT INTO `bank` VALUES ('B013', '中信银行', null, '/icon/bank/CITIC_OUT.gif', 'http://bank.ecitic.com/', '19');
INSERT INTO `bank` VALUES ('B015', '中国建设银行', null, '/icon/bank/CCB_OUT.gif', 'http://www.ccb.com/cn/home/indexv3.html', '2');
INSERT INTO `bank` VALUES ('B016', '招商银行', null, '/icon/bank/CMB_OUT.gif', 'http://www.cmbchina.com/', '4');
INSERT INTO `bank` VALUES ('B018', '中国民生银行', null, '/icon/bank/CMBC_OUT.gif', 'http://www.cmbc.com.cn/', '7');
INSERT INTO `bank` VALUES ('B019', '微信', null, null, '#', '90');
INSERT INTO `bank` VALUES ('B020', '支付宝', null, null, 'https://www.alipay.com/', '91');
INSERT INTO `bank` VALUES ('B021', '中国邮政储蓄银行', null, null, 'http://www.psbc.com/portal/zh_CN/index.html', '15');
INSERT INTO `bank` VALUES ('B022', '北京农商银行', null, '#', 'http://www.bjrcb.com/', '17');
INSERT INTO `bank` VALUES ('B023', '上海农商银行', null, null, 'http://www.srcb.com/html/index.html', '18');
INSERT INTO `bank` VALUES ('B024', '南京银行', null, null, null, '22');
INSERT INTO `bank` VALUES ('B025', '东亚银行', null, null, null, '23');
INSERT INTO `bank` VALUES ('B026', '宁波银行', null, null, null, '24');
INSERT INTO `bank` VALUES ('B027', '深圳发展银行', null, null, null, '25');
INSERT INTO `bank` VALUES ('B028', '财付通', null, null, null, '92');
INSERT INTO `bank` VALUES ('B029', '微信WAP', null, null, null, '93');
INSERT INTO `bank` VALUES ('B030', '渤海银行', null, null, null, '28');
INSERT INTO `bank` VALUES ('B031', '浙江稠州商业银行', null, null, null, '29');
INSERT INTO `bank` VALUES ('B032', 'H5端收银台', null, '/images/bank/B032.jpg', null, '89');
INSERT INTO `bank` VALUES ('B033', 'PC端收银台', null, '/images/bank/B033.jpg', null, '88');
INSERT INTO `bank` VALUES ('B034', 'QQ钱包', null, '/images/bank/B034.jpg', null, '94');
INSERT INTO `bank` VALUES ('B035', '京东钱包', null, null, null, '95');
INSERT INTO `bank` VALUES ('B036', '银联', null, null, null, '96');

-- ----------------------------
-- Table structure for bankcards_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `bankcards_blacklist`;
CREATE TABLE `bankcards_blacklist` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键, 自增',
  `username` varchar(50) DEFAULT NULL COMMENT '人员姓名',
  `bankcard` varchar(50) DEFAULT NULL COMMENT '银行卡号',
  `phoneno` varchar(50) DEFAULT NULL COMMENT '电话号码',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='黑名单列表';

-- ----------------------------
-- Records of bankcards_blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for banks_card_bin
-- ----------------------------
DROP TABLE IF EXISTS `banks_card_bin`;
CREATE TABLE `banks_card_bin` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `bankprefix` varchar(19) NOT NULL,
  `bankcode` varchar(4) DEFAULT NULL,
  `bankname` varchar(50) DEFAULT NULL,
  `banklen` int(11) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB AUTO_INCREMENT=1401 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of banks_card_bin
-- ----------------------------
INSERT INTO `banks_card_bin` VALUES ('1', '621098', null, '邮储银行·绿卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('2', '622150', null, '邮储银行·绿卡银联标准卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('3', '622151', null, '邮储银行·绿卡银联标准卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('4', '622181', null, '邮储银行·绿卡专用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('5', '622188', null, '邮储银行·绿卡银联标准卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('6', '955100', null, '邮储银行·绿卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('7', '621095', null, '邮储银行·绿卡VIP卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('8', '620062', null, '邮储银行·银联标准卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('9', '621285', null, '邮储银行·中职学生资助卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('10', '621798', null, '邮政储蓄银行·IC绿卡通VIP卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('11', '621799', null, '邮政储蓄银行·IC绿卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('12', '621797', null, '邮政储蓄银行·IC联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('13', '620529', null, '邮政储蓄银行·IC预付费卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('14', '622199', null, '邮储银行·绿卡银联标准卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('15', '621096', null, '邮储银行·绿卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('16', '621622', null, '邮政储蓄银行·武警军人保障卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('17', '623219', null, '邮政储蓄银行·中国旅游卡（金卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('18', '621674', null, '邮政储蓄银行·普通高中学生资助卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('19', '623218', null, '邮政储蓄银行·中国旅游卡（普卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('20', '621599', null, '邮政储蓄银行·福农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('21', '370246', null, '工商银行·牡丹运通卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('22', '370248', null, '工商银行·牡丹运通卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('23', '370249', null, '工商银行·牡丹运通卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('24', '427010', null, '工商银行·牡丹VISA卡(单位卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('25', '427018', null, '工商银行·牡丹VISA信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('26', '427019', null, '工商银行·牡丹VISA卡(单位卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('27', '427020', null, '工商银行·牡丹VISA信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('28', '427029', null, '工商银行·牡丹VISA信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('29', '427030', null, '工商银行·牡丹VISA信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('30', '427039', null, '工商银行·牡丹VISA信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('31', '370247', null, '工商银行·牡丹运通卡普通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('32', '438125', null, '工商银行·牡丹VISA信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('33', '438126', null, '工商银行·牡丹VISA白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('34', '451804', null, '工商银行·牡丹贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('35', '451810', null, '工商银行·牡丹贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('36', '451811', null, '工商银行·牡丹贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('37', '458071', null, '工商银行·牡丹贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('38', '489734', null, '工商银行·牡丹欧元卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('39', '489735', null, '工商银行·牡丹欧元卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('40', '489736', null, '工商银行·牡丹欧元卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('41', '510529', null, '工商银行·牡丹万事达国际借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('42', '427062', null, '工商银行·牡丹VISA信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('43', '524091', null, '工商银行·海航信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('44', '427064', null, '工商银行·牡丹VISA信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('45', '530970', null, '工商银行·牡丹万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('46', '530990', null, '工商银行·牡丹万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('47', '558360', null, '工商银行·牡丹万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('48', '620200', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('49', '620302', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('50', '620402', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('51', '620403', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('52', '620404', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('53', '524047', null, '工商银行·牡丹万事达白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('54', '620406', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('55', '620407', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('56', '525498', null, '工商银行·海航信用卡个人普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('57', '620409', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('58', '620410', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('59', '620411', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('60', '620412', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('61', '620502', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('62', '620503', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('63', '620405', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('64', '620408', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('65', '620512', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('66', '620602', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('67', '620604', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('68', '620607', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('69', '620611', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('70', '620612', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('71', '620704', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('72', '620706', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('73', '620707', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('74', '620708', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('75', '620709', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('76', '620710', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('77', '620609', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('78', '620712', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('79', '620713', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('80', '620714', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('81', '620802', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('82', '620711', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('83', '620904', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('84', '620905', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('85', '621001', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('86', '620902', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('87', '621103', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('88', '621105', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('89', '621106', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('90', '621107', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('91', '621102', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('92', '621203', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('93', '621204', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('94', '621205', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('95', '621206', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('96', '621207', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('97', '621208', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('98', '621209', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('99', '621210', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('100', '621302', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('101', '621303', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('102', '621202', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('103', '621305', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('104', '621306', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('105', '621307', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('106', '621309', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('107', '621311', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('108', '621313', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('109', '621211', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('110', '621315', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('111', '621304', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('112', '621402', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('113', '621404', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('114', '621405', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('115', '621406', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('116', '621407', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('117', '621408', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('118', '621409', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('119', '621410', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('120', '621502', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('121', '621317', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('122', '621511', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('123', '621602', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('124', '621603', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('125', '621604', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('126', '621605', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('127', '621608', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('128', '621609', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('129', '621610', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('130', '621611', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('131', '621612', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('132', '621613', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('133', '621614', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('134', '621615', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('135', '621616', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('136', '621617', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('137', '621607', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('138', '621606', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('139', '621804', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('140', '621807', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('141', '621813', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('142', '621814', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('143', '621817', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('144', '621901', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('145', '621904', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('146', '621905', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('147', '621906', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('148', '621907', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('149', '621908', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('150', '621909', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('151', '621910', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('152', '621911', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('153', '621912', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('154', '621913', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('155', '621915', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('156', '622002', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('157', '621903', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('158', '622004', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('159', '622005', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('160', '622006', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('161', '622007', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('162', '622008', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('163', '622010', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('164', '622011', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('165', '622012', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('166', '621914', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('167', '622015', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('168', '622016', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('169', '622003', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('170', '622018', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('171', '622019', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('172', '622020', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('173', '622102', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('174', '622103', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('175', '622104', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('176', '622105', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('177', '622013', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('178', '622111', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('179', '622114', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('180', '622200', null, '工商银行·灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('181', '622017', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('182', '622202', null, '工商银行·E时代卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('183', '622203', null, '工商银行·E时代卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('184', '622208', null, '工商银行·理财金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('185', '622210', null, '工商银行·准贷记卡(个普)', null, null);
INSERT INTO `banks_card_bin` VALUES ('186', '622211', null, '工商银行·准贷记卡(个普)', null, null);
INSERT INTO `banks_card_bin` VALUES ('187', '622212', null, '工商银行·准贷记卡(个普)', null, null);
INSERT INTO `banks_card_bin` VALUES ('188', '622213', null, '工商银行·准贷记卡(个普)', null, null);
INSERT INTO `banks_card_bin` VALUES ('189', '622214', null, '工商银行·准贷记卡(个普)', null, null);
INSERT INTO `banks_card_bin` VALUES ('190', '622110', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('191', '622220', null, '工商银行·准贷记卡(商普)', null, null);
INSERT INTO `banks_card_bin` VALUES ('192', '622223', null, '工商银行·牡丹卡(商务卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('193', '622225', null, '工商银行·准贷记卡(商金)', null, null);
INSERT INTO `banks_card_bin` VALUES ('194', '622229', null, '工商银行·牡丹卡(商务卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('195', '622230', null, '工商银行·贷记卡(个普)', null, null);
INSERT INTO `banks_card_bin` VALUES ('196', '622231', null, '工商银行·牡丹卡(个人卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('197', '622232', null, '工商银行·牡丹卡(个人卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('198', '622233', null, '工商银行·牡丹卡(个人卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('199', '622234', null, '工商银行·牡丹卡(个人卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('200', '622235', null, '工商银行·贷记卡(个金)', null, null);
INSERT INTO `banks_card_bin` VALUES ('201', '622237', null, '工商银行·牡丹交通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('202', '622215', null, '工商银行·准贷记卡(个金)', null, null);
INSERT INTO `banks_card_bin` VALUES ('203', '622239', null, '工商银行·牡丹交通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('204', '622240', null, '工商银行·贷记卡(商普)', null, null);
INSERT INTO `banks_card_bin` VALUES ('205', '622245', null, '工商银行·贷记卡(商金)', null, null);
INSERT INTO `banks_card_bin` VALUES ('206', '622224', null, '工商银行·牡丹卡(商务卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('207', '622303', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('208', '622304', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('209', '622305', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('210', '622306', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('211', '622307', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('212', '622308', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('213', '622309', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('214', '622238', null, '工商银行·牡丹交通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('215', '622314', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('216', '622315', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('217', '622317', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('218', '622302', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('219', '622402', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('220', '622403', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('221', '622404', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('222', '622313', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('223', '622504', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('224', '622505', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('225', '622509', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('226', '622513', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('227', '622517', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('228', '622502', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('229', '622604', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('230', '622605', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('231', '622606', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('232', '622510', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('233', '622703', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('234', '622715', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('235', '622806', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('236', '622902', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('237', '622903', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('238', '622706', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('239', '623002', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('240', '623006', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('241', '623008', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('242', '623011', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('243', '623012', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('244', '622904', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('245', '623015', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('246', '623100', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('247', '623202', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('248', '623301', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('249', '623400', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('250', '623500', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('251', '623602', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('252', '623803', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('253', '623901', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('254', '623014', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('255', '624100', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('256', '624200', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('257', '624301', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('258', '624402', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('259', '62451804', null, '工商银行·牡丹贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('260', '62451810', null, '工商银行·牡丹贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('261', '62451811', null, '工商银行·牡丹贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('262', '62458071', null, '工商银行·牡丹贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('263', '623700', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('264', '628288', null, '工商银行·中央预算单位公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('265', '624000', null, '工商银行·牡丹灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('266', '628286', null, '工商银行·财政预算单位公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('267', '622206', null, '工商银行·牡丹卡白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('268', '621225', null, '工商银行·牡丹卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('269', '526836', null, '工商银行·国航知音牡丹信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('270', '513685', null, '工商银行·国航知音牡丹信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('271', '543098', null, '工商银行·国航知音牡丹信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('272', '458441', null, '工商银行·国航知音牡丹信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('273', '620058', null, '工商银行·银联标准卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('274', '621281', null, '工商银行·中职学生资助卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('275', '622246', null, '工商银行·专用信用消费卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('276', '900000', null, '工商银行·牡丹社会保障卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('277', '544210', null, '中国工商银行·牡丹东航联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('278', '548943', null, '中国工商银行·牡丹东航联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('279', '370267', null, '中国工商银行·牡丹运通白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('280', '621558', null, '中国工商银行·福农灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('281', '621559', null, '中国工商银行·福农灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('282', '621722', null, '工商银行·灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('283', '621723', null, '工商银行·灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('284', '620086', null, '中国工商银行·中国旅行卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('285', '621226', null, '工商银行·牡丹卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('286', '402791', null, '工商银行·国际借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('287', '427028', null, '工商银行·国际借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('288', '427038', null, '工商银行·国际借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('289', '548259', null, '工商银行·国际借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('290', '356879', null, '中国工商银行·牡丹JCB信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('291', '356880', null, '中国工商银行·牡丹JCB信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('292', '356881', null, '中国工商银行·牡丹JCB信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('293', '356882', null, '中国工商银行·牡丹JCB信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('294', '528856', null, '中国工商银行·牡丹多币种卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('295', '621618', null, '中国工商银行·武警军人保障卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('296', '620516', null, '工商银行·预付芯片卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('297', '621227', null, '工商银行·理财金账户金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('298', '621721', null, '工商银行·灵通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('299', '900010', null, '工商银行·牡丹宁波市民卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('300', '625330', null, '中国工商银行·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('301', '625331', null, '中国工商银行·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('302', '625332', null, '中国工商银行·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('303', '623062', null, '中国工商银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('304', '622236', null, '中国工商银行·借贷合一卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('305', '621670', null, '中国工商银行·普通高中学生资助卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('306', '524374', null, '中国工商银行·牡丹多币种卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('307', '550213', null, '中国工商银行·牡丹多币种卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('308', '374738', null, '中国工商银行·牡丹百夫长信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('309', '374739', null, '中国工商银行·牡丹百夫长信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('310', '621288', null, '工商银行·工银财富卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('311', '625708', null, '中国工商银行·中小商户采购卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('312', '625709', null, '中国工商银行·中小商户采购卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('313', '622597', null, '中国工商银行·环球旅行金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('314', '622599', null, '中国工商银行·环球旅行白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('315', '360883', null, '中国工商银行·牡丹工银大来卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('316', '360884', null, '中国工商银行·牡丹工银大莱卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('317', '625865', null, '中国工商银行·IC金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('318', '625866', null, '中国工商银行·IC白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('319', '625899', null, '中国工商银行·工行IC卡（红卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('320', '621376', null, '中国工商银行布鲁塞尔分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('321', '620054', null, '中国工商银行布鲁塞尔分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('322', '620142', null, '中国工商银行布鲁塞尔分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('323', '621428', null, '中国工商银行金边分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('324', '625939', null, '中国工商银行金边分行·信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('325', '621434', null, '中国工商银行金边分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('326', '625987', null, '中国工商银行金边分行·信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('327', '621761', null, '中国工商银行加拿大分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('328', '621749', null, '中国工商银行加拿大分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('329', '620184', null, '中国工商银行加拿大分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('330', '621300', null, '中国工商银行巴黎分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('331', '621378', null, '中国工商银行巴黎分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('332', '625114', null, '中国工商银行巴黎分行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('333', '622159', null, '中国工商银行法兰克福分行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('334', '621720', null, '中国工商银行法兰克福分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('335', '625021', null, '中国工商银行法兰克福分行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('336', '625022', null, '中国工商银行法兰克福分行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('337', '621379', null, '中国工商银行法兰克福分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('338', '620114', null, '中国工商银行法兰克福分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('339', '620146', null, '中国工商银行法兰克福分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('340', '621724', null, '中国工商银行印尼分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('341', '625918', null, '中国工商银行印尼分行·信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('342', '621371', null, '中国工商银行米兰分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('343', '620143', null, '中国工商银行米兰分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('344', '620149', null, '中国工商银行米兰分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('345', '621414', null, '中国工商银行阿拉木图子行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('346', '625914', null, '中国工商银行阿拉木图子行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('347', '621375', null, '中国工商银行阿拉木图子行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('348', '620187', null, '中国工商银行阿拉木图子行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('349', '621433', null, '中国工商银行万象分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('350', '625986', null, '中国工商银行万象分行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('351', '621370', null, '中国工商银行卢森堡分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('352', '625925', null, '中国工商银行卢森堡分行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('353', '622926', null, '中国工商银行澳门分行·E时代卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('354', '622927', null, '中国工商银行澳门分行·E时代卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('355', '622928', null, '中国工商银行澳门分行·E时代卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('356', '622929', null, '中国工商银行澳门分行·理财金账户', null, null);
INSERT INTO `banks_card_bin` VALUES ('357', '622930', null, '中国工商银行澳门分行·理财金账户', null, null);
INSERT INTO `banks_card_bin` VALUES ('358', '622931', null, '中国工商银行澳门分行·理财金账户', null, null);
INSERT INTO `banks_card_bin` VALUES ('359', '620124', null, '中国工商银行澳门分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('360', '620183', null, '中国工商银行澳门分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('361', '620561', null, '中国工商银行澳门分行·工银闪付预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('362', '625116', null, '中国工商银行澳门分行·工银银联公司卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('363', '622227', null, '中国工商银行澳门分行·Diamond', null, null);
INSERT INTO `banks_card_bin` VALUES ('364', '621372', null, '中国工商银行阿姆斯特丹·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('365', '621464', null, '中国工商银行卡拉奇分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('366', '625942', null, '中国工商银行卡拉奇分行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('367', '622158', null, '中国工商银行新加坡分行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('368', '625917', null, '中国工商银行新加坡分行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('369', '621765', null, '中国工商银行新加坡分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('370', '620094', null, '中国工商银行新加坡分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('371', '620186', null, '中国工商银行新加坡分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('372', '621719', null, '中国工商银行新加坡分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('373', '621750', null, '中国工商银行马德里分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('374', '621377', null, '中国工商银行马德里分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('375', '620148', null, '中国工商银行马德里分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('376', '620185', null, '中国工商银行马德里分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('377', '621374', null, '中国工商银行伦敦子行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('378', '621731', null, '中国工商银行伦敦子行·工银伦敦借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('379', '621781', null, '中国工商银行伦敦子行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('380', '552599', null, '农业银行·金穗贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('381', '623206', null, '农业银行·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('382', '621671', null, '农业银行·普通高中学生资助卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('383', '620059', null, '农业银行·银联标准卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('384', '403361', null, '农业银行·金穗贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('385', '404117', null, '农业银行·金穗贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('386', '404118', null, '农业银行·金穗贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('387', '404119', null, '农业银行·金穗贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('388', '404120', null, '农业银行·金穗贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('389', '404121', null, '农业银行·金穗贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('390', '463758', null, '农业银行·VISA白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('391', '514027', null, '农业银行·万事达白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('392', '519412', null, '农业银行·金穗贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('393', '519413', null, '农业银行·金穗贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('394', '520082', null, '农业银行·金穗贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('395', '520083', null, '农业银行·金穗贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('396', '558730', null, '农业银行·金穗贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('397', '621282', null, '农业银行·中职学生资助卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('398', '621336', null, '农业银行·专用惠农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('399', '621619', null, '农业银行·武警军人保障卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('400', '622821', null, '农业银行·金穗校园卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('401', '622822', null, '农业银行·金穗星座卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('402', '622823', null, '农业银行·金穗社保卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('403', '622824', null, '农业银行·金穗旅游卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('404', '622825', null, '农业银行·金穗青年卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('405', '622826', null, '农业银行·复合介质金穗通宝卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('406', '622827', null, '农业银行·金穗海通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('407', '622828', null, '农业银行·退役金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('408', '622836', null, '农业银行·金穗贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('409', '622837', null, '农业银行·金穗贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('410', '622840', null, '农业银行·金穗通宝卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('411', '622841', null, '农业银行·金穗惠农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('412', '622843', null, '农业银行·金穗通宝银卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('413', '622844', null, '农业银行·金穗通宝卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('414', '622845', null, '农业银行·金穗通宝卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('415', '622846', null, '农业银行·金穗通宝卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('416', '622847', null, '农业银行·金穗通宝卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('417', '622848', null, '农业银行·金穗通宝卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('418', '622849', null, '农业银行·金穗通宝钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('419', '623018', null, '农业银行·掌尚钱包', null, null);
INSERT INTO `banks_card_bin` VALUES ('420', '625996', null, '农业银行·银联IC卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('421', '625997', null, '农业银行·银联预算单位公务卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('422', '625998', null, '农业银行·银联IC卡白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('423', '628268', null, '农业银行·金穗公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('424', '625826', null, '中国农业银行贷记卡·IC普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('425', '625827', null, '中国农业银行贷记卡·IC金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('426', '548478', null, '中国农业银行贷记卡·澳元卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('427', '544243', null, '中国农业银行贷记卡·欧元卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('428', '622820', null, '中国农业银行贷记卡·金穗通商卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('429', '622830', null, '中国农业银行贷记卡·金穗通商卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('430', '622838', null, '中国农业银行贷记卡·银联白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('431', '625336', null, '中国农业银行贷记卡·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('432', '628269', null, '中国农业银行贷记卡·银联IC公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('433', '620501', null, '宁波市农业银行·市民卡B卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('434', '621660', null, '中国银行·联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('435', '621661', null, '中国银行·个人普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('436', '621662', null, '中国银行·个人金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('437', '621663', null, '中国银行·员工普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('438', '621665', null, '中国银行·员工金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('439', '621667', null, '中国银行·理财普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('440', '621668', null, '中国银行·理财金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('441', '621669', null, '中国银行·理财银卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('442', '621666', null, '中国银行·理财白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('443', '625908', null, '中国银行·中行金融IC卡白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('444', '625910', null, '中国银行·中行金融IC卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('445', '625909', null, '中国银行·中行金融IC卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('446', '356833', null, '中国银行·中银JCB卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('447', '356835', null, '中国银行·中银JCB卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('448', '409665', null, '中国银行·员工普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('449', '409666', null, '中国银行·个人普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('450', '409668', null, '中国银行·中银威士信用卡员', null, null);
INSERT INTO `banks_card_bin` VALUES ('451', '409669', null, '中国银行·中银威士信用卡员', null, null);
INSERT INTO `banks_card_bin` VALUES ('452', '409670', null, '中国银行·个人白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('453', '409671', null, '中国银行·中银威士信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('454', '409672', null, '中国银行·长城公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('455', '456351', null, '中国银行·长城电子借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('456', '512315', null, '中国银行·中银万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('457', '512316', null, '中国银行·中银万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('458', '512411', null, '中国银行·中银万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('459', '512412', null, '中国银行·中银万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('460', '514957', null, '中国银行·中银万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('461', '409667', null, '中国银行·中银威士信用卡员', null, null);
INSERT INTO `banks_card_bin` VALUES ('462', '518378', null, '中国银行·长城万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('463', '518379', null, '中国银行·长城万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('464', '518474', null, '中国银行·长城万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('465', '518475', null, '中国银行·长城万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('466', '518476', null, '中国银行·长城万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('467', '438088', null, '中国银行·中银奥运信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('468', '524865', null, '中国银行·长城信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('469', '525745', null, '中国银行·长城信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('470', '525746', null, '中国银行·长城信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('471', '547766', null, '中国银行·长城万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('472', '552742', null, '中国银行·长城公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('473', '553131', null, '中国银行·长城公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('474', '558868', null, '中国银行·中银万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('475', '514958', null, '中国银行·中银万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('476', '622752', null, '中国银行·长城人民币信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('477', '622753', null, '中国银行·长城人民币信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('478', '622755', null, '中国银行·长城人民币信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('479', '524864', null, '中国银行·长城信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('480', '622757', null, '中国银行·长城人民币信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('481', '622758', null, '中国银行·长城人民币信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('482', '622759', null, '中国银行·长城信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('483', '622760', null, '中国银行·银联单币贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('484', '622761', null, '中国银行·长城信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('485', '622762', null, '中国银行·长城信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('486', '622763', null, '中国银行·长城信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('487', '601382', null, '中国银行·长城电子借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('488', '622756', null, '中国银行·长城人民币信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('489', '628388', null, '中国银行·银联标准公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('490', '621256', null, '中国银行·一卡双账户普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('491', '621212', null, '中国银行·财互通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('492', '620514', null, '中国银行·电子现金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('493', '622754', null, '中国银行·长城人民币信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('494', '622764', null, '中国银行·长城单位信用卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('495', '518377', null, '中国银行·中银女性主题信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('496', '622765', null, '中国银行·长城单位信用卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('497', '622788', null, '中国银行·白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('498', '621283', null, '中国银行·中职学生资助卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('499', '620061', null, '中国银行·银联标准卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('500', '621725', null, '中国银行·金融IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('501', '620040', null, '中国银行·长城社会保障卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('502', '558869', null, '中国银行·世界卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('503', '621330', null, '中国银行·社保联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('504', '621331', null, '中国银行·社保联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('505', '621332', null, '中国银行·医保联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('506', '621333', null, '中国银行·医保联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('507', '621297', null, '中国银行·公司借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('508', '377677', null, '中国银行·银联美运顶级卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('509', '621568', null, '中国银行·长城福农借记卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('510', '621569', null, '中国银行·长城福农借记卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('511', '625905', null, '中国银行·中行金融IC卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('512', '625906', null, '中国银行·中行金融IC卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('513', '625907', null, '中国银行·中行金融IC卡白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('514', '628313', null, '中国银行·长城银联公务IC卡白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('515', '625333', null, '中国银行·中银旅游信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('516', '628312', null, '中国银行·长城银联公务IC卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('517', '623208', null, '中国银行·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('518', '621620', null, '中国银行·武警军人保障卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('519', '621756', null, '中国银行·社保联名借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('520', '621757', null, '中国银行·社保联名借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('521', '621758', null, '中国银行·医保联名借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('522', '621759', null, '中国银行·医保联名借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('523', '621785', null, '中国银行·借记IC个人普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('524', '621786', null, '中国银行·借记IC个人金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('525', '621787', null, '中国银行·借记IC个人普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('526', '621788', null, '中国银行·借记IC白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('527', '621789', null, '中国银行·借记IC钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('528', '621790', null, '中国银行·借记IC联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('529', '621672', null, '中国银行·普通高中学生资助卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('530', '625337', null, '中国银行·长城环球通港澳台旅游金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('531', '625338', null, '中国银行·长城环球通港澳台旅游白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('532', '625568', null, '中国银行·中银福农信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('533', '621648', null, '中国银行金边分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('534', '621248', null, '中国银行雅加达分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('535', '621249', null, '中国银行首尔分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('536', '622750', null, '中国银行澳门分行·人民币信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('537', '622751', null, '中国银行澳门分行·人民币信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('538', '622771', null, '中国银行澳门分行·中银卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('539', '622772', null, '中国银行澳门分行·中银卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('540', '622770', null, '中国银行澳门分行·中银卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('541', '625145', null, '中国银行澳门分行·中银银联双币商务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('542', '620531', null, '中国银行澳门分行·预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('543', '620210', null, '中国银行澳门分行·澳门中国银行银联预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('544', '620211', null, '中国银行澳门分行·澳门中国银行银联预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('545', '622479', null, '中国银行澳门分行·熊猫卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('546', '622480', null, '中国银行澳门分行·财富卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('547', '622273', null, '中国银行澳门分行·银联港币卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('548', '622274', null, '中国银行澳门分行·银联澳门币卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('549', '621231', null, '中国银行马尼拉分行·双币种借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('550', '621638', null, '中国银行胡志明分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('551', '621334', null, '中国银行曼谷分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('552', '625140', null, '中国银行曼谷分行·长城信用卡环球通', null, null);
INSERT INTO `banks_card_bin` VALUES ('553', '621395', null, '中国银行曼谷分行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('554', '622725', null, '建设银行·龙卡准贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('555', '622728', null, '建设银行·龙卡准贷记卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('556', '621284', null, '建设银行·中职学生资助卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('557', '421349', null, '建设银行·乐当家银卡VISA', null, null);
INSERT INTO `banks_card_bin` VALUES ('558', '434061', null, '建设银行·乐当家金卡VISA', null, null);
INSERT INTO `banks_card_bin` VALUES ('559', '434062', null, '建设银行·乐当家白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('560', '436728', null, '建设银行·龙卡普通卡VISA', null, null);
INSERT INTO `banks_card_bin` VALUES ('561', '436742', null, '建设银行·龙卡储蓄卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('562', '453242', null, '建设银行·VISA准贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('563', '491031', null, '建设银行·VISA准贷记金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('564', '524094', null, '建设银行·乐当家', null, null);
INSERT INTO `banks_card_bin` VALUES ('565', '526410', null, '建设银行·乐当家', null, null);
INSERT INTO `banks_card_bin` VALUES ('566', '544033', null, '建设银行·准贷记金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('567', '552245', null, '建设银行·乐当家白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('568', '589970', null, '建设银行·金融复合IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('569', '620060', null, '建设银行·银联标准卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('570', '621080', null, '建设银行·银联理财钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('571', '621081', null, '建设银行·金融IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('572', '621466', null, '建设银行·理财白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('573', '621467', null, '建设银行·社保IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('574', '621488', null, '建设银行·财富卡私人银行卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('575', '621499', null, '建设银行·理财金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('576', '621598', null, '建设银行·福农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('577', '621621', null, '建设银行·武警军人保障卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('578', '621700', null, '建设银行·龙卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('579', '622280', null, '建设银行·银联储蓄卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('580', '622700', null, '建设银行·龙卡储蓄卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('581', '622707', null, '建设银行·准贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('582', '622966', null, '建设银行·理财白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('583', '622988', null, '建设银行·理财金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('584', '625955', null, '建设银行·准贷记卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('585', '625956', null, '建设银行·准贷记卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('586', '553242', null, '建设银行·龙卡信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('587', '621082', null, '建设银行·建行陆港通龙卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('588', '621673', null, '中国建设银行·普通高中学生资助卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('589', '623211', null, '中国建设银行·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('590', '356896', null, '中国建设银行·龙卡JCB金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('591', '356899', null, '中国建设银行·龙卡JCB白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('592', '356895', null, '中国建设银行·龙卡JCB普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('593', '436718', null, '中国建设银行·龙卡贷记卡公司卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('594', '436738', null, '中国建设银行·龙卡贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('595', '436745', null, '中国建设银行·龙卡国际普通卡VISA', null, null);
INSERT INTO `banks_card_bin` VALUES ('596', '436748', null, '中国建设银行·龙卡国际金卡VISA', null, null);
INSERT INTO `banks_card_bin` VALUES ('597', '489592', null, '中国建设银行·VISA白金信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('598', '531693', null, '中国建设银行·龙卡国际白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('599', '532450', null, '中国建设银行·龙卡国际普通卡MASTER', null, null);
INSERT INTO `banks_card_bin` VALUES ('600', '532458', null, '中国建设银行·龙卡国际金卡MASTER', null, null);
INSERT INTO `banks_card_bin` VALUES ('601', '544887', null, '中国建设银行·龙卡万事达金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('602', '552801', null, '中国建设银行·龙卡贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('603', '557080', null, '中国建设银行·龙卡万事达白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('604', '558895', null, '中国建设银行·龙卡贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('605', '559051', null, '中国建设银行·龙卡万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('606', '622166', null, '中国建设银行·龙卡人民币信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('607', '622168', null, '中国建设银行·龙卡人民币信用金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('608', '622708', null, '中国建设银行·龙卡人民币白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('609', '625964', null, '中国建设银行·龙卡IC信用卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('610', '625965', null, '中国建设银行·龙卡IC信用卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('611', '625966', null, '中国建设银行·龙卡IC信用卡白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('612', '628266', null, '中国建设银行·龙卡银联公务卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('613', '628366', null, '中国建设银行·龙卡银联公务卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('614', '625362', null, '中国建设银行·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('615', '625363', null, '中国建设银行·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('616', '628316', null, '中国建设银行·龙卡IC公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('617', '628317', null, '中国建设银行·龙卡IC公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('618', '620021', null, '交通银行·交行预付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('619', '620521', null, '交通银行·世博预付IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('620', '405512', null, '交通银行·太平洋互连卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('621', '601428', null, '交通银行·太平洋万事顺卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('622', '405512', null, '交通银行·太平洋互连卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('623', '434910', null, '交通银行·太平洋白金信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('624', '458123', null, '交通银行·太平洋双币贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('625', '458124', null, '交通银行·太平洋双币贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('626', '520169', null, '交通银行·太平洋双币贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('627', '522964', null, '交通银行·太平洋白金信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('628', '552853', null, '交通银行·太平洋双币贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('629', '601428', null, '交通银行·太平洋万事顺卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('630', '622250', null, '交通银行·太平洋人民币贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('631', '622251', null, '交通银行·太平洋人民币贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('632', '521899', null, '交通银行·太平洋双币贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('633', '622254', null, '交通银行·太平洋准贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('634', '622255', null, '交通银行·太平洋准贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('635', '622256', null, '交通银行·太平洋准贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('636', '622257', null, '交通银行·太平洋准贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('637', '622258', null, '交通银行·太平洋借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('638', '622259', null, '交通银行·太平洋借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('639', '622253', null, '交通银行·太平洋人民币贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('640', '622261', null, '交通银行·太平洋借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('641', '622284', null, '交通银行·太平洋MORE卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('642', '622656', null, '交通银行·白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('643', '628216', null, '交通银行·交通银行公务卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('644', '622252', null, '交通银行·太平洋人民币贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('645', '66405512', null, '交通银行·太平洋互连卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('646', '622260', null, '交通银行·太平洋借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('647', '66601428', null, '交通银行·太平洋万事顺卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('648', '955590', null, '交通银行·太平洋贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('649', '955591', null, '交通银行·太平洋贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('650', '955592', null, '交通银行·太平洋贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('651', '955593', null, '交通银行·太平洋贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('652', '628218', null, '交通银行·交通银行公务卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('653', '622262', null, '交通银行·交银IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('654', '621069', null, '交通银行香港分行·交通银行港币借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('655', '620013', null, '交通银行香港分行·港币礼物卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('656', '625028', null, '交通银行香港分行·双币种信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('657', '625029', null, '交通银行香港分行·双币种信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('658', '621436', null, '交通银行香港分行·双币卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('659', '621002', null, '交通银行香港分行·银联人民币卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('660', '621335', null, '交通银行澳门分行·银联借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('661', '433670', null, '中信银行·中信借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('662', '433680', null, '中信银行·中信借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('663', '442729', null, '中信银行·中信国际借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('664', '442730', null, '中信银行·中信国际借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('665', '620082', null, '中信银行·中国旅行卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('666', '622690', null, '中信银行·中信借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('667', '622691', null, '中信银行·中信借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('668', '622692', null, '中信银行·中信贵宾卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('669', '622696', null, '中信银行·中信理财宝金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('670', '622698', null, '中信银行·中信理财宝白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('671', '622998', null, '中信银行·中信钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('672', '622999', null, '中信银行·中信钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('673', '433671', null, '中信银行·中信借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('674', '968807', null, '中信银行·中信理财宝(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('675', '968808', null, '中信银行·中信理财宝(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('676', '968809', null, '中信银行·中信理财宝(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('677', '621771', null, '中信银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('678', '621767', null, '中信银行·理财宝IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('679', '621768', null, '中信银行·理财宝IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('680', '621770', null, '中信银行·理财宝IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('681', '621772', null, '中信银行·理财宝IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('682', '621773', null, '中信银行·理财宝IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('683', '620527', null, '中信银行·主账户复合电子现金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('684', '356837', null, '光大银行·阳光商旅信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('685', '356838', null, '光大银行·阳光商旅信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('686', '486497', null, '光大银行·阳光商旅信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('687', '622660', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('688', '622662', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('689', '622663', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('690', '622664', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('691', '622665', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('692', '622666', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('693', '622667', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('694', '622669', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('695', '622670', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('696', '622671', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('697', '622672', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('698', '622668', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('699', '622661', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('700', '622674', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('701', '622673', null, '光大银行·阳光卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('702', '620518', null, '光大银行·借记卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('703', '621489', null, '光大银行·社会保障IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('704', '621492', null, '光大银行·IC借记卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('705', '620535', null, '光大银行·手机支付卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('706', '623156', null, '光大银行·联名IC卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('707', '621490', null, '光大银行·借记IC卡白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('708', '621491', null, '光大银行·借记IC卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('709', '620085', null, '光大银行·阳光旅行卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('710', '623155', null, '光大银行·借记IC卡钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('711', '623157', null, '光大银行·联名IC卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('712', '623158', null, '光大银行·联名IC卡白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('713', '623159', null, '光大银行·联名IC卡钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('714', '999999', null, '华夏银行·华夏卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('715', '621222', null, '华夏银行·华夏白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('716', '623020', null, '华夏银行·华夏普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('717', '623021', null, '华夏银行·华夏金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('718', '623022', null, '华夏银行·华夏白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('719', '623023', null, '华夏银行·华夏钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('720', '622630', null, '华夏银行·华夏卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('721', '622631', null, '华夏银行·华夏至尊金卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('722', '622632', null, '华夏银行·华夏丽人卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('723', '622633', null, '华夏银行·华夏万通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('724', '622615', null, '民生银行·民生借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('725', '622616', null, '民生银行·民生银联借记卡－金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('726', '622618', null, '民生银行·钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('727', '622622', null, '民生银行·民生借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('728', '622617', null, '民生银行·民生借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('729', '622619', null, '民生银行·民生借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('730', '415599', null, '民生银行·民生借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('731', '421393', null, '民生银行·民生国际卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('732', '421865', null, '民生银行·民生国际卡(银卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('733', '427570', null, '民生银行·民生国际卡(欧元卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('734', '427571', null, '民生银行·民生国际卡(澳元卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('735', '472067', null, '民生银行·民生国际卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('736', '472068', null, '民生银行·民生国际卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('737', '622620', null, '民生银行·薪资理财卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('738', '621691', null, '民生银行·借记卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('739', '545392', null, '民生银行·民生MasterCard', null, null);
INSERT INTO `banks_card_bin` VALUES ('740', '545393', null, '民生银行·民生MasterCard', null, null);
INSERT INTO `banks_card_bin` VALUES ('741', '545431', null, '民生银行·民生MasterCard', null, null);
INSERT INTO `banks_card_bin` VALUES ('742', '545447', null, '民生银行·民生MasterCard', null, null);
INSERT INTO `banks_card_bin` VALUES ('743', '356859', null, '民生银行·民生JCB信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('744', '356857', null, '民生银行·民生JCB金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('745', '407405', null, '民生银行·民生贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('746', '421869', null, '民生银行·民生贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('747', '421870', null, '民生银行·民生贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('748', '421871', null, '民生银行·民生贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('749', '512466', null, '民生银行·民生贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('750', '356856', null, '民生银行·民生JCB普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('751', '528948', null, '民生银行·民生贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('752', '552288', null, '民生银行·民生贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('753', '622600', null, '民生银行·民生信用卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('754', '622601', null, '民生银行·民生信用卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('755', '622602', null, '民生银行·民生银联白金信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('756', '517636', null, '民生银行·民生贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('757', '622621', null, '民生银行·民生银联个人白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('758', '628258', null, '民生银行·公务卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('759', '556610', null, '民生银行·民生贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('760', '622603', null, '民生银行·民生银联商务信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('761', '464580', null, '民生银行·民VISA无限卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('762', '464581', null, '民生银行·民生VISA商务白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('763', '523952', null, '民生银行·民生万事达钛金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('764', '545217', null, '民生银行·民生万事达世界卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('765', '553161', null, '民生银行·民生万事达白金公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('766', '356858', null, '民生银行·民生JCB白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('767', '622623', null, '民生银行·银联标准金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('768', '625911', null, '民生银行·银联芯片普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('769', '377152', null, '民生银行·民生运通双币信用卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('770', '377153', null, '民生银行·民生运通双币信用卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('771', '377158', null, '民生银行·民生运通双币信用卡钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('772', '377155', null, '民生银行·民生运通双币标准信用卡白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('773', '625912', null, '民生银行·银联芯片金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('774', '625913', null, '民生银行·银联芯片白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('775', '356885', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('776', '356886', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('777', '356887', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('778', '356888', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('779', '356890', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('780', '402658', null, '招商银行·两地一卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('781', '410062', null, '招商银行·招行国际卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('782', '439188', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('783', '439227', null, '招商银行·VISA商务信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('784', '468203', null, '招商银行·招行国际卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('785', '479228', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('786', '479229', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('787', '512425', null, '招商银行·招行国际卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('788', '521302', null, '招商银行·世纪金花联名信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('789', '524011', null, '招商银行·招行国际卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('790', '356889', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('791', '545620', null, '招商银行·万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('792', '545621', null, '招商银行·万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('793', '545947', null, '招商银行·万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('794', '545948', null, '招商银行·万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('795', '552534', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('796', '552587', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('797', '622575', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('798', '622576', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('799', '622577', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('800', '622579', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('801', '622580', null, '招商银行·一卡通(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('802', '545619', null, '招商银行·万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('803', '622581', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('804', '622582', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('805', '622588', null, '招商银行·一卡通(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('806', '622598', null, '招商银行·公司卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('807', '622609', null, '招商银行·金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('808', '690755', null, '招商银行·招行一卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('809', '690755', null, '招商银行·招行一卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('810', '545623', null, '招商银行·万事达信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('811', '621286', null, '招商银行·金葵花卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('812', '620520', null, '招商银行·电子现金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('813', '621483', null, '招商银行·银联IC普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('814', '621485', null, '招商银行·银联IC金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('815', '621486', null, '招商银行·银联金葵花IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('816', '628290', null, '招商银行·IC公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('817', '622578', null, '招商银行·招商银行信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('818', '370285', null, '招商银行信用卡中心·美国运通绿卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('819', '370286', null, '招商银行信用卡中心·美国运通金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('820', '370287', null, '招商银行信用卡中心·美国运通商务绿卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('821', '370289', null, '招商银行信用卡中心·美国运通商务金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('822', '439225', null, '招商银行信用卡中心·VISA信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('823', '518710', null, '招商银行信用卡中心·MASTER信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('824', '518718', null, '招商银行信用卡中心·MASTER信用金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('825', '628362', null, '招商银行信用卡中心·银联标准公务卡(金卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('826', '439226', null, '招商银行信用卡中心·VISA信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('827', '628262', null, '招商银行信用卡中心·银联标准财政公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('828', '625802', null, '招商银行信用卡中心·芯片IC信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('829', '625803', null, '招商银行信用卡中心·芯片IC信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('830', '621299', null, '招商银行香港分行·香港一卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('831', '966666', null, '兴业银行·兴业卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('832', '622909', null, '兴业银行·兴业卡(银联标准卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('833', '622908', null, '兴业银行·兴业自然人生理财卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('834', '438588', null, '兴业银行·兴业智能卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('835', '438589', null, '兴业银行·兴业智能卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('836', '461982', null, '兴业银行·visa标准双币个人普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('837', '486493', null, '兴业银行·VISA商务普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('838', '486494', null, '兴业银行·VISA商务金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('839', '486861', null, '兴业银行·VISA运动白金信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('840', '523036', null, '兴业银行·万事达信用卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('841', '451289', null, '兴业银行·VISA信用卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('842', '527414', null, '兴业银行·加菲猫信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('843', '528057', null, '兴业银行·个人白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('844', '622901', null, '兴业银行·银联信用卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('845', '622902', null, '兴业银行·银联信用卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('846', '622922', null, '兴业银行·银联白金信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('847', '628212', null, '兴业银行·银联标准公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('848', '451290', null, '兴业银行·VISA信用卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('849', '524070', null, '兴业银行·万事达信用卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('850', '625084', null, '兴业银行·银联标准贷记普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('851', '625085', null, '兴业银行·银联标准贷记金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('852', '625086', null, '兴业银行·银联标准贷记金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('853', '625087', null, '兴业银行·银联标准贷记金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('854', '548738', null, '兴业银行·兴业信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('855', '549633', null, '兴业银行·兴业信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('856', '552398', null, '兴业银行·兴业信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('857', '625082', null, '兴业银行·银联标准贷记普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('858', '625083', null, '兴业银行·银联标准贷记普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('859', '625960', null, '兴业银行·兴业芯片普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('860', '625961', null, '兴业银行·兴业芯片金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('861', '625962', null, '兴业银行·兴业芯片白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('862', '625963', null, '兴业银行·兴业芯片钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('863', '356851', null, '浦东发展银行·浦发JCB金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('864', '356852', null, '浦东发展银行·浦发JCB白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('865', '404738', null, '浦东发展银行·信用卡VISA普通', null, null);
INSERT INTO `banks_card_bin` VALUES ('866', '404739', null, '浦东发展银行·信用卡VISA金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('867', '456418', null, '浦东发展银行·浦发银行VISA年青卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('868', '498451', null, '浦东发展银行·VISA白金信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('869', '515672', null, '浦东发展银行·浦发万事达白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('870', '356850', null, '浦东发展银行·浦发JCB普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('871', '517650', null, '浦东发展银行·浦发万事达金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('872', '525998', null, '浦东发展银行·浦发万事达普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('873', '622177', null, '浦东发展银行·浦发单币卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('874', '622277', null, '浦东发展银行·浦发银联单币麦兜普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('875', '622516', null, '浦东发展银行·东方轻松理财卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('876', '622517', null, '浦东发展银行·东方-轻松理财卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('877', '622518', null, '浦东发展银行·东方轻松理财卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('878', '622520', null, '浦东发展银行·东方轻松理财智业金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('879', '622521', null, '浦东发展银行·东方卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('880', '622522', null, '浦东发展银行·东方卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('881', '622523', null, '浦东发展银行·东方卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('882', '628222', null, '浦东发展银行·公务卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('883', '628221', null, '浦东发展银行·公务卡普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('884', '984301', null, '浦东发展银行·东方卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('885', '984303', null, '浦东发展银行·东方卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('886', '622176', null, '浦东发展银行·浦发单币卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('887', '622276', null, '浦东发展银行·浦发联名信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('888', '622228', null, '浦东发展银行·浦发银联白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('889', '621352', null, '浦东发展银行·轻松理财普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('890', '621351', null, '浦东发展银行·移动联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('891', '621390', null, '浦东发展银行·轻松理财消贷易卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('892', '621792', null, '浦东发展银行·轻松理财普卡（复合卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('893', '625957', null, '浦东发展银行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('894', '625958', null, '浦东发展银行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('895', '621791', null, '浦东发展银行·东方借记卡（复合卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('896', '620530', null, '浦东发展银行·电子现金卡（IC卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('897', '625993', null, '浦东发展银行·移动浦发联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('898', '622519', null, '浦东发展银行·东方-标准准贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('899', '621793', null, '浦东发展银行·轻松理财金卡（复合卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('900', '621795', null, '浦东发展银行·轻松理财白金卡（复合卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('901', '621796', null, '浦东发展银行·轻松理财钻石卡（复合卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('902', '622500', null, '浦东发展银行·东方卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('903', '623078', null, '恒丰银行·九州IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('904', '622384', null, '恒丰银行·九州借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('905', '940034', null, '恒丰银行·九州借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('906', '940015', null, '天津市商业银行·银联卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('907', '622886', null, '烟台商业银行·金通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('908', '622391', null, '潍坊银行·鸢都卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('909', '940072', null, '潍坊银行·鸳都卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('910', '622359', null, '临沂商业银行·沂蒙卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('911', '940066', null, '临沂商业银行·沂蒙卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('912', '622857', null, '日照市商业银行·黄海卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('913', '940065', null, '日照市商业银行·黄海卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('914', '621019', null, '浙商银行·商卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('915', '622309', null, '浙商银行·商卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('916', '621268', null, '渤海银行·浩瀚金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('917', '622884', null, '渤海银行·渤海银行借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('918', '621453', null, '渤海银行·金融IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('919', '622684', null, '渤海银行·渤海银行公司借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('920', '621016', null, '星展银行·星展银行借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('921', '621015', null, '星展银行·星展银行借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('922', '622950', null, '恒生银行·恒生通财卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('923', '622951', null, '恒生银行·恒生优越通财卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('924', '621072', null, '新韩银行·新韩卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('925', '623183', null, '上海银行·慧通钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('926', '623185', null, '上海银行·慧通金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('927', '621005', null, '上海银行·私人银行卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('928', '622172', null, '上海银行·综合保险卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('929', '622985', null, '上海银行·申卡社保副卡(有折)', null, null);
INSERT INTO `banks_card_bin` VALUES ('930', '622987', null, '上海银行·申卡社保副卡(无折)', null, null);
INSERT INTO `banks_card_bin` VALUES ('931', '622267', null, '上海银行·白金IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('932', '622278', null, '上海银行·慧通白金卡(配折)', null, null);
INSERT INTO `banks_card_bin` VALUES ('933', '622279', null, '上海银行·慧通白金卡(不配折)', null, null);
INSERT INTO `banks_card_bin` VALUES ('934', '622468', null, '上海银行·申卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('935', '622892', null, '上海银行·申卡借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('936', '940021', null, '上海银行·银联申卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('937', '621050', null, '上海银行·单位借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('938', '620522', null, '上海银行·首发纪念版IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('939', '356827', null, '上海银行·申卡贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('940', '356828', null, '上海银行·申卡贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('941', '356830', null, '上海银行·J分期付款信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('942', '402673', null, '上海银行·申卡贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('943', '402674', null, '上海银行·申卡贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('944', '438600', null, '上海银行·上海申卡IC', null, null);
INSERT INTO `banks_card_bin` VALUES ('945', '486466', null, '上海银行·申卡贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('946', '519498', null, '上海银行·申卡贷记卡普通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('947', '520131', null, '上海银行·申卡贷记卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('948', '524031', null, '上海银行·万事达白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('949', '548838', null, '上海银行·万事达星运卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('950', '622148', null, '上海银行·申卡贷记卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('951', '622149', null, '上海银行·申卡贷记卡普通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('952', '622268', null, '上海银行·安融卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('953', '356829', null, '上海银行·分期付款信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('954', '622300', null, '上海银行·信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('955', '628230', null, '上海银行·个人公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('956', '622269', null, '上海银行·安融卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('957', '625099', null, '上海银行·上海银行银联白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('958', '625953', null, '上海银行·贷记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('959', '625350', null, '上海银行·中国旅游卡（IC普卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('960', '625351', null, '上海银行·中国旅游卡（IC金卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('961', '625352', null, '上海银行·中国旅游卡（IC白金卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('962', '519961', null, '上海银行·万事达钻石卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('963', '625839', null, '上海银行·淘宝IC普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('964', '421317', null, '北京银行·京卡借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('965', '602969', null, '北京银行·京卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('966', '621030', null, '北京银行·京卡借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('967', '621420', null, '北京银行·京卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('968', '621468', null, '北京银行·京卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('969', '623111', null, '北京银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('970', '422160', null, '北京银行·京卡贵宾金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('971', '422161', null, '北京银行·京卡贵宾白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('972', '622865', null, '吉林银行·君子兰一卡通(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('973', '940012', null, '吉林银行·君子兰卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('974', '623131', null, '吉林银行·长白山金融IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('975', '622178', null, '吉林银行·信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('976', '622179', null, '吉林银行·信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('977', '628358', null, '吉林银行·公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('978', '622394', null, '镇江市商业银行·金山灵通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('979', '940025', null, '镇江市商业银行·金山灵通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('980', '621279', null, '宁波银行·银联标准卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('981', '622281', null, '宁波银行·汇通借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('982', '622316', null, '宁波银行·汇通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('983', '940022', null, '宁波银行·明州卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('984', '621418', null, '宁波银行·汇通借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('985', '512431', null, '宁波银行·汇通国际卡银联双币卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('986', '520194', null, '宁波银行·汇通国际卡银联双币卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('987', '621626', null, '平安银行·新磁条借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('988', '623058', null, '平安银行·平安银行IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('989', '602907', null, '平安银行·万事顺卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('990', '622986', null, '平安银行·平安银行借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('991', '622989', null, '平安银行·平安银行借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('992', '622298', null, '平安银行·万事顺借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('993', '622338', null, '焦作市商业银行·月季借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('994', '940032', null, '焦作市商业银行·月季城市通(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('995', '623205', null, '焦作市商业银行·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('996', '621977', null, '温州银行·金鹿卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('997', '990027', null, '汉口银行·九通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('998', '622325', null, '汉口银行·九通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('999', '623029', null, '汉口银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1000', '623105', null, '汉口银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1001', '621244', null, '盛京银行·玫瑰卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1002', '623081', null, '盛京银行·玫瑰IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1003', '623108', null, '盛京银行·玫瑰IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1004', '566666', null, '盛京银行·玫瑰卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1005', '622455', null, '盛京银行·玫瑰卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1006', '940039', null, '盛京银行·玫瑰卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1007', '622466', null, '盛京银行·玫瑰卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1008', '628285', null, '盛京银行·盛京银行公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1009', '622420', null, '洛阳银行·都市一卡通(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1010', '940041', null, '洛阳银行·都市一卡通(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1011', '623118', null, '洛阳银行·--', null, null);
INSERT INTO `banks_card_bin` VALUES ('1012', '603708', null, '大连银行·北方明珠卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1013', '622993', null, '大连银行·人民币借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1014', '623070', null, '大连银行·金融IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1015', '623069', null, '大连银行·大连市社会保障卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1016', '623172', null, '大连银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1017', '623173', null, '大连银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1018', '622383', null, '大连银行·大连市商业银行贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1019', '622385', null, '大连银行·大连市商业银行贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1020', '628299', null, '大连银行·银联标准公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1021', '603506', null, '苏州市商业银行·姑苏卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1022', '603367', null, '杭州商业银行·西湖卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1023', '622878', null, '杭州商业银行·西湖卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1024', '623061', null, '杭州商业银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1025', '623209', null, '杭州商业银行·', null, null);
INSERT INTO `banks_card_bin` VALUES ('1026', '628242', null, '南京银行·梅花信用卡公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1027', '622595', null, '南京银行·梅花信用卡商务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1028', '622303', null, '南京银行·梅花贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1029', '622305', null, '南京银行·梅花借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1030', '621259', null, '南京银行·白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1031', '622596', null, '南京银行·商务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1032', '622333', null, '东莞市商业银行·万顺通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1033', '940050', null, '东莞市商业银行·万顺通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1034', '621439', null, '东莞市商业银行·万顺通借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1035', '623010', null, '东莞市商业银行·社会保障卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1036', '621751', null, '乌鲁木齐市商业银行·雪莲借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1037', '628278', null, '乌鲁木齐市商业银行·乌鲁木齐市公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1038', '625502', null, '乌鲁木齐市商业银行·福农卡贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1039', '625503', null, '乌鲁木齐市商业银行·福农卡准贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1040', '625135', null, '乌鲁木齐市商业银行·雪莲准贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1041', '622476', null, '乌鲁木齐市商业银行·雪莲贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1042', '621754', null, '乌鲁木齐市商业银行·雪莲借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1043', '622143', null, '乌鲁木齐市商业银行·雪莲借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1044', '940001', null, '乌鲁木齐市商业银行·雪莲卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1045', '623026', null, '绍兴银行·兰花IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1046', '623086', null, '绍兴银行·社保IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1047', '628291', null, '绍兴银行·兰花公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1048', '621532', null, '成都商业银行·芙蓉锦程福农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1049', '621482', null, '成都商业银行·芙蓉锦程天府通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1050', '622135', null, '成都商业银行·锦程卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1051', '622152', null, '成都商业银行·锦程卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1052', '622153', null, '成都商业银行·锦程卡定活一卡通金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1053', '622154', null, '成都商业银行·锦程卡定活一卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('1054', '622996', null, '成都商业银行·锦程力诚联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1055', '622997', null, '成都商业银行·锦程力诚联名卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1056', '940027', null, '成都商业银行·锦程卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1057', '623099', null, '抚顺银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1058', '623007', null, '临商银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1059', '940055', null, '宜昌市商业银行·三峡卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1060', '622397', null, '宜昌市商业银行·信用卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1061', '622398', null, '葫芦岛市商业银行·一通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1062', '940054', null, '葫芦岛市商业银行·一卡通(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1063', '622331', null, '天津市商业银行·津卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1064', '622426', null, '天津市商业银行·津卡贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1065', '625995', null, '天津市商业银行·贷记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1066', '621452', null, '天津市商���银行·--', null, null);
INSERT INTO `banks_card_bin` VALUES ('1067', '628205', null, '天津银行·商务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1068', '628214', null, '宁夏银行·宁夏银行公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1069', '625529', null, '宁夏银行·宁夏银行福农贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1070', '622428', null, '宁夏银行·如意卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1071', '621529', null, '宁夏银行·宁夏银行福农借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1072', '622429', null, '宁夏银行·如意借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1073', '621417', null, '宁夏银行·如意IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1074', '623089', null, '宁夏银行·宁夏银行如意借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1075', '623200', null, '宁夏银行·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1076', '940057', null, '齐商银行·金达卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1077', '622311', null, '齐商银行·金达借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1078', '623119', null, '齐商银行·金达IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1079', '622877', null, '徽商银行·黄山卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1080', '622879', null, '徽商银行·黄山卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1081', '621775', null, '徽商银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1082', '623203', null, '徽商银行·徽商银行中国旅游卡（安徽）', null, null);
INSERT INTO `banks_card_bin` VALUES ('1083', '603601', null, '徽商银行合肥分行·黄山卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1084', '622137', null, '徽商银行芜湖分行·黄山卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1085', '622327', null, '徽商银行马鞍山分行·黄山卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1086', '622340', null, '徽商银行淮北分行·黄山卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1087', '622366', null, '徽商银行安庆分行·黄山卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1088', '622134', null, '重庆银行·长江卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1089', '940018', null, '重庆银行·长江卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1090', '623016', null, '重庆银行·长江卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1091', '623096', null, '重庆银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1092', '940049', null, '哈尔滨银行·丁香一卡通(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1093', '622425', null, '哈尔滨银行·丁香借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1094', '622425', null, '哈尔滨银行·丁香卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1095', '621577', null, '哈尔滨银行·福农借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1096', '622485', null, '无锡市商业银行·太湖金保卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1097', '623098', null, '丹东银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1098', '628329', null, '丹东银行·丹东银行公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1099', '621538', null, '兰州银行·敦煌卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1100', '940006', null, '南昌银行·金瑞卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1101', '621269', null, '南昌银行·南昌银行借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1102', '622275', null, '南昌银行·金瑞卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1103', '621216', null, '晋商银行·晋龙一卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('1104', '622465', null, '晋商银行·晋龙一卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('1105', '940031', null, '晋商银行·晋龙卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1106', '621252', null, '青岛银行·金桥通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1107', '622146', null, '青岛银行·金桥卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1108', '940061', null, '青岛银行·金桥卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1109', '621419', null, '青岛银行·金桥卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1110', '623170', null, '青岛银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1111', '622440', null, '吉林银行·雾凇卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1112', '940047', null, '吉林银行·雾凇卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1113', '940017', null, '南通商业银行·金桥卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1114', '622418', null, '南通商业银行·金桥卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1115', '623077', null, '日照银行·黄海卡、财富卡借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1116', '622413', null, '鞍山银行·千山卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1117', '940002', null, '鞍山银行·千山卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1118', '623188', null, '鞍山银行·千山卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1119', '622310', null, '青海银行·三江银行卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1120', '940068', null, '青海银行·三江卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1121', '622321', null, '台州银行·大唐贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1122', '625001', null, '台州银行·大唐准贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1123', '622427', null, '台州银行·大唐卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1124', '940069', null, '台州银行·大唐卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1125', '623039', null, '台州银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1126', '628273', null, '台州银行·公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1127', '622370', null, '泉州银行·海峡银联卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1128', '683970', null, '泉州银行·海峡储蓄卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1129', '940074', null, '泉州银行·海峡银联卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1130', '621437', null, '泉州银行·海峡卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1131', '628319', null, '泉州银行·公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1132', '990871', null, '昆明商业银行·春城卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1133', '622308', null, '昆明商业银行·春城卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1134', '621415', null, '昆明商业银行·富滇IC卡（复合卡）', null, null);
INSERT INTO `banks_card_bin` VALUES ('1135', '623166', null, '阜新银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1136', '622132', null, '嘉兴银行·南湖借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1137', '621340', null, '廊坊银行·白金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1138', '621341', null, '廊坊银行·金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1139', '622140', null, '廊坊银行·银星卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1140', '623073', null, '廊坊银行·龙凤呈祥卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1141', '622147', null, '内蒙古银行·百灵卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1142', '621633', null, '内蒙古银行·成吉思汗卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1143', '622301', null, '湖州市商业银行·百合卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1144', '623171', null, '湖州市商业银行·', null, null);
INSERT INTO `banks_card_bin` VALUES ('1145', '621422', null, '沧州银行·狮城卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1146', '622335', null, '南宁市商业银行·桂花卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1147', '622336', null, '包商银行·雄鹰卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1148', '622165', null, '包商银行·包头市商业银行借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1149', '622315', null, '包商银行·雄鹰贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1150', '628295', null, '包商银行·包商银行内蒙古自治区公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1151', '625950', null, '包商银行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1152', '621760', null, '包商银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1153', '622337', null, '连云港市商业银行·金猴神通借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1154', '622411', null, '威海商业银行·通达卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1155', '623102', null, '威海市商业银行·通达借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1156', '622342', null, '攀枝花市商业银行·攀枝花卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1157', '623048', null, '攀枝花市商业银行·攀枝花卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1158', '622367', null, '绵阳市商业银行·科技城卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1159', '622392', null, '泸州市商业银行·酒城卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1160', '623085', null, '泸州市商业银行·酒城IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1161', '622395', null, '大同市商业银行·云冈卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1162', '622441', null, '三门峡银行·天鹅卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1163', '622448', null, '广东南粤银行·南珠卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1164', '621413', null, '张家口市商业银行·好运IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1165', '622856', null, '桂林市商业银行·漓江卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1166', '621037', null, '龙江银行·福农借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1167', '621097', null, '龙江银行·联名借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1168', '621588', null, '龙江银行·福农借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1169', '623032', null, '龙江银行·龙江IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1170', '622644', null, '龙江银行·社会保障卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1171', '623518', null, '龙江银行·--', null, null);
INSERT INTO `banks_card_bin` VALUES ('1172', '622870', null, '江苏长江商业银行·长江卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1173', '622866', null, '徐州市商业银行·彭城借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1174', '623072', null, '南充市商业银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1175', '622897', null, '南充市商业银行·熊猫团团卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1176', '628279', null, '莱商银行·银联标准卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1177', '622864', null, '莱芜银行·金凤卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1178', '621403', null, '莱商银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1179', '622561', null, '德阳银行·锦程卡定活一卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('1180', '622562', null, '德阳银行·锦程卡定活一卡通金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1181', '622563', null, '德阳银行·锦程卡定活一卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('1182', '622167', null, '唐山市商业银行·唐山市城通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1183', '622777', null, '曲靖市商业银行·珠江源卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1184', '621497', null, '曲靖市商业银行·珠江源IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1185', '622868', null, '温州银行·金鹿信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1186', '622899', null, '温州银行·金鹿信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1187', '628255', null, '温州银行·金鹿公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1188', '625988', null, '温州银行·贷记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1189', '622566', null, '汉口银行·汉口银行贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1190', '622567', null, '汉口银行·汉口银行贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1191', '622625', null, '汉口银行·九通香港旅游贷记普卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1192', '622626', null, '汉口银行·九通香港旅游贷记金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1193', '625946', null, '汉口银行·贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1194', '628200', null, '汉口银行·九通公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1195', '621076', null, '江苏银行·聚宝借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1196', '504923', null, '江苏银行·月季卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1197', '622173', null, '江苏银行·紫金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1198', '622422', null, '江苏银行·绿扬卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1199', '622447', null, '江苏银行·月季卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1200', '622131', null, '江苏银行·九州借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1201', '940076', null, '江苏银行·月季卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1202', '621579', null, '江苏银行·聚宝惠民福农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1203', '622876', null, '江苏银行·江苏银行聚宝IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1204', '622873', null, '江苏银行·聚宝IC借记卡VIP卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1205', '622962', null, '长治市商业银行·长治商行银联晋龙卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1206', '622936', null, '承德市商业银行·热河卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1207', '623060', null, '承德银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1208', '622937', null, '德州银行·长河借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1209', '623101', null, '德州银行·--', null, null);
INSERT INTO `banks_card_bin` VALUES ('1210', '621460', null, '遵义市商业银行·社保卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1211', '622939', null, '遵义市商业银行·尊卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1212', '622960', null, '邯郸市商业银行·邯银卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1213', '623523', null, '邯郸市商业银行·邯郸银行贵宾IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1214', '621591', null, '安顺市商业银行·黄果树福农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1215', '622961', null, '安顺市商业银行·黄果树借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1216', '628210', null, '江苏银行·紫金信用卡(公务卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1217', '622283', null, '江苏银行·紫金信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1218', '625902', null, '江苏银行·天翼联名信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1219', '621010', null, '平凉市商业银行·广成卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1220', '622980', null, '玉溪市商业银行·红塔卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1221', '623135', null, '玉溪市商业银行·红塔卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1222', '621726', null, '浙江民泰商业银行·金融IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1223', '621088', null, '浙江民泰商业银行·民泰借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1224', '620517', null, '浙江民泰商业银行·金融IC卡C卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1225', '622740', null, '浙江民泰商业银行·银联标准普卡金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1226', '625036', null, '浙江民泰商业银行·商惠通', null, null);
INSERT INTO `banks_card_bin` VALUES ('1227', '621014', null, '上饶市商业银行·三清山卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1228', '621004', null, '东营银行·胜利卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1229', '622972', null, '泰安市商业银行·岱宗卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1230', '623196', null, '泰安市商业银行·市民一卡通', null, null);
INSERT INTO `banks_card_bin` VALUES ('1231', '621028', null, '浙江稠州商业银行·义卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1232', '623083', null, '浙江稠州商业银行·义卡借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1233', '628250', null, '浙江稠州商业银行·公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1234', '623121', null, '自贡市商业银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1235', '621070', null, '自贡市商业银行·锦程卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1236', '628253', null, '鄂尔多斯银行·天骄公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1237', '622979', null, '鹤壁银行·鹤卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1238', '621035', null, '许昌银行·连城卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1239', '621038', null, '铁岭银行·龙凤卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1240', '621086', null, '乐山市商业银行·大福卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1241', '621498', null, '乐山市商业银行·--', null, null);
INSERT INTO `banks_card_bin` VALUES ('1242', '621296', null, '长安银行·长长卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1243', '621448', null, '长安银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1244', '622945', null, '重庆三峡银行·财富人生卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1245', '621755', null, '重庆三峡银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1246', '622940', null, '石嘴山银行·麒麟借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1247', '623120', null, '石嘴山银行·麒麟借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1248', '628355', null, '石嘴山银行·麒麟公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1249', '621089', null, '盘锦市商业银行·鹤卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1250', '623161', null, '盘锦市商业银行·盘锦市商业银行鹤卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1251', '628339', null, '平顶山银行·平顶山银行公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1252', '621074', null, '朝阳银行·鑫鑫通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1253', '621515', null, '朝阳银行·朝阳银行福农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1254', '623030', null, '朝阳银行·红山卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1255', '621345', null, '宁波东海银行·绿叶卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1256', '621090', null, '遂宁市商业银行·锦程卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1257', '623178', null, '遂宁是商业银行·金荷卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1258', '621091', null, '保定银行·直隶卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1259', '623168', null, '保定银行·直隶卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1260', '621057', null, '凉山州商业银行·锦程卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1261', '623199', null, '凉山州商业银行·金凉山卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1262', '621075', null, '漯河银行·福卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1263', '623037', null, '漯河银行·福源卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1264', '628303', null, '漯河银行·福源公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1265', '621233', null, '达州市商业银行·锦程卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1266', '621235', null, '新乡市商业银行·新卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1267', '621223', null, '晋中银行·九州方圆借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1268', '621780', null, '晋中银行·九州方圆卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1269', '621221', null, '驻马店银行·驿站卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1270', '623138', null, '驻马店银行·驿站卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1271', '628389', null, '驻马店银行·公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1272', '621239', null, '衡水银行·金鼎卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1273', '623068', null, '衡水银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1274', '621271', null, '周口银行·如愿卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1275', '628315', null, '周口银行·公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1276', '621272', null, '阳泉市商业银行·金鼎卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1277', '621738', null, '阳泉市商业银行·金鼎卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1278', '621273', null, '宜宾市商业银行·锦程卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1279', '623079', null, '宜宾市商业银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1280', '621263', null, '库尔勒市商业银行·孔雀胡杨卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1281', '621325', null, '雅安市商业银行·锦城卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1282', '623084', null, '雅安市商业银行·--', null, null);
INSERT INTO `banks_card_bin` VALUES ('1283', '621327', null, '安阳银行·安鼎卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1284', '621753', null, '信阳银行·信阳卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1285', '628331', null, '信阳银行·公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1286', '623160', null, '信阳银行·信阳卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1287', '621366', null, '华融湘江银行·华融卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1288', '621388', null, '华融湘江银行·华融卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1289', '621348', null, '营口沿海银行·祥云借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1290', '621359', null, '景德镇商业银行·瓷都卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1291', '621360', null, '哈密市商业银行·瓜香借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1292', '621217', null, '湖北银行·金牛卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1293', '622959', null, '湖北银行·汉江卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1294', '621270', null, '湖北银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1295', '622396', null, '湖北银行·三峡卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1296', '622511', null, '湖北银行·至尊卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1297', '623076', null, '湖北银行·金融IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1298', '621391', null, '西藏银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1299', '621339', null, '新疆汇和银行·汇和卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1300', '621469', null, '广东华兴银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1301', '621625', null, '广东华兴银行·华兴银联公司卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1302', '623688', null, '广东华兴银行·华兴联名IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1303', '623113', null, '广东华兴银行·华兴金融IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1304', '621601', null, '濮阳银行·龙翔卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1305', '621655', null, '宁波通商银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1306', '621636', null, '甘肃银行·神舟兴陇借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1307', '623182', null, '甘肃银行·甘肃银行神州兴陇IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1308', '623087', null, '枣庄银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1309', '621696', null, '本溪市商业银行·借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1310', '622955', null, '盛京银行·医保卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1311', '622478', null, '上海农商银行·如意卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1312', '940013', null, '上海农商银行·如意卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1313', '621495', null, '上海农商银行·鑫通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1314', '621688', null, '上海农商银行·国际如意卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1315', '623162', null, '上海农商银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1316', '622462', null, '常熟市农村商业银行·粒金贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1317', '628272', null, '常熟市农村商业银行·公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1318', '625101', null, '常熟市农村商业银行·粒金准贷卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1319', '622323', null, '常熟农村商业银行·粒金借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1320', '623071', null, '常熟农村商业银行·粒金IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1321', '603694', null, '常熟农村商业银行·粒金卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1322', '622128', null, '深圳农村商业银行·信通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1323', '622129', null, '深圳农村商业银行·信通商务卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1324', '623035', null, '深圳农村商业银行·信通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1325', '623186', null, '深圳农村商业银行·信通商务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1326', '621522', null, '广州农村商业银行·福农太阳卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1327', '622271', null, '广东南海农村商业银行·盛通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1328', '940037', null, '广东南海农村商业银行·盛通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1329', '940038', null, '佛山顺德农村商业银行·恒通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1330', '985262', null, '佛山顺德农村商业银行·恒通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1331', '622322', null, '佛山顺德农村商业银行·恒通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1332', '628381', null, '江阴农村商业银行·暨阳公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1333', '622481', null, '江阴市农村商业银行·合作贷记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1334', '622341', null, '江阴农村商业银行·合作借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1335', '940058', null, '江阴农村商业银行·合作卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1336', '623115', null, '江阴农村商业银行·暨阳卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1337', '621258', null, '重庆农村商业银行·江渝借记卡VIP卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1338', '621465', null, '重庆农村商业银行·江渝IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1339', '621528', null, '重庆农村商业银行·江渝乡情福农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1340', '622328', null, '东莞农村商业银行·信通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1341', '940062', null, '东莞农村商业银行·信通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1342', '625288', null, '东莞农村商业银行·信通信用卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1343', '623038', null, '东莞农村商业银行·信通借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1344', '625888', null, '东莞农村商业银行·贷记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1345', '622332', null, '张家港农村商业银行·一卡通(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1346', '940063', null, '张家港农村商业银行·一卡通(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1347', '623123', null, '张家港农村商业银行·', null, null);
INSERT INTO `banks_card_bin` VALUES ('1348', '622138', null, '北京农村商业银行·信通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1349', '621066', null, '北京农村商业银行·惠通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1350', '621560', null, '北京农村商业银行·凤凰福农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1351', '621068', null, '北京农村商业银行·惠通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1352', '620088', null, '北京农村商业银行·中国旅行卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1353', '621067', null, '北京农村商业银行·凤凰卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1354', '622531', null, '天津农村商业银行·吉祥商联IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1355', '622329', null, '天津农村商业银行·信通借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1356', '623103', null, '天津农村商业银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1357', '622339', null, '鄞州农村合作银行·蜜蜂借记卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1358', '620500', null, '宁波鄞州农村合作银行·蜜蜂电子钱包(IC)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1359', '621024', null, '宁波鄞州农村合作银行·蜜蜂IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1360', '622289', null, '宁波鄞州农村合作银行·蜜蜂贷记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1361', '622389', null, '宁波鄞州农村合作银行·蜜蜂贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1362', '628300', null, '宁波鄞州农村合作银行·公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1363', '625516', null, '成都农村商业银行·福农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1364', '621516', null, '成都农村商业银行·福农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1365', '622859', null, '珠海农村商业银行·信通卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1366', '622869', null, '太仓农村商业银行·郑和卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1367', '623075', null, '太仓农村商业银行·郑和IC借记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1368', '622895', null, '无锡农村商业银行·金阿福', null, null);
INSERT INTO `banks_card_bin` VALUES ('1369', '623125', null, '无锡农村商业银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1370', '622947', null, '黄河农村商业银行·黄河卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1371', '621561', null, '黄河农村商业银行·黄河富农卡福农卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1372', '623095', null, '黄河农村商业银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1373', '621073', null, '天津滨海农村商业银行·四海通卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1374', '623109', null, '天津滨海农村商业银行·四海通e芯卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1375', '621361', null, '武汉农村商业银行·汉卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1376', '623033', null, '武汉农村商业银行·汉卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1377', '623207', null, '武汉农村商业银行·中国旅游卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1378', '622891', null, '江南农村商业银行·阳湖卡(银联卡)', null, null);
INSERT INTO `banks_card_bin` VALUES ('1379', '621363', null, '江南农村商业银行·天天红火卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1380', '623189', null, '江南农村商业银行·借记IC卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1381', '623510', null, '海口联合农村商业银行·海口联合农村商业银行合卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1382', '622995', null, '湖北嘉鱼吴江村镇银行·垂虹卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1383', '621053', null, '福建建瓯石狮村镇银行·玉竹卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1384', '621230', null, '浙江平湖工银村镇银行·金平卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1385', '621229', null, '重庆璧山工银村镇银行·翡翠卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1386', '622218', null, '重庆农村商业银行·银联标准贷记卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1387', '628267', null, '重庆农村商业银行·公务卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1388', '621392', null, '南阳村镇银行·玉都卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1389', '621481', null, '晋中市榆次融信村镇银行·魏榆卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1390', '621310', null, '三水珠江村镇银行·珠江太阳卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1391', '621396', null, '东营莱商村镇银行·绿洲卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1392', '623251', null, '建设银行·单位结算卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1393', '628351', null, '玉溪市商业银行·红塔卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1394', '623094', null, '建设银行 - 银联储蓄卡', null, null);
INSERT INTO `banks_card_bin` VALUES ('1395', '62366837', '123', '建设银行', '1', '重庆涪陵');
INSERT INTO `banks_card_bin` VALUES ('1396', '623668', '456', '建设银行', '1', '重庆涪陵');
INSERT INTO `banks_card_bin` VALUES ('1397', '62218052', '0000', '邮政储蓄银行', '6', '储蓄卡');
INSERT INTO `banks_card_bin` VALUES ('1398', '622180', '000', '邮政储蓄银行', '0', '邮政储蓄银行');
INSERT INTO `banks_card_bin` VALUES ('1399', '62305203', '0000', '农业银行', '0', '农行');
INSERT INTO `banks_card_bin` VALUES ('1400', '623052', '0000', '农业银行', '0', '农业银行');

-- ----------------------------
-- Table structure for betting_all_agent
-- ----------------------------
DROP TABLE IF EXISTS `betting_all_agent`;
CREATE TABLE `betting_all_agent` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(20) DEFAULT NULL COMMENT '玩家用户名',
  `gametype` varchar(10) DEFAULT NULL COMMENT '游戏平台',
  `gamebigtype` varchar(2) DEFAULT NULL,
  `betday` int(11) DEFAULT NULL COMMENT '投注日期',
  `betmoney` double(10,2) DEFAULT NULL COMMENT '投注金额',
  `netmoney` double(10,2) DEFAULT NULL COMMENT '输赢金额：赢正数，输负数。',
  `validmoney` double(10,2) DEFAULT NULL COMMENT '有效投注额',
  `createtime` datetime DEFAULT NULL COMMENT '记录添加时间',
  `patchno` varchar(20) DEFAULT NULL COMMENT '记录批次号。99开头的表示正常的汇总数据，98开头的表示补单的汇总数据',
  `rate` double(10,4) DEFAULT '0.0000' COMMENT '洗码比例',
  `amount` double(10,2) DEFAULT '0.00' COMMENT '洗码金额',
  `status` int(11) DEFAULT '0' COMMENT '0=生成 1=已发放',
  PRIMARY KEY (`lsh`),
  KEY `index_employeecode` (`employeecode`) USING BTREE,
  KEY `index_parentemployeecode` (`parentemployeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总投注记录天统计报表';

-- ----------------------------
-- Records of betting_all_agent
-- ----------------------------

-- ----------------------------
-- Table structure for betting_all_day
-- ----------------------------
DROP TABLE IF EXISTS `betting_all_day`;
CREATE TABLE `betting_all_day` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '用户上级编码',
  `User_Name` varchar(20) DEFAULT NULL COMMENT '玩家用户名',
  `Game_Platform` varchar(10) DEFAULT NULL COMMENT '游戏平台',
  `Game_Big_Type` varchar(2) DEFAULT NULL,
  `Game_Type` varchar(45) DEFAULT NULL COMMENT '游戏类型 真人视讯 体育 小游戏 彩票',
  `Bet_Day` date DEFAULT NULL COMMENT '投注日期',
  `Bet_Money` double(10,2) DEFAULT NULL COMMENT '投注金额',
  `Net_Money` double(10,2) DEFAULT NULL COMMENT '输赢金额：赢正数，输负数。',
  `Valid_Money` double(10,2) DEFAULT NULL COMMENT '有效投注额',
  `Rebates_Cash` double(10,2) DEFAULT NULL,
  `Rebates` tinyint(1) DEFAULT '0' COMMENT '是否返水 1 2 ',
  `Add_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录添加时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '打码发放状态 1未发放 2已发放',
  `paytype` tinyint(4) DEFAULT '0',
  `is_daily_agent` tinyint(1) DEFAULT '0',
  `is_weekly_member` tinyint(1) DEFAULT '0',
  `ratio` double DEFAULT '0',
  `payno` varchar(19) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `index_employeecode` (`employeecode`) USING BTREE,
  KEY `index_parentemployeecode` (`parentemployeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总投注记录天统计报表';

-- ----------------------------
-- Records of betting_all_day
-- ----------------------------

-- ----------------------------
-- Table structure for betting_all_day2
-- ----------------------------
DROP TABLE IF EXISTS `betting_all_day2`;
CREATE TABLE `betting_all_day2` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '用户上级编码',
  `User_Name` varchar(20) DEFAULT NULL COMMENT '玩家用户名',
  `Game_Platform` varchar(10) DEFAULT NULL COMMENT '游戏平台',
  `Game_Big_Type` varchar(2) DEFAULT NULL,
  `Game_Type` varchar(45) DEFAULT NULL COMMENT '记录批次号。99开头的表示正常的汇总数据，98开头的表示补单的汇总数据',
  `Bet_Day` int(11) DEFAULT NULL COMMENT '投注日期',
  `Bet_Money` double(10,2) DEFAULT NULL COMMENT '投注金额',
  `Net_Money` double(10,2) DEFAULT NULL COMMENT '输赢金额：赢正数，输负数。',
  `Valid_Money` double(10,2) DEFAULT NULL COMMENT '有效投注额',
  `Add_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录添加时间',
  `patchno` varchar(20) DEFAULT NULL COMMENT '记录批次号。99开头的表示正常的汇总数据，98开头的表示补单的汇总数据',
  PRIMARY KEY (`Id`),
  KEY `index_employeecode` (`employeecode`) USING BTREE,
  KEY `index_parentemployeecode` (`parentemployeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总投注记录天统计报表';

-- ----------------------------
-- Records of betting_all_day2
-- ----------------------------

-- ----------------------------
-- Table structure for betting_all_game_winlose_detail
-- ----------------------------
DROP TABLE IF EXISTS `betting_all_game_winlose_detail`;
CREATE TABLE `betting_all_game_winlose_detail` (
  `platformtype` varchar(6) NOT NULL COMMENT 'platformtype: AG, BBIN,HY,OAG,OIBC,OG,PNG,PT,CP,AV,MG,QP,SA,TTG,YGAG,ZJ',
  `platformid` varchar(50) NOT NULL COMMENT '第三方平台唯一标识',
  `employeecode` char(8) NOT NULL,
  `bettime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `betmoney` double(15,2) NOT NULL DEFAULT '0.00',
  `validbet` double(15,2) NOT NULL DEFAULT '0.00',
  `netmoney` double(15,2) NOT NULL DEFAULT '0.00',
  `enterprisecode` char(8) DEFAULT NULL,
  `brandcode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `gamebigtype` varchar(6) DEFAULT NULL,
  `gametype` varchar(10) DEFAULT NULL,
  `patchno` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`platformtype`,`platformid`),
  KEY `idx_betting_all_game_winlose_detail_ben` (`bettime`,`employeecode`,`netmoney`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='整合所有第三方平台每一局游戏的输赢';

-- ----------------------------
-- Records of betting_all_game_winlose_detail
-- ----------------------------

-- ----------------------------
-- Table structure for betting_all_member
-- ----------------------------
DROP TABLE IF EXISTS `betting_all_member`;
CREATE TABLE `betting_all_member` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(20) DEFAULT NULL COMMENT '玩家用户名',
  `gametype` varchar(10) DEFAULT NULL COMMENT '游戏平台',
  `gamebigtype` varchar(2) DEFAULT NULL,
  `betday` int(11) DEFAULT NULL COMMENT '投注日期',
  `betmoney` double(10,2) DEFAULT NULL COMMENT '投注金额',
  `netmoney` double(10,2) DEFAULT NULL COMMENT '输赢金额：赢正数，输负数。',
  `validmoney` double(10,2) DEFAULT NULL COMMENT '有效投注额',
  `createtime` datetime DEFAULT NULL COMMENT '记录添加时间',
  `patchno` varchar(20) DEFAULT NULL COMMENT '记录批次号。99开头的表示正常的汇总数据，98开头的表示补单的汇总数据',
  `rate` double(10,4) DEFAULT '0.0000' COMMENT '洗码比例',
  `amount` double(10,2) DEFAULT '0.00' COMMENT '洗码金额',
  `status` int(11) DEFAULT '0' COMMENT '0=生成 1=已发放',
  PRIMARY KEY (`lsh`),
  KEY `index_employeecode` (`employeecode`) USING BTREE,
  KEY `index_parentemployeecode` (`parentemployeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='总投注记录天统计报表';

-- ----------------------------
-- Records of betting_all_member
-- ----------------------------

-- ----------------------------
-- Table structure for betting_all_plan
-- ----------------------------
DROP TABLE IF EXISTS `betting_all_plan`;
CREATE TABLE `betting_all_plan` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `patchno` varchar(20) NOT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `total_count` int(11) DEFAULT NULL,
  `total_betmoney` double DEFAULT NULL,
  `total_validbet` double DEFAULT NULL,
  `total_netmoney` double DEFAULT NULL,
  `betday` int(11) DEFAULT NULL,
  `operater` varchar(50) DEFAULT NULL,
  `operater_time` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '0=已生成计划 1=已取消 2=财务已核准 3=已支付',
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_all_plan
-- ----------------------------

-- ----------------------------
-- Table structure for betting_ebet
-- ----------------------------
DROP TABLE IF EXISTS `betting_ebet`;
CREATE TABLE `betting_ebet` (
  `bethistoryid` varchar(50) NOT NULL,
  `gametype` varchar(10) DEFAULT NULL,
  `gamename` varchar(20) DEFAULT NULL,
  `betmap` varchar(2000) DEFAULT NULL,
  `judgeresult` varchar(2000) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `payouttime` varchar(50) DEFAULT NULL,
  `gametime` varchar(50) DEFAULT NULL,
  `roundno` varchar(50) DEFAULT NULL,
  `subchannelid` varchar(10) DEFAULT NULL,
  `validbet` varchar(10) DEFAULT NULL,
  `payout` varchar(10) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `bankercards` varchar(2000) DEFAULT NULL,
  `tigercard` varchar(2000) DEFAULT NULL,
  `dragoncard` varchar(2000) DEFAULT NULL,
  `numbercard` varchar(2000) DEFAULT NULL,
  `alldices` varchar(2000) DEFAULT NULL,
  `playercards` varchar(2000) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`bethistoryid`),
  KEY `betting_ebet_ix1` (`username`) USING BTREE,
  KEY `betting_ebet_ix2` (`enterprisecode`) USING BTREE,
  KEY `betting_ebet_ix3` (`employeecode`) USING BTREE,
  KEY `betting_ebet_ix4` (`parentemployeecode`) USING BTREE,
  KEY `betting_ebet_ix5` (`loginaccount`) USING BTREE,
  KEY `betting_ebet_ix6` (`bettime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_ebet
-- ----------------------------

-- ----------------------------
-- Table structure for betting_eibc
-- ----------------------------
DROP TABLE IF EXISTS `betting_eibc`;
CREATE TABLE `betting_eibc` (
  `transid` varchar(50) NOT NULL,
  `playername` varchar(50) DEFAULT NULL,
  `transactiontime` varchar(30) DEFAULT NULL,
  `matchid` varchar(20) DEFAULT NULL,
  `leagueid` varchar(20) DEFAULT NULL,
  `leaguename` varchar(1000) DEFAULT NULL,
  `sporttype` varchar(20) DEFAULT NULL,
  `awayid` varchar(20) DEFAULT NULL,
  `awayidname` varchar(1000) DEFAULT NULL,
  `homeid` varchar(20) DEFAULT NULL,
  `homeidname` varchar(1000) DEFAULT NULL,
  `matchdatetime` varchar(50) DEFAULT NULL,
  `bettype` varchar(20) DEFAULT NULL,
  `parlayrefno` varchar(20) DEFAULT NULL,
  `betteam` varchar(100) DEFAULT NULL,
  `hdp` varchar(20) DEFAULT NULL,
  `awayhdp` varchar(20) DEFAULT NULL,
  `homehdp` varchar(20) DEFAULT NULL,
  `odds` varchar(20) DEFAULT NULL,
  `oddstype` varchar(20) DEFAULT NULL,
  `awayscore` varchar(20) DEFAULT NULL,
  `homescore` varchar(20) DEFAULT NULL,
  `islive` varchar(20) DEFAULT NULL,
  `lastballno` varchar(20) DEFAULT NULL,
  `ticketstatus` varchar(20) DEFAULT NULL,
  `stake` varchar(20) DEFAULT NULL,
  `winloseamount` varchar(20) DEFAULT NULL,
  `winlostdatetime` varchar(30) DEFAULT NULL,
  `currency` varchar(20) DEFAULT NULL,
  `versionkey` varchar(20) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `nettime` datetime DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`transid`),
  KEY `index1` (`playername`) USING BTREE,
  KEY `index2` (`enterprisecode`) USING BTREE,
  KEY `index3` (`employeecode`) USING BTREE,
  KEY `index4` (`loginaccount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_eibc
-- ----------------------------

-- ----------------------------
-- Table structure for betting_gb
-- ----------------------------
DROP TABLE IF EXISTS `betting_gb`;
CREATE TABLE `betting_gb` (
  `settleid` varchar(20) NOT NULL,
  `betid` varchar(20) DEFAULT NULL,
  `betgrpno` varchar(30) DEFAULT NULL,
  `tpcode` varchar(20) DEFAULT NULL,
  `gbsn` varchar(20) DEFAULT NULL,
  `memberid` varchar(20) DEFAULT NULL,
  `curcode` varchar(20) DEFAULT NULL,
  `betdt` varchar(30) DEFAULT NULL,
  `bettype` varchar(20) DEFAULT NULL,
  `bettypeparam1` varchar(20) DEFAULT NULL,
  `bettypeparam2` varchar(20) DEFAULT NULL,
  `wintype` varchar(20) DEFAULT NULL,
  `hxmguid` varchar(20) DEFAULT NULL,
  `initbetamt` varchar(20) DEFAULT NULL,
  `realbetamt` varchar(20) DEFAULT NULL,
  `holdingamt` varchar(20) DEFAULT NULL,
  `initbetrate` varchar(20) DEFAULT NULL,
  `realbetrate` varchar(20) DEFAULT NULL,
  `prewinamt` varchar(20) DEFAULT NULL,
  `betresult` varchar(20) DEFAULT NULL,
  `wlamt` varchar(20) DEFAULT NULL,
  `refundbetamt` varchar(20) DEFAULT NULL,
  `ticketbetamt` varchar(20) DEFAULT NULL,
  `ticketresult` varchar(20) DEFAULT NULL,
  `ticketwlamt` varchar(20) DEFAULT NULL,
  `settledt` varchar(30) DEFAULT NULL,
  `kenolist` varchar(2000) DEFAULT NULL,
  `lottolist` varchar(2000) DEFAULT NULL,
  `ssclist` varchar(2000) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `pkxlist` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`settleid`),
  KEY `betting_gb_ix1` (`memberid`) USING BTREE,
  KEY `betting_gb_ix2` (`enterprisecode`) USING BTREE,
  KEY `betting_gb_ix3` (`employeecode`) USING BTREE,
  KEY `betting_gb_ix4` (`parentemployeecode`) USING BTREE,
  KEY `betting_gb_ix5` (`loginaccount`) USING BTREE,
  KEY `betting_gb_ix6` (`bettime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_gb
-- ----------------------------

-- ----------------------------
-- Table structure for betting_gg
-- ----------------------------
DROP TABLE IF EXISTS `betting_gg`;
CREATE TABLE `betting_gg` (
  `autoid` bigint(20) NOT NULL DEFAULT '0' COMMENT '游戏编码',
  `gameid` varchar(10) DEFAULT NULL,
  `cuuency` varchar(10) DEFAULT NULL COMMENT '货币',
  `linkid` varchar(20) DEFAULT NULL,
  `accountno` varchar(20) DEFAULT NULL COMMENT '用户名',
  `betmoney` double DEFAULT NULL COMMENT '投注金额',
  `netmoney` double DEFAULT NULL COMMENT '输赢',
  `bettime` datetime DEFAULT NULL COMMENT '投注时间',
  `createtime` datetime DEFAULT NULL COMMENT '创建记录时间',
  `platformflag` varchar(30) DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`autoid`),
  KEY `betting_gg_ix1` (`createtime`) USING BTREE,
  KEY `betting_gg_ix2` (`enterprisecode`) USING BTREE,
  KEY `betting_gg_ix3` (`brandcode`) USING BTREE,
  KEY `betting_gg_ix4` (`employeecode`) USING BTREE,
  KEY `betting_gg_ix6` (`loginaccount`) USING BTREE,
  KEY `betting_gg_ix7` (`bettime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_gg
-- ----------------------------

-- ----------------------------
-- Table structure for betting_ggp
-- ----------------------------
DROP TABLE IF EXISTS `betting_ggp`;
CREATE TABLE `betting_ggp` (
  `lsh` varchar(36) NOT NULL,
  `gamedate` varchar(10) NOT NULL,
  `username` varchar(50) NOT NULL DEFAULT '',
  `ngr` varchar(10) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT 'QP',
  `status` int(11) DEFAULT '0',
  UNIQUE KEY `index1` (`gamedate`,`username`) USING BTREE,
  KEY `index2` (`enterprisecode`,`loginaccount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_ggp
-- ----------------------------

-- ----------------------------
-- Table structure for betting_hab
-- ----------------------------
DROP TABLE IF EXISTS `betting_hab`;
CREATE TABLE `betting_hab` (
  `friendlygameinstanceid` varchar(36) NOT NULL,
  `playerid` varchar(36) DEFAULT NULL,
  `brandid` varchar(36) DEFAULT NULL,
  `username` varchar(36) DEFAULT NULL,
  `brandgameid` varchar(36) DEFAULT NULL,
  `gamekeyname` varchar(36) DEFAULT NULL,
  `gametypeid` varchar(36) DEFAULT NULL,
  `dtstarted` datetime DEFAULT NULL,
  `dtcompleted` datetime DEFAULT NULL,
  `gameinstanceid` varchar(36) DEFAULT NULL,
  `stake` double DEFAULT NULL,
  `payout` double DEFAULT NULL,
  `jackpotwin` double DEFAULT NULL,
  `jackpotcontribution` double DEFAULT NULL,
  `currencycode` varchar(10) DEFAULT NULL,
  `channeltypeid` varchar(10) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`friendlygameinstanceid`),
  KEY `index_username` (`username`) USING BTREE,
  KEY `betting_hab_ix2` (`bettime`) USING BTREE,
  KEY `betting_hab_ix3` (`enterprisecode`) USING BTREE,
  KEY `betting_hab_ix4` (`employeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_hab
-- ----------------------------

-- ----------------------------
-- Table structure for betting_hq_ag
-- ----------------------------
DROP TABLE IF EXISTS `betting_hq_ag`;
CREATE TABLE `betting_hq_ag` (
  `bill_No` varchar(32) NOT NULL COMMENT '注单流水号(满足平台的唯一约束条件)',
  `brandcode` varchar(20) DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '用户登录账号',
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT '游戏大类',
  `player_Name` varchar(50) DEFAULT NULL COMMENT '玩家账号',
  `agent_Code` varchar(55) DEFAULT NULL COMMENT '代理商编号',
  `game_Code` varchar(50) DEFAULT NULL COMMENT '游戏局号',
  `net_Amount` double(11,2) DEFAULT NULL COMMENT '玩家输赢额度',
  `bet_Time` timestamp NULL DEFAULT NULL COMMENT '投注时间',
  `game_Type` varchar(10) DEFAULT NULL COMMENT '游戏类型',
  `bet_Amount` double(11,2) DEFAULT NULL COMMENT '投注金额',
  `valid_Bet_Amount` double(11,2) DEFAULT NULL COMMENT '有效投注额度',
  `flag` int(1) DEFAULT NULL COMMENT '结算状态',
  `play_Type` varchar(50) DEFAULT NULL COMMENT '游戏玩法',
  `currency` varchar(5) DEFAULT NULL COMMENT '货币类型',
  `table_Code` varchar(10) DEFAULT NULL COMMENT '桌子编号',
  `login_IP` varchar(16) DEFAULT NULL COMMENT '玩家 IP',
  `recalcu_Time` timestamp NULL DEFAULT NULL COMMENT '注单重新派彩时间',
  `platform_Id` varchar(50) DEFAULT NULL COMMENT '平台编号(通常為空)',
  `platform_Type` varchar(10) DEFAULT NULL COMMENT '平台類型',
  `remark` varchar(55) DEFAULT NULL COMMENT '輪盤遊戲  -  額外資訊',
  `round` varchar(55) DEFAULT NULL,
  `stringex` varchar(55) DEFAULT NULL,
  `createtime` timestamp NULL DEFAULT NULL COMMENT '数据导出时间',
  `result` text,
  `before_Credit` varchar(50) DEFAULT NULL,
  `device_Type` varchar(20) DEFAULT NULL COMMENT '设备类型',
  `Last_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`bill_No`),
  KEY `IDX_betting_hq_ag_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_betting_hq_ag_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_betting_hq_ag_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `UK_betting_hq_ag_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `betting_hq_ag_ix6` (`createtime`) USING BTREE,
  KEY `idx_betting_hq_ag_bepn` (`bet_Time`,`employeecode`,`parentemployeecode`,`net_Amount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_hq_ag
-- ----------------------------

-- ----------------------------
-- Table structure for betting_hq_bbin
-- ----------------------------
DROP TABLE IF EXISTS `betting_hq_bbin`;
CREATE TABLE `betting_hq_bbin` (
  `bbin_Wagers_Id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '注单号码',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT '登陆账号',
  `bbin_User_Name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '帐号',
  `bbin_Wagers_Date` timestamp NULL DEFAULT NULL COMMENT '下注时间',
  `bbin_Serial_Id` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '局号',
  `bbin_Round_No` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '场次',
  `bbin_Game_Type` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏种类',
  `bbin_Game_Code` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '桌号',
  `bbin_Result` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '开牌结果',
  `bbin_Result_Type` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '注单结果\n-1：注销、0：未结算',
  `bbin_Card` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '结果牌',
  `bbin_Bet_Amount` double(10,2) DEFAULT NULL COMMENT '下注金额',
  `bbin_Payoff` double(10,2) DEFAULT NULL COMMENT '派彩金额',
  `bbin_Currency` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '币别',
  `bbin_Exchange_Rate` double(10,2) DEFAULT NULL COMMENT '与人民币的汇率',
  `bbin_Commissionable` double(10,2) DEFAULT NULL COMMENT '会员有效投注额',
  `bbin_Commission` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '退水',
  `bbin_Origin` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '1.行动装置下单：M \n1-1.ios手机：MI1 \n1-2.ios平板：MI2 \n1-3.Android手机：MA1 \n1-4.Android平板：MA2 \n2.计算机下单：P',
  `bbin_Modified_Date` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '注单变更时间',
  `bbin_Is_Paid` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT 'Y：已派彩、N：未派彩',
  `bbin_Order_Date` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '帐务时间',
  `bbin_UPTIME` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `bbin_createtime` timestamp NULL DEFAULT NULL COMMENT '平台更新时间',
  `Last_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gamebigtype` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  `bbin_Wager_Detail` varchar(1024) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`bbin_Wagers_Id`),
  KEY `IDX_betting_hq_bbin_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_betting_hq_bbin_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_betting_hq_bbin_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_betting_hq_bbin_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `betting_hq_bbin_ix6` (`bbin_createtime`) USING BTREE,
  KEY `idx_betting_hq_bbin_bepP` (`bbin_Wagers_Date`,`employeecode`,`parentemployeecode`,`bbin_Payoff`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='环球BBIN';

-- ----------------------------
-- Records of betting_hq_bbin
-- ----------------------------

-- ----------------------------
-- Table structure for betting_hq_nhq
-- ----------------------------
DROP TABLE IF EXISTS `betting_hq_nhq`;
CREATE TABLE `betting_hq_nhq` (
  `Betting_ID` varchar(20) NOT NULL,
  `Betting_NO` varchar(20) NOT NULL DEFAULT '' COMMENT '注单号	\n',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '用户编码',
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '用户账号',
  `Betting_Credits` double(15,2) DEFAULT NULL COMMENT '投注积分',
  `Pre_Credits_Point` double(20,2) DEFAULT NULL COMMENT '投注前积分',
  `Game_Result` varchar(255) DEFAULT NULL COMMENT '游戏结果	\n',
  `Game_Room_Name` varchar(50) DEFAULT NULL COMMENT '游戏大厅	\n',
  `Agent_Account` varchar(20) DEFAULT NULL COMMENT '代理帐号	\n',
  `Gambling_Code` varchar(32) DEFAULT NULL COMMENT '赌局号	\n',
  `After_Payout_Credits` double(20,2) DEFAULT NULL COMMENT '派彩积分	\n',
  `User_Account` varchar(20) DEFAULT NULL COMMENT '会员帐号	\n',
  `Game_Type` varchar(5) DEFAULT NULL COMMENT '游戏类型	\n',
  `Betting_Date` timestamp NULL DEFAULT NULL COMMENT '下注时间	\n',
  `Dealer_Name` varchar(50) DEFAULT NULL COMMENT '荷官	\n\n',
  `Game_Name` varchar(20) DEFAULT NULL COMMENT '游戏名称	\n',
  `Set_Game_No` varchar(20) DEFAULT NULL COMMENT '靴号局号	\n',
  `Is_Payout` tinyint(4) DEFAULT NULL COMMENT '是否派彩	\n',
  `Parent_User_ID` varchar(10) DEFAULT NULL COMMENT '上级ID	\n',
  `Winning_Credits` double(15,2) DEFAULT NULL COMMENT '输赢积分	\n',
  `Betting_Point` varchar(20) DEFAULT NULL COMMENT '下注点	\n',
  `Table_Name` varchar(20) DEFAULT NULL COMMENT '桌名	\n',
  `Track_IP` varchar(30) DEFAULT NULL COMMENT '追踪IP	\n',
  `Create_Time` timestamp NULL DEFAULT NULL COMMENT '导入时间	\n',
  `Wash_Code_Credits` double(20,2) DEFAULT NULL COMMENT '游码积分	\n',
  `Update_Time` timestamp NULL DEFAULT NULL COMMENT '更新时间	\n',
  `Last_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '用户上级编码',
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`Betting_ID`),
  KEY `IDX_betting_hq_nhq_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_betting_hq_nhq_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_betting_hq_nhq_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_betting_hq_nhq_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `betting_hq_nhq_ix5` (`Create_Time`) USING BTREE,
  KEY `idx_betting_hq_nhq_BepW` (`Betting_Date`,`employeecode`,`parentemployeecode`,`Winning_Credits`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_hq_nhq
-- ----------------------------

-- ----------------------------
-- Table structure for betting_hq_og_ag
-- ----------------------------
DROP TABLE IF EXISTS `betting_hq_og_ag`;
CREATE TABLE `betting_hq_og_ag` (
  `aoi_Product_Id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '唯一ID',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT '登陆账号',
  `aoi_User_Name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名',
  `aoi_Game_Record_Id` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏结果',
  `aoi_Order_Number` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '单号',
  `aoi_Table_Id` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '桌号',
  `aoi_Stage` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '局号',
  `aoi_Inning` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '靴号',
  `aoi_Game_Name_Id` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏类型',
  `aoi_Game_Betting_Kind` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '投注类型',
  `aoi_Game_Betting_Content` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '番摊,轮盘,骰宝的投注区',
  `aoi_Result_Type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏结果类型',
  `aoi_Betting_Amount` double(10,2) DEFAULT NULL COMMENT '投注金额',
  `aoi_Compensate_Rate` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '赔率',
  `aoi_Win_Lose_Amount` double(10,2) DEFAULT NULL COMMENT '输赢金额',
  `aoi_Balance` double(10,2) DEFAULT NULL COMMENT '余额',
  `aoi_Add_Time` timestamp NULL DEFAULT NULL COMMENT '交易时间',
  `aoi_Vendor_Id` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '供应商Id',
  `aoi_Valid_Amount` double(10,2) DEFAULT NULL COMMENT '有效投注额',
  `aoi_PlatformID` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `aoi_createtime` timestamp NULL DEFAULT NULL COMMENT '平台更新时间',
  `Last_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gamebigtype` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`aoi_Product_Id`),
  KEY `IDX_betting_hq_og_ag_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_betting_hq_og_ag_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_betting_hq_og_ag_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_betting_hq_og_ag_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `betting_hq_og_ag_ix5` (`aoi_Add_Time`) USING BTREE,
  KEY `betting_hq_og_ag_ix6` (`aoi_createtime`) USING BTREE,
  KEY `idx_betting_hq_og_ag_aepW` (`aoi_Add_Time`,`employeecode`,`parentemployeecode`,`aoi_Win_Lose_Amount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='环球_OG_AG';

-- ----------------------------
-- Records of betting_hq_og_ag
-- ----------------------------

-- ----------------------------
-- Table structure for betting_hq_og_ibc
-- ----------------------------
DROP TABLE IF EXISTS `betting_hq_og_ibc`;
CREATE TABLE `betting_hq_og_ibc` (
  `ibc_rowguid` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '唯一ID',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `ibc_ballid` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '场次ID',
  `ibc_balltime` timestamp NULL DEFAULT NULL COMMENT '开赛时间',
  `ibc_content` text COLLATE utf8_bin COMMENT '下注内容',
  `ibc_curpl` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '赔率',
  `ibc_ds` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '单双',
  `ibc_dxc` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '大小个数',
  `ibc_isbk` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏类别',
  `ibc_iscancel` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '是否取消',
  `ibc_isdanger` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '是否危险球',
  `ibc_isjs` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '是否结算',
  `ibc_lose` double(10,2) DEFAULT NULL COMMENT '输掉的金额',
  `ibc_matchid` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '联赛ID',
  `ibc_moneyrate` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '货币比率',
  `ibc_orderid` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '投注单号',
  `ibc_recard` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '红牌',
  `ibc_result` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '赛事结果',
  `ibc_rqc` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '让球个数',
  `ibc_rqteam` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '让球队伍',
  `ibc_sportid` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '下注球类ID号',
  `ibc_tballtime` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '走地时间',
  `ibc_thisdate` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '结算日期',
  `ibc_truewin` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '赢半，赢，输半，输，和',
  `ibc_tzip` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '投注IP，ibc 不提供，为空就行',
  `ibc_tzmoney` double(10,2) DEFAULT NULL COMMENT '下注金额',
  `ibc_tzteam` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '下注队伍',
  `ibc_tztype` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '下注类别',
  `ibc_updatetime` timestamp NULL DEFAULT NULL COMMENT '下注时间',
  `ibc_username` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '会员名',
  `ibc_win` double(10,2) DEFAULT NULL COMMENT '赢的钱',
  `ibc_zdbf` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '走地比分',
  `ibc_vendorid` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '注单更新顺序号',
  `ibc_createtime` timestamp NULL DEFAULT NULL COMMENT '平台更新时间',
  `Last_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL,
  `loginaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `gamebigtype` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`ibc_rowguid`),
  KEY `idx_UserName` (`ibc_username`) USING BTREE,
  KEY `IDX_betting_hq_og_ibc_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_betting_hq_og_ibc_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_betting_hq_og_ibc_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_betting_hq_og_ibc_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `betting_hq_og_ibc_ix6` (`ibc_balltime`) USING BTREE,
  KEY `betting_hq_og_ibc_ix7` (`ibc_createtime`) USING BTREE,
  KEY `idx_betting_hq_og_ibc_ibc_updatetime` (`ibc_updatetime`) USING BTREE,
  KEY `idx_betting_hq_og_ibc_uepwlose` (`ibc_updatetime`,`employeecode`,`parentemployeecode`,`ibc_win`,`ibc_lose`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='环球OG_IBC';

-- ----------------------------
-- Records of betting_hq_og_ibc
-- ----------------------------

-- ----------------------------
-- Table structure for betting_hq_og_og
-- ----------------------------
DROP TABLE IF EXISTS `betting_hq_og_og`;
CREATE TABLE `betting_hq_og_og` (
  `aoi_Product_Id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '唯一ID',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `aoi_User_Name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名',
  `aoi_Game_Record_Id` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏结果',
  `aoi_Order_Number` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '单号',
  `aoi_Table_Id` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '桌号',
  `aoi_Stage` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '局号',
  `aoi_Inning` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '靴号',
  `aoi_Game_Name_Id` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏类型',
  `aoi_Game_Betting_Kind` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '投注类型',
  `aoi_Game_Betting_Content` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '番摊,轮盘,骰宝的投注区',
  `aoi_Result_Type` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏结果类型',
  `aoi_Betting_Amount` double(10,2) DEFAULT NULL COMMENT '投注金额',
  `aoi_Compensate_Rate` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '赔率',
  `aoi_Win_Lose_Amount` double(10,2) DEFAULT NULL COMMENT '输赢金额',
  `aoi_Balance` double(10,2) DEFAULT NULL COMMENT '余额',
  `aoi_Add_Time` timestamp NULL DEFAULT NULL COMMENT '交易时间',
  `aoi_Vendor_Id` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '供应商Id',
  `aoi_Valid_Amount` double(10,2) DEFAULT NULL COMMENT '有效投注额',
  `aoi_Platform_ID` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `aoi_createtime` timestamp NULL DEFAULT NULL COMMENT '平台更新时间',
  `Last_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL,
  `loginaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `gamebigtype` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`aoi_Product_Id`),
  KEY `idx_GameType` (`aoi_Game_Name_Id`) USING BTREE,
  KEY `idx_UserName` (`aoi_User_Name`) USING BTREE,
  KEY `UK_betting_hq_og_og_employeecode` (`employeecode`) USING BTREE,
  KEY `UK_betting_hq_og_og_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_betting_hq_og_og_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_betting_hq_og_og_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_betting_hq_og_og_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_betting_hq_og_og_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `betting_hq_og_og_ix9` (`aoi_Add_Time`) USING BTREE,
  KEY `betting_hq_og_og_ix10` (`aoi_createtime`) USING BTREE,
  KEY `idx_betting_hq_og_AepWLose` (`aoi_Add_Time`,`employeecode`,`parentemployeecode`,`aoi_Win_Lose_Amount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='环球_OG_OG';

-- ----------------------------
-- Records of betting_hq_og_og
-- ----------------------------

-- ----------------------------
-- Table structure for betting_hq_png
-- ----------------------------
DROP TABLE IF EXISTS `betting_hq_png`;
CREATE TABLE `betting_hq_png` (
  `bill_No` varchar(32) NOT NULL COMMENT '注单流水号(满足平台的唯一约束条件)',
  `brandcode` varchar(20) DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '用户登录账号',
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT '游戏大类',
  `player_Name` varchar(50) DEFAULT NULL COMMENT '玩家账号',
  `agent_Code` varchar(55) DEFAULT NULL COMMENT '代理商编号',
  `game_Code` varchar(50) DEFAULT NULL COMMENT '游戏局号',
  `net_Amount` double(11,2) DEFAULT NULL COMMENT '玩家输赢额度',
  `bet_Time` timestamp NULL DEFAULT NULL COMMENT '投注时间',
  `game_Type` varchar(10) DEFAULT NULL COMMENT '游戏类型',
  `bet_Amount` double(11,2) DEFAULT NULL COMMENT '投注金额',
  `valid_Bet_Amount` double(11,2) DEFAULT NULL COMMENT '有效投注额度',
  `flag` int(1) DEFAULT NULL COMMENT '结算状态',
  `play_Type` varchar(50) DEFAULT NULL COMMENT '游戏玩法',
  `currency` varchar(5) DEFAULT NULL COMMENT '货币类型',
  `table_Code` varchar(10) DEFAULT NULL COMMENT '桌子编号',
  `login_IP` varchar(16) DEFAULT NULL COMMENT '玩家 IP',
  `recalcu_Time` timestamp NULL DEFAULT NULL COMMENT '注单重新派彩时间',
  `platform_Id` varchar(50) DEFAULT NULL COMMENT '平台编号(通常為空)',
  `platform_Type` varchar(10) DEFAULT NULL COMMENT '平台類型',
  `remark` varchar(55) DEFAULT NULL COMMENT '輪盤遊戲  -  額外資訊',
  `round` varchar(55) DEFAULT NULL,
  `stringex` varchar(55) DEFAULT NULL,
  `createtime` timestamp NULL DEFAULT NULL COMMENT '数据导出时间',
  `result` text,
  `before_Credit` varchar(50) DEFAULT NULL,
  `device_Type` varchar(20) DEFAULT NULL COMMENT '设备类型',
  `Last_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`bill_No`),
  KEY `IDX_betting_hq_ag_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_betting_hq_ag_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_betting_hq_ag_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `UK_betting_hq_ag_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `index4` (`bet_Time`) USING BTREE,
  KEY `betting_hq_ag_ix6` (`createtime`) USING BTREE,
  KEY `idx_betting_hq_png_bepn` (`bet_Time`,`employeecode`,`parentemployeecode`,`net_Amount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_hq_png
-- ----------------------------

-- ----------------------------
-- Table structure for betting_hq_pt
-- ----------------------------
DROP TABLE IF EXISTS `betting_hq_pt`;
CREATE TABLE `betting_hq_pt` (
  `pt_gamecode` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '游戏编号',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `pt_gametype` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏类型',
  `pt_gameid` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏id',
  `pt_gamename` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '游戏名称',
  `pt_username` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名',
  `pt_windowcode` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '窗口代码',
  `pt_bet` double(10,2) DEFAULT NULL COMMENT '投注额',
  `pt_win` double(10,2) DEFAULT NULL COMMENT '赢',
  `pt_balance` double(10,2) DEFAULT NULL COMMENT '余额',
  `pt_gamedate` timestamp NULL DEFAULT NULL COMMENT '游戏时间',
  `pt_info` varchar(1500) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏信息',
  `pt_sessionid` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT 'sessionID',
  `pt_progressivebet` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '逐步下注',
  `pt_progressivewin` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '进步的胜利',
  `pt_currentbet` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '最近赌注',
  `pt_livenetwork` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '活网工作',
  `pt_rnum` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '序号',
  `pt_createtime` timestamp NULL DEFAULT NULL COMMENT '平台更新时间',
  `Last_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL,
  `loginaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `gamebigtype` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`pt_gamecode`),
  KEY `idx_UserName` (`pt_username`) USING BTREE,
  KEY `IDX_betting_hq_pt_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_betting_hq_pt_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_betting_hq_pt_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_betting_hq_pt_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `betting_hq_pt_ix6` (`pt_gamedate`) USING BTREE,
  KEY `betting_hq_pt_ix7` (`pt_createtime`) USING BTREE,
  KEY `idx_betting_hq_pt_gepwbet` (`pt_gamedate`,`employeecode`,`parentemployeecode`,`pt_win`,`pt_bet`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='环球PT';

-- ----------------------------
-- Records of betting_hq_pt
-- ----------------------------

-- ----------------------------
-- Table structure for betting_hq_xcp
-- ----------------------------
DROP TABLE IF EXISTS `betting_hq_xcp`;
CREATE TABLE `betting_hq_xcp` (
  `xcp_projectid` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '投注id',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `xcp_bonus` double(10,2) DEFAULT NULL COMMENT '返奖',
  `xcp_prize` double(10,2) DEFAULT NULL COMMENT '奖金额',
  `xcp_writetime` timestamp NULL DEFAULT NULL COMMENT '下注时间',
  `xcp_username` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名',
  `xcp_code` text COLLATE utf8_bin COMMENT '下注内容',
  `xcp_totalprice` double(10,2) DEFAULT NULL COMMENT '下注金额',
  `xcp_isgetprize` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '是否中奖，1=未中间，2=中奖',
  `xcp_updatetime` timestamp NULL DEFAULT NULL COMMENT '派奖时间',
  `xcp_lotteryid` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '彩种，彩种编号参照附录',
  `xcp_issue` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '奖期',
  `xcp_codetimes` double(10,2) DEFAULT NULL COMMENT '倍数',
  `xcp_createtime` timestamp NULL DEFAULT NULL COMMENT '平台更新时间',
  `Last_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL,
  `loginaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `gamebigtype` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`xcp_projectid`),
  KEY `IDX_betting_hq_xcp_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_betting_hq_xcp_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_betting_hq_xcp_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_betting_hq_xcp_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `betting_hq_xcp_ix5` (`xcp_createtime`) USING BTREE,
  KEY `betting_hq_xcp_ix6` (`xcp_writetime`) USING BTREE,
  KEY `idx_betting_hq_xcp_wepbonus` (`xcp_writetime`,`employeecode`,`parentemployeecode`,`xcp_bonus`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='环球XCP';

-- ----------------------------
-- Records of betting_hq_xcp
-- ----------------------------

-- ----------------------------
-- Table structure for betting_idn
-- ----------------------------
DROP TABLE IF EXISTS `betting_idn`;
CREATE TABLE `betting_idn` (
  `transactionno` varchar(50) NOT NULL,
  `tableno` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `betdate` varchar(50) DEFAULT NULL,
  `game` varchar(50) DEFAULT NULL,
  `bettable` varchar(50) DEFAULT NULL,
  `periode` varchar(50) DEFAULT NULL,
  `room` varchar(50) DEFAULT NULL,
  `bet` varchar(20) DEFAULT NULL,
  `currbet` varchar(50) DEFAULT NULL,
  `rbet` varchar(50) DEFAULT NULL,
  `game_status` varchar(50) DEFAULT NULL,
  `card` varchar(50) DEFAULT NULL,
  `hand` varchar(50) DEFAULT NULL,
  `prize` varchar(50) DEFAULT NULL,
  `curr` varchar(50) DEFAULT NULL,
  `currplayer` varchar(50) DEFAULT NULL,
  `curramount` varchar(50) DEFAULT NULL,
  `amount` varchar(50) DEFAULT NULL,
  `total` varchar(50) DEFAULT NULL,
  `agentcomission` varchar(50) DEFAULT NULL,
  `agentbill` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`transactionno`),
  KEY `betting_idn_ix1` (`bettime`) USING BTREE,
  KEY `betting_idn_ix2` (`employeecode`) USING BTREE,
  KEY `betting_idn_ix3` (`enterprisecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_idn
-- ----------------------------

-- ----------------------------
-- Table structure for betting_idn2
-- ----------------------------
DROP TABLE IF EXISTS `betting_idn2`;
CREATE TABLE `betting_idn2` (
  `lsh` varchar(36) NOT NULL,
  `turnoverdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `userid` varchar(50) NOT NULL DEFAULT '',
  `totalturnover` varchar(50) DEFAULT NULL,
  `turnoverpoker` varchar(50) DEFAULT NULL,
  `turnoverdomino` varchar(50) DEFAULT NULL,
  `turnoverceme` varchar(50) DEFAULT NULL,
  `turnoverblackjack` varchar(50) DEFAULT NULL,
  `turnovercapsa` varchar(50) DEFAULT NULL,
  `turnoverlivepoker` varchar(50) DEFAULT NULL,
  `texaspoker` varchar(50) DEFAULT NULL,
  `domino` varchar(50) DEFAULT NULL,
  `ceme` varchar(50) DEFAULT NULL,
  `blackjack` varchar(50) DEFAULT NULL,
  `capsa` varchar(50) DEFAULT NULL,
  `livepoker` varchar(50) DEFAULT NULL,
  `pokertournament` varchar(50) DEFAULT NULL,
  `agentcommission` varchar(50) DEFAULT NULL,
  `agentbill` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT 'QP',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`turnoverdate`,`userid`),
  KEY `index2` (`userid`) USING BTREE,
  KEY `index3` (`loginaccount`) USING BTREE,
  KEY `index4` (`employeecode`) USING BTREE,
  KEY `index1` (`lsh`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_idn2
-- ----------------------------

-- ----------------------------
-- Table structure for betting_im
-- ----------------------------
DROP TABLE IF EXISTS `betting_im`;
CREATE TABLE `betting_im` (
  `betid` varchar(50) NOT NULL,
  `providername` varchar(50) DEFAULT NULL,
  `gameid` varchar(50) DEFAULT NULL,
  `wagercreationdatetime` varchar(50) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `playerid` varchar(50) DEFAULT NULL,
  `stakeamount` double(50,0) DEFAULT NULL,
  `memberexposure` double(50,0) DEFAULT NULL,
  `payoutamount` double(50,0) DEFAULT NULL,
  `winloss` double(50,0) DEFAULT NULL,
  `oddstype` varchar(50) DEFAULT NULL,
  `wagertype` varchar(50) DEFAULT NULL,
  `platform` varchar(50) DEFAULT NULL,
  `issettled` varchar(50) DEFAULT NULL,
  `isconfirmed` varchar(50) DEFAULT NULL,
  `iscancelled` varchar(50) DEFAULT NULL,
  `bettradestatus` varchar(50) DEFAULT NULL,
  `bettradecommission` varchar(50) DEFAULT NULL,
  `bettradebuybackamount` varchar(50) DEFAULT NULL,
  `combotype` varchar(50) DEFAULT NULL,
  `lastupdateddate` varchar(50) DEFAULT NULL,
  `detailitems` text,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `nettime` datetime DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `platformflag` varchar(50) DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_im
-- ----------------------------

-- ----------------------------
-- Table structure for betting_jdb
-- ----------------------------
DROP TABLE IF EXISTS `betting_jdb`;
CREATE TABLE `betting_jdb` (
  `seqNo` bigint(20) NOT NULL COMMENT '游戏序号，主键',
  `playerId` varchar(19) NOT NULL COMMENT '玩家账号',
  `mtype` int(11) DEFAULT NULL COMMENT '机台类型',
  `gameDate` char(19) DEFAULT NULL COMMENT '游戏时间',
  `bet` double DEFAULT NULL COMMENT '押注金额',
  `gambleBet` double DEFAULT NULL COMMENT '博取游戏押注金额',
  `win` double DEFAULT NULL COMMENT '游戏输赢',
  `total` double DEFAULT NULL COMMENT '总输赢',
  `currency` char(2) DEFAULT NULL COMMENT '货币编码',
  `denom` double DEFAULT NULL COMMENT '投注面额',
  `lastModifyTime` char(19) DEFAULT NULL COMMENT '最后修改时间',
  `playerIp` char(15) DEFAULT NULL COMMENT '玩家IP',
  `clientType` varchar(20) DEFAULT NULL COMMENT '客户端类型',
  `gType` int(11) DEFAULT NULL COMMENT '游戏类型：0-老虎机，7-捕鱼机，9-水果机',
  `hasGamble` int(11) DEFAULT NULL COMMENT '是否博取游戏：0-否，1-是【老虎鱼&水果机】',
  `hasBonusGame` int(11) DEFAULT NULL COMMENT '是否奖金游戏：0-否，1-是【水果机专属】',
  `hasFreegame` int(11) DEFAULT NULL COMMENT '是否免费游戏：0-否，1-是【老虎机专属】',
  `roomType` int(11) DEFAULT NULL COMMENT '捕鱼机房间类型：0-欢乐区，1-富豪区【捕鱼机专属】',
  `systemTakeWin` int(11) DEFAULT NULL COMMENT '标记该笔为游戏中断线，由系统结算：0-否，1-是【老虎机专属】',
  `jackpot` double DEFAULT NULL COMMENT '赢得彩金金额【老虎机专属】',
  `jackpotContribute` double DEFAULT NULL COMMENT '彩金贡献值【老虎机专属】',
  `beforeBalance` double DEFAULT NULL COMMENT '进场金额【捕鱼机专属】',
  `afterBalance` double DEFAULT NULL COMMENT '离场金额【捕鱼机专属】',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '会员编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '会员上级编码',
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '会员账号',
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT '游戏类型',
  `status` int(11) DEFAULT '0' COMMENT '状态',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `bettime` datetime DEFAULT NULL COMMENT '投注时间',
  `betmoney` double DEFAULT NULL COMMENT '投注金额',
  `netmoney` double DEFAULT NULL COMMENT '输赢金额',
  PRIMARY KEY (`seqNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='JDB168游戏数据';

-- ----------------------------
-- Records of betting_jdb
-- ----------------------------

-- ----------------------------
-- Table structure for betting_kr_av
-- ----------------------------
DROP TABLE IF EXISTS `betting_kr_av`;
CREATE TABLE `betting_kr_av` (
  `tid` varchar(20) NOT NULL DEFAULT '' COMMENT '注单ID',
  `enterprisecode` varchar(8) DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(8) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` varchar(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` varchar(8) DEFAULT NULL COMMENT '上级员工编码',
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '登陆用户名',
  `transtype` varchar(20) DEFAULT NULL COMMENT '投注标识',
  `amount` double(10,2) DEFAULT NULL COMMENT '下注金额',
  `transtype2` varchar(20) DEFAULT NULL COMMENT '结果标识',
  `amount2` double(10,2) DEFAULT NULL COMMENT '输赢金额',
  `provider` varchar(20) DEFAULT NULL COMMENT '游戏大类',
  `roundid` varchar(20) DEFAULT NULL COMMENT '循环序号',
  `gameinfo` varchar(20) DEFAULT NULL COMMENT '游戏信息',
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT '游戏大类',
  `history` varchar(255) DEFAULT NULL COMMENT '游戏历史名称',
  `isroundfinished` varchar(10) DEFAULT NULL COMMENT '完成信息',
  `time` datetime DEFAULT NULL COMMENT '下注时间',
  `userid` varchar(20) DEFAULT NULL COMMENT '用户名',
  `createtime` datetime DEFAULT NULL COMMENT '数据生成时间',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`tid`),
  KEY `index_employeecode` (`employeecode`) USING BTREE,
  KEY `betting_kr_av_ix2` (`enterprisecode`) USING BTREE,
  KEY `betting_kr_av_ix3` (`parentemployeecode`) USING BTREE,
  KEY `betting_kr_av_ix4` (`brandcode`) USING BTREE,
  KEY `betting_kr_av_ix5` (`time`) USING BTREE,
  KEY `betting_kr_av_ix6` (`createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_kr_av
-- ----------------------------

-- ----------------------------
-- Table structure for betting_m88
-- ----------------------------
DROP TABLE IF EXISTS `betting_m88`;
CREATE TABLE `betting_m88` (
  `transid` varchar(36) NOT NULL,
  `memberid` varchar(36) DEFAULT NULL,
  `operatorid` varchar(50) DEFAULT NULL,
  `sitecode` varchar(36) DEFAULT NULL,
  `leagueid` varchar(36) DEFAULT NULL,
  `homeid` varchar(36) DEFAULT NULL,
  `awayid` varchar(36) DEFAULT NULL,
  `matchdatetime` varchar(36) DEFAULT NULL,
  `bettype` varchar(36) DEFAULT NULL,
  `parlayrefno` varchar(36) DEFAULT NULL,
  `odds` varchar(36) DEFAULT NULL,
  `currency` varchar(36) DEFAULT NULL,
  `stake` varchar(36) DEFAULT NULL,
  `winlostamount` varchar(36) DEFAULT NULL,
  `transactiontime` varchar(36) DEFAULT NULL,
  `ticketstatus` varchar(36) DEFAULT NULL,
  `versionkey` varchar(36) DEFAULT NULL,
  `winlostdatetime` varchar(36) DEFAULT NULL,
  `oddstype` varchar(36) DEFAULT NULL,
  `sportstype` varchar(36) DEFAULT NULL,
  `betteam` varchar(255) DEFAULT NULL,
  `homehdp` varchar(36) DEFAULT NULL,
  `awayhdp` varchar(36) DEFAULT NULL,
  `matchid` varchar(36) DEFAULT NULL,
  `islive` varchar(36) DEFAULT NULL,
  `homescore` varchar(36) DEFAULT NULL,
  `awayscore` varchar(36) DEFAULT NULL,
  `choicecode` varchar(255) DEFAULT NULL,
  `choicename` varchar(255) DEFAULT NULL,
  `txntype` varchar(36) DEFAULT NULL,
  `lastupdate` varchar(36) DEFAULT NULL,
  `leaguename` varchar(255) DEFAULT NULL,
  `homename` varchar(255) DEFAULT NULL,
  `awayname` varchar(255) DEFAULT NULL,
  `sportname` varchar(255) DEFAULT NULL,
  `oddsname` varchar(255) DEFAULT NULL,
  `bettypename` varchar(255) DEFAULT NULL,
  `winloststatus` varchar(36) DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `nettime` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`transid`),
  KEY `betting_m88_ix1` (`employeecode`) USING BTREE,
  KEY `betting_m88_ix2` (`bettime`) USING BTREE,
  KEY `betting_m88_ix3` (`enterprisecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_m88
-- ----------------------------

-- ----------------------------
-- Table structure for betting_mg
-- ----------------------------
DROP TABLE IF EXISTS `betting_mg`;
CREATE TABLE `betting_mg` (
  `mg_trans_Id` varchar(50) NOT NULL COMMENT '????',
  `mg_key` varchar(50) DEFAULT NULL COMMENT '????(????)',
  `mg_col_Id` varchar(50) DEFAULT NULL COMMENT '???????(????)',
  `mg_agent_Id` varchar(50) DEFAULT NULL COMMENT '????',
  `mg_mbr_Id` varchar(50) DEFAULT NULL COMMENT '????',
  `mg_mbr_Code` varchar(50) DEFAULT NULL COMMENT '????',
  `mg_game_Id` varchar(50) DEFAULT NULL COMMENT '????',
  `mg_trans_Type` varchar(50) DEFAULT NULL COMMENT '?????[?? -> "bet", ? -> "win", ?? -> "refund"]',
  `mg_trans_Time` varchar(50) DEFAULT NULL COMMENT '????????UTC+0???',
  `mg_mgs_Game_Id` varchar(50) DEFAULT NULL COMMENT 'MG ???????',
  `mg_mgs_Action_Id` varchar(50) DEFAULT NULL COMMENT 'MG ????????',
  `mg_amnt` varchar(50) DEFAULT NULL COMMENT '?????(????????????????)',
  `mg_clrng_Amnt` varchar(50) DEFAULT NULL COMMENT '?????(????????????????)',
  `mg_balance` varchar(50) DEFAULT NULL COMMENT '??????',
  `mg_ref_Trans_Id` varchar(50) DEFAULT NULL COMMENT '???????? ??????????, ???????????????transId?',
  `mg_ref_Trans_Type` varchar(50) DEFAULT NULL COMMENT '?????????. [?? -> "bet", ? -> "win"]',
  `mg_win` varchar(50) DEFAULT NULL COMMENT '??????',
  `mg_createtime` datetime DEFAULT NULL COMMENT '????',
  `Platformflag` varchar(50) DEFAULT NULL COMMENT '????',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '????',
  `brandcode` varchar(20) DEFAULT NULL COMMENT '????',
  `employeecode` char(8) DEFAULT NULL COMMENT '????',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '??????',
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '??????',
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT '????',
  `status` int(11) DEFAULT '0',
  `bettime` datetime DEFAULT NULL,
  `net_money` double DEFAULT NULL,
  `mg_amount` double DEFAULT NULL,
  PRIMARY KEY (`mg_trans_Id`),
  KEY `betting_mg_ix1` (`mg_createtime`) USING BTREE,
  KEY `betting_mg_ix2` (`enterprisecode`) USING BTREE,
  KEY `betting_mg_ix3` (`brandcode`) USING BTREE,
  KEY `betting_mg_ix4` (`employeecode`) USING BTREE,
  KEY `betting_mg_ix6` (`loginaccount`) USING BTREE,
  KEY `betting_mg_ix7` (`bettime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='MG?????';

-- ----------------------------
-- Records of betting_mg
-- ----------------------------

-- ----------------------------
-- Table structure for betting_qp
-- ----------------------------
DROP TABLE IF EXISTS `betting_qp`;
CREATE TABLE `betting_qp` (
  `Turn_Number` varchar(50) NOT NULL COMMENT '游戏局号',
  `Server_ID` varchar(50) DEFAULT NULL COMMENT '游戏类型',
  `Kind_ID` varchar(50) DEFAULT NULL COMMENT '房间类型',
  `Room_Name` varchar(50) DEFAULT NULL COMMENT '游戏房间名称',
  `Start_Time` varchar(50) DEFAULT NULL COMMENT '下注时间',
  `End_Time` varchar(50) DEFAULT NULL COMMENT '派彩时间',
  `Score` varchar(50) DEFAULT NULL COMMENT '投注金额',
  `Turn_Score` varchar(50) DEFAULT NULL COMMENT '输赢',
  `Account` varchar(50) DEFAULT NULL COMMENT '玩家账号',
  `createtime` datetime DEFAULT NULL COMMENT '创建日期',
  `Platformflag` varchar(50) DEFAULT NULL COMMENT '标志',
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `bettime` datetime DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `Revenue` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Turn_Number`),
  KEY `betting_mg_ix1` (`createtime`) USING BTREE,
  KEY `betting_mg_ix2` (`enterprisecode`) USING BTREE,
  KEY `betting_mg_ix3` (`brandcode`) USING BTREE,
  KEY `betting_mg_ix4` (`employeecode`) USING BTREE,
  KEY `betting_mg_ix6` (`loginaccount`) USING BTREE,
  KEY `betting_mg_ix7` (`bettime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='棋牌游戏表';

-- ----------------------------
-- Records of betting_qp
-- ----------------------------

-- ----------------------------
-- Table structure for betting_qt
-- ----------------------------
DROP TABLE IF EXISTS `betting_qt`;
CREATE TABLE `betting_qt` (
  `id` varchar(36) NOT NULL DEFAULT '',
  `playergameroundid` varchar(36) DEFAULT NULL,
  `gameid` varchar(36) DEFAULT NULL,
  `amount` varchar(10) DEFAULT NULL,
  `balance` varchar(10) DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `gameprovider` varchar(36) DEFAULT NULL,
  `gtype` varchar(10) DEFAULT NULL,
  `gameclienttype` varchar(36) DEFAULT NULL,
  `gamecategory` varchar(36) DEFAULT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `playerdevice` varchar(36) DEFAULT NULL,
  `operatorid` varchar(36) DEFAULT NULL,
  `playerid` varchar(36) DEFAULT NULL,
  `wallettransactionid` varchar(36) DEFAULT NULL,
  `roundstatus` varchar(36) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index1` (`playergameroundid`) USING BTREE,
  KEY `betting_qt_ix2` (`playerid`) USING BTREE,
  KEY `betting_qt_ix3` (`enterprisecode`) USING BTREE,
  KEY `betting_qt_ix4` (`employeecode`) USING BTREE,
  KEY `betting_qt_ix5` (`parentemployeecode`) USING BTREE,
  KEY `betting_qt_ix6` (`loginaccount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_qt
-- ----------------------------

-- ----------------------------
-- Table structure for betting_qwp
-- ----------------------------
DROP TABLE IF EXISTS `betting_qwp`;
CREATE TABLE `betting_qwp` (
  `TurnNumber` bigint(20) NOT NULL COMMENT '局号',
  `ServerId` int(11) DEFAULT NULL COMMENT '房间Id',
  `KindId` int(11) DEFAULT NULL COMMENT '游戏Id',
  `RoomName` varchar(100) DEFAULT NULL COMMENT '房间名称',
  `StartTime` datetime DEFAULT NULL COMMENT '开始时间',
  `EndTime` datetime DEFAULT NULL COMMENT '结束时间',
  `RecordTime` datetime DEFAULT NULL COMMENT '记录时间',
  `CardData` varchar(100) DEFAULT NULL COMMENT '牌型',
  `Account` varchar(50) DEFAULT NULL COMMENT '玩家账号',
  `Score` double DEFAULT NULL COMMENT '输赢',
  `TurnScore` double DEFAULT NULL COMMENT '底分',
  `Revenue` double DEFAULT NULL COMMENT '抽水',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '会员编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '会员上级编码',
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '会员账号',
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT '游戏类型',
  `status` int(11) DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`TurnNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='去玩棋牌游戏数据';

-- ----------------------------
-- Records of betting_qwp
-- ----------------------------

-- ----------------------------
-- Table structure for betting_sa
-- ----------------------------
DROP TABLE IF EXISTS `betting_sa`;
CREATE TABLE `betting_sa` (
  `betid` varchar(32) NOT NULL DEFAULT '' COMMENT '投注ID',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '登陆账号',
  `gamebigtype` varchar(10) DEFAULT NULL COMMENT '游戏大类',
  `bettime` datetime DEFAULT NULL COMMENT '投注时间',
  `payouttime` datetime DEFAULT NULL COMMENT '结算时间',
  `username` varchar(20) DEFAULT NULL COMMENT '用户名',
  `hostid` varchar(10) DEFAULT NULL COMMENT '桌台 ID',
  `gameid` varchar(32) DEFAULT NULL COMMENT '游戏 ID',
  `round` varchar(10) DEFAULT NULL COMMENT '局',
  `sets` varchar(10) DEFAULT NULL COMMENT '靴',
  `betamount` double(10,2) DEFAULT NULL COMMENT '下注额',
  `resultamount` double(10,2) DEFAULT NULL COMMENT '结算',
  `gametype` varchar(15) DEFAULT NULL COMMENT '游戏类型',
  `bettype` varchar(10) DEFAULT NULL COMMENT '投注类型',
  `betsource` varchar(10) DEFAULT NULL COMMENT '投注来源',
  `state` varchar(10) DEFAULT NULL COMMENT '下注是否成功',
  `detail` varchar(32) DEFAULT NULL COMMENT '其他详情',
  `createtime` datetime DEFAULT NULL COMMENT '数据生成时间',
  `status` int(11) DEFAULT '0',
  `validbet` double(10,2) DEFAULT '0.00',
  PRIMARY KEY (`betid`),
  KEY `index_employeecode` (`employeecode`) USING BTREE,
  KEY `betting_sa_ix2` (`enterprisecode`) USING BTREE,
  KEY `betting_sa_ix3` (`brandcode`) USING BTREE,
  KEY `betting_sa_ix4` (`employeecode`) USING BTREE,
  KEY `betting_sa_ix5` (`parentemployeecode`) USING BTREE,
  KEY `betting_sa_ix6` (`bettime`) USING BTREE,
  KEY `betting_sa_ix7` (`payouttime`) USING BTREE,
  KEY `betting_sa_ix8` (`createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_sa
-- ----------------------------

-- ----------------------------
-- Table structure for betting_sgs
-- ----------------------------
DROP TABLE IF EXISTS `betting_sgs`;
CREATE TABLE `betting_sgs` (
  `ugsbetid` varchar(50) NOT NULL,
  `txid` varchar(50) DEFAULT NULL,
  `betid` varchar(50) DEFAULT NULL,
  `beton` datetime DEFAULT NULL,
  `betclosedon` datetime DEFAULT NULL,
  `betupdatedon` datetime DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `roundid` varchar(50) DEFAULT NULL,
  `roundstatus` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `riskamt` double DEFAULT NULL,
  `winamt` double DEFAULT NULL,
  `winloss` double DEFAULT NULL,
  `beforebal` double DEFAULT NULL,
  `postbal` double DEFAULT NULL,
  `cur` varchar(10) DEFAULT NULL,
  `gameprovider` varchar(50) DEFAULT NULL,
  `gamename` varchar(50) DEFAULT NULL,
  `gameid` varchar(50) DEFAULT NULL,
  `platformtype` varchar(50) DEFAULT NULL,
  `ipaddress` varchar(50) DEFAULT NULL,
  `bettype` varchar(50) DEFAULT NULL,
  `playtype` varchar(50) DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `platformflag` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `validmoney` double DEFAULT '0',
  PRIMARY KEY (`ugsbetid`),
  KEY `betting_sgs_ix1` (`userid`) USING BTREE,
  KEY `betting_sgs_ix2` (`bettime`) USING BTREE,
  KEY `betting_sgs_ix3` (`employeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_sgs
-- ----------------------------

-- ----------------------------
-- Table structure for betting_tgp
-- ----------------------------
DROP TABLE IF EXISTS `betting_tgp`;
CREATE TABLE `betting_tgp` (
  `ugsbetid` varchar(50) NOT NULL DEFAULT '',
  `txid` varchar(50) DEFAULT NULL,
  `betid` varchar(50) DEFAULT NULL,
  `beton` datetime DEFAULT NULL,
  `betclosedon` datetime DEFAULT NULL,
  `betupdatedon` datetime DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `roundid` varchar(50) DEFAULT NULL,
  `roundstatus` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `riskamt` double DEFAULT NULL,
  `winamt` double DEFAULT NULL,
  `winloss` double DEFAULT NULL,
  `beforebal` double DEFAULT NULL,
  `postbal` double DEFAULT NULL,
  `cur` varchar(10) DEFAULT NULL,
  `gameprovider` varchar(50) DEFAULT NULL,
  `gamename` varchar(50) DEFAULT NULL,
  `gameid` varchar(50) DEFAULT NULL,
  `platformtype` varchar(50) DEFAULT NULL,
  `ipaddress` varchar(50) DEFAULT NULL,
  `bettype` varchar(50) DEFAULT NULL,
  `playtype` varchar(50) DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `bettime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `validmoney` double DEFAULT '0',
  PRIMARY KEY (`ugsbetid`),
  KEY `betting_tgp_ix1` (`userid`) USING BTREE,
  KEY `betting_tgp_ix2` (`enterprisecode`) USING BTREE,
  KEY `betting_tgp_ix3` (`employeecode`) USING BTREE,
  KEY `betting_tgp_ix4` (`parentemployeecode`) USING BTREE,
  KEY `betting_tgp_ix5` (`loginaccount`) USING BTREE,
  KEY `betting_tgp_ix6` (`bettime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_tgp
-- ----------------------------

-- ----------------------------
-- Table structure for betting_ttg
-- ----------------------------
DROP TABLE IF EXISTS `betting_ttg`;
CREATE TABLE `betting_ttg` (
  `transaction_Id` bigint(20) NOT NULL DEFAULT '0' COMMENT '交易ID',
  `request_Id` varchar(50) DEFAULT NULL COMMENT '请求ID',
  `partner_Id` varchar(50) DEFAULT NULL COMMENT '同伴ID',
  `player_Id` varchar(50) DEFAULT NULL COMMENT '玩家ID',
  `amount` varchar(50) DEFAULT NULL COMMENT '总额',
  `hand_Id` varchar(50) DEFAULT NULL COMMENT '游戏独特的手Id',
  `transaction_Type` varchar(50) DEFAULT NULL COMMENT '交易类型',
  `transaction_Sub_Type` varchar(50) DEFAULT NULL COMMENT '子交易类型',
  `currency` varchar(50) DEFAULT NULL COMMENT '货币类型',
  `game` varchar(50) DEFAULT NULL COMMENT '游戏名称',
  `transaction_Date` varchar(50) DEFAULT NULL COMMENT '交易日期',
  `createtime` datetime DEFAULT NULL COMMENT '创建日期',
  `Platformflag` varchar(50) DEFAULT NULL COMMENT '标志',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '用户登录账号',
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  `bettime` datetime DEFAULT NULL,
  `net_Money` varchar(50) DEFAULT NULL,
  `resolvetime` datetime DEFAULT NULL,
  PRIMARY KEY (`transaction_Id`),
  KEY `betting_ttg_ix1` (`createtime`) USING BTREE,
  KEY `betting_ttg_ix2` (`enterprisecode`) USING BTREE,
  KEY `betting_ttg_ix3` (`brandcode`) USING BTREE,
  KEY `betting_ttg_ix4` (`employeecode`) USING BTREE,
  KEY `betting_ttg_ix5` (`parentemployeecode`) USING BTREE,
  KEY `betting_ttg_ix6` (`bettime`) USING BTREE,
  KEY `idx_betting_ttg_hand_Id_transaction_Id` (`hand_Id`,`transaction_Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='TTG游戏表';

-- ----------------------------
-- Records of betting_ttg
-- ----------------------------

-- ----------------------------
-- Table structure for betting_win88
-- ----------------------------
DROP TABLE IF EXISTS `betting_win88`;
CREATE TABLE `betting_win88` (
  `pt_gamecode` varchar(32) NOT NULL,
  `pt_username` varchar(32) DEFAULT NULL,
  `pt_windowcode` varchar(32) DEFAULT NULL,
  `pt_gameid` varchar(32) DEFAULT NULL,
  `pt_gametype` varchar(32) DEFAULT NULL,
  `pt_gamename` varchar(200) DEFAULT NULL,
  `pt_bet` decimal(11,2) DEFAULT NULL,
  `pt_win` decimal(11,2) DEFAULT NULL,
  `pt_balance` decimal(11,2) DEFAULT NULL,
  `pt_gamedate` datetime DEFAULT NULL,
  `pt_info` varchar(1000) DEFAULT NULL,
  `pt_sessionid` varchar(32) DEFAULT NULL,
  `pt_progressivebet` varchar(32) DEFAULT NULL,
  `pt_progressivewin` varchar(32) DEFAULT NULL,
  `pt_currentbet` varchar(32) DEFAULT NULL,
  `pt_livenetwork` varchar(32) DEFAULT NULL,
  `pt_rnum` varchar(32) DEFAULT NULL,
  `pt_createtime` datetime DEFAULT NULL,
  `Platformflag` varchar(50) DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(12) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`pt_gamecode`),
  KEY `ix_pt_gameinfo_pt_username` (`pt_username`) USING BTREE,
  KEY `ix_pt_gameinfo_pt_gamedate` (`pt_gamedate`) USING BTREE,
  KEY `betting_win88_ix3` (`enterprisecode`) USING BTREE,
  KEY `betting_win88_ix4` (`employeecode`) USING BTREE,
  KEY `betting_win88_ix5` (`loginaccount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_win88
-- ----------------------------

-- ----------------------------
-- Table structure for betting_yg_ag
-- ----------------------------
DROP TABLE IF EXISTS `betting_yg_ag`;
CREATE TABLE `betting_yg_ag` (
  `bet_id` varchar(32) NOT NULL DEFAULT '' COMMENT '注单 ID',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` varchar(20) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '上级编码',
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '登陆账号',
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT '游戏大类',
  `user` varchar(25) DEFAULT NULL COMMENT '会员帐号',
  `game_id` varchar(20) DEFAULT NULL COMMENT '游戏 ID',
  `game_name` varchar(100) DEFAULT NULL COMMENT '游戏名称',
  `money` double(10,2) DEFAULT NULL COMMENT '下注金额',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注，如游戏场景 ID，捕鱼王奖励，游戏局号等',
  `time` datetime DEFAULT NULL COMMENT '下注时间',
  `result` double(10,2) DEFAULT NULL COMMENT '输赢结果，正数为会员所赢的钱数，负数为会员输的钱',
  `valid_money` double(10,0) DEFAULT NULL COMMENT '有效下注金额',
  `createtime` datetime DEFAULT NULL COMMENT '创建时间？',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`bet_id`),
  KEY `IDX_betting_yg_ag_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_betting_yg_ag_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_betting_yg_ag_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_betting_yg_ag_parentemployeecode` (`parentemployeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_yg_ag
-- ----------------------------

-- ----------------------------
-- Table structure for betting_yoplay
-- ----------------------------
DROP TABLE IF EXISTS `betting_yoplay`;
CREATE TABLE `betting_yoplay` (
  `bill_No` varchar(50) NOT NULL,
  `player_Name` varchar(50) DEFAULT NULL,
  `agent_Code` varchar(50) DEFAULT NULL,
  `game_Code` varchar(200) DEFAULT NULL,
  `net_Amount` varchar(50) DEFAULT NULL,
  `bet_Time` datetime DEFAULT NULL,
  `game_Type` varchar(50) DEFAULT NULL,
  `bet_Amount` varchar(50) DEFAULT NULL,
  `valid_Bet_Amount` varchar(50) DEFAULT NULL,
  `flag` varchar(50) DEFAULT NULL,
  `play_Type` varchar(50) DEFAULT NULL,
  `currency` varchar(50) DEFAULT NULL,
  `table_Code` varchar(50) DEFAULT NULL,
  `login_IP` varchar(50) DEFAULT NULL,
  `recalcu_Time` varchar(50) DEFAULT NULL,
  `platform_Type` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `round` varchar(50) DEFAULT NULL,
  `slottype` varchar(50) DEFAULT NULL,
  `result` varchar(2048) DEFAULT NULL,
  `mainbillno` varchar(50) DEFAULT NULL,
  `before_Credit` varchar(50) DEFAULT NULL,
  `device_Type` varchar(50) DEFAULT NULL,
  `bet_Amount_Base` varchar(50) DEFAULT NULL,
  `bet_Amount_Bonus` varchar(50) DEFAULT NULL,
  `net_Amount_Base` varchar(50) DEFAULT NULL,
  `net_Amount_Bonus` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `betmoney` double DEFAULT NULL,
  `netmoney` double DEFAULT NULL,
  `validmoney` double DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT 'DZ',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`bill_No`),
  KEY `index1` (`bet_Time`) USING BTREE,
  KEY `index2` (`loginaccount`) USING BTREE,
  KEY `index3` (`bill_No`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_yoplay
-- ----------------------------

-- ----------------------------
-- Table structure for betting_zj
-- ----------------------------
DROP TABLE IF EXISTS `betting_zj`;
CREATE TABLE `betting_zj` (
  `id` varchar(32) NOT NULL COMMENT '游戏平台记录 id',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `loginaccount` varchar(12) DEFAULT NULL COMMENT '员工账号',
  `username` varchar(20) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `gametype` varchar(20) DEFAULT NULL,
  `tableinfoid` varchar(20) DEFAULT NULL COMMENT '桌号 ID',
  `shoeinfoid` varchar(20) DEFAULT NULL COMMENT '靴号 ID',
  `gameinfoid` varchar(10) DEFAULT NULL,
  `tablename` varchar(10) DEFAULT NULL,
  `issueno` varchar(10) DEFAULT NULL,
  `bankerresult` varchar(100) DEFAULT NULL,
  `resultlist` varchar(100) DEFAULT NULL,
  `pokerlist` varchar(100) DEFAULT NULL,
  `stakeamount` double(8,2) DEFAULT NULL COMMENT '注投额？',
  `validstake` double(8,2) DEFAULT NULL COMMENT '效有投注额？',
  `winloss` double(8,2) DEFAULT NULL COMMENT '输赢金额？',
  `comm` double(8,2) DEFAULT NULL COMMENT '佣金',
  `balanceafter` double(8,2) DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `ip` varchar(30) DEFAULT NULL COMMENT '下注 IP',
  `details` text,
  `bettime` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL COMMENT '数据拉取时间',
  `gamebigtype` varchar(5) DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_employeecode` (`employeecode`) USING BTREE,
  KEY `betting_zj_ix2` (`enterprisecode`) USING BTREE,
  KEY `betting_zj_ix3` (`employeecode`) USING BTREE,
  KEY `betting_zj_ix4` (`brandcode`) USING BTREE,
  KEY `betting_zj_ix5` (`parentemployeecode`) USING BTREE,
  KEY `betting_zj_ix6` (`bettime`) USING BTREE,
  KEY `betting_zj_ix7` (`createtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_zj
-- ----------------------------

-- ----------------------------
-- Table structure for brand_domain
-- ----------------------------
DROP TABLE IF EXISTS `brand_domain`;
CREATE TABLE `brand_domain` (
  `domaincode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisecode` char(6) NOT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(10) DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '上级用户编码',
  `domainlink` varchar(64) NOT NULL COMMENT '推广域名',
  `employeetype` varchar(10) NOT NULL COMMENT '用户类型',
  `dividend` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '分红',
  `share` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '占成',
  `bonus` varchar(2000) NOT NULL COMMENT '洗码',
  `domaintype` char(1) NOT NULL DEFAULT '3' COMMENT '域名类型 1:企业绑定域名-会员|2:会员站点域名|3:代理注册链接|4:代理站点域名|5：企业绑定域名-代理',
  `isdefualt` char(1) NOT NULL DEFAULT '0' COMMENT '是否默认主域名',
  `copyright` char(1) NOT NULL DEFAULT '2' COMMENT '域名版权(1、公共 , 2、私有)',
  `linkdomain` int(11) DEFAULT NULL COMMENT '二级域名指向的主域名',
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `linkstatus` char(1) NOT NULL DEFAULT '1' COMMENT '链接状态(1、启用 2、禁用)',
  `webtemplatecode` char(6) DEFAULT NULL COMMENT '站点模板',
  `datastatus` char(2) NOT NULL DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`domaincode`),
  KEY `UK_brand_domain_domainlink` (`domainlink`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1301 DEFAULT CHARSET=utf8 COMMENT='注册链接与站点域名';

-- ----------------------------
-- Records of brand_domain
-- ----------------------------

-- ----------------------------
-- Table structure for data_handle
-- ----------------------------
DROP TABLE IF EXISTS `data_handle`;
CREATE TABLE `data_handle` (
  `handlecode` varchar(50) NOT NULL COMMENT '编码',
  `handledesc` varchar(50) NOT NULL COMMENT '说明',
  `updatetime` varchar(2000) NOT NULL COMMENT '更新时间',
  `lasttime` varchar(50) DEFAULT '0',
  `lastnum` int(11) DEFAULT '0',
  `daynum` int(11) DEFAULT '0',
  `allnum` int(11) DEFAULT '0',
  `intervalnum` int(11) DEFAULT '20',
  `remark` varchar(200) DEFAULT NULL,
  `gametype` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`handlecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据抓取';

-- ----------------------------
-- Records of data_handle
-- ----------------------------
INSERT INTO `data_handle` VALUES ('begin.time.eibc', 'IBC沙巴体育', '2017-12-03 20:25:07', '20171203202507', '6', '0', '639101', '960', '估计不得超过12小时', 'eIBCGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.ag', '环球AG数据采集开始时间', '201712030744', '20171203202503', '0', '0', '5822511', '30', '估计不得超过30分钟', 'TAGGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.bbin', '环球BBIN数据采集开始时间（最远7天内）', '2017-12-03 08:20:08', '20171203202523', '0', '0', '272741', '30', '估计不得超过12小时', 'BBINGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.ebet', 'eBET数据采集', '2017-12-03 20:25:07', '20171203202507', '0', '0', '2341', '60', '估计不得超过12小时', 'EBETGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.gb', 'GB彩票数据采集', 'EN003K=53231882;EN003A=52774966;EN003Y=38198069;', '20171203202506', '0', '0', '7510', '0', '无', 'GBGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.gg', '游行天下GG数据采集开始时间', '2017-08-18 22:08:00', '0', '0', '0', '28220', '10', '估计不得超过10分钟', 'GGGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.ggpoker', 'GGPoker扑克数据采集开始日期', '2017-10-30', '0', '121', '0', '18427', '0', '无', 'GGPGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.hab', 'HABA哈巴电子数据采集', '2017-11-02 11:25:00', '0', '0', '0', '25', '30', '估计不得超过60分钟', 'HABGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.idn', 'IDN数据采集', '2017-08-18', '0', '0', '0', '406', '0', '无', 'IDNGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.m88', 'M88数据采集', '2017-12-03 20:25:06', '20171203202507', '0', '0', '10', '30', '估计不得超过60分钟', 'M88Game');
INSERT INTO `data_handle` VALUES ('begin.time.hq.nhq', '环球NHQ数据采集开始时间', '2017-12-03 20:26:00', '20171203202600', '0', '0', '418604', '60', '估计不得超过240分钟', 'NHQGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.og.og', '环球OG数据采集开始时间', 'EN003K=1415269646470;EN003A=1415271039164;', '20171203202503', '0', '0', '2473', '0', '无', 'OGGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.pt', '环球PT数据采集开始时间', '2017-12-03 20:26:02', '20171203202602', '0', '0', '4665062', '30', '超过30分钟不报错但没有数据返回', 'PTGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.qt', 'QTech电子数据采集', '2017-10-20 19:35:25', '0', '0', '0', '14604', '60', '估计不得超过12小时', 'QTGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.sgs', '申博SGS数据采集开始时间', '2017-11-02 11:25:00', '0', '0', '0', '3731', '240', '估计不得超过24小时', 'SGSGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.tgp', 'TGP申博数据采集', '2017-10-20 19:35:27', '0', '0', '0', '322861', '240', '估计不得超过24小时', 'TGPGame');
INSERT INTO `data_handle` VALUES ('begin.time.hq.win88', 'WIN88的PT数据采集', '2017-12-03 20:26:00', '20171203202601', '0', '0', '13954', '30', '超过30分钟不报错但没有数据返回', 'W88Game');
INSERT INTO `data_handle` VALUES ('begin.time.im', 'IM体育', '2017-12-03 20:26:00', '20171203202600', '0', '0', '519', '10', '不得超过10分钟', 'IMGame');
INSERT INTO `data_handle` VALUES ('begin.time.jdb', 'JDB加多宝', '2017-12-03 20:21:00', '20171203202600', '0', '0', '99831', '15', '估计不得超过15分钟', 'JDBGame');
INSERT INTO `data_handle` VALUES ('begin.time.kr.av', '韩国AV老虎机', '2017-02-14 00:00:00', '0', '0', '0', '0', '20', '暂无', 'AVGame');
INSERT INTO `data_handle` VALUES ('begin.time.mg', 'MG数据采集开始时间', '2017-12-02 19:00:28', '20171202190029', '0', '0', '6718547', '60', '估计不得超过60分钟', 'MGGame');
INSERT INTO `data_handle` VALUES ('begin.time.qp', 'QP棋牌数据采集开始时间', '2017-10-07 09:40:18', '0', '0', '0', '3981', '30', '估计不得超过30分钟', 'QPGame');
INSERT INTO `data_handle` VALUES ('begin.time.qwp', '去玩棋牌', '2017-12-03 20:26:02', '20171203202603', '0', '0', '6773', '30', '估计不得超过30分钟', null);
INSERT INTO `data_handle` VALUES ('begin.time.sa', '环球沙龙数据采集开始时间', '2017-12-03 20:25:00', '20171203202501', '0', '0', '31193', '30', '估计不得超过240分钟', 'SAGame');
INSERT INTO `data_handle` VALUES ('begin.time.ttg', 'TTG数据采集开始时间', '2017-12-03 20:25:07', '20171203202508', '0', '0', '454', '30', '估计不得超过240分钟', 'TTGGame');
INSERT INTO `data_handle` VALUES ('begin.time.yoplay', 'YoPLAY数据采集开始时间', '201712030744', '20171203202504', '0', '0', '829', '5', '0', 'YoPLAYGame');
INSERT INTO `data_handle` VALUES ('begin.time.zj', '环球洲际数据采集开始时间', 'EN003A=0;', '0', '0', '0', '0', '20', '暂无', 'ZJGame');
INSERT INTO `data_handle` VALUES ('day.count.time', '日统计开始时间', '2017-10-22', '0', '0', '0', '0', '20', null, null);
INSERT INTO `data_handle` VALUES ('day.count.time.append', '日统计汇总补单数据', '2017-10-14', '0', '0', '0', '0', '20', null, null);
INSERT INTO `data_handle` VALUES ('day.count.username.time', '填充用户名数据开始日期', '20170221', '0', '0', '0', '0', '20', null, null);
INSERT INTO `data_handle` VALUES ('rebates.day.time', '日返水开始时间', '2016-6-20', '0', '0', '0', '0', '20', null, null);
INSERT INTO `data_handle` VALUES ('rebates.week.time', '周返水开始时间', '2016-6-20', '0', '0', '0', '0', '20', null, null);
INSERT INTO `data_handle` VALUES ('week.count.time', '周统计开始时间', '2016-6-20', '0', '0', '0', '0', '20', null, null);

-- ----------------------------
-- Table structure for data_handle_logs
-- ----------------------------
DROP TABLE IF EXISTS `data_handle_logs`;
CREATE TABLE `data_handle_logs` (
  `lsh` varchar(36) NOT NULL,
  `gametype` varchar(30) DEFAULT NULL,
  `lasttime` datetime DEFAULT NULL,
  `dataparams` varchar(2000) DEFAULT NULL,
  `datalog` varchar(4000) DEFAULT NULL,
  `agentaccount` varchar(50) DEFAULT NULL,
  `flag` int(11) DEFAULT '0',
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_handle_logs
-- ----------------------------

-- ----------------------------
-- Table structure for data_handle_maintenance
-- ----------------------------
DROP TABLE IF EXISTS `data_handle_maintenance`;
CREATE TABLE `data_handle_maintenance` (
  `gametype` varchar(10) NOT NULL,
  `flag` int(11) DEFAULT '1',
  `lasttime` datetime DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`gametype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_handle_maintenance
-- ----------------------------
INSERT INTO `data_handle_maintenance` VALUES ('BBINGame', '1', '2017-12-03 20:26:08', null);
INSERT INTO `data_handle_maintenance` VALUES ('EBETGame', '1', '2017-12-03 20:26:11', null);
INSERT INTO `data_handle_maintenance` VALUES ('eIBCGame', '1', '2017-12-03 20:26:12', null);
INSERT INTO `data_handle_maintenance` VALUES ('GBGame', '1', '2017-12-03 20:26:11', null);
INSERT INTO `data_handle_maintenance` VALUES ('GGGame', '3', '2017-10-18 15:17:47', null);
INSERT INTO `data_handle_maintenance` VALUES ('GGPGame', '1', '2017-12-03 20:26:17', null);
INSERT INTO `data_handle_maintenance` VALUES ('HABGame', '3', '2017-11-02 11:48:24', null);
INSERT INTO `data_handle_maintenance` VALUES ('IDNGame', '3', '2017-08-18 22:02:20', null);
INSERT INTO `data_handle_maintenance` VALUES ('IMGame', '1', '2017-12-03 20:26:19', null);
INSERT INTO `data_handle_maintenance` VALUES ('JDBGame', '1', '2017-12-03 20:26:20', null);
INSERT INTO `data_handle_maintenance` VALUES ('M88Game', '1', '2017-12-03 20:26:10', null);
INSERT INTO `data_handle_maintenance` VALUES ('MGGame', '1', '2017-12-03 20:26:13', null);
INSERT INTO `data_handle_maintenance` VALUES ('NHQGame', '1', '2017-12-03 20:26:14', null);
INSERT INTO `data_handle_maintenance` VALUES ('OGGame', '1', '2017-12-03 20:26:16', null);
INSERT INTO `data_handle_maintenance` VALUES ('PNGGame', '3', '2017-08-05 10:39:42', null);
INSERT INTO `data_handle_maintenance` VALUES ('PTGame', '1', '2017-12-03 20:26:15', null);
INSERT INTO `data_handle_maintenance` VALUES ('QPGame', '3', '2017-10-14 14:45:26', null);
INSERT INTO `data_handle_maintenance` VALUES ('QTGame', '3', '2017-10-21 08:31:57', null);
INSERT INTO `data_handle_maintenance` VALUES ('QWPGame', '1', '2017-12-03 20:26:19', null);
INSERT INTO `data_handle_maintenance` VALUES ('SAGame', '1', '2017-12-03 20:26:09', null);
INSERT INTO `data_handle_maintenance` VALUES ('SGSGame', '3', '2017-11-02 11:48:44', null);
INSERT INTO `data_handle_maintenance` VALUES ('TAGGame', '1', '2017-12-03 20:26:09', null);
INSERT INTO `data_handle_maintenance` VALUES ('TGPGame', '3', '2017-11-01 16:32:51', null);
INSERT INTO `data_handle_maintenance` VALUES ('TTGGame', '1', '2017-12-03 20:26:10', null);
INSERT INTO `data_handle_maintenance` VALUES ('W88Game', '1', '2017-12-03 20:26:18', null);
INSERT INTO `data_handle_maintenance` VALUES ('YoPLAYGame', '1', '2017-12-03 20:26:18', null);

-- ----------------------------
-- Table structure for data_handle_repeat
-- ----------------------------
DROP TABLE IF EXISTS `data_handle_repeat`;
CREATE TABLE `data_handle_repeat` (
  `lsh` varchar(36) NOT NULL,
  `gametype` varchar(10) DEFAULT NULL,
  `starttime` varchar(20) DEFAULT NULL,
  `endtime` varchar(255) DEFAULT NULL,
  `lasttime` datetime DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_handle_repeat
-- ----------------------------

-- ----------------------------
-- Table structure for deposit_withdral_order_delegate
-- ----------------------------
DROP TABLE IF EXISTS `deposit_withdral_order_delegate`;
CREATE TABLE `deposit_withdral_order_delegate` (
  `delegatecode` int(11) NOT NULL AUTO_INCREMENT COMMENT '委派编码',
  `flowcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '流程编码',
  `ordernumber` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `assignedtocode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '委派人编码',
  `assignedtoaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT '委派人名称',
  `begintime` timestamp NULL DEFAULT NULL COMMENT '开始处理时间',
  `endtime` timestamp NULL DEFAULT NULL COMMENT '处理结束时间',
  `processduration` int(11) DEFAULT NULL COMMENT '处理时长',
  `overtimereason` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '超时处理原因',
  `imgname` varchar(150) COLLATE utf8_bin DEFAULT NULL COMMENT '图片路径',
  `auditresult` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '审核结果',
  `auditdesc` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '审核说明',
  PRIMARY KEY (`delegatecode`),
  KEY `FK_deposit_w` (`flowcode`) USING BTREE,
  KEY `FK_deposit_withdral_order` (`ordernumber`) USING BTREE,
  KEY `index_assignedtocode` (`assignedtocode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='存取款单委派';

-- ----------------------------
-- Records of deposit_withdral_order_delegate
-- ----------------------------

-- ----------------------------
-- Table structure for deposit_withdraw_order
-- ----------------------------
DROP TABLE IF EXISTS `deposit_withdraw_order`;
CREATE TABLE `deposit_withdraw_order` (
  `ordernumber` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '订单号',
  `employeecode` char(10) COLLATE utf8_bin NOT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '员工上级编码',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `paymenttypecode` char(4) COLLATE utf8_bin DEFAULT NULL COMMENT '支付方式',
  `orderdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单日期',
  `orderamount` decimal(16,2) DEFAULT NULL COMMENT '订单金额',
  `exchangerate` decimal(16,5) unsigned DEFAULT NULL COMMENT '汇率',
  `enterprisepaymentname` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '企业收付款账号姓名',
  `enterprisepaymentaccount` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '企业收付款账号',
  `enterprisepaymentbank` char(4) COLLATE utf8_bin DEFAULT NULL COMMENT '企业收付款银行',
  `employeepaymentname` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '员工收付款姓名',
  `employeepaymentaccount` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '员工收付款账号',
  `employeepaymentbank` char(4) COLLATE utf8_bin DEFAULT NULL COMMENT '员工收付款银行',
  `ordertype` tinyint(4) DEFAULT NULL COMMENT '订单类型{1:存款,2:取款}',
  `orderstatus` tinyint(4) DEFAULT NULL COMMENT '订单状态{1:处理中,2:已处理,3:驳回,4:拒绝,5:待出款}',
  `ordercreater` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT '订单创建人',
  `traceip` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '跟踪IP',
  `ordercomment` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '订单备注',
  `flowcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '流程编码',
  `delegatecode` int(11) NOT NULL COMMENT '委托编码',
  `handleemployee` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT '当前处理用户',
  `handleovertime` timestamp NULL DEFAULT NULL COMMENT '订单处理完成时间',
  `favourableid` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ordernumber`),
  KEY `ER_employee_N_order_FK` (`employeecode`) USING BTREE,
  KEY `index_order_number` (`ordernumber`) USING BTREE,
  KEY `index4` (`parentemployeecode`) USING BTREE,
  KEY `index5` (`enterprisecode`) USING BTREE,
  KEY `index6` (`orderdate`) USING BTREE,
  KEY `index7` (`handleemployee`) USING BTREE,
  KEY `index8` (`delegatecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='应该有操作时间，处理人，有状态， 自动转出平台';

-- ----------------------------
-- Records of deposit_withdraw_order
-- ----------------------------

-- ----------------------------
-- Table structure for employee_agent_relation
-- ----------------------------
DROP TABLE IF EXISTS `employee_agent_relation`;
CREATE TABLE `employee_agent_relation` (
  `employeecode` char(8) NOT NULL COMMENT '用户编码',
  `loginaccount` varchar(12) NOT NULL COMMENT '登陆账号',
  `lowercode` text COMMENT '下级代理编码',
  `uppercode` text COMMENT '上级代理编码',
  `lowercodeenum` set('one','two') DEFAULT NULL,
  PRIMARY KEY (`employeecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee_agent_relation
-- ----------------------------
INSERT INTO `employee_agent_relation` VALUES ('E0000000', 'sa', 'E0000000,E000IF2W,E000IF2X', 'E0000000,00000000', null);
INSERT INTO `employee_agent_relation` VALUES ('E0000001', 'sa', 'E0000001', 'E0000001,00000000', null);
INSERT INTO `employee_agent_relation` VALUES ('E000IF2W', 'diwangguoji', 'E000IF2W', 'E000IF2W,E0000000', null);
INSERT INTO `employee_agent_relation` VALUES ('E000IF2X', 'dilonggl', 'E000IF2X', 'E000IF2X,E0000000', null);

-- ----------------------------
-- Table structure for employee_api_accout
-- ----------------------------
DROP TABLE IF EXISTS `employee_api_accout`;
CREATE TABLE `employee_api_accout` (
  `apiaccountcode` int(11) NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌ID',
  `employeecode` char(8) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '登陆账号',
  `gametype` char(12) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '游戏类型编码',
  `gameaccount` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏账号',
  `gamepassword` char(64) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏密码',
  `createtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `balance` decimal(16,2) DEFAULT '0.00',
  `status` varchar(6) COLLATE utf8_bin DEFAULT '启用',
  PRIMARY KEY (`apiaccountcode`),
  UNIQUE KEY `UK_employee_api_accout` (`employeecode`,`gametype`) USING BTREE,
  KEY `index_gameaccount` (`gameaccount`) USING BTREE,
  KEY `employee_api_accout_ix3` (`loginaccount`,`gametype`) USING BTREE,
  KEY `idx_employee_api_accout_gameaccount_gametype` (`gameaccount`,`gametype`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=84156 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='会员游戏平台账号';

-- ----------------------------
-- Records of employee_api_accout
-- ----------------------------
INSERT INTO `employee_api_accout` VALUES ('1', 'EN0000', null, 'E0000000', 'E0000000', 'sa', 'NHQGame', 'sais5gxz', 'Gnl9hjV6', '2016-11-12 15:49:20', '0.00', '启用');

-- ----------------------------
-- Table structure for employee_api_accout_password_job
-- ----------------------------
DROP TABLE IF EXISTS `employee_api_accout_password_job`;
CREATE TABLE `employee_api_accout_password_job` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `employeecode` char(8) DEFAULT NULL,
  `enterprisecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(100) DEFAULT NULL,
  `gametype` char(12) DEFAULT NULL,
  `gameaccount` varchar(30) DEFAULT NULL,
  `gamepassword` char(64) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `updatestatus` int(11) DEFAULT '0',
  `updatecomment` text,
  PRIMARY KEY (`lsh`),
  KEY `employee_api_accout_password_job_ix1` (`employeecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1155 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee_api_accout_password_job
-- ----------------------------

-- ----------------------------
-- Table structure for employee_available
-- ----------------------------
DROP TABLE IF EXISTS `employee_available`;
CREATE TABLE `employee_available` (
  `employeecode` char(8) NOT NULL COMMENT '员工编码',
  `availabletime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '有效截至时间',
  PRIMARY KEY (`employeecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户有效时间';

-- ----------------------------
-- Records of employee_available
-- ----------------------------

-- ----------------------------
-- Table structure for employee_gamecataloy_bonus
-- ----------------------------
DROP TABLE IF EXISTS `employee_gamecataloy_bonus`;
CREATE TABLE `employee_gamecataloy_bonus` (
  `employeecode` char(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '员工编码',
  `gametype` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '游戏平台标志(唯一)',
  `categorytype` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '游戏种类类型标志(唯一)',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `bonus` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '洗码',
  PRIMARY KEY (`employeecode`,`gametype`,`categorytype`),
  KEY `FK_employee_gamecataloy_bonus_game_gametype` (`gametype`) USING BTREE,
  KEY `UK_employee_gam` (`employeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='接入平台游戏种类洗码设置表';

-- ----------------------------
-- Records of employee_gamecataloy_bonus
-- ----------------------------

-- ----------------------------
-- Table structure for employee_game_login
-- ----------------------------
DROP TABLE IF EXISTS `employee_game_login`;
CREATE TABLE `employee_game_login` (
  `lsh` bigint(20) NOT NULL AUTO_INCREMENT,
  `gametype` varchar(20) DEFAULT NULL,
  `enterprisecode` char(8) DEFAULT NULL,
  `brandcode` char(8) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `gameaccount` varchar(30) DEFAULT NULL,
  `createtime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '0',
  `remark` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`lsh`),
  KEY `index_employeecode` (`employeecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee_game_login
-- ----------------------------

-- ----------------------------
-- Table structure for employee_level_condition
-- ----------------------------
DROP TABLE IF EXISTS `employee_level_condition`;
CREATE TABLE `employee_level_condition` (
  `levelconditioncode` char(4) COLLATE utf8_bin NOT NULL COMMENT '级别条件编码',
  `employeelevelcode` char(4) COLLATE utf8_bin DEFAULT NULL COMMENT '员工级别编码',
  `depositamount` decimal(16,2) DEFAULT NULL COMMENT '存款量',
  `depositnumber` int(11) DEFAULT NULL COMMENT '存款次数',
  PRIMARY KEY (`levelconditioncode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='企业员工级别表';

-- ----------------------------
-- Records of employee_level_condition
-- ----------------------------

-- ----------------------------
-- Table structure for employee_mapping_menu
-- ----------------------------
DROP TABLE IF EXISTS `employee_mapping_menu`;
CREATE TABLE `employee_mapping_menu` (
  `employeecode` char(10) COLLATE utf8_bin NOT NULL COMMENT '员工编码',
  `menucode` char(8) COLLATE utf8_bin NOT NULL COMMENT '菜单编码',
  PRIMARY KEY (`employeecode`,`menucode`),
  KEY `FK_ER_permission_group_mapping_N_group` (`employeecode`) USING BTREE,
  KEY `UK_employee_mapping_menu_menucode` (`menucode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of employee_mapping_menu
-- ----------------------------

-- ----------------------------
-- Table structure for employee_mapping_role
-- ----------------------------
DROP TABLE IF EXISTS `employee_mapping_role`;
CREATE TABLE `employee_mapping_role` (
  `employeecode` char(8) NOT NULL COMMENT '员工CODE',
  `rolecode` char(8) NOT NULL COMMENT '角色CODE',
  PRIMARY KEY (`employeecode`,`rolecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工角色对应表';

-- ----------------------------
-- Records of employee_mapping_role
-- ----------------------------

-- ----------------------------
-- Table structure for employee_message
-- ----------------------------
DROP TABLE IF EXISTS `employee_message`;
CREATE TABLE `employee_message` (
  `messagecode` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息编码',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `sendemployeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '发送人编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `sendemployeeaccount` varchar(12) COLLATE utf8_bin NOT NULL COMMENT '发送人账号',
  `messagetextcode` int(11) NOT NULL COMMENT '消息编号',
  `acceptemployeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '接收人编码',
  `acceptaccount` varchar(12) COLLATE utf8_bin NOT NULL COMMENT '接收人账号',
  `messagetype` char(1) COLLATE utf8_bin NOT NULL COMMENT '消息类型（1:系统消息 ， 2:用户消息）',
  `replaycode` int(11) DEFAULT NULL COMMENT '回复编号',
  `readstatus` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '阅读状态（1:未阅读，2:已阅读）',
  PRIMARY KEY (`messagecode`),
  KEY `FK_employee_massage_enterprise_operating_brand_brandcode` (`brandcode`) USING BTREE,
  KEY `FK_employee_message_employee_message_text_messagetextcode` (`messagetextcode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of employee_message
-- ----------------------------

-- ----------------------------
-- Table structure for employee_message_text
-- ----------------------------
DROP TABLE IF EXISTS `employee_message_text`;
CREATE TABLE `employee_message_text` (
  `messagetextcode` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息文本编号',
  `content` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '消息内容',
  `sendtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '发送时间',
  `datastatus` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '数据状态(1:正常 ， -1:删除)',
  PRIMARY KEY (`messagetextcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of employee_message_text
-- ----------------------------

-- ----------------------------
-- Table structure for employee_money_change
-- ----------------------------
DROP TABLE IF EXISTS `employee_money_change`;
CREATE TABLE `employee_money_change` (
  `moneychangecode` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '帐变编码',
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `moneychangetypecode` char(32) COLLATE utf8_bin DEFAULT NULL COMMENT '帐变类型编码',
  `moneychangedate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '帐变时间',
  `currencycode` char(3) COLLATE utf8_bin DEFAULT NULL,
  `moneychangeamount` decimal(16,2) DEFAULT NULL COMMENT '帐变金额',
  `settlementamount` decimal(16,2) DEFAULT NULL COMMENT '帐变前余额',
  `moneyaddtype` char(3) COLLATE utf8_bin DEFAULT NULL COMMENT '冲正冲负类型',
  `moneyinoutcomment` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `ordernumber` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '帐变订单编号',
  `timesort` bigint(20) DEFAULT NULL COMMENT '排序字段',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`moneychangecode`),
  KEY `ER_money_change_type_N_money_change_FK` (`moneychangetypecode`) USING BTREE,
  KEY `FK_employee_money_change_enterprise_employee_employeecode` (`employeecode`) USING BTREE,
  KEY `employee_money_change_ix3` (`parentemployeecode`) USING BTREE,
  KEY `employee_money_change_ix4` (`ordernumber`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of employee_money_change
-- ----------------------------

-- ----------------------------
-- Table structure for employee_money_change_type
-- ----------------------------
DROP TABLE IF EXISTS `employee_money_change_type`;
CREATE TABLE `employee_money_change_type` (
  `moneychangetypecode` char(32) COLLATE utf8_bin NOT NULL COMMENT '帐变类型编码',
  `moneychangetype` varchar(8) CHARACTER SET utf8 NOT NULL COMMENT '帐变类型',
  `moneychangetypeclassify` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '帐变类型类别(1、常规 2、活动)',
  `moneyinouttype` char(1) COLLATE utf8_bin NOT NULL COMMENT '进出帐类型(1进账，2出账)',
  `datastatus` char(2) COLLATE utf8_bin DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`moneychangetypecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户充值 用户取款 A活动充值...';

-- ----------------------------
-- Records of employee_money_change_type
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise
-- ----------------------------
DROP TABLE IF EXISTS `enterprise`;
CREATE TABLE `enterprise` (
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `parententerprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业上级编码',
  `enterprisename` varchar(16) COLLATE utf8_bin NOT NULL COMMENT '企业名称',
  `registrationdate` datetime NOT NULL COMMENT '登记日期',
  `datastatus` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '数据状态',
  `ipenable` char(2) COLLATE utf8_bin DEFAULT '1',
  `takerate` varchar(10) COLLATE utf8_bin DEFAULT '0',
  `depositrate` varchar(10) COLLATE utf8_bin DEFAULT '0',
  `transfertype` varchar(2) COLLATE utf8_bin DEFAULT '1',
  `rate` double DEFAULT '100',
  `rate2` double DEFAULT '1',
  `currencycode` char(8) COLLATE utf8_bin DEFAULT 'CNY' COMMENT '币种',
  PRIMARY KEY (`enterprisecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='企业';

-- ----------------------------
-- Records of enterprise
-- ----------------------------
INSERT INTO `enterprise` VALUES ('EN0000', 'NULL', '超级管理', '2015-09-28 21:39:34', '1', '1', '0', '0', '1', '1', '1', 'CNY');

-- ----------------------------
-- Table structure for enterprise_activity_customization
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_activity_customization`;
CREATE TABLE `enterprise_activity_customization` (
  `ecactivitycode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `activitytemplatecode` int(11) NOT NULL COMMENT '活动模板ID',
  `activityname` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '活动名称',
  `unshare` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '不共享活动',
  `activityimage` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '活动PC端图片',
  `activityimagehfive` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '活动H5端图片',
  `activitycontent` text COLLATE utf8_bin COMMENT '活动内容',
  `datastatus` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '数据状态',
  `remark` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `ord` int(11) DEFAULT '99',
  `activitycontenth5` text COLLATE utf8_bin,
  PRIMARY KEY (`ecactivitycode`),
  KEY `FK_enterprise_activity_customization_enterprise_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `enterprise_activity_customization_ix2` (`activitytemplatecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='企业活动定制';

-- ----------------------------
-- Records of enterprise_activity_customization
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_activity_customization_setting
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_activity_customization_setting`;
CREATE TABLE `enterprise_activity_customization_setting` (
  `eacscode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ecactivitycode` int(11) NOT NULL COMMENT '企业定制活动编码',
  `activitysettingcode` int(11) NOT NULL COMMENT '活动参数编码',
  `agementvalue` varchar(2000) NOT NULL COMMENT '参数值',
  PRIMARY KEY (`eacscode`),
  KEY `enterprise_activity_customization_setting_ix1` (`activitysettingcode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8 COMMENT='企业定制活动参数';

-- ----------------------------
-- Records of enterprise_activity_customization_setting
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_activity_pay
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_activity_pay`;
CREATE TABLE `enterprise_activity_pay` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `employeecode` char(8) DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` varchar(20) DEFAULT NULL,
  `parentemployeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `acname` varchar(500) DEFAULT NULL,
  `ecactivitycode` int(11) DEFAULT NULL,
  `paytype` int(11) DEFAULT NULL,
  `paystatus` int(11) DEFAULT NULL,
  `paymoneyaudit` double DEFAULT NULL,
  `paymoneyreal` double DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `audittime` datetime DEFAULT NULL,
  `auditer` varchar(50) DEFAULT NULL,
  `paytyime` datetime DEFAULT NULL,
  `payer` varchar(50) DEFAULT NULL,
  `auditremark` varchar(500) DEFAULT NULL,
  `descs` varchar(500) DEFAULT NULL,
  `lsbs` varchar(20) DEFAULT '1',
  `depositmoney` double DEFAULT '0',
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of enterprise_activity_pay
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_agength5_level
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_agength5_level`;
CREATE TABLE `enterprise_agength5_level` (
  `employeelevelcode` char(10) COLLATE utf8_bin NOT NULL COMMENT '员工级别编码',
  `employeelevelname` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '员工级别',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `upperlevel_rate` decimal(10,2) DEFAULT NULL COMMENT '直接上级返现比例',
  `upperlevel_rate2` decimal(10,2) DEFAULT NULL COMMENT '间接上级返现比例',
  `personcount` int(3) DEFAULT '3' COMMENT '升级条件：需发展的会员人数',
  `agengtcount` int(3) DEFAULT '3' COMMENT '升级条件：需发展的代理人数',
  `orderamount` decimal(16,2) DEFAULT '1.00' COMMENT '升级条件：下线代理需完成的元宝交易量',
  `datastatus` int(4) DEFAULT '1',
  `ord` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`employeelevelcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='企业代理级别';

-- ----------------------------
-- Records of enterprise_agength5_level
-- ----------------------------
INSERT INTO `enterprise_agength5_level` VALUES ('L01N', '一级', 'EN003Z', '0.10', '0.10', '0', '3', '1.00', '1', '1');
INSERT INTO `enterprise_agength5_level` VALUES ('L01P', '二级', 'EN003Z', '0.20', '0.10', '0', '3', '1.00', '1', '2');
INSERT INTO `enterprise_agength5_level` VALUES ('L01Q', '三级', 'EN003Z', '0.30', '0.10', '0', '3', '1.00', '1', '3');
INSERT INTO `enterprise_agength5_level` VALUES ('L01R', '四级', 'EN003Z', '0.42', '0.12', '0', '3', '1.00', '1', '4');
INSERT INTO `enterprise_agength5_level` VALUES ('L01S', '五级', 'EN003Z', '0.55', '0.13', '0', '3', '1.00', '1', '5');
INSERT INTO `enterprise_agength5_level` VALUES ('L01T', '六级', 'EN003Z', '0.05', '0.06', '0', '3', '1.00', '1', '6');

-- ----------------------------
-- Table structure for enterprise_banner_info
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_banner_info`;
CREATE TABLE `enterprise_banner_info` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `bannername` varchar(50) DEFAULT NULL,
  `bannertype` varchar(50) DEFAULT 'PC' COMMENT 'banner使用类型：PC，H5',
  `imgpath` varchar(500) DEFAULT NULL,
  `linkpath` varchar(500) DEFAULT NULL,
  `ord` int(11) DEFAULT NULL,
  `brandcode` char(8) DEFAULT NULL,
  `enterprisecode` char(8) DEFAULT NULL,
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of enterprise_banner_info
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_brand_activity
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_brand_activity`;
CREATE TABLE `enterprise_brand_activity` (
  `enterprisebrandactivitycode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '团队编码',
  `ecactivitycode` int(11) DEFAULT NULL COMMENT '定制活动编码',
  `begintime` datetime NOT NULL COMMENT '活动开始时间',
  `endtime` datetime NOT NULL COMMENT '活动结束时间',
  `status` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '活动状态',
  PRIMARY KEY (`enterprisebrandactivitycode`),
  KEY `FK_enterprise_brand_activity_enterprise_brand_brandcode` (`brandcode`) USING BTREE,
  KEY `FK_enterprise_brand_activity_enterprise_employee_employeecode` (`employeecode`) USING BTREE,
  KEY `FK_enterprise_brand_activity_enterprise_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `FK_enterprise_brand_activity_activity_template_activitycode` (`ecactivitycode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='企业品牌活动';

-- ----------------------------
-- Records of enterprise_brand_activity
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_brand_contact
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_brand_contact`;
CREATE TABLE `enterprise_brand_contact` (
  `contactcode` char(10) COLLATE utf8_bin NOT NULL COMMENT '联系方式编码',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin NOT NULL COMMENT '品牌编码',
  `contacttitle` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '联系方式title',
  `contacttype` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '联系方式类型(QQ,Skyle,Vchat,Phone)',
  `content` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '联系方式内容',
  `contenttype` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '内容类型(value,link,img)',
  `enable` char(1) COLLATE utf8_bin NOT NULL COMMENT '是否启用(1、启用 2、禁用)',
  `datastatus` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '数据类型(1、正常 -1、删除)',
  PRIMARY KEY (`contactcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='品牌客服联系方式';

-- ----------------------------
-- Records of enterprise_brand_contact
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_brand_notic
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_brand_notic`;
CREATE TABLE `enterprise_brand_notic` (
  `noticcode` char(12) COLLATE utf8_bin NOT NULL COMMENT '公告编码',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `brandcode` char(10) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `notictype` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '公告类型',
  `title` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '公告标题',
  `content` varchar(1000) COLLATE utf8_bin NOT NULL COMMENT '公告内容',
  `begintime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '公告开始时间',
  `endtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '公告结束时间',
  `createtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datastatus` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`noticcode`),
  KEY `FK_enterprise_brand_notic_enterprise_operating_brand_brandcode` (`brandcode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of enterprise_brand_notic
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_employee
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_employee`;
CREATE TABLE `enterprise_employee` (
  `employeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '上级员工编码',
  `parentemployeeaccount` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT '上级员工账号',
  `employeetypecode` char(4) COLLATE utf8_bin NOT NULL COMMENT '员工类型编码',
  `employeelevelcode` char(10) COLLATE utf8_bin DEFAULT NULL COMMENT '员工层级编码',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `loginaccount` varchar(12) COLLATE utf8_bin NOT NULL COMMENT '登录账号',
  `loginpassword` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '登录密码',
  `fundpassword` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '资金密码',
  `displayalias` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '用户昵称',
  `onlinestatus` tinyint(4) NOT NULL DEFAULT '0' COMMENT '在线状态(0=下线 1=在线)',
  `employeestatus` tinyint(4) NOT NULL DEFAULT '1' COMMENT '员工状态(1.启用 2.锁定游戏 3.禁用)',
  `logindatetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册登录时间',
  `lastlogintime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上次登录时间',
  `dividend` decimal(5,4) DEFAULT '0.0000' COMMENT '分红',
  `share` decimal(5,4) DEFAULT '0.0000' COMMENT '占成',
  `creditrating` tinyint(4) NOT NULL DEFAULT '0',
  `registercode` char(32) COLLATE utf8_bin DEFAULT NULL COMMENT '注册链接编码',
  `datastatus` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '1:有效用户，-1:无效的用户',
  `loginpassword2` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `phoneno` varchar(11) COLLATE utf8_bin DEFAULT NULL,
  `ipstatus` varchar(2) COLLATE utf8_bin DEFAULT '1',
  `email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `qq` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `wechat` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `alipay` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `phonestatus` varchar(2) COLLATE utf8_bin DEFAULT '0',
  PRIMARY KEY (`employeecode`),
  KEY `ix_enterprise_employee_employeecode_parentemployeecode` (`employeecode`,`parentemployeecode`) USING BTREE,
  KEY `IX_enterprise_employee_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `FK_enterprise_employ` (`employeelevelcode`) USING BTREE,
  KEY `FK_enterprise_employee_enterprise_employee_type_employeetypecode` (`employeetypecode`) USING BTREE,
  KEY `IDX_enterprise_employee_dividend` (`dividend`) USING BTREE,
  KEY `IDX_enterprise_employee_share` (`share`) USING BTREE,
  KEY `index_loginaccount` (`loginaccount`) USING BTREE,
  KEY `index_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `index_brandcode` (`brandcode`) USING BTREE,
  KEY `enterprise_employee_ix10` (`phoneno`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='代理可以看成企业在外的员工\r\n\r\n是否要加推荐人 活动渠道  设备渠道（ios,android,ip';

-- ----------------------------
-- Records of enterprise_employee
-- ----------------------------
INSERT INTO `enterprise_employee` VALUES ('E0000000', '00000000', '0', 'T001', null, 'EN0000', null, 'sa', '46f94c8de14fb36680850768ff1b7f2a', '11f034b5e13dd6f48b87912c8d6cc548', '超级管理员', '1', '1', '2015-10-07 06:42:11', '2018-01-03 23:42:17', '1.0000', '1.0000', '0', null, '1', 'PZnEDcn9s1WL8W6YLFmBFg==', null, '2', null, null, null, null, '0');

-- ----------------------------
-- Table structure for enterprise_employee_all_uplevels
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_employee_all_uplevels`;
CREATE TABLE `enterprise_employee_all_uplevels` (
  `employeecode` char(8) NOT NULL,
  `parentemployeecode` varchar(8) NOT NULL DEFAULT '00000000',
  `employeetypecode` char(4) NOT NULL,
  `employeeallupleves` varchar(1000) NOT NULL COMMENT '最大100层，如果超过100层级， 调整该字段',
  `brandcode` char(8) DEFAULT NULL,
  `loginaccount` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`employeecode`),
  KEY `idx_enterprise_employee_all_uplevels_employeeallupleves_eep` (`employeeallupleves`(191),`employeetypecode`,`employeecode`,`parentemployeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='包函有所有用户的层级字段， 这个表由enterprise_employee表触发器来完成维护';

-- ----------------------------
-- Records of enterprise_employee_all_uplevels
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_employee_capital_account
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_employee_capital_account`;
CREATE TABLE `enterprise_employee_capital_account` (
  `employeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `balance` decimal(16,2) NOT NULL COMMENT '账户余额',
  `upintegralbalance` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '上分前余额',
  `accumulateddeposit` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '累计存款',
  `accumulatedwithdraw` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '累计提现',
  PRIMARY KEY (`employeecode`),
  KEY `index_employeecode` (`employeecode`) USING BTREE,
  KEY `index_parentemployeecode` (`parentemployeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='企业人员资金账户';

-- ----------------------------
-- Records of enterprise_employee_capital_account
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_employee_information
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_employee_information`;
CREATE TABLE `enterprise_employee_information` (
  `informationcode` char(8) COLLATE utf8_bin NOT NULL COMMENT '用户银行卡编码',
  `employeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `bankcode` char(4) COLLATE utf8_bin NOT NULL COMMENT '银行编码',
  `paymentaccount` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '账号',
  `accountname` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '户名',
  `openningbank` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '开户支行',
  `phonenumber` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `QQ` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT 'QQ',
  `skype` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT 'skype',
  `email` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT 'email',
  `infomationcomment` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `status` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态(1:锁定 2:解锁 )',
  `datastatus` char(2) COLLATE utf8_bin DEFAULT '1' COMMENT '1正常，-1删除',
  PRIMARY KEY (`informationcode`),
  KEY `FK_ER_bank_N_bank_card` (`bankcode`) USING BTREE,
  KEY `FK_enterprise_employee_information_enterprise` (`employeecode`) USING BTREE,
  KEY `index_enterprisecode` (`enterprisecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of enterprise_employee_information
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_employee_level
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_employee_level`;
CREATE TABLE `enterprise_employee_level` (
  `employeelevelcode` char(10) COLLATE utf8_bin NOT NULL COMMENT '员工级别编码',
  `employeelevel` varchar(8) CHARACTER SET utf8 NOT NULL COMMENT '员工级别',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `taketimeofday` smallint(6) DEFAULT NULL COMMENT '每日取款次数',
  `takemoneyofday` decimal(16,2) DEFAULT NULL COMMENT '每日取款金额',
  `bankcardcout` int(3) DEFAULT '5' COMMENT '可绑定银行卡数量',
  `datastatus` int(4) DEFAULT '1',
  `isdefault` varchar(2) COLLATE utf8_bin DEFAULT '0',
  `ord` int(11) DEFAULT '1',
  `conditionlevel` varchar(100) COLLATE utf8_bin DEFAULT '0-0',
  PRIMARY KEY (`employeelevelcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='企业员工级别';

-- ----------------------------
-- Records of enterprise_employee_level
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_employee_level_bonus
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_employee_level_bonus`;
CREATE TABLE `enterprise_employee_level_bonus` (
  `employeelevelcode` char(10) NOT NULL,
  `gametype` varchar(8) NOT NULL,
  `categorytype` varchar(4) NOT NULL,
  `bonus` decimal(5,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`employeelevelcode`,`gametype`,`categorytype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of enterprise_employee_level_bonus
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_employee_regedit_log
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_employee_regedit_log`;
CREATE TABLE `enterprise_employee_regedit_log` (
  `lsh` varchar(36) NOT NULL DEFAULT '',
  `enterprisecode` char(8) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(20) DEFAULT NULL,
  `parentemployeeaccount` varchar(20) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`lsh`),
  KEY `index_enterprise_employee_regedit_log_1` (`enterprisecode`) USING BTREE,
  KEY `index_enterprise_employee_regedit_log_2` (`ip`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of enterprise_employee_regedit_log
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_employee_type
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_employee_type`;
CREATE TABLE `enterprise_employee_type` (
  `employeetypecode` char(4) COLLATE utf8_bin NOT NULL COMMENT '员工类别编码',
  `employeetype` varchar(8) CHARACTER SET utf8 DEFAULT NULL COMMENT '员工类别',
  `datastatus` int(4) DEFAULT '0' COMMENT '{0=有效的,1=无效的}',
  PRIMARY KEY (`employeetypecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='企业员工类别';

-- ----------------------------
-- Records of enterprise_employee_type
-- ----------------------------
INSERT INTO `enterprise_employee_type` VALUES ('T001', '业主', '1');
INSERT INTO `enterprise_employee_type` VALUES ('T002', '员工', '1');
INSERT INTO `enterprise_employee_type` VALUES ('T003', '会员', '1');
INSERT INTO `enterprise_employee_type` VALUES ('T004', '代理', '1');
INSERT INTO `enterprise_employee_type` VALUES ('T005', '信用代理', '1');
INSERT INTO `enterprise_employee_type` VALUES ('T006', '大股东', '1');
INSERT INTO `enterprise_employee_type` VALUES ('T007', '股东', '1');
INSERT INTO `enterprise_employee_type` VALUES ('T008', '总代理', '1');

-- ----------------------------
-- Table structure for enterprise_game
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_game`;
CREATE TABLE `enterprise_game` (
  `code` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `gamecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '接口编码',
  PRIMARY KEY (`code`),
  KEY `FK_enterprise_game_enterprise_enterprisecode` (`enterprisecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1358 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of enterprise_game
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_information
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_information`;
CREATE TABLE `enterprise_information` (
  `enterpriseinformationcode` char(8) COLLATE utf8_bin NOT NULL COMMENT '企业银行卡编码',
  `bankcode` char(4) COLLATE utf8_bin DEFAULT NULL COMMENT '银行代码',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `openningaccount` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '账号或地址',
  `accountname` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT '开户名',
  `openningbank` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '开户支行',
  `enterprisecontact` varchar(8) COLLATE utf8_bin DEFAULT NULL COMMENT '企业联系人',
  `enterprisephone` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT '企业联系人电话',
  `enterpriseqq` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT '企业联系人QQ',
  `enterpriseemail` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '企业联系人邮箱',
  `currentbalance` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '当前余额',
  `enable` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '是否启用',
  `datastatus` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`enterpriseinformationcode`),
  KEY `FK_enterprise_information_bank_bankcode` (`bankcode`) USING BTREE,
  KEY `FK_enterprise_information_enterprise_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `UK_enterprise_information` (`openningbank`,`datastatus`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of enterprise_information
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_information_qrcode
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_information_qrcode`;
CREATE TABLE `enterprise_information_qrcode` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` char(8) DEFAULT NULL,
  `qrtype` int(2) DEFAULT '1',
  `qrurl` varchar(500) DEFAULT NULL,
  `qraccountno` varchar(50) DEFAULT NULL,
  `qraccountname` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of enterprise_information_qrcode
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_operating_brand
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_operating_brand`;
CREATE TABLE `enterprise_operating_brand` (
  `brandcode` char(8) COLLATE utf8_bin NOT NULL,
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL,
  `brandname` varchar(16) COLLATE utf8_bin NOT NULL,
  `brandfoundedtime` datetime NOT NULL,
  `webtemplatecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT 'web模板编码',
  `logopath` varchar(150) COLLATE utf8_bin NOT NULL,
  `defualtchip` decimal(5,2) NOT NULL DEFAULT '1.00' COMMENT '默认打码',
  `datastatus` char(2) COLLATE utf8_bin DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`brandcode`),
  KEY `FK_enterprise_operating_brand_webview_template_webtemplatecode` (`webtemplatecode`) USING BTREE,
  KEY `index_enterprisecode` (`enterprisecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='一般指前端的现金网';

-- ----------------------------
-- Records of enterprise_operating_brand
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_operating_brand_game
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_operating_brand_game`;
CREATE TABLE `enterprise_operating_brand_game` (
  `brandcode` char(8) COLLATE utf8_bin NOT NULL COMMENT '品牌编码',
  `gamecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '接口编码',
  `flag` int(11) DEFAULT '0',
  PRIMARY KEY (`brandcode`,`gamecode`),
  KEY `FK_enterprise_operating_brand_game_game_gamecode` (`gamecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='企业品牌接入游戏';

-- ----------------------------
-- Records of enterprise_operating_brand_game
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_operating_brand_pay
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_operating_brand_pay`;
CREATE TABLE `enterprise_operating_brand_pay` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `enterprisecode` char(8) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '品牌编码',
  `paycallbackurl` varchar(255) DEFAULT NULL COMMENT '回调域名',
  `adminurl` varchar(255) DEFAULT NULL,
  `datastatus` int(11) DEFAULT '1' COMMENT '是否有效 0=否1=是',
  PRIMARY KEY (`lsh`),
  KEY `enterprise_operating_brand_pay_ix1` (`enterprisecode`) USING BTREE,
  KEY `enterprise_operating_brand_pay_ix2` (`brandcode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='品牌支付回调域名管理';

-- ----------------------------
-- Records of enterprise_operating_brand_pay
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_report_dates
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_report_dates`;
CREATE TABLE `enterprise_report_dates` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `enterprisecode` char(6) DEFAULT NULL,
  `reportdate` int(8) DEFAULT NULL COMMENT '报表日期',
  `member_regedit_count` int(11) DEFAULT NULL COMMENT '会员注册人数',
  `agent_regedit_count` int(11) DEFAULT NULL COMMENT '理代注册人数',
  `login_count` int(11) DEFAULT NULL COMMENT '登录人数',
  `first_deposit_count` int(11) DEFAULT NULL COMMENT '首存人数',
  `first_deposit_money` double DEFAULT NULL COMMENT '首存总额',
  `second_deposit_count` int(11) DEFAULT NULL COMMENT '二存人数',
  `second_deposit_money` double DEFAULT NULL COMMENT '二存总额',
  `no_second_count` int(11) DEFAULT NULL COMMENT '首存未二存人数',
  `no_three_count` int(11) DEFAULT NULL COMMENT '二存未三存人数',
  `today_deposit_count` int(11) DEFAULT NULL COMMENT '存款人数',
  `today_deposit_count1` int(11) DEFAULT NULL COMMENT '存款总人次',
  `today_deposit_money` double DEFAULT NULL COMMENT '存款总额',
  `today_take_count` int(11) DEFAULT NULL COMMENT '取款人数',
  `today_take_count1` int(11) DEFAULT NULL COMMENT '款取总人次',
  `today_take_money` double DEFAULT NULL COMMENT '取款总额',
  `today_betmoney` double DEFAULT NULL COMMENT '投注总额',
  `today_netmoney` double DEFAULT NULL COMMENT '赢输总额',
  `today_vaildmoney` double DEFAULT NULL COMMENT '有效投注总额',
  `today_prosmoney` double DEFAULT NULL COMMENT '冲正总额',
  `today_consmoney` double DEFAULT NULL COMMENT '冲负总额',
  `today_preferential_count` int(11) DEFAULT NULL COMMENT '优惠人数',
  `today_preferential_money` double DEFAULT NULL COMMENT '优惠总额',
  `today_wash_count` int(11) DEFAULT NULL COMMENT '洗码发放人数',
  `today_wash_money` double DEFAULT NULL COMMENT '洗码发放总额',
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB AUTO_INCREMENT=503 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of enterprise_report_dates
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_thirdparty_payment
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_thirdparty_payment`;
CREATE TABLE `enterprise_thirdparty_payment` (
  `enterprisethirdpartycode` char(8) COLLATE utf8_bin NOT NULL COMMENT '企业第三方支付编码',
  `dscription` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '账号描述',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `thirdpartypaymenttypecode` char(4) COLLATE utf8_bin NOT NULL COMMENT '第三方支付类型编码',
  `currentbalance` decimal(16,2) DEFAULT '0.00' COMMENT '当前余额',
  `status` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '状态（1：启用 2：禁用)',
  `isdefualttakecard` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '是否为默认系统自动出款卡(0:否，1:是)',
  `datastatus` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '数据状态',
  `h5status` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1',
  `isbanks` tinyint(4) DEFAULT '1',
  `isweixin` tinyint(4) DEFAULT '1',
  `iszhifubao` tinyint(4) DEFAULT '1',
  `displayname` varchar(30) COLLATE utf8_bin DEFAULT '未定义',
  `minmoney` decimal(16,2) DEFAULT '100.00',
  `maxmoney` decimal(16,2) DEFAULT '50000.00',
  `ord` varchar(2) COLLATE utf8_bin DEFAULT '99',
  `callbackurl` varchar(500) COLLATE utf8_bin DEFAULT 'http://api.hyzonghe.net/',
  PRIMARY KEY (`enterprisethirdpartycode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of enterprise_thirdparty_payment
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_thirdparty_payment_agument
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_thirdparty_payment_agument`;
CREATE TABLE `enterprise_thirdparty_payment_agument` (
  `paymentagumentcode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisethirdpartycode` char(8) COLLATE utf8_bin NOT NULL COMMENT '企业第三方支付编码',
  `paymentsettingcode` char(5) COLLATE utf8_bin NOT NULL COMMENT '第三方支付参数编码',
  `agumentvalue` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '参数值',
  PRIMARY KEY (`paymentagumentcode`),
  KEY `index_enterprisethirdpartycode` (`enterprisethirdpartycode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=889 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of enterprise_thirdparty_payment_agument
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_webview
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_webview`;
CREATE TABLE `enterprise_webview` (
  `ewvcode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键,自增长',
  `enterprisecode` char(6) NOT NULL COMMENT '企业编码',
  `webtemplatecode` char(6) NOT NULL COMMENT 'web模板编码',
  `sitetype` char(1) NOT NULL DEFAULT '1' COMMENT '1、会员站点  2、代理站点',
  PRIMARY KEY (`ewvcode`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8 COMMENT='web模板分配';

-- ----------------------------
-- Records of enterprise_webview
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_withdral_config
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_withdral_config`;
CREATE TABLE `enterprise_withdral_config` (
  `enterprisecode` char(6) NOT NULL COMMENT '企业编码',
  `withdralway` char(1) NOT NULL COMMENT '取款方式（1:系统自动出款，2:财务手动出款）',
  `upperlimit` decimal(10,2) DEFAULT NULL COMMENT '出款上线(金额设置)',
  PRIMARY KEY (`enterprisecode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='企业出款方式配置';

-- ----------------------------
-- Records of enterprise_withdral_config
-- ----------------------------
INSERT INTO `enterprise_withdral_config` VALUES ('EN0000', '2', null);

-- ----------------------------
-- Table structure for exchange_rate
-- ----------------------------
DROP TABLE IF EXISTS `exchange_rate`;
CREATE TABLE `exchange_rate` (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `currencyname` varchar(12) NOT NULL COMMENT '货币名称',
  `currencycode` char(8) NOT NULL COMMENT '货币字母代码',
  `exchangerate` decimal(8,4) DEFAULT '0.0000' COMMENT '对人民币汇率',
  `oprationtime` timestamp NULL DEFAULT NULL COMMENT '操作时间',
  `oprationperson` varchar(12) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exchange_rate
-- ----------------------------
INSERT INTO `exchange_rate` VALUES ('1', '美元', 'USD', '0.1500', '2017-10-15 10:09:19', 'eggbet88');
INSERT INTO `exchange_rate` VALUES ('2', '港币', 'HKD', '1.1277', '2017-05-07 14:29:11', 'sa');
INSERT INTO `exchange_rate` VALUES ('3', '新台币', 'TWD', '4.3711', '2017-05-07 14:29:11', 'sa');
INSERT INTO `exchange_rate` VALUES ('4', '欧元', 'EUR', '0.1318', '2017-05-07 14:29:11', 'sa');
INSERT INTO `exchange_rate` VALUES ('7', '印尼盾', 'IDR', '2045.0000', '2017-09-14 18:26:35', 'lin8888');
INSERT INTO `exchange_rate` VALUES ('11', '韩元', 'KRW', '172.6300', '2017-09-14 17:46:57', 'dwshichang');

-- ----------------------------
-- Table structure for favourable
-- ----------------------------
DROP TABLE IF EXISTS `favourable`;
CREATE TABLE `favourable` (
  `lsh` varchar(36) NOT NULL DEFAULT '',
  `favourablename` varchar(100) DEFAULT NULL,
  `isonce` int(11) DEFAULT '0',
  `enterprisecode` char(6) DEFAULT NULL,
  `lsbs` double DEFAULT NULL,
  `starttime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `isdeault` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of favourable
-- ----------------------------
INSERT INTO `favourable` VALUES ('13220d3a-8fc3-400f-887f-6c9a0103a10a', 'TTG老虎机优惠', '1', 'EN003Q', '20', '2017-05-01 00:00:00', '2017-06-30 23:59:59', '2017-05-24 20:34:40', '0', '0');
INSERT INTO `favourable` VALUES ('190daf48-f9d9-4e63-9f69-db15d0fc81b8', '免费888', '1', 'EN003A', '25', '2017-08-14 15:05:00', '2017-08-14 08:08:00', '2017-08-14 15:06:52', '0', '1');
INSERT INTO `favourable` VALUES ('1be3e1cd-7b6e-48bf-b3ba-06396181693f', '1288元体育首存', '0', 'EN003Q', '16', '2017-05-01 00:00:00', '2017-06-30 23:59:59', '2017-05-24 19:24:39', '0', '0');
INSERT INTO `favourable` VALUES ('36374f9c-1707-4419-857c-ce71de5f6e36', '68%老虎机首存', '0', 'EN003Q', '20', '2017-05-01 00:00:00', '2017-06-30 23:59:59', '2017-05-24 20:07:36', '0', '0');
INSERT INTO `favourable` VALUES ('58c59f7a-a3d0-4bc4-ac33-b4bcced575af', '负盈利转运金', '1', 'EN003Q', '1', '2017-05-01 00:00:00', '2017-06-30 23:59:59', '2017-05-24 20:20:00', '0', '0');
INSERT INTO `favourable` VALUES ('6608a205-4f27-44c5-8208-962e2c996581', '规范的功夫高', '1', 'EN0030', '1', '2017-04-09 13:40:00', '2017-04-28 13:40:00', '2017-04-09 13:40:49', '1', '0');
INSERT INTO `favourable` VALUES ('76e83a53-4990-4874-b715-9b8806e89267', '每日来每日送1倍水', '1', 'EN003Q', '1', '2017-05-01 00:00:00', '2017-06-30 23:59:59', '2017-05-25 13:29:45', '0', '0');
INSERT INTO `favourable` VALUES ('7acd9451-e8ee-4f66-ba5a-695b2fdd424b', '代理开运红包', '1', 'EN003X', '3', '2017-05-01 00:00:00', '2017-12-31 23:59:59', '2017-05-22 13:17:26', '0', '0');
INSERT INTO `favourable` VALUES ('7ee3f4dd-09b2-47c5-855b-c2f29358ab6b', '108元周周送', '1', 'EN003Q', '20', '2017-05-01 00:00:00', '2017-06-30 23:59:59', '2017-05-24 19:43:02', '0', '0');
INSERT INTO `favourable` VALUES ('a69e424a-3d62-4141-a4d7-d72b74a2496e', '22000元豪礼尽兴来博娱乐', '1', 'EN003Q', '1', '2017-05-01 00:00:00', '2017-06-30 23:59:59', '2017-05-24 19:33:21', '0', '0');
INSERT INTO `favourable` VALUES ('ab44e637-9977-40ab-82d2-317cc9026cfd', '每日100%礼金打老虎', '1', 'EN003Q', '1', '2017-05-01 00:00:00', '2017-06-30 23:59:59', '2017-05-24 20:38:24', '0', '0');
INSERT INTO `favourable` VALUES ('df26d75b-f0ed-46dc-bd37-0f26bd0982b5', '月月拿月月送', '1', 'EN003Q', '1', '2017-05-01 00:00:00', '2017-06-30 23:59:59', '2017-05-24 20:02:28', '0', '0');
INSERT INTO `favourable` VALUES ('e31483c5-a6fa-474b-9f53-f3bd4f19e89d', '1888元老虎机笔笔存送', '1', 'EN003Q', '15', '2017-05-01 00:00:00', '2017-06-30 23:59:59', '2017-05-24 19:38:38', '0', '0');

-- ----------------------------
-- Table structure for favourable_user
-- ----------------------------
DROP TABLE IF EXISTS `favourable_user`;
CREATE TABLE `favourable_user` (
  `lsh` varchar(36) NOT NULL DEFAULT '',
  `favourableid` varchar(36) DEFAULT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  PRIMARY KEY (`lsh`),
  KEY `index1` (`enterprisecode`,`employeecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for game
-- ----------------------------
DROP TABLE IF EXISTS `game`;
CREATE TABLE `game` (
  `gamecode` char(4) COLLATE utf8_bin NOT NULL COMMENT '游戏编码',
  `gametype` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '游戏类型',
  `gamename` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏名称',
  `sort` int(2) DEFAULT NULL COMMENT '排序',
  `picid` varchar(6) COLLATE utf8_bin DEFAULT NULL COMMENT '素材ID',
  `android` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT 'android唤起语句',
  `h5` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT 'IOS唤起语句',
  `iso` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT 'H5登陆链接',
  `downloadurl` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '下载链接',
  `datastatus` char(2) COLLATE utf8_bin DEFAULT '1' COMMENT '数据是否删除(1有效，-1删除)',
  PRIMARY KEY (`gamecode`),
  UNIQUE KEY `UK_game_gametype` (`gametype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='游戏';

-- ----------------------------
-- Records of game
-- ----------------------------
INSERT INTO `game` VALUES ('G001', 'BBINGame', 'BBIN波音', '2', 'pic002', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G002', 'AGGame', 'OG-AG 东方-AG', '5', 'pic005', null, null, null, null, '-1');
INSERT INTO `game` VALUES ('G003', 'XCPGame', '火星彩票', '8', 'pic008', null, null, null, null, '-1');
INSERT INTO `game` VALUES ('G004', 'TAGGame', 'AG游戏', '3', 'pic003', null, 'http://tcbet888.com/game-go-TAGGameDz.html', null, null, '1');
INSERT INTO `game` VALUES ('G005', 'PTGame', 'PT游戏', '6', 'pic006', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G006', 'OGGame', 'OG东方', '4', 'pic004', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G007', 'QPGame', '帝王棋牌', '9', 'pic009', null, null, null, null, '-1');
INSERT INTO `game` VALUES ('G008', 'IBCGame', '沙巴体育', '7', 'pic007', null, null, null, null, '-1');
INSERT INTO `game` VALUES ('G009', 'NHQGame', 'HY视讯', '1', 'pic001', 'dw://app?param={0}', 'http://phone.432dw.com/autoLogin.do?param={0}', 'dw://app?param={0}', 'http://www.432dw.com/download.do', '1');
INSERT INTO `game` VALUES ('G00I', 'HXQPGame', '火星棋牌', '14', '', null, null, null, null, '-1');
INSERT INTO `game` VALUES ('G00J', 'TTGGame', 'TTG老虎机', '13', 'pic015', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G00K', 'MGGame', 'MG游戏', '14', 'pic014', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G00L', 'PNGGame', 'PNG老虎机', '18', 'pic016', null, null, null, null, '-1');
INSERT INTO `game` VALUES ('G00M', 'DZDYGame', '德州扑克', '19', 'pic017', null, null, null, null, '-1');
INSERT INTO `game` VALUES ('G010', 'YAGGame', '云谷AG', '10', 'pic010', null, null, null, null, '-1');
INSERT INTO `game` VALUES ('G011', 'AVGame', 'AV老虎机', '11', 'pic011', null, null, null, null, '-1');
INSERT INTO `game` VALUES ('G012', 'ZJGame', 'ZJ洲际', '12', 'pic012', null, null, null, null, '-1');
INSERT INTO `game` VALUES ('G013', 'SAGame', 'SA沙龙', '13', 'pic013', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G019', 'SGSGame', '申博', '19', 'pic019', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G020', 'GGGame', 'GG捕鱼', '20', 'pic020', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G021', 'IDNGame', 'IDN扑克', '21', 'pic021', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G022', 'M88Game', 'M88体育', '22', 'pic022', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G023', 'HABGame', 'HB哈巴电子', '23', 'pic023', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G024', 'QTGame', 'QTech电子', '24', 'pic024', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G025', 'GBGame', 'GB彩票', '25', 'pic025', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G026', 'EBETGame', 'eBET视讯', '26', 'pic026', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G027', 'TGPGame', 'TGPlayer申博', '27', 'pic027', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G028', 'GGPGame', 'GG扑克', '28', 'pic028', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G029', 'W88Game', 'PT游戏', '29', 'pic029', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G030', 'eIBCGame', 'IBC沙巴体育', '30', 'pic030', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G031', 'YoPLAYGame', '电子娱乐', '31', 'pic031', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G032', 'QWPGame', '去玩棋牌', '32', 'pic032', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G033', 'IMGame', 'IM体育', '33', 'pic033', null, null, null, null, '1');
INSERT INTO `game` VALUES ('G034', 'JDBGame', 'JDB加多宝', '34', 'pic034', null, null, null, null, '1');

-- ----------------------------
-- Table structure for game_api_input
-- ----------------------------
DROP TABLE IF EXISTS `game_api_input`;
CREATE TABLE `game_api_input` (
  `apicode` char(8) COLLATE utf8_bin NOT NULL COMMENT '接口编码',
  `platformcode` char(64) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏编码',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `apiurl` varchar(256) COLLATE utf8_bin NOT NULL COMMENT '接口地址',
  `outputapistatus` tinyint(4) NOT NULL COMMENT '接口状态',
  `apikey1` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '接口key1',
  `apikey2` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '接口key2',
  `apiuser` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '接口用户',
  `apipassword` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '接口用户密码',
  `apicomment` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '接口备注',
  `trytime` smallint(6) DEFAULT '5' COMMENT '接口尝试连接次数',
  PRIMARY KEY (`apicode`),
  UNIQUE KEY `UK_game_api_input_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `FK_game_api_input_game_gamecode` (`platformcode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='游戏接入接口';

-- ----------------------------
-- Records of game_api_input
-- ----------------------------

-- ----------------------------
-- Table structure for game_category
-- ----------------------------
DROP TABLE IF EXISTS `game_category`;
CREATE TABLE `game_category` (
  `categorycode` int(11) NOT NULL AUTO_INCREMENT COMMENT '游戏种类编码',
  `gametype` varchar(10) NOT NULL COMMENT '游戏平台标志(唯一)',
  `categorytype` varchar(8) NOT NULL COMMENT '游戏种类类型标志(唯一)',
  `categoryname` varchar(8) NOT NULL COMMENT '游戏种类名称',
  `minbonus` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '最小洗码值',
  `maxbonus` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '最大洗码值',
  `sort` smallint(6) NOT NULL COMMENT '排序',
  PRIMARY KEY (`categorycode`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of game_category
-- ----------------------------
INSERT INTO `game_category` VALUES ('3', 'XCPGame', 'CP', '彩票', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('9', 'BBINGame', 'TY', '体育', '0.0000', '1.0000', '3');
INSERT INTO `game_category` VALUES ('16', 'IBCGame', 'TY', '体育', '0.0000', '1.0000', '3');
INSERT INTO `game_category` VALUES ('17', 'BBINGame', 'SX', '视讯', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('18', 'AGGame', 'SX', '视讯', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('20', 'TAGGame', 'SX', '视讯', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('21', 'PTGame', 'SX', '视讯', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('22', 'OGGame', 'SX', '视讯', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('25', 'BBINGame', 'DZ', '电子', '0.0000', '1.0000', '4');
INSERT INTO `game_category` VALUES ('26', 'AGGame', 'DZ', '电子', '0.0000', '1.0000', '4');
INSERT INTO `game_category` VALUES ('28', 'TAGGame', 'DZ', '电子', '0.0000', '1.0000', '4');
INSERT INTO `game_category` VALUES ('29', 'PTGame', 'DZ', '电子', '0.0000', '1.0000', '4');
INSERT INTO `game_category` VALUES ('33', 'BBINGame', 'CP', '彩票', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('35', 'NHQGame', 'SX', '视讯', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('36', 'AVGame', 'DZ', '电子', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('37', 'YAGGame', 'SX', '视讯', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('38', 'YAGGame', 'DZ', '电子', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('39', 'SAGame', 'SX', '视讯', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('40', 'SAGame', 'DZ', '电子', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('41', 'ZJGame', 'SX', '视讯', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('42', 'QPGame', 'QP', '棋牌', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('43', 'MGGame', 'DZ', '电子', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('44', 'MGGame', 'SX', '视讯', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('45', 'PNGGame', 'DZ', '电子', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('46', 'GGGame', 'DZ', '电子', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('47', 'SGSGame', 'SX', '视讯', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('48', 'SGSGame', 'DZ', '电子', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('49', 'IDNGame', 'QP', '棋牌', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('50', 'M88Game', 'TY', '体育', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('51', 'HABGame', 'DZ', '电子', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('52', 'QTGame', 'DZ', '电子', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('53', 'GBGame', 'CP', '彩票', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('54', 'EBETGame', 'SX', '视讯', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('55', 'TGPGame', 'SX', '视讯', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('56', 'TGPGame', 'DZ', '电子', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('57', 'GGPGame', 'QP', '棋牌', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('58', 'W88Game', 'SX', '视讯', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('59', 'W88Game', 'DZ', '电子', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('60', 'TTGGame', 'DZ', '电子', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('61', 'eIBCGame', 'TY', '体育', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('62', 'eIBCGame', 'DZ', '电子', '0.0000', '1.0000', '2');
INSERT INTO `game_category` VALUES ('63', 'YoPLAYGame', 'DZ', '电子', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('64', 'IMGame', 'TY', '体育', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('65', 'QWPGame', 'QP', '棋牌', '0.0000', '1.0000', '1');
INSERT INTO `game_category` VALUES ('66', 'JDBGame', 'DZ', '电子', '0.0000', '1.0000', '1');

-- ----------------------------
-- Table structure for game_class
-- ----------------------------
DROP TABLE IF EXISTS `game_class`;
CREATE TABLE `game_class` (
  `gameclasscode` int(11) NOT NULL AUTO_INCREMENT,
  `gametype` varchar(8) COLLATE utf8_bin NOT NULL COMMENT '游戏类型(BBINGame,AGGame...)',
  `classchinaname` varchar(25) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏分类名称(中文)',
  `classenglishname` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏分类名称(英文)',
  `parentclasstype` char(5) COLLATE utf8_bin DEFAULT NULL COMMENT '父级菜单编码',
  `sort` char(2) COLLATE utf8_bin DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`gameclasscode`),
  KEY `FK_game_class_game_gametype` (`gametype`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='游戏分类';

-- ----------------------------
-- Records of game_class
-- ----------------------------
INSERT INTO `game_class` VALUES ('1', 'PTGame', '奇迹大奖', 'Miracle Award', '18', '1');
INSERT INTO `game_class` VALUES ('2', 'PTGame', '5-10条线', '5-10Line', '18', '2');
INSERT INTO `game_class` VALUES ('3', 'PTGame', '15-20条线', '12-20Line', '18', '3');
INSERT INTO `game_class` VALUES ('4', 'PTGame', '25+条线', '25+line', '18', '4');
INSERT INTO `game_class` VALUES ('5', 'PTGame', '多旋律', 'Polyrhythms', '18', '5');
INSERT INTO `game_class` VALUES ('6', 'PTGame', '累计', 'Grand total', '18', '6');
INSERT INTO `game_class` VALUES ('7', 'PTGame', '经典老虎机', 'Classic Slot Machine', '18', '7');
INSERT INTO `game_class` VALUES ('8', 'PTGame', '视频扑克', 'Video Poker', '18', '8');
INSERT INTO `game_class` VALUES ('9', 'PTGame', '老虎机-街机', 'Slot Machines - Arcade', '19', '10');
INSERT INTO `game_class` VALUES ('10', 'PTGame', '基诺-数字', 'Keno - Digital', '19', '11');
INSERT INTO `game_class` VALUES ('11', 'PTGame', '运动-虚拟', 'Sports - Virtual', '19', '12');
INSERT INTO `game_class` VALUES ('12', 'PTGame', '吃角子老虎机游戏', 'Slots Games', '20', '14');
INSERT INTO `game_class` VALUES ('13', 'PTGame', '其它', 'Other', '20', '15');
INSERT INTO `game_class` VALUES ('14', 'PTGame', '21点', '21Point', '21', '16');
INSERT INTO `game_class` VALUES ('15', 'PTGame', '轮盘', 'Rotary table', '21', '17');
INSERT INTO `game_class` VALUES ('16', 'PTGame', '其他', 'Other', '21', '19');
INSERT INTO `game_class` VALUES ('17', 'PTGame', '刮刮乐', 'Lottery', '21', '18');
INSERT INTO `game_class` VALUES ('18', 'PTGame', '电动吃角子老虎', null, '0', '1');
INSERT INTO `game_class` VALUES ('19', 'PTGame', '街机游戏', null, '0', '2');
INSERT INTO `game_class` VALUES ('20', 'PTGame', '累计游戏', null, '0', '3');
INSERT INTO `game_class` VALUES ('21', 'PTGame', '牌桌-纸牌游戏', null, '0', '4');

-- ----------------------------
-- Table structure for game_class_details
-- ----------------------------
DROP TABLE IF EXISTS `game_class_details`;
CREATE TABLE `game_class_details` (
  `classdetailscode` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类明细编码,主键',
  `gameclasscode` char(4) NOT NULL COMMENT '分类编码',
  `classdetailsflag` varchar(10) NOT NULL COMMENT '游戏flag,对应各个平台的游戏编码',
  `detailschinaname` varchar(25) DEFAULT NULL COMMENT '游戏中文名',
  `detailsenglishname` varchar(50) DEFAULT NULL COMMENT '游戏英文名',
  `picturename` varchar(50) DEFAULT NULL COMMENT '图片名称',
  `path` varchar(255) DEFAULT NULL COMMENT '服务器存储路径',
  `sort` smallint(6) NOT NULL COMMENT '排序',
  `disable` char(1) DEFAULT '1' COMMENT '是否可用(1:可用，2:不可用)',
  PRIMARY KEY (`classdetailscode`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8 COMMENT='游戏分类-详细游戏信息';

-- ----------------------------
-- Records of game_class_details
-- ----------------------------
INSERT INTO `game_class_details` VALUES ('1', '1', 'drd', '超胆侠 20线', 'Daredevil', 'drd.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('2', '1', 'elr', '黑天使 20线', 'Elektra', 'elr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('3', '1', 'hlk50', '绿巨人 50线', 'The Incredible Hulk 50 Lines', 'hlk50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('4', '1', 'spidc', '蜘蛛侠 25线', 'Spider-Man: Attack of The Green Goblin', 'spidc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('5', '1', 'fnf', '神奇四侠 20线', 'Fantastic Four', 'fnf.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('6', '1', 'irm3', '钢铁侠Ⅱ 25线', 'Iron Man 2', 'irm3.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('7', '1', 'cam', '美国队长 20线', 'Captain America – The First Avenger', 'cam.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('8', '1', 'trm', '雷神 30线', 'Thor The Mighty Avenger', 'trm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('9', '1', 'xmn', 'X战警 25线', 'X-Men', 'xmn.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('10', '1', 'ghr', '灵魂骑士 20线', 'Ghost Rider', 'ghr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('11', '1', 'irm50', '钢铁侠Ⅱ 50线', 'Iron Man 2 50 Lines', 'irm50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('12', '1', 'xmn50', 'X战警 50线', 'X-Men 50 Lines', 'xmn50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '12', '1');
INSERT INTO `game_class_details` VALUES ('13', '1', 'fnf50', '神奇四侠 50线', 'Fantastic Four 50 Lines', 'fnf50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '13', '1');
INSERT INTO `game_class_details` VALUES ('14', '1', 'avng', '复仇者联盟 20线', 'The Avengers', 'avng.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '14', '1');
INSERT INTO `game_class_details` VALUES ('15', '1', 'wvm', '金刚狼 25线', 'Wolverine', 'wvm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '15', '1');
INSERT INTO `game_class_details` VALUES ('16', '1', 'bld50', '刀锋战士 50线', 'Blade – 50 Lines', 'bld50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '16', '1');
INSERT INTO `game_class_details` VALUES ('17', '2', 'hk', '高速工路', 'Highway Kings', 'hk.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('18', '2', 'ct', '船长的宝藏', 'Captain\'s Treasure', 'ct.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('19', '2', 'gos', '黄金之旅', 'Golden Tour', 'gos.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('20', '2', 'sib', '纯银子弹', 'Silver Bullet', 'sib.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('21', '2', 'er', '开心假期', 'Vacation Station', 'er.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('22', '2', 'cm', '中国厨房', 'Chinese Kitchen', 'cm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('23', '2', 'wsffr', '玩转华尔街', 'Wall St. Fever', 'wsffr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('24', '2', 'qop', '金字塔女王', 'Queen of the Pyramids', 'qop.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('25', '2', 'fmn', '疯狂水果', 'Fruit Mania', 'fmn.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('26', '2', 'zcjb', '招财进宝', 'Zhao Cai Jin Bao', 'zcjb.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('27', '2', 'gs', '钻石峡谷', 'Diamond Valley', 'gs.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('28', '2', 'cifr', '全景电影', 'Cinerama', 'cifr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '12', '1');
INSERT INTO `game_class_details` VALUES ('29', '2', 'gtscbl', '外星人与牛仔', 'Cowboys & Aliens', 'gtscbl.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '13', '1');
INSERT INTO `game_class_details` VALUES ('30', '2', 'grel', '金色召唤', 'Gold Rally', 'grel.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '14', '1');
INSERT INTO `game_class_details` VALUES ('31', '2', 'gtshwkp', '高速之王PRO', 'Highway Kings Pro', 'gtshwkp.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '15', '1');
INSERT INTO `game_class_details` VALUES ('32', '3', 'lm', '疯狂乐透', 'Lotto Madness', 'lm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('33', '3', 'dt', '沙漠宝藏', 'Desert Treasure', 'dt.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('34', '3', 'hb', '狂欢夜', 'A Night Out', 'hb.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('35', '3', 'hlf', '好莱坞之万圣节', 'Halloween Fortune', 'hlf.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('36', '6', 'hk', '高速之王', 'Highway Kings', 'hk.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('37', '3', 'ssp', '圣诞惊喜', 'Santa Surprise', 'ssp.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('38', '3', 'dlm', '恋爱大师', 'Dr Lovemore', 'dlm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('39', '6', 'ct', '船长的宝藏', 'Captain\'s Treasure', 'ct.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('40', '3', 'gtsdgk', '龙之王国', 'Dragon Kingdom', 'gtsdgk.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('41', '3', 'dt2', '沙漠宝藏Ⅱ', 'Desert Treasure II', 'dt2.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('42', '6', 'lm', '疯狂乐透', 'Lotto Madness', 'lm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('43', '3', 'eas', '复活节惊喜', 'Easter Surprise', 'eas.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('44', '6', 'fbr', '终极足球', 'Football Rules!', 'fbr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('45', '3', 'wis', '狂野精灵', 'Wild Spirit', 'wis.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('46', '3', 'gtspor', '大富豪', 'Plenty O\'Fortune', 'gtspor.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('47', '6', 'dt', '沙漠宝藏', 'Desert Treasure', 'dt.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('48', '3', 'gtsstg', '苏丹金币', 'Sultan’s Gold', 'gtsstg.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '12', '1');
INSERT INTO `game_class_details` VALUES ('49', '6', 'hb', '狂欢夜', 'A Night Out', 'hb.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('50', '3', 'mcb', '返水先生', 'Mr. Cashback', 'mcb.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '13', '1');
INSERT INTO `game_class_details` VALUES ('51', '6', 'wsffr', '玩转华尔街', 'Wall St. Fever', 'wsffr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('52', '3', 'iceh', '冰球大战', 'Ice Hockey', 'iceh.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '14', '1');
INSERT INTO `game_class_details` VALUES ('53', '6', 'dlm', '恋爱大师', 'Dr Lovemore', 'dlm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('54', '3', 'gtswng', '黄金之翼', 'Wings of Gold', 'gtswng.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '15', '1');
INSERT INTO `game_class_details` VALUES ('55', '6', 'qop', '金字塔女王', 'Queen of the Pyramids', 'qop.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('56', '3', 'fff', '农夫与水果', 'Funky Fruits Farm', 'fff.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '16', '1');
INSERT INTO `game_class_details` VALUES ('57', '6', 'fow', '惊异之林', 'Forest of Wonders', 'fow.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('58', '3', 'gtsdrdv', '勇敢的戴夫', 'Daring Dave & The Eye of Ra', 'gtsdrdv.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '17', '1');
INSERT INTO `game_class_details` VALUES ('59', '6', 'fmn', '水果狂', 'Fruit Mania', 'fmn.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('60', '3', 'gtswg', '野性赌徒', 'Wild Gambler', 'gtswg.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '18', '1');
INSERT INTO `game_class_details` VALUES ('61', '3', 'gtsgoc', '圣诞幽灵', 'Ghosts of Christmas', 'gtsgoc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '19', '1');
INSERT INTO `game_class_details` VALUES ('62', '6', 'wan', '通缉令', 'Wanted Dead or Alive', 'wan.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '12', '1');
INSERT INTO `game_class_details` VALUES ('63', '3', 'kkg', '无敌金刚', 'Kong The Eighth Wonder of The World', 'kkg.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '20', '1');
INSERT INTO `game_class_details` VALUES ('64', '6', 'fnfrj', '疯狂水果', 'Funky Fruits', 'fnfrj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '13', '1');
INSERT INTO `game_class_details` VALUES ('65', '3', 'drd', '超胆侠', 'Daredevil', 'drd.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '21', '1');
INSERT INTO `game_class_details` VALUES ('66', '6', 'gs', '钻石谷', 'Diamond Valley', 'gs.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '14', '1');
INSERT INTO `game_class_details` VALUES ('67', '3', 'elr', '黑天使', 'Elektra', 'elr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '22', '1');
INSERT INTO `game_class_details` VALUES ('68', '6', 'ts', '时空过客', 'Thrill Seekers', 'ts.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '15', '1');
INSERT INTO `game_class_details` VALUES ('69', '3', 'bld', '刀锋战士', 'Blade', 'bld.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '23', '1');
INSERT INTO `game_class_details` VALUES ('70', '3', 'fnf', '神奇四侠', 'Fantastic Four', 'fnf.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '24', '1');
INSERT INTO `game_class_details` VALUES ('71', '6', 'cifr', '全景电影', 'Cinerama', 'cifr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '16', '1');
INSERT INTO `game_class_details` VALUES ('72', '3', 'cam', '美国队长', 'Captain America – The First Avenger', 'cam.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '25', '1');
INSERT INTO `game_class_details` VALUES ('73', '6', 'ah2', '异形猎手', 'Alien Hunter', 'ah2.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '17', '1');
INSERT INTO `game_class_details` VALUES ('74', '3', 'ghr', '幽灵骑士', 'Ghost Rider', 'ghr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '26', '1');
INSERT INTO `game_class_details` VALUES ('75', '6', 'sc', '保险箱探宝', 'Safecracker', 'sc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '18', '1');
INSERT INTO `game_class_details` VALUES ('76', '3', 'avng', '复仇者联盟', 'The Avengers', 'avng.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '27', '1');
INSERT INTO `game_class_details` VALUES ('77', '6', 'ms', '魔幻吃角子', 'Magic Slots', 'ms.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '19', '1');
INSERT INTO `game_class_details` VALUES ('78', '3', 'gtsbayw', '海滩游侠', null, 'gtsbayw.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '28', '1');
INSERT INTO `game_class_details` VALUES ('79', '6', 'hlk50', '绿巨人', 'The Incredible Hulk 50 Lines', 'hlk50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '20', '1');
INSERT INTO `game_class_details` VALUES ('80', '3', 'bl', '海滨嘉华年', 'Beach Life', 'bl.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '29', '1');
INSERT INTO `game_class_details` VALUES ('81', '6', 'spidc', '蜘蛛侠', 'Spider-Man: Attack of The Green Goblin', 'spidc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '21', '1');
INSERT INTO `game_class_details` VALUES ('82', '3', 'ashbgt', '英国达人', 'Britain’s Got Talent', 'ashbgt.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '30', '1');
INSERT INTO `game_class_details` VALUES ('83', '6', 'irm3', '钢铁侠3', 'Iron Man 2', 'irm3.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '22', '1');
INSERT INTO `game_class_details` VALUES ('84', '3', 'gtsftf', '足球迷', 'Football Fans', 'gtsftf.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '31', '1');
INSERT INTO `game_class_details` VALUES ('85', '6', 'cam', '美国队长', 'Captain America – The First Avenger', 'cam.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '23', '1');
INSERT INTO `game_class_details` VALUES ('86', '3', 'ashfmf', '月圆传说', 'Full Moon Fortunes', 'ashfmf.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '32', '1');
INSERT INTO `game_class_details` VALUES ('87', '6', 'trm', '雷神', 'Thor The Mighty Avenger', 'trm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '24', '1');
INSERT INTO `game_class_details` VALUES ('88', '3', 'gtsmrln', '玛丽莲梦露', 'Marilyn Monroe', 'gtsmrln.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '33', '1');
INSERT INTO `game_class_details` VALUES ('89', '6', 'ghr', '灵魂骑士', 'Ghost Rider', 'ghr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '25', '1');
INSERT INTO `game_class_details` VALUES ('90', '3', 'snsb', '薄暮沙滩', 'Sunset Beach', 'snsb.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '34', '1');
INSERT INTO `game_class_details` VALUES ('91', '6', 'irm50', '钢铁侠Ⅱ', 'Iron Man 2 50 Lines', 'irm50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '26', '1');
INSERT INTO `game_class_details` VALUES ('92', '3', 'ttcsc', '顶级歌手', 'Top Trumps Celebs Scratch', 'ttcsc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '35', '1');
INSERT INTO `game_class_details` VALUES ('93', '6', 'xmn50', 'X-战警', 'X-Men 50 Lines', 'xmn50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '27', '1');
INSERT INTO `game_class_details` VALUES ('94', '6', 'fnf50', '神奇四侠', 'Fantastic Four 50 Lines', 'fnf50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '28', '1');
INSERT INTO `game_class_details` VALUES ('95', '3', 'ttl', '顶级足球英雄', 'Top Trumps Football Legends', 'ttl.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '36', '1');
INSERT INTO `game_class_details` VALUES ('96', '3', 'tfs', '顶级足球明星', 'Top Trumps World Football Stars', 'tfs.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '37', '1');
INSERT INTO `game_class_details` VALUES ('97', '6', 'avng', '复仇者联盟', 'The Avengers', 'avng.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '29', '1');
INSERT INTO `game_class_details` VALUES ('98', '3', 'gts52', '维京米娜', 'Vikingmania', 'gts52.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '38', '1');
INSERT INTO `game_class_details` VALUES ('99', '6', 'wvm', '金刚狼', 'Wolverine', 'wvm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '30', '1');
INSERT INTO `game_class_details` VALUES ('100', '6', 'bl', '海滨嘉年华', 'Beach Life', 'bl.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '31', '1');
INSERT INTO `game_class_details` VALUES ('101', '4', 'gc', '地妖之穴', 'Goblin\'s Cave', 'gc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('102', '6', 'bld50', '刀锋战士', 'Blade – 50 Lines', 'bld50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '32', '1');
INSERT INTO `game_class_details` VALUES ('103', '4', 'op', '海洋公主', 'Ocean Princess', 'op.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('104', '6', 'glrj', '角斗士', 'Gladiator Jackpot', 'glrj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '33', '1');
INSERT INTO `game_class_details` VALUES ('105', '4', 'tr', '热带滚筒', 'Tropic Reels', 'tr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('106', '6', 'grel', '金色召集', 'Gold Rally', 'grel.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '34', '1');
INSERT INTO `game_class_details` VALUES ('107', '4', 'tp', '三倍利润', 'Triple Profits', 'tp.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('108', '6', 'lvb', '爱之船', 'The Love Boat', 'lvb.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '35', '1');
INSERT INTO `game_class_details` VALUES ('109', '4', 'ub', '神鬼战士', 'Ugga Bugga', 'ub.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('110', '6', 'cnpr', '甜蜜派对', 'Sweet Party™', 'cnpr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '36', '1');
INSERT INTO `game_class_details` VALUES ('111', '5', 'gc', '地妖之穴', 'Goblin\'s Cave', 'gc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('112', '6', 'esmk', '埃斯梅拉达', 'Esmeralda', 'esmk.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '36', '1');
INSERT INTO `game_class_details` VALUES ('113', '5', 'op', '海洋公主', 'Ocean Princess', 'op.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('114', '5', 'tr', '热带滚筒', 'Tropic Reels', 'tr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('115', '5', 'tp', '三倍利润', 'Triple Profits', 'tp.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('116', '5', 'ub', '神鬼战士', 'Ugga Bugga', 'ub.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('117', '7', 'fm', '古怪的猴子', 'Funky Monkey', 'fm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('118', '7', 'c7', '疯狂之七', 'Crazy 7', 'c7.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('119', '7', 'rnr', '摇摆舞', 'Rock ‘n’ Roller', 'rnr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('120', '7', '8bs', '8球吃角子坳虎', '8-Ball Slots', '8bs.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('121', '7', 'sfr', '转轴经典5', 'Reel Classic 5', 'sfr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('122', '7', 'foy', '青春之泉', 'Fountain of Youth', 'foy.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('123', '7', 'pl', '派对风景线', 'Party Line', 'pl.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('124', '7', 'bt', '百慕大三角', 'Bermuda Triangle', 'bt.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('125', '7', 'hh', '鬼屋', 'Haunted House', 'hh.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('126', '7', 'sc', '保险箱探宝', 'Safecracker', 'sc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('127', '7', 'nk', '海神王国', 'Neptune’s Kingdom', 'nk.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('128', '7', 'ms', '神奇老虎机', 'Magic Slots', 'ms.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '12', '1');
INSERT INTO `game_class_details` VALUES ('129', '7', 'ssl', '转轴经典3', 'Reel Classic 3', 'ssl.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '13', '1');
INSERT INTO `game_class_details` VALUES ('130', '7', 'sf', '苏丹的财富', 'Sultan’s Fortune', 'sf.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '14', '1');
INSERT INTO `game_class_details` VALUES ('131', '7', 'ta', '三个好友', 'Tres Amigos', 'ta.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '15', '1');
INSERT INTO `game_class_details` VALUES ('132', '7', 'jb', '丛林摇摆', 'Jungle Boogie', 'jb.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '16', '1');
INSERT INTO `game_class_details` VALUES ('133', '7', 'al', '术士炼金室', 'Alchemist’s Lab', 'al.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '17', '1');
INSERT INTO `game_class_details` VALUES ('134', '8', 'hljb', '两种皇家同花顺', '2 Ways Royal', 'hljb.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('135', '8', 'af', 'A级花牌', 'Aces and Faces', 'af.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('136', '8', 'tab', '对十高手', null, 'tob.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('137', '8', 'po', '对J高手', 'Jacks or Better', 'po.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('138', '8', 'af4', '四线A级花牌', '4-Line Aces and Faces', 'af4.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('139', '8', 'jb4', '四线对J高手', '4-Line Jacks or Better', 'jb4.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('140', '8', 'dw', '百搭牌', 'Deuces Wild', 'dw.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('141', '8', 'jp', '环游世界', 'Joker Poker', 'jp.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('142', '8', 'dw4', '大奖保龄球', '4-Line Deuces Wild', 'dw4.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('143', '8', 'jb_mh', '王牌扑克', 'Jacks or Better Multi-Hand', 'jb_mh.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('144', '8', 'af25', '25线A与王牌', '25-Line Aces & Faces', 'af25.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('145', '8', 'amvp', '全美视频扑克', 'All American', 'amvp.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '12', '1');
INSERT INTO `game_class_details` VALUES ('146', '8', 'jb50', '50线对J高手', '50-line Jacks or Better', 'jb50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '13', '1');
INSERT INTO `game_class_details` VALUES ('147', '8', 'jp50', '50线王牌扑克', '50-line Joker Poker', 'jp50.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '14', '1');
INSERT INTO `game_class_details` VALUES ('148', '8', 'jb10p', '10线对J高手', '10-line Jacks or Better Progressive', 'jb10p.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '15', '1');
INSERT INTO `game_class_details` VALUES ('149', '8', 'mj', '百万杰克', 'Mega Jacks', 'mj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '16', '1');
INSERT INTO `game_class_details` VALUES ('150', '9', 'head', '硬币投掷赌博', 'Heads or Tails', 'ht.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('151', '9', 'rps', '石头,剪刀,布', 'Rock-Paper-Scissors', 'rps.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('152', '9', 'gtsru', '财富魔方', 'Rubik’s Riches', 'gtsru.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('153', '9', 'lwh', '西班牙轮盘', 'Spin a Win', 'lwh.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('154', '10', 'ghl', '猜扑克游戏', 'Genie\'s Hi-Lo', 'ghl.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('155', '10', 'dctw', '转骰子游戏', 'Dice Twister', 'dctw.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('156', '10', 'kn', '基诺', 'Keno', 'kn.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('157', '10', 'rcd', '掷骰子赌博游戏', 'Roller Coaster Dice', 'rcd.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('158', '10', 'pop', '宾果', 'Pop Bingo', 'pop.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('159', '10', 'knx', '基诺实验', 'Keno Xperiment', 'knx.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('160', '10', 'kf', '富足彩', 'Fortune Keno', 'kf.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('161', '10', 'atw', '周游列国', 'Around the World', 'atw.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('162', '10', 'bls', '百万幸运球', 'Mega Ball', 'bls.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('163', '10', 'ghlj', '猜扑克牌彩池', 'Genie\'s Hi-Lo Progressive', 'ghlj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('164', '11', 'pso', '罚点球游戏', 'Penalty Shootout', 'pso.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('165', '11', 'gog', '最佳拳手', 'Knockout', 'gog.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('166', '11', 'bowl', '猜保龄球游戏', 'Bonus Bowling', 'bowl.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('167', '11', 'hr', '赛马游戏', 'Derby Day (former Horse Racing)', 'hr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('168', '11', 'qbd', '飞镖游戏', 'Darts', 'qbd.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('169', '11', 'drts', '飞镖投掷赌博', 'Darts 180', 'drts.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('170', '11', 'fsc', '最终比分', 'Final Score', 'fsc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('171', '11', 'tps', '弗兰基赛马', 'Frankie’s Fantastic 7', 'tps.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('172', '11', 'ghlj', '猜扑克牌彩池', 'Genie\'s Hi-Lo Progressive', 'ghlj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('173', '11', 'gtsru', '财富魔方', 'Rubik’s Riches', 'gtsru.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('174', '11', 'lwh', '轮盘旋转赌博', 'Spin a Win', 'lwh.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('175', '12', 'hk', '高速之王', 'Highway Kings', 'hk.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('176', '12', 'ct', '船长的宝藏', 'Captain\'s Treasure', 'ct.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('177', '12', 'sib', '纯银子弹', 'Silver Bullet', 'sib.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('178', '12', 'lm', '疯狂乐透', 'Lotto Madness', 'lm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('179', '12', 'fbr', '终极足球', 'Football Rules!', 'fbr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('180', '12', 'dt', '沙漠宝藏', 'Desert Treasure', 'dt.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('181', '12', 'hb', '狂欢夜', 'A Night Out', 'hb.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('182', '12', 'wsffr', '玩转华尔街', 'Wall St. Fever', 'wsffr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('183', '12', 'dlm', '恋爱大师', 'Dr Lovemore', 'dlm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('184', '12', 'qop', '金字塔女王', 'Queen of the Pyramids', 'qop.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('185', '12', 'fow', '惊异之林', 'Forest of Wonders', 'fow.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('186', '12', 'fmn', '水果狂', 'Fruit Mania', 'fmn.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '12', '1');
INSERT INTO `game_class_details` VALUES ('187', '12', 'wan', '通缉令', 'Wanted Dead or Alive', 'wan.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '13', '1');
INSERT INTO `game_class_details` VALUES ('188', '12', 'fnfrj', '疯狂水果', 'Funky Fruits', 'fnfrj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '14', '1');
INSERT INTO `game_class_details` VALUES ('189', '12', 'gs', '钻石谷', 'Diamond Valley', 'gs.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '15', '1');
INSERT INTO `game_class_details` VALUES ('190', '12', 'ts', '时空过客', 'Thrill Seekers', 'ts.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '16', '1');
INSERT INTO `game_class_details` VALUES ('191', '12', 'cifr', '全景电影', 'Cinerama', 'cifr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '17', '1');
INSERT INTO `game_class_details` VALUES ('192', '12', 'ah2', '异形猎手', 'Alien Hunter', 'ah2.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '18', '1');
INSERT INTO `game_class_details` VALUES ('193', '12', 'sc', '保险箱探宝', 'Safecracker', 'sc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '19', '1');
INSERT INTO `game_class_details` VALUES ('194', '12', 'ms', '魔幻吃角子', 'Magic Slots', 'ms.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '20', '1');
INSERT INTO `game_class_details` VALUES ('195', '12', 'bl', '海滨嘉年华', 'Beach Life', 'bl.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '21', '1');
INSERT INTO `game_class_details` VALUES ('196', '12', 'glrj', '角斗士', 'Gladiator Jackpot', 'glrj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '22', '1');
INSERT INTO `game_class_details` VALUES ('197', '12', 'grel', '金色召集', 'Gold Rally', 'grel.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '23', '1');
INSERT INTO `game_class_details` VALUES ('198', '12', 'pnp', '粉红豹', 'Pink Panther', 'pnp.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '24', '1');
INSERT INTO `game_class_details` VALUES ('199', '12', 'lvb', '爱之船', 'The Love Boat', 'lvb.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '25', '1');
INSERT INTO `game_class_details` VALUES ('200', '12', 'cnpr', '甜蜜派对', 'Sweet Party™', 'cnpr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '26', '1');
INSERT INTO `game_class_details` VALUES ('201', '13', 'car', '加勒比梭哈', 'Caribbean Stud?Poker', 'car.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('202', '13', 'str', '盛世21点', 'Stravaganza', 'str.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('203', '13', 'wv', '野蛮海盗', 'Wild Viking', 'wv.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('204', '13', 'bls', '百万幸运球', 'Mega Ball', 'bls.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('205', '13', 'drts', '飞镖投掷赌博', 'Darts 180', 'drts.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('206', '13', 'ghlj', '猜扑克牌彩池', 'Genie\'s Hi-Lo Progressive', 'ghlj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('207', '13', 'jb10p', '10线对J高手', '10-line Jacks or Better Progressive', 'jb10p.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('208', '13', 'mj', '超级杰克', 'Mega Jacks', 'mj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('209', '13', 'pba', '累积百家乐', 'Progressive Baccarat', 'pba.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('210', '14', 'bj', '21点', null, 'bj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('211', '14', 'bjsd', '投降21点', null, 'bjsd.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('212', '14', 'bj21d', '决斗21点', null, 'bj21d.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('213', '14', 'psdbj', '黑杰克PRO', 'Blackjack Pro', 'psdbj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('214', '14', 's21', '黑杰克', 'Blackjack Super 21', 's21.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('215', '14', 'bjs', '换牌21点', 'Blackjack Switch', 'bjs.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('216', '14', 'bjhd', '减半翻倍21点', null, 'bjhd.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('217', '14', 'lbj', '幸运黑杰克', 'Lucky Blackjack', 'lbj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('218', '14', 'pfbj_mh5', '完美21点', 'Perfect Blackjack', 'pfbj_mh5.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('219', '14', 'pon_mh5', '英式21点', 'Pontoon', 'pon_mh5.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('220', '14', 'pbj', '累积21点', 'Progressive Blackjack™', 'pbj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('221', '14', 'bjuk_mh5', '英伦21点', 'Blackjack UK', 'bjuk_mh5.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '12', '1');
INSERT INTO `game_class_details` VALUES ('222', '15', 'ro3d', '3D轮盘', '3D Roulette', 'ro3d.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('223', '15', 'gtsro3d', '3D轮盘白金版', '3D Roulette Premium', 'gtsro3d.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('224', '15', 'rodz', '美式轮盘', 'American Roulette', 'rodz.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('225', '15', 'ro', '欧洲轮盘', 'European Roulette', 'ro.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('226', '15', 'frr', '法式轮盘', 'French Roulette', 'frr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('227', '15', 'rom', '漫威轮盘', 'Marvel Roulette', 'rom.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('228', '15', 'romw', '多场轮盘', 'Multi Wheel Roulette', 'romw.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('229', '15', 'rodz', '美式奖金轮盘', 'American Roulette', 'rodz.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('230', '15', 'ro', '偶是奖金轮盘', 'European Roulette', 'ro.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('231', '15', 'frr_g', '法式奖金轮盘', 'Premium French Roulette', 'frr_g.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('232', '15', 'rop_g', '轮盘奖金专家', 'Premium Roulette Pro', 'rop_g.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('233', '15', 'rop', '超级轮盘', 'Roulette Pro', 'rop.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '12', '1');
INSERT INTO `game_class_details` VALUES ('234', '15', 'gts5', '视频轮盘', 'Video Roulette', 'gts5.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '13', '1');
INSERT INTO `game_class_details` VALUES ('235', '16', 'car', '加勒比梭哈', 'Caribbean Stud?Poker', 'car.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('236', '16', 'str', '盛世21点', 'Stravaganza', 'str.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('237', '16', 'wv', '野蛮海盗', 'Wild Viking', 'wv.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('238', '16', 'ba', '百家乐', 'Baccarat', 'ba.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('239', '16', 'cheaa', '赌场Hold', 'Casino Hold \'Em', 'cheaa.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('240', '16', 'cr', '双色骰子游戏', 'Craps', 'cr.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('241', '16', 'pg', '牌九扑克', 'Pai Gow Poker', 'pg.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('242', '16', 'pba', '累积百家乐', 'Progressive Baccarat', 'pba.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('243', '16', 'rd', '红狗', 'Red Dog', 'rd.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('244', '16', 'sb', '骰宝', 'Sic Bo', 'sb.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('245', '16', 'tqp', '龙舌兰扑克', 'Tequila Poker', 'tqp.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('246', '17', 'tclsc', '三个小丑', '3 Clowns Scratch', 'tclsc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '1', '1');
INSERT INTO `game_class_details` VALUES ('247', '17', 'bbn', '甲虫宾果', 'Beetle Bingo Scratch', 'bbn.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '2', '1');
INSERT INTO `game_class_details` VALUES ('248', '17', 'bj', '21点', null, 'bj.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '3', '1');
INSERT INTO `game_class_details` VALUES ('249', '17', 'scs', '经典老虎机', 'Classic Slots Scratch Card', 'scs.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '4', '1');
INSERT INTO `game_class_details` VALUES ('250', '17', 'essc', '复活节惊喜', 'Easter Surprise Scratch', 'essc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '5', '1');
INSERT INTO `game_class_details` VALUES ('251', '17', 'fbm', '狂热足球', 'Football Mania Scratch', 'fbm.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '6', '1');
INSERT INTO `game_class_details` VALUES ('252', '17', 'irm3sc', '钢铁侠Ⅱ', 'Iron Man 2 Scratch', 'irm3sc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '7', '1');
INSERT INTO `game_class_details` VALUES ('253', '17', 'irmn3sc', '钢铁侠', 'Iron Man 3 Scratch', 'irmn3sc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '8', '1');
INSERT INTO `game_class_details` VALUES ('254', '17', 'kkgsc', '金刚之王', 'Kong Scratch', 'kkgsc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '9', '1');
INSERT INTO `game_class_details` VALUES ('255', '17', 'lom', '丘比特配对', 'Love Match Scratch', 'lom.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '10', '1');
INSERT INTO `game_class_details` VALUES ('256', '17', 'pks', '法老王国', 'Pharaoh’s Kingdom Scratch', 'pks.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '11', '1');
INSERT INTO `game_class_details` VALUES ('257', '17', 'sro', '轮盘赌', 'Roulette Scratch Card', 'sro.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '12', '1');
INSERT INTO `game_class_details` VALUES ('258', '17', 'ssa', '圣诞刮刮乐', 'Santa Scratch', 'ssa.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '13', '1');
INSERT INTO `game_class_details` VALUES ('259', '17', 'ttcsc', '顶级歌手', 'Top Trumps Celebs Scratch', 'ttcsc.jpg', 'http://192.168.1.207:9090/ecrm-pic/ptgames/', '14', '1');

-- ----------------------------
-- Table structure for game_platform_prefix
-- ----------------------------
DROP TABLE IF EXISTS `game_platform_prefix`;
CREATE TABLE `game_platform_prefix` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `game_platform` varchar(10) DEFAULT NULL COMMENT '游戏平台',
  `prefixcode` varchar(10) DEFAULT NULL COMMENT '前缀',
  PRIMARY KEY (`lsh`),
  KEY `index_enterprisecode_game_platform` (`enterprisecode`,`game_platform`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of game_platform_prefix
-- ----------------------------
INSERT INTO `game_platform_prefix` VALUES ('1', 'EN0000', 'NHQGame', '');
INSERT INTO `game_platform_prefix` VALUES ('2', 'EN0000', 'BBINGame', '');
INSERT INTO `game_platform_prefix` VALUES ('3', 'EN0000', 'TAGGame', '');
INSERT INTO `game_platform_prefix` VALUES ('4', 'EN0000', 'OGGame', '');
INSERT INTO `game_platform_prefix` VALUES ('5', 'EN0000', 'AGGame', '');
INSERT INTO `game_platform_prefix` VALUES ('6', 'EN0000', 'IBCGame', '');
INSERT INTO `game_platform_prefix` VALUES ('7', 'EN0000', 'XCPGame', '');

-- ----------------------------
-- Table structure for hqgametype
-- ----------------------------
DROP TABLE IF EXISTS `hqgametype`;
CREATE TABLE `hqgametype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hq_gm` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hqgametype
-- ----------------------------
INSERT INTO `hqgametype` VALUES ('1', '1', '百家乐');
INSERT INTO `hqgametype` VALUES ('2', '2', '龙虎');
INSERT INTO `hqgametype` VALUES ('3', '3', '轮盘');
INSERT INTO `hqgametype` VALUES ('4', '4', '骰宝');
INSERT INTO `hqgametype` VALUES ('5', '5', '番摊');

-- ----------------------------
-- Table structure for integral_exchange
-- ----------------------------
DROP TABLE IF EXISTS `integral_exchange`;
CREATE TABLE `integral_exchange` (
  `lsh` varchar(36) NOT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` char(8) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(20) DEFAULT NULL,
  `integralcode` varchar(36) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `patchno` varchar(20) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `exchangedesc` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `checkaccount` varchar(20) DEFAULT NULL,
  `checktime` datetime DEFAULT NULL,
  `checkdesc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`lsh`),
  KEY `index1` (`enterprisecode`,`brandcode`) USING BTREE,
  KEY `index2` (`employeecode`) USING BTREE,
  KEY `index3` (`loginaccount`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of integral_exchange
-- ----------------------------

-- ----------------------------
-- Table structure for integral_record
-- ----------------------------
DROP TABLE IF EXISTS `integral_record`;
CREATE TABLE `integral_record` (
  `lsh` varchar(36) NOT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` char(8) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(20) DEFAULT NULL,
  `gametype` varchar(10) DEFAULT NULL,
  `gamebigtype` varchar(4) DEFAULT NULL,
  `platformid` varchar(50) DEFAULT NULL,
  `betmoney` decimal(10,2) DEFAULT '0.00',
  `rebatemoney` decimal(10,2) DEFAULT '0.00',
  `m2i_rate` decimal(10,2) DEFAULT '1.00',
  `amount` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `createtime` datetime DEFAULT NULL,
  `exchangetime` datetime DEFAULT NULL,
  `exchangetype` int(11) DEFAULT NULL,
  `exchangedesc` varchar(100) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`lsh`),
  KEY `index1` (`enterprisecode`,`brandcode`) USING BTREE,
  KEY `index2` (`employeecode`) USING BTREE,
  KEY `index3` (`loginaccount`) USING BTREE,
  KEY `index4` (`gametype`,`gamebigtype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of integral_record
-- ----------------------------

-- ----------------------------
-- Table structure for integral_setting
-- ----------------------------
DROP TABLE IF EXISTS `integral_setting`;
CREATE TABLE `integral_setting` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `enterprisecode` char(6) DEFAULT NULL,
  `brandcode` char(8) DEFAULT NULL,
  `gametype` varchar(10) DEFAULT NULL,
  `gamebigtype` varchar(4) DEFAULT NULL,
  `m2i_rate` decimal(10,2) DEFAULT '1.00',
  `i2m_rate` decimal(10,2) DEFAULT '1.00',
  `timeoutday` int(11) DEFAULT '7',
  PRIMARY KEY (`lsh`),
  UNIQUE KEY `index1` (`enterprisecode`,`brandcode`,`gametype`,`gamebigtype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of integral_setting
-- ----------------------------

-- ----------------------------
-- Table structure for login_white_list
-- ----------------------------
DROP TABLE IF EXISTS `login_white_list`;
CREATE TABLE `login_white_list` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `enterprisecode` char(8) DEFAULT NULL COMMENT '企业编码',
  `ip` char(18) DEFAULT NULL COMMENT '白名单IP',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`lsh`),
  KEY `index_enterprisecode` (`enterprisecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=465 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of login_white_list
-- ----------------------------
INSERT INTO `login_white_list` VALUES ('1', 'EN0000', '180.232.108.150', '好盈');

-- ----------------------------
-- Table structure for log_login
-- ----------------------------
DROP TABLE IF EXISTS `log_login`;
CREATE TABLE `log_login` (
  `code` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisecode` char(6) NOT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(10) NOT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '用户上级编码',
  `loginaccount` varchar(12) NOT NULL COMMENT '登陆账号',
  `logintime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '登陆时间',
  `loginip` char(18) NOT NULL COMMENT '登陆IP',
  `machinecode` varchar(32) DEFAULT NULL COMMENT '机器码',
  `opratesystem` varchar(25) DEFAULT NULL COMMENT '操作系统',
  `browserversion` varchar(50) DEFAULT NULL COMMENT '浏览器版本',
  `refererurl` varchar(255) DEFAULT NULL COMMENT '来源网址',
  PRIMARY KEY (`code`),
  KEY `log_login_ix1` (`employeecode`) USING BTREE,
  KEY `log_login_ix2` (`loginaccount`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log_login
-- ----------------------------

-- ----------------------------
-- Table structure for log_operation
-- ----------------------------
DROP TABLE IF EXISTS `log_operation`;
CREATE TABLE `log_operation` (
  `logcode` int(10) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `tablename` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '数据表名称',
  `servicename` varchar(25) COLLATE utf8_bin NOT NULL COMMENT '业务名称',
  `visiteurl` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '访问URL',
  `oprationtype` varchar(8) COLLATE utf8_bin NOT NULL COMMENT '操作类型',
  `oprationtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '上级用户编码',
  `oprationperson` varchar(12) COLLATE utf8_bin NOT NULL COMMENT '操作人',
  PRIMARY KEY (`logcode`),
  KEY `IDX_log_operation_employeecode` (`employeecode`) USING BTREE,
  KEY `UK_log_operation_oprationperson` (`oprationperson`) USING BTREE,
  KEY `UK_log_operation_servicename` (`servicename`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户操作日志';

-- ----------------------------
-- Records of log_operation
-- ----------------------------

-- ----------------------------
-- Table structure for log_operation_detail
-- ----------------------------
DROP TABLE IF EXISTS `log_operation_detail`;
CREATE TABLE `log_operation_detail` (
  `logdetailcode` int(10) NOT NULL AUTO_INCREMENT COMMENT '详细日志ID',
  `logcode` int(11) NOT NULL COMMENT '日志ID',
  `fieldname` varchar(25) COLLATE utf8_bin DEFAULT NULL COMMENT '操作字段',
  `fieldvalue` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '操作值',
  `conditions` text COLLATE utf8_bin COMMENT '操作条件',
  PRIMARY KEY (`logdetailcode`)
) ENGINE=InnoDB AUTO_INCREMENT=690 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='操作日志详细';

-- ----------------------------
-- Records of log_operation_detail
-- ----------------------------

-- ----------------------------
-- Table structure for payment_type
-- ----------------------------
DROP TABLE IF EXISTS `payment_type`;
CREATE TABLE `payment_type` (
  `paymenttypecode` char(4) COLLATE utf8_bin NOT NULL,
  `paymenttype` varchar(32) COLLATE utf8_bin NOT NULL,
  `datastatus` char(2) COLLATE utf8_bin DEFAULT '1',
  PRIMARY KEY (`paymenttypecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='银行卡 银行卡-柜台办理 银行卡-ATM办理 易宝 支付宝 汇潮 等';

-- ----------------------------
-- Records of payment_type
-- ----------------------------
INSERT INTO `payment_type` VALUES ('PM01', '第三方即时支付', '1');
INSERT INTO `payment_type` VALUES ('PM02', '银行卡转账', '1');

-- ----------------------------
-- Table structure for permission_menu
-- ----------------------------
DROP TABLE IF EXISTS `permission_menu`;
CREATE TABLE `permission_menu` (
  `menucode` char(6) COLLATE utf8_bin NOT NULL,
  `parentmenucode` char(6) COLLATE utf8_bin DEFAULT NULL,
  `menuname` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `englishname` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `menuurl` varchar(256) COLLATE utf8_bin NOT NULL,
  `menusort` tinyint(4) DEFAULT NULL,
  `menulevel` tinyint(4) DEFAULT NULL,
  `menustatus` tinyint(4) NOT NULL,
  `datastatus` char(2) COLLATE utf8_bin DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`menucode`),
  KEY `index_parentmenucode` (`parentmenucode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='增，删，改，查，开放下一级，隐私信息显示\r\n页面只作逻辑删除，数据库维护做物理删除';

-- ----------------------------
-- Records of permission_menu
-- ----------------------------
INSERT INTO `permission_menu` VALUES ('MN0000', 'INIT', '菜单管理', 'Menu Info', '#', '-1', '0', '-1', '1');
INSERT INTO `permission_menu` VALUES ('MN0001', 'MN0000', '业务管理', 'Business', '#', '3', '1', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0002', 'MN0000', '运营管理', 'Operational', '#', '2', '1', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0003', 'MN0002', '风险管理', 'Risk Info', '#', '7', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0005', 'MN0002', '基础信息', 'Base Info', '#', '1', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0006', 'MN0001', '客户管理', 'Client Info', '#', '1', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0008', 'MN001A', '权限管理', 'Authorization', '#', '5', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000C', 'MN0005', '公司银行卡', 'Co. Bank Cards', '/EInformation/list', '10', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000E', 'MN0005', '品牌信息', 'Brand List', '/EOBrand/list', '5', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000F', 'MN0006', '会员信息', 'Member List', '/EEmployee/userJsp/index', '7', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000G', 'MN000N', '用户银行', 'Member Banks', '/EmployeeInformation/userInfo/index', '7', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000H', 'MN0008', '菜单管理', 'Menu Info', '/PermissionMenu/list', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000I', 'MN004Q', '创建企业', 'Company Set Up', '/Enterprise/Add', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000L', 'MN000C', '添加收款卡', 'Add Pay Card', '/EInformation/add', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000N', 'MN0002', '支付管理', 'Payments', '#', '2', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000O', 'MN000N', '存款信息', 'Deposit Info', '/takeDepositRecord/takeDeposit/index?orderType=1', '5', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000P', 'MN006J', '系统公告', 'SYS Notice', '#', '1', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000S', 'MN0002', '登录日志', null, '#', '4', '2', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN000T', 'MN004Q', '搜索', 'Search', '/Enterprise/data', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN000Z', 'MN000F', '用户批量删除', 'Batch Delete User', '/EEmployee/deleteSelectEmployee', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0011', 'MN000F', '重置登录密码', 'Reset Password', '/common/resetLoginPassword', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0012', 'MN000G', '添加银行卡', null, '/EmployeeInformation/userInfo/userInfoAdd', '1', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0014', 'MN000G', '修改银行卡信息', null, '/EmployeeInformation/updateEnterpriseEmployeeInformation', '3', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0019', 'MN000N', '取款信息', 'Withdrawals Info', '/takeDepositRecord/takeDeposit/index?orderType=2', '6', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001A', 'MN0000', '配置管理', 'SYS Setting', '#', '6', '1', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001E', 'MN001A', '流程管理', 'Work Folws', '#', '1', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001J', 'MN001E', '存款流程设置', 'Deposit Process Settings', '/workingFlow/depositIndex', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001K', 'MN001J', '新增存款流程', 'New Deposit Process', '/workingFlow/depositWorkingFlowConfigurationAdd', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001L', 'MN001J', '修改存款流程', 'Modify Deposit Process', '/workingFlow/depositWorkingFlowConfigurationUpdate', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001M', 'MN001J', '删除存款流程', 'Delete Deposit Process', '/workingFlow/depositWorkingFlowConfigurationDelete', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001N', 'MN001E', '取款流程设置', 'Withdrawal Process Setting', '/workingFlow/takeIndex', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001P', 'MN001N', '新增取款流程', 'New Withdrawal Process', '/workingFlow/takeWorkingFlowConfigurationAdd', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001Q', 'MN001N', '修改取款流程', 'Modify Withdrawal Process', '/workingFlow/takeWorkingFlowConfigurationUpdate', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001R', 'MN001N', '删除取款流程', 'Delete Withdrawal Process', '/workingFlow/takeWorkingFlowConfigurationDelete', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001S', 'MN000C', '编辑收款卡', 'Edit Payment Card', '/EInformation/edit', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001T', 'MN000C', '删除', 'Delete', '/EInformation/delete', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001U', 'MN000C', '搜索', 'Search', '/EInformation/data', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001Y', 'MN000E', '搜索', 'Search', '/EOBrand/data', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN001Z', 'MN000E', '创建品牌', 'Create Brand', '/EOBrand/add', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0022', 'MN000N', '存款审核', 'Deposit Review', '/takeDepositRecord/depositApprove', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0023', 'MN000N', '取款审核', 'Withdrawals Review', '/takeDepositRecord/takeApprove', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0024', 'MN004U', '手工录单', null, '/takeDepositRecord/takeDepositRecordAdd', '5', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0026', 'MN004U', '员工管理', null, '/employeeOperating/userJsp/employeeIndex', '12', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0027', 'MN004U', '股东管理', null, '/enterpriseType/userJsp/enterpriseIndex', '8', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0029', 'MN0006', '代理信息', 'Agent List', '/employeeAgent/userJsp/agentEmployeeIndex', '8', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN002B', 'MN0001', '统计管理', 'Reports', '#', '8', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN002E', 'MN004U', '存取款统计', null, '/takeDepositRecord/countDepositTakeRecordDatail', '14', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN002G', 'MN004U', '存取款明细', null, '/takeDepositRecord/depositTakeRecordDatail', '15', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN002Q', 'MN0001', '营销管理', 'Marketing Info', '#', '2', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN002R', 'MN002S', '会员站点注册', 'Member Site Registration', '/registerLink/userSiteAdd', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN002S', 'MN002Q', '会员站点管理', 'Member Website Managment', '/registerLink/usersiteindex', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN002T', 'MN000E', '开放游戏', 'Open The Game', '/brandGame/saveBrandGame', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN002U', 'MN0027', '批量删除', null, 'enterpriseType/deleteSelectEmployee', '1', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN002V', 'MN0027', '搜索企业', null, '/enterpriseType/findEmployee', '2', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN002W', 'MN0027', '登录密码重置', 'Login Password Reset', '/common/resetLoginPassword', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN002X', 'MN0027', '资金密码重置', 'Funds Password Reset', '/common/resetCapitalPassword', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN002Y', 'MN0027', '权限管理', null, '/EmployeeMPG/permission', '5', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN002Z', 'MN0026', '搜索员工', null, '/employeeOperating/findEmployee', '1', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0030', 'MN0026', '添加员工', null, '/employeeOperating/userJsp/employeeAdd', '2', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0031', 'MN0026', '重置登录密码', 'Login Password Reset', '/common/resetLoginPassword', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0032', 'MN0026', '批量删除', null, '/employeeOperating/deleteSelectEmployee', '4', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0033', 'MN0026', '重置资金密码', 'Funds Password Reset', '/common/resetCapitalPassword', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0034', 'MN0026', '权限管理', null, '/EmployeeMPG/permission', '6', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0035', 'MN002S', '搜索', 'Search', '/registerLink/queryRegisterLink', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0036', 'MN002S', '启用', 'Enable', '##', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0037', 'MN002S', '禁用', 'Disable', '##', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0038', 'MN000F', '用户搜索', 'Search User', '/EEmployee/findEmployee', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0039', 'MN000F', '重置资金密码', 'Funds Password Reset', '/common/resetCapitalPassword', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003A', 'MN000F', '结算配置', 'Settlement Config', '/GCBonus/memberSetting', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003B', 'MN0029', '搜索代理', 'Search Affiliate', '/employeeAgent/findEmployee', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003C', 'MN0029', '批量删除', 'Batch Delete', '/employeeAgent/deleteSelectEmployee', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003D', 'MN0029', '重置登录密码', 'Login Password Reset', '/common/resetLoginPassword', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003E', 'MN0029', '重置资金密码', 'Funds Password Reset', '/common/resetCapitalPassword', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003F', 'MN0029', '权限管理', 'Authority Management', '/EmployeeMPG/agentpermission', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003G', 'MN0029', '结算配置', 'Settlement Config', '/GCBonus/agentSetting', '6', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003H', 'MN002S', '删除', 'Delete', '##', '7', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003I', 'MN000G', '解锁银行卡', 'Unlock The Bank Card', '/EmployeeInformation/unlockingBank', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003J', 'MN0022', '搜索', 'Search', '/takeDepositRecord/findDepositApproveRecord', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003K', 'MN0022', '审批', 'Approval', '/takeDepositRecord/approve', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003L', 'MN0023', '搜索', 'Search', '/takeDepositRecord/findTakeApproveRecord', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003M', 'MN0023', '审批', 'Approval', '/takeDepositRecord/approve', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003N', 'MN0024', '修改订单', null, '/takeDepositRecord/updateTakeDepositRecord', '1', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN003O', 'MN0024', '订单作废', null, '##', '2', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN003P', 'MN000O', '查看审批详情', 'View Approval Details', '/common/queryDepositTakeApproveRecord', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003Q', 'MN000O', '搜索订单', 'Search Order', '/takeDepositRecord/findTakeDepositRecord', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003R', 'MN0019', '查看审批详情', 'View approval details', '/common/queryDepositTakeApproveRecord', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003S', 'MN0019', '搜索订单', 'Search Order', '/takeDepositRecord/findTakeDepositRecord', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003T', 'MN001J', '审批人设置', 'Approval Setting', '/workingFlow/addDepositWorkingFlowApproveEmployee', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003U', 'MN001J', '搜索', 'Search', '/workingFlow/queryDepositWorkingFlowConfiguration', '6', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003V', 'MN001N', '审批人设置', 'Approval setting', '/workingFlow/addTakeWorkingFlowApproveEmployee', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003W', 'MN002S', '批量删除', 'Batch Delete', '##', '7', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003X', 'MN000G', '搜索', 'Search', '/EmployeeInformation/findBankInfo', '8', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003Y', 'MN001N', '搜索', 'Search', '/workingFlow/queryTakeWorkingFlowConfiguration', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN003Z', 'MN000E', '域名管理', null, '/registerLink/mianDomainSetting', '7', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0040', 'MN000N', '驳回订单', 'Rejected Orders', '/takeDepositRecord/rejectedPage', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0041', 'MN0040', '查询', 'Search', '/takeDepositRecord/findRejectData', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0042', 'MN0040', '修改存款订单', 'Modify Deposit Order', '/takeDepositRecord/editDepositOrders', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0043', 'MN004U', '注册链接', null, '/registerLink/registerLinkAdd', '4', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0044', 'MN002Q', '代理注册管理', 'Affiliate Registration Management', '/registerLink/registerLinkIndex', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0045', 'MN0001', '游戏管理', 'Game Info', '#', '7', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0046', 'MN0045', 'HY真人', 'HY Live', '/NHQGame/index', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0047', 'MN0045', 'BBIN波音', 'BBIN', '/BBINGame/list', '22', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0048', 'MN0045', 'AG亚游', 'AG Live', '/TAGGame/index', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0049', 'MN0045', 'OG东方真人', 'OG Live', '/OGGame/list', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004A', 'MN0045', 'PT游戏', 'PT Slot', '/PTGame/list', '5', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004B', 'MN0045', 'SB沙巴体育', 'SB Sports', '/IBCGame/list', '9', '3', '-1', '-1');
INSERT INTO `permission_menu` VALUES ('MN004C', 'MN0045', '火星彩票', 'Mars Lottery', '/XCPGame/list', '6', '3', '-1', '-1');
INSERT INTO `permission_menu` VALUES ('MN004D', 'MN0003', '客户登陆分析', 'Customer Login Analysis', '/LoginLog/index', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004E', 'MN000P', '系统公告', 'Notices', '/BrandNotic/noticshow', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004F', 'MN006J', '站内消息', 'Messages', '##', '2', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004G', 'MN004F', '系统消息', 'System News', '/Message/SystemMessage', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004H', 'MN0002', '通信管理', 'Communication', '##', '9', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004I', 'MN0002', '日志管理', null, '##', '10', '2', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN004J', 'MN004H', '运营公告', 'Operational Announcement', '/BrandNotic/index', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004K', 'MN007Q', '运行监控', 'Operation Monitor', '##', '1', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004L', 'MN004H', '消息管理', 'Message Management', '/Message/ManagerMessage', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004M', 'MN004I', '操作日志', null, '##', '2', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN004O', 'MN004F', '站内消息', 'Agent Info', '/Message/AgentMessage', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004Q', 'MN0005', '公司信息', 'Co. Profile', '/Enterprise/List', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004R', 'MN006K', '用户类型', 'User Type', '/employeeType/employeeTypeIndex', '9', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004U', 'MN005Q', '测试功能', null, '##', '3', '2', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN004V', 'MN004U', '测试', null, '##', '7', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN004W', 'MN0005', '用户信息', 'User Info', '/EEmployee/userJsp/employeeData', '7', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004X', 'MN0002', '财务管理', 'Finane Info', '##', '3', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004Y', 'MN0006', '账户总览', 'Account Info', '/EmployeeInformation/accountDataQuery', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN004Z', 'MN0006', '密码修改', 'Change PWD', '/EEmployee/userJsp/modifyPassword', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0050', 'MN004U', '测试2', null, '##', '6', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0051', 'MN0005', '公司快捷支付', 'Co. Fast Pay', '/thirdpartyPayment/index', '11', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0052', 'MN004X', '红利信息', 'Bonus Info', '/activitypay/index', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0053', 'MN004X', '账户账变', 'Account Balance Statement ', '/employeeMoneyChange/index', '5', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0054', 'MN004X', '冲正冲负', 'Credit / Deduct', '/moneyInAndOut/plusLessMinute', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0055', 'MN004X', '利润报表', 'Profit Settlement', '/report/userProfitReport', '7', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0056', 'MN002Q', '推广渠道信息', 'Marketing Source Info', '/common/Developing', '1', '3', '-1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0057', 'MN009R', '活动模板', 'Activity Template', '/ActivityTemplate/Show', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0058', 'MN004X', '活动充值', 'Activity Recharge', '/moneyInAndOut/activityRecharge', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0059', 'MN002Q', '推广活动运营', 'Marketing Activity Operation', '/Activity/Show', '8', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005A', 'MN0045', '帝王棋牌', 'DW Poker', '/QpGame/index', '10', '3', '-1', '-1');
INSERT INTO `permission_menu` VALUES ('MN005B', 'MN004X', '转分信息', 'Points Transfer Info', '/moneyInAndOut/index', '14', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005C', 'MN0045', '游戏报表', 'Game Report', '/report/userGameReport', '99', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005D', 'MN002B', '用户输赢统计', 'User Win-Loss Statistics', '/report/userLoseWinCount', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005E', 'MN002B', '用户存取统计', 'User Deposit Withdraw Statistics', '/report/userDepositTakeReport', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005F', 'MN002B', '会员来源统计', null, '/common/Developing', '4', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN005G', 'MN002B', '订单处理统计', 'Order Processing Statistics', '/report/businessHandleReport', '5', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005H', 'MN002B', '用户活跃统计', 'User Sctive Statistics', '/report/employeeActivityReport', '6', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005I', 'MN002B', '用户注册统计', 'User Registration Statistics', '/report/userRegistered', '7', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005J', 'MN002B', '会员存款排名', 'Membership Deposit Rankings', '/report/employeeDepositRankingReport', '8', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005K', 'MN002B', '会员取款排名', 'Membership Withdrawals Rankings', '/report/employeeWithdrawalsRankingReport', '9', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005L', 'MN002B', '用户输钱排名', 'Users Money Lose Ranking', '/report/userLoseWinRankingReport?mark=0', '10', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005M', 'MN002B', '代理贡献排名', 'Affiliate Contribution Ranking', '/report/agentContributionRankingReport', '14', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005N', 'MN0003', '客户输赢分析', 'Customer Win-Loss Analysis', '/report/userLoseWinAnalysis', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005O', 'MN0003', '运营监控', null, '##', '4', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN005P', 'MN0003', '用户操作日志', 'User Operation Log', '/operatingLog/index', '5', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005Q', 'MN0000', '未整合功能', null, '##', '8', '1', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN005R', 'MN0045', '东方-AG', null, '/bettingHqAg/index', '8', '3', '-1', '-1');
INSERT INTO `permission_menu` VALUES ('MN005S', 'MN0045', 'HY真人', null, '/bettingHqNhq/index', '7', '3', '-1', '-1');
INSERT INTO `permission_menu` VALUES ('MN005T', 'MN004U', 'HQ-环球', null, '/HQGame/list', '2', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN005U', 'MN004U', '东方-AG', null, '/AGGame/list', '1', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN005V', 'MN004Q', '编辑企业', 'Edit Company', '/Enterprise/Edit', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005W', 'MN004Q', 'API证书', 'API Certificate', '/InputAPI/SettingAPI', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005X', 'MN004W', '创建用户', 'Create User', '/employeeOperating/userJsp/employeeAdd', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005Y', 'MN004W', '删除用户', 'Delete User', '/EEmployee/deleteSelectEmployee', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN005Z', 'MN004W', '查询用户', 'Search User', '/EEmployee/findEmployeeData', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0060', 'MN004W', '保存用户', 'Save User', '/employeeOperating/saveEnterpriseEmployee', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0061', 'MN004R', '查询', 'Search', '/employeeType/data', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0062', 'MN004R', '添加', 'Add', '/employeeType/add', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0063', 'MN004R', '修改', 'Edit', '/employeeType/update', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0064', 'MN004R', '删除', 'Delete', '/employeeType/delete', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0065', 'MN004R', '保存', 'Save', '/employeeType/save', '6', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0066', 'MN004R', '修改保存', 'Update', '/employeeType/saveUpdate', '7', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0067', 'MN000F', '创建会员', 'Create Member', '/EEmployee/userJsp/userAdd', '6', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0068', 'MN0029', '创建代理', 'Create Affiliate', '/employeeAgent/userJsp/agentEmployeeAdd', '7', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0069', 'MN0022', '存款补单', '存款补单', '/takeDepositRecord/DepositAdd', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006A', 'MN0023', '取款补单', '取款补单', '/takeDepositRecord/TakeAdd', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006B', 'MN004R', '批量删除', '批量删除', '/employeeType/deleteSelect', '8', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006C', 'MN000E', '编辑品牌', '编辑品牌', '/EOBrand/Edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006D', 'MN000H', '创建子菜单', '创建子菜单', '/PermissionMenu/add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006E', 'MN000H', '编辑菜单', '编辑菜单', '/PermissionMenu/edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006F', 'MN000G', '批量删除', null, '/EmployeeInformation/deleteSelectBankInfo', '5', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN006G', 'MN000G', '删除', null, '/EmployeeInformation/deleteBankInfo', '6', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN006H', 'MN000C', '批量删除', '批量删除', '/EInformation/BatchDelete', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006I', 'MN0040', '修改取款订单', '修改取款订单', '/takeDepositRecord/editTakeOrders', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006J', 'MN0000', '消息/公告', 'News&Notice', '##', '4', '1', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006K', 'MN001A', '数据类型', 'Data Type', '##', '10', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006L', 'MN006K', '帐变类型', null, '##', '7', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN006M', 'MN006K', '游戏类型', 'Game Type', '/gametype/index', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006N', 'MN006K', '支付类型', 'Payment Type', '/paymenttype/index', '10', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006O', 'MN006K', '查询', null, '/gametype/data', '2', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN006P', 'MN006K', '新增', null, '/gametype/add', '3', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN006Q', 'MN006K', '删除', null, '/gametype/deleteGameType', '6', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN006R', 'MN006M', '添加', '添加', '/gametype/add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006S', 'MN006M', '查询', '查询', '/gametype/data', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006T', 'MN006M', '删除', '删除', '/gametype/deleteGameType', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006U', 'MN006M', '批量删除', '批量删除', '/gametype/deleteSelectGameType', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006V', 'MN006M', '修改', '修改', '/gametype/update', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006W', 'MN006N', '查询', '查询', '/paymenttype/data', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006X', 'MN006N', '添加', '添加', '/paymenttype/add', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006Y', 'MN006N', '删除', '删除', '/paymenttype/deletePaymentType', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN006Z', 'MN006N', '批量删除', '批量删除', '/paymenttype/deleteSelectPaymentType', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0070', 'MN006N', '修改', '修改', '/paymenttype/update', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0071', 'MN006K', '帐变类型', 'Funds Changes Type', '/moneyChangeType/index', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0072', 'MN0071', '查询', '查询', '/moneyChangeType/data', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0073', 'MN0071', '创建帐变类型', '创建帐变类型', '/moneyChangeType/add', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0074', 'MN0071', '删除', '删除', '/moneyChangeType/deleteEmployeeMoneyChangeType', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0075', 'MN0071', '批量删除', '批量删除', '/moneyChangeType/deleteSelectEmployeeMoneyChangeType', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0076', 'MN0071', '编辑帐变类型', '编辑帐变类型', '/moneyChangeType/update', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0077', 'MN004O', '发送消息', '发送消息', '/Message/AgentMSend', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0078', 'MN004L', '发送系统消息', '发送系统消息', '/Message/ManagerSend', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0079', 'MN004J', '创建公告', '创建公告', '/BrandNotic/add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007A', 'MN004J', '编辑公告', '编辑公告', '/BrandNotic/edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007B', 'MN0044', '代理注册链接', '代理注册链接', '/registerLink/registerLinkAdd', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007C', 'MN002S', '代理域名注册', null, '/registerLink/expandDomainAdd', '2', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN007D', 'MN0057', '创建活动模板', '创建活动模板', '/ActivityTemplate/Add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007E', 'MN0051', '保存', '保存', '/thirdpartyPayment/save', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007F', 'MN0051', '删除', '删除', '/thirdpartyPayment/delete', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007G', 'MN0051', '批量删除', '批量删除', '/thirdpartyPayment/deleteSelect', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007H', 'MN0051', '启用禁用', '启用禁用', '/thirdpartyPayment/enableDisable', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007I', 'MN0051', '查询', '查询', '/thirdpartyPayment/data', '7', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007J', 'MN0057', '编辑活动模板', '编辑活动模板', '/ActivityTemplate/Edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007K', 'MN0057', '参数设置', '参数设置', '/ATemplateSetting/Show', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007L', 'MN007K', '添加参数', '添加参数', '/ATemplateSetting/Add', '1', '5', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007M', 'MN007K', '编辑参数', '编辑参数', '/ATemplateSetting/Edit', '2', '5', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007N', 'MN007K', '删除参数', '删除参数', '/ATemplateSetting/Delete', '3', '5', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007O', 'MN0059', '添加活动', '添加活动', '/Activity/Add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007P', 'MN0059', '编辑活动', '编辑活动', '/Activity/Edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007Q', 'MN0000', '系统监控', 'SYS Monitor', '##', '7', '1', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007R', 'MN004K', 'GLHT日志开关', 'GLHT Log Switch', '/RunLogger/Index', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007S', 'MN0051', '新增', '新增', '/thirdpartyPayment/add', '6', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007T', 'MN004Q', '删除企业', '删除企业', '/Enterprise/Delete', '7', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007U', 'MN000G', '锁定银行卡', '锁定银行卡', '/EmployeeInformation/lockingBank', '7', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007V', 'MN004W', '查看直系会员', '查看直系会员', '/employeeAgent/member', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007W', 'MN004D', '查看登录IP分析数据', '查看登录IP分析数据', '/LoginLog/list', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007X', 'MN004D', '查看登录日志详情', '查看登录日志详情', '/LoginLog/data', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007Y', 'MN001A', 'VIP管理', 'VIP Info', '##', '4', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN007Z', 'MN007Y', 'VIP信息', 'VIP Info', '/employeeLevel/index', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0080', 'MN001A', '支付配置', 'Payment Setting', '#', '9', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0081', 'MN0080', '快捷支付银行', null, '/thirdpartyPaymentBank/index', '2', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0082', 'MN000N', '待出款订单', 'Pending Order', '/takeDepositRecord/waitPayment', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0083', 'MN006K', '用户等级', null, '/employeeLevel/index', '5', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0089', 'MN0082', '查询', '查询', '/takeDepositRecord/findBeOutOfMoney', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008A', 'MN007Z', '查询', '查询', '/employeeLevel/list', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008B', 'MN007Z', '修改', '修改', '/employeeLevel/update', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008C', 'MN007Z', '批量删除', '批量删除', '/employeeLevel/batchDelete', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008D', 'MN007Z', '删除', '删除', '/employeeLevel/delete', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008E', 'MN007Z', '保存', '保存', '/employeeLevel/save', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008F', 'MN0080', '新增', null, '/thirdpartyPaymentBank/add', '7', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN008G', 'MN0080', '快捷支付银行', 'Fast Pay Bank', '/thirdpartyPaymentBank/index', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008H', 'MN008G', '添加支付银行', '添加支付银行', '/thirdpartyPaymentBank/add', '6', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008I', 'MN008G', '查询', '查询', '/thirdpartyPaymentBank/data', '7', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008J', 'MN008G', '批量删除', '批量删除', '/thirdpartyPaymentBank/deleteSelect', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008K', 'MN008G', '编辑支付银行', '编辑支付银行', '/thirdpartyPaymentBank/update', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008L', 'MN004K', 'API访问监控', 'API Access Monitor', 'http://o-api/SystemVisite/ApiVisiteLog', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008M', 'MN004K', 'GLXT访问监控', 'GLXT Access Monitor', '/SystemVisite/SysVisiteLog', '5', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008N', 'MN0008', '隐私数据授权', 'Privacy Data Authorization', '/PrivateData/View', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008O', 'MN002B', '取款次数排名', 'Times Of Withdraw Ranking', '/report/employeeWithdraNumberRanking', '16', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008P', 'MN002B', '用户赢钱排名', 'User Win Ranking', '/report/userLoseWinRankingReport?mark=1', '11', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008Q', 'MN004W', '登录密码重置', '登录密码重置', '/common/resetLoginPassword', '6', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008R', 'MN004W', '资金密码重置', '资金密码重置', '/common/resetCapitalPassword', '7', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008S', 'MN004W', '权限配置', '权限配置', '/EmployeeMPG/permission', '10', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008V', 'MN002B', '用户来源统计', 'User Source Statistics', '/report/userDomainLink', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008W', 'MN004O', '消息回复', '消息回复', '/Message/ReplyMessage', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008X', 'MN0029', '查看直线会员', '查看直线会员', '/employeeAgent/agentMember', '8', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008Y', 'MN0096', '会员站点模板', 'Member Site Template', '/brandTemplate/index', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN008Z', 'MN008Y', '查询', '查询', '/brandTemplate/queryTemplateData', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0090', 'MN008Y', '添加', '添加', 'brandTemplate/addTemplate', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0091', 'MN008Y', '修改', null, '/brandTemplate/updateTemplate', '4', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN0092', 'MN008Y', '删除', '删除', '/brandTemplate/deleteTemplate', '6', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0093', 'MN008Y', '修改', '修改', 'brandTemplate/addTemplate', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0094', 'MN009C', '客服专线', 'Customer Service Hotline', '/brandContact/index', '13', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0095', 'MN004Q', '域名管理', '域名管理', '/registerLink/mianDomainSetting', '6', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0096', 'MN001A', '站点模板管理', 'Website Template', '##', '6', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0097', 'MN0094', '查询', '查询', '/brandContact/queryBrandContact', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0098', 'MN0094', '添加', '添加', '/brandContact/addBrandContact', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN0099', 'MN0094', '删除', '删除', '/brandContact/deleteBrandContact', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009A', 'MN0005', '公司总览', 'Co. Info', '/Pandect/iPandect', '0', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009B', 'MN0006', '团队总览', 'Team Info', '/Pandect/aPandect', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009C', 'MN001A', '专线管理', 'Hotline Info', '##', '2', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009D', 'MN000E', '客服专线', '客服专线', '/brandContact/index', '6', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009E', 'MN0094', '编辑专线', '编辑专线', '/brandContact/updBrandContact', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009F', 'MN004Q', '出款方式', '出款方式', '/Enterprise/savePaymentMethod', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009G', 'MN000E', '删除品牌', '删除品牌', '/EOBrand/Delete', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009H', 'MN0082', '快速出款', '快速出款', '/takeDepositRecord/systemAutoPayment', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009I', 'MN0082', '手动出款', '手动出款', '/takeDepositRecord/accountingManuallyPayment', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009J', 'MN0082', '拒绝', '拒绝', '/takeDepositRecord/RefusePayment', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009K', 'MN000C', '调整余额', '调整余额', '/EInformation/update', '7', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009L', 'MN008Y', '编辑', '编辑', 'brandTemplate/updTemplate', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009M', 'MN004W', '结算配置', '结算配置', '/GCBonus/userSetting', '9', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009N', 'MN007Q', '数据采集', 'Data Collection', '##', '2', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009O', 'MN009N', '手动采集', 'Manual Collection', 'http://o-data/Data/Index', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009P', 'MN005I', '客户活跃统计详细', null, '/report/employeeActivityDetail', '1', '4', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN009Q', 'MN005H', '客户活跃统计', '客户活跃统计', '/report/employeeActivityDetail', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009R', 'MN001A', '活动管理', 'Activity Info', '##', '3', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009S', 'MN0096', '会员站点模板分配', 'Member Site Template Distribution', '/brandTemplate/contactIndex', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009T', 'MN009R', '活动定制', 'Activity Customization', '/EACustomization/Index', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009U', 'MN009T', '定制活动', '定制活动', '/EACustomization/Add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009V', 'MN009T', '活动编辑', '活动编辑', '/EACustomization/Edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009W', 'MN009S', '分配模板', '分配模板', '/brandTemplate/templateContactAdd', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009X', 'MN009T', '参数设置', '参数设置', '/EACustomization/SaveSetting', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009Y', 'MN0096', '代理站点模板', 'Affiliate Site Template', '/brandTemplate/agentIndex', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN009Z', 'MN0096', '代理站点模板分配', 'Proxy Site Template Distribution', '/brandTemplate/agentContactIndex', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00A0', 'MN002Q', '代理站点管理', 'Affiliate Site Management', '/registerLink/agementSiteIndex', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00A1', 'MN009Y', '创建代理模板', '创建代理模板', 'brandTemplate/addAgentTemplate', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00A2', 'MN009Y', '修改代理模板', '修改代理模板', 'brandTemplate/updAgentTemplate', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00A3', 'MN009Y', '删除代理模板', '删除代理模板', '/brandTemplate/deleteTemplate', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00A4', 'MN009Z', '分配代理模板', '分配代理模板', '/brandTemplate/agentTemplateContactAdd', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00A5', 'MN00A0', '代理站点注册', '代理站点注册', '/registerLink/agentSiteAdd', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00A6', 'MN0005', '域名信息', 'Domain Info', '/registerLink/domainInfoIndex', '6', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00A7', 'MN004W', '禁用用户', '禁用用户', '/EEmployee/disableSelectEmployee', '11', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00A8', 'MN004W', '启用用户', '启用用户', '/EEmployee/activateSelectEmployee', '12', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00A9', 'MN000F', '用户批量禁用', '用户批量禁用', '/EEmployee/disableSelectEmployee', '7', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AA', 'MN000F', '用户批量启用', '用户批量启用', '/EEmployee/activateSelectEmployee', '8', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AB', 'MN0029', '批量禁用', '批量禁用', '/EEmployee/disableSelectEmployee', '9', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AC', 'MN0029', '批量启用', '批量启用', '/EEmployee/activateSelectEmployee', '10', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AD', 'MN0006', '余额提现', 'Balance Withdraw', '/takeDepositRecord/agentTakeAdd', '5', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AE', 'MN004W', '有效时间', '有效时间', '/EEmployee/ValidTimeEmployee', '13', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AF', 'MN0045', 'AV老虎机', 'AV Slot', '/KrAvGame/list', '11', '3', '-1', '-1');
INSERT INTO `permission_menu` VALUES ('MN00AG', 'MN0045', 'YGAG云谷', 'YGAG云谷', '/YgAgGame/list', '12', '3', '-1', '-1');
INSERT INTO `permission_menu` VALUES ('MN00AH', 'MN004X', '优惠流水', 'Bonus Statement', '/ActivityBetRecord/list', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AI', 'MN0006', '绑定银行卡', null, '##', '4', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN00AJ', 'MN0045', 'SA沙龙', 'SA沙龙', '/SaGame/list', '13', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AK', 'MN0045', 'ZJ洲际', 'ZJ洲际', '/ZjGame/list', '14', '3', '-1', '-1');
INSERT INTO `permission_menu` VALUES ('MN00AL', 'MN0006', '我的银行卡', 'My Bank Cards', '/EmployeeInformation/myBank/index', '6', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AM', 'MN00AL', '添加银行卡', '添加银行卡', '/EmployeeInformation/userInfo/userInfoAdd', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AN', 'MN00AL', '编辑银行卡', '编辑银行卡', '/EmployeeInformation/updateBankInfo', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AO', 'MN0005', '运营流程图', 'Process Chart', '/Enterprise/SettingStep', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AP', 'MN00AL', '删除银行卡', '删除银行卡', '/EmployeeInformation/deleteBankInfo', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AQ', 'MN004K', 'API日志开关', 'API Logs Switch', 'http://o-api/RunLogger/Index', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AR', 'MN0001', '结算管理', 'Settlement Info', '#', '3', '2', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AS', 'MN00AR', '会员打码日结算', 'Daily Turnover Settle', '/reportMember/reportDailyList', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AT', 'MN00AS', '全部发放', '全部发放', '/reportMember/processDailyAll', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AU', 'MN00AS', '发放选择', '发放选择', '/reportMember/processDailySelect', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AV', 'MN00AR', '会员打码周结算', 'Weekly Turnover Settle', '/reportMember/reportWeeklyList', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AW', 'MN00AV', '发放选择', '发放选择', '/reportMember/processWeeklySelect', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AX', 'MN00AV', '发放全部', '发放全部', '/reportMember/processWeeklyAll', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AY', 'MN0008', 'IP白名单', 'IP Whitelist', '/LoginWhiteList/index', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00AZ', 'MN00AR', '代理打码日结算', 'Agent Daily Turnover Settle', '/reportAgent/reportDailyList', '3', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN00B0', 'MN00AZ', '发放选择', '发放选择', '/reportAgent/processDailySelect', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00B1', 'MN00AZ', '发放全部', '发放全部', '/reportAgent/processDailyAll', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00B2', 'MN00AY', '添加', '添加', '/LoginWhiteList/add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00B3', 'MN00AY', '修改', '修改', '/LoginWhiteList/edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00B4', 'MN004Q', 'IP白名单', 'IP Whitelist', '/LoginWhiteList/savesa', '8', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00B5', 'MN004Q', '快速创建企业帐号', '快速创建企业帐号', '/enterprise/toFastCreate', '9', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00B6', 'MN00AR', '代理打码周结算', 'Agent Weekly Turnover Settle', '/reportAgent/reportWeekList', '4', '3', '1', '-1');
INSERT INTO `permission_menu` VALUES ('MN00B7', 'MN00B6', '发放选择', '发放选择', '/reportAgent/reportWeekList', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00B8', 'MN00B6', '发放全部', '发放全部', '/reportAgent/reportWeekList', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00B9', 'MN004Q', '游戏账号前缀配置', '游戏账号前缀配置', '/GamePlatformPrefix/data', '10', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BA', 'MN000N', '存取款查询', 'Deposit And Withdrawal Inquiries', '/takeDepositRecord/takedeposit', '8', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BB', 'MN00BA', '查看审批详情', '查看审批详情', '/common/queryDepositTakeApproveRecord', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BC', 'MN00BA', '搜索订单', '搜索订单', '/takeDepositRecord/findTakeDepositRecordAll', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BD', 'MN000F', '转入转出', '转入转出', '/CreditAgent/shifintergral', '9', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BE', 'MN0029', '转入转出', '转入转出', '/CreditAgent/shifintergral', '11', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BF', 'MN0005', '支付回调域名', 'Callback Domain', '/EnterpriseOperatingBrandPay/index', '12', '3', '2', '1');
INSERT INTO `permission_menu` VALUES ('MN00BG', 'MN00BF', '查询', '查询', '/EnterpriseOperatingBrandPay/data', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BH', 'MN00BF', '新增', '新增', '/EnterpriseOperatingBrandPay/add', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BI', 'MN00BF', '编辑', '编辑', '/EnterpriseOperatingBrandPay/update', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BJ', 'MN00BF', '保存', '保存', '/EnterpriseOperatingBrandPay/save', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BK', 'MN00BF', '删除', '删除', '/EnterpriseOperatingBrandPay/deleteIp', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BL', 'MN0005', '企业游戏列表', 'Co. Game List', '/EmployeeAccout/gameList', '14', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BM', 'MN00BL', '数据查询', '数据查询', '/EmployeeAccout/gameListData', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BN', 'MN00BL', '批量下分', '批量下分', '/EmployeeAccout/batchDown', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BO', 'MN00BL', '查询余额', '查询余额', '/EmployeeAccout/batchBalance', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BP', 'MN0051', '编辑', '编辑', '/thirdpartyPayment/update', '8', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BQ', 'MN0051', '保存修改', '保存修改', '/thirdpartyPayment/updatename', '9', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BR', 'MN002S', '会员站点编辑', '会员站点编辑', '/registerLink/userSiteUpdate', '8', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BS', 'MN002S', '会员站点保存', '会员站点保存', '/registerLink/userSiteSave', '9', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BT', 'MN00A0', '代理站点编辑', '代理站点编辑', '/registerLink/agentSiteUpdate', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BU', 'MN00A0', '代理站点保存', '代理站点保存', '/registerLink/agentSiteSave', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BV', 'MN0008', '游戏API管理', 'Game APIs', '/apigame/index', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BW', 'MN00BV', '分页查询', '分页查询', '/apigame/pagekey', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BX', 'MN00BV', '初始化', '初始化', '/apigame/initkey', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BY', 'MN00BV', '转到编辑', '转到编辑', '/apigame/edit', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00BZ', 'MN00BV', '保存数据', '保存数据', '/apigame/save', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00C0', 'MN0045', 'MG游戏', 'MG Game', '/MgGame/index', '16', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00C1', 'MN0045', 'TTG老虎机', 'TTG Slot', '/TtgGame/index', '17', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00C2', 'MN0008', '游戏分类管理', 'Game Type', '/apigametype/index', '5', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00C3', 'MN00C2', '分页查询', '分页查询', '/apigametype/pagelist', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00C4', 'MN00C2', '转到编辑', '转到编辑', '/apigametype/edit', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00C5', 'MN00C2', '保存数据', '保存数据', '/apigametype/save', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00C6', 'MN0045', 'PNG老虎机', 'PNG Slot', '/PNGGame/index', '18', '3', '-1', '-1');
INSERT INTO `permission_menu` VALUES ('MN00C7', 'MN0052', '审核权限', '审核权限', '/activitypay/audit', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00C8', 'MN0052', '发放权限', '发放权限', '/activitypay/pay', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00C9', 'MN0052', '修改权限', '修改权限', '/activitypay/edit', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CA', 'MN0045', 'GG捕鱼', 'GG Fishing', '/gggame/index', '19', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CB', 'MN0045', '申博', 'Shenbet', '/sgsgame/index', '20', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CC', 'MN0045', 'IDN扑克', 'IDN Poker', '/idngame/index', '21', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CD', 'MN0005', 'Banner管理', 'Banner List', '/banner/index', '22', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CE', 'MN00CD', '新增Banner', '新增Banner', '/banner/add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CF', 'MN00CD', '编辑Banner', '编辑Banner', '/banner/edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CG', 'MN00CD', '删除Banner', '删除Banner', '/banner/delete', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CH', 'MN002Q', '签到领红包管理', 'Check In For Red Envelop Managment ', '/redbag/index', '9', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CI', 'MN00CH', '红包审核', '红包审核', '/redbag/audit', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CJ', 'MN00CH', '红包发放', '红包发放', '/redbag/pay', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CK', 'MN0003', '注册风险IP', 'Registration Risk IP', '/regeditlog/index', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CL', 'MN0006', '会员银行卡', 'Member Bank Cards', '/EmployeeInformation/indexBankInfoList', '9', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CM', 'MN0003', '提存比预警', 'Deposit And Withdral Ratio warning', '/report/userDepositTakeRateReport', '8', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CN', 'MN0003', '输赢概率预警', 'Win Loss Ratio Warning', '/report/userGameWinLoseRateReport', '9', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CO', 'MN0045', 'M88体育', 'M88 Sports', '/m88game/index', '23', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CP', 'MN0005', '电子游戏管理', 'Game Management', '/enterprisesolt/index', '23', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CQ', 'MN0005', '会员操作日志', 'Membership Opration Log', '/userlog/userlog', '24', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CR', 'MN0005', '后台操作日志', 'Backend Opration Log', '/userlog/adminlog', '25', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CS', 'MN0045', 'HB哈巴电子', 'HB哈巴电子', '/habgame/index', '23', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CT', 'MN004W', '导出用户数据', '导出用户数据', '/EEmployee/exportEmployee', '14', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CU', 'MN004X', '优惠管理', 'Peomotion Management', '/favourable/index', '15', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CV', 'MN00CU', '创建优惠', '创建优惠', '/favourable/add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CW', 'MN00CU', '编辑优惠', '编辑优惠', '/favourable/edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CX', 'MN00CU', '启用禁用优惠', '启用禁用优惠', '/favourable/dostatus', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CY', 'MN004X', '优惠组管理', 'Peomotion Group Management', '/favourableuser/index', '16', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00CZ', 'MN00CY', '优惠组编辑', '优惠组编辑', '/favourableuser/edit', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00D0', 'MN002B', '游戏活跃统计', 'Game Active Statistics', '/bettingallday/index', '0', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00D1', 'MN00AR', '占成代结算A', '占成代结算A', '/nbreport/a1', '17', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00D2', 'MN00AR', '占成代结算B', '占成代结算B', '/nbreport/a2', '18', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00D3', 'MN00AR', '分红代理结算', 'Dividend Agent Settlement', '/nbreport/b', '21', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00D4', 'MN0005', '游戏账号管理', 'Game Account Managment', '/apiaccount/index', '9', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00D5', 'MN00D4', '启用禁用操作', '启用禁用操作', '/apiaccount/update', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00D6', 'MN0045', 'QTech电子', 'QTech', '/qtgame/index', '24', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00D7', 'MN0045', 'GB彩票', 'GB Lottery', '/gbcgame/index', '25', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00D8', 'MN0045', 'eBET真人', 'eBET Live', '/ebetgame/index', '26', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00D9', 'MN0045', 'WIN88 PT游戏', 'WIN88 PT', '/win88game/index', '27', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DA', 'MN0045', 'TGPlayer申博', 'TGPlayer', '/tgpgame/index', '28', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DB', 'MN0045', 'GG扑克', 'GG Poker', '/ggpgame/index', '29', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DE', 'MN002Q', '活动定制', 'Activity Customization', '/EACustomization/Index', '5', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DF', 'MN0005', '汇率管理', 'Exchange Rate', '/exchangerate/list', '20', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DG', 'MN00DF', '搜索', '搜索', '/exchangerate/data', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DH', 'MN00DF', '创建汇率', '创建汇率', '/exchangerate/add', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DI', 'MN00DF', '修改汇率', '修改汇率', '/exchangerate/update', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DJ', 'MN00DF', '删除汇率', '删除汇率', '/exchangerate/delete', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DK', 'MN00DF', '批量删除', '批量删除', '/exchangerate/batchDelete', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DM', 'MN004X', '活动充值批量', '活动充值批量', '/moneyInAndOut/activityBatchRecharge', '5', '3', '-1', '-1');
INSERT INTO `permission_menu` VALUES ('MN00DN', 'MN0045', '会员游戏汇总', 'Membership Game Summary', '/bettingallday/memberGameReport', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DO', 'MN0045', 'IBC沙巴体育', 'IBC SB Sports', '/eibcgame/index', '30', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DP', 'MN00CL', '编辑银行卡', '编辑银行卡', '/EmployeeInformation/updateBankInfo', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DQ', 'MN00CL', '删除银行卡', '删除银行卡', '/EmployeeInformation/deleteBankInfo', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DR', 'MN007Z', '设置洗码', '设置洗码', '/employeeLevelBonus/setting', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DS', 'MN000F', '游戏', '游戏', '/EmployeeAccout/userAccout', '9', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DT', 'MN000F', '总览', '总览', '/EEmployee/account', '10', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DU', 'MN004W', '编辑', '编辑', '/EEmployee/userJsp/updateEmployeeInfo', '8', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DW', 'MN004X', '额度转换', 'Fund Transfer', '/UserBalanceTransfer/index', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DX', 'MN009N', '游戏平台状态', 'Game Platform Status', '/datahand/status', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DY', 'MN009N', '数据同步清单', 'Data Synchronization List', '/datahand/index', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00DZ', 'MN009N', '数据同步日志', 'Data Synchronization Log', '/datahand/logs', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00E0', 'MN009N', '手动同步任务', 'Manually Synchronize Tasks', '/datahand/repeat', '5', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00E1', 'MN004W', '会员信息汇总', '会员信息汇总', '/EEmployee/userJsp/allinfo', '15', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00E2', 'MN000F', '会员信息汇总', '会员信息汇总', '/EEmployee/allinfo', '11', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00E3', 'MN004Q', '企业域名设置', '企业域名设置', '/', '11', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00E4', 'MN0005', '在线用户列表', 'Online List', '/EEmployee/onlineIndex', '8', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00E5', 'MN0008', '角色管理', 'Role Info', '/PermissionRole/index', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00E6', 'MN00E5', '新增角色', '新增角色', '/PermissionRole/add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00E7', 'MN00E5', '删除角色', '删除角色', '/PermissionRole/delete', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00E8', 'MN00E5', '批量删除角色', '批量删除角色', '/PermissionRole/batchDelete', '5', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00E9', 'MN00E5', '编辑角色', '编辑角色', '/PermissionRole/edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EA', 'MN00E5', '克隆角色', '克隆角色', '/PermissionRole/clone', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EB', 'MN00CL', '锁定', '锁定', '/EmployeeInformation/updateStatus', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EC', 'MN00CL', '解锁', '解锁', '/EmployeeInformation/updateStatus', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00ED', 'MN006K', '银行卡号校验库', 'Bank Card Verification lib', '/cardbin/index', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EE', 'MN0005', '公司收款二维码', 'Co. Reciving QR code ', '/enterpriseqcode/list', '11', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EF', 'MN00EE', '创建二维码', '创建二维码', '/enterpriseqcode/add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EG', 'MN00EE', '删除二维码', '删除二维码', '/enterpriseqcode/delete', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EH', 'MN00EE', '编辑二维码', '编辑二维码', '/enterpriseqcode/edit', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EI', 'MN00EE', '启用禁用二维码', '启用禁用二维码', '/enterpriseqcode/enableDisable', '4', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EJ', 'MN0045', '会员日报表', 'Member Daily Report', '/bettingallday/dayreport', '0', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EK', 'MN0005', '系统登录日志', 'System Login Report', '/LoginLog/indexall', '27', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EL', 'MN009N', 'AG采集情况', 'AG Collection Statement', '/datahand/tag', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EM', 'MN0003', '上下分预警', 'Points Warning', '/moneyInAndOut/warn', '10', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EN', 'MN0045', 'YoPLAY游戏', 'YoPLAY Game', '/yoplaygame/index', '31', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EO', 'MN00AR', '占成代结算C', '占成代结算C', '/nbreport/a3', '19', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EP', 'MN004X', '额度转换-维护', 'Fund Transfer', '/UserBalanceTransfer/index2', '4', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EV', 'MN007Y', '信用代理等级', '信用代理等级', '/agenth5Level/index', '2', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EW', 'MN00AS', '取消支付计划', '取消支付计划', '/reportMember/cancelDaily', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EX', 'MN00AV', '取消支付计划', '取消支付计划', '/reportMember/cancelWeekly', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EY', 'MN00AZ', '取消支付计划', '取消支付计划', '/reportAgent/cancelDaily', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00EZ', 'MN00B6', '取消支付计划', '取消支付计划', '/reportAgent/cancelWeekly', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00F0', 'MN00CL', '增加银行卡', 'Add Bank Card', '/EmployeeInformation/userInfo/addUserInfo', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00F1', 'MN002Q', '代理Banner', '代理Banner', '/agent/banner/index', '6', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00F2', 'MN002Q', '代理系统栏目', '代理系统栏目', '/agent/item/index', '7', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00F3', 'MN00F1', '新增', '新增', '/agent/banner/add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00F4', 'MN00F1', '编辑', '编辑', '/agent/banner/edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00F5', 'MN00F1', '删除', '删除', '/agent/banner/delete', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00F6', 'MN00F2', '增加栏目', '增加栏目', '/agent/item/add', '1', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00F7', 'MN00F2', '编辑栏目', '编辑栏目', '/agent/item/edit', '2', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00F8', 'MN00F2', '删除栏目', '删除栏目', '/agent/item/delete', '3', '4', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00F9', 'MN006K', '银行卡黑名单', 'Blacklist', '/cardsblacklist/index', '3', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00FA', 'MN0045', 'IM体育', 'IM体育', '/imgame/index', '32', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00FB', 'MN0005', '今日报表', 'Report dates', '/EnterpriseReportDates/index', '1', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00FC', 'MN0045', '去玩棋牌', null, '/QwpGame/index', '33', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00FD', 'MN0045', 'JDB168', null, '/JdbGame/index', '34', '3', '1', '1');
INSERT INTO `permission_menu` VALUES ('MN00FE', 'MN009N', '监控面板', null, '/datahand/service', '7', '3', '1', '1');

-- ----------------------------
-- Table structure for permission_role
-- ----------------------------
DROP TABLE IF EXISTS `permission_role`;
CREATE TABLE `permission_role` (
  `rolecode` char(8) NOT NULL COMMENT '主键',
  `rolename` varchar(20) NOT NULL COMMENT '角色名称',
  `enterprisecode` char(8) NOT NULL COMMENT '企业CODE',
  `datastatus` char(2) NOT NULL DEFAULT '1' COMMENT '1:有效数据，-1:无效的数据',
  `permissions` text COMMENT '拥有的权限',
  PRIMARY KEY (`rolecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of permission_role
-- ----------------------------
INSERT INTO `permission_role` VALUES ('PR0001', '测试角色', 'EN0000', '-1', 'MN0002|MN0005|MN00AO|MN009A|MN004Q|MN000T|MN000I|MN009F|MN005V|MN005W|MN0095|MN007T|MN00B4|MN00B5|MN00B9|MN00E3|MN000E|MN001Y|MN006C|MN009G|MN001Z|MN002T|MN009D|MN00A6|MN004W|MN005X|MN005Y|MN005Z|MN0060|MN007V|MN008Q|MN008R|MN00DU|MN009M|MN008S|MN00A7|MN00A8|MN00AE|MN00E1|MN00E4|MN00D4|MN00D5|MN000C|MN001U|MN000L|MN001S|MN006H|MN001T|MN009K|MN00EE|MN00EF|MN00EG|MN00EH|MN00EI|MN0051|MN007E|MN007F|MN007G|MN007H|MN007S|MN007I|MN00BP|MN00BQ|MN00BF|MN00BG|MN00BH|MN00BJ|MN00BI|MN00BK|MN00BL|MN00BM|MN00BN|MN00BO|MN00DF|MN00DG|MN00DH|MN00DI|MN00DJ|MN00DK|MN00CD|MN00CE|MN00CF|MN00CG|MN00CP|MN00CQ|MN00CR|MN000N|MN0040|MN0041|MN006I|MN0042|MN0022|MN0069|MN003J|MN003K|MN0023|MN006A|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003I|MN007U|MN003X|MN00BA|MN00BB|MN00BC|MN004X|MN0052|MN00C7|MN00C8|MN00C9|MN00AH|MN0054|MN00DW|MN0058|MN00DM|MN0053|MN0055|MN005B|MN00CU|MN00CV|MN00CW|MN00CX|MN00CY|MN00CZ|MN0003|MN00CK|MN004D|MN007W|MN007X|MN005N|MN005P|MN00CM|MN00CN|MN004H|MN004J|MN0079|MN007A|MN004L|MN0078');
INSERT INTO `permission_role` VALUES ('PR0002', '[克隆] 测试角色', 'EN0000', '-1', 'MN0002|MN0005|MN00AO|MN009A|MN004Q|MN000T|MN000I|MN009F|MN005V|MN005W|MN0095|MN007T|MN00B4|MN00B5|MN00B9|MN00E3|MN000E|MN001Y|MN006C|MN009G|MN001Z|MN002T|MN009D|MN00A6|MN004W|MN005X|MN005Y|MN005Z|MN0060|MN007V|MN008Q|MN008R|MN00DU|MN009M|MN008S|MN00A7|MN00A8|MN00AE|MN00E1|MN00E4|MN00D4|MN00D5|MN000C|MN001U|MN000L|MN001S|MN006H|MN001T|MN009K|MN00EE|MN00EF|MN00EG|MN00EH|MN00EI|MN0051|MN007E|MN007F|MN007G|MN007H|MN007S|MN007I|MN00BP|MN00BQ|MN00BF|MN00BG|MN00BH|MN00BJ|MN00BI|MN00BK|MN00BL|MN00BM|MN00BN|MN00BO|MN00DF|MN00DG|MN00DH|MN00DI|MN00DJ|MN00DK|MN00CD|MN00CE|MN00CF|MN00CG|MN00CP|MN00CQ|MN00CR|MN000N|MN0040|MN0041|MN006I|MN0042|MN0022|MN0069|MN003J|MN003K|MN0023|MN006A|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003I|MN007U|MN003X|MN00BA|MN00BB|MN00BC|MN004X|MN0052|MN00C7|MN00C8|MN00C9|MN00AH|MN0054|MN00DW|MN0058|MN00DM|MN0053|MN0055|MN005B|MN00CU|MN00CV|MN00CW|MN00CX|MN00CY|MN00CZ|MN0003|MN00CK|MN004D|MN007W|MN007X|MN005N|MN005P|MN00CM|MN00CN|MN004H|MN004J|MN0079|MN007A|MN004L|MN0078');
INSERT INTO `permission_role` VALUES ('PR0003', '测试角色A', 'EN0000', '1', '');
INSERT INTO `permission_role` VALUES ('PR0004', '主管', 'EN0030', '1', 'MN0002|MN0005|MN00AO|MN009A|MN004Q|MN000T|MN009F|MN005W|MN0095|MN00B4|MN00B9|MN00E3|MN000E|MN001Y|MN006C|MN009G|MN001Z|MN002T|MN009D|MN004W|MN005X|MN005Y|MN005Z|MN0060|MN007V|MN008Q|MN008R|MN009M|MN008S|MN00A7|MN00A8|MN00AE|MN00D4|MN00D5|MN000C|MN001U|MN000L|MN001S|MN006H|MN001T|MN009K|MN00EE|MN00EF|MN00EG|MN00EH|MN00EI|MN0051|MN007E|MN007F|MN007G|MN007H|MN007S|MN007I|MN00BP|MN00BQ|MN00BF|MN00BG|MN00BH|MN00BJ|MN00BI|MN00BK|MN00BL|MN00BM|MN00BN|MN00BO|MN00CD|MN00CE|MN00CF|MN00CG|MN00CP|MN00CQ|MN00CR|MN0003|MN00CK|MN004D|MN007W|MN007X|MN005N|MN005P|MN00CM|MN00CN|MN004H|MN004J|MN0079|MN007A|MN004L|MN0078|MN0001|MN0006|MN004Y|MN009B|MN004Z|MN00AD|MN00AL|MN00AM|MN00AN|MN00AP|MN000F|MN0038|MN000Z|MN0039|MN0011|MN003A|MN0067|MN00A9|MN00AA|MN00BD|MN00CL|MN002Q|MN0056|MN002S|MN002R|MN0035|MN0036|MN0037|MN003H|MN003W|MN00BR|MN00BS|MN0044|MN007B|MN0059|MN007O|MN007P|MN00CH|MN00CI|MN00CJ|MN00AR|MN00AS|MN00AU|MN00AT|MN00AV|MN00AW|MN00AX|MN00D1|MN00D2|MN00D3|MN0045|MN00EJ|MN00DN|MN0046|MN0048|MN0049|MN004A|MN004C|MN004B|MN005A|MN00AF|MN00AG|MN00AJ|MN00AK|MN00C0|MN00C1|MN00C6|MN00CA|MN00CB|MN00CC|MN0047|MN00CO|MN00CS|MN005C|MN002B|MN00D0|MN005D|MN005E|MN008V|MN005G|MN005H|MN009Q|MN005I|MN005J|MN005K|MN005L|MN008P|MN005M|MN008O|MN006J|MN000P|MN004E|MN004F|MN004G|MN004O|MN0077|MN008W|MN001A|MN001E|MN001J|MN001K|MN001L|MN001M|MN003T|MN003U|MN001N|MN001P|MN001Q|MN001R|MN003V|MN003Y|MN009C|MN0094|MN0097|MN009E|MN0098|MN0099|MN007Y|MN007Z|MN008A|MN008B|MN008C|MN008D|MN008E|MN0008|MN008N|MN00AY|MN00B2|MN00B3');
INSERT INTO `permission_role` VALUES ('PR0005', '超级管理员', 'EN0030', '1', 'MN0002|MN0005|MN00AO|MN009A|MN004Q|MN000T|MN009F|MN005W|MN0095|MN00B4|MN00B9|MN00E3|MN000E|MN001Y|MN006C|MN009G|MN001Z|MN002T|MN009D|MN00A6|MN004W|MN005X|MN005Y|MN005Z|MN0060|MN007V|MN008Q|MN008R|MN009M|MN008S|MN00A7|MN00A8|MN00AE|MN00E4|MN00D4|MN00D5|MN000C|MN001U|MN000L|MN001S|MN006H|MN001T|MN009K|MN00EE|MN00EF|MN00EG|MN00EH|MN00EI|MN0051|MN007E|MN007F|MN007G|MN007H|MN007S|MN007I|MN00BP|MN00BQ|MN00BF|MN00BG|MN00BH|MN00BJ|MN00BI|MN00BK|MN00BL|MN00BM|MN00BN|MN00BO|MN00CD|MN00CE|MN00CF|MN00CG|MN00CP|MN00CQ|MN00CR|MN000N|MN0040|MN0041|MN006I|MN0042|MN0022|MN0069|MN003J|MN003K|MN0023|MN006A|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003I|MN007U|MN003X|MN00BA|MN00BB|MN00BC|MN004X|MN0052|MN00C7|MN00C8|MN00C9|MN00AH|MN0054|MN0058|MN0053|MN0055|MN005B|MN00CU|MN00CV|MN00CW|MN00CX|MN00CY|MN00CZ|MN0003|MN00CK|MN004D|MN007W|MN007X|MN005N|MN005P|MN00CM|MN00CN|MN004H|MN004J|MN0079|MN007A|MN004L|MN0078|MN0001|MN0006|MN004Y|MN009B|MN004Z|MN00AD|MN00AL|MN00AM|MN00AN|MN00AP|MN000F|MN0038|MN000Z|MN0039|MN0011|MN003A|MN0067|MN00A9|MN00AA|MN00BD|MN0029|MN003B|MN003C|MN003D|MN003E|MN003F|MN003G|MN0068|MN008X|MN00AB|MN00AC|MN00BE|MN00CL|MN002Q|MN0056|MN002S|MN002R|MN0035|MN0036|MN0037|MN003H|MN003W|MN00BR|MN00BS|MN00A0|MN00A5|MN00BT|MN00BU|MN0044|MN007B|MN0059|MN007O|MN007P|MN00CH|MN00CI|MN00CJ|MN00AR|MN00AS|MN00AU|MN00AT|MN00AV|MN00AW|MN00AX|MN00AZ|MN00B0|MN00B1|MN00B6|MN00B7|MN00B8|MN00D1|MN00D2|MN00D3|MN0045|MN00EJ|MN00DN|MN0046|MN0048|MN0049|MN004A|MN004C|MN004B|MN005A|MN00AF|MN00AG|MN00AJ|MN00AK|MN00C0|MN00C1|MN00C6|MN00CA|MN00CB|MN00CC|MN0047|MN00CO|MN00CS|MN005C|MN002B|MN00D0|MN005D|MN005E|MN008V|MN005G|MN005H|MN009Q|MN005I|MN005J|MN005K|MN005L|MN008P|MN005M|MN008O|MN006J|MN000P|MN004E|MN004F|MN004G|MN004O|MN0077|MN008W|MN001A|MN001E|MN001J|MN001K|MN001L|MN001M|MN003T|MN003U|MN001N|MN001P|MN001Q|MN001R|MN003V|MN003Y|MN009C|MN0094|MN0097|MN009E|MN0098|MN0099|MN007Y|MN007Z|MN008A|MN008B|MN008C|MN008D|MN008E|MN0008|MN00E5|MN00E6|MN00E9|MN00E7|MN00EA|MN00E8|MN008N|MN00AY|MN00B2|MN00B3');
INSERT INTO `permission_role` VALUES ('PR0006', '财务', 'EN0030', '1', 'MN0002|MN0005|MN000N|MN0040|MN0041|MN006I|MN0042|MN0022|MN0069|MN003J|MN003K|MN0023|MN006A|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003I|MN007U|MN003X|MN00BA|MN00BB|MN00BC|MN004X|MN0052|MN00C7|MN00C8|MN00C9|MN00AH|MN0054|MN0058|MN0053|MN0055|MN005B|MN00CU|MN00CV|MN00CW|MN00CX|MN00CY|MN00CZ');
INSERT INTO `permission_role` VALUES ('PR0007', '风控', 'EN0030', '1', 'MN0002|MN0005|MN00D4|MN00D5|MN000N|MN0040|MN0041|MN006I|MN0042|MN0022|MN0069|MN003J|MN003K|MN0023|MN006A|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003I|MN007U|MN003X|MN00BA|MN00BB|MN00BC|MN0003|MN00CK|MN004D|MN007W|MN007X|MN005N|MN005P|MN00CM|MN00CN|MN0001|MN0006|MN000F|MN0038|MN0067|MN00A9|MN00AA|MN002Q|MN00CH|MN00CI|MN00CJ');
INSERT INTO `permission_role` VALUES ('PR0008', '客服', 'EN0030', '1', 'MN0002|MN0005|MN00D4|MN00D5|MN000N|MN0040|MN0041|MN006I|MN0042|MN0022|MN0069|MN003J|MN003K|MN0023|MN006A|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003I|MN007U|MN003X|MN00BA|MN00BB|MN00BC|MN0001|MN0006|MN004Y|MN009B|MN000F|MN0038|MN0067|MN00A9|MN00AA|MN002Q|MN0059|MN007O|MN007P|MN00CH|MN00CI|MN00CJ|MN0045|MN00EJ|MN00DN');
INSERT INTO `permission_role` VALUES ('PR0009', '代理专员', 'EN0030', '1', 'MN0001|MN0006|MN004Y|MN009B|MN004Z|MN00AD|MN00AL|MN00AM|MN00AN|MN00AP|MN000F|MN0038|MN000Z|MN0039|MN0011|MN003A|MN0067|MN00A9|MN00AA|MN00DS|MN00BD|MN00DT|MN00E2|MN0029|MN003B|MN003C|MN003D|MN003E|MN003F|MN003G|MN0068|MN008X|MN00AB|MN00AC|MN00BE|MN002Q|MN002S|MN002R|MN0035|MN0036|MN0037|MN003H|MN003W|MN00BR|MN00BS|MN00A0|MN00A5|MN00BT|MN00BU|MN0044|MN007B|MN00AR|MN00AS|MN00AU|MN00AT|MN00AV|MN00AW|MN00AX|MN00AZ|MN00B0|MN00B1|MN00B6|MN00B7|MN00B8|MN00D1|MN00D2|MN00D3|MN0045|MN00EJ|MN00DN|MN006J|MN004F|MN004O|MN0077|MN008W');
INSERT INTO `permission_role` VALUES ('PR000A', '营销推广管理', 'EN0030', '1', 'MN0001|MN0006|MN004Y|MN009B|MN000F|MN0038|MN0067|MN002Q|MN0056|MN002S|MN002R|MN0035|MN0036|MN0037|MN003H|MN003W|MN00BR|MN00BS|MN0059|MN007O|MN007P|MN0045|MN00EJ|MN00DN|MN002B|MN00D0|MN005D|MN005E|MN008V|MN005G|MN005H|MN009Q|MN005I|MN005J|MN005K|MN005L|MN008P|MN005M|MN008O');
INSERT INTO `permission_role` VALUES ('PR000B', '技术', 'EN0030', '1', 'MN0002|MN0005|MN004Q|MN000T|MN009F|MN005W|MN0095|MN00B4|MN00B9|MN00E3|MN000E|MN001Y|MN006C|MN009G|MN001Z|MN002T|MN009D|MN00EE|MN00EF|MN00EG|MN00EH|MN00EI|MN00BF|MN00BG|MN00BH|MN00BJ|MN00BI|MN00BK|MN00CD|MN00CE|MN00CF|MN00CG|MN00CP|MN00CQ|MN00CR|MN001A|MN0008|MN00E5|MN00E6|MN00E9|MN00E7|MN00EA|MN00E8|MN008N|MN00AY|MN00B2|MN00B3');
INSERT INTO `permission_role` VALUES ('PR000C', '客服', 'EN003X', '1', 'MN0002|MN0005|MN004Q|MN000T|MN009F|MN004W|MN005Z|MN007V|MN008Q|MN008R|MN00DU|MN00A7|MN00A8|MN00E1|MN00E4|MN000C|MN001U|MN00CQ|MN000N|MN0022|MN003J|MN003K|MN0023|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003I|MN007U|MN003X|MN00BA|MN00BB|MN00BC|MN004X|MN0052|MN00C7|MN00C8|MN00C9|MN00AH|MN0054|MN0058|MN00DW|MN0053|MN0055|MN005B|MN0003|MN00CK|MN004D|MN007W|MN007X|MN005N|MN005P|MN00CM|MN00CN|MN004H|MN004J|MN0079|MN007A|MN004L|MN0078|MN0001|MN0006|MN004Z|MN000F|MN0038|MN0039|MN0011|MN0029|MN003B|MN00CL|MN00DP|MN00DQ|MN00EB|MN00EC|MN00AR|MN00AS|MN00AU|MN00AT|MN00AV|MN00AW|MN00AX|MN00AZ|MN00B0|MN00B1|MN00B6|MN00B7|MN00B8|MN00D3|MN0045|MN00EJ|MN00DN|MN0046|MN0048|MN004A|MN00C0|MN00D6|MN00D7|MN00D8|MN00DA|MN005C|MN002B|MN00D0|MN005D|MN005E|MN008V|MN005G|MN005H|MN009Q|MN005I|MN005J|MN005K|MN005L|MN008P|MN005M|MN008O');
INSERT INTO `permission_role` VALUES ('PR000D', '客服组长', 'EN003X', '1', 'MN0002|MN0005|MN004W|MN005Z|MN007V|MN008Q|MN008R|MN00DU|MN00A7|MN00A8|MN00E1|MN00E4|MN00D4|MN00D5|MN000C|MN001U|MN0051|MN007H|MN007I|MN00CQ|MN00CR|MN000N|MN0022|MN003J|MN003K|MN0023|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003I|MN007U|MN003X|MN00BA|MN00BB|MN00BC|MN004X|MN0052|MN00C7|MN00C8|MN00C9|MN00AH|MN0054|MN0058|MN00DW|MN0053|MN0055|MN005B|MN0003|MN00CK|MN004D|MN007W|MN007X|MN005N|MN005P|MN00CM|MN00CN|MN004H|MN004J|MN0079|MN007A|MN004L|MN0078|MN0001|MN0006|MN004Z|MN000F|MN0038|MN0039|MN0011|MN0029|MN003B|MN00CL|MN00DP|MN00DQ|MN00EB|MN00EC|MN00AR|MN00AS|MN00AU|MN00AT|MN00AV|MN00AW|MN00AX|MN00AZ|MN00B0|MN00B1|MN00B6|MN00B7|MN00B8|MN00D3|MN0045|MN00EJ|MN00DN|MN0046|MN0048|MN004A|MN00C0|MN00D6|MN00D7|MN00D8|MN00DA|MN005C|MN002B|MN00D0|MN005D|MN005E|MN008V|MN005G|MN005H|MN009Q|MN005I|MN005J|MN005K|MN005L|MN008P|MN005M|MN008O');
INSERT INTO `permission_role` VALUES ('PR000E', '风控', 'EN003X', '1', 'MN0002|MN0005|MN00AO|MN009A|MN004Q|MN000T|MN009F|MN0095|MN00B4|MN00E3|MN000E|MN001Y|MN006C|MN009G|MN001Z|MN002T|MN009D|MN00A6|MN004W|MN005X|MN005Y|MN005Z|MN0060|MN007V|MN008Q|MN008R|MN00DU|MN009M|MN008S|MN00A7|MN00A8|MN00AE|MN00CT|MN00E1|MN00E4|MN00D4|MN00D5|MN000C|MN001U|MN000L|MN001S|MN006H|MN001T|MN009K|MN00EE|MN00EF|MN00EG|MN00EH|MN00EI|MN0051|MN007E|MN007F|MN007H|MN007S|MN007I|MN00BP|MN00BQ|MN00BF|MN00BG|MN00BH|MN00BJ|MN00BI|MN00BK|MN00BL|MN00BM|MN00BN|MN00BO|MN00CD|MN00CE|MN00CF|MN00CG|MN00CQ|MN00CR|MN00EK|MN000N|MN0040|MN0041|MN006I|MN0042|MN0022|MN0069|MN003J|MN003K|MN0023|MN006A|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003I|MN007U|MN003X|MN00BA|MN00BB|MN00BC|MN004X|MN0052|MN00C7|MN00C8|MN00C9|MN00AH|MN0054|MN0058|MN00DW|MN0053|MN0055|MN005B|MN0003|MN00CK|MN004D|MN007W|MN007X|MN005N|MN005P|MN00CM|MN00CN|MN004H|MN004J|MN0079|MN007A|MN004L|MN0078');
INSERT INTO `permission_role` VALUES ('PR000F', '品牌运营CEO', 'EN0040', '1', 'MN0002|MN0005|MN00AO|MN009A|MN004Q|MN000T|MN009F|MN0095|MN00B4|MN00E3|MN000E|MN001Y|MN002T|MN009D|MN00A6|MN004W|MN005X|MN005Y|MN005Z|MN0060|MN007V|MN008Q|MN008R|MN00DU|MN009M|MN008S|MN00A7|MN00A8|MN00AE|MN00CT|MN00E1|MN00E4|MN00D4|MN00D5|MN000C|MN001U|MN000L|MN001S|MN006H|MN001T|MN009K|MN00EE|MN00EF|MN00EG|MN00EH|MN00EI|MN0051|MN007E|MN007F|MN007G|MN007H|MN007S|MN007I|MN00BP|MN00BQ|MN00BF|MN00BG|MN00BH|MN00BJ|MN00BI|MN00BK|MN00BL|MN00BM|MN00BN|MN00BO|MN00CD|MN00CE|MN00CF|MN00CG|MN00CQ|MN00CR|MN00EK|MN000N|MN0040|MN0041|MN006I|MN0042|MN0022|MN0069|MN003J|MN003K|MN0023|MN006A|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003I|MN007U|MN003X|MN00BA|MN00BB|MN00BC|MN004X|MN0052|MN00C7|MN00C8|MN00C9|MN00AH|MN0054|MN0058|MN00EP|MN00DW|MN0053|MN0055|MN005B|MN00CU|MN00CV|MN00CW|MN00CX|MN00CY|MN00CZ|MN0003|MN00CK|MN004D|MN007W|MN007X|MN005N|MN005P|MN00CM|MN00CN|MN00EM|MN004H|MN004J|MN0079|MN007A|MN004L|MN0078|MN0001|MN0006|MN004Y|MN009B|MN004Z|MN00AD|MN00AL|MN00AM|MN00AN|MN00AP|MN000F|MN0038|MN000Z|MN0039|MN0011|MN003A|MN0067|MN00A9|MN00AA|MN00DS|MN00BD|MN00DT|MN00E2|MN0029|MN003B|MN003C|MN003D|MN003E|MN003F|MN003G|MN0068|MN008X|MN00AB|MN00AC|MN00BE|MN00CL|MN00DP|MN00DQ|MN00EB|MN00EC|MN002Q|MN0056|MN002S|MN002R|MN0035|MN0036|MN0037|MN003H|MN003W|MN00BR|MN00BS|MN00A0|MN00A5|MN00BT|MN00BU|MN0044|MN007B|MN00DE|MN0059|MN007O|MN007P|MN00CH|MN00CI|MN00CJ|MN00AR|MN00AS|MN00AU|MN00AT|MN00AV|MN00AW|MN00AX|MN00AZ|MN00B0|MN00B1|MN00B6|MN00B7|MN00B8|MN00D1|MN00D2|MN00EO|MN00D3|MN0045|MN00EJ|MN00DN|MN0046|MN005C|MN002B|MN00D0|MN005D|MN005E|MN008V|MN005G|MN005H|MN009Q|MN005I|MN005J|MN005K|MN005L|MN008P|MN005M|MN008O|MN006J|MN000P|MN004E|MN004F|MN004G|MN004O|MN0077|MN008W|MN001A|MN001E|MN001J|MN001K|MN001L|MN001M|MN003T|MN003U|MN001N|MN001P|MN001Q|MN001R|MN003V|MN003Y|MN009C|MN0094|MN0097|MN009E|MN0098|MN0099|MN009R|MN009T|MN009U|MN009V|MN007Y|MN007Z|MN008A|MN008B|MN008C|MN008D|MN00DR|MN008E|MN00EV|MN0008|MN00E5|MN00E6|MN00E9|MN00E7|MN00EA|MN00E8|MN008N|MN00AY|MN00B2|MN00B3');
INSERT INTO `permission_role` VALUES ('PR000G', '客服角色', 'EN0040', '1', 'MN0002|MN0005|MN009A|MN00A6|MN004W|MN005X|MN005Z|MN0060|MN007V|MN008Q|MN00DU|MN00A7|MN00A8|MN00AE|MN00CT|MN00E1|MN00E4|MN00D4|MN00D5|MN000C|MN001U|MN000L|MN00EE|MN00EI|MN0051|MN007E|MN007H|MN007I|MN00BQ|MN00BF|MN00BG|MN00BJ|MN00CD|MN00CE|MN00CF|MN00CG|MN00CQ|MN00CR|MN00EK|MN000N|MN0040|MN0041|MN0022|MN0069|MN003J|MN0023|MN006A|MN003L|MN0082|MN0089|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003X|MN00BA|MN00BB|MN00BC|MN004X|MN00AH|MN0053|MN005B|MN00CU|MN00CX|MN00CY|MN0003|MN00CK|MN004D|MN007W|MN007X|MN005N|MN005P|MN00CM|MN00CN|MN00EM|MN004H|MN004J|MN0079|MN007A|MN004L|MN0078|MN0001|MN0006|MN00CL|MN002Q|MN00CH|MN00CI|MN00CJ|MN00AR|MN00AS|MN00AU|MN00AT|MN00AV|MN00AW|MN00AX|MN00AZ|MN00B0|MN00B1|MN00B6|MN00B7|MN00B8|MN00D1|MN00D2|MN00EO|MN00D3|MN0045|MN00EJ|MN00DN|MN0046|MN005C|MN002B|MN00D0|MN005D|MN005E|MN008V|MN005G|MN005H|MN009Q|MN005I|MN005J|MN005K|MN005L|MN008P|MN005M|MN008O|MN006J|MN000P|MN004E|MN004F|MN004G|MN004O|MN0077|MN008W|MN001A|MN009C|MN0094|MN0097|MN009R|MN009T|MN007Y|MN007Z|MN008A');
INSERT INTO `permission_role` VALUES ('PR000H', '财务角色', 'EN0040', '1', 'MN0002|MN0005|MN004W|MN005Z|MN007V|MN00E1|MN000C|MN001U|MN000L|MN009K|MN00EE|MN00EF|MN00EI|MN0051|MN007E|MN007H|MN007S|MN007I|MN00BQ|MN00BF|MN00BG|MN00BH|MN00BJ|MN00EK|MN000N|MN0040|MN0041|MN006I|MN0042|MN0022|MN0069|MN003J|MN003K|MN0023|MN006A|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003X|MN00BA|MN00BB|MN00BC|MN004X|MN0052|MN00C7|MN00C8|MN00C9|MN00AH|MN0054|MN0058|MN00EP|MN00DW|MN0053|MN0055|MN005B|MN00CU|MN00CV|MN00CW|MN00CX|MN00CY|MN00CZ|MN0001|MN0006|MN00CL|MN002Q|MN00CH|MN00CI|MN00CJ|MN00AR|MN00AS|MN00AU|MN00AT|MN00AV|MN00AW|MN00AX|MN00AZ|MN00B0|MN00B1|MN00B6|MN00B7|MN00B8|MN00D1|MN00D2|MN00EO|MN00D3|MN0045|MN00EJ|MN00DN|MN0046|MN005C');
INSERT INTO `permission_role` VALUES ('PR000I', '代理角色', 'EN0040', '1', 'MN0001|MN0006|MN004Y|MN009B|MN004Z|MN00AD|MN00AL|MN00AM|MN00AN|MN00AP|MN000F|MN0038|MN0011|MN003A|MN0067|MN00DS|MN00BD|MN00DT|MN0029|MN003B|MN003D|MN003F|MN003G|MN0068|MN008X|MN00BE|MN00CL|MN002Q|MN002S|MN002R|MN0035|MN0036|MN0037|MN003H|MN003W|MN00BR|MN00BS|MN00A0|MN00A5|MN00BT|MN00BU|MN0044|MN007B|MN00AR|MN00D1|MN00D2|MN00EO|MN00D3|MN0045|MN00EJ|MN00DN|MN0046|MN005C|MN002B|MN005M');
INSERT INTO `permission_role` VALUES ('PR000J', '[克隆] 代理角色', 'EN0040', '-1', 'MN0001|MN0006|MN004Y|MN009B|MN004Z|MN00AD|MN00AL|MN00AM|MN00AN|MN00AP|MN000F|MN0038|MN0011|MN003A|MN0067|MN00DS|MN00BD|MN00DT|MN0029|MN003B|MN003D|MN003F|MN003G|MN0068|MN008X|MN00BE|MN00CL|MN002Q|MN002S|MN002R|MN0035|MN0036|MN0037|MN003H|MN003W|MN00BR|MN00BS|MN00A0|MN00A5|MN00BT|MN00BU|MN0044|MN007B|MN00AR|MN00D1|MN00D2|MN00EO|MN00D3|MN0045|MN00EJ|MN00DN|MN0046|MN005C|MN002B|MN005M');
INSERT INTO `permission_role` VALUES ('PR000K', '运营COO', 'EN0041', '1', 'MN0002|MN0005|MN00FB|MN00AO|MN009A|MN004Q|MN000T|MN009F|MN0095|MN00B4|MN00E3|MN000E|MN001Y|MN002T|MN009D|MN00A6|MN004W|MN005X|MN005Y|MN005Z|MN0060|MN007V|MN008Q|MN008R|MN00DU|MN009M|MN008S|MN00A7|MN00A8|MN00AE|MN00CT|MN00E1|MN00E4|MN00D4|MN00D5|MN000C|MN001U|MN000L|MN001S|MN006H|MN001T|MN009K|MN00EE|MN00EF|MN00EG|MN00EH|MN00EI|MN0051|MN007E|MN007F|MN007G|MN007H|MN007S|MN007I|MN00BP|MN00BQ|MN00BF|MN00BG|MN00BH|MN00BJ|MN00BI|MN00BK|MN00CD|MN00CE|MN00CF|MN00CG|MN00CQ|MN00CR|MN00EK|MN000N|MN0040|MN0041|MN006I|MN0042|MN0022|MN0069|MN003J|MN003K|MN0023|MN006A|MN003L|MN003M|MN0082|MN0089|MN009H|MN009I|MN009J|MN000O|MN003P|MN003Q|MN0019|MN003R|MN003S|MN000G|MN003I|MN007U|MN003X|MN00BA|MN00BB|MN00BC|MN004X|MN0052|MN00C7|MN00C8|MN00C9|MN00AH|MN0054|MN0058|MN00EP|MN00DW|MN0053|MN0055|MN005B|MN00CU|MN00CV|MN00CW|MN00CX|MN00CY|MN00CZ|MN0003|MN00CK|MN004D|MN007W|MN007X|MN005N|MN005P|MN00CM|MN00CN|MN00EM|MN004H|MN004J|MN0079|MN007A|MN004L|MN0078|MN0001|MN0006|MN004Y|MN009B|MN004Z|MN00AD|MN00AL|MN00AM|MN00AN|MN00AP|MN000F|MN0038|MN000Z|MN0039|MN0011|MN003A|MN0067|MN00A9|MN00AA|MN00DS|MN00BD|MN00DT|MN00E2|MN0029|MN003B|MN003C|MN003D|MN003E|MN003F|MN003G|MN0068|MN008X|MN00AB|MN00AC|MN00BE|MN00CL|MN00F0|MN00DP|MN00DQ|MN00EB|MN00EC|MN002Q|MN0056|MN002S|MN002R|MN0035|MN0036|MN0037|MN003H|MN003W|MN00BR|MN00BS|MN00A0|MN00A5|MN00BT|MN00BU|MN0044|MN007B|MN00DE|MN00F1|MN00F3|MN00F4|MN00F5|MN00F2|MN00F6|MN00F7|MN00F8|MN0059|MN007O|MN007P|MN00CH|MN00CI|MN00CJ|MN00AR|MN00AS|MN00AU|MN00AT|MN00EW|MN00AV|MN00AW|MN00AX|MN00EX|MN00D1|MN00D2|MN00EO|MN00D3|MN0045|MN00EJ|MN00DN|MN00CB|MN005C|MN002B|MN00D0|MN005D|MN005E|MN008V|MN005G|MN005H|MN009Q|MN005I|MN005J|MN005K|MN005L|MN008P|MN005M|MN008O|MN006J|MN000P|MN004E|MN004F|MN004G|MN004O|MN0077|MN008W|MN001A|MN001E|MN001J|MN001K|MN001L|MN001M|MN003T|MN003U|MN001N|MN001P|MN001Q|MN001R|MN003V|MN003Y|MN009C|MN0094|MN0097|MN009E|MN0098|MN0099|MN009R|MN009T|MN009U|MN009V|MN009X|MN007Y|MN007Z|MN008A|MN008B|MN008C|MN008D|MN00DR|MN008E|MN00EV|MN0008|MN008N|MN00AY|MN00B2|MN00B3');

-- ----------------------------
-- Table structure for platform_api_output
-- ----------------------------
DROP TABLE IF EXISTS `platform_api_output`;
CREATE TABLE `platform_api_output` (
  `outputapicode` char(32) COLLATE utf8_bin NOT NULL COMMENT '输出接口编码',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `outputapiurl` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '接口地址',
  `outputapistatus` tinyint(4) NOT NULL DEFAULT '1' COMMENT '接口状态 1.可用 0.不可用',
  `apikey1` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'aesKey ',
  `apikey2` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'md5Key',
  `apiuser` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '接口用户',
  `apipassword` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '接口用户密码',
  `apicomment` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '接口备注',
  PRIMARY KEY (`outputapicode`),
  KEY `FK_platform_api_output_enterprise_enterprisecode` (`enterprisecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='平台输出接口';

-- ----------------------------
-- Records of platform_api_output
-- ----------------------------

-- ----------------------------
-- Table structure for private_data_access
-- ----------------------------
DROP TABLE IF EXISTS `private_data_access`;
CREATE TABLE `private_data_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisecode` char(6) COLLATE utf8_bin DEFAULT NULL COMMENT '企业编码',
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '员工编码',
  PRIMARY KEY (`id`),
  KEY `FK_private_data_access_enterprise_employee_employeecode` (`employeecode`) USING BTREE,
  KEY `FK_private_data_access_enterprise_enterprisecode` (`enterprisecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='隐私数据权限控制';

-- ----------------------------
-- Records of private_data_access
-- ----------------------------

-- ----------------------------
-- Table structure for report_daily_agent
-- ----------------------------
DROP TABLE IF EXISTS `report_daily_agent`;
CREATE TABLE `report_daily_agent` (
  `reportcode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT ' 上级员工编码',
  `loginaccount` varchar(12) COLLATE utf8_bin NOT NULL COMMENT '用户账户',
  `bet` decimal(16,2) NOT NULL COMMENT '投注量',
  `amount` decimal(16,2) NOT NULL COMMENT '打码金额',
  `ratio` decimal(16,4) NOT NULL COMMENT '打码比率',
  `time` datetime NOT NULL COMMENT '打码日期',
  `reporttime` datetime NOT NULL COMMENT '报表日期',
  `gameplatform` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '游戏平台',
  `gametype` varchar(8) COLLATE utf8_bin NOT NULL COMMENT '游戏类型',
  `status` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '打码发放状态(0：未发放 1：已发放 2：周结汇总)',
  `is_weekly_agent` tinyint(1) DEFAULT '0',
  `payno` varchar(19) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`reportcode`),
  KEY `FK_daily_report_agent_brandcode` (`brandcode`) USING BTREE,
  KEY `FK_daily_report_agent_employeecode` (`employeecode`) USING BTREE,
  KEY `FK_daily_report_agent_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `FK_daily_report_agent_parentemployeecode` (`parentemployeecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7800 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='代理日结打码报表';

-- ----------------------------
-- Records of report_daily_agent
-- ----------------------------

-- ----------------------------
-- Table structure for report_daily_member
-- ----------------------------
DROP TABLE IF EXISTS `report_daily_member`;
CREATE TABLE `report_daily_member` (
  `reportcode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT ' 上级员工编码',
  `loginaccount` varchar(12) COLLATE utf8_bin NOT NULL COMMENT '用户账户',
  `bet` decimal(16,2) NOT NULL COMMENT '投注量',
  `amount` decimal(16,2) NOT NULL COMMENT '打码金额',
  `ratio` decimal(3,3) NOT NULL COMMENT '打码比率',
  `time` datetime NOT NULL COMMENT '打码日期',
  `reporttime` datetime NOT NULL COMMENT '报表日期',
  `gametype` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '游戏类型',
  `status` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '打码发放状态',
  `payno` varchar(19) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`reportcode`),
  KEY `FK_daily_report_player_employeecode` (`employeecode`) USING BTREE,
  KEY `FK_daily_report_player_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `FK_daily_report_player_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `FK_daily_report_player_brandcode` (`brandcode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='玩家日结打码报表';

-- ----------------------------
-- Records of report_daily_member
-- ----------------------------

-- ----------------------------
-- Table structure for report_weekly_agent
-- ----------------------------
DROP TABLE IF EXISTS `report_weekly_agent`;
CREATE TABLE `report_weekly_agent` (
  `reportcode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT ' 上级员工编码',
  `loginaccount` varchar(12) COLLATE utf8_bin NOT NULL COMMENT '用户账户',
  `bet` decimal(16,2) NOT NULL COMMENT '投注量',
  `amount` decimal(16,2) NOT NULL COMMENT '打码金额',
  `subtract` decimal(16,2) NOT NULL COMMENT '需要减去的已发放金额',
  `ratio` decimal(16,4) NOT NULL COMMENT '打码比率',
  `starttime` datetime NOT NULL COMMENT '打码开始日期',
  `endtime` datetime NOT NULL COMMENT '打码结束日期',
  `reporttime` datetime NOT NULL COMMENT '报表日期',
  `gameplatform` varchar(10) COLLATE utf8_bin NOT NULL,
  `gametype` varchar(8) COLLATE utf8_bin NOT NULL COMMENT '游戏类型',
  `status` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '打码发放状态 1未发放 2已发放',
  `paytype` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '业务类型 1正常 2补发',
  `patchno` varchar(36) COLLATE utf8_bin NOT NULL COMMENT '批次号，同一组数据的唯一编码，包括：员工编码、游戏平台、游戏类型、报表开始时间',
  `actual` decimal(16,2) DEFAULT '0.00',
  `payno` varchar(19) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`reportcode`),
  KEY `FK_weekly_report_T004_employeecode` (`employeecode`) USING BTREE,
  KEY `FK_weekly_report_T004_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `FK_weekly_report_T004_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `FK_weekly_report_T004_brandcode` (`brandcode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2718 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='代理周结打码报表';

-- ----------------------------
-- Records of report_weekly_agent
-- ----------------------------

-- ----------------------------
-- Table structure for report_weekly_member
-- ----------------------------
DROP TABLE IF EXISTS `report_weekly_member`;
CREATE TABLE `report_weekly_member` (
  `reportcode` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `employeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT ' 上级员工编码',
  `loginaccount` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '用户账户',
  `bet` decimal(16,2) NOT NULL COMMENT '投注量',
  `amount` decimal(16,2) NOT NULL COMMENT '打码金额',
  `subtract` decimal(16,2) NOT NULL COMMENT '需要减去的已发放金额',
  `ratio` decimal(3,3) NOT NULL COMMENT '打码比率',
  `starttime` datetime NOT NULL COMMENT '打码开始日期',
  `endtime` datetime NOT NULL COMMENT '打码开始日期',
  `reporttime` datetime NOT NULL COMMENT '报表日期',
  `gameplatform` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏平台',
  `gametype` varchar(8) COLLATE utf8_bin NOT NULL COMMENT '游戏类型',
  `status` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '打码发放状态',
  `paytype` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1',
  `patchno` varchar(36) COLLATE utf8_bin NOT NULL,
  `actual` decimal(16,2) DEFAULT '0.00',
  `payno` varchar(19) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`reportcode`),
  KEY `FK_report_weekly_T003_employeecode` (`employeecode`) USING BTREE,
  KEY `FK_report_weekly_T003_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `FK_report_weekly_T003_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `FK_report_weekly_T003_brandcode` (`brandcode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='玩家周结打码报表';

-- ----------------------------
-- Records of report_weekly_member
-- ----------------------------

-- ----------------------------
-- Table structure for table_pk_seed
-- ----------------------------
DROP TABLE IF EXISTS `table_pk_seed`;
CREATE TABLE `table_pk_seed` (
  `tablename` varchar(128) COLLATE utf8_bin NOT NULL,
  `performancefactor` tinyint(4) NOT NULL DEFAULT '0' COMMENT '在写入要求很高的表中，用于分割字符主键生成范围，这时采取随机生成',
  `seed` varchar(16) COLLATE utf8_bin NOT NULL,
  `codeprefix` varchar(8) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`tablename`,`performancefactor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of table_pk_seed
-- ----------------------------
INSERT INTO `table_pk_seed` VALUES ('deposit_withdraw_order', '0', '00000', 'ETD');
INSERT INTO `table_pk_seed` VALUES ('enterprise', '0', '0043', 'EN');
INSERT INTO `table_pk_seed` VALUES ('enterprise_brand_notic', '0', '000000008Z', 'NT');
INSERT INTO `table_pk_seed` VALUES ('enterprise_employee', '0', '000K4LA', 'E');
INSERT INTO `table_pk_seed` VALUES ('enterprise_employee_information', '0', '00SR0', 'EEI');
INSERT INTO `table_pk_seed` VALUES ('enterprise_employee_level', '0', '0040', '');
INSERT INTO `table_pk_seed` VALUES ('enterprise_employee_type', '0', '01K', 'T');
INSERT INTO `table_pk_seed` VALUES ('enterprise_information', '0', '00004I', 'EI');
INSERT INTO `table_pk_seed` VALUES ('enterprise_operating_brand', '0', '0000BQ', 'EB');
INSERT INTO `table_pk_seed` VALUES ('enterprise_thirdparty_payment', '0', '00007R', 'EP');
INSERT INTO `table_pk_seed` VALUES ('game', '0', '00M', 'G');
INSERT INTO `table_pk_seed` VALUES ('game_api_input', '0', '00002G', 'GM');
INSERT INTO `table_pk_seed` VALUES ('payment_type', '0', '08', 'PM');
INSERT INTO `table_pk_seed` VALUES ('permission_menu', '0', '00A0', 'MN');
INSERT INTO `table_pk_seed` VALUES ('third_party_payment', '0', '004', 'P');
INSERT INTO `table_pk_seed` VALUES ('third_party_payment_setting', '0', '014', 'PS');
INSERT INTO `table_pk_seed` VALUES ('user_money_in_and_out', '0', '0000000003EAR', 'ACC');
INSERT INTO `table_pk_seed` VALUES ('working_flow_configuration', '0', '00004L', 'WF');
INSERT INTO `table_pk_seed` VALUES ('webview_template', '0', '001F', 'WT');
INSERT INTO `table_pk_seed` VALUES ('enterprise_brand_contact', '0', '00000052', 'CT');
INSERT INTO `table_pk_seed` VALUES ('permission_role', '0', '000K', 'PR');

-- ----------------------------
-- Table structure for test_ggp
-- ----------------------------
DROP TABLE IF EXISTS `test_ggp`;
CREATE TABLE `test_ggp` (
  `user_id` varchar(255) NOT NULL DEFAULT '',
  `site_user_id` varchar(255) NOT NULL,
  `balance` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test_ggp
-- ----------------------------
INSERT INTO `test_ggp` VALUES ('111', 'egg123', '0.15');
INSERT INTO `test_ggp` VALUES ('114', 'eggbiyang110', '0.14');
INSERT INTO `test_ggp` VALUES ('11730', 'harrytao', '0.07');
INSERT INTO `test_ggp` VALUES ('11928', 'cd1998', '11.3');
INSERT INTO `test_ggp` VALUES ('12308', 'xw9777', '0.12');
INSERT INTO `test_ggp` VALUES ('12647', 'm50691379', '26.65');
INSERT INTO `test_ggp` VALUES ('12705', 'dmr520', '1.89');
INSERT INTO `test_ggp` VALUES ('12917', 'tongwei8', '0.07');
INSERT INTO `test_ggp` VALUES ('13255', 'z344078218', '0.12');
INSERT INTO `test_ggp` VALUES ('13280', 'zhouhong', '0.08');
INSERT INTO `test_ggp` VALUES ('13913', 'x1335346', '0.08');
INSERT INTO `test_ggp` VALUES ('14025', 'yoki0425', '0.49');
INSERT INTO `test_ggp` VALUES ('14086', 'kimmywong', '0.14');
INSERT INTO `test_ggp` VALUES ('14179', 'superking', '0.09');
INSERT INTO `test_ggp` VALUES ('14355', 'luckyjoo', '0.07');
INSERT INTO `test_ggp` VALUES ('14375', 'yangjing', '0.25');
INSERT INTO `test_ggp` VALUES ('14422', 'liyunjv', '0.08');
INSERT INTO `test_ggp` VALUES ('14548', 'erlang1218', '0.79');
INSERT INTO `test_ggp` VALUES ('14549', 'oscargogo', '0.44');
INSERT INTO `test_ggp` VALUES ('14554', 'hanxiao', '0.28');
INSERT INTO `test_ggp` VALUES ('14674', 'dujiang85', '0.08');
INSERT INTO `test_ggp` VALUES ('14737', 'eggcs12345', '0.37');
INSERT INTO `test_ggp` VALUES ('14822', 'zhuke918', '4.07');
INSERT INTO `test_ggp` VALUES ('14859', 'liu0721', '0.4');
INSERT INTO `test_ggp` VALUES ('14889', 'rao723', '0.01');
INSERT INTO `test_ggp` VALUES ('14945', 'ljl0190', '0.07');
INSERT INTO `test_ggp` VALUES ('14983', 'yu2004', '0.08');
INSERT INTO `test_ggp` VALUES ('15010', 'michelle99', '0.49');
INSERT INTO `test_ggp` VALUES ('15032', 'zy668833', '0.36');
INSERT INTO `test_ggp` VALUES ('15036', 'alrick', '0.07');
INSERT INTO `test_ggp` VALUES ('15037', 'cheriet9', '0.07');
INSERT INTO `test_ggp` VALUES ('15042', 'mandyli9', '0.22');
INSERT INTO `test_ggp` VALUES ('15049', 'ym1314', '0.01');
INSERT INTO `test_ggp` VALUES ('15052', 'timmychan', '0.21');
INSERT INTO `test_ggp` VALUES ('15071', 'chriswong', '0.07');
INSERT INTO `test_ggp` VALUES ('15072', 'alanw288', '0.07');
INSERT INTO `test_ggp` VALUES ('15073', 'akqueen', '0.83');
INSERT INTO `test_ggp` VALUES ('15082', 'winningaa', '0.07');
INSERT INTO `test_ggp` VALUES ('15083', 'yokingan', '0.25');
INSERT INTO `test_ggp` VALUES ('15136', 'zy88988', '0.51');
INSERT INTO `test_ggp` VALUES ('15153', 'hg1988', '1.73');
INSERT INTO `test_ggp` VALUES ('15208', 'kszz036', '0.07');
INSERT INTO `test_ggp` VALUES ('15340', 'jd112258', '0.18');
INSERT INTO `test_ggp` VALUES ('15341', 'nice1989', '0.07');
INSERT INTO `test_ggp` VALUES ('15430', 'dashen888', '0.26');
INSERT INTO `test_ggp` VALUES ('15455', 'ts8068', '0.01');
INSERT INTO `test_ggp` VALUES ('15464', 'wongks', '0.02');
INSERT INTO `test_ggp` VALUES ('15529', 'wzf6089', '1.23');
INSERT INTO `test_ggp` VALUES ('15533', 'q414676879', '1.12');
INSERT INTO `test_ggp` VALUES ('15556', 'zhang32914', '0.11');
INSERT INTO `test_ggp` VALUES ('15562', 'aqliang8', '0.04');
INSERT INTO `test_ggp` VALUES ('15578', 'hjj168', '0.07');
INSERT INTO `test_ggp` VALUES ('15601', 'yuanyuanai', '1.31');
INSERT INTO `test_ggp` VALUES ('15602', 'luokai1219', '0.08');
INSERT INTO `test_ggp` VALUES ('15603', 'zhengrye', '1.29');
INSERT INTO `test_ggp` VALUES ('15619', 'wutiang', '0.55');
INSERT INTO `test_ggp` VALUES ('15713', 'fzlhlh', '0.18');
INSERT INTO `test_ggp` VALUES ('15717', 'cpt2128119', '0.29');
INSERT INTO `test_ggp` VALUES ('15728', 'tcaijy', '0.07');
INSERT INTO `test_ggp` VALUES ('15804', 'zuocheng', '0.01');
INSERT INTO `test_ggp` VALUES ('15809', 'df007andy', '0.07');
INSERT INTO `test_ggp` VALUES ('15811', 'manutd', '0.07');
INSERT INTO `test_ggp` VALUES ('15962', 'vip818a', '0.08');
INSERT INTO `test_ggp` VALUES ('15966', 'rnm123', '4.05');
INSERT INTO `test_ggp` VALUES ('15980', 'ouyang0915', '0.07');
INSERT INTO `test_ggp` VALUES ('15982', 'goldgogo', '0.08');
INSERT INTO `test_ggp` VALUES ('15983', '133gao', '0.14');
INSERT INTO `test_ggp` VALUES ('15987', 'doublekill', '0.59');
INSERT INTO `test_ggp` VALUES ('15992', 'yy345678', '0.03');
INSERT INTO `test_ggp` VALUES ('16083', 'fakerasie', '0.07');
INSERT INTO `test_ggp` VALUES ('16112', 'playerwin', '0.46');
INSERT INTO `test_ggp` VALUES ('16123', 'fakefold', '0.35');
INSERT INTO `test_ggp` VALUES ('16127', 'hg673519', '0.32');
INSERT INTO `test_ggp` VALUES ('16157', 'ouyang1', '1.01');
INSERT INTO `test_ggp` VALUES ('16161', 'damaged18', '0.07');
INSERT INTO `test_ggp` VALUES ('16162', 'goodplayer', '0.55');
INSERT INTO `test_ggp` VALUES ('16274', 'cao8686', '0.15');
INSERT INTO `test_ggp` VALUES ('16277', 'ke0712', '0.08');
INSERT INTO `test_ggp` VALUES ('16288', 'hardwin', '0.67');
INSERT INTO `test_ggp` VALUES ('16297', 'jumpshoot', '0.89');
INSERT INTO `test_ggp` VALUES ('16323', 'hatepoker', '0.07');
INSERT INTO `test_ggp` VALUES ('16420', 'startv', '0.21');
INSERT INTO `test_ggp` VALUES ('16421', 'dyychh', '0.08');
INSERT INTO `test_ggp` VALUES ('16422', 'aj212324', '0.8');
INSERT INTO `test_ggp` VALUES ('16431', 'fthhty', '0.15');
INSERT INTO `test_ggp` VALUES ('16432', 'dingyong', '0.35');
INSERT INTO `test_ggp` VALUES ('16446', 'woshixing', '0.01');
INSERT INTO `test_ggp` VALUES ('16448', 'dwckty', '0.05');
INSERT INTO `test_ggp` VALUES ('16699', 'skyline', '0.07');
INSERT INTO `test_ggp` VALUES ('16877', 'addressc', '0.08');
INSERT INTO `test_ggp` VALUES ('16898', 'tree0123', '0.23');
INSERT INTO `test_ggp` VALUES ('16923', 'may78910', '2.2');
INSERT INTO `test_ggp` VALUES ('16978', 'aa3210', '0.01');
INSERT INTO `test_ggp` VALUES ('17005', 'john544', '1.08');
INSERT INTO `test_ggp` VALUES ('17113', 'mary566', '0.32');
INSERT INTO `test_ggp` VALUES ('17117', 'cheating', '0.15');
INSERT INTO `test_ggp` VALUES ('17228', 'kingdoma', '0.16');
INSERT INTO `test_ggp` VALUES ('17229', 'sim8686', '0.08');
INSERT INTO `test_ggp` VALUES ('17235', 'dutiesi', '0.14');
INSERT INTO `test_ggp` VALUES ('17236', 'what67', '0.85');
INSERT INTO `test_ggp` VALUES ('17243', 'where87', '0.15');
INSERT INTO `test_ggp` VALUES ('17253', 'fan369147', '0.12');
INSERT INTO `test_ggp` VALUES ('17255', 'joohoou', '0.53');
INSERT INTO `test_ggp` VALUES ('17257', 'eargee002', '0.08');
INSERT INTO `test_ggp` VALUES ('17258', 'hongking', '0.24');
INSERT INTO `test_ggp` VALUES ('17259', 'duilee345', '0.08');
INSERT INTO `test_ggp` VALUES ('17376', 'ahhtyu', '0.12');
INSERT INTO `test_ggp` VALUES ('17428', 'manyou4141', '0.08');
INSERT INTO `test_ggp` VALUES ('17632', 'eggcs8888', '0.08');
INSERT INTO `test_ggp` VALUES ('17715', 'tanlan1', '9.77');
INSERT INTO `test_ggp` VALUES ('17807', 'hbzpq1314', '4.49');
INSERT INTO `test_ggp` VALUES ('17987', 'lhqka888', '0.07');
INSERT INTO `test_ggp` VALUES ('18214', 'ci123456', '0.11');
INSERT INTO `test_ggp` VALUES ('18217', 'b123456', '0.12');
INSERT INTO `test_ggp` VALUES ('18243', 'di123456', '0.08');
INSERT INTO `test_ggp` VALUES ('18285', 'xi123456', '0.15');
INSERT INTO `test_ggp` VALUES ('18292', 'cs123456', '0.11');
INSERT INTO `test_ggp` VALUES ('18340', 'xx456789', '0.22');
INSERT INTO `test_ggp` VALUES ('18366', 'cc456789', '0.22');
INSERT INTO `test_ggp` VALUES ('18369', 'dp123456', '0.04');
INSERT INTO `test_ggp` VALUES ('18388', 'dd456789', '0.06');
INSERT INTO `test_ggp` VALUES ('18488', 'zxc987654', '0.07');
INSERT INTO `test_ggp` VALUES ('18512', 'tt123456', '0.15');
INSERT INTO `test_ggp` VALUES ('18519', 'nm456456', '4.08');
INSERT INTO `test_ggp` VALUES ('18534', 'pp456789', '0.08');
INSERT INTO `test_ggp` VALUES ('18566', 'az543345', '0.07');
INSERT INTO `test_ggp` VALUES ('18599', 'ff123456', '0.08');
INSERT INTO `test_ggp` VALUES ('18604', 'plm659823', '0.08');
INSERT INTO `test_ggp` VALUES ('18651', 'bb123456', '0.08');
INSERT INTO `test_ggp` VALUES ('18809', 'tt888999', '0.08');
INSERT INTO `test_ggp` VALUES ('18813', 'yyy888999', '0.15');
INSERT INTO `test_ggp` VALUES ('18867', 'zz456789', '0.25');
INSERT INTO `test_ggp` VALUES ('18869', 'zz888999', '0.05');
INSERT INTO `test_ggp` VALUES ('18901', 'gg456789', '0.08');
INSERT INTO `test_ggp` VALUES ('18905', 'gg8889999', '0.08');
INSERT INTO `test_ggp` VALUES ('18983', 'hh123123', '0.08');
INSERT INTO `test_ggp` VALUES ('19', 'egg2230', '0.14');
INSERT INTO `test_ggp` VALUES ('19007', 'ss456987', '0.08');
INSERT INTO `test_ggp` VALUES ('19029', 'cc741741', '0.08');
INSERT INTO `test_ggp` VALUES ('19053', 'yu852852', '0.08');
INSERT INTO `test_ggp` VALUES ('19059', 'tr456456', '0.08');
INSERT INTO `test_ggp` VALUES ('19060', 'tr789789', '0.08');
INSERT INTO `test_ggp` VALUES ('19072', 'df123123', '0.08');
INSERT INTO `test_ggp` VALUES ('19073', 'df456456', '0.08');
INSERT INTO `test_ggp` VALUES ('19093', 'x247157345', '1.94');
INSERT INTO `test_ggp` VALUES ('19142', 'fg123123', '0.08');
INSERT INTO `test_ggp` VALUES ('19402', 'qi123456', '4.08');
INSERT INTO `test_ggp` VALUES ('19510', 'za123456', '0.07');
INSERT INTO `test_ggp` VALUES ('19521', 'pl10001', '4.08');
INSERT INTO `test_ggp` VALUES ('19665', 'jy0014', '11.44');
INSERT INTO `test_ggp` VALUES ('19711', 'cs0001', '0.05');
INSERT INTO `test_ggp` VALUES ('19762', 'hy5982', '0.19');
INSERT INTO `test_ggp` VALUES ('19785', 'leilei1248', '0.07');
INSERT INTO `test_ggp` VALUES ('19877', '416064', '0.07');
INSERT INTO `test_ggp` VALUES ('19943', 'hou646421', '12.29');
INSERT INTO `test_ggp` VALUES ('19966', 'hxshowvip3', '6.21');
INSERT INTO `test_ggp` VALUES ('20024', 'a8917502', '0.08');
INSERT INTO `test_ggp` VALUES ('20041', 'baba123', '0.05');
INSERT INTO `test_ggp` VALUES ('20082', 'shuang8888', '0.76');
INSERT INTO `test_ggp` VALUES ('20097', 'wzm8888', '0.5');
INSERT INTO `test_ggp` VALUES ('20110', 'erica811', '0.12');
INSERT INTO `test_ggp` VALUES ('20137', 'niganma35', '8.08');
INSERT INTO `test_ggp` VALUES ('20145', 'luokk1', '0.16');
INSERT INTO `test_ggp` VALUES ('20155', 'liujk1990', '0.43');
INSERT INTO `test_ggp` VALUES ('20158', 'asd789789', '22.04');
INSERT INTO `test_ggp` VALUES ('20162', 'zxc147', '0.16');
INSERT INTO `test_ggp` VALUES ('20165', 'zhangyue', '0.25');
INSERT INTO `test_ggp` VALUES ('20166', 'zhang888', '0.27');
INSERT INTO `test_ggp` VALUES ('20171', 'zkk123', '4.08');
INSERT INTO `test_ggp` VALUES ('20206', 'dawangyu1', '0.08');
INSERT INTO `test_ggp` VALUES ('20249', 'my123321', '0.07');
INSERT INTO `test_ggp` VALUES ('20261', 'a38693866', '0.08');
INSERT INTO `test_ggp` VALUES ('20290', 'hl6717', '0.05');
INSERT INTO `test_ggp` VALUES ('20296', 'yanerwy', '0.07');
INSERT INTO `test_ggp` VALUES ('20302', 'hbx888', '0.07');
INSERT INTO `test_ggp` VALUES ('20311', 'hdphdp', '0.33');
INSERT INTO `test_ggp` VALUES ('20315', 'feiying123', '0.07');
INSERT INTO `test_ggp` VALUES ('20316', 'dinosin', '0.24');
INSERT INTO `test_ggp` VALUES ('20322', 'danielkong', '0.08');
INSERT INTO `test_ggp` VALUES ('20325', 'axeplan', '0.08');
INSERT INTO `test_ggp` VALUES ('20328', 'hongchu', '0.08');
INSERT INTO `test_ggp` VALUES ('20342', 'zhangyk', '0.4');
INSERT INTO `test_ggp` VALUES ('20344', 'zhouxu888', '0.23');
INSERT INTO `test_ggp` VALUES ('20345', 'jackking', '0.14');
INSERT INTO `test_ggp` VALUES ('20347', 'ericchoi2', '0.12');
INSERT INTO `test_ggp` VALUES ('20356', 'gems2017', '0.04');
INSERT INTO `test_ggp` VALUES ('20358', '8920531', '1.44');
INSERT INTO `test_ggp` VALUES ('20367', '678876', '6.3');
INSERT INTO `test_ggp` VALUES ('20424', 'djakiko', '0.44');
INSERT INTO `test_ggp` VALUES ('20451', 'onurunal', '0.15');
INSERT INTO `test_ggp` VALUES ('20455', 'liufei1108', '0.02');
INSERT INTO `test_ggp` VALUES ('20484', 'ke8686', '0.03');
INSERT INTO `test_ggp` VALUES ('20499', 'fanj1314', '0.02');
INSERT INTO `test_ggp` VALUES ('20540', 'd10500731', '0.02');
INSERT INTO `test_ggp` VALUES ('20542', 'dh88588', '0.03');
INSERT INTO `test_ggp` VALUES ('20552', 'ml3353635', '0.02');
INSERT INTO `test_ggp` VALUES ('20563', 'czs1980', '0.02');
INSERT INTO `test_ggp` VALUES ('20614', 'a414676879', '0.02');
INSERT INTO `test_ggp` VALUES ('20622', 'lmw0603', '6.32');
INSERT INTO `test_ggp` VALUES ('20673', 'a237379241', '6.32');
INSERT INTO `test_ggp` VALUES ('20697', 'wsdaitao88', '0.02');
INSERT INTO `test_ggp` VALUES ('20710', 'fuqin18', '0.02');
INSERT INTO `test_ggp` VALUES ('20713', 'csn7758258', '0.16');
INSERT INTO `test_ggp` VALUES ('20768', 'liu8464', '0.14');
INSERT INTO `test_ggp` VALUES ('20809', 'hh2321666', '6.32');
INSERT INTO `test_ggp` VALUES ('20812', 'yehui123', '0.02');
INSERT INTO `test_ggp` VALUES ('20814', 'sui9999', '0.12');
INSERT INTO `test_ggp` VALUES ('20830', 'shisheng8', '0.02');
INSERT INTO `test_ggp` VALUES ('20994', 'purdy419', '3.18');
INSERT INTO `test_ggp` VALUES ('21037', 'ai137855', '0.02');
INSERT INTO `test_ggp` VALUES ('21083', 'klq8888', '0.02');
INSERT INTO `test_ggp` VALUES ('21146', 'mrhuang989', '0.03');
INSERT INTO `test_ggp` VALUES ('21220', 'yaozhu1234', '0.14');
INSERT INTO `test_ggp` VALUES ('21269', '88ron88', '21.33');
INSERT INTO `test_ggp` VALUES ('21318', 'lidan888', '0.02');
INSERT INTO `test_ggp` VALUES ('21331', 'czk4343', '0.02');
INSERT INTO `test_ggp` VALUES ('21396', 'djm141242', '0.02');
INSERT INTO `test_ggp` VALUES ('21494', 'm1hr1ban', '0.21');
INSERT INTO `test_ggp` VALUES ('21495', 'k4dirc4n', '0.03');
INSERT INTO `test_ggp` VALUES ('21504', 'a1b2c3d4', '0.79');
INSERT INTO `test_ggp` VALUES ('21638', 's3m4mc4', '0.03');
INSERT INTO `test_ggp` VALUES ('21643', 'c4k4lk4rl0', '0.08');
INSERT INTO `test_ggp` VALUES ('21680', 'kkkpoker99', '1.41');
INSERT INTO `test_ggp` VALUES ('21698', 'wmkc94zmjy', '0.02');
INSERT INTO `test_ggp` VALUES ('21713', 'sv625123', '0.11');
INSERT INTO `test_ggp` VALUES ('21756', 'c4nc4n', '0.03');
INSERT INTO `test_ggp` VALUES ('21765', '1panyanju', '0.45');
INSERT INTO `test_ggp` VALUES ('21774', 'yanyan18', '0.03');
INSERT INTO `test_ggp` VALUES ('21777', 'sinlan88', '0.03');
INSERT INTO `test_ggp` VALUES ('21787', 'gigikwan8', '0.19');
INSERT INTO `test_ggp` VALUES ('21884', 'd3d3c3', '0.03');
INSERT INTO `test_ggp` VALUES ('21972', 'm3gab0x', '0.03');
INSERT INTO `test_ggp` VALUES ('21983', 'adong520', '0.02');
INSERT INTO `test_ggp` VALUES ('22010', 'd4ml4k', '2.33');
INSERT INTO `test_ggp` VALUES ('22021', 't0kk3n', '0.03');
INSERT INTO `test_ggp` VALUES ('22030', 'yokiw8888', '0.02');
INSERT INTO `test_ggp` VALUES ('22042', 'br3zilln', '0.11');
INSERT INTO `test_ggp` VALUES ('22044', 'b30lkin', '0.48');
INSERT INTO `test_ggp` VALUES ('22104', 'lee162431', '0.16');
INSERT INTO `test_ggp` VALUES ('22122', 'wendy1984', '0.02');
INSERT INTO `test_ggp` VALUES ('22124', 'wxm851210', '10.53');
INSERT INTO `test_ggp` VALUES ('22125', 'jintagg520', '6.12');
INSERT INTO `test_ggp` VALUES ('22130', 'jinta1314', '7.2');
INSERT INTO `test_ggp` VALUES ('22131', 'talang111', '8.41');
INSERT INTO `test_ggp` VALUES ('22155', 'plm009', '0.02');
INSERT INTO `test_ggp` VALUES ('22168', 'kenkk88', '0.42');
INSERT INTO `test_ggp` VALUES ('22177', 'boyboy18', '0.04');
INSERT INTO `test_ggp` VALUES ('22180', 'yingbaoji1', '0.02');
INSERT INTO `test_ggp` VALUES ('22181', 'l0ll4l4l0', '0.73');
INSERT INTO `test_ggp` VALUES ('22190', 'hushuang17', '0.62');
INSERT INTO `test_ggp` VALUES ('22200', 'b6y1e4t6', '0.73');
INSERT INTO `test_ggp` VALUES ('22202', '54bhj445', '0.03');
INSERT INTO `test_ggp` VALUES ('22207', 'jintahu888', '3.81');
INSERT INTO `test_ggp` VALUES ('22215', 'b4ttis', '0.56');
INSERT INTO `test_ggp` VALUES ('22240', 'nothing123', '6.08');
INSERT INTO `test_ggp` VALUES ('22241', 'wxm123', '8.28');
INSERT INTO `test_ggp` VALUES ('22244', 'wsygg888', '7.97');
INSERT INTO `test_ggp` VALUES ('22248', 'free888', '12.78');
INSERT INTO `test_ggp` VALUES ('22250', 'bkb000', '4.79');
INSERT INTO `test_ggp` VALUES ('22258', 'dabao9', '4.39');
INSERT INTO `test_ggp` VALUES ('22259', 'nihao1', '4.49');
INSERT INTO `test_ggp` VALUES ('22260', 'xiaobao1', '4.46');
INSERT INTO `test_ggp` VALUES ('22261', 'shuiniu123', '4.94');
INSERT INTO `test_ggp` VALUES ('22273', 'tianya1', '5.52');
INSERT INTO `test_ggp` VALUES ('22275', 'lushui1', '4.54');
INSERT INTO `test_ggp` VALUES ('22276', 'taideng222', '4.53');
INSERT INTO `test_ggp` VALUES ('22277', 'sunny1', '5.63');
INSERT INTO `test_ggp` VALUES ('22278', 'dabige123', '0.03');
INSERT INTO `test_ggp` VALUES ('22281', 'zhaoyun520', '0.03');
INSERT INTO `test_ggp` VALUES ('22289', 'ligui520', '0.28');
INSERT INTO `test_ggp` VALUES ('22303', 'wechats8', '0.02');
INSERT INTO `test_ggp` VALUES ('22304', 'rosewong2', '0.02');
INSERT INTO `test_ggp` VALUES ('22305', 'weixiao66', '0.21');
INSERT INTO `test_ggp` VALUES ('22308', 'shayu666', '0.03');
INSERT INTO `test_ggp` VALUES ('22313', 'xiadayu111', '12.02');
INSERT INTO `test_ggp` VALUES ('22314', 'tongyi1', '4.63');
INSERT INTO `test_ggp` VALUES ('22315', 'zhongguo1', '4.43');
INSERT INTO `test_ggp` VALUES ('22316', 'xiaxiaoyu2', '4.55');
INSERT INTO `test_ggp` VALUES ('22317', 'zy1111', '3.48');
INSERT INTO `test_ggp` VALUES ('22318', 'jason2245', '1.08');
INSERT INTO `test_ggp` VALUES ('22319', 'm00ld44', '0.03');
INSERT INTO `test_ggp` VALUES ('22325', 'yibaiwan2', '11.48');
INSERT INTO `test_ggp` VALUES ('22326', 'jonny222', '5.05');
INSERT INTO `test_ggp` VALUES ('22327', 'keykey1', '4.68');
INSERT INTO `test_ggp` VALUES ('22328', 'harve123', '5.48');
INSERT INTO `test_ggp` VALUES ('22340', 'ceshi8', '0.26');
INSERT INTO `test_ggp` VALUES ('22341', 'fr4nches', '0.21');
INSERT INTO `test_ggp` VALUES ('22345', 'jerry123', '18.14');
INSERT INTO `test_ggp` VALUES ('22346', 'sdany999', '4.71');
INSERT INTO `test_ggp` VALUES ('22347', 'franklin1', '4.43');
INSERT INTO `test_ggp` VALUES ('22348', 'hhzz22', '4.06');
INSERT INTO `test_ggp` VALUES ('22349', 'sealand2', '7.93');
INSERT INTO `test_ggp` VALUES ('22353', 'bnm2838', '0.83');
INSERT INTO `test_ggp` VALUES ('22354', 'leipozi25', '0.06');
INSERT INTO `test_ggp` VALUES ('22358', 'addoil22', '0.02');
INSERT INTO `test_ggp` VALUES ('22366', 'jasonkobe2', '0.03');
INSERT INTO `test_ggp` VALUES ('22369', 'taiexin6', '4.49');
INSERT INTO `test_ggp` VALUES ('22371', 'yueliang1', '5.52');
INSERT INTO `test_ggp` VALUES ('22372', 'xingyuan1', '9.16');
INSERT INTO `test_ggp` VALUES ('22373', 'meinv6', '4.59');
INSERT INTO `test_ggp` VALUES ('22379', 'cristi4an', '0.03');
INSERT INTO `test_ggp` VALUES ('22393', 'asd258', '0.03');
INSERT INTO `test_ggp` VALUES ('22397', 'wo9999', '0.56');
INSERT INTO `test_ggp` VALUES ('22414', 'ss44d0y', '1.82');
INSERT INTO `test_ggp` VALUES ('22424', 'k1ngb4by', '0.03');
INSERT INTO `test_ggp` VALUES ('22432', 'hjw3333', '3.91');
INSERT INTO `test_ggp` VALUES ('22439', 'hjw789', '0.09');
INSERT INTO `test_ggp` VALUES ('22441', 'diaoding1', '4.48');
INSERT INTO `test_ggp` VALUES ('22442', 'yule123', '4.66');
INSERT INTO `test_ggp` VALUES ('22443', 'jiaren33', '4.57');
INSERT INTO `test_ggp` VALUES ('22444', 'bunuli2', '8.81');
INSERT INTO `test_ggp` VALUES ('22453', 'diban2', '11.7');
INSERT INTO `test_ggp` VALUES ('22454', 'ni9999', '0.03');
INSERT INTO `test_ggp` VALUES ('22455', 'coke444', '4.86');
INSERT INTO `test_ggp` VALUES ('22456', 'jitui123', '4.68');
INSERT INTO `test_ggp` VALUES ('22457', 'wahaha2', '4.58');
INSERT INTO `test_ggp` VALUES ('22459', 'wangyi1993', '0.16');
INSERT INTO `test_ggp` VALUES ('22465', 'shenqi222', '1.46');
INSERT INTO `test_ggp` VALUES ('22466', 'luobo01', '6.96');
INSERT INTO `test_ggp` VALUES ('22467', 'matong7', '1.58');
INSERT INTO `test_ggp` VALUES ('22468', 'dingning1', '11.31');
INSERT INTO `test_ggp` VALUES ('22469', 'poring1', '4.59');
INSERT INTO `test_ggp` VALUES ('22474', 'dafei9999', '0.02');
INSERT INTO `test_ggp` VALUES ('22475', 'alphaaa18', '0.02');
INSERT INTO `test_ggp` VALUES ('22476', 'dabibi66', '0.03');
INSERT INTO `test_ggp` VALUES ('22479', 'nihao9999', '0.03');
INSERT INTO `test_ggp` VALUES ('22481', 'tufei1998', '0.21');
INSERT INTO `test_ggp` VALUES ('22490', 'xigua1997', '0.03');
INSERT INTO `test_ggp` VALUES ('22491', 'qwertyui04', '1.79');
INSERT INTO `test_ggp` VALUES ('22501', 'bashen111', '0.52');
INSERT INTO `test_ggp` VALUES ('22502', 'dashayu121', '0.03');
INSERT INTO `test_ggp` VALUES ('22504', 'balala00', '0.03');
INSERT INTO `test_ggp` VALUES ('22512', 'b1v2c3', '0.18');
INSERT INTO `test_ggp` VALUES ('22534', 'xizhuxi89', '0.03');
INSERT INTO `test_ggp` VALUES ('22535', 'hongri1991', '0.21');
INSERT INTO `test_ggp` VALUES ('22536', 'laoda119', '1.24');
INSERT INTO `test_ggp` VALUES ('22538', 'haopa555', '0.17');
INSERT INTO `test_ggp` VALUES ('22544', '1b4b4y', '0.41');
INSERT INTO `test_ggp` VALUES ('22601', 'allin27', '0.02');
INSERT INTO `test_ggp` VALUES ('22603', 'fafacai222', '5.38');
INSERT INTO `test_ggp` VALUES ('22623', 'david430', '0.02');
INSERT INTO `test_ggp` VALUES ('22654', 'laozheng25', '0.03');
INSERT INTO `test_ggp` VALUES ('22657', 'jinta123', '6.09');
INSERT INTO `test_ggp` VALUES ('22663', 'dashi88', '0.03');
INSERT INTO `test_ggp` VALUES ('22671', 'csnjinta81', '0.02');
INSERT INTO `test_ggp` VALUES ('22678', 'bai425', '0.37');
INSERT INTO `test_ggp` VALUES ('22680', 'feiyang66', '69.08');
INSERT INTO `test_ggp` VALUES ('22683', 'dahua512', '5.57');
INSERT INTO `test_ggp` VALUES ('22693', 'xuhao456', '7.66');
INSERT INTO `test_ggp` VALUES ('22701', 'yangyang83', '0.03');
INSERT INTO `test_ggp` VALUES ('22702', 'dagedage9', '0.03');
INSERT INTO `test_ggp` VALUES ('22703', 'qingchun1', '12.13');
INSERT INTO `test_ggp` VALUES ('22704', 'dn19930808', '0.02');
INSERT INTO `test_ggp` VALUES ('22705', 'kai123', '5.04');
INSERT INTO `test_ggp` VALUES ('22713', 'pizza888', '0.16');
INSERT INTO `test_ggp` VALUES ('22716', '3lmir4', '0.03');
INSERT INTO `test_ggp` VALUES ('22722', 'shi123', '4.02');
INSERT INTO `test_ggp` VALUES ('22735', 'zheng321', '4.11');
INSERT INTO `test_ggp` VALUES ('22750', 'wuli888', '4.49');
INSERT INTO `test_ggp` VALUES ('22754', 'yingyang1', '4.35');
INSERT INTO `test_ggp` VALUES ('22758', 'asdfghjk01', '0.11');
INSERT INTO `test_ggp` VALUES ('22759', 'avskkt8', '0.03');
INSERT INTO `test_ggp` VALUES ('22763', 'philips123', '5.22');
INSERT INTO `test_ggp` VALUES ('22766', 'qian321', '4.85');
INSERT INTO `test_ggp` VALUES ('22769', 'xingzi123', '1.81');
INSERT INTO `test_ggp` VALUES ('22770', 'jzg9999', '0.56');
INSERT INTO `test_ggp` VALUES ('22771', 'gang9999', '0.03');
INSERT INTO `test_ggp` VALUES ('22776', 'qwert1235', '10');
INSERT INTO `test_ggp` VALUES ('22781', 'xing456', '5.01');
INSERT INTO `test_ggp` VALUES ('22786', 'csn902', '0.01');
INSERT INTO `test_ggp` VALUES ('22795', 'zuzuyouyu1', '8.46');
INSERT INTO `test_ggp` VALUES ('22803', 'xiang789', '27.46');
INSERT INTO `test_ggp` VALUES ('22804', 'lucy911', '5.58');
INSERT INTO `test_ggp` VALUES ('22806', 'fafafa666', '6.05');
INSERT INTO `test_ggp` VALUES ('22812', 'lg123456', '4.36');
INSERT INTO `test_ggp` VALUES ('22813', 'shi987', '12.12');
INSERT INTO `test_ggp` VALUES ('22815', 'denglu222', '8.07');
INSERT INTO `test_ggp` VALUES ('22819', 'chuwei79', '0.02');
INSERT INTO `test_ggp` VALUES ('22820', 'key123', '4.22');
INSERT INTO `test_ggp` VALUES ('22821', 'lovelove12', '4.36');
INSERT INTO `test_ggp` VALUES ('22824', 'mbp6688', '0.03');
INSERT INTO `test_ggp` VALUES ('22825', 'niufa222', '8.44');
INSERT INTO `test_ggp` VALUES ('22828', 'shou123', '5.04');
INSERT INTO `test_ggp` VALUES ('22829', 'wan456', '13.28');
INSERT INTO `test_ggp` VALUES ('22830', 'bha222', '5.15');
INSERT INTO `test_ggp` VALUES ('22831', 'huqiao123', '5.01');
INSERT INTO `test_ggp` VALUES ('22836', 'cba111', '9.1');
INSERT INTO `test_ggp` VALUES ('22837', 'jin147', '4.37');
INSERT INTO `test_ggp` VALUES ('22838', 'yaya89', '4.47');
INSERT INTO `test_ggp` VALUES ('22839', 'hao123', '4.24');
INSERT INTO `test_ggp` VALUES ('22843', 'ying888', '4.68');
INSERT INTO `test_ggp` VALUES ('22844', 'nba222', '6.06');
INSERT INTO `test_ggp` VALUES ('22845', 'gun123', '3.75');
INSERT INTO `test_ggp` VALUES ('22847', 'guojia123', '4.45');
INSERT INTO `test_ggp` VALUES ('22848', 'lian456', '11.03');
INSERT INTO `test_ggp` VALUES ('22854', 'niubi9999', '0.03');
INSERT INTO `test_ggp` VALUES ('22857', 'gbafan888', '0.39');
INSERT INTO `test_ggp` VALUES ('22863', 'myck64444', '0.22');
INSERT INTO `test_ggp` VALUES ('22864', 'gggking8', '0.21');
INSERT INTO `test_ggp` VALUES ('22865', 'xupeng9999', '0.14');
INSERT INTO `test_ggp` VALUES ('22866', 'khigh66', '0.03');
INSERT INTO `test_ggp` VALUES ('22870', 'chiji123', '8.91');
INSERT INTO `test_ggp` VALUES ('22873', 'weiwei888', '10.55');
INSERT INTO `test_ggp` VALUES ('22877', 'bing9999', '0.69');
INSERT INTO `test_ggp` VALUES ('22887', 'yu52883344', '0.03');
INSERT INTO `test_ggp` VALUES ('22889', 'yu8522', '0.56');
INSERT INTO `test_ggp` VALUES ('22905', 'kaihu333', '7.36');
INSERT INTO `test_ggp` VALUES ('22907', 'zanzan77', '4.13');
INSERT INTO `test_ggp` VALUES ('22911', 'ftb111', '9.54');
INSERT INTO `test_ggp` VALUES ('22912', 'ying123', '4.14');
INSERT INTO `test_ggp` VALUES ('22913', 'sao456', '4.06');
INSERT INTO `test_ggp` VALUES ('22918', 'geng456', '4.11');
INSERT INTO `test_ggp` VALUES ('22920', 'ppmmmmm1', '0.38');
INSERT INTO `test_ggp` VALUES ('22921', 'yatou68', '10.41');
INSERT INTO `test_ggp` VALUES ('22922', 'xiong147', '4.61');
INSERT INTO `test_ggp` VALUES ('22923', 'ggaa111', '4.1');
INSERT INTO `test_ggp` VALUES ('22928', 'duo456', '3.9');
INSERT INTO `test_ggp` VALUES ('22930', 'wojia888', '8.92');
INSERT INTO `test_ggp` VALUES ('22934', 'ccc111', '4.26');
INSERT INTO `test_ggp` VALUES ('22935', 'jiajia25', '3.98');
INSERT INTO `test_ggp` VALUES ('22939', 'lian888', '10.01');
INSERT INTO `test_ggp` VALUES ('22941', 'shazi222', '5.37');
INSERT INTO `test_ggp` VALUES ('22942', 'man111', '3.99');
INSERT INTO `test_ggp` VALUES ('22943', 'xun456', '4.31');
INSERT INTO `test_ggp` VALUES ('22946', 'menmen9', '10.58');
INSERT INTO `test_ggp` VALUES ('22947', 'deng456', '4.47');
INSERT INTO `test_ggp` VALUES ('22948', 'meng888', '4.27');
INSERT INTO `test_ggp` VALUES ('22949', 'bbb111', '4.3');
INSERT INTO `test_ggp` VALUES ('22959', 'xiaxia32', '4.31');
INSERT INTO `test_ggp` VALUES ('22960', 'zhe456', '8.76');
INSERT INTO `test_ggp` VALUES ('22965', 'www111', '4.26');
INSERT INTO `test_ggp` VALUES ('22968', 'jiayou22', '4.27');
INSERT INTO `test_ggp` VALUES ('22982', 'dengni123', '4.02');
INSERT INTO `test_ggp` VALUES ('22983', 'ttt111', '3.97');
INSERT INTO `test_ggp` VALUES ('22984', 'fang456', '8.51');
INSERT INTO `test_ggp` VALUES ('22985', 'yonghu123', '4.06');
INSERT INTO `test_ggp` VALUES ('22987', '0sm4nli', '0.09');
INSERT INTO `test_ggp` VALUES ('22996', 'ghc0955', '4.03');
INSERT INTO `test_ggp` VALUES ('23017', 'duoduo888', '11.5');
INSERT INTO `test_ggp` VALUES ('23020', 'aa667788', '6.11');
INSERT INTO `test_ggp` VALUES ('23021', 'jinru111', '12.33');
INSERT INTO `test_ggp` VALUES ('23023', 'fuwei888', '6.38');
INSERT INTO `test_ggp` VALUES ('23025', 'bei456', '4.22');
INSERT INTO `test_ggp` VALUES ('23034', 'youxi123', '5.4');
INSERT INTO `test_ggp` VALUES ('23053', 'zl158180', '2.28');
INSERT INTO `test_ggp` VALUES ('23054', 'zhanghao1', '6.73');
INSERT INTO `test_ggp` VALUES ('23055', 'zyx126', '4.8');
INSERT INTO `test_ggp` VALUES ('23057', 'qq225588', '5.91');
INSERT INTO `test_ggp` VALUES ('23064', 'xcm0716', '3.66');
INSERT INTO `test_ggp` VALUES ('23091', 'buyu123', '4.8');
INSERT INTO `test_ggp` VALUES ('23093', 'ww336699', '4.64');
INSERT INTO `test_ggp` VALUES ('23095', 'ppp888', '3.53');
INSERT INTO `test_ggp` VALUES ('23100', 'dian0517', '5.86');
INSERT INTO `test_ggp` VALUES ('23113', 'uu112233', '5');
INSERT INTO `test_ggp` VALUES ('23115', 'ooo111', '11.36');
INSERT INTO `test_ggp` VALUES ('23119', 'xin135', '3.95');
INSERT INTO `test_ggp` VALUES ('23120', 'jinjin46', '4.11');
INSERT INTO `test_ggp` VALUES ('23123', 'gai465', '3.8');
INSERT INTO `test_ggp` VALUES ('23130', 'niuniu3', '8.39');
INSERT INTO `test_ggp` VALUES ('23131', 'zuo135', '4.29');
INSERT INTO `test_ggp` VALUES ('23132', 'rrr111', '4.38');
INSERT INTO `test_ggp` VALUES ('23133', 'you465', '4.29');
INSERT INTO `test_ggp` VALUES ('23137', 'tianxie123', '7.17');
INSERT INTO `test_ggp` VALUES ('23138', 'xiaowang1', '12.72');
INSERT INTO `test_ggp` VALUES ('23139', 'ggg111', '4.04');
INSERT INTO `test_ggp` VALUES ('23140', 'nini12', '4.05');
INSERT INTO `test_ggp` VALUES ('23141', 'wei135', '8.34');
INSERT INTO `test_ggp` VALUES ('23142', 'zhou465', '4.04');
INSERT INTO `test_ggp` VALUES ('23145', 'kaihu00', '8.98');
INSERT INTO `test_ggp` VALUES ('23148', 'kaola33', '4.27');
INSERT INTO `test_ggp` VALUES ('23151', 'han465', '4.08');
INSERT INTO `test_ggp` VALUES ('23152', 'mmm111', '4.03');
INSERT INTO `test_ggp` VALUES ('23158', 'tiyun135', '4.12');
INSERT INTO `test_ggp` VALUES ('23159', 'liang465', '4.92');
INSERT INTO `test_ggp` VALUES ('23160', 'moli90', '8.83');
INSERT INTO `test_ggp` VALUES ('23170', 'dd556677', '5.69');
INSERT INTO `test_ggp` VALUES ('23174', 'hh115599', '4.66');
INSERT INTO `test_ggp` VALUES ('23175', 'fffwww88', '0.58');
INSERT INTO `test_ggp` VALUES ('23184', 'atm321', '0.03');
INSERT INTO `test_ggp` VALUES ('23186', 'kk335577', '4.06');
INSERT INTO `test_ggp` VALUES ('23188', 'jpin35', '3.94');
INSERT INTO `test_ggp` VALUES ('23190', 'wenwen1234', '7.4');
INSERT INTO `test_ggp` VALUES ('23191', 'mantou123', '4.9');
INSERT INTO `test_ggp` VALUES ('23209', 'cuixiaoxu1', '11.17');
INSERT INTO `test_ggp` VALUES ('23216', '10ne2tw0', '0.77');
INSERT INTO `test_ggp` VALUES ('23219', 'boluo222', '7.09');
INSERT INTO `test_ggp` VALUES ('23230', 'zcjt444', '4.8');
INSERT INTO `test_ggp` VALUES ('23236', 'nbdr777', '4.43');
INSERT INTO `test_ggp` VALUES ('23241', 'xjlh611', '0.04');
INSERT INTO `test_ggp` VALUES ('23246', 'erji666', '3.19');
INSERT INTO `test_ggp` VALUES ('23273', 'linpeng521', '9.59');
INSERT INTO `test_ggp` VALUES ('23279', 'kuio753', '2.45');
INSERT INTO `test_ggp` VALUES ('23280', 'zhang6688', '7.62');
INSERT INTO `test_ggp` VALUES ('23281', 'li0609', '11.3');
INSERT INTO `test_ggp` VALUES ('23282', 'tian0317', '10.95');
INSERT INTO `test_ggp` VALUES ('23283', 'yan5525', '5.94');
INSERT INTO `test_ggp` VALUES ('23284', 'hcz520', '0.01');
INSERT INTO `test_ggp` VALUES ('23286', 'ftyt654', '4.01');
INSERT INTO `test_ggp` VALUES ('23287', 'zhou6274', '5.07');
INSERT INTO `test_ggp` VALUES ('23288', 'xing369', '6.72');
INSERT INTO `test_ggp` VALUES ('23305', 'bl4ck0n3', '0.52');
INSERT INTO `test_ggp` VALUES ('23310', 'lkiu369', '5.27');
INSERT INTO `test_ggp` VALUES ('23312', '9957zhou', '4.11');
INSERT INTO `test_ggp` VALUES ('23314', 'jiajia520', '3.64');
INSERT INTO `test_ggp` VALUES ('23315', 'bing258', '8.84');
INSERT INTO `test_ggp` VALUES ('23332', 'pangzi888', '3.85');
INSERT INTO `test_ggp` VALUES ('23337', 'feiniu888', '3.87');
INSERT INTO `test_ggp` VALUES ('23346', 'wen1234', '3.72');
INSERT INTO `test_ggp` VALUES ('23352', 'fei520', '6.06');
INSERT INTO `test_ggp` VALUES ('23353', 'kele888', '5.04');
INSERT INTO `test_ggp` VALUES ('23355', 'long589', '3.56');
INSERT INTO `test_ggp` VALUES ('23383', 'b0xking', '0.07');
INSERT INTO `test_ggp` VALUES ('23421', 'bl00dgam3', '0.03');
INSERT INTO `test_ggp` VALUES ('23423', 'z5632098', '0.02');
INSERT INTO `test_ggp` VALUES ('23427', 'mouqi520', '5.07');
INSERT INTO `test_ggp` VALUES ('23429', '511275291z', '6.14');
INSERT INTO `test_ggp` VALUES ('23435', 'diannao111', '8.08');
INSERT INTO `test_ggp` VALUES ('23438', 'wangka888', '4.72');
INSERT INTO `test_ggp` VALUES ('23451', 'zhuce888', '3.13');
INSERT INTO `test_ggp` VALUES ('23452', 'youxi444', '5.83');
INSERT INTO `test_ggp` VALUES ('23454', 'qq1685361', '5.83');
INSERT INTO `test_ggp` VALUES ('23455', 'wulin999', '5.11');
INSERT INTO `test_ggp` VALUES ('23458', 'moneyco888', '4.14');
INSERT INTO `test_ggp` VALUES ('23459', 'k0nt3s', '0.03');
INSERT INTO `test_ggp` VALUES ('23460', 'w4mpir', '0.03');
INSERT INTO `test_ggp` VALUES ('23468', 'zhuizhu1', '4.59');
INSERT INTO `test_ggp` VALUES ('23473', 'gaizao123', '5.63');
INSERT INTO `test_ggp` VALUES ('23494', 'jamesbond1', '11.05');
INSERT INTO `test_ggp` VALUES ('23512', 'cuixiao1', '5.29');
INSERT INTO `test_ggp` VALUES ('23519', 'ohmyfk5', '4.98');
INSERT INTO `test_ggp` VALUES ('23535', 'ming663', '7');
INSERT INTO `test_ggp` VALUES ('23538', 'erji567', '8.52');
INSERT INTO `test_ggp` VALUES ('23546', 'katong222', '8.03');
INSERT INTO `test_ggp` VALUES ('23548', 'qifen888', '5.31');
INSERT INTO `test_ggp` VALUES ('23549', 'travller8', '8.16');
INSERT INTO `test_ggp` VALUES ('23551', 'omg777', '8.96');
INSERT INTO `test_ggp` VALUES ('23552', 'datian8', '4.3');
INSERT INTO `test_ggp` VALUES ('23554', 'cuidawang2', '3.53');
INSERT INTO `test_ggp` VALUES ('23555', 'tiyu123', '8.23');
INSERT INTO `test_ggp` VALUES ('23559', 'mengzeyi88', '0.02');
INSERT INTO `test_ggp` VALUES ('23560', 'j0hann', '0.21');
INSERT INTO `test_ggp` VALUES ('23561', 'l3tsg0', '0.03');
INSERT INTO `test_ggp` VALUES ('23563', 'nongfu666', '5.66');
INSERT INTO `test_ggp` VALUES ('23593', 'shidai888', '3.39');
INSERT INTO `test_ggp` VALUES ('23594', 'jtiniubi1', '4.48');
INSERT INTO `test_ggp` VALUES ('23597', 'chich4', '0.17');
INSERT INTO `test_ggp` VALUES ('23600', 'nl7000000', '3.48');
INSERT INTO `test_ggp` VALUES ('23602', 'erjilook11', '3.8');
INSERT INTO `test_ggp` VALUES ('23604', 'th3m3t', '0.06');
INSERT INTO `test_ggp` VALUES ('23609', 'treebook22', '3.64');
INSERT INTO `test_ggp` VALUES ('23610', 'xiong321', '4.95');
INSERT INTO `test_ggp` VALUES ('23612', 'truehot33', '5.15');
INSERT INTO `test_ggp` VALUES ('23691', 'gudanhero2', '4.86');
INSERT INTO `test_ggp` VALUES ('23694', 'xiaomi22', '5.38');
INSERT INTO `test_ggp` VALUES ('23695', 'gr33nn', '0.03');
INSERT INTO `test_ggp` VALUES ('23701', 'b00ssiy', '0.03');
INSERT INTO `test_ggp` VALUES ('23702', 'zhangtao3', '5.46');
INSERT INTO `test_ggp` VALUES ('23703', 'kaixin999', '10.31');
INSERT INTO `test_ggp` VALUES ('23713', 's1ng4p', '0.03');
INSERT INTO `test_ggp` VALUES ('23725', 'kottp86', '5.06');
INSERT INTO `test_ggp` VALUES ('23726', 'shanpao1', '4.08');
INSERT INTO `test_ggp` VALUES ('23727', 'aomaha000', '8.48');
INSERT INTO `test_ggp` VALUES ('23732', 'ppnide4', '3.48');
INSERT INTO `test_ggp` VALUES ('23734', 'xiaoming5', '7.68');
INSERT INTO `test_ggp` VALUES ('23736', 'aomaha666', '6.2');
INSERT INTO `test_ggp` VALUES ('23737', 'xiaoli333', '5.93');
INSERT INTO `test_ggp` VALUES ('23746', 'zid4n3e', '0.03');
INSERT INTO `test_ggp` VALUES ('23748', 'ch1ck3nn', '0.03');
INSERT INTO `test_ggp` VALUES ('23751', '1g02in', '0.03');
INSERT INTO `test_ggp` VALUES ('23754', 'xiaomei0', '5.52');
INSERT INTO `test_ggp` VALUES ('23758', 'niang123', '4.62');
INSERT INTO `test_ggp` VALUES ('23763', 'bc0inking', '0.03');
INSERT INTO `test_ggp` VALUES ('23779', 'meilian88', '4.58');
INSERT INTO `test_ggp` VALUES ('23780', 'a275366036', '4.51');
INSERT INTO `test_ggp` VALUES ('23783', 'qinfeng2', '2.8');
INSERT INTO `test_ggp` VALUES ('23786', '0gg3b0', '0.52');
INSERT INTO `test_ggp` VALUES ('23788', 'n0g4m3', '0.11');
INSERT INTO `test_ggp` VALUES ('23798', 'a328080434', '4.8');
INSERT INTO `test_ggp` VALUES ('23814', 'kang666', '0.71');
INSERT INTO `test_ggp` VALUES ('23820', 'shishi520', '4.97');
INSERT INTO `test_ggp` VALUES ('23828', 'b04t3ng', '0.29');
INSERT INTO `test_ggp` VALUES ('23839', 's4nan3er', '0.21');
INSERT INTO `test_ggp` VALUES ('23845', 'libotao88', '4.6');
INSERT INTO `test_ggp` VALUES ('23847', 'hujunming9', '4.92');
INSERT INTO `test_ggp` VALUES ('23852', 'fish2017', '5.12');
INSERT INTO `test_ggp` VALUES ('23855', 'xiezheng55', '5');
INSERT INTO `test_ggp` VALUES ('23856', 'xiaomifen6', '4.22');
INSERT INTO `test_ggp` VALUES ('23857', 'woshizhu11', '4.67');
INSERT INTO `test_ggp` VALUES ('23865', 'yang321', '4.3');
INSERT INTO `test_ggp` VALUES ('23895', 'kaixuan888', '5.14');
INSERT INTO `test_ggp` VALUES ('23903', 'kekelele88', '4.71');
INSERT INTO `test_ggp` VALUES ('23906', 'jiling666', '4.95');
INSERT INTO `test_ggp` VALUES ('23915', 'highv0lt', '0.03');
INSERT INTO `test_ggp` VALUES ('23941', 'h4h7ert', '0.03');
INSERT INTO `test_ggp` VALUES ('24000', 'sibada777', '4.27');
INSERT INTO `test_ggp` VALUES ('24030', 'victory888', '4.84');
INSERT INTO `test_ggp` VALUES ('24055', 'onlyyou888', '3.97');
INSERT INTO `test_ggp` VALUES ('24058', 'makebest11', '3.83');
INSERT INTO `test_ggp` VALUES ('24071', 'kuer321', '5.02');
INSERT INTO `test_ggp` VALUES ('24072', 'gettheg22', '3.75');
INSERT INTO `test_ggp` VALUES ('24156', 'feiyu123', '5.04');
INSERT INTO `test_ggp` VALUES ('24161', 'yu0317', '4.63');
INSERT INTO `test_ggp` VALUES ('24167', 'lang789', '4.7');
INSERT INTO `test_ggp` VALUES ('24168', 'erhuo222', '4.26');
INSERT INTO `test_ggp` VALUES ('24171', 'xinchang1', '6.51');
INSERT INTO `test_ggp` VALUES ('24186', 'shule111', '4.08');
INSERT INTO `test_ggp` VALUES ('24189', 'mingmen33', '3.59');
INSERT INTO `test_ggp` VALUES ('24193', 'baidu123', '4.05');
INSERT INTO `test_ggp` VALUES ('24196', 'chao666', '4.15');
INSERT INTO `test_ggp` VALUES ('24197', 'zhuanqian2', '4.62');
INSERT INTO `test_ggp` VALUES ('24208', 'whatyou77', '2.58');
INSERT INTO `test_ggp` VALUES ('24234', 'btc0ins', '0.4');
INSERT INTO `test_ggp` VALUES ('24266', 'fanyi666', '4.07');
INSERT INTO `test_ggp` VALUES ('24270', 'buyuwang9', '4.42');
INSERT INTO `test_ggp` VALUES ('24274', 'buyuwang8', '4.45');
INSERT INTO `test_ggp` VALUES ('24275', 'tianmao111', '4.7');
INSERT INTO `test_ggp` VALUES ('24279', 'huan456', '4.29');
INSERT INTO `test_ggp` VALUES ('24282', 'aof333', '7.19');
INSERT INTO `test_ggp` VALUES ('24301', 'zhuanqian3', '5.16');
INSERT INTO `test_ggp` VALUES ('24304', 'chin4g0lle', '0.21');
INSERT INTO `test_ggp` VALUES ('24306', 'gh0strac3', '0.03');
INSERT INTO `test_ggp` VALUES ('24307', 'bikesch0', '0.1');
INSERT INTO `test_ggp` VALUES ('24309', 'ataixgg2', '3.89');
INSERT INTO `test_ggp` VALUES ('24310', 'huozhe111', '5');
INSERT INTO `test_ggp` VALUES ('24311', 'jixiang888', '4.97');
INSERT INTO `test_ggp` VALUES ('24315', 'hong123', '4.48');
INSERT INTO `test_ggp` VALUES ('24317', 'huozhe222', '5.48');
INSERT INTO `test_ggp` VALUES ('24318', 'alert1990', '5.39');
INSERT INTO `test_ggp` VALUES ('24322', 'gpokel663', '6.81');
INSERT INTO `test_ggp` VALUES ('24334', 'facai123', '3.62');
INSERT INTO `test_ggp` VALUES ('24339', 'kangda555', '4.08');
INSERT INTO `test_ggp` VALUES ('24345', 'fadacai111', '4.01');
INSERT INTO `test_ggp` VALUES ('24349', 'mangduan33', '1.82');
INSERT INTO `test_ggp` VALUES ('24352', 'yihao123', '5.07');
INSERT INTO `test_ggp` VALUES ('24353', 'momo666', '4.88');
INSERT INTO `test_ggp` VALUES ('24372', 'dafacai222', '4.86');
INSERT INTO `test_ggp` VALUES ('24374', 'haoyun121', '4.76');
INSERT INTO `test_ggp` VALUES ('24386', 'k1b2f3', '0.21');
INSERT INTO `test_ggp` VALUES ('24391', 'yonghe77', '5.29');
INSERT INTO `test_ggp` VALUES ('24395', 'babyboy88', '3.8');
INSERT INTO `test_ggp` VALUES ('24396', 'goingfafa1', '4.71');
INSERT INTO `test_ggp` VALUES ('24400', 'pukeshou5', '2.33');
INSERT INTO `test_ggp` VALUES ('24404', 'jiqiren3', '4.56');
INSERT INTO `test_ggp` VALUES ('24407', 'c88918', '0.02');
INSERT INTO `test_ggp` VALUES ('24408', 'xiaosu121', '4.87');
INSERT INTO `test_ggp` VALUES ('24410', 'hai666', '6.96');
INSERT INTO `test_ggp` VALUES ('24416', 'qingren1', '4.36');
INSERT INTO `test_ggp` VALUES ('24424', 'niubi111', '5.76');
INSERT INTO `test_ggp` VALUES ('24455', 'huawei123', '4.5');
INSERT INTO `test_ggp` VALUES ('24457', 'xiaodao6', '4.23');
INSERT INTO `test_ggp` VALUES ('24471', 'dadyc0l', '0.56');
INSERT INTO `test_ggp` VALUES ('24488', 'hold3m', '0.17');
INSERT INTO `test_ggp` VALUES ('24586', 'jiang121', '4.58');
INSERT INTO `test_ggp` VALUES ('24587', 'xin555', '4.15');
INSERT INTO `test_ggp` VALUES ('24620', 'jin0826', '3.44');
INSERT INTO `test_ggp` VALUES ('24633', 'boshi123', '3.48');
INSERT INTO `test_ggp` VALUES ('24665', 'wzckid1', '0.51');
INSERT INTO `test_ggp` VALUES ('24690', 'charm3nd', '0.03');
INSERT INTO `test_ggp` VALUES ('24722', 'kafei123', '0.49');
INSERT INTO `test_ggp` VALUES ('24762', 'ceshiji001', '20.65');
INSERT INTO `test_ggp` VALUES ('24795', 'snake88', '3.11');
INSERT INTO `test_ggp` VALUES ('24802', 'whl888', '0.02');
INSERT INTO `test_ggp` VALUES ('24805', 'snake003', '11.76');
INSERT INTO `test_ggp` VALUES ('24806', 'snake004', '11.76');
INSERT INTO `test_ggp` VALUES ('24807', 'snake005', '11.76');
INSERT INTO `test_ggp` VALUES ('24861', 'hongkou123', '0.03');
INSERT INTO `test_ggp` VALUES ('24907', 'kugou888', '0.21');
INSERT INTO `test_ggp` VALUES ('24915', 'b3tlike', '0.17');
INSERT INTO `test_ggp` VALUES ('24970', 'louie1', '0.13');
INSERT INTO `test_ggp` VALUES ('24972', 'jolly123', '19.38');
INSERT INTO `test_ggp` VALUES ('24974', 'huyi1981', '0.71');
INSERT INTO `test_ggp` VALUES ('24978', 'kkiidd1', '0.03');
INSERT INTO `test_ggp` VALUES ('24996', '13qwsa', '0.03');
INSERT INTO `test_ggp` VALUES ('24997', 'uiiic25', '0.03');
INSERT INTO `test_ggp` VALUES ('52', 'woshinige', '0.05');
INSERT INTO `test_ggp` VALUES ('54', 'lyle1234', '1.07');
INSERT INTO `test_ggp` VALUES ('58', 'testegg', '0.14');
INSERT INTO `test_ggp` VALUES ('71', 'elephant9', '0.08');
INSERT INTO `test_ggp` VALUES ('7400', 'eggvip', '0.09');
INSERT INTO `test_ggp` VALUES ('8148', 'heqing', '0.18');
INSERT INTO `test_ggp` VALUES ('8781', 'tmdylc88', '0.3');
INSERT INTO `test_ggp` VALUES ('9320', 'yyd0660', '0.03');
INSERT INTO `test_ggp` VALUES ('9750', 'wvk197610', '0.05');

-- ----------------------------
-- Table structure for test_test
-- ----------------------------
DROP TABLE IF EXISTS `test_test`;
CREATE TABLE `test_test` (
  `employeecode` char(8) DEFAULT NULL,
  `parent_employeecode` char(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test_test
-- ----------------------------

-- ----------------------------
-- Table structure for thirdparty_payment_bank
-- ----------------------------
DROP TABLE IF EXISTS `thirdparty_payment_bank`;
CREATE TABLE `thirdparty_payment_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID ,主键',
  `bankcode` char(4) NOT NULL COMMENT '银行编码',
  `thirdpartypaymenttypecode` char(4) DEFAULT NULL COMMENT '第三方支付编码',
  `paymenttypebankcode` varchar(20) DEFAULT NULL COMMENT '第三方支付银行编码',
  `enable` char(1) DEFAULT NULL COMMENT '启用与禁用',
  PRIMARY KEY (`id`),
  KEY `index_thirdpartypaymenttypecode` (`thirdpartypaymenttypecode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=683 DEFAULT CHARSET=utf8 COMMENT='第三方支付银行';

-- ----------------------------
-- Records of thirdparty_payment_bank
-- ----------------------------
INSERT INTO `thirdparty_payment_bank` VALUES ('10', 'B005', 'P001', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('12', 'B004', 'P001', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('14', 'B003', 'P001', 'BOCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('15', 'B015', 'P001', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('16', 'B006', 'P001', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('17', 'B021', 'P001', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('18', 'B016', 'P001', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('19', 'B012', 'P001', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('20', 'B008', 'P001', 'CEBBANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('21', 'B013', 'P001', 'ECITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('22', 'B010', 'P001', 'PINGAN', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('23', 'B018', 'P001', 'CMBCS', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('24', 'B011', 'P001', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('25', 'B009', 'P001', 'CGB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('26', 'B002', 'P001', 'BCCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('29', 'B007', 'P001', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('30', 'B019', 'P003', 'WEIXIN', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('32', 'B005', 'P005', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('33', 'B004', 'P005', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('34', 'B003', 'P005', 'BOCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('35', 'B015', 'P005', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('36', 'B006', 'P005', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('37', 'B021', 'P005', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('38', 'B016', 'P005', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('39', 'B012', 'P005', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('40', 'B008', 'P005', 'CEBBANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('41', 'B013', 'P005', 'ECITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('42', 'B010', 'P005', 'PINGAN', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('43', 'B018', 'P005', 'CMBCS', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('44', 'B011', 'P005', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('45', 'B009', 'P005', 'CGB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('46', 'B002', 'P005', 'BCCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('47', 'B007', 'P005', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('48', 'B019', 'P005', 'WEIXIN', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('49', 'B019', 'P006', '30', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('50', 'B020', 'P006', '22', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('51', 'B020', 'P007', 'ZHIFUBAO', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('53', 'B020', 'P001', 'ZHIFUBAO', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('54', 'B015', 'P008', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('55', 'B004', 'P008', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('56', 'B016', 'P008', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('57', 'B002', 'P008', 'BCCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('58', 'B003', 'P008', 'BOCO', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('59', 'B007', 'P008', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('60', 'B018', 'P008', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('61', 'B008', 'P008', 'CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('62', 'B010', 'P008', 'PINGANBANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('63', 'B013', 'P008', 'CTTIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('64', 'B009', 'P008', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('65', 'B001', 'P008', 'SHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('66', 'B012', 'P008', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('67', 'B021', 'P008', 'PSBS', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('68', 'B011', 'P008', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('69', 'B022', 'P008', 'BJRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('70', 'B023', 'P008', 'SRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('71', 'B020', 'P008', 'ALIPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('72', 'B019', 'P008', 'WEIXIN', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('73', 'B024', 'P008', 'NJCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('74', 'B030', 'P008', 'CBHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('75', 'B025', 'P008', 'HKBEA', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('76', 'B026', 'P008', 'NBCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('77', 'B027', 'P008', 'SDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('78', 'B031', 'P008', 'CZB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('79', 'B029', 'P008', 'TENPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('80', 'B006', 'P009', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('81', 'B005', 'P009', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('82', 'B015', 'P009', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('83', 'B003', 'P009', 'BOCM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('84', 'B004', 'P009', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('85', 'B016', 'P009', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('86', 'B021', 'P009', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('87', 'B018', 'P009', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('88', 'B011', 'P009', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('89', 'B007', 'P009', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('90', 'B009', 'P009', 'CGB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('91', 'B009', 'P009', 'CITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('92', 'B020', 'P012', '100067', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('93', 'B019', 'P011', '100040', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('94', 'B002', 'P010', '100026', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('95', 'B021', 'P010', '100025', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('96', 'B008', 'P010', '100024', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('97', 'B013', 'P010', '100023', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('98', 'B009', 'P010', '100022', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('99', 'B012', 'P010', '100021', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('100', 'B007', 'P010', '100020', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('101', 'B011', 'P010', '100019', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('102', 'B018', 'P010', '100018', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('103', 'B004', 'P010', '100017', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('104', 'B016', 'P010', '100016', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('105', 'B003', 'P010', '100015', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('106', 'B015', 'P010', '100014', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('107', 'B005', 'P010', '100013', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('108', 'B006', 'P010', '100012', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('109', 'B005', 'P013', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('110', 'B004', 'P013', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('111', 'B003', 'P013', 'BOCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('112', 'B015', 'P013', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('113', 'B006', 'P013', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('114', 'B021', 'P013', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('115', 'B016', 'P013', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('116', 'B012', 'P013', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('117', 'B008', 'P013', 'CEBBANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('118', 'B013', 'P013', 'ECITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('119', 'B010', 'P013', 'PINGAN', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('120', 'B018', 'P013', 'CMBCS', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('121', 'B011', 'P013', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('122', 'B009', 'P013', 'CGB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('123', 'B002', 'P013', 'BCCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('124', 'B001', 'P013', 'BOS', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('125', 'B007', 'P013', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('126', 'B019', 'P013', 'WEIXIN', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('128', 'B005', 'P014', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('129', 'B006', 'P014', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('130', 'B015', 'P014', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('131', 'B003', 'P014', 'BCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('132', 'B004', 'P014', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('133', 'B016', 'P014', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('134', 'B018', 'P014', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('135', 'B008', 'P014', 'CEBB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('136', 'B007', 'P014', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('137', 'B021', 'P014', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('138', 'B010', 'P014', 'SPABANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('139', 'B013', 'P014', 'ECITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('140', 'B009', 'P014', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('141', 'B011', 'P014', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('142', 'B012', 'P014', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('143', 'B025', 'P014', 'BEA', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('144', 'B019', 'P014', 'WECHATQR', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('145', 'B020', 'P014', 'ALIPAYQR', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('146', 'B020', 'P013', 'ZHIFUBAO', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('147', 'B006', 'P015', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('148', 'B015', 'P015', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('149', 'B003', 'P015', 'BCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('150', 'B004', 'P015', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('151', 'B016', 'P015', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('152', 'B018', 'P015', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('153', 'B008', 'P015', 'CEBB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('154', 'B002', 'P015', 'BOB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('155', 'B001', 'P015', 'SHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('156', 'B026', 'P015', 'NBB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('157', 'B011', 'P015', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('158', 'B007', 'P015', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('159', 'B021', 'P015', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('160', 'B010', 'P015', 'SPABANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('161', 'B012', 'P015', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('162', 'B013', 'P015', 'ECITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('163', 'B009', 'P015', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('164', 'B005', 'P019', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('165', 'B022', 'P019', 'BJRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('166', 'B002', 'P019', 'BOB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('167', 'B004', 'P019', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('168', 'B001', 'P019', 'BOS', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('169', 'B030', 'P019', 'CBHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('170', 'B015', 'P019', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('171', 'B008', 'P019', 'CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('172', 'B007', 'P019', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('173', 'B013', 'P019', 'CITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('174', 'B016', 'P019', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('175', 'B018', 'P019', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('176', 'B003', 'P019', 'COMM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('177', 'B031', 'P019', 'CZB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('178', 'B009', 'P019', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('179', 'B011', 'P019', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('180', 'B006', 'P019', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('181', 'B010', 'P019', 'PAB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('182', 'B021', 'P019', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('183', 'B027', 'P019', 'SDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('184', 'B012', 'P019', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('185', 'B006', 'P020', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('188', 'B019', 'P022', 'WECHAT', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('189', 'B020', 'P022', 'ALIPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('191', 'B007', 'P001', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('192', 'B006', 'P027', 'BANK_ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('193', 'B005', 'P027', 'BANK_ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('194', 'B005', 'P015', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('195', 'B007', 'P027', 'BANK_CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('196', 'B009', 'P027', 'BANK_GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('197', 'B008', 'P027', 'BANK_CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('198', 'B002', 'P027', 'BANK_BOBJ', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('199', 'B001', 'P027', 'BANK_BOS', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('200', 'B010', 'P027', 'BANK_PAB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('201', 'B026', 'P027', 'BANK_NBCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('202', 'B031', 'P027', 'BANK_CZB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('203', 'B016', 'P027', 'BANK_CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('204', 'B004', 'P027', 'BANK_BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('205', 'B003', 'P027', 'BANK_BOCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('206', 'B011', 'P027', 'BANK_HXBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('207', 'B012', 'P027', 'BANK_SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('208', 'B013', 'P027', 'BANK_CITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('209', 'B021', 'P027', 'BANK_PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('210', 'B023', 'P027', 'BANK_SRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('211', 'B022', 'P027', 'BANK_BJRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('212', 'B030', 'P027', 'BANK_CBHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('213', 'B024', 'P027', 'BANK_BON', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('214', 'B025', 'P027', 'BANK_BEA', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('215', 'B019', 'P029', 'WEIXIN_QRCODE', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('216', 'B020', 'P029', 'ALIPAY_QRCODE', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('217', 'B015', 'P027', 'BANK_CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('218', 'B018', 'P027', 'BANK_CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('219', 'B015', 'P030', 'BANK_CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('220', 'B006', 'P030', 'BANK_ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('221', 'B005', 'P030', 'BANK_ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('222', 'B018', 'P030', 'BANK_CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('223', 'B007', 'P030', 'BANK_CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('224', 'B008', 'P030', 'BANK_CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('225', 'B016', 'P030', 'BANK_CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('226', 'B004', 'P030', 'BANK_BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('227', 'B003', 'P030', 'BANK_BOCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('228', 'B011', 'P030', 'BANK_HXBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('229', 'B013', 'P030', 'BANK_CITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('230', 'B010', 'P030', 'BANK_PAB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('231', 'B016', 'P023', '308584000013', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('232', 'B006', 'P023', '102100099996', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('233', 'B015', 'P023', '105100000017', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('234', 'B005', 'P023', '103100000026', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('235', 'B004', 'P023', '104100000004', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('236', 'B012', 'P023', '310290000013', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('237', 'B003', 'P023', '301290000007', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('238', 'B009', 'P023', '306581000003', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('239', 'B013', 'P023', '302100011000', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('240', 'B008', 'P023', '303100000006', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('241', 'B007', 'P023', '309391000011', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('242', 'B010', 'P023', '313584099990', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('243', 'B011', 'P023', '304100040000', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('244', 'B021', 'P023', '403100000004', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('245', 'B006', 'P034', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('246', 'B005', 'P034', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('247', 'B015', 'P034', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('248', 'B003', 'P034', 'BOCM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('249', 'B004', 'P034', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('250', 'B016', 'P034', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('251', 'B021', 'P034', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('252', 'B011', 'P034', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('253', 'B007', 'P034', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('254', 'B009', 'P034', 'CGB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('255', 'B013', 'P034', 'CITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('256', 'B010', 'P035', 'PAB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('257', 'B002', 'P035', 'BCCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('258', 'B006', 'P035', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('259', 'B005', 'P035', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('260', 'B004', 'P035', 'BOCSH', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('261', 'B015', 'P035', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('262', 'B016', 'P035', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('263', 'B012', 'P035', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('264', 'B009', 'P035', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('265', 'B003', 'P035', 'BOCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('266', 'B021', 'P035', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('267', 'B013', 'P035', 'CNCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('268', 'B018', 'P035', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('269', 'B008', 'P035', 'CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('270', 'B011', 'P035', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('271', 'B007', 'P035', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('272', 'B001', 'P035', 'BOS', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('273', 'B023', 'P035', 'SRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('274', 'B016', 'P025', '308584000013', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('275', 'B006', 'P025', '102100099996', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('276', 'B015', 'P025', '105100000017', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('277', 'B005', 'P025', '103100000026', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('278', 'B004', 'P025', '104100000004', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('279', 'B012', 'P025', '310290000013', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('280', 'B003', 'P025', '301290000007', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('281', 'B009', 'P025', '306581000003', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('282', 'B013', 'P025', '302100011000', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('283', 'B008', 'P025', '303100000006', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('284', 'B007', 'P025', '309391000011', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('285', 'B010', 'P025', '313584099990', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('286', 'B011', 'P025', '304100040000', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('287', 'B021', 'P025', '403100000004', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('288', 'B009', 'P021', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('289', 'B015', 'P021', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('290', 'B013', 'P021', 'ECITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('291', 'B012', 'P021', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('292', 'B010', 'P021', 'SPABANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('293', 'B021', 'P021', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('294', 'B007', 'P021', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('295', 'B011', 'P021', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('296', 'B026', 'P021', 'NBB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('297', 'B001', 'P021', 'SHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('298', 'B002', 'P021', 'BOB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('299', 'B008', 'P021', 'CEBB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('300', 'B018', 'P021', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('301', 'B004', 'P021', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('302', 'B006', 'P021', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('303', 'B003', 'P021', 'BCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('305', 'B005', 'P021', 'ABC', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('306', 'B020', 'P036', 'alipay_scan', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('307', 'B019', 'P036', 'weixin_scan', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('308', 'B006', 'P037', 'ICBC-NET-B2C', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('309', 'B016', 'P037', 'CMBCHINA-NET-B2C', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('310', 'B005', 'P037', 'ABC-NET-B2C', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('311', 'B015', 'P037', 'CCB-NET-B2C', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('312', 'B002', 'P037', 'BCCB-NET-B2C', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('313', 'B003', 'P037', 'BOCO-NET-B2C', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('314', 'B007', 'P037', 'CIB-NET-B2C', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('315', 'B018', 'P037', 'CMBC-NET-B2C', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('316', 'B008', 'P037', 'CEB-NET-B2C', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('317', 'B004', 'P037', 'BOC-NET-B2C', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('318', 'B013', 'P037', 'ECITIC-NET-B2C', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('319', 'B009', 'P037', 'GDB-NET-B2C', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('320', 'B021', 'P037', 'POST-NET-B2C', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('321', 'B011', 'P037', 'HXB-NET-B2C', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('326', 'B019', 'P038', 'weixin', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('327', 'B020', 'P039', 'alipay', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('328', 'B019', 'P037', 'weixin', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('329', 'B020', 'P037', 'alipay', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('333', 'B033', 'P040', 'web.pay', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('335', 'B019', 'P042', 'WECHATQR', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('336', 'B005', 'P041', 'ABC', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('337', 'B006', 'P041', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('338', 'B015', 'P041', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('339', 'B003', 'P041', 'BCOM', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('340', 'B004', 'P041', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('341', 'B016', 'P041', 'CMB', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('342', 'B018', 'P041', 'CMBC', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('343', 'B008', 'P041', 'CEBB', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('344', 'B007', 'P041', 'CIB', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('345', 'B021', 'P041', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('346', 'B010', 'P041', 'SPABANK', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('347', 'B013', 'P041', 'ECITIC', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('348', 'B009', 'P041', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('349', 'B011', 'P041', 'HXB', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('350', 'B012', 'P041', 'SPDB', '2');
INSERT INTO `thirdparty_payment_bank` VALUES ('351', 'B020', 'P042', 'ALIPAYQR', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('352', 'B032', 'P043', 'wap.pay', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('353', 'B005', 'P044', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('354', 'B006', 'P044', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('355', 'B015', 'P044', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('356', 'B003', 'P044', 'BCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('357', 'B004', 'P044', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('358', 'B016', 'P044', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('359', 'B018', 'P044', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('360', 'B008', 'P044', 'CEBB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('361', 'B007', 'P044', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('362', 'B021', 'P044', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('363', 'B010', 'P044', 'SPABANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('364', 'B013', 'P044', 'ECITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('365', 'B009', 'P044', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('366', 'B011', 'P044', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('367', 'B012', 'P044', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('368', 'B034', 'P042', 'QQWALLET', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('369', 'B019', 'P032', 'wx_sm', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('370', 'B020', 'P045', 'ali_sm', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('371', 'B034', 'P046', 'qq_sm', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('372', 'B006', 'P047', '00004', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('373', 'B016', 'P047', '00021', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('374', 'B015', 'P047', '00003', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('375', 'B005', 'P047', '00017', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('376', 'B004', 'P047', '00083', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('379', 'B009', 'P047', '00052', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('380', 'B008', 'P047', '00057', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('381', 'B018', 'P047', '00013', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('382', 'B013', 'P047', '00054', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('386', 'B002', 'P047', '00050', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('387', 'B011', 'P047', '00041', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('391', 'B019', 'P048', 'wechat', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('392', 'B020', 'P048', 'alipay', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('393', 'B034', 'P048', 'qqwallet', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('394', 'B033', 'P049', 'PC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('395', 'B019', 'P052', 'wechat', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('396', 'B020', 'P052', 'alipay', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('397', 'B034', 'P052', 'qqwallet', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('398', 'B005', 'P058', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('399', 'B006', 'P058', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('400', 'B015', 'P058', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('401', 'B003', 'P058', 'BCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('402', 'B004', 'P058', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('403', 'B016', 'P058', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('404', 'B018', 'P058', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('405', 'B008', 'P058', 'CEBB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('406', 'B007', 'P058', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('407', 'B021', 'P058', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('408', 'B010', 'P058', 'SPABANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('409', 'B013', 'P058', 'ECITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('410', 'B009', 'P058', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('411', 'B011', 'P058', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('412', 'B012', 'P058', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('413', 'B019', 'P059', 'WECHATQR', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('414', 'B020', 'P059', 'ALIPAYQR', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('415', 'B034', 'P059', 'QQWALLET', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('416', 'B021', 'P030', 'BANK_PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('417', 'B025', 'P030', 'BANK_BEA', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('418', 'B002', 'P030', 'BANK_BOBJ', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('419', 'B009', 'P030', 'BANK_GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('420', 'B001', 'P030', 'BANK_SRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('421', 'B024', 'P030', 'BANK_BON', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('422', 'B023', 'P030', 'BANK_SRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('423', 'B022', 'P030', 'BANK_BJRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('424', 'B019', 'P063', 'wechat', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('425', 'B020', 'P063', 'alipay', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('426', 'B019', 'P050', 'wechat', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('427', 'B020', 'P050', 'alipay', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('428', 'B018', 'P034', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('429', 'B033', 'P065', 'NO', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('430', 'B032', 'P065', 'NO', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('431', 'B019', 'P057', '1004', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('432', 'B020', 'P057', '992', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('433', 'B034', 'P057', '993', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('434', 'B013', 'P056', '962', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('435', 'B004', 'P056', '963', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('436', 'B005', 'P056', '964', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('437', 'B015', 'P056', '965', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('438', 'B006', 'P056', '967', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('439', 'B016', 'P056', '970', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('440', 'B021', 'P056', '971', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('441', 'B007', 'P056', '972', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('442', 'B023', 'P056', '976', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('443', 'B012', 'P056', '977', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('444', 'B024', 'P056', '979', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('445', 'B018', 'P056', '980', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('446', 'B003', 'P056', '981', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('447', 'B009', 'P056', '985', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('448', 'B008', 'P056', '986', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('449', 'B002', 'P056', '989', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('450', 'B019', 'P073', '1007', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('451', 'B020', 'P073', '1006', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('452', 'B019', 'P071', 'WXPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('453', 'B020', 'P071', 'ALIPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('454', 'B034', 'P071', 'QQPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('455', 'B016', 'P070', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('456', 'B006', 'P070', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('457', 'B015', 'P070', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('458', 'B004', 'P070', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('459', 'B005', 'P070', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('460', 'B003', 'P070', 'BOCM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('461', 'B012', 'P070', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('462', 'B009', 'P070', 'CGB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('463', 'B013', 'P070', 'CITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('464', 'B008', 'P070', 'CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('465', 'B007', 'P070', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('466', 'B010', 'P070', 'PAYH', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('467', 'B018', 'P070', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('468', 'B011', 'P070', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('469', 'B021', 'P070', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('470', 'B002', 'P070', 'BCCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('471', 'B001', 'P070', 'SHBANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('472', 'B004', 'P072', '中国银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('473', 'B005', 'P072', '中国农业银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('474', 'B006', 'P072', '中国工商银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('475', 'B015', 'P072', '中国建设银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('476', 'B003', 'P072', '交通银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('477', 'B013', 'P072', '中信银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('478', 'B008', 'P072', '中国光大银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('479', 'B011', 'P072', '华夏银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('480', 'B009', 'P072', '广发银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('481', 'B010', 'P072', '平安银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('482', 'B016', 'P072', '招商银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('483', 'B018', 'P072', '中国民生银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('484', 'B007', 'P072', '兴业银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('485', 'B012', 'P072', '上海浦东发展银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('486', 'B023', 'P072', '上海农商银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('487', 'B021', 'P072', '中国邮政储蓄银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('488', 'B002', 'P072', '北京银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('489', 'B001', 'P072', '上海银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('490', 'B024', 'P072', '南京银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('491', 'B026', 'P072', '宁波银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('492', 'B030', 'P072', '渤海银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('493', 'B031', 'P072', '浙江稠州商业银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('494', 'B034', 'P050', 'qqpay', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('495', 'B006', 'P053', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('496', 'B005', 'P053', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('497', 'B015', 'P053', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('498', 'B012', 'P053', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('499', 'B007', 'P053', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('500', 'B018', 'P053', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('501', 'B003', 'P053', 'BCM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('502', 'B013', 'P053', 'CNCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('503', 'B008', 'P053', 'CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('504', 'B002', 'P053', 'BCCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('505', 'B016', 'P053', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('506', 'B009', 'P053', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('507', 'B001', 'P053', 'SHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('508', 'B004', 'P053', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('509', 'B011', 'P053', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('510', 'B010', 'P053', 'PAB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('511', 'B021', 'P053', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('512', 'B027', 'P053', 'SDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('513', 'B019', 'P054', 'WebMM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('514', 'B020', 'P054', 'ALIPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('515', 'B034', 'P052', 'QQPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('516', 'B019', 'P079', '2', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('517', 'B020', 'P079', '1', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('518', 'B034', 'P079', '3', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('519', 'B019', 'P080', '2', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('520', 'B020', 'P080', '1', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('521', 'B034', 'P080', '3', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('522', 'B005', 'P078', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('523', 'B004', 'P078', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('524', 'B015', 'P078', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('525', 'B008', 'P078', 'CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('526', 'B007', 'P078', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('527', 'B016', 'P078', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('528', 'B018', 'P078', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('529', 'B013', 'P078', 'CNCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('530', 'B003', 'P078', 'COMM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('531', 'B009', 'P078', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('532', 'B011', 'P078', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('533', 'B006', 'P078', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('534', 'B010', 'P078', 'PAB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('535', 'B021', 'P078', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('536', 'B012', 'P078', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('537', 'B005', 'P081', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('538', 'B004', 'P081', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('539', 'B030', 'P081', 'CBHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('540', 'B030', 'P078', 'CBHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('541', 'B015', 'P081', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('542', 'B008', 'P081', 'CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('543', 'B007', 'P081', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('545', 'B018', 'P081', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('546', 'B013', 'P081', 'CNCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('547', 'B003', 'P081', 'COMM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('548', 'B009', 'P081', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('549', 'B011', 'P081', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('550', 'B006', 'P081', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('551', 'B010', 'P081', 'PAB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('552', 'B021', 'P081', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('553', 'B012', 'P081', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('554', 'B016', 'P081', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('555', 'B033', 'P002', 'pay', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('556', 'B036', 'P083', 'UNIONPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('557', 'B035', 'P084', 'JDWALLET', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('558', 'B036', 'P085', '4', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('559', 'B019', 'P090', 'WECHATQR', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('560', 'B020', 'P090', 'ALIPAYQR', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('561', 'B034', 'P090', 'QQWALLET', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('562', 'B019', 'P091', 'WECHATWAP', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('563', 'B020', 'P091', 'ALIPAYWAP', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('564', 'B034', 'P091', 'QQWAP', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('565', 'B035', 'P094', 'JDWALLET', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('566', 'B005', 'P089', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('567', 'B006', 'P089', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('568', 'B015', 'P089', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('569', 'B003', 'P089', 'BCOM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('570', 'B004', 'P089', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('571', 'B016', 'P089', 'CMB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('572', 'B018', 'P089', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('573', 'B008', 'P089', 'CEBB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('574', 'B007', 'P089', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('575', 'B021', 'P089', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('576', 'B010', 'P089', 'SPABANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('577', 'B013', 'P089', 'ECITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('578', 'B009', 'P089', 'GDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('579', 'B011', 'P089', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('580', 'B012', 'P089', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('581', 'B035', 'P093', 'JDWALLET', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('582', 'B008', 'P034', 'CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('584', 'B006', 'P095', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('585', 'B015', 'P095', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('586', 'B004', 'P095', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('587', 'B005', 'P095', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('588', 'B003', 'P095', 'BOCM', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('590', 'B009', 'P095', 'CGB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('592', 'B008', 'P095', 'CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('595', 'B018', 'P095', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('597', 'B021', 'P095', 'PSBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('598', 'B002', 'P095', 'BCCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('599', 'B001', 'P095', 'SHBANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('600', 'B019', 'P096', 'WXPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('601', 'B020', 'P096', 'ALIPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('603', 'B035', 'P097', 'JDPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('604', 'B034', 'P096', 'QQPAY', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('605', 'B006', 'P104', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('606', 'B016', 'P104', 'CMBCHINA', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('607', 'B005', 'P104', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('608', 'B015', 'P104', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('609', 'B002', 'P104', 'BCCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('610', 'B003', 'P104', 'BOCO', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('611', 'B018', 'P104', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('612', 'B010', 'P104', 'PINGANBANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('613', 'B007', 'P104', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('614', 'B024', 'P104', 'NJCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('615', 'B008', 'P104', 'CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('616', 'B004', 'P104', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('617', 'B009', 'P104', 'CGB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('618', 'B001', 'P104', 'SHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('619', 'B012', 'P104', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('620', 'B021', 'P104', 'POST', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('621', 'B030', 'P104', 'CBHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('622', 'B025', 'P104', 'HKBEA', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('623', 'B026', 'P104', 'NBCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('624', 'B013', 'P104', 'ECITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('625', 'B022', 'P104', 'BJRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('626', 'B011', 'P104', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('627', 'B023', 'P104', 'SRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('632', 'B006', 'P108', 'ICBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('633', 'B016', 'P108', 'CMBCHINA', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('634', 'B005', 'P108', 'ABC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('635', 'B015', 'P108', 'CCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('636', 'B002', 'P108', 'BCCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('637', 'B003', 'P108', 'BOCO', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('638', 'B018', 'P108', 'CMBC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('639', 'B010', 'P108', 'PINGANBANK', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('640', 'B007', 'P108', 'CIB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('641', 'B024', 'P108', 'NJCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('642', 'B008', 'P108', 'CEB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('643', 'B004', 'P108', 'BOC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('644', 'B009', 'P108', 'CGB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('645', 'B001', 'P108', 'SHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('646', 'B012', 'P108', 'SPDB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('647', 'B021', 'P108', 'POST', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('648', 'B030', 'P108', 'CBHB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('649', 'B025', 'P108', 'HKBEA', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('650', 'B026', 'P108', 'NBCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('651', 'B013', 'P108', 'ECITIC', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('652', 'B022', 'P108', 'BJRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('653', 'B011', 'P108', 'HXB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('654', 'B023', 'P108', 'SRCB', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('655', 'B006', 'P098', '中国工商银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('656', 'B005', 'P098', '中国农业银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('657', 'B004', 'P098', '中国银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('658', 'B015', 'P098', '中国建设银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('659', 'B003', 'P098', '交通银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('660', 'B013', 'P098', '中信银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('661', 'B008', 'P098', '中国光大银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('662', 'B011', 'P098', '华夏银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('663', 'B018', 'P098', '中国民生银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('664', 'B009', 'P098', '广发银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('665', 'B010', 'P098', '平安银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('666', 'B016', 'P098', '招商银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('667', 'B007', 'P098', '兴业银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('668', 'B012', 'P098', '上海浦东发展银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('669', 'B002', 'P098', '北京银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('670', 'B024', 'P098', '南京银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('671', 'B026', 'P098', '宁波银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('672', 'B001', 'P098', '上海银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('673', 'B031', 'P098', '浙江稠州商业银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('674', 'B030', 'P098', '渤海银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('675', 'B023', 'P098', '上海农商银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('676', 'B022', 'P098', '北京农村商业银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('677', 'B021', 'P098', '中国邮政储蓄银行', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('678', 'B034', 'P105', '70000103', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('679', 'B020', 'P105', '20000303', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('680', 'B019', 'P105', '10000103', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('681', 'B035', 'P106', '80000103', '1');
INSERT INTO `thirdparty_payment_bank` VALUES ('682', 'B036', 'P107', '60000103', '1');

-- ----------------------------
-- Table structure for thirdparty_payment_type
-- ----------------------------
DROP TABLE IF EXISTS `thirdparty_payment_type`;
CREATE TABLE `thirdparty_payment_type` (
  `thirdpartypaymenttypecode` char(4) COLLATE utf8_bin NOT NULL COMMENT '第三方支付类型编码',
  `thirdpartypaymenttypename` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '第三方支付类型名称',
  `status` char(1) COLLATE utf8_bin NOT NULL COMMENT '状态',
  `datastatus` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`thirdpartypaymenttypecode`),
  UNIQUE KEY `UK_third_party_payment_thirdpa` (`thirdpartypaymenttypecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='第三方支付主表';


-- ----------------------------
-- Table structure for thirdparty_payment_type_setting
-- ----------------------------
DROP TABLE IF EXISTS `thirdparty_payment_type_setting`;
CREATE TABLE `thirdparty_payment_type_setting` (
  `paymentsettingcode` char(5) COLLATE utf8_bin NOT NULL COMMENT '第三方支付参数编码',
  `thirdpartypaymenttypecode` char(4) COLLATE utf8_bin NOT NULL COMMENT '第三方支付编码',
  `argumentfiled` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '参数字段',
  `argumentdesc` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '参数描述',
  `datastatus` char(2) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`paymentsettingcode`),
  KEY `FK_thirdparty_payment_type_setting_thirdparty_payment_type` (`thirdpartypaymenttypecode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='第三方支付参数表';


-- ----------------------------
-- Table structure for user_logs
-- ----------------------------
DROP TABLE IF EXISTS `user_logs`;
CREATE TABLE `user_logs` (
  `lsh` varchar(36) NOT NULL,
  `enterprisecode` char(6) DEFAULT NULL,
  `employeecode` char(8) DEFAULT NULL,
  `loginaccount` varchar(12) DEFAULT NULL,
  `operatype` varchar(20) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `operaer` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`lsh`),
  KEY `user_logs_ix2` (`enterprisecode`,`loginaccount`,`operatype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_money_in_and_out
-- ----------------------------
DROP TABLE IF EXISTS `user_money_in_and_out`;
CREATE TABLE `user_money_in_and_out` (
  `moneyinoutcode` char(16) COLLATE utf8_bin NOT NULL COMMENT '上下分编码',
  `employeecode` char(8) COLLATE utf8_bin NOT NULL COMMENT '员工编码',
  `gametype` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏类型',
  `parentemployeecode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '用户上级编码',
  `moneyinoutdate` datetime DEFAULT NULL COMMENT '上下分时间',
  `moneyinoutamount` decimal(16,4) DEFAULT NULL COMMENT '上下分金额',
  `moneyinoutcomment` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `beforebalance` decimal(16,4) DEFAULT NULL COMMENT '上下分前余额',
  `afterbalance` decimal(16,4) DEFAULT NULL COMMENT '上下分后余额',
  `updatecapital` char(1) COLLATE utf8_bin NOT NULL COMMENT '是否成功 (1：是 2：否)',
  `opreatetype` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '上下分类型（1：上分，2：下分）',
  `backmoney` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '是否返还金额（1：否 ， 2：是）',
  `timesort` bigint(20) DEFAULT NULL COMMENT '排序字段',
  `orderno` varchar(19) COLLATE utf8_bin DEFAULT '0',
  `patchno` varchar(19) COLLATE utf8_bin DEFAULT '0',
  `enterprisecode` char(8) COLLATE utf8_bin DEFAULT '0',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT '0',
  `isdown` varchar(1) COLLATE utf8_bin DEFAULT '1',
  PRIMARY KEY (`moneyinoutcode`),
  KEY `index_employeecode` (`employeecode`) USING BTREE,
  KEY `index_orderno` (`orderno`) USING BTREE,
  KEY `index_patchno` (`patchno`) USING BTREE,
  KEY `user_money_in_and_out_ix4` (`moneyinoutdate`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户账变';

-- ----------------------------
-- Records of user_money_in_and_out
-- ----------------------------

-- ----------------------------
-- Table structure for webview_template
-- ----------------------------
DROP TABLE IF EXISTS `webview_template`;
CREATE TABLE `webview_template` (
  `webtemplatecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '模板编码',
  `templatename` varchar(25) COLLATE utf8_bin NOT NULL COMMENT '模板名字',
  `sign` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '模板唯一标识',
  `templatetype` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '模板类型(CP:彩票, XJW:现金网)',
  `sitetype` char(1) COLLATE utf8_bin NOT NULL DEFAULT '1' COMMENT '1、会员站点  2、代理站点',
  PRIMARY KEY (`webtemplatecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='会员游戏界面模板';

-- ----------------------------
-- Table structure for working_flow_configuration
-- ----------------------------
DROP TABLE IF EXISTS `working_flow_configuration`;
CREATE TABLE `working_flow_configuration` (
  `flowcode` char(8) COLLATE utf8_bin NOT NULL COMMENT '流程编号',
  `flowname` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '流程名称',
  `enterprisecode` char(6) COLLATE utf8_bin NOT NULL COMMENT '企业编码',
  `brandcode` char(8) COLLATE utf8_bin DEFAULT NULL COMMENT '品牌编码',
  `flowtype` smallint(6) NOT NULL COMMENT '流程标志',
  `enable` smallint(6) NOT NULL COMMENT '是否启用',
  `flowsort` smallint(6) NOT NULL COMMENT '流程顺序',
  `flowthreshold` decimal(10,0) NOT NULL COMMENT '流程启动条件',
  `handletime` int(11) DEFAULT NULL COMMENT '处理时长',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `datastatus` smallint(6) NOT NULL DEFAULT '1' COMMENT '数据状态',
  PRIMARY KEY (`flowcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='工作流配置表';

-- ----------------------------
-- Table structure for working_flow_object
-- ----------------------------
DROP TABLE IF EXISTS `working_flow_object`;
CREATE TABLE `working_flow_object` (
  `employeecode` char(10) COLLATE utf8_bin NOT NULL COMMENT '员工编码',
  `flowcode` char(8) COLLATE utf8_bin NOT NULL COMMENT '工作流编码',
  PRIMARY KEY (`employeecode`,`flowcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='工作流审核对象';

-- ----------------------------
-- Table structure for zhf_citys
-- ----------------------------
DROP TABLE IF EXISTS `zhf_citys`;
CREATE TABLE `zhf_citys` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `parentcode` varchar(10) DEFAULT NULL,
  `ccode` varchar(10) DEFAULT NULL,
  `cname` varchar(50) DEFAULT NULL,
  `ename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB AUTO_INCREMENT=376 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhf_citys
-- ----------------------------
INSERT INTO `zhf_citys` VALUES ('2', '0', '11', '北京市', 'Beijing Municipality');
INSERT INTO `zhf_citys` VALUES ('3', '0', '12', '天津市', 'Tianjin Municipality');
INSERT INTO `zhf_citys` VALUES ('4', '0', '13', '河北省', 'Hebei Province');
INSERT INTO `zhf_citys` VALUES ('5', '0', '14', '山西省', 'Shanxi Province');
INSERT INTO `zhf_citys` VALUES ('6', '0', '15', '内蒙古', 'Inner Mogolia');
INSERT INTO `zhf_citys` VALUES ('7', '0', '21', '辽宁省', 'Liaoning Province');
INSERT INTO `zhf_citys` VALUES ('8', '0', '22', '吉林省', 'Jilin Province');
INSERT INTO `zhf_citys` VALUES ('9', '0', '23', '黑龙江省', 'Heilongjiang Province');
INSERT INTO `zhf_citys` VALUES ('10', '0', '31', '上海市', 'Shanghai Municipality');
INSERT INTO `zhf_citys` VALUES ('11', '0', '32', '江苏省', 'Jiangsu Province');
INSERT INTO `zhf_citys` VALUES ('12', '0', '33', '浙江省', 'Zhejiang Province');
INSERT INTO `zhf_citys` VALUES ('13', '0', '34', '安徽省', 'Anhui Province');
INSERT INTO `zhf_citys` VALUES ('14', '0', '35', '福建省', 'Fujian Province');
INSERT INTO `zhf_citys` VALUES ('15', '0', '36', '江西省', 'Jiangxi Province');
INSERT INTO `zhf_citys` VALUES ('16', '0', '37', '山东省', 'Shandong Province');
INSERT INTO `zhf_citys` VALUES ('17', '0', '41', '河南省', 'Henan Province');
INSERT INTO `zhf_citys` VALUES ('18', '0', '42', '湖北省', 'Hubei Province');
INSERT INTO `zhf_citys` VALUES ('19', '0', '43', '湖南省', 'Hunan Province');
INSERT INTO `zhf_citys` VALUES ('20', '0', '44', '广东省', 'Guangdong Province');
INSERT INTO `zhf_citys` VALUES ('21', '0', '45', '广西壮族自治区', 'Guangxi Zhuang Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('22', '0', '46', '海南省', 'Hainan Province');
INSERT INTO `zhf_citys` VALUES ('23', '0', '50', '重庆市', 'Chongqing Municipality');
INSERT INTO `zhf_citys` VALUES ('24', '0', '51', '四川省', 'Sichuan Province');
INSERT INTO `zhf_citys` VALUES ('25', '0', '52', '贵州省', 'Guizhou Province');
INSERT INTO `zhf_citys` VALUES ('26', '0', '53', '云南省', 'Yunnan Province');
INSERT INTO `zhf_citys` VALUES ('27', '0', '54', '西藏自治区', 'Tibet Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('28', '0', '61', '陕西省', 'Shanxi Province');
INSERT INTO `zhf_citys` VALUES ('29', '0', '62', '甘肃省', 'Gansu Province');
INSERT INTO `zhf_citys` VALUES ('30', '0', '63', '青海省', 'Qinghai Province');
INSERT INTO `zhf_citys` VALUES ('31', '0', '64', '宁夏回族自治区', 'Ningxia Hui Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('32', '0', '65', '新疆维吾尔自治区', 'Xinjiang Uygur Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('34', '11', '1000', '北京市', 'Beijing City');
INSERT INTO `zhf_citys` VALUES ('35', '12', '1100', '天津市', 'Tianjin City');
INSERT INTO `zhf_citys` VALUES ('36', '13', '1210', '石家庄市', 'Shijiazhuang City');
INSERT INTO `zhf_citys` VALUES ('37', '13', '1240', '唐山市', 'Tangshan City');
INSERT INTO `zhf_citys` VALUES ('38', '13', '1260', '秦皇岛市', 'Qinhuangdao City');
INSERT INTO `zhf_citys` VALUES ('39', '13', '1270', '邯郸市', 'Handan City');
INSERT INTO `zhf_citys` VALUES ('40', '13', '1310', '邢台市', 'Xingtai City');
INSERT INTO `zhf_citys` VALUES ('41', '13', '1340', '保定市', 'Baoding City');
INSERT INTO `zhf_citys` VALUES ('42', '13', '1380', '张家口市', 'Zhangjiakou City');
INSERT INTO `zhf_citys` VALUES ('43', '13', '1410', '承德市', 'Chengde City');
INSERT INTO `zhf_citys` VALUES ('44', '13', '1430', '沧州市', 'Cangzhou City');
INSERT INTO `zhf_citys` VALUES ('45', '13', '1460', '廊坊市', 'Langfang City');
INSERT INTO `zhf_citys` VALUES ('46', '13', '1480', '衡水市', 'Hengshui City');
INSERT INTO `zhf_citys` VALUES ('47', '14', '1610', '太原市', 'Taiyuan city');
INSERT INTO `zhf_citys` VALUES ('48', '14', '1620', '大同市', 'Datong City');
INSERT INTO `zhf_citys` VALUES ('49', '14', '1630', '阳泉市', 'Yangquan city');
INSERT INTO `zhf_citys` VALUES ('50', '14', '1640', '长治市', 'Changzhi City');
INSERT INTO `zhf_citys` VALUES ('51', '14', '1680', '晋城市', 'Jingcheng City');
INSERT INTO `zhf_citys` VALUES ('52', '14', '1690', '朔州市', 'Shuozhou City');
INSERT INTO `zhf_citys` VALUES ('53', '14', '1710', '忻州市', 'Xinzhou City');
INSERT INTO `zhf_citys` VALUES ('54', '14', '1730', '吕梁市', 'Lvliang City');
INSERT INTO `zhf_citys` VALUES ('55', '14', '1750', '晋中市', 'Jingzhong City');
INSERT INTO `zhf_citys` VALUES ('56', '14', '1770', '临汾市', 'Linfeng City');
INSERT INTO `zhf_citys` VALUES ('57', '14', '1810', '运城市', 'Yuncheng City');
INSERT INTO `zhf_citys` VALUES ('58', '15', '1910', '呼和浩特市', 'Hohhot City');
INSERT INTO `zhf_citys` VALUES ('59', '15', '1920', '包头市', 'Baotou City');
INSERT INTO `zhf_citys` VALUES ('60', '15', '1930', '乌海市', 'Wuhai City');
INSERT INTO `zhf_citys` VALUES ('61', '15', '1940', '赤峰市', 'Chifeng City');
INSERT INTO `zhf_citys` VALUES ('62', '15', '1960', '呼伦贝尔市', 'Hulunbeier City');
INSERT INTO `zhf_citys` VALUES ('63', '15', '1980', '兴安盟', 'Hinggan League');
INSERT INTO `zhf_citys` VALUES ('64', '15', '1990', '通辽市', 'Tongliao City');
INSERT INTO `zhf_citys` VALUES ('65', '15', '2010', '锡林郭勒盟', 'Xilin Gol League');
INSERT INTO `zhf_citys` VALUES ('66', '15', '2030', '乌兰察布市', 'Ulanqab City');
INSERT INTO `zhf_citys` VALUES ('67', '15', '2050', '鄂尔多斯市', 'Erdos City');
INSERT INTO `zhf_citys` VALUES ('68', '15', '2070', '巴彦淖尔市', 'Bayan Nur City');
INSERT INTO `zhf_citys` VALUES ('69', '15', '2080', '阿拉善盟', 'Alxa League');
INSERT INTO `zhf_citys` VALUES ('70', '21', '2210', '沈阳市', 'Shenyang City');
INSERT INTO `zhf_citys` VALUES ('71', '21', '2220', '大连市', 'Dalian City');
INSERT INTO `zhf_citys` VALUES ('72', '21', '2230', '鞍山市', 'Anshan City');
INSERT INTO `zhf_citys` VALUES ('73', '21', '2240', '抚顺市', 'Fushun City');
INSERT INTO `zhf_citys` VALUES ('74', '21', '2250', '本溪市', 'Benxi City');
INSERT INTO `zhf_citys` VALUES ('75', '21', '2260', '丹东市', 'Dandong City');
INSERT INTO `zhf_citys` VALUES ('76', '21', '2270', '锦州市', 'Jinzhou City');
INSERT INTO `zhf_citys` VALUES ('77', '21', '2276', '葫芦岛市', 'Huludao City');
INSERT INTO `zhf_citys` VALUES ('78', '21', '2280', '营口市', 'Yingkou City');
INSERT INTO `zhf_citys` VALUES ('79', '21', '2290', '阜新市', 'Fuxin City');
INSERT INTO `zhf_citys` VALUES ('80', '21', '2310', '辽阳市', 'Liaoyang City');
INSERT INTO `zhf_citys` VALUES ('81', '21', '2320', '盘锦市', 'Panjing City');
INSERT INTO `zhf_citys` VALUES ('82', '21', '2330', '铁岭市', 'Tieling City');
INSERT INTO `zhf_citys` VALUES ('83', '21', '2340', '朝阳市', 'Chaoyang City');
INSERT INTO `zhf_citys` VALUES ('84', '22', '2410', '长春市', 'Changchun City');
INSERT INTO `zhf_citys` VALUES ('85', '22', '2420', '吉林市', 'Jilin City');
INSERT INTO `zhf_citys` VALUES ('86', '22', '2430', '四平市', 'Siping City');
INSERT INTO `zhf_citys` VALUES ('87', '22', '2440', '辽源市', 'Liaoyuan City');
INSERT INTO `zhf_citys` VALUES ('88', '22', '2450', '通化市', 'Tonghua City');
INSERT INTO `zhf_citys` VALUES ('89', '22', '2460', '白山市', 'Baishan City');
INSERT INTO `zhf_citys` VALUES ('90', '22', '2470', '白城市', 'Baicheng City');
INSERT INTO `zhf_citys` VALUES ('91', '22', '2490', '延边朝鲜族自治州', 'Yanbian Korean Autonomous Prefecture');
INSERT INTO `zhf_citys` VALUES ('92', '22', '2520', '松原市', 'Songyuan City');
INSERT INTO `zhf_citys` VALUES ('93', '23', '2610', '哈尔滨市', 'Harbin City');
INSERT INTO `zhf_citys` VALUES ('94', '23', '2640', '齐齐哈尔市', 'Qiqihar City');
INSERT INTO `zhf_citys` VALUES ('95', '23', '2650', '大庆市', 'Daqing City');
INSERT INTO `zhf_citys` VALUES ('96', '23', '2660', '鸡西市', 'Jixi City');
INSERT INTO `zhf_citys` VALUES ('97', '23', '2670', '鹤岗市', 'Hegang City');
INSERT INTO `zhf_citys` VALUES ('98', '23', '2680', '双鸭山市', 'Shuangyashan City');
INSERT INTO `zhf_citys` VALUES ('99', '23', '2690', '佳木斯市', 'Jiamusi City');
INSERT INTO `zhf_citys` VALUES ('100', '23', '2710', '伊春市', 'Yichun City');
INSERT INTO `zhf_citys` VALUES ('101', '23', '2720', '牡丹江市', 'Mudanjiang City');
INSERT INTO `zhf_citys` VALUES ('102', '23', '2740', '七台河市', 'Qitaihe City');
INSERT INTO `zhf_citys` VALUES ('103', '23', '2760', '绥化市', 'Suihua City');
INSERT INTO `zhf_citys` VALUES ('104', '23', '2780', '黑河市', 'Heihe City');
INSERT INTO `zhf_citys` VALUES ('105', '23', '2790', '大兴安岭地区', 'Daxinganling region');
INSERT INTO `zhf_citys` VALUES ('106', '31', '2900', '上海市', 'Shanghai City');
INSERT INTO `zhf_citys` VALUES ('107', '32', '3010', '南京市', 'Nanjing City');
INSERT INTO `zhf_citys` VALUES ('108', '32', '3020', '无锡市', 'Wuxi City');
INSERT INTO `zhf_citys` VALUES ('109', '32', '3030', '徐州市', 'Xuzhou City');
INSERT INTO `zhf_citys` VALUES ('110', '32', '3040', '常州市', 'Changzhou City');
INSERT INTO `zhf_citys` VALUES ('111', '32', '3050', '苏州市', 'Suzhou City');
INSERT INTO `zhf_citys` VALUES ('112', '32', '3060', '南通市', 'Nantong City');
INSERT INTO `zhf_citys` VALUES ('113', '32', '3070', '连云港市', 'Lianyungang City');
INSERT INTO `zhf_citys` VALUES ('114', '32', '3080', '淮安市', 'Huai An City');
INSERT INTO `zhf_citys` VALUES ('115', '32', '3090', '宿迁市', 'Suqian City');
INSERT INTO `zhf_citys` VALUES ('116', '32', '3110', '盐城市', 'Yancheng City');
INSERT INTO `zhf_citys` VALUES ('117', '32', '3120', '扬州市', 'Yangzhou City');
INSERT INTO `zhf_citys` VALUES ('118', '32', '3128', '泰州市', 'Taizhou City');
INSERT INTO `zhf_citys` VALUES ('119', '32', '3140', '镇江市', 'Zhenjiang City');
INSERT INTO `zhf_citys` VALUES ('120', '33', '3310', '杭州市', 'Hangzhou City');
INSERT INTO `zhf_citys` VALUES ('121', '33', '3320', '宁波市', 'Ningbo City');
INSERT INTO `zhf_citys` VALUES ('122', '33', '3330', '温州市', 'Wenzhou City');
INSERT INTO `zhf_citys` VALUES ('123', '33', '3350', '嘉兴市', 'Jiaxing City');
INSERT INTO `zhf_citys` VALUES ('124', '33', '3360', '湖州市', 'Huzhou City');
INSERT INTO `zhf_citys` VALUES ('125', '33', '3370', '绍兴市', 'Shaoxing City');
INSERT INTO `zhf_citys` VALUES ('126', '33', '3380', '金华市', 'Jinhua City');
INSERT INTO `zhf_citys` VALUES ('127', '33', '3410', '衢州市', 'Quzhou City');
INSERT INTO `zhf_citys` VALUES ('128', '33', '3420', '舟山市', 'Zhoushan City');
INSERT INTO `zhf_citys` VALUES ('129', '33', '3430', '丽水市', 'Lishui City');
INSERT INTO `zhf_citys` VALUES ('130', '33', '3450', '台州市', 'Taizhou City');
INSERT INTO `zhf_citys` VALUES ('131', '34', '3610', '合肥市', 'Hefei City');
INSERT INTO `zhf_citys` VALUES ('132', '34', '3620', '芜湖市', 'Wuhu City');
INSERT INTO `zhf_citys` VALUES ('133', '34', '3630', '蚌埠市', 'Bengbu City');
INSERT INTO `zhf_citys` VALUES ('134', '34', '3640', '淮南市', 'Huainan City');
INSERT INTO `zhf_citys` VALUES ('135', '34', '3650', '马鞍山市', 'Ma’anshan City');
INSERT INTO `zhf_citys` VALUES ('136', '34', '3660', '淮北市', 'Huaibei City');
INSERT INTO `zhf_citys` VALUES ('137', '34', '3670', '铜陵市', 'Tongling City');
INSERT INTO `zhf_citys` VALUES ('138', '34', '3680', '安庆市', 'Anqing City');
INSERT INTO `zhf_citys` VALUES ('139', '34', '3710', '黄山市', 'Huangshan City');
INSERT INTO `zhf_citys` VALUES ('140', '34', '3720', '阜阳市', 'Fuyang City');
INSERT INTO `zhf_citys` VALUES ('141', '34', '3722', '亳州市', 'Bozhou City');
INSERT INTO `zhf_citys` VALUES ('142', '34', '3740', '宿州市', 'Suzhou City');
INSERT INTO `zhf_citys` VALUES ('143', '34', '3750', '滁州市', 'Chuzhou City');
INSERT INTO `zhf_citys` VALUES ('144', '34', '3760', '六安市', 'Liu’an City');
INSERT INTO `zhf_citys` VALUES ('145', '34', '3771', '宣城市', 'Xuancheng City');
INSERT INTO `zhf_citys` VALUES ('146', '34', '3781', '巢湖市', 'Chaohu City');
INSERT INTO `zhf_citys` VALUES ('147', '34', '3790', '池州市', 'Chizhou City');
INSERT INTO `zhf_citys` VALUES ('148', '35', '3910', '福州市', 'Fuzhou City');
INSERT INTO `zhf_citys` VALUES ('149', '35', '3930', '厦门市', 'Xiamen City');
INSERT INTO `zhf_citys` VALUES ('150', '35', '3940', '莆田市', 'Putian City');
INSERT INTO `zhf_citys` VALUES ('151', '35', '3950', '三明市', 'Sanming City');
INSERT INTO `zhf_citys` VALUES ('152', '35', '3970', '泉州市', 'Quanzhou City');
INSERT INTO `zhf_citys` VALUES ('153', '35', '3990', '漳州市', 'Zhangzhou City');
INSERT INTO `zhf_citys` VALUES ('154', '35', '4010', '南平市', 'Nanping City');
INSERT INTO `zhf_citys` VALUES ('155', '35', '4030', '宁德市', 'Ningde City');
INSERT INTO `zhf_citys` VALUES ('156', '35', '4050', '龙岩市', 'Longyan City');
INSERT INTO `zhf_citys` VALUES ('157', '36', '4210', '南昌市', 'Nanchang City');
INSERT INTO `zhf_citys` VALUES ('158', '36', '4220', '景德镇市', 'Jingdezhen City');
INSERT INTO `zhf_citys` VALUES ('159', '36', '4230', '萍乡市', 'Pingxiang City');
INSERT INTO `zhf_citys` VALUES ('160', '36', '4240', '九江市', 'Jiujiang City');
INSERT INTO `zhf_citys` VALUES ('161', '36', '4260', '新余市', 'Xinyu City');
INSERT INTO `zhf_citys` VALUES ('162', '36', '4270', '鹰潭市', 'Yingtan City');
INSERT INTO `zhf_citys` VALUES ('163', '36', '4280', '赣州市', 'Ganzhou City');
INSERT INTO `zhf_citys` VALUES ('164', '36', '4310', '宜春市', 'Yichun City');
INSERT INTO `zhf_citys` VALUES ('165', '36', '4330', '上饶市', 'Shangrao City');
INSERT INTO `zhf_citys` VALUES ('166', '36', '4350', '吉安市', 'Ji’an City');
INSERT INTO `zhf_citys` VALUES ('167', '36', '4370', '抚州市', 'Fuzhou City');
INSERT INTO `zhf_citys` VALUES ('168', '37', '4510', '济南市', 'Jinan City');
INSERT INTO `zhf_citys` VALUES ('169', '37', '4520', '青岛市', 'Qingdao City');
INSERT INTO `zhf_citys` VALUES ('170', '37', '4530', '淄博市', 'Zibo City');
INSERT INTO `zhf_citys` VALUES ('171', '37', '4540', '枣庄市', 'Zaozhuang City');
INSERT INTO `zhf_citys` VALUES ('172', '37', '4550', '东营市', 'Dongying City');
INSERT INTO `zhf_citys` VALUES ('173', '37', '4560', '烟台市', 'Yantai City');
INSERT INTO `zhf_citys` VALUES ('174', '37', '4580', '潍坊市', 'Weifang City');
INSERT INTO `zhf_citys` VALUES ('175', '37', '4610', '济宁市', 'Jining City');
INSERT INTO `zhf_citys` VALUES ('176', '37', '4630', '泰安市', 'Tai’an City');
INSERT INTO `zhf_citys` VALUES ('177', '37', '4634', '莱芜市', 'Laiwu City');
INSERT INTO `zhf_citys` VALUES ('178', '37', '4650', '威海市', 'Weihai City');
INSERT INTO `zhf_citys` VALUES ('179', '37', '4660', '滨州市', 'Binzhou City');
INSERT INTO `zhf_citys` VALUES ('180', '37', '4680', '德州市', 'Dezhou City');
INSERT INTO `zhf_citys` VALUES ('181', '37', '4710', '聊城市', 'Liaocheng City');
INSERT INTO `zhf_citys` VALUES ('182', '37', '4730', '临沂市', 'Linyi City');
INSERT INTO `zhf_citys` VALUES ('183', '37', '4732', '日照市', 'Rizhao City');
INSERT INTO `zhf_citys` VALUES ('184', '37', '4750', '菏泽市', 'Heze City');
INSERT INTO `zhf_citys` VALUES ('185', '41', '4910', '郑州市', 'Zhengzhou City');
INSERT INTO `zhf_citys` VALUES ('186', '41', '4920', '开封市', 'Kaifeng City');
INSERT INTO `zhf_citys` VALUES ('187', '41', '4930', '洛阳市', 'Luoyang City');
INSERT INTO `zhf_citys` VALUES ('188', '41', '4950', '平顶山市', 'Pingdingshan City');
INSERT INTO `zhf_citys` VALUES ('189', '41', '4960', '安阳市', 'Anyang City');
INSERT INTO `zhf_citys` VALUES ('190', '41', '4970', '鹤壁市', 'Hebi City');
INSERT INTO `zhf_citys` VALUES ('191', '41', '4980', '新乡市', 'Xinxiang City');
INSERT INTO `zhf_citys` VALUES ('192', '41', '5010', '焦作市', 'Jiaozuo City');
INSERT INTO `zhf_citys` VALUES ('193', '41', '5020', '濮阳市', 'Puyang City');
INSERT INTO `zhf_citys` VALUES ('194', '41', '5030', '许昌市', 'Xuchang City');
INSERT INTO `zhf_citys` VALUES ('195', '41', '5040', '漯河市', 'Luohe City');
INSERT INTO `zhf_citys` VALUES ('196', '41', '5050', '三门峡市', 'Sanmenxia City');
INSERT INTO `zhf_citys` VALUES ('197', '41', '5060', '商丘市', 'Shangqiu City');
INSERT INTO `zhf_citys` VALUES ('198', '41', '5080', '周口市', 'Zhoukou City');
INSERT INTO `zhf_citys` VALUES ('199', '41', '5110', '驻马店市', 'Zhumendian City');
INSERT INTO `zhf_citys` VALUES ('200', '41', '5130', '南阳市', 'Nanyang City');
INSERT INTO `zhf_citys` VALUES ('201', '41', '5150', '信阳市', 'Xinyang City');
INSERT INTO `zhf_citys` VALUES ('202', '42', '5210', '武汉市', 'Wuhan City');
INSERT INTO `zhf_citys` VALUES ('203', '42', '5220', '黄石市', 'Huangshi City');
INSERT INTO `zhf_citys` VALUES ('204', '42', '5230', '十堰市', 'Shiyan City');
INSERT INTO `zhf_citys` VALUES ('205', '42', '5260', '宜昌市', 'Yichang City');
INSERT INTO `zhf_citys` VALUES ('206', '42', '5280', '襄樊市', 'Xiangfan City');
INSERT INTO `zhf_citys` VALUES ('207', '42', '5286', '随州市', 'Suizhou City');
INSERT INTO `zhf_citys` VALUES ('208', '42', '5310', '鄂州市', 'Ezhou City');
INSERT INTO `zhf_citys` VALUES ('209', '42', '5320', '荆门市', 'Jinmen City');
INSERT INTO `zhf_citys` VALUES ('210', '42', '5330', '黄冈市', 'Huanggang City');
INSERT INTO `zhf_citys` VALUES ('211', '42', '5350', '孝感市', 'Xiaogan City');
INSERT INTO `zhf_citys` VALUES ('212', '42', '5360', '咸宁市', 'Xianning City');
INSERT INTO `zhf_citys` VALUES ('213', '42', '5370', '荆州市', 'Jinzhou City');
INSERT INTO `zhf_citys` VALUES ('214', '42', '5410', '恩施州', 'Enshi Prefecture');
INSERT INTO `zhf_citys` VALUES ('215', '43', '5510', '长沙市', 'Changsha City');
INSERT INTO `zhf_citys` VALUES ('216', '43', '5520', '株州市', 'Zhuzhou City');
INSERT INTO `zhf_citys` VALUES ('217', '43', '5530', '湘潭市', 'Xiangtan City');
INSERT INTO `zhf_citys` VALUES ('218', '43', '5540', '衡阳市', 'Hengyang City');
INSERT INTO `zhf_citys` VALUES ('219', '43', '5550', '邵阳市', 'Shaoyang City');
INSERT INTO `zhf_citys` VALUES ('220', '43', '5570', '岳阳市', 'Yueyang City');
INSERT INTO `zhf_citys` VALUES ('221', '43', '5580', '常德市', 'Changde City');
INSERT INTO `zhf_citys` VALUES ('222', '43', '5590', '张家界市', 'Zhangjiajie City');
INSERT INTO `zhf_citys` VALUES ('223', '43', '5610', '益阳市', 'Yiyang City');
INSERT INTO `zhf_citys` VALUES ('224', '43', '5620', '娄底市', 'Loudi City');
INSERT INTO `zhf_citys` VALUES ('225', '43', '5630', '郴州市', 'Chenzhou City');
INSERT INTO `zhf_citys` VALUES ('226', '43', '5650', '永州市', 'Yongzhou City');
INSERT INTO `zhf_citys` VALUES ('227', '43', '5670', '怀化市', 'Huaihua City');
INSERT INTO `zhf_citys` VALUES ('228', '43', '5690', '吉首市', 'Jishou City');
INSERT INTO `zhf_citys` VALUES ('229', '44', '5810', '广州市', 'Guangzhou City');
INSERT INTO `zhf_citys` VALUES ('230', '44', '5820', '韶关市', 'Shaoguan City');
INSERT INTO `zhf_citys` VALUES ('231', '44', '5840', '深圳市', 'Shenzhen City');
INSERT INTO `zhf_citys` VALUES ('232', '44', '5850', '珠海市', 'Zhuhai City');
INSERT INTO `zhf_citys` VALUES ('233', '44', '5860', '汕头市', 'Shantou City');
INSERT INTO `zhf_citys` VALUES ('234', '44', '5865', '揭阳市', 'Jieyang City');
INSERT INTO `zhf_citys` VALUES ('235', '44', '5869', '潮州市', 'Chaozhou City');
INSERT INTO `zhf_citys` VALUES ('236', '44', '5880', '佛山市', 'Foshan City');
INSERT INTO `zhf_citys` VALUES ('237', '44', '5890', '江门市', 'Jiangmen City');
INSERT INTO `zhf_citys` VALUES ('238', '44', '5910', '湛江市', 'Zhanjiang City');
INSERT INTO `zhf_citys` VALUES ('239', '44', '5920', '茂名市', 'Maoming City');
INSERT INTO `zhf_citys` VALUES ('240', '44', '5930', '肇庆市', 'Zhaoqing City');
INSERT INTO `zhf_citys` VALUES ('241', '44', '5937', '云浮市', 'Yunfu City');
INSERT INTO `zhf_citys` VALUES ('242', '44', '5950', '惠州市', 'Huizhou City');
INSERT INTO `zhf_citys` VALUES ('243', '44', '5960', '梅州市', 'Meizhou City');
INSERT INTO `zhf_citys` VALUES ('244', '44', '5970', '汕尾市', 'Shanwei City');
INSERT INTO `zhf_citys` VALUES ('245', '44', '5980', '河源市', 'Heyuan City');
INSERT INTO `zhf_citys` VALUES ('246', '44', '5990', '阳江市', 'Yangjiang City');
INSERT INTO `zhf_citys` VALUES ('247', '44', '6010', '清远市', 'Qingyuan City');
INSERT INTO `zhf_citys` VALUES ('248', '44', '6020', '东莞市', 'Dongguan City');
INSERT INTO `zhf_citys` VALUES ('249', '44', '6030', '中山市', 'Zhongshan City');
INSERT INTO `zhf_citys` VALUES ('250', '45', '6110', '南宁市', 'Nanning City');
INSERT INTO `zhf_citys` VALUES ('251', '45', '6128', '崇左市', 'Chongzuo City');
INSERT INTO `zhf_citys` VALUES ('252', '45', '6140', '柳州市', 'Liuzhou City');
INSERT INTO `zhf_citys` VALUES ('253', '45', '6155', '来宾市', 'Laibing City');
INSERT INTO `zhf_citys` VALUES ('254', '45', '6170', '桂林市', 'Guilin City');
INSERT INTO `zhf_citys` VALUES ('255', '45', '6210', '梧州市', 'Wuzhou City');
INSERT INTO `zhf_citys` VALUES ('256', '45', '6225', '贺州市', 'Hezhou City');
INSERT INTO `zhf_citys` VALUES ('257', '45', '6230', '北海市', 'Beihai City');
INSERT INTO `zhf_citys` VALUES ('258', '45', '6240', '玉林市', 'Yulin City');
INSERT INTO `zhf_citys` VALUES ('259', '45', '6242', '贵港市', 'Guigang City');
INSERT INTO `zhf_citys` VALUES ('260', '45', '6261', '百色市', 'Baise City');
INSERT INTO `zhf_citys` VALUES ('261', '45', '6281', '河池市', 'Hechi City');
INSERT INTO `zhf_citys` VALUES ('262', '45', '6311', '钦州市', 'Qingzhou City');
INSERT INTO `zhf_citys` VALUES ('263', '45', '6330', '防城港市', 'Fangchenggang City');
INSERT INTO `zhf_citys` VALUES ('264', '46', '6410', '海口市', 'Haikou City');
INSERT INTO `zhf_citys` VALUES ('265', '46', '6420', '三亚市', 'Sanya City');
INSERT INTO `zhf_citys` VALUES ('266', '51', '6510', '成都市', 'Chengdu City');
INSERT INTO `zhf_citys` VALUES ('267', '50', '6530', '重庆市', 'Chongqing City');
INSERT INTO `zhf_citys` VALUES ('268', '51', '6550', '自贡市', 'Zigong City');
INSERT INTO `zhf_citys` VALUES ('269', '51', '6560', '攀枝花市', 'Panzhihua City');
INSERT INTO `zhf_citys` VALUES ('270', '51', '6570', '泸州市', 'Luzhou City');
INSERT INTO `zhf_citys` VALUES ('271', '51', '6580', '德阳市', 'Deyang City');
INSERT INTO `zhf_citys` VALUES ('272', '51', '6590', '绵阳市', 'Mianyang City');
INSERT INTO `zhf_citys` VALUES ('273', '51', '6610', '广元市', 'Guangyuan City');
INSERT INTO `zhf_citys` VALUES ('274', '51', '6620', '遂宁市', 'Suining City');
INSERT INTO `zhf_citys` VALUES ('275', '51', '6630', '内江市', 'Neijiang City');
INSERT INTO `zhf_citys` VALUES ('276', '51', '6636', '资阳市', 'Ziyang City');
INSERT INTO `zhf_citys` VALUES ('277', '51', '6650', '乐山市', 'Leshan City');
INSERT INTO `zhf_citys` VALUES ('278', '51', '6652', '眉山市', 'Meishan City');
INSERT INTO `zhf_citys` VALUES ('279', '50', '6670', '万州区', 'Wanzhou District');
INSERT INTO `zhf_citys` VALUES ('280', '50', '6690', '涪陵区', 'Fuling District');
INSERT INTO `zhf_citys` VALUES ('281', '51', '6710', '宜宾市', 'Yibing City');
INSERT INTO `zhf_citys` VALUES ('282', '51', '6730', '南充市', 'Nanchong City');
INSERT INTO `zhf_citys` VALUES ('283', '51', '6737', '广安市', 'Guang’an City');
INSERT INTO `zhf_citys` VALUES ('284', '51', '6750', '达州市', 'Dazhou City');
INSERT INTO `zhf_citys` VALUES ('285', '51', '6758', '巴中市', 'Bazhong City');
INSERT INTO `zhf_citys` VALUES ('286', '51', '6770', '雅安市', 'Ya’an City');
INSERT INTO `zhf_citys` VALUES ('287', '51', '6790', '阿坝藏族羌族自治州', 'Aba Tibetan and Qiang Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('288', '51', '6810', '甘孜藏族自治州', 'Garze Tibetan Autonomous Prefecture');
INSERT INTO `zhf_citys` VALUES ('289', '51', '6840', '凉山彝族自治州', 'Yi Autonomous Prefecture of Liangshan');
INSERT INTO `zhf_citys` VALUES ('290', '50', '6870', '黔江区', 'Qianjiang District');
INSERT INTO `zhf_citys` VALUES ('291', '52', '7010', '贵阳市', 'Guiyang City');
INSERT INTO `zhf_citys` VALUES ('292', '52', '7020', '六盘水市', 'Liupanshui City');
INSERT INTO `zhf_citys` VALUES ('293', '52', '7030', '遵义市', 'Zunyi City');
INSERT INTO `zhf_citys` VALUES ('294', '52', '7050', '铜仁地区', 'Tongren District');
INSERT INTO `zhf_citys` VALUES ('295', '52', '7070', '黔西南州', 'Qianxinan Prefecture');
INSERT INTO `zhf_citys` VALUES ('296', '52', '7090', '毕节地区', 'Bijie District');
INSERT INTO `zhf_citys` VALUES ('297', '52', '7110', '安顺市', 'Anshun City');
INSERT INTO `zhf_citys` VALUES ('298', '52', '7130', '黔东南州', 'Qiandongnan Prefecture');
INSERT INTO `zhf_citys` VALUES ('299', '52', '7150', '黔南州', 'Qianan Prefecture');
INSERT INTO `zhf_citys` VALUES ('300', '53', '7310', '昆明市', 'Kunming City');
INSERT INTO `zhf_citys` VALUES ('301', '53', '7340', '昭通市', 'Zhaotong City');
INSERT INTO `zhf_citys` VALUES ('302', '53', '7360', '曲靖市', 'Qujing City');
INSERT INTO `zhf_citys` VALUES ('303', '53', '7380', '楚雄市', 'Chuxiong City');
INSERT INTO `zhf_citys` VALUES ('304', '53', '7410', '玉溪市', 'Yuxi City');
INSERT INTO `zhf_citys` VALUES ('305', '53', '7430', '红河哈尼族彝族自治州', 'Honghe Hani Autonomous Prefecture');
INSERT INTO `zhf_citys` VALUES ('306', '53', '7450', '文山壮族苗族自治州', 'Wenshan Zhuang-Miao Autonomous Prefecture');
INSERT INTO `zhf_citys` VALUES ('307', '53', '7470', '思茅市', 'Simao City');
INSERT INTO `zhf_citys` VALUES ('308', '53', '7490', '西双版纳傣族自治州', 'Xishuangbanna Dai Autonomous Prefecture');
INSERT INTO `zhf_citys` VALUES ('309', '53', '7510', '大理白族自治州', 'Dali Bai Autonomous prefecture');
INSERT INTO `zhf_citys` VALUES ('310', '53', '7530', '保山市', 'Baoshan City');
INSERT INTO `zhf_citys` VALUES ('311', '53', '7540', '德宏傣族景颇族自治州', 'Dehong Dai-Jingpo Autonomous Prefecture');
INSERT INTO `zhf_citys` VALUES ('312', '53', '7550', '丽江市', 'Lijiang City');
INSERT INTO `zhf_citys` VALUES ('313', '53', '7560', '怒江傈僳族自治州', 'Nujiang Lisu Autonomous Prefecture');
INSERT INTO `zhf_citys` VALUES ('314', '53', '7570', '迪庆藏族自治州', 'Diqing Tibetan Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('315', '53', '7580', '临沧市', 'Lincang City');
INSERT INTO `zhf_citys` VALUES ('316', '54', '7700', '拉萨市', 'Lhasa City');
INSERT INTO `zhf_citys` VALUES ('317', '54', '7720', '昌都地区', 'Changdu District');
INSERT INTO `zhf_citys` VALUES ('318', '54', '7740', '山南地区', 'Shannan District');
INSERT INTO `zhf_citys` VALUES ('319', '54', '7760', '日喀则地区', 'Shigatse District');
INSERT INTO `zhf_citys` VALUES ('320', '54', '7790', '那曲地区', 'Naqu Distri');
INSERT INTO `zhf_citys` VALUES ('321', '54', '7811', '阿里地区', 'Ali District');
INSERT INTO `zhf_citys` VALUES ('322', '54', '7830', '林芝地区', 'Linzhi District');
INSERT INTO `zhf_citys` VALUES ('323', '61', '7910', '西安市', 'Xi’an City');
INSERT INTO `zhf_citys` VALUES ('324', '61', '7920', '铜川市', 'Tongchuan City');
INSERT INTO `zhf_citys` VALUES ('325', '61', '7930', '宝鸡市', 'Baoji City');
INSERT INTO `zhf_citys` VALUES ('326', '61', '7950', '咸阳市', 'Xianyang City');
INSERT INTO `zhf_citys` VALUES ('327', '61', '7970', '渭南市', 'Weinan City');
INSERT INTO `zhf_citys` VALUES ('328', '61', '7990', '汉中市', 'Hanzhong City');
INSERT INTO `zhf_citys` VALUES ('329', '61', '8010', '安康市', 'Ankang City');
INSERT INTO `zhf_citys` VALUES ('330', '61', '8030', '商洛市', 'Shangluo City');
INSERT INTO `zhf_citys` VALUES ('331', '61', '8040', '延安市', 'Yan’an City');
INSERT INTO `zhf_citys` VALUES ('332', '61', '8060', '榆林市', 'Yulin City');
INSERT INTO `zhf_citys` VALUES ('333', '62', '8210', '兰州市', 'Lanzhou City');
INSERT INTO `zhf_citys` VALUES ('334', '62', '8220', '嘉峪关市', 'Jiayuguan City');
INSERT INTO `zhf_citys` VALUES ('335', '62', '8230', '金昌市', 'Jinchang City');
INSERT INTO `zhf_citys` VALUES ('336', '62', '8240', '白银市', 'Baiyin City');
INSERT INTO `zhf_citys` VALUES ('337', '62', '8250', '天水市', 'Tianshui City');
INSERT INTO `zhf_citys` VALUES ('338', '62', '8260', '酒泉市', 'Jiuquan City');
INSERT INTO `zhf_citys` VALUES ('339', '62', '8270', '张掖市', 'Zhangye City');
INSERT INTO `zhf_citys` VALUES ('340', '62', '8280', '武威市', 'Wuwei City');
INSERT INTO `zhf_citys` VALUES ('341', '62', '8290', '定西市', 'Dingxi City');
INSERT INTO `zhf_citys` VALUES ('342', '62', '8310', '陇南市', 'Longnan City');
INSERT INTO `zhf_citys` VALUES ('343', '62', '8330', '平凉市', 'Pingliang City');
INSERT INTO `zhf_citys` VALUES ('344', '62', '8340', '庆阳市', 'Qingyang City');
INSERT INTO `zhf_citys` VALUES ('345', '62', '8360', '临夏州', 'Linxia City');
INSERT INTO `zhf_citys` VALUES ('346', '62', '8380', '甘南州', 'Gannan Prefecture');
INSERT INTO `zhf_citys` VALUES ('347', '63', '8510', '西宁市', 'Xining City');
INSERT INTO `zhf_citys` VALUES ('348', '63', '8520', '海东地区', 'Haidong District');
INSERT INTO `zhf_citys` VALUES ('349', '63', '8540', '海北藏族自治州', 'Haibei Tibetan Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('350', '63', '8550', '黄南藏族自治州', 'Huangnan Tibetan Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('351', '63', '8560', '海南藏族自治州', 'Hainan Tibetan Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('352', '63', '8570', '果洛藏族自治州', 'Guoluo Tibetan Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('353', '63', '8580', '玉树藏族自治州', 'Yushu Tibetan Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('354', '63', '8590', '海西蒙古族藏族自治州', 'Haixi Mogolian-Tibetan Autonomous Region');
INSERT INTO `zhf_citys` VALUES ('355', '64', '8710', '银川市', 'Yinchuan City');
INSERT INTO `zhf_citys` VALUES ('356', '64', '8720', '石嘴山市', 'Shizuishan City');
INSERT INTO `zhf_citys` VALUES ('357', '64', '8731', '吴忠市', 'Wuzhong City');
INSERT INTO `zhf_citys` VALUES ('358', '64', '8733', '中卫市', 'Zhongwei City');
INSERT INTO `zhf_citys` VALUES ('359', '64', '8741', '固原市', 'Guyuan City');
INSERT INTO `zhf_citys` VALUES ('360', '65', '8810', '乌鲁木齐市', 'Urumqi City');
INSERT INTO `zhf_citys` VALUES ('361', '65', '8820', '克拉玛依市', 'Karamay City');
INSERT INTO `zhf_citys` VALUES ('362', '65', '8830', '吐鲁番市', 'Turpan city');
INSERT INTO `zhf_citys` VALUES ('363', '65', '8840', '哈密市', 'Hami City');
INSERT INTO `zhf_citys` VALUES ('364', '65', '8844', '阿勒泰地区', 'Altay Prefecture');
INSERT INTO `zhf_citys` VALUES ('365', '65', '8850', '昌吉回族自治州', 'Hui Autonomous Prefecture of Changji');
INSERT INTO `zhf_citys` VALUES ('366', '65', '8870', '博尔塔拉蒙古自治州', 'Bortala Mongol Autonomous Prefecture');
INSERT INTO `zhf_citys` VALUES ('367', '65', '8880', '巴音郭楞蒙古自治州', 'Bayingolin Mogol Autonomous Prefecture');
INSERT INTO `zhf_citys` VALUES ('368', '65', '8910', '阿克苏地区', 'Akesu Prefecture');
INSERT INTO `zhf_citys` VALUES ('369', '65', '8930', '克孜勒苏柯尔克孜自治州', 'Kizilsu Kirghiz Autonomous Prefecture');
INSERT INTO `zhf_citys` VALUES ('370', '65', '8940', '喀什地区', 'Kashi Prefecture');
INSERT INTO `zhf_citys` VALUES ('371', '65', '8960', '和田地区', 'Hotan Prefecture');
INSERT INTO `zhf_citys` VALUES ('372', '65', '8980', '伊犁哈萨克自治州', 'Kazak Autonomous Prefecture of Ili');
INSERT INTO `zhf_citys` VALUES ('373', '65', '9010', '塔城地区', 'Tacheng prefecture');
INSERT INTO `zhf_citys` VALUES ('374', '65', '9020', '阿勒泰地区', 'Altay Prefecture');
INSERT INTO `zhf_citys` VALUES ('375', '65', '9028', '石河子市', 'Shihezi City');

INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('1', '叶冠基', '6226097812597715', '13424261271', '恶意投诉勒索');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('2', '陶远林', '6214857556077446', '18513139448', '恶意投诉勒索');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('3', '王飞', '6217256300009023887', '18256560131', '恶意投诉勒索');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('4', '陈林', '', '15798950232', '恶意投诉勒索');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('5', '周伟超', '6217001500001379074', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('6', '周伟超', '6222031206000181727', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('7', '王勇', '6226620306419987', '18656588180', '恶意举报');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('8', '王勇', '6228480178500953975', '18656588180', '恶意举报');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('9', '王勇', '6217855300024014973', '18656588180', '恶意举报');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('10', '测试', '6226098899998888', '18612345678', '测试黑名单数据');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('11', '陈澳', '6212262201030704409', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('12', '梁承旺', '6236683030004158437', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('13', '梁承旺', '62178526000173339', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('14', '梁承旺', '6230521700001524679', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('15', '覃忠信', '6212262102002168831', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('16', '覃忠信', '6227003371370158797', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('17', '朱志科', '6228483478759099273', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('18', '黄伟', '622033100001363228', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('19', '李玉英', '6212261602019087461', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('20', '邓波', '62122631000175468000', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('21', '邓波', '6228480478594570879', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('22', '邓波', '6210983330008116858', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('23', '丛雪', '6217855300024014973', '15004684777', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('24', '林军北', '6228480395828148670', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('25', '徐丽华', '6228480332964747718', '13064532487', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('26', '张如斌', '6217002960106071373', '18118423911', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('27', '郭峰', '6228480178485429173', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('28', '董玉青', '6228482599102572475', '18225640380', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('29', '童成', '6228480405923872874', '13327882709', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('30', '刘昌', '6236692100000181995', '18079562811', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('31', '周勇', '6222021509003806964', '18664579851', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('32', '王丽文', '6228450266017798367', '15053540037', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('33', '王晓丽', '6212261606002019779', '', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('34', '刘平', '', '13717479135', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('35', '张飞飞', '', '15151555136', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('36', '田亮亮', '', '15358565345', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('37', '肖鹏骞', '', '13319593379', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('38', '娄强', '', '13521741494', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('39', '沈少雄', '', '13521741494', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('40', '沈少雄', '', '13390729199', '');
INSERT INTO `bankcards_blacklist` (`lsh`, `username`, `bankcard`, `phoneno`, `remark`) VALUES ('41', '王席东', '', '18852499333', '');


INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('1A53AEC4179E4E46AEE7EE752C16E3B1', '冲正', '1', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('204A417376604900BE9A2A7AA834F30F', '注册首充赠送', '2', '1', '-1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('2BC2CB7FDD7B4720906B56812E075F94', '游戏下分', '1', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('312302DD636E498286C1028FE80153DD', '取款拒绝', '1', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('56F82CC5B5DC4FFABBFD62F82CACA891', '周结校验补发', '1', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('577C286638534926B93C14489BB5C5C7', '上分失败返还', '1', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('5FFD22A671B5440DB46D5E3E7D36422F', '转出金额', '1', '2', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('6B06E77AA855454EB5ADF60B6CC37787', '洗码周结', '1', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('6EF182A8358C4F8C92FF8B814D4DA782', '笔笔存返利', '2', '1', '-1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('7DF02AB6F0854BF0831D5C4EA6646B3C', '取款驳回', '1', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('831F252CEAE94DD0A740260EE151A437', '冲负', '1', '2', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('836E5DFAE46C477DAE15A523A06D6E7C', '体验红包', '2', '1', '-1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('88C2DE5DBC644E94A81A876456809C2C', '签到抽奖', '2', '1', '-1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('8B322E2C4E414770A16FA042D7683E25', '测试活动', '2', '2', '-1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('8CD5E45210A44F3287CF2C0D7C61703E', '取款', '1', '2', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('8D37FD20D92043FA8D856590F0DFED0F', '存款', '1', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('9389569F3D9D4A3D81E80968F2D228E4', '积分兑换', '1', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('AF0B2F04CCA64E3197F047402FEE5832', '游戏上分', '1', '2', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('B1FF4C4ADC9C423C8D0344DDFD7DC279', '洗码日结', '1', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('C22A505981D8490781026BC899F3C692', '洗码冲减', '1', '2', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('D6B0C11A0AC44EBBB1538BE69B004811', '优惠活动', '2', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('E229B46CE9864EB8AE35D7C51CFEC04C', '转入金额', '1', '1', '1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('E95D65AE151D4471BC06B8AA4E25B717', '每日首充赠送', '2', '1', '-1');
INSERT INTO `employee_money_change_type` (`moneychangetypecode`, `moneychangetype`, `moneychangetypeclassify`, `moneyinouttype`, `datastatus`) VALUES ('F8ED21848E3E480CB8281CA9A20B2993', '输值月月返', '2', '1', '-1');




