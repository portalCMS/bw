-- add by xiaogao2017.12.18
ALTER TABLE enterprise ADD COLUMN `currencycode` char(8) COLLATE utf8_bin DEFAULT 'CNY' COMMENT '币种';

-- add by Clout: 后台首页dashboard面板数据统计的存储过程
DROP PROCEDURE IF EXISTS `ups_daily_deposit_report`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE ups_daily_deposit_report(IN in_enterprisecode CHAR(6), OUT out_passed INT, OUT out_review INT, OUT out_notpass INT)
BEGIN
	SELECT COUNT(1) INTO `out_passed` FROM deposit_withdraw_order WHERE enterprisecode = in_enterprisecode AND ordertype = 1 AND orderstatus = 2 AND orderdate >= CURDATE() AND orderdate <= DATE_ADD(CURDATE(), INTERVAL 1 DAY);
	SELECT COUNT(1) INTO `out_review` FROM deposit_withdraw_order WHERE enterprisecode = in_enterprisecode AND ordertype = 1 AND orderstatus = 1 AND orderdate >= CURDATE() AND orderdate <= DATE_ADD(CURDATE(), INTERVAL 1 DAY);
	SELECT COUNT(1) INTO `out_notpass`FROM deposit_withdraw_order WHERE enterprisecode = in_enterprisecode AND ordertype = 1 AND orderstatus = 4 AND orderdate >= CURDATE() AND orderdate <= DATE_ADD(CURDATE(), INTERVAL 1 DAY);
END;
;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `ups_daily_withdrawal_report`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE ups_daily_withdrawal_report(IN in_enterprisecode CHAR(6), OUT out_passed INT, OUT out_review INT, OUT out_notpass INT, OUT out_topaid INT)
BEGIN
	SELECT COUNT(1) INTO `out_passed` FROM deposit_withdraw_order WHERE enterprisecode = in_enterprisecode AND ordertype = 2 AND orderstatus = 2 AND orderdate >= CURDATE() AND orderdate <= DATE_ADD(CURDATE(), INTERVAL 1 DAY);
	SELECT COUNT(1) INTO `out_review` FROM deposit_withdraw_order WHERE enterprisecode = in_enterprisecode AND ordertype = 2 AND orderstatus = 1 AND orderdate >= CURDATE() AND orderdate <= DATE_ADD(CURDATE(), INTERVAL 1 DAY);
	SELECT COUNT(1) INTO `out_notpass`FROM deposit_withdraw_order WHERE enterprisecode = in_enterprisecode AND ordertype = 2 AND orderstatus = 4 AND orderdate >= CURDATE() AND orderdate <= DATE_ADD(CURDATE(), INTERVAL 1 DAY);
	SELECT COUNT(1) INTO `out_topaid` FROM deposit_withdraw_order WHERE enterprisecode = in_enterprisecode AND ordertype = 2 AND orderstatus = 5 AND orderdate >= CURDATE() AND orderdate <= DATE_ADD(CURDATE(), INTERVAL 1 DAY);
END;
;;
DELIMITER ;

-- add by xiaogao 12.28 在线支付相关
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P099', '畅汇网银', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P100', '畅汇微信', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P101', '畅汇快捷支付', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P102', '畅汇QQ钱包', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P103', '畅汇扫码支付', '1', '1');

-- add by xiaogao 01.01
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CP', 'P099', 'merCode', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CQ', 'P099', 'sha1Key', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CI', 'P099', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CA', 'P100', 'merCode', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CB', 'P100', 'sha1Key', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CC', 'P100', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CD', 'P101', 'merCode', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CE', 'P101', 'sha1Key', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CF', 'P101', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CJ', 'P102', 'merCode', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CK', 'P102', 'sha1Key', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CL', 'P102', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CM', 'P103', 'merCode', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CN', 'P103', 'sha1Key', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CO', 'P103', 'payUrl', '支付接口地址', '1');

INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CX', 'P099', 'paFrpId', '支付通道名称', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CY', 'P100', 'paFrpId', '支付通道名称', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CZ', 'P101', 'paFrpId', '支付通道名称', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0CW', 'P103', 'paFrpId', '支付通道名称', '1');
-- add by xiaogao 修改业务层级
UPDATE enterprise_employee_type set employeetype ='业主' where employeetypecode='T001';
INSERT INTO `enterprise_employee_type` (`employeetypecode`, `employeetype`, `datastatus`) VALUES ('T006', '大股东', '1');
INSERT INTO `enterprise_employee_type` (`employeetypecode`, `employeetype`, `datastatus`) VALUES ('T007', '股东', '1');
INSERT INTO `enterprise_employee_type` (`employeetypecode`, `employeetype`, `datastatus`) VALUES ('T008', '总代理', '1');

-- add by xiaogao 01.02 风云支付
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P109', '风云聚合网银', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P110', '风云聚合微信', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P111', '风云聚合QQ', '1', '1');

INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DA', 'P109', 'cid', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DB', 'P109', 'apiKey', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DC', 'P109', 'url', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DD', 'P109', 'type', '存款方式', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DE', 'P109', 'tFlag', '存款银行', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DF', 'P110', 'cid', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DG', 'P110', 'apiKey', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DK', 'P110', 'url', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DL', 'P110', 'type', '存款方式', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DO', 'P110', 'tFlag', '存款银行', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DP', 'P111', 'cid', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DQ', 'P111', 'apiKey', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DI', 'P111', 'url', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DS', 'P111', 'type', '存款方式', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0DT', 'P111', 'tFlag', '存款银行', '1');


-- add by xiaogao 01.08
ALTER TABLE game MODIFY COLUMN gametype VARCHAR(20) COMMENT '游戏平台编码';
INSERT INTO `game` (`gamecode`, `gametype`, `gamename`, `sort`, `picid`, `android`, `h5`, `iso`, `downloadurl`, `datastatus`) VALUES
('G035', 'BET67HYSX', '67bet-好赢真人', '35', 'pic035', NULL, NULL, NULL, NULL, '1'),
('G036', 'BET67ABSX', '67bet-欧博真人', '36', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G037', 'BET67EBETSX', '67bet-EBET真人', '37', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G038', 'BET67AGSX', '67bet-AG真人', '38', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G039', 'BET67BBINSX', '67bet-BBIN真人', '39', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G040', 'BET67GDSX', '67bet-GD真人', '40', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G041', 'BET67HGSX', '67bet-HG真人', '41', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G042', 'BET67SASX', '67bet-沙龙真人', '42', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G043', 'BET67OGSX', '67bet-OG真人', '43', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G044', 'BET67TSTY', '67bet-三升体育', '44', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G045', 'BET67VGQP', '67bet-VG棋牌', '45', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G046', 'BET67ELGDZ', '67bet-ELG电子', '46', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G047', 'BET67MGDZ', '67bet-MG电子', '47', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G048', 'BET67OGCP', '67bet-OG彩票', '48', 'pic036', NULL, NULL, NULL, NULL, '1');


ALTER TABLE game_category MODIFY COLUMN gametype VARCHAR(20) COMMENT '游戏平台编码';
INSERT INTO `game_category` (`categorycode`, `gametype`, `categorytype`, `categoryname`, `minbonus`, `maxbonus`, `sort`) VALUES 
('67', 'BET67HYSX', 'SX', '视讯', '0.0000', '1.0000', '1'),
('68', 'BET67OGCP', 'CP', '彩票', '0.0000', '1.0000', '2'),
('69', 'BET67ABSX', 'SX', '视讯', '0.0000', '1.0000', '3'),
('70', 'BET67TSTY', 'XY', '体育', '0.0000', '1.0000', '4'),
('71', 'BET67EBETSX', 'SX', '视讯', '0.0000', '1.0000', '5'),
('72', 'BET67VGQP', 'QP', '棋牌', '0.0000', '1.0000', '6'),
 ('73', 'BET67AGSX', 'SX', '视讯', '0.0000', '1.0000', '7'),
 ('74', 'BET67BBINSX', 'SX', '视讯', '0.0000', '1.0000', '8'),
('75', 'BET67GDSX', 'SX', '视讯', '0.0000', '1.0000', '9'),
 ('76', 'BET67HGSX', 'SX', '视讯', '0.0000', '1.0000', '10'),
('77', 'BET67SASX', 'SX', '视讯', '0.0000', '1.0000', '11'),
 ('78', 'BET67OGSX', 'SX', '视讯', '0.0000', '1.0000', '12'),
('79', 'BET67ELGDZ', 'DZ', '电子', '0.0000', '1.0000', '13'),
('80', 'BET67MGDZ', 'DZ', '电子', '0.0000', '1.0000', '14');

ALTER TABLE game_platform_prefix MODIFY COLUMN game_platform VARCHAR(20) COMMENT '游戏平台编码';

ALTER TABLE `employee_gamecataloy_bonus` MODIFY COLUMN `gametype` VARCHAR(20) COMMENT '游戏平台编码';
INSERT INTO `employee_gamecataloy_bonus` (`employeecode`, `gametype`, `categorytype`, `parentemployeecode`, `bonus`) VALUES
('E0000000', 'AGGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'AGGame', 'SX', '00000000', '1.0000'),
('E0000000', 'AVGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'BBINGame', 'CP', '00000000', '1.0000'),
('E0000000', 'BBINGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'BBINGame', 'SX', '00000000', '1.0000'),
('E0000000', 'BBINGame', 'TY', '00000000', '1.0000'),
('E0000000', 'BET67ABSX', 'SX', '00000000', '1.0000'),
('E0000000', 'BET67AGSX', 'SX', '00000000', '1.0000'),
('E0000000', 'BET67BBINSX', 'SX', '00000000', '1.0000'),
('E0000000', 'BET67EBETSX', 'SX', '00000000', '1.0000'),
('E0000000', 'BET67ELGDZ', 'DZ', '00000000', '1.0000'),
('E0000000', 'BET67GDSX', 'SX', '00000000', '1.0000'),
('E0000000', 'BET67HGSX', 'SX', '00000000', '1.0000'),
('E0000000', 'BET67HYSX', 'SX', '00000000', '1.0000'),
('E0000000', 'BET67MGDZ', 'DZ', '00000000', '1.0000'),
('E0000000', 'BET67OGCP', 'CP', '00000000', '1.0000'),
('E0000000', 'BET67OGSX', 'SX', '00000000', '1.0000'),
('E0000000', 'BET67SASX', 'SX', '00000000', '1.0000'),
('E0000000', 'BET67TSTY', 'XY', '00000000', '1.0000'),
('E0000000', 'BET67VGQP', 'QP', '00000000', '1.0000'),
('E0000000', 'EBETGame', 'SX', '00000000', '1.0000'),
('E0000000', 'GBGame', 'CP', '00000000', '1.0000'),
('E0000000', 'GGGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'GGPGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'GGPGame', 'QP', '00000000', '1.0000'),
('E0000000', 'GGPGame', 'SX', '00000000', '1.0000'),
('E0000000', 'HABGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'IBCGame', 'TY', '00000000', '1.0000'),
('E0000000', 'IDNGame', 'QP', '00000000', '1.0000'),
('E0000000', 'IMGame', 'TY', '00000000', '1.0000'),
('E0000000', 'JDBGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'M88Game', 'TY', '00000000', '1.0000'),
('E0000000', 'MGGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'MGGame', 'SX', '00000000', '1.0000'),
('E0000000', 'NHQGame', 'SX', '00000000', '1.0000'),
('E0000000', 'OGGame', 'SX', '00000000', '1.0000'),
('E0000000', 'PNGGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'PTGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'PTGame', 'SX', '00000000', '1.0000'),
('E0000000', 'QPGame', 'QP', '00000000', '1.0000'),
('E0000000', 'QTGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'QWPGame', 'QP', '00000000', '1.0000'),
('E0000000', 'SAGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'SAGame', 'SX', '00000000', '1.0000'),
('E0000000', 'SGSGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'SGSGame', 'SX', '00000000', '1.0000'),
('E0000000', 'TAGGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'TAGGame', 'SX', '00000000', '1.0000'),
('E0000000', 'TGPGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'TGPGame', 'SX', '00000000', '1.0000'),
('E0000000', 'TTGGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'W88Game', 'DZ', '00000000', '1.0000'),
('E0000000', 'W88Game', 'SX', '00000000', '1.0000'),
('E0000000', 'XCPGame', 'CP', '00000000', '1.0000'),
('E0000000', 'YAGGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'YAGGame', 'SX', '00000000', '1.0000'),
('E0000000', 'YoPLAYGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'ZJGame', 'SX', '00000000', '1.0000'),
('E0000000', 'eIBCGame', 'DZ', '00000000', '1.0000'),
('E0000000', 'eIBCGame', 'TY', '00000000', '1.0000');

REPLACE INTO `game_category` (`gametype`, `categorytype`, `categoryname`, `minbonus`, `maxbonus`, `sort`) VALUES 
('TGPI', 'DZ', '电子', '0.0000', '1.0000', '1'),
('TGPI', 'SX', '视讯', '0.0000', '1.0000', '1'),
('TGPI', 'TY', '体育', '0.0000', '1.0000', '1');

REPLACE INTO `employee_gamecataloy_bonus` (`employeecode`, `gametype`, `categorytype`, `parentemployeecode`, `bonus`) VALUES
('E0000000', 'TGPI', 'DZ', '00000000', '1.0000'),
('E0000000', 'TGPI', 'SX', '00000000', '1.0000'),
('E0000000', 'TGPI', 'TY', '00000000', '1.0000');

INSERT INTO `game` (`gamecode`, `gametype`, `gamename`, `sort`, `picid`, `android`, `h5`, `iso`, `downloadurl`, `datastatus`) VALUES
('G049', 'TGPI', 'TGP游戏接口', '49', 'pic049', NULL, NULL, NULL, NULL, '1');

-- add by xiaogao 2018.1.26
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.hy.live', '67BET好赢真人数据采集', '', '20180128153600', '0', '0', '0', '20', 'hy_live', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.og.lottery', '67BET OG彩票数据采集', '', '20180128153600', '0', '0', '0', '20', 'og_lottery', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.ob.live', '67BET欧博真人数据采集', '', '20180128153600', '0', '0', '0', '20', 'ob_live', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.ts.sport', '67BET三升真人数据采集', '', '20180128153600', '0', '0', '0', '20', 'ts_sport', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.ebet.live', '67BET EBET真人数据采集', '', '20180128153600', '0', '0', '0', '20', 'ebet_live', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.vg', '67BET VG棋牌数据采集', '', '20180128153600', '0', '0', '0', '20', 'vg', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.ag.live', '67BET AG真人数据采集', '', '20180128153600', '0', '0', '0', '20', 'ag_live', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.bbin.live', '67BET BBIN真人数据采集', '', '20180128153600', '0', '0', '0', '20', 'bbin_live', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.gd.live', '67BET GD真人数据采集', '', '20180128153600', '0', '0', '0', '20', 'gd_live', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.hg.live', '67BET HG真人数据采集', '', '20180128153600', '0', '0', '0', '20', 'hg_live', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.sl.live', '67BET 沙龙真人数据采集', '', '20180128153600', '0', '0', '0', '20', 'sl_live', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.og.live', '67BET OG真人数据采集', '', '20180128153600', '0', '0', '0', '20', 'og_live', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.elg.slot', '67BET ELG老虎机数据采集', '', '20180128153600', '0', '0', '0', '20', 'elg_slot', 'BET67');
INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`) VALUES ('begin.time.bet67.mg.slot', '67BET MG老虎机数据采集', '', '20180128153600', '0', '0', '0', '20', 'mg_slot', 'BET67');

DROP TABLE IF EXISTS `api_bet67_hylive_gameinfo`;
CREATE TABLE `api_bet67_hylive_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `betId` varchar(255) DEFAULT NULL COMMENT '投注编号',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `gameRoundId` varchar(32) DEFAULT NULL COMMENT '局号',
  `gameTypeName` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `validAmount` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betTypeName` varchar(255) DEFAULT NULL COMMENT '下单项',
  `gameResult` varchar(512) DEFAULT NULL COMMENT '游戏结果',
  `tableName` varchar(32) DEFAULT NULL COMMENT '桌号',
  `billTime` datetime DEFAULT NULL COMMENT '结算时间',
  `isBill` varchar(16) DEFAULT NULL COMMENT '结算状态',
  `betBefore` decimal(11,2) DEFAULT NULL COMMENT '下单前余额',
  `billAfter` decimal(11,2) DEFAULT NULL COMMENT '结算后余额',
  PRIMARY KEY (`id`),
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_gameRoundId` (`gameRoundId`) USING BTREE,
  KEY `IDX_gameTypeName` (`gameTypeName`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_betTypeName` (`betTypeName`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='67BET好赢真人投注记录表';

DROP TABLE IF EXISTS `betting_bet67_hylive`;
CREATE TABLE `betting_bet67_hylive` (
  `betId` varchar(255) NOT NULL DEFAULT '' COMMENT '投注ID',
  `gameRoundId` varchar(32) DEFAULT NULL COMMENT '局号',
  `gameTypeName` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `validAmount` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betTypeName` varchar(255) DEFAULT NULL COMMENT '下单项',
  `gameResult` varchar(512) DEFAULT NULL COMMENT '游戏结果',
  `tableName` varchar(32) DEFAULT NULL COMMENT '桌号',
  `billTime` datetime DEFAULT NULL COMMENT '结算时间',
  `isBill` varchar(16) DEFAULT NULL COMMENT '结算状态',
  `betBefore` decimal(11,2) DEFAULT NULL COMMENT '下单前余额',
  `billAfter` decimal(11,2) DEFAULT NULL COMMENT '结算后余额',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betid`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_betId` (`betid`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_gameRoundId` (`gameRoundId`) USING BTREE,
  KEY `IDX_gameTypeName` (`gameTypeName`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_betTypeName` (`betTypeName`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TRIGGER IF EXISTS `trg_api_bet67_hylive_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_bet67_hylive_gameinfo_after_insert` AFTER INSERT ON `api_bet67_hylive_gameinfo` FOR EACH ROW BEGIN


   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'HY' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.validAmount AS validbet, NEW.winOrLoss AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype  ,'BET67HYSX' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67HYSX';
		
   REPLACE INTO betting_bet67_hylive
    	SELECT NEW.betId,  
           NEW.gameRoundId,
           NEW.gameTypeName,
           NEW.betTime,
           NEW.betAmount,
           NEW.validAmount,
           NEW.winOrLoss,
           NEW.betTypeName,
           NEW.gameResult,
           NEW.tableName,
           NEW.billTime,           
           NEW.isBill,
           NEW.betBefore,
           NEW.billAfter,
          
		   loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'SX' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67HYSX';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_hylive_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_hylive_gameinfo_after_delete` AFTER DELETE ON `api_bet67_hylive_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_hylive WHERE betid = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'HY' AND gametype='BET67HYSX' AND platformid = OLD.betid;
END
;;

DROP TABLE IF EXISTS `api_bet67_tssport_gameinfo`;
CREATE TABLE `api_bet67_tssport_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `betId` varchar(128) DEFAULT NULL COMMENT '交易号',
  `isNormalWager` varchar(64) DEFAULT NULL COMMENT '是否普通注单',
  `playTypeName` varchar(64) DEFAULT NULL COMMENT '类别名称',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `matchName` varchar(64) DEFAULT NULL COMMENT '球赛名称',
  `eventName` varchar(64) DEFAULT NULL COMMENT '赛式名称',
  `matchDate` datetime DEFAULT NULL COMMENT '赛式时间',
  `betTypeName` varchar(128) DEFAULT NULL COMMENT '下单项目名称',
  `teamBetName` varchar(64) DEFAULT NULL COMMENT '下单方式名称',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `wagerOdds` varchar(16) DEFAULT NULL COMMENT '赔率',
  `wagerStake` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `winAmt` varchar(255) DEFAULT NULL COMMENT '结算结果',
  `score` varchar(64) DEFAULT NULL COMMENT '比分',
  `betStatus` varchar(32) DEFAULT NULL COMMENT '注单状态名称',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `handicap` varchar(64) DEFAULT NULL COMMENT '让球',
  `billTime` datetime DEFAULT NULL COMMENT '最后更新时间',
  `isBill` char(2) DEFAULT NULL COMMENT '是否结算',
  `betDetail` varchar(1024) DEFAULT NULL COMMENT '订单明细【html数据】',
  PRIMARY KEY (`id`),
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE,
  KEY `IDX_betStatus` (`betStatus`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_tssport`;
CREATE TABLE `betting_bet67_tssport` (
  `betId` varchar(128) NOT NULL DEFAULT '' COMMENT '交易号',
  `isNormalWager` varchar(64) DEFAULT NULL COMMENT '是否普通注单',
  `playTypeName` varchar(64) DEFAULT NULL COMMENT '类别名称',
  `matchName` varchar(64) DEFAULT NULL COMMENT '球赛名称',
  `eventName` varchar(64) DEFAULT NULL COMMENT '赛式名称',
  `matchDate` datetime DEFAULT NULL COMMENT '赛式时间',
  `betTypeName` varchar(128) DEFAULT NULL COMMENT '下单项目名称',
  `teamBetName` varchar(64) DEFAULT NULL COMMENT '下单方式名称',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `wagerOdds` varchar(16) DEFAULT NULL COMMENT '赔率',
  `wagerStake` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `winAmt` varchar(255) DEFAULT NULL COMMENT '结算结果',
  `score` varchar(64) DEFAULT NULL COMMENT '比分',
  `betStatus` varchar(32) DEFAULT NULL COMMENT '注单状态名称',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `handicap` varchar(64) DEFAULT NULL COMMENT '让球',
  `billTime` datetime DEFAULT NULL COMMENT '最后更新时间',
  `isBill` char(2) DEFAULT NULL COMMENT '是否结算',
  `betDetail` varchar(1024) DEFAULT NULL COMMENT '订单明细【html数据】',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE,
  KEY `IDX_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_tssport_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_tssport_gameinfo_after_insert` AFTER INSERT ON `api_bet67_tssport_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'TS' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.wagerStake AS betmoney, NEW.wagerStake AS validbet, NEW.winAmt AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'TY' AS gamebigtype  ,'BET67TSTY' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67TSTY';
		
   REPLACE INTO betting_bet67_tssport
    	SELECT NEW.betId,  
           NEW.isNormalWager,
           NEW.playTypeName,
           NEW.matchName,
           NEW.eventName,
           NEW.matchDate,
           NEW.betTypeName,
           NEW.teamBetName,
           NEW.betTime,
           NEW.wagerOdds,
           NEW.wagerStake,           
           NEW.winAmt,
           NEW.score,
           NEW.betStatus,
		  NEW.remark,
		  NEW.handicap,
		  NEW.billTime,
		  NEW.isBill,
		  NEW.betDetail,

		   loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'TY' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67TSTY';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_tssport_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_tssport_gameinfo_after_delete` AFTER DELETE ON `api_bet67_tssport_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_tssport WHERE betid = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'TS' AND gametype='BET67TSTY' AND platformid = OLD.betid;
END
;;

DROP TABLE IF EXISTS `api_bet67_oblive_gameinfo`;
CREATE TABLE `api_bet67_oblive_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `betId` varchar(128) DEFAULT NULL COMMENT '局号',
  `gameTypeName` varchar(64) DEFAULT NULL COMMENT '游戏类型',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `validAmount` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betStatus` varchar(32) DEFAULT NULL COMMENT '下单状态',
  `betTypeName` varchar(255) DEFAULT NULL COMMENT '下单项',
  `gameResult` varchar(255) DEFAULT NULL COMMENT '结果说明',
  `tableName` varchar(255) DEFAULT NULL COMMENT '桌台名称',
  `commissionName` varchar(255) DEFAULT NULL COMMENT '桌台类型',
  `gameStartTime` datetime DEFAULT NULL COMMENT '游戏开始时间',
  `gameEndTime` datetime DEFAULT NULL COMMENT '游戏结束时间',
  PRIMARY KEY (`id`),
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_betStatus` (`betStatus`) USING BTREE,
  KEY `IDX_gameStartTime` (`gameStartTime`) USING BTREE,
  KEY `IDX_gameEndTime` (`gameEndTime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_oblive`;
CREATE TABLE `betting_bet67_oblive` (
  `betId` varchar(128) DEFAULT NULL COMMENT '局号',
  `gameTypeName` varchar(64) DEFAULT NULL COMMENT '游戏类型',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `validAmount` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betStatus` varchar(32) DEFAULT NULL COMMENT '下单状态',
  `betTypeName` varchar(255) DEFAULT NULL COMMENT '下单项',
  `gameResult` varchar(255) DEFAULT NULL COMMENT '结果说明',
  `tableName` varchar(255) DEFAULT NULL COMMENT '桌台名称',
  `commissionName` varchar(255) DEFAULT NULL COMMENT '桌台类型',
  `gameStartTime` datetime DEFAULT NULL COMMENT '游戏开始时间',
  `gameEndTime` datetime DEFAULT NULL COMMENT '游戏结束时间',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_betStatus` (`betStatus`) USING BTREE,
  KEY `IDX_gameStartTime` (`gameStartTime`) USING BTREE,
  KEY `IDX_gameEndTime` (`gameEndTime`) USING BTREE,
  KEY `IDX_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_oblive_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_oblive_gameinfo_after_insert` AFTER INSERT ON `api_bet67_oblive_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'OB' platformtype, NEW.id AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.validAmount AS validbet, NEW.winOrLoss AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype  ,'BET67ABSX' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67ABSX';
		
   REPLACE INTO betting_bet67_oblive
    	SELECT NEW.id,  
           NEW.gameTypeName,
           NEW.betTime,
           NEW.betAmount,
           NEW.validAmount,
           NEW.winOrLoss,
           NEW.betStatus,
           NEW.betTypeName,
           NEW.gameResult,
		   NEW.tableName,
		   NEW.commissionName,
		   NEW.gameStartTime,
		   NEW.gameEndTime,

		   loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'SX' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67ABSX';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_oblive_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_oblive_gameinfo_after_delete` AFTER DELETE ON `api_bet67_oblive_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_oblive WHERE betId = OLD.id;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'OB' AND gametype='BET67ABSX' AND platformid = OLD.id;
END
;;


DROP TABLE IF EXISTS `api_bet67_oglive_gameinfo`;
CREATE TABLE `api_bet67_oglive_gameinfo` (
  `id` varchar(255) DEFAULT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `gameRoundId` varchar(32) DEFAULT NULL COMMENT '局号',
  `gameTypeName` varchar(255) DEFAULT NULL COMMENT '游戏名称',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betTypeName` varchar(64) DEFAULT NULL COMMENT '下单',
  `isBill` varchar(32) DEFAULT NULL COMMENT '无效单或已结算',
  `betId` varchar(255) DEFAULT NULL COMMENT '注单号',
  `platformName` varchar(32) DEFAULT NULL COMMENT '厅名',
  `gameKind` varchar(64) DEFAULT NULL COMMENT '游戏名称类型',
  `balance` decimal(11,2) DEFAULT NULL,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_oglive`;
CREATE TABLE `betting_bet67_oglive` (
  `betId` varchar(255) DEFAULT NULL COMMENT '注单号',
  `gameRoundId` varchar(32) DEFAULT NULL COMMENT '局号',
  `gameTypeName` varchar(255) DEFAULT NULL COMMENT '游戏名称',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betTypeName` varchar(64) DEFAULT NULL COMMENT '下单',
  `isBill` varchar(32) DEFAULT NULL COMMENT '无效单或已结算',
  `platformName` varchar(32) DEFAULT NULL COMMENT '厅名',
  `gameKind` varchar(64) DEFAULT NULL COMMENT '游戏名称类型',
  `balance` decimal(11,2) DEFAULT NULL,
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_oglive_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_oglive_gameinfo_after_insert` AFTER INSERT ON `api_bet67_oglive_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'OGSX' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.betAmount AS validbet, NEW.winOrLoss AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype  ,'BET67OGSX' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67OGSX';
		
   REPLACE INTO betting_bet67_oglive
    	SELECT NEW.betId,  
           NEW.gameRoundId,
           NEW.gameTypeName,
           NEW.betTime,
           NEW.betAmount,
           NEW.winOrLoss,
           NEW.betTypeName,
           NEW.isBill,
           NEW.platformName,
           NEW.gameKind,
           NEW.balance,

		   loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'SX' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67OGSX';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_oglive_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_oglive_gameinfo_after_delete` AFTER DELETE ON `api_bet67_oglive_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_oglive WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'OGSX' AND gametype='BET67OGSX' AND platformid = OLD.betId;
END
;;

DROP TABLE IF EXISTS `api_bet67_oglottery_gameinfo`;
CREATE TABLE `api_bet67_oglottery_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `betId` varchar(255) DEFAULT NULL COMMENT '投注ID',
  `gameName` varchar(255) DEFAULT NULL COMMENT '游戏名称',
  `phaseNum` int(11) DEFAULT NULL COMMENT '期数',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betTypeName` varchar(255) DEFAULT NULL COMMENT '下单项',
  `betStatus` varchar(255) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_betStatus` (`betStatus`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `betting_bet67_oglottery`;
CREATE TABLE `betting_bet67_oglottery` (
  `betId` varchar(255) DEFAULT NULL COMMENT '投注ID',
  `gameName` varchar(255) DEFAULT NULL COMMENT '游戏名称',
  `phaseNum` int(11) DEFAULT NULL COMMENT '期数',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betTypeName` varchar(255) DEFAULT NULL COMMENT '下单项',
  `betStatus` varchar(255) DEFAULT NULL COMMENT '状态',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_betStatus` (`betStatus`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_oglottery_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_oglottery_gameinfo_after_insert` AFTER INSERT ON `api_bet67_oglottery_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'OGCP' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.betAmount AS validbet, NEW.winOrLoss AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'CP' AS gamebigtype  ,'BET67OGCP' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67OGCP';
		
   REPLACE INTO betting_bet67_oglottery
    	SELECT NEW.betId,  
           NEW.gameName,
           NEW.phaseNum,
           NEW.betTime,
           NEW.betAmount,
           NEW.winOrLoss,
           NEW.betTypeName,
           NEW.betStatus,

		       loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'CP' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67OGCP';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_oglottery_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_oglottery_gameinfo_after_delete` AFTER DELETE ON `api_bet67_oglottery_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_oglottery WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'OGCP' AND gametype='BET67OGCP' AND platformid = OLD.betId;
END
;;


DROP TABLE IF EXISTS `api_bet67_ebetlive_gameinfo`;
CREATE TABLE `api_bet67_ebetlive_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `betId` varchar(64) DEFAULT NULL COMMENT '投注编号',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户名',
  `gameRoundId` varchar(64) DEFAULT NULL COMMENT '局号',
  `gameTypeName` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `validAmount` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betTypeName` varchar(64) DEFAULT NULL COMMENT '下单项',
  `gameResult` varchar(128) DEFAULT NULL COMMENT '结果项',
  `billTime` datetime DEFAULT NULL COMMENT '结算时间',
  `isBill` varchar(32) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_ebetlive`;
CREATE TABLE `betting_bet67_ebetlive` (
  `betId` varchar(64) DEFAULT NULL COMMENT '投注编号',
  `gameRoundId` varchar(64) DEFAULT NULL COMMENT '局号',
  `gameTypeName` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `validAmount` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betTypeName` varchar(64) DEFAULT NULL COMMENT '下单项',
  `gameResult` varchar(128) DEFAULT NULL COMMENT '结果项',
  `billTime` datetime DEFAULT NULL COMMENT '结算时间',
  `isBill` varchar(32) DEFAULT NULL COMMENT '状态',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_ebetlive_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_ebetlive_gameinfo_after_insert` AFTER INSERT ON `api_bet67_ebetlive_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'EBET' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.validAmount AS validbet, NEW.winOrLoss AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype  ,'BET67EBETSX' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67EBETSX';
		
   REPLACE INTO betting_bet67_ebetlive
    	SELECT NEW.betId,  
           NEW.gameRoundId,
           NEW.gameTypeName,
           NEW.betTime,
           NEW.betAmount,
           NEW.validAmount,
           NEW.winOrLoss,
           NEW.betTypeName,
					 NEW.gameResult,
						NEW.billTime,
						NEW.isBill,

		       loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'SX' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67EBETSX';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_ebetlive_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_ebetlive_gameinfo_after_delete` AFTER DELETE ON `api_bet67_ebetlive_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_ebetlive WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'EBET' AND gametype='BET67EBETSX' AND platformid = OLD.betId;
END
;;

DROP TABLE IF EXISTS `api_bet67_vg_gameinfo`;
CREATE TABLE `api_bet67_vg_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户名',
  `betId` varchar(64) DEFAULT NULL COMMENT '注单号',
  `roomName` varchar(32) DEFAULT NULL COMMENT '房间号',
  `gameName` varchar(32) DEFAULT NULL COMMENT '游戏盘名称',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `isLord` varchar(32) DEFAULT NULL COMMENT '是否地主',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `serviceMoney` decimal(11,2) DEFAULT NULL COMMENT '服务费',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  PRIMARY KEY (`id`),
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_gameName` (`gameName`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting__bet67_vg`;
CREATE TABLE `betting__bet67_vg` (
  `betId` varchar(64) DEFAULT NULL COMMENT '注单号',
  `roomName` varchar(32) DEFAULT NULL COMMENT '房间号',
  `gameName` varchar(32) DEFAULT NULL COMMENT '游戏盘名称',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `isLord` varchar(32) DEFAULT NULL COMMENT '是否地主',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `serviceMoney` decimal(11,2) DEFAULT NULL COMMENT '服务费',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_gameName` (`gameName`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_vg_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_vg_gameinfo_after_insert` AFTER INSERT ON `api_bet67_vg_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'VGQP' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.betAmount AS validbet, NEW.winOrLoss AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'QP' AS gamebigtype  ,'BET67VGQP' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67VGQP';
		
   REPLACE INTO betting__bet67_vg
    	SELECT NEW.betId,  
           NEW.roomName,
           NEW.gameName,
           NEW.betTime,
           NEW.isLord,
           NEW.betAmount,
           NEW.serviceMoney,
           NEW.winOrLoss,

		       loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'QP' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67VGQP';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_vg_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_vg_gameinfo_after_delete` AFTER DELETE ON `api_bet67_vg_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting__bet67_vg WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'VGQP' AND gametype='BET67VGQP' AND platformid = OLD.betId;
END
;;

DROP TABLE IF EXISTS `api_bet67_aglive_gameinfo`;
CREATE TABLE `api_bet67_aglive_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `betId` varchar(255) DEFAULT NULL COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `playType` varchar(64) DEFAULT NULL COMMENT '玩法',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `okBetMoney` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户名',
  `gameType` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `isbill` varchar(16) DEFAULT NULL COMMENT '是否结算',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '局号',
  `tableCode` varchar(32) DEFAULT NULL COMMENT '桌号',
  PRIMARY KEY (`id`),
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_isbill` (`isbill`) USING BTREE,
  KEY `IDX_gameCode` (`gameCode`) USING BTREE,
  KEY `IDX_tableCode` (`tableCode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_aglive`;
CREATE TABLE `betting_bet67_aglive` (
  `betId` varchar(255) DEFAULT NULL COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `playType` varchar(64) DEFAULT NULL COMMENT '玩法',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `okBetMoney` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `gameType` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `isbill` varchar(16) DEFAULT NULL COMMENT '是否结算',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '局号',
  `tableCode` varchar(32) DEFAULT NULL COMMENT '桌号',
   `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
 PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_isbill` (`isbill`) USING BTREE,
  KEY `IDX_gameCode` (`gameCode`) USING BTREE,
  KEY `IDX_tableCode` (`tableCode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_aglive_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_aglive_gameinfo_after_insert` AFTER INSERT ON `api_bet67_aglive_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'AG' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betMoney AS betmoney, NEW.okBetMoney AS validbet, NEW.betResult AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype  ,'BET67AGSX' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67AGSX';
		
   REPLACE INTO betting_bet67_aglive
    	SELECT NEW.betId,  
           NEW.betTime,
           NEW.playType,
           NEW.betMoney,
           NEW.okBetMoney,
           NEW.betResult,
           NEW.gameType,
           NEW.isbill,
						NEW.gameCode,
           NEW.tableCode,

		       loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'SX' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67AGSX';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_aglive_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_aglive_gameinfo_after_delete` AFTER DELETE ON `api_bet67_aglive_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_aglive WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'AG' AND gametype='BET67AGSX' AND platformid = OLD.betId;
END
;;

DROP TABLE IF EXISTS `api_bet67_bbinlive_gameinfo`;
CREATE TABLE `api_bet67_bbinlive_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `betId` varchar(64) DEFAULT NULL COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户名',
  `gKind` char(2) DEFAULT NULL COMMENT '游戏类型 （3真人  5电子）',
  `gType` varchar(255) DEFAULT NULL COMMENT '游戏代号',
  `serialId` varchar(64) DEFAULT NULL COMMENT '局号（真人）',
  `betMoney` decimal(11,2) DEFAULT NULL,
  `okBetMoney` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '输赢情况',
  `isbill` varchar(16) DEFAULT NULL COMMENT '是否已结算',
  PRIMARY KEY (`id`),
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_isbill` (`isbill`) USING BTREE,
  KEY `IDX_gKind` (`gKind`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_bbinlive`;
CREATE TABLE `betting_bet67_bbinlive` (
  `betId` varchar(64) DEFAULT NULL COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `gKind` char(2) DEFAULT NULL COMMENT '游戏类型 （3真人  5电子）',
  `gType` varchar(255) DEFAULT NULL COMMENT '游戏代号',
  `serialId` varchar(64) DEFAULT NULL COMMENT '局号（真人）',
  `betMoney` decimal(11,2) DEFAULT NULL,
  `okBetMoney` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '输赢情况',
  `isbill` varchar(16) DEFAULT NULL COMMENT '是否已结算',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_isbill` (`isbill`) USING BTREE,
  KEY `IDX_gKind` (`gKind`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_bbinlive_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_bbinlive_gameinfo_after_insert` AFTER INSERT ON `api_bet67_bbinlive_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'BBIN' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betMoney AS betmoney, NEW.okBetMoney AS validbet, NEW.betResult AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype  ,'BET67BBINSX' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67BBINSX';
		
   REPLACE INTO betting_bet67_bbinlive
    	SELECT NEW.betId,  
           NEW.betTime,
           NEW.gKind,
           NEW.gType,
           NEW.serialId,
           NEW.betMoney,
           NEW.okBetMoney,
           NEW.betResult,
					 NEW.isbill,

		       loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'SX' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67BBINSX';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_bbinlive_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_bbinlive_gameinfo_after_delete` AFTER DELETE ON `api_bet67_bbinlive_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_bbinlive WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'BBIN' AND gametype='BET67BBINSX' AND platformid = OLD.betId;
END
;;
	

DROP TABLE IF EXISTS `api_bet67_gdlive_gameinfo`;
CREATE TABLE `api_bet67_gdlive_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `betId` int(64) DEFAULT NULL COMMENT '投注编号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `gameId` varchar(32) DEFAULT NULL COMMENT '游戏局号',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户名',
  `gameType` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `subBetType` varchar(32) DEFAULT NULL COMMENT '下单项',
  `startBalance` decimal(11,2) DEFAULT NULL COMMENT '真人投注前/电子中奖池',
  `openDetail` varchar(255) DEFAULT NULL COMMENT '牌局结果',
  `state` varchar(32) DEFAULT NULL COMMENT '结果',
  PRIMARY KEY (`id`),
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_gameId` (`gameId`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_gameType` (`gameType`) USING BTREE,
  KEY `IDX_state` (`state`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_gdlive`;
CREATE TABLE `betting_bet67_gdlive` (
  `betId` int(64) DEFAULT NULL COMMENT '投注编号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `gameId` varchar(32) DEFAULT NULL COMMENT '游戏局号',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `gameType` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `subBetType` varchar(32) DEFAULT NULL COMMENT '下单项',
  `startBalance` decimal(11,2) DEFAULT NULL COMMENT '真人投注前/电子中奖池',
  `openDetail` varchar(255) DEFAULT NULL COMMENT '牌局结果',
  `state` varchar(32) DEFAULT NULL COMMENT '结果',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_gameId` (`gameId`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_gameType` (`gameType`) USING BTREE,
  KEY `IDX_state` (`state`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_gdlive_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_gdlive_gameinfo_after_insert` AFTER INSERT ON `api_bet67_gdlive_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'GD' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betMoney AS betmoney, NEW.betMoney AS validbet, NEW.betResult AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype  ,'BET67GDSX' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67GDSX';
		
   REPLACE INTO betting_bet67_gdlive
    	SELECT NEW.betId,  
           NEW.betTime,
           NEW.gameId,
           NEW.betMoney,
           NEW.betResult,
           NEW.gameType,
           NEW.subBetType,
           NEW.startBalance,
		   NEW.openDetail,
           NEW.state,
    
		   loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'SX' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67GDSX';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_gdlive_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_gdlive_gameinfo_after_delete` AFTER DELETE ON `api_bet67_gdlive_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_gdlive WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'GD' AND gametype='BET67GDSX' AND platformid = OLD.betId;
END
;;

DROP TABLE IF EXISTS `api_bet67_hglive_gameinfo`;
CREATE TABLE `api_bet67_hglive_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `betId` varchar(64) DEFAULT NULL COMMENT '投注编号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `gameId` varchar(32) DEFAULT NULL COMMENT '局号（局号相同为同一局）',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `payOut` decimal(11,2) DEFAULT NULL,
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `gameType` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `openDetail` varchar(128) DEFAULT NULL COMMENT '开牌结果',
  `billTime` datetime DEFAULT NULL,
  `betDetail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_gameId` (`gameId`) USING BTREE,
  KEY `IDX_gameType` (`gameType`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `betting_bet67_hglive`;
CREATE TABLE `betting_bet67_hglive` (
  `betId` varchar(64) DEFAULT NULL COMMENT '投注编号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `gameId` varchar(32) DEFAULT NULL COMMENT '局号（局号相同为同一局）',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `payOut` decimal(11,2) DEFAULT NULL,
  `gameType` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `openDetail` varchar(128) DEFAULT NULL COMMENT '开牌结果',
  `billTime` datetime DEFAULT NULL,
  `betDetail` varchar(255) DEFAULT NULL,
 `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_gameId` (`gameId`) USING BTREE,
  KEY `IDX_gameType` (`gameType`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_hglive_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_hglive_gameinfo_after_insert` AFTER INSERT ON `api_bet67_hglive_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'HGSX' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.betAmount AS validbet, NEW.payOut AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype  ,'BET67HGSX' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67HGSX';
		
   REPLACE INTO betting_bet67_hglive
    	SELECT NEW.betId,  
           NEW.betTime,
           NEW.gameId,
           NEW.betAmount,
           NEW.payOut,
           NEW.gameType,
           NEW.openDetail,
           NEW.billTime,
					 NEW.betDetail,

		       loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'SX' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67HGSX';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_hglive_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_hglive_gameinfo_after_delete` AFTER DELETE ON `api_bet67_hglive_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_hglive WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'HGSX' AND gametype='BET67HGSX' AND platformid = OLD.betId;
END
;;

DROP TABLE IF EXISTS `api_bet67_sllive_gameinfo`;
CREATE TABLE `api_bet67_sllive_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `betId` varchar(64) DEFAULT NULL COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `desNo` varchar(32) DEFAULT NULL COMMENT '台号',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `round` varchar(32) DEFAULT NULL COMMENT '局数',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `betRgn` varchar(255) DEFAULT NULL COMMENT '投注码',
  `chipLeft` varchar(255) DEFAULT NULL COMMENT '本局余额',
  `openAnswer` varchar(255) DEFAULT NULL COMMENT '结果',
  `openDetail` varchar(255) DEFAULT NULL COMMENT '发牌详情',
  `bSuccess` varchar(32) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_round` (`round`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_bSuccess` (`bSuccess`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_sllive`;
CREATE TABLE `betting_bet67_sllive` (
  `betId` varchar(64) DEFAULT NULL COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `desNo` varchar(32) DEFAULT NULL COMMENT '台号',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `round` varchar(32) DEFAULT NULL COMMENT '局数',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `betRgn` varchar(255) DEFAULT NULL COMMENT '投注码',
  `chipLeft` varchar(255) DEFAULT NULL COMMENT '本局余额',
  `openAnswer` varchar(255) DEFAULT NULL COMMENT '结果',
  `openDetail` varchar(255) DEFAULT NULL COMMENT '发牌详情',
  `bSuccess` varchar(32) DEFAULT NULL COMMENT '状态',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_round` (`round`) USING BTREE,
  KEY `IDX_bSuccess` (`bSuccess`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_sllive_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_sllive_gameinfo_after_insert` AFTER INSERT ON `api_bet67_sllive_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'SA' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betMoney AS betmoney, NEW.betMoney AS validbet, NEW.betResult AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype  ,'BET67SASX' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67SASX';
		
   REPLACE INTO betting_bet67_sllive
    	SELECT NEW.betId,  
           NEW.betTime,
           NEW.desNo,
           NEW.betMoney,
           NEW.round,
           NEW.betResult,
           NEW.gameCode,
           NEW.betRgn,
					 NEW.chipLeft,
					 NEW.openAnswer,
           NEW.openDetail,
					 NEW.bSuccess,

		       loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'SX' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67SASX';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_sllive_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_sllive_gameinfo_after_delete` AFTER DELETE ON `api_bet67_sllive_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_sllive WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'SA' AND gametype='BET67SASX' AND platformid = OLD.betId;
END
;;

DROP TABLE IF EXISTS `api_bet67_elgslot_gameinfo`;
CREATE TABLE `api_bet67_elgslot_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户名',
  `betId` varchar(32) DEFAULT NULL COMMENT '局号',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '游戏Code',
  `gameName` varchar(32) DEFAULT NULL COMMENT '游戏名称',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betBefore` decimal(11,2) DEFAULT NULL COMMENT '结算前余额额',
  `billBefore` decimal(11,2) DEFAULT NULL COMMENT '结算前余额',
  `isBill` varchar(32) DEFAULT NULL COMMENT '结算状态',
  PRIMARY KEY (`id`),
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE,
  KEY `IDX_gameCode` (`gameCode`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_elgslot`;
CREATE TABLE `betting_bet67_elgslot` (
  `betId` varchar(32) DEFAULT NULL COMMENT '局号',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '游戏Code',
  `gameName` varchar(32) DEFAULT NULL COMMENT '游戏名称',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `betBefore` decimal(11,2) DEFAULT NULL COMMENT '结算前余额额',
  `billBefore` decimal(11,2) DEFAULT NULL COMMENT '结算前余额',
  `isBill` varchar(32) DEFAULT NULL COMMENT '结算状态',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE,
  KEY `IDX_gameCode` (`gameCode`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TRIGGER IF EXISTS `trg_api_bet67_elgslot_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_elgslot_gameinfo_after_insert` AFTER INSERT ON `api_bet67_elgslot_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'ELG' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betMoney AS betmoney, NEW.betMoney AS validbet, NEW.winOrLoss AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype  ,'BET67ELGDZ' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67ELGDZ';
		
   REPLACE INTO betting_bet67_elgslot
    	SELECT NEW.betId,  
           NEW.gameCode,
           NEW.gameName,
           NEW.betTime,
           NEW.betMoney,
           NEW.winOrLoss,
           NEW.betBefore,
           NEW.billBefore,
					 NEW.isBill,

		       loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'DZ' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67ELGDZ';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_elgslot_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_elgslot_gameinfo_after_delete` AFTER DELETE ON `api_bet67_elgslot_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_elgslot WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'ELG' AND gametype='BET67ELGDZ' AND platformid = OLD.betId;
END
;;

DROP TABLE IF EXISTS `api_bet67_mgslot_gameinfo`;
CREATE TABLE `api_bet67_mgslot_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户名',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '游戏Code',
  `gameName` varchar(32) DEFAULT NULL COMMENT '游戏名称',
  `betId` varchar(64) DEFAULT NULL COMMENT '局号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `isBill` varchar(32) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_gameCode` (`gameCode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_mgslot`;
CREATE TABLE `betting_bet67_mgslot` (
  `betId` varchar(64) DEFAULT NULL COMMENT '局号',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '游戏Code',
  `gameName` varchar(32) DEFAULT NULL COMMENT '游戏名称',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `winOrLoss` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `isBill` varchar(32) DEFAULT NULL COMMENT '状态',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_isBill` (`isBill`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_gameCode` (`gameCode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TRIGGER IF EXISTS `trg_api_bet67_mgslot_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_mgslot_gameinfo_after_insert` AFTER INSERT ON `api_bet67_mgslot_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'MG' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.betAmount AS validbet, NEW.winOrLoss AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype  ,'BET67MGDZ' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67MGDZ';
		
   REPLACE INTO betting_bet67_mgslot
    	SELECT NEW.betId,  
           NEW.gameCode,
           NEW.gameName,
           NEW.betTime,
           NEW.betAmount,
           NEW.winOrLoss,
           NEW.isBill,

		       loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'DZ' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67MGDZ';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_mgslot_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_mgslot_gameinfo_after_delete` AFTER DELETE ON `api_bet67_mgslot_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_mgslot WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'MG' AND gametype='BET67MGDZ' AND platformid = OLD.betId;
END
;;

ALTER TABLE betting_all_game_winlose_detail MODIFY COLUMN gametype VARCHAR(20) COMMENT '游戏平台编码';

ALTER TABLE data_handle ADD COLUMN `repeattime` varchar(2000) COMMENT '补单更新时间';

-- add by Cloud: 统一更新游戏相关表中的gametype字段长度为15
ALTER TABLE `betting_all_agent` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `betting_all_game_winlose_detail` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `betting_all_member` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `data_handle` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `data_handle_maintenance` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `data_handle_repeat` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `employee_api_accout` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `employee_api_accout_password_job` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `employee_gamecataloy_bonus` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `enterprise_employee_level_bonus` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `game_category` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `game_class` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `integral_record` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `integral_setting` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `report_daily_agent` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `report_daily_member` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `report_weekly_agent` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `report_weekly_member` MODIFY COLUMN `gametype` VARCHAR(15);
ALTER TABLE `user_money_in_and_out` MODIFY COLUMN `gametype` VARCHAR(15);

DROP TRIGGER IF EXISTS `trg_api_tgp_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_tgp_gameinfo_after_insert` AFTER INSERT ON `api_tgp_gameinfo` FOR EACH ROW
BEGIN
	REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
		SELECT 'TGP' platformtype,NEW.ugsbetid AS platformid,employeecode,NEW.bettime AS bettime,NEW.betmoney AS betmoney,NEW.validmoney AS validbet,NEW.netmoney AS netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,
			CASE
				WHEN NEW.gameprovider = 'SB' OR NEW.gameprovider = 'GD' OR NEW.gameprovider = 'EA' THEN 'SX'
				WHEN NEW.gameprovider = 'ESB' THEN 'TY'
				ELSE 'DZ'
			END AS gamebigtype,
		'TGPI' AS gametype
		FROM employee_api_accout WHERE gameaccount = LOWER(NEW.userid) AND gametype = 'TGPI';
		
	REPLACE INTO betting_tgp
	SELECT NEW.ugsbetid AS ugsbetid,
		NEW.txid AS txid,
		NEW.betid AS betid,
		NEW.beton AS beton,
		NEW.betclosedon AS betclosedon,
		NEW.betupdatedon AS betupdatedon,
		NEW.timestamp AS timestamp,
		NEW.roundid AS roundid,
		NEW.roundstatus AS roundstatus,
		NEW.userid AS userid,
		NEW.username AS username,
		NEW.riskamt AS riskamt,
		NEW.winamt AS winamt,
		NEW.winloss AS winloss,
		NEW.beforebal AS beforebal,
		NEW.postbal AS postbal,
		NEW.cur AS cur,
		NEW.gameprovider AS gameprovider,
		NEW.gamename AS gamename,
		NEW.gameid AS gameid,
		NEW.platformtype AS platformtype,
		NEW.ipaddress AS ipaddress,
		NEW.bettype AS bettype,
		NEW.playtype AS playtype,
		NEW.betmoney AS betmoney,
		NEW.netmoney AS netmoney,
		NEW.bettime AS bettime,
		NEW.Platformflag AS platformflag,
		NEW.createtime AS createtime,       
		enterprisecode AS enterprisecode,
		brandcode AS brandcode,  
		employeecode AS employeecode,
		parentemployeecode AS parentemployeecode,
		loginaccount AS loginaccount,
		CASE
			WHEN NEW.gameprovider = 'SB' OR NEW.gameprovider = 'GD' OR NEW.gameprovider = 'EA' THEN 'SX'
			WHEN NEW.gameprovider = 'ESB' THEN 'TY'
			ELSE 'DZ'
		END AS gamebigtype,
		0 AS status,
		NEW.validmoney AS validmoney
	FROM employee_api_accout
	WHERE gameaccount = LOWER(NEW.userid) AND gametype = 'TGPI';
END;

DROP TRIGGER IF EXISTS `trg_api_tgp_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_tgp_gameinfo_after_delete` AFTER DELETE ON `api_tgp_gameinfo` FOR EACH ROW
BEGIN
	DELETE FROM betting_tgp WHERE ugsbetid = OLD.ugsbetid;
	DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'TGPI' AND platformid = OLD.ugsbetid;
END;

REPLACE INTO `data_handle_maintenance` VALUES
('BET67HYSX', '1', '2017-12-03 20:26:18', NULL),
('BET67ABSX', '1', '2017-12-03 20:26:18', NULL),
('BET67EBETSX', '1', '2017-12-03 20:26:18', NULL),
('BET67AGSX', '1', '2017-12-03 20:26:18', NULL),
('BET67BBINSX', '1', '2017-12-03 20:26:18', NULL),
('BET67GDSX', '1', '2017-12-03 20:26:18', NULL),
('BET67HGSX', '1', '2017-12-03 20:26:18', NULL),
('BET67SASX', '1', '2017-12-03 20:26:18', NULL),
('BET67OGSX', '1', '2017-12-03 20:26:18', NULL),
('BET67OGCP', '1', '2017-12-03 20:26:18', NULL),
('BET67TSTY', '1', '2017-12-03 20:26:18', NULL),
('BET67VGQP', '1', '2017-12-03 20:26:18', NULL),
('BET67ELGDZ', '1', '2017-12-03 20:26:18', NULL),
('BET67MGDZ', '1', '2017-12-03 20:26:18', NULL);

-- add by link betting67菜单sql
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99800', 'MN0045', 'AG 真人', 'AG Live', '/BET67AGSX/list', 2, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99801', 'MN0045', 'BBIN 真人', 'BBIN Live', '/BET67BBINSX/list', 3, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99802', 'MN0045', 'EBET 真人', 'ebet Live', '/BET67EBETSX/list', 4, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99803', 'MN0045', 'GD 真人', 'AG Live', '/BET67GDSX/list', 5, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99804', 'MN0045', 'HG真人', 'HG Live', '/BET67HGSX/list', 6, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99805', 'MN0045', 'MG电子', 'mg slot', '/BET67MGDZ/list', 8, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99806', 'MN0045', 'Allbet欧博真人', 'OB Live', '/BET67ABSX/list', 9, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99807', 'MN0045', 'OG真人', 'OG Live', '/BET67OGSX/list', 10, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99808', 'MN0045', 'OG 彩票', 'OG Lottery', '/BET67OGCP/list', 11, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99809', 'MN0045', '沙龙真人', 'SL Live', '/BET67SASX/list', 12, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99890', 'MN0045', '三升体育', 'TS Sport', '/BET67TSTY/list', 13, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99891', 'MN0045', 'ELG 电子', 'elg_slot', '/BET67AGSX/list', 14, 3, 1, '1');


-- add by xiaogao 2018.2.12
ALTER table api_bet67_elgslot_gameinfo MODIFY `betId` varchar(64) DEFAULT NULL COMMENT '局号';
ALTER table betting_bet67_elgslot MODIFY `betId` varchar(64) DEFAULT NULL COMMENT '局号';

-- add by xiaogao 2018.2.19
ALTER TABLE api_bet67_mgslot_gameinfo MODIFY `gameCode` varchar(64) DEFAULT NULL COMMENT '游戏Code';
ALTER TABLE betting_bet67_mgslot MODIFY `gameCode` varchar(64) DEFAULT NULL COMMENT '游戏Code';

ALTER TABLE api_bet67_elgslot_gameinfo MODIFY `gameCode` varchar(128) DEFAULT NULL COMMENT '游戏Code';
ALTER TABLE betting_bet67_elgslot MODIFY `gameCode` varchar(128) DEFAULT NULL COMMENT '游戏Code';

-- add by xiaogao 2018.2.24
DELETE FROM game_category where gametype='TGPI'; 
INSERT INTO `game_category` (`categorycode`, `gametype`, `categorytype`, `categoryname`, `minbonus`, `maxbonus`, `sort`) VALUES ('82', 'TGPI', 'DZ', '电子', '0.0000', '1.0000', '1');
INSERT INTO `game_category` (`categorycode`, `gametype`, `categorytype`, `categoryname`, `minbonus`, `maxbonus`, `sort`) VALUES ('83', 'TGPI', 'SX', '视讯', '0.0000', '1.0000', '1');
INSERT INTO `game_category` (`categorycode`, `gametype`, `categorytype`, `categoryname`, `minbonus`, `maxbonus`, `sort`) VALUES ('84', 'TGPI', 'QP', '棋牌', '0.0000', '1.0000', '1');
INSERT INTO `game_category` (`categorycode`, `gametype`, `categorytype`, `categoryname`, `minbonus`, `maxbonus`, `sort`) VALUES ('85', 'TGPI', 'TY', '体育', '0.0000', '1.0000', '1');


-- add by xiaogao 2018.3.6
ALTER table api_bet67_gdlive_gameinfo MODIFY `betId` varchar(64) DEFAULT NULL COMMENT '投注编号';
ALTER table betting_bet67_gdlive MODIFY `betId` varchar(64) DEFAULT NULL COMMENT '投注编号';

ALTER table api_bet67_oglottery_gameinfo MODIFY  `phaseNum` bigint(11) DEFAULT NULL COMMENT '期数';
ALTER table betting_bet67_oglottery MODIFY  `phaseNum` bigint(11) DEFAULT NULL COMMENT '期数';

ALTER table api_bet67_sllive_gameinfo MODIFY `chipLeft` varchar(255) DEFAULT NULL COMMENT '本局余额';
ALTER table betting_bet67_sllive MODIFY `chipLeft` varchar(255) DEFAULT NULL COMMENT '本局余额';

-- add by xiaogao 2018.3.9
ALTER TABLE betting_all_day MODIFY COLUMN Game_Platform varchar(20) DEFAULT NULL COMMENT '游戏平台';
ALTER TABLE betting_all_day2 MODIFY COLUMN `Game_Platform` varchar(20) DEFAULT NULL COMMENT '游戏平台';

ALTER TABLE `employee_gamecataloy_bonus` MODIFY COLUMN `categorytype` VARCHAR(20) COMMENT '游戏种类类型标志(唯一)';


--add by xiaogao 2018.3.28
INSERT INTO `game` (`gamecode`, `gametype`, `gamename`, `sort`, `picid`, `android`, `h5`, `iso`, `downloadurl`, `datastatus`) VALUES
('G048', 'BET67AGFISH', '67bet-AG捕鱼', '48', 'pic048', NULL, NULL, NULL, NULL, '1'),
('G049', 'BET67SAFISH', '67bet-SA捕鱼', '49', 'pic049', NULL, NULL, NULL, NULL, '1');

INSERT INTO `game_category` (`categorycode`, `gametype`, `categorytype`, `categoryname`, `minbonus`, `maxbonus`, `sort`) VALUES 
('81', 'BET67AGFISH', 'BY', '捕鱼', '0.0000', '1.0000', '1'),
('82', 'BET67SAFISH', 'BY', '捕鱼', '0.0000', '1.0000', '1');

INSERT INTO `employee_gamecataloy_bonus` (`employeecode`, `gametype`, `categorytype`, `parentemployeecode`, `bonus`) VALUES
('E0000000', 'BET67AGFISH', 'BY', '00000000', '1.0000'),
('E0000000', 'BET67SAFISH', 'BY', '00000000', '1.0000');

REPLACE INTO `data_handle_maintenance` VALUES
('BET67AGFISH', '1', '2018-03-28 17:30:18', NULL),
('BET67SAFISH', '1', '2018-03-28 17:30:18', NULL);


INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P116', '捷付微信扫码', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P117', '捷付QQ扫码', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P118', '捷付支付宝扫码', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P119', '捷付网银支付', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P120', '捷付QQ钱包', '1', '1');

INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EV', 'P116', 'merCode', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EH', 'P116', 'sha1Key', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EI', 'P116', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EJ', 'P117', 'merCode', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EK', 'P117', 'sha1Key', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EL', 'P117', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EM', 'P118', 'merCode', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EN', 'P118', 'sha1Key', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EO', 'P118', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EP', 'P119', 'merCode', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EQ', 'P119', 'sha1Key', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0ER', 'P119', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0ES', 'P120', 'merCode', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0ET', 'P120', 'sha1Key', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EU', 'P120', 'payUrl', '支付接口地址', '1');


-- 如意支付插入sql开始
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P041', '如意网关支付', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P042', '如意微信支付', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P044', '如意代付', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P093', '如意京东钱包', '1', '1');


INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EW', 'P041', 'merId', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EX', 'P041', 'merKey', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EY', 'P041', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0EZ', 'P042', 'merId', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FA', 'P042', 'merKey', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FB', 'P042', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FC', 'P044', 'merId', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FD', 'P044', 'merKey', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FE', 'P044', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FF', 'P093', 'merId', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FH', 'P093', 'payUrl', '支付接口地址', '1');
I
-- 如意支付插入sql结束

-- add by xiaogao 2018.04.18
DROP TABLE IF EXISTS `api_bet67_agfish_gameinfo`;
CREATE TABLE `api_bet67_agfish_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `betId` varchar(255) DEFAULT NULL COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `playType` varchar(64) DEFAULT NULL COMMENT '玩法',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `okBetMoney` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户名',
  `gameType` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `isbill` varchar(16) DEFAULT NULL COMMENT '是否结算',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '局号',
  `tableCode` varchar(32) DEFAULT NULL COMMENT '桌号',
  PRIMARY KEY (`id`),
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_isbill` (`isbill`) USING BTREE,
  KEY `IDX_gameCode` (`gameCode`) USING BTREE,
  KEY `IDX_tableCode` (`tableCode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_agfish`;
CREATE TABLE `betting_bet67_agfish` (
  `betId` varchar(255) DEFAULT NULL COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `playType` varchar(64) DEFAULT NULL COMMENT '玩法',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `okBetMoney` decimal(11,2) DEFAULT NULL COMMENT '有效下单金额',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `gameType` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `isbill` varchar(16) DEFAULT NULL COMMENT '是否结算',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '局号',
  `tableCode` varchar(32) DEFAULT NULL COMMENT '桌号',
   `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
 PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_isbill` (`isbill`) USING BTREE,
  KEY `IDX_gameCode` (`gameCode`) USING BTREE,
  KEY `IDX_tableCode` (`tableCode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_agfish_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_agfish_gameinfo_after_insert` AFTER INSERT ON `api_bet67_agfish_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'AGFISH' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betMoney AS betmoney, NEW.okBetMoney AS validbet, NEW.betResult AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'BY' AS gamebigtype  ,'BET67AGFISH' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67AGSX';
		
   REPLACE INTO betting_bet67_agfish
    	SELECT NEW.betId,  
           NEW.betTime,
           NEW.playType,
           NEW.betMoney,
           NEW.okBetMoney,
           NEW.betResult,
           NEW.gameType,
           NEW.isbill,
		   NEW.gameCode,
           NEW.tableCode,

		   loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'BY' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67AGSX';

END
;;


DROP TRIGGER IF EXISTS `trg_api_bet67_agfish_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_agfish_gameinfo_after_delete` AFTER DELETE ON `api_bet67_agfish_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_agfish WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'AGFISH' AND gametype='BET67AGFISH' AND platformid = OLD.betId;
END
;;


DROP TABLE IF EXISTS `api_bet67_slfish_gameinfo`;
CREATE TABLE `api_bet67_slfish_gameinfo` (
  `id` varchar(255) NOT NULL COMMENT '唯一编号【抓取历史数据使用】',
  `betId` varchar(64) DEFAULT NULL COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `desNo` varchar(32) DEFAULT NULL COMMENT '台号',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `round` varchar(32) DEFAULT NULL COMMENT '局数',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `betRgn` varchar(255) DEFAULT NULL COMMENT '投注码',
  `chipLeft` varchar(255) DEFAULT NULL COMMENT '本局余额',
  `openAnswer` varchar(255) DEFAULT NULL COMMENT '结果',
  `openDetail` varchar(255) DEFAULT NULL COMMENT '发牌详情',
  `bSuccess` varchar(32) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_round` (`round`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_bSuccess` (`bSuccess`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_bet67_slfish`;
CREATE TABLE `betting_bet67_slfish` (
  `betId` varchar(64) DEFAULT NULL COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `desNo` varchar(32) DEFAULT NULL COMMENT '台号',
  `betMoney` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `round` varchar(32) DEFAULT NULL COMMENT '局数',
  `betResult` decimal(11,2) DEFAULT NULL COMMENT '结算结果',
  `gameCode` varchar(32) DEFAULT NULL COMMENT '游戏类型',
  `betRgn` varchar(255) DEFAULT NULL COMMENT '投注码',
  `chipLeft` varchar(255) DEFAULT NULL COMMENT '本局余额',
  `openAnswer` varchar(255) DEFAULT NULL COMMENT '结果',
  `openDetail` varchar(255) DEFAULT NULL COMMENT '发牌详情',
  `bSuccess` varchar(32) DEFAULT NULL COMMENT '状态',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_round` (`round`) USING BTREE,
  KEY `IDX_bSuccess` (`bSuccess`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_bet67_slfish_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_bet67_slfish_gameinfo_after_insert` AFTER INSERT ON `api_bet67_slfish_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'SAFISH' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betMoney AS betmoney, NEW.betMoney AS validbet, NEW.betResult AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'BY' AS gamebigtype  ,'BET67SAFISH' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'BET67SASX';
		
   REPLACE INTO betting_bet67_slfish
    	SELECT NEW.betId,  
           NEW.betTime,
           NEW.desNo,
           NEW.betMoney,
           NEW.round,
           NEW.betResult,
           NEW.gameCode,
           NEW.betRgn,
					 NEW.chipLeft,
					 NEW.openAnswer,
           NEW.openDetail,
					 NEW.bSuccess,

		       loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'BY' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'BET67SASX';

END
;;

DROP TRIGGER IF EXISTS `trg_api_bet67_slfish_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_bet67_slfish_gameinfo_after_delete` AFTER DELETE ON `api_bet67_slfish_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_bet67_slfish WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'SAFISH' AND gametype='BET67SAFISH' AND platformid = OLD.betId;
END
;;

-- add by xiaogao 2018.4.27
ALTER TABLE enterprise_employee_information ADD COLUMN `createtime` datetime DEFAULT NULL COMMENT '创建时间';

-- add by link  2018.04.28 捕鱼菜单添加sql
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99892', 'MN0045', 'AG捕鱼', 'ag_fish', '/BET67AGFISH/list', 15, 3, 1, '1');
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99893', 'MN0045', 'SA捕鱼', 'sl_fish', '/BET67SAFISH/list', 16, 3, 1, '1');

-- add by xiaogao 2018.05.10

INSERT INTO `game` (`gamecode`, `gametype`, `gamename`, `sort`, `picid`, `android`, `h5`, `iso`, `downloadurl`, `datastatus`) VALUES
('G00Q', 'YSBGame', 'YSB体育', '51', 'pic036', NULL, NULL, NULL, NULL, '1'),
('G00R', 'IMPTGame', 'IMPT电子', '52', 'pic036', NULL, NULL, NULL, NULL, '1');

INSERT INTO `game_category` (`categorycode`, `gametype`, `categorytype`, `categoryname`, `minbonus`, `maxbonus`, `sort`) VALUES 
('90', 'YSBGame', 'TY', '体育', '0.0000', '1.0000', '13'),
('91', 'IMPTGame', 'DZ', '电子', '0.0000', '1.0000', '14');

INSERT INTO `employee_gamecataloy_bonus` (`employeecode`, `gametype`, `categorytype`, `parentemployeecode`, `bonus`) VALUES
('E0000000', 'YSBGame', 'TY', '00000000', '1.0000'),
('E0000000', 'IMPTGame', 'DZ', '00000000', '1.0000');


-- add by link 2018-05-15 速龙支付
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P121', '速龙手机微信', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P122', '速龙QQ扫码', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P123', '速龙支付宝扫码', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P124', '速龙京东扫码', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P125', '速龙银联扫码', '1', '1');
INSERT INTO `thirdparty_payment_type` (`thirdpartypaymenttypecode`, `thirdpartypaymenttypename`, `status`, `datastatus`) VALUES ('P126', '速龙网银支付', '1', '1');

INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FK', 'P121', 'merId', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FL', 'P121', 'merKey', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FM', 'P121', 'payUrl', '支付接口地址', '1');

INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FN', 'P122', 'merId', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FO', 'P122', 'merKey', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FP', 'P122', 'payUrl', '支付接口地址', '1');

INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FQ', 'P123', 'merId', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FR', 'P123', 'merKey', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FS', 'P123', 'payUrl', '支付接口地址', '1');

INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FT', 'P124', 'merId', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FU', 'P124', 'merKey', '签名Key', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FV', 'P124', 'payUrl', '支付接口地址', '1');

INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FW', 'P125', 'merId', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FX', 'P125', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FY', 'P125', 'merKey', '签名Key', '1');

INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0FZ', 'P126', 'merId', '商户号', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0GA', 'P126', 'payUrl', '支付接口地址', '1');
INSERT INTO `thirdparty_payment_type_setting` (`paymentsettingcode`, `thirdpartypaymenttypecode`, `argumentfiled`, `argumentdesc`, `datastatus`) VALUES ('PS0GB', 'P126', 'merKey', '签名Key', '1');

-- add by xiaogao 2018.5.19
DROP TABLE IF EXISTS `api_ysb_gameinfo`;
CREATE TABLE `api_ysb_gameinfo` (
  `betId` varchar(64) COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `billTime` datetime DEFAULT NULL COMMENT '结算时间',
  `betAmount` decimal(11,4) DEFAULT NULL COMMENT '下单金额',
  `bonusAmount` varchar(32) DEFAULT NULL COMMENT '奖金数额',
  `profit` varchar(32) DEFAULT NULL COMMENT '所获利润',
  `selectionPlace` varchar(64) DEFAULT NULL COMMENT '大小盘',
  `Status` varchar(32) DEFAULT NULL COMMENT '状态',
  `eventId` varchar(32) DEFAULT NULL COMMENT '赛事ID',
  `score` varchar(32) DEFAULT NULL COMMENT '比赛分数',
  `sportType` varchar(32) DEFAULT NULL COMMENT '体育类型',
  `oddFormat` varchar(32) DEFAULT NULL COMMENT '盘口',
  `userName` varchar(32) DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`betId`),
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_Status` (`Status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_ysb`;
CREATE TABLE `betting_ysb` (
  `betId` varchar(64) NOT NULL DEFAULT '' COMMENT '注单号',
  `betTime` datetime DEFAULT NULL COMMENT '下单时间',
  `billTime` datetime DEFAULT NULL COMMENT '结算时间',
  `betAmount` decimal(11,4) DEFAULT NULL COMMENT '下单金额',
  `bonusAmount` varchar(32) DEFAULT NULL COMMENT '奖金数额',
  `profit` varchar(32) DEFAULT NULL COMMENT '所获利润',
  `selectionPlace` varchar(64) DEFAULT NULL COMMENT '大小盘',
  `Status` varchar(32) DEFAULT NULL COMMENT '状态',
  `eventId` varchar(32) DEFAULT NULL COMMENT '赛事ID',
  `sportType` varchar(32) DEFAULT NULL COMMENT '体育类型',
  `oddFormat` varchar(32) DEFAULT NULL COMMENT '盘口',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE,
  KEY `IDX_Status` (`Status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_ysb_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_ysb_gameinfo_after_insert` AFTER INSERT ON `api_ysb_gameinfo` FOR EACH ROW BEGIN
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,
   		enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'YSB' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.betAmount AS validbet, NEW.profit AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'TY' AS gamebigtype  ,'YSBGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'YSBGame';

   REPLACE INTO betting_ysb
    	SELECT NEW.betId,
           NEW.betTime,
           NEW.billTime,
           NEW.betAmount,
           NEW.bonusAmount,
           NEW.profit,
           NEW.selectionPlace,
           NEW.Status,
		       NEW.eventId,
           NEW.sportType,
		       NEW.oddFormat,

		   loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           'TY' AS gamebigtype
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'YSBGame';

END;

DROP TRIGGER IF EXISTS `trg_api_ysb_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_ysb_gameinfo_after_delete` AFTER DELETE ON `api_ysb_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_ysb WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'YSB' AND gametype='YSBGame' AND platformid = OLD.betId;
END;


DROP TABLE IF EXISTS `api_nb_gameinfo`;
CREATE TABLE `api_nb_gameinfo` (
  `betId` varchar(64) COMMENT '注单号',
  `orderNo` varchar(64) DEFAULT NULL COMMENT '订单号',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `validbet` decimal(11,2) DEFAULT NULL COMMENT '有效金额',
  `winorloss` decimal(11,2) DEFAULT NULL COMMENT '輸贏金额',
  `betTime` datetime DEFAULT NULL COMMENT '下注时间',
  `billTime` datetime DEFAULT NULL COMMENT '结算时间',
  `sportNo` varchar(32) DEFAULT NULL COMMENT '体育项编号',
  `raceName` varchar(512) DEFAULT NULL COMMENT '联赛名',
  `macthId` varchar(64) DEFAULT NULL COMMENT '比赛ID',
  `macthName` varchar(512) DEFAULT NULL COMMENT '比赛名称',
  `gameType` varchar(32) DEFAULT NULL COMMENT '玩法类型',
  `gameName` varchar(32) DEFAULT NULL COMMENT '玩法名称',
  `optionId` varchar(32) DEFAULT NULL COMMENT '投注项ID',
  `optionName` varchar(32) DEFAULT NULL COMMENT '投注项名称',
  `odds` varchar(32) DEFAULT NULL COMMENT '注单赔率',
  `userId` varchar(64) DEFAULT NULL COMMENT '用户Id',
  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`betId`),
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_orderNo` (`orderNo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `betting_nb`;
CREATE TABLE `betting_nb` (
  `betId` varchar(64) COMMENT '注单号',
  `betAmount` decimal(11,2) DEFAULT NULL COMMENT '下单金额',
  `validbet` decimal(11,2) DEFAULT NULL COMMENT '有效金额',
  `winorloss` decimal(11,2) DEFAULT NULL COMMENT '輸贏金额',
  `betTime` datetime DEFAULT NULL COMMENT '下注时间',
  `billTime` datetime DEFAULT NULL COMMENT '结算时间',
  `sportNo` varchar(32) DEFAULT NULL COMMENT '体育项编号',
  `raceName` varchar(512) DEFAULT NULL COMMENT '联赛名',
  `macthId` varchar(64) DEFAULT NULL COMMENT '比赛ID',
  `macthName` varchar(512) DEFAULT NULL COMMENT '比赛名称',
  `gameType` varchar(32) DEFAULT NULL COMMENT '玩法类型',
  `gameName` varchar(32) DEFAULT NULL COMMENT '玩法名称',
  `optionId` varchar(32) DEFAULT NULL COMMENT '投注项ID',
  `optionName` varchar(32) DEFAULT NULL COMMENT '投注项名称',
  `odds` varchar(32) DEFAULT NULL COMMENT '注单赔率',

  `userName` varchar(64) DEFAULT NULL COMMENT '用户名',
  `enterprisecode` char(6) DEFAULT NULL COMMENT '企业编码',
  `brandcode` char(8) DEFAULT NULL COMMENT '企业品牌编码',
  `employeecode` char(8) DEFAULT NULL COMMENT '员工编码',
  `parentemployeecode` char(8) DEFAULT NULL COMMENT '员工上级编码',
  `gamebigtype` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '游戏大类',
  PRIMARY KEY (`betId`),
  KEY `IDX_employeecode` (`employeecode`) USING BTREE,
  KEY `IDX_enterprisecode` (`enterprisecode`) USING BTREE,
  KEY `IDX_brandcode` (`brandcode`) USING BTREE,
  KEY `IDX_parentemployeecode` (`parentemployeecode`) USING BTREE,
  KEY `IDX_userName` (`userName`) USING BTREE,
  KEY `IDX_betId` (`betId`) USING BTREE,
  KEY `IDX_betTime` (`betTime`) USING BTREE,
  KEY `IDX_billTime` (`billTime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS `trg_api_nb_gameinfo_after_insert`;
CREATE TRIGGER `trg_api_nb_gameinfo_after_insert` AFTER INSERT ON `api_nb_gameinfo` FOR EACH ROW BEGIN
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,
   		enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'NB' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.validbet AS validbet, NEW.winorloss AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'TY' AS gamebigtype  ,'NBGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'NBGame';
		
   REPLACE INTO `betting_nb`
    	SELECT NEW.betId,  
           NEW.betAmount,
           NEW.validbet,
           NEW.winorloss,
           NEW.betTime,
           NEW.billTime,
           NEW.sportNo,
           NEW.raceName,
	       NEW.macthId,
	       NEW.macthName,
	       NEW.gameType,
	       NEW.gameName,
	       NEW.optionId,
	       NEW.optionName,
	       NEW.odds,
		   
		   loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           'TY' AS gamebigtype
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'NBGame';

END;

DROP TRIGGER IF EXISTS `trg_api_nb_gameinfo_after_delete`;
CREATE TRIGGER `trg_api_nb_gameinfo_after_delete` AFTER DELETE ON `api_nb_gameinfo` FOR EACH ROW BEGIN

        DELETE FROM betting_nb WHERE betId = OLD.betId;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'NB' AND gametype='NBGame' AND platformid = OLD.betId;
END
;;

INSERT INTO `game` (`gamecode`, `gametype`, `gamename`, `sort`, `picid`, `android`, `h5`, `iso`, `downloadurl`, `datastatus`) VALUES
('G060', 'HGGame', 'HG电子', '52', 'pic036', NULL, NULL, NULL, NULL, '1');

INSERT INTO `game_category` (`categorycode`, `gametype`, `categorytype`, `categoryname`, `minbonus`, `maxbonus`, `sort`) VALUES 
('121', 'HGGame', 'DZ', '电子', '0.0000', '1.0000', '19');
INSERT INTO `game_category` (`categorycode`, `gametype`, `categorytype`, `categoryname`, `minbonus`, `maxbonus`, `sort`) VALUES 
('122', 'NBGame', 'TY', '体育', '0.0000', '1.0000', '19');

INSERT INTO `employee_gamecataloy_bonus` (`employeecode`, `gametype`, `categorytype`, `parentemployeecode`, `bonus`) VALUES
('E0000000', 'NBGame', 'TY', '00000000', '1.0000'),
('E0000000', 'HGGame', 'DZ', '00000000', '1.0000');

-- add by link 2018-06-01 KG彩票相关sql
CREATE TABLE `api_kg_lottery_gameinfo` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`betId` VARCHAR(255) NULL DEFAULT NULL COMMENT '投注ID',
	`gameName` VARCHAR(255) NULL DEFAULT NULL COMMENT '游戏名称',
	`gameId` VARCHAR(255) NULL DEFAULT NULL,
	`userName` VARCHAR(64) NULL DEFAULT NULL COMMENT '用户名',
	`regionId` VARCHAR(64) NULL DEFAULT NULL,
	`betTypeName` VARCHAR(255) NULL DEFAULT NULL COMMENT '下单项',
	`betSlip` VARCHAR(255) NULL DEFAULT NULL,
	`betAmount` DECIMAL(16,4) NULL DEFAULT NULL COMMENT '下单金额',
	`valBetAmount` DECIMAL(11,2) NULL DEFAULT NULL,
	`credit` DECIMAL(11,2) NULL DEFAULT NULL,
	`winOrLoss` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '结算结果',
	`jackpot` DECIMAL(11,2) NULL DEFAULT NULL,
	`betTime` DATETIME NULL DEFAULT NULL COMMENT '下单时间',
	`updateTime` DATETIME NULL,
	`odds` VARCHAR(50) NULL DEFAULT NULL COMMENT '期数',
	`betStatus` VARCHAR(50) NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `IDX_betId` (`betId`) USING BTREE,
	INDEX `IDX_userName` (`userName`) USING BTREE,
	INDEX `IDX_betTime` (`betTime`) USING BTREE
)
COMMENT='kg彩票游戏数据表'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `betting_kg_lottery` (
	`id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '唯一编号【抓取历史数据使用】',
	`betId` VARCHAR(255) NULL DEFAULT NULL COMMENT '投注ID',
	`betTime` DATETIME NULL DEFAULT NULL COMMENT '玩家下注该期的时间',
	`gameName` VARCHAR(255) NULL DEFAULT NULL COMMENT '游戏名称',
	`gameId` VARCHAR(255) NULL DEFAULT NULL COMMENT '游戏编号与符号‘-',
	`regionId` VARCHAR(64) NULL DEFAULT NULL COMMENT '赛事 ID',
	`betTypeName` VARCHAR(255) NULL DEFAULT NULL COMMENT '下单项',
	`betSlip` VARCHAR(255) NULL DEFAULT NULL COMMENT '游戏编号',
	`betAmount` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '玩家的下注金额',
	`valBetAmount` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '有效流水）为不计个人奖金回退',
	`credit` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '玩家的当前余额',
	`winOrLoss` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '玩家的输赢金额-赢/输则出现负数如: (-) ',
	`jackpot` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '玩家的个人累积奖金',
	`updateTime` DATETIME NULL DEFAULT NULL COMMENT '系统派彩该期的时间',
	`odds` VARCHAR(50) NULL DEFAULT NULL COMMENT '返点',
	`userName` VARCHAR(64) NULL DEFAULT NULL COMMENT '用户名',
	`betStatus` VARCHAR(255) NULL DEFAULT NULL COMMENT '状态',
	`enterprisecode` VARCHAR(255) NULL DEFAULT NULL COMMENT '企业编码',
	`brandcode` VARCHAR(255) NULL DEFAULT NULL COMMENT '企业code',
	`employeecode` VARCHAR(255) NULL DEFAULT NULL COMMENT '员工编号',
	`parentemployeecode` VARCHAR(255) NULL DEFAULT NULL COMMENT '员工父类编号',
	`gamebigtype` VARCHAR(255) NULL DEFAULT NULL COMMENT '游戏大类',
	PRIMARY KEY (`id`),
	INDEX `IDX_betId` (`betId`) USING BTREE,
	INDEX `IDX_userName` (`userName`) USING BTREE,
	INDEX `IDX_betTime` (`betTime`) USING BTREE,
	INDEX `IDX_betStatus` (`betStatus`) USING BTREE
)
COMMENT='kg彩票游戏数据表'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE DEFINER=`root`@`%` TRIGGER `api_kg_lottery_gameinfo_after_insert` AFTER INSERT ON `api_kg_lottery_gameinfo` FOR EACH ROW BEGIN
  REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,
   		enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'KGGL' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.valBetAmount AS validbet, NEW.winOrLoss AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'KGGL' AS gamebigtype  ,'KGGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'KGGame';

	
   REPLACE INTO betting_kg_lottery (betId,betTime,gameName,gameId,regionId,betTypeName,betSlip,betAmount,valBetAmount,
			credit,winOrLoss,jackpot,updateTime,odds,userName,enterprisecode,brandcode,employeecode,parentemployeecode,gamebigtype)
    	SELECT NEW.betId,
           NEW.betTime,
           NEW.gameName,
           NEW.gameId,
           NEW.regionId,
           NEW.betTypeName,
           NEW.betSlip,
		     NEW.betAmount,
		     NEW.valBetAmount,
           NEW.credit,
		     NEW.winOrLoss,
		     NEW.jackpot,
		     NEW.updateTime,
		     NEW.odds,
		     loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           'KGGL' AS gamebigtype
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'KGGame';

END

CREATE DEFINER=`root`@`%` TRIGGER `api_kg_lottery_gameinfo_after_delete` AFTER DELETE ON `api_kg_lottery_gameinfo` FOR EACH ROW BEGIN

DELETE FROM betting_kg_lottery WHERE betId = OLD.betId;
DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'KGGL' AND gametype='KGGame' AND platformid = OLD.betId;
     
END

INSERT INTO `game` (`GAMECODE`, `GAMETYPE`, `GAMENAME`, `SORT`, `PICID`, `ANDROID`, `H5`, `ISO`, `DOWNLOADURL`) VALUES ('G00S', 'KGGame', 'KG彩票', 53, NULL, NULL, NULL, NULL, NULL);

INSERT INTO `api_tb_game` (`GAME_ID`, `GAME_NAME`) VALUES (38, 'KG彩票');

INSERT INTO `api_tb_proxy` (`PROXY_ID`, `PROXY_NAME`, `PROXY_SITE`, `PROXY_KEY1`, `PROXY_KEY2`, `PROXY_CODE`) VALUES (115, 'DFH-KGGL', '巅峰会（KGGL）', 'dfh', '264', 'EN0044');

INSERT INTO `api_tb_proxy_key` (`PROXY_KEY_ID`, `PROXY_ID`, `GAME_ID`, `PROXY_MD5_KEY`, `PROXY_API_URL`) VALUES (122, 115, 38, 'DUkgi3Cw3wSm1fBt', 'http://gameinfo2.v88kgg.com/GameInfo.php');

-- 游戏报表菜单插入  add by link 2018-06-01
INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99894', 'MN0045', 'KG彩票', 'kg_lottery', '/KGGameLottery/list', 17, 3, 1, '1');

INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99895', 'MN0045', 'NB体育', 'nb', '/NB/list', 18, 3, 1, '1');

INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99896', 'MN0045', 'YSB体育', 'ysb', '/YSB/list', 19, 3, 1, '1');

INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`, `repeattime`) VALUES ('begin.time.kggame', 'KG彩票数据采集', 'EN0044=2018-06-02 14:10;', '20180601200600', 0, 0, 13248, 0, '无', 'KGGame', NULL);

INSERT INTO `game_category` (`categorycode`, `gametype`, `categorytype`, `categoryname`, `minbonus`, `maxbonus`, `sort`) VALUES 
('125', 'KGGame', 'CP', '彩票', '0.0000', '1.0000', '20');
INSERT INTO `employee_gamecataloy_bonus` (`employeecode`, `gametype`, `categorytype`, `parentemployeecode`, `bonus`) VALUES
('E0000000', 'KGGame', 'CP', '00000000', '1.0000');


--  HG游戏相关SQL开始
CREATE TABLE `api_hg_live_gameinfo` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`betId` VARCHAR(255) NULL DEFAULT NULL COMMENT '投注ID',
	`gameName` VARCHAR(255) NULL DEFAULT NULL COMMENT '游戏名称',
	`gameId` VARCHAR(255) NULL DEFAULT NULL,
	`userName` VARCHAR(64) NULL DEFAULT NULL COMMENT '用户名',
	`regionId` VARCHAR(64) NULL DEFAULT NULL,
	`betTypeName` VARCHAR(255) NULL DEFAULT NULL COMMENT '下单项',
	`betSlip` VARCHAR(255) NULL DEFAULT NULL,
	`betAmount` DECIMAL(16,4) NULL DEFAULT NULL COMMENT '下单金额',
	`valBetAmount` DECIMAL(11,2) NULL DEFAULT NULL,
	`credit` DECIMAL(11,2) NULL DEFAULT NULL,
	`winOrLoss` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '结算结果',
	`jackpot` DECIMAL(11,2) NULL DEFAULT NULL,
	`betTime` DATETIME NULL DEFAULT NULL COMMENT '下单时间',
	`updateTime` DATETIME NULL DEFAULT NULL,
	`odds` VARCHAR(50) NULL DEFAULT NULL COMMENT '期数',
	`betStatus` VARCHAR(50) NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `IDX_betId` (`betId`) USING BTREE,
	INDEX `IDX_userName` (`userName`) USING BTREE,
	INDEX `IDX_betTime` (`betTime`) USING BTREE
)
COMMENT='HG真人游戏数据表'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
CREATE TABLE `betting_hg_live` (
	`id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '唯一编号【抓取历史数据使用】',
	`betId` VARCHAR(255) NULL DEFAULT NULL COMMENT '投注ID',
	`betTime` DATETIME NULL DEFAULT NULL COMMENT '玩家下注该期的时间',
	`gameName` VARCHAR(255) NULL DEFAULT NULL COMMENT '游戏名称',
	`gameId` VARCHAR(255) NULL DEFAULT NULL COMMENT '游戏编号与符号‘-',
	`regionId` VARCHAR(64) NULL DEFAULT NULL COMMENT '赛事 ID',
	`betTypeName` VARCHAR(255) NULL DEFAULT NULL COMMENT '下单项',
	`betSlip` VARCHAR(255) NULL DEFAULT NULL COMMENT '游戏编号',
	`betAmount` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '玩家的下注金额',
	`valBetAmount` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '有效流水）为不计个人奖金回退',
	`credit` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '玩家的当前余额',
	`winOrLoss` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '玩家的输赢金额-赢/输则出现负数如: (-) ',
	`jackpot` DECIMAL(11,2) NULL DEFAULT NULL COMMENT '玩家的个人累积奖金',
	`updateTime` DATETIME NULL DEFAULT NULL COMMENT '系统派彩该期的时间',
	`odds` VARCHAR(50) NULL DEFAULT NULL COMMENT '返点',
	`userName` VARCHAR(64) NULL DEFAULT NULL COMMENT '用户名',
	`betStatus` VARCHAR(255) NULL DEFAULT NULL COMMENT '状态',
	`enterprisecode` VARCHAR(255) NULL DEFAULT NULL COMMENT '企业编码',
	`brandcode` VARCHAR(255) NULL DEFAULT NULL COMMENT '企业code',
	`employeecode` VARCHAR(255) NULL DEFAULT NULL COMMENT '员工编号',
	`parentemployeecode` VARCHAR(255) NULL DEFAULT NULL COMMENT '员工父类编号',
	`gamebigtype` VARCHAR(255) NULL DEFAULT NULL COMMENT '游戏大类',
	PRIMARY KEY (`id`),
	INDEX `IDX_betId` (`betId`) USING BTREE,
	INDEX `IDX_userName` (`userName`) USING BTREE,
	INDEX `IDX_betTime` (`betTime`) USING BTREE,
	INDEX `IDX_betStatus` (`betStatus`) USING BTREE
)
COMMENT='HG真人游戏数据表'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
CREATE TRIGGER `api_hg_live_gameinfo_after_delete` AFTER DELETE ON `api_hg_live_gameinfo` FOR EACH ROW BEGIN
DELETE FROM betting_hg_live WHERE betId = OLD.betId;
DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'HGL' AND gametype='HGGame' AND platformid = OLD.betId;
END

CREATE DEFINER=`root`@`%` TRIGGER `api_hg_live_gameinfo_after_insert` AFTER INSERT ON `api_hg_live_gameinfo` FOR EACH ROW BEGIN
REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,
   		enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'HGL' platformtype, NEW.betId AS platformid, employeecode, NEW.betTime AS bettime,NEW.betAmount AS betmoney, NEW.valBetAmount AS validbet, NEW.winOrLoss AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'HGL' AS gamebigtype  ,'KGGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userName
   	       AND gametype = 'HGGame';

	
   REPLACE INTO betting_hg_live (betId,betTime,gameName,gameId,regionId,betTypeName,betSlip,betAmount,valBetAmount,
			credit,winOrLoss,jackpot,updateTime,odds,userName,enterprisecode,brandcode,employeecode,parentemployeecode,gamebigtype)
    	SELECT NEW.betId,
           NEW.betTime,
           NEW.gameName,
           NEW.gameId,
           NEW.regionId,
           NEW.betTypeName,
           NEW.betSlip,
		     NEW.betAmount,
		     NEW.valBetAmount,
           NEW.credit,
		     NEW.winOrLoss,
		     NEW.jackpot,
		     NEW.updateTime,
		     NEW.odds,
		     loginaccount AS userName,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           'HGL' AS gamebigtype
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userName
   AND gametype = 'HGGame';
END


INSERT INTO `game` (`gamecode`, `gametype`, `gamename`, `sort`, `picid`, `android`, `h5`, `iso`, `downloadurl`, `datastatus`) VALUES ('G060', 'HGGame', 'HG真人', 52, NULL, NULL, NULL, NULL, NULL, '1');


INSERT INTO `api_tb_game` (`GAME_ID`, `GAME_NAME`) VALUES (40, 'HG真人');

INSERT INTO `data_handle_maintenance` (`gametype`, `flag`, `lasttime`, `remark`) VALUES ('HGGame', 1, '2018-06-07 00:55:01', NULL);

INSERT INTO `api_tb_proxy` (`PROXY_ID`, `PROXY_NAME`, `PROXY_SITE`, `PROXY_KEY1`, `PROXY_KEY2`, `PROXY_CODE`) VALUES (119, 'DFH-HGL', '巅峰会（HGL）', 'web@play8live.com', '1qaz@WSX', 'EN0044');

INSERT INTO `api_tb_proxy_key` (`PROXY_KEY_ID`, `PROXY_ID`, `GAME_ID`, `PROXY_MD5_KEY`, `PROXY_API_URL`) VALUES (124, 119, 40, 'play8live1segame', 'http://webapi-asia.hointeractive.com/Betapi.asmx');

INSERT INTO `data_handle` (`handlecode`, `handledesc`, `updatetime`, `lasttime`, `lastnum`, `daynum`, `allnum`, `intervalnum`, `remark`, `gametype`, `repeattime`) VALUES ('begin.time.hggame', 'HG真人数据采集', 'EN0044=2018-06-07 23:00:00;', '20180607230000', 0, 0, 0, 0, '无', 'HGGame', NULL);


INSERT INTO `permission_menu` (`menucode`, `parentmenucode`, `menuname`, `englishname`, `menuurl`, `menusort`, `menulevel`, `menustatus`, `datastatus`) VALUES ('M99897', 'MN0045', 'HG真人', 'hgl', '/HGGameLive/list', 20, 3, 1, '1');

ALTER TABLE betting_all_game_winlose_detail ADD COLUMN `returnTime` datetime DEFAULT NULL COMMENT '洗码时间';
