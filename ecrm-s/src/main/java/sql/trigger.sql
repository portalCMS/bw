DROP TRIGGER IF EXISTS `trg_api_aoi_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_aoi_gameinfo_after_insert` AFTER INSERT ON `api_aoi_gameinfo` FOR EACH ROW BEGIN
   
   
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'OG' AS platformtype, NEW.aoi_ProductId AS platformid,employeecode, NEW.aoi_AddTime AS bettime, NEW.aoi_BettingAmount AS betmoney, NEW.aoi_ValidAmount AS validbet, NEW.aoi_WinLoseAmount AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype ,'OGGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.aoi_UserName
   	       AND gametype = 'OGGame';
		
   REPLACE INTO betting_hq_og_og
    SELECT NEW.aoi_ProductId AS aoi_Product_Id,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           NEW.aoi_UserName AS aoi_User_Name,
           NEW.aoi_GameRecordId AS aoi_Game_Record_Id,
           NEW.aoi_OrderNumber AS aoi_Order_Number,
           NEW.aoi_TableId AS aoi_Table_Id,
           NEW.aoi_Stage AS aoi_Stage,
           NEW.aoi_Inning AS aoi_Inning,
           NEW.aoi_GameNameId AS aoi_Game_Name_Id,
           NEW.aoi_GameBettingKind AS aoi_Game_Betting_Kind,
           NEW.aoi_GameBettingContent AS aoi_Game_Betting_Content,
           NEW.aoi_ResultType AS aoi_Result_Type,
           NEW.aoi_BettingAmount AS aoi_Betting_Amount,
           NEW.aoi_CompensateRate AS aoi_Compensate_Rate,
           NEW.aoi_WinLoseAmount AS aoi_Win_Lose_Amount,
           NEW.aoi_Balance AS aoi_Balance,
           NEW.aoi_AddTime AS aoi_Add_Time,
           NEW.aoi_VendorId AS aoi_Vendor_Id,
           NEW.aoi_ValidAmount AS aoi_Valid_Amount,
           NEW.aoi_PlatformID AS aoi_Platform_ID,
           NEW.aoi_createtime AS aoi_createtime,
           CURRENT_TIMESTAMP AS Last_Time,
           employeecode AS employeecode,
           loginaccount AS loginaccount,
           parentemployeecode AS parentemployeecode,
           'SX' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.aoi_UserName
   AND gametype = 'OGGame';
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_aoi_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_aoi_gameinfo_after_delete` AFTER DELETE ON `api_aoi_gameinfo` FOR EACH ROW BEGIN
   DELETE FROM betting_hq_og_og WHERE aoi_Product_Id = OLD.aoi_ProductId;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'OG' AND platformid = OLD.aoi_ProductId;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_av_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_av_gameinfo_after_insert` AFTER INSERT ON `api_av_gameinfo` FOR EACH ROW BEGIN

        
   
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'AV' platformtype, NEW.tid AS platformid, employeecode, NEW.time AS bettime,NEW.amount AS betmoney, NEW.amount AS validbet, NEW.amount2 AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype,'AVGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userID
   	       AND gametype = 'AVGame';
		
   REPLACE INTO betting_kr_av
    SELECT NEW.tid AS tid,           
           NEW.transType AS transtype,
           NEW.amount AS amount,
           NEW.transType2 AS transtype2,           
           NEW.amount2 AS amount2,
           NEW.provider AS provider,
           NEW.roundID AS roundid,           
           NEW.gameInfo AS gameinfo,           
           NEW.history AS history,
           NEW.createtime AS createtime,     
           NEW.isRoundFinished as isroundfinished,
           NEW.time as time,
           NEW.userID as userid,                 
           employeecode AS employeecode,
           loginaccount AS loginaccount,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           parentemployeecode AS parentemployeecode,
           'DZ' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userID
   AND gametype = 'AVGame';

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_av_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_av_gameinfo_after_delete` AFTER DELETE ON `api_av_gameinfo` FOR EACH ROW BEGIN
DELETE FROM betting_kr_av WHERE tid = OLD.tid;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'AV' AND platformid = OLD.tid;

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_bbin_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_bbin_gameinfo_after_insert` AFTER INSERT ON `api_bbin_gameinfo` FOR EACH ROW BEGIN



   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'BBIN' platformtype, NEW.bbin_WagersID AS platformid, employeecode, NEW.bbin_WagersDate AS bettime,NEW.bbin_BetAmount AS betmoney, NEW.bbin_Commissionable AS validbet, (NEW.bbin_Payoff) AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,NEW.Platformflag AS gamebigtype ,'BBINGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.bbin_UserName
   	       AND gametype = 'BBINGame';
		
   REPLACE INTO betting_hq_bbin
    SELECT NEW.bbin_WagersID AS bbin_Wagers_Id,      
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,
                                 
           NEW.bbin_UserName AS bbin_User_Name,
           NEW.bbin_WagersDate AS bbin_Wagers_Date,           
           NEW.bbin_SerialID AS bbin_Serial_Id,
           NEW.bbin_RoundNo AS bbin_Round_No,
           NEW.bbin_GameType AS bbin_Game_Type,
           NEW.bbin_GameCode AS bbin_Game_Code,
           NEW.bbin_Result AS bbin_Result,
           NEW.bbin_ResultType AS bbin_Result_Type,
           NEW.bbin_Card AS bbin_Card,       
           NEW.bbin_BetAmount AS bbin_Bet_Amount,
           
           NEW.bbin_Payoff AS bbin_Payoff,
           NEW.bbin_Currency AS bbin_Currency,
           NEW.bbin_ExchangeRate AS bbin_Exchange_Rate,
           NEW.bbin_Commissionable AS bbin_Commissionable,
           NEW.bbin_Commission AS bbin_Commission,
           NEW.bbin_Origin AS bbin_Origin,  
           NULL AS  bbin_Modified_Date,        
           NEW.bbin_IsPaid AS bbin_Is_Paid,
           NULL AS bbin_Order_Date,
           NULL AS bbin_UPTIME,
           NEW.bbin_createtime AS bbin_createtime,  
           NULL AS Last_Time, 
           NEW.Platformflag AS gamebigtype,
           0 AS status,
           NEW.bbin_WagerDetail AS bbin_Wager_Detail
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.bbin_UserName
   AND gametype = 'BBINGame';




END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_bbin_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_bbin_gameinfo_after_delete` AFTER DELETE ON `api_bbin_gameinfo` FOR EACH ROW BEGIN

DELETE FROM betting_hq_bbin WHERE bbin_Wagers_Id = OLD.bbin_WagersID;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'BBIN' AND platformid = OLD.bbin_WagersID;

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_ebet_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_ebet_gameinfo_after_insert` AFTER INSERT ON `api_ebet_gameinfo` FOR EACH ROW BEGIN


   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'EBET' platformtype, NEW.bethistoryid AS platformid, employeecode, NEW.bettime AS bettime,NEW.betmoney AS betmoney, NEW.validbet AS validbet, NEW.netmoney AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype  ,'EBETGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.username
   	       AND gametype = 'EBETGame';
		
   REPLACE INTO betting_ebet
    SELECT NEW.bethistoryid AS bethistoryid,      
           
                      
           NEW.gametype AS gametype,
           NEW.gamename AS gamename,
           NEW.betmap AS betmap,
           NEW.judgeresult AS judgeresult,
           NEW.userid AS userid,
           NEW.payouttime AS payouttime,
           NEW.gametime AS gametime,
           NEW.roundno AS roundno,
           NEW.subchannelid AS subchannelid,
           NEW.validbet AS validbet,
           NEW.payout AS payout,           
           NEW.username AS username,
           NEW.bankercards AS bankercards,
           NEW.tigercard AS tigercard,
           NEW.dragoncard AS dragoncard,
           NEW.numbercard AS numbercard,
           NEW.alldices AS alldices,
           NEW.playercards AS playercards,       
           NEW.createtime AS createtime,
               
           NEW.bettime AS bettime,
           NEW.betmoney AS betmoney,   
           NEW.netmoney AS netmoney,        
           
           
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,           
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,
           'SX' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.username
   AND gametype = 'EBETGame';

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_ebet_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_ebet_gameinfo_after_delete` AFTER DELETE ON `api_ebet_gameinfo` FOR EACH ROW BEGIN


        DELETE FROM betting_ebet WHERE bethistoryid = OLD.bethistoryid;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'EBET' AND platformid = OLD.bethistoryid;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_eibc_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_eibc_gameinfo_after_insert` AFTER INSERT ON `api_eibc_gameinfo` FOR EACH ROW BEGIN


   	
        REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'EIBC' platformtype, NEW.transid AS platformid, employeecode, NEW.nettime AS bettime,NEW.betmoney AS betmoney, NEW.betmoney AS validbet, NEW.netmoney AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'TY' AS gamebigtype ,'eIBCGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.playername
   	       AND gametype = 'eIBCGame';
		
   REPLACE INTO betting_eibc
    SELECT NEW.transid AS transid,      
         
           NEW.playername AS playername,
           NEW.transactiontime AS transactiontime,
           NEW.matchid AS matchid,
           NEW.leagueid AS leagueid,
           NEW.leaguename AS leaguename,
           NEW.sporttype AS sporttype,
           NEW.awayid AS awayid,
           NEW.awayidname AS awayidname,
           NEW.homeid AS homeid,
           NEW.homeidname AS homeidname,
           NEW.matchdatetime AS matchdatetime,           
           NEW.bettype AS bettype,
           NEW.parlayrefno AS parlayrefno,
           NEW.betteam AS betteam,
           NEW.hdp AS hdp,
           NEW.awayhdp AS awayhdp,
           NEW.homehdp AS homehdp,
           NEW.odds AS odds,           
           NEW.oddstype AS oddstype,
           NEW.awayscore AS awayscore,
           NEW.homescore AS homescore,
           NEW.islive AS islive,
           NEW.lastballno AS lastballno,
           NEW.ticketstatus AS ticketstatus,
           NEW.stake AS stake,           
           NEW.winloseamount AS winloseamount,
           NEW.winlostdatetime AS winlostdatetime,
           NEW.currency AS currency,
           NEW.versionkey AS versionkey,
           
           NEW.createtime AS createtime,
           NEW.bettime AS bettime,
           NEW.betmoney AS betmoney,
           NEW.netmoney AS netmoney,                 
           NEW.nettime AS nettime,   
           
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,           
           'TY' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.playername
   AND gametype = 'eIBCGame';

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_eibc_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_eibc_gameinfo_after_delete` AFTER DELETE ON `api_eibc_gameinfo` FOR EACH ROW BEGIN

DELETE FROM betting_eibc WHERE transid = OLD.transid;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'EIBC' AND platformid = OLD.transid;
   
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_gb_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_gb_gameinfo_after_insert` AFTER INSERT ON `api_gb_gameinfo` FOR EACH ROW BEGIN

   	       
        REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'GB' platformtype, NEW.settleid AS platformid, employeecode, NEW.bettime AS bettime,NEW.betmoney AS betmoney, NEW.betmoney AS validbet, NEW.netmoney AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'CP' AS gamebigtype,'GBGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.memberid
   	       AND gametype = 'GBGame';
		
   REPLACE INTO betting_gb
    SELECT NEW.settleid AS settleid,      
         
           NEW.betid AS betid,
           NEW.betgrpno AS betgrpno,
           NEW.tpcode AS tpcode,
           NEW.gbsn AS gbsn,
           NEW.memberid AS memberid,
           NEW.curcode AS curcode,
           NEW.betdt AS betdt,
           NEW.bettype AS bettype,
           NEW.bettypeparam1 AS bettypeparam1,
           NEW.bettypeparam2 AS bettypeparam2,
           NEW.wintype AS wintype,           
           NEW.hxmguid AS hxmguid,
           NEW.initbetamt AS initbetamt,
           NEW.realbetamt AS realbetamt,
           NEW.holdingamt AS holdingamt,
           NEW.initbetrate AS initbetrate,
           NEW.realbetrate AS realbetrate,
           NEW.prewinamt AS prewinamt,           
           NEW.betresult AS betresult,
           NEW.wlamt AS wlamt,
           NEW.refundbetamt AS refundbetamt,
           NEW.ticketbetamt AS ticketbetamt,
           NEW.ticketresult AS ticketresult,
           NEW.ticketwlamt AS ticketwlamt,
           NEW.settledt AS settledt,           
           NEW.kenolist AS kenolist,
           NEW.lottolist AS lottolist,
           NEW.ssclist AS ssclist,
           
           NEW.createtime AS createtime,
           NEW.bettime AS bettime,
           NEW.betmoney AS betmoney,
           NEW.netmoney AS netmoney,                 
           
           
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,           
           'CP' AS gamebigtype,
           0 AS status,
           NEW.pkxlist AS pkxlist
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.memberid
   AND gametype = 'GBGame';
        
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_gb_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_gb_gameinfo_after_delete` AFTER DELETE ON `api_gb_gameinfo` FOR EACH ROW BEGIN

        DELETE FROM betting_gb WHERE settleid = OLD.settleid;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'GB' AND platformid = OLD.settleid;
        
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_gg_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_gg_gameinfo_after_insert` AFTER INSERT ON `api_gg_gameinfo` FOR EACH ROW BEGIN

   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype, gametype)
         SELECT 'GG' platformtype, NEW.autoid AS platformid, employeecode, NEW.bettime AS bettime,NEW.betmoney AS betmoney, NEW.betmoney AS validbet, NEW.netmoney AS netmoney, 
         enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype ,'GGGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.accountno AND gametype = 'GGGame';


                 
  REPLACE INTO betting_gg
    SELECT NEW.autoid AS autoid,           
           NEW.gameId AS gameid,
           NEW.cuuency AS cuuency,
           NEW.linkId AS linkid,           
           NEW.accountno AS accountno,
           NEW.betmoney AS betmoney,
           NEW.netmoney AS netmoney,           
           NEW.bettime AS bettime,           
           NEW.createtime AS createtime,      
           NEW.Platformflag AS platformflag,           
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,     
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,           
           'DZ' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.accountno
   AND gametype = 'GGGame';

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_gg_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_gg_gameinfo_after_delete` AFTER DELETE ON `api_gg_gameinfo` FOR EACH ROW BEGIN
   DELETE FROM betting_gg WHERE autoid = OLD.autoid;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'GG' AND platformid = OLD.autoid;

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_ggp_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_ggp_gameinfo_after_insert` AFTER INSERT ON `api_ggp_gameinfo` FOR EACH ROW BEGIN


REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'GGP' platformtype, NEW.lsh AS platformid, employeecode, now() AS bettime,NEW.ngr AS betmoney, NEW.ngr AS validbet, NEW.ngr AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'QP' AS gamebigtype,'GGPGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.username AND gametype = 'GGPGame';


                 
  REPLACE INTO betting_ggp
    SELECT NEW.lsh AS lsh,           
           NEW.gamedate AS gamedate,
           NEW.username AS username,
           NEW.ngr AS ngr,           
           now() AS createtime,          
           NEW.ngr AS betmoney,                    
             
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,     
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,           
           'QP' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.username
   AND gametype = 'GGPGame';
   
   
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_ggp_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_ggp_gameinfo_after_delete` AFTER DELETE ON `api_ggp_gameinfo` FOR EACH ROW BEGIN

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_hab_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_hab_gameinfo_after_insert` AFTER INSERT ON `api_hab_gameinfo` FOR EACH ROW BEGIN


        REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'HAB' platformtype, NEW.friendlygameinstanceid AS platformid, employeecode, NEW.bettime AS bettime,NEW.betmoney AS betmoney, NEW.betmoney AS validbet, NEW.netmoney AS netmoney, 
         enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype  ,'HABGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.username AND gametype = 'HABGame';


                 
  REPLACE INTO betting_hab
    SELECT NEW.friendlygameinstanceid AS friendlygameinstanceid,           
           NEW.playerid AS playerid,
           NEW.brandid AS brandid,           
           NEW.username AS username,
           NEW.brandgameid AS brandgameid,
           NEW.gamekeyname AS gamekeyname,           
           NEW.gametypeid AS gametypeid,           
           NEW.dtstarted AS dtstarted,      
           NEW.dtcompleted AS dtcompleted,      
           NEW.gameinstanceid AS gameinstanceid,           
           NEW.stake AS stake,           
           NEW.payout AS payout,      
           NEW.jackpotwin AS jackpotwin,  
           NEW.jackpotcontribution AS jackpotcontribution,           
           NEW.currencycode AS currencycode,           
           NEW.channeltypeid AS channeltypeid,      
           NEW.createtime AS createtime,            
           NEW.bettime AS bettime,           
           NEW.betmoney AS betmoney,           
           NEW.netmoney AS netmoney,                 
                       
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,     
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,           
           'DZ' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.username
   AND gametype = 'HABGame';
   
   
   
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_hab_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_hab_gameinfo_after_delete` AFTER DELETE ON `api_hab_gameinfo` FOR EACH ROW BEGIN

   DELETE FROM betting_hab WHERE friendlygameinstanceid = OLD.friendlygameinstanceid;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'HAB' AND platformid = OLD.friendlygameinstanceid;

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_ibc_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_ibc_gameinfo_after_insert` AFTER INSERT ON `api_ibc_gameinfo` FOR EACH ROW BEGIN
   
   
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'IBC' AS platformtype, NEW.ibc_rowguid AS platformid, employeecode, NEW.ibc_balltime AS bettime, NEW.ibc_tzmoney AS betmoney, NEW.ibc_tzmoney AS validbet, NEW.ibc_win-NEW.ibc_lose AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,'TY' AS gamebigtype ,'IBCGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.ibc_username
   	       AND gametype = 'IBCGame';
		
   REPLACE INTO betting_hq_og_ibc
    SELECT NEW.ibc_rowguid AS ibc_rowguid,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           NEW.ibc_ballid AS ibc_ballid,
           NEW.ibc_balltime AS ibc_balltime,
           NEW.ibc_content AS ibc_content,
           NEW.ibc_curpl AS ibc_curpl,
           NEW.ibc_ds AS ibc_ds,
           NEW.ibc_dxc AS ibc_dxc,
           NEW.ibc_isbk AS ibc_isbk,
           NEW.ibc_iscancel AS ibc_iscancel,
           NEW.ibc_isdanger AS ibc_isdanger,
           NEW.ibc_isjs AS ibc_isjs,
           NEW.ibc_lose AS ibc_lose,
           NEW.ibc_matchid AS ibc_matchid,
           NEW.ibc_moneyrate AS ibc_moneyrate,
           NEW.ibc_orderid AS ibc_orderid,
           NEW.ibc_recard AS ibc_recard,
           NEW.ibc_result AS ibc_result,
           NEW.ibc_rqc AS ibc_rqc,
           NEW.ibc_rqteam AS ibc_rqteam,
           NEW.ibc_sportid AS ibc_sportid,
           NEW.ibc_tballtime AS ibc_tballtime,
           NEW.ibc_thisdate AS ibc_thisdate,
           NEW.ibc_truewin AS ibc_truewin,
           NEW.ibc_tzip AS ibc_tzip,
           NEW.ibc_tzmoney AS ibc_tzmoney,
           NEW.ibc_tzteam AS ibc_tzteam,
           NEW.ibc_tztype AS ibc_tztype,
           NEW.ibc_updatetime AS ibc_updatetime,
           NEW.ibc_username AS ibc_username,
           NEW.ibc_win AS ibc_win,
           NEW.ibc_zdbf AS ibc_zdbf,
           NEW.ibc_vendorid AS ibc_vendorid,
           NEW.ibc_createtime AS ibc_createtime,
           CURRENT_TIMESTAMP AS Last_Time,
           employeecode AS employeecode,
           loginaccount AS loginaccount,
           parentemployeecode AS parentemployeecode,
           'TY' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.ibc_username
   AND gametype = 'IBCGame';
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_ibc_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_ibc_gameinfo_after_delete` AFTER DELETE ON `api_ibc_gameinfo` FOR EACH ROW BEGIN
   DELETE FROM betting_hq_og_ibc WHERE ibc_rowguid = OLD.ibc_rowguid;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'IBC' AND platformid = OLD.ibc_rowguid;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_idn_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_idn_gameinfo_after_insert` AFTER INSERT ON `api_idn_gameinfo` FOR EACH ROW BEGIN

        REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'IDN' platformtype, NEW.transactionno AS platformid, employeecode, NEW.bettime AS bettime,NEW.betmoney AS betmoney, NEW.betmoney AS validbet, NEW.netmoney AS netmoney, 
         enterprisecode,brandcode,loginaccount,parentemployeecode,'QP' AS gamebigtype,'IDNGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = lower(NEW.userid) AND gametype = 'IDNGame';


                 
  REPLACE INTO betting_idn
    SELECT NEW.transactionno AS transactionno,           
           NEW.tableno AS tableno,
           lower(NEW.userid) AS userid,
           NEW.betdate AS betdate,           
           NEW.game AS game,
           NEW.bettable AS bettable,
           NEW.periode AS periode,           
           NEW.room AS room,           
           NEW.bet AS bet,      
           NEW.currbet AS currbet,      
           NEW.rbet AS rbet,           
           NEW.status AS game_status,           
           NEW.card AS card,      
           NEW.hand AS hand,  
           NEW.prize AS prize,           
           NEW.curr AS curr,           
           NEW.currplayer AS currplayer,      
           NEW.curramount AS curramount, 
           NEW.amount AS amount,           
           NEW.total AS total,           
           NEW.agentcomission AS agentcomission,      
           NEW.agentbill AS agentbill,             
           NEW.createtime AS createtime,           
           NEW.bettime AS bettime,           
           NEW.betmoney AS betmoney,      
           NEW.netmoney AS netmoney,                  
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,     
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,           
           'QP' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = lower(NEW.userid)
   AND gametype = 'IDNGame';


END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_idn_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_idn_gameinfo_after_delete` AFTER DELETE ON `api_idn_gameinfo` FOR EACH ROW BEGIN

        
        DELETE FROM betting_idn WHERE transactionno = OLD.transactionno;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'IDN' AND platformid = OLD.transactionno;
        
        
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_idn2_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_idn2_gameinfo_after_insert` AFTER INSERT ON `api_idn2_gameinfo` FOR EACH ROW BEGIN

REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'IDN' platformtype, NEW.lsh AS platformid, employeecode, NEW.turnoverdate AS bettime,NEW.totalturnover AS betmoney, NEW.totalturnover AS validbet, NEW.agentcommission AS netmoney, 
         enterprisecode,brandcode,loginaccount,parentemployeecode,'QP' AS gamebigtype ,'IDNGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = lower(NEW.userid) AND gametype = 'IDNGame';


            REPLACE INTO betting_idn2
    SELECT NEW.lsh AS lsh,           
           NEW.turnoverdate AS turnoverdate,
           lower(NEW.userid) AS userid,
           NEW.totalturnover AS totalturnover,           
           NEW.turnoverpoker AS turnoverpoker,
           NEW.turnoverdomino AS turnoverdomino,
           NEW.turnoverceme AS turnoverceme,           
           NEW.turnoverblackjack AS turnoverblackjack,           
           NEW.turnovercapsa AS turnovercapsa,      
           NEW.turnoverlivepoker AS turnoverlivepoker,      
           NEW.texaspoker AS texaspoker,           
           NEW.domino AS domino,           
           NEW.ceme AS ceme,      
           NEW.blackjack AS blackjack,  
           NEW.capsa AS capsa,           
           NEW.livepoker AS livepoker,           
           NEW.pokertournament AS pokertournament,      
           NEW.agentcommission AS agentcommission, 
           NEW.agentbill AS agentbill,           
                     
           NEW.createtime AS createtime,           
           
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,     
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,           
           'QP' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = lower(NEW.userid)
   AND gametype = 'IDNGame';     
  


END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_idn2_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_idn2_gameinfo_after_delete` AFTER DELETE ON `api_idn2_gameinfo` FOR EACH ROW BEGIN

DELETE FROM betting_idn2 WHERE lsh = OLD.lsh;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'IDN' AND platformid = OLD.lsh;

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_im_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_im_gameinfo_after_insert` AFTER INSERT ON `api_im_gameinfo` FOR EACH ROW BEGIN




   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'IM' platformtype, NEW.betid AS platformid, employeecode, NEW.nettime AS bettime,NEW.betmoney AS betmoney, NEW.betmoney AS validbet, NEW.netmoney AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,'TY' AS gamebigtype,'IMGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.playerid
   	       AND gametype = 'IMGame';
  
  
  REPLACE INTO betting_im
    SELECT NEW.betid AS betid,           
           NEW.providername AS providername,
           NEW.gameid AS gameid,
           NEW.wagercreationdatetime AS wagercreationdatetime,
           NEW.currency AS currency,
           NEW.playerid AS playerid,
           NEW.stakeamount AS stakeamount,
           NEW.memberexposure AS memberexposure,
           NEW.payoutamount AS payoutamount,
           NEW.winloss AS winloss,
           NEW.oddstype AS oddstype,
           NEW.wagertype AS wagertype,
           NEW.platform AS platform,
           NEW.issettled AS issettled,
           NEW.isconfirmed AS isconfirmed,
           NEW.iscancelled AS iscancelled,
           NEW.bettradestatus AS bettradestatus,
           NEW.bettradecommission AS bettradecommission,
           NEW.bettradebuybackamount AS bettradebuybackamount,
           NEW.combotype AS combotype,
           NEW.lastupdateddate AS lastupdateddate,
           NEW.detailitems AS detailitems,
           
           NEW.bettime AS bettime,
           NEW.betmoney AS betmoney,
           NEW.nettime AS nettime,
           NEW.netmoney AS netmoney,           
           NEW.createtime AS createtime,
           NEW.platformflag AS platformflag,
           
    
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,   
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,
           'TY' AS gamebigtype,
           0 AS status
           
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.playerid
   AND gametype = 'IMGame';		


END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_im_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_im_gameinfo_after_delete` AFTER DELETE ON `api_im_gameinfo` FOR EACH ROW BEGIN

DELETE FROM betting_im WHERE betid = OLD.betid;
DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'IM' AND platformid = OLD.betid;
   
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_jdb_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_jdb_gameinfo_after_insert` AFTER INSERT ON `api_jdb_gameinfo` FOR EACH ROW BEGIN

	
	REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
    SELECT 'JDB' AS platformtype,NEW.seqNo AS platformid,employeecode,NEW.bettime AS bettime,ABS(NEW.betmoney) AS betmoney,ABS(NEW.betmoney) AS validbet,NEW.netmoney AS netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype, 'JDBGame' AS gametype
	FROM employee_api_accout
	WHERE gameaccount = NEW.playerId
	AND gametype = 'JDBGame';
	
	REPLACE INTO betting_jdb
	SELECT NEW.seqNo AS seqNo,
		NEW.playerId AS playerId,
		NEW.mtype AS mtype,
		NEW.gameDate AS gameDate,
		NEW.bet AS bet,
		NEW.gambleBet AS gambleBet,
		NEW.win AS win,
		NEW.total AS total,
		NEW.currency AS currency,
		NEW.denom AS denom,
		NEW.lastModifyTime AS lastModifyTime,
		NEW.playerIp AS playerIp,
		NEW.clientType AS clientType,
		NEW.gType AS gType,
		NEW.hasGamble AS hasGamble,
		NEW.hasBonusGame AS hasBonusGame,
		NEW.hasFreegame AS hasFreegame,
		NEW.roomType AS roomType,
		NEW.systemTakeWin AS systemTakeWin,
		NEW.jackpot AS jackpot,
		NEW.jackpotContribute AS jackpotContribute,
		NEW.beforeBalance AS beforeBalance,
		NEW.afterBalance AS afterBalance,
	
		enterprisecode AS enterprisecode,
		brandcode AS brandcode,   
		employeecode AS employeecode,
		parentemployeecode AS parentemployeecode,
		loginaccount AS loginaccount,
		'DZ' AS gamebigtype,
		0 AS status,
		
		NEW.createtime AS createtime,
		NEW.bettime AS bettime,
		ABS(NEW.betmoney) AS betmoney,
		NEW.netmoney AS netmoney
		
	FROM employee_api_accout
	WHERE gameaccount = NEW.playerId
	AND gametype = 'JDBGame';		

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_jdb_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_jdb_gameinfo_after_delete` AFTER DELETE ON `api_jdb_gameinfo` FOR EACH ROW BEGIN

DELETE FROM betting_jdb WHERE seqNo = OLD.seqNo;
DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'JDB' AND platformid = OLD.seqNo;
   
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_m88_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_m88_gameinfo_after_insert` AFTER INSERT ON `api_m88_gameinfo` FOR EACH ROW BEGIN
                
        
        REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'M88' platformtype, NEW.transid AS platformid, employeecode, NEW.nettime AS bettime,NEW.betmoney AS betmoney, NEW.betmoney AS validbet, NEW.netmoney AS netmoney, 
         enterprisecode,brandcode,loginaccount,parentemployeecode,'TY' AS gamebigtype,'M88Game' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.memberid AND gametype = 'M88Game';


                 
  REPLACE INTO betting_m88
    SELECT NEW.transid AS transid,           
           NEW.memberid AS memberid,
           NEW.operatorid AS operatorid,           
           NEW.sitecode AS sitecode,
           NEW.leagueid AS leagueid,
           NEW.homeid AS homeid,           
           NEW.awayid AS awayid,           
           NEW.matchdatetime AS matchdatetime,      
           NEW.bettype AS bettype,      
           NEW.parlayrefno AS parlayrefno,           
           NEW.odds AS odds,           
           NEW.currency AS currency,  
           NEW.stake AS stake,  
           NEW.winlostamount AS winlostamount,           
           NEW.transactiontime AS transactiontime,           
           NEW.ticketstatus AS ticketstatus,      
           NEW.versionkey AS versionkey,            
           NEW.winlostdatetime AS winlostdatetime,           
           NEW.oddstype AS oddstype,           
           NEW.sportstype AS sportstype,      
           NEW.betteam AS betteam,  
           NEW.homehdp AS homehdp,           
           NEW.awayhdp AS awayhdp,           
           NEW.matchid AS matchid,      
           NEW.islive AS islive,            
           NEW.homescore AS homescore,           
           NEW.awayscore AS awayscore,           
           NEW.choicecode AS choicecode,   
           NEW.choicename AS choicename,  
           NEW.txntype AS txntype,           
           NEW.lastupdate AS lastupdate,           
           NEW.leaguename AS leaguename,      
           NEW.homename AS homename,            
           NEW.awayname AS awayname,           
           NEW.sportname AS sportname,           
           NEW.oddsname AS oddsname,           
           NEW.bettypename AS bettypename,            
           NEW.winloststatus AS winloststatus,           
           NEW.betmoney AS betmoney,           
           NEW.netmoney AS netmoney,   
           NEW.bettime AS bettime,            
           NEW.nettime AS nettime,           
           NEW.createtime AS createtime,       
                       
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,     
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,           
           'TY' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.memberid
   AND gametype = 'M88Game';
   
           
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_m88_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_m88_gameinfo_after_delete` AFTER DELETE ON `api_m88_gameinfo` FOR EACH ROW BEGIN

   DELETE FROM betting_m88 WHERE transid = OLD.transid;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'M88' AND platformid = OLD.transid;
   
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_mg_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_mg_gameinfo_after_insert` AFTER INSERT ON `api_mg_gameinfo` FOR EACH ROW BEGIN
   
   
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'MG' AS platformtype, NEW.mg_transId AS platformid ,employeecode, NEW.mg_transTime AS bettime, NEW.mg_amnt AS betmoney, NEW.mg_amnt AS validbet, NEW.mg_win AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype,'MGGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.mg_mbrCode
   	       AND gametype = 'MGGame';
		
   REPLACE INTO betting_mg
    SELECT NEW.mg_transId AS mg_trans_Id,
           NEW.mg_key AS mg_key,
           NEW.mg_colId AS mg_col_Id,
           NEW.mg_agentId AS mg_agent_Id,
           NEW.mg_mbrId AS mg_mbr_Id,
           NEW.mg_mbrCode AS mg_mbr_Code,
           NEW.mg_gameId AS mg_game_Id,
           NEW.mg_transType AS mg_trans_Type,
           NEW.mg_transTime AS mg_trans_Time,
           NEW.mg_mgsGameId AS mg_mgs_Game_Id,
           NEW.mg_mgsActionId AS mg_mgs_Action_Id,
           NEW.mg_amnt AS mg_amnt,
           NEW.mg_clrngAmnt AS mg_clrng_Amnt,
           NEW.mg_balance AS mg_balance,
           NEW.mg_refTransId AS mg_ref_Trans_Id,
           NEW.mg_refTransType AS mg_ref_Trans_Type,
           NEW.mg_win AS mg_win,
           NEW.mg_createtime AS mg_createtime,
           NEW.Platformflag AS Platformflag,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,
           'DZ' AS gamebigtype,
           0 AS status,
           NEW.mg_transTime AS bettime,
           NEW.mg_win AS net_money,
           NEW.mg_amnt AS mg_amount
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.mg_mbrCode
   AND gametype = 'MGGame';
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_mg_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_mg_gameinfo_after_delete` AFTER DELETE ON `api_mg_gameinfo` FOR EACH ROW BEGIN
   DELETE FROM betting_mg WHERE mg_trans_Id = OLD.mg_transId;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'MG' AND platformid = OLD.mg_transId;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_nhq_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_nhq_gameinfo_after_insert` AFTER INSERT ON `api_nhq_gameinfo` FOR EACH ROW BEGIN
   
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'HY' platformtype, NEW.BettingID AS platformid,employeecode, NEW.BettingDate AS bettime, NEW.BettingCredits AS betmoney, NEW.WashCodeCredits AS validbet, NEW.WinningCredits AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype,'NHQGame' AS gametype
   	       FROM employee_api_accout
   	      WHERE gameaccount = NEW.UserAccount
		    AND gametype = 'NHQGame';

   
   REPLACE INTO betting_hq_nhq
   SELECT NEW.BettingID AS Betting_ID,
          NEW.BettingNO AS Betting_NO,
          enterprisecode AS enterprisecode,
          brandcode AS brandcode,
          employeecode AS employeecode,
          loginaccount AS loginaccount,
          NEW.BettingCredits AS Betting_Credits,
          NEW.PreCreditsPoint AS Pre_Credits_Point,
          NEW.GameResult AS Game_Result,
          NEW.GameRoomName AS Game_Room_Name,
          NEW.AgentAccount AS Agent_Account,
          NEW.GamblingCode AS Gambling_Code,
          NEW.AfterPayoutCredits AS After_Payout_Credits,
          NEW.UserAccount AS User_Account,
          NEW.GameType AS Game_Type,
          NEW.BettingDate AS Betting_Date,
          NEW.DealerName AS Dealer_Name,
          NEW.GameName AS Game_Name,
          NEW.SetGameNo AS Set_Game_No,
          NEW.IsPayout AS Is_Payout,
          NEW.ParentUserID AS Parent_User_ID,
          NEW.WinningCredits AS Winning_Credits,
          NEW.BettingPoint AS Betting_Point,
          NEW.TableName AS Table_Name,
          NEW.TrackIP AS Track_IP,
          NEW.CreateTime AS Create_Time,
          NEW.WashCodeCredits AS Wash_Code_Credits,
          NEW.UpdateTime AS Update_Time,
          CURRENT_TIMESTAMP AS Last_Time,
          parentemployeecode AS parentemployeecode,
          'SX' AS gamebigtype,
          0 AS status 
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.UserAccount
      AND gametype = 'NHQGame';
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_nhq_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_nhq_gameinfo_after_delete` AFTER DELETE ON `api_nhq_gameinfo` FOR EACH ROW BEGIN
   DELETE FROM betting_hq_nhq WHERE Betting_ID = OLD.BettingID;
   DELETE FROM betting_all_game_winlose_detail WHERE  platformtype = 'HY' AND platformid = OLD.BettingID;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_pt_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_pt_gameinfo_after_insert` AFTER INSERT ON `api_pt_gameinfo` FOR EACH ROW BEGIN
   
   
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'PT' platformtype, NEW.pt_gamecode AS platformid, employeecode, NEW.pt_gamedate AS bettime,NEW.pt_bet AS betmoney, NEW.pt_bet AS validbet, NEW.pt_win AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,CASE WHEN NEW.pt_gametype = 'Live Games' THEN 'SX' 
                ELSE 'DZ'
	       END AS gamebigtype ,'PTGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = LOWER(NEW.pt_username)
   	       AND gametype = 'PTGame';
		
   REPLACE INTO betting_hq_pt
    SELECT NEW.pt_gamecode AS pt_gamecode,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           NEW.pt_gametype AS pt_gametype,
           NEW.pt_gameid AS pt_gameid,
           NEW.pt_gamename AS pt_gamename,
           NEW.pt_username AS pt_username,
           NEW.pt_windowcode AS pt_windowcode,
           NEW.pt_bet AS pt_bet,
           NEW.pt_win AS pt_win,
           NEW.pt_balance AS pt_balance,
           NEW.pt_gamedate AS pt_gamedate,
           NEW.pt_info AS pt_info,
           NEW.pt_sessionid AS pt_sessionid,
           NEW.pt_progressivebet AS pt_progressivebet,
           NEW.pt_progressivewin AS pt_progressivewin,
           NEW.pt_currentbet AS pt_currentbet,
           NEW.pt_livenetwork AS pt_livenetwork,
           NEW.pt_rnum AS pt_rnum,
           NEW.pt_createtime AS pt_createtime,
           CURRENT_TIMESTAMP AS Last_Time,
           employeecode AS employeecode,
           loginaccount AS loginaccount,
           parentemployeecode AS parentemployeecode,
           CASE WHEN NEW.pt_gametype = 'Live Games' THEN 'SX'
                ELSE 'DZ'
	       END AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = LOWER(NEW.pt_username)
   AND gametype = 'PTGame';
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_pt_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_pt_gameinfo_after_delete` AFTER DELETE ON `api_pt_gameinfo` FOR EACH ROW BEGIN
   DELETE FROM betting_hq_pt WHERE pt_gamecode = OLD.pt_gamecode;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'PT' AND platformid = OLD.pt_gamecode;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_qp_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_qp_gameinfo_after_insert` AFTER INSERT ON `api_qp_gameinfo` FOR EACH ROW BEGIN
   
   
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'QP' platformtype, NEW.TurnNumber AS platformid, employeecode, str_to_date(NEW.StartTime,'%Y-%m-%d %k:%i:%s') AS bettime, NEW.TurnScore AS betmoney, NEW.TurnScore AS validbet, NEW.Revenue AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,'QP' AS gamebigtype ,'QPGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.Account
   	       AND gametype = 'QPGame';
		
   REPLACE INTO betting_qp
    SELECT NEW.TurnNumber AS Turn_Number,
           NEW.ServerID AS Server_ID,
           NEW.KindID AS Kind_ID,
           NEW.RoomName AS Room_Name,
           NEW.StartTime AS Start_Time,
           NEW.EndTime AS End_Time,
           NEW.Score AS Score,
           NEW.TurnScore AS Turn_Score,
           NEW.Account AS Account,
           NEW.createtime AS createtime,
           NEW.Platformflag AS Platformflag,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,
           'QP' AS gamebigtype,
           0 AS status,
           str_to_date(NEW.StartTime,'%Y-%m-%d %k:%i:%s') AS bettime,
           NEW.Revenue AS netmoney,
           NEW.TurnScore AS betmoney,
           NEW.Revenue AS Revenue
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.Account
      AND gametype = 'QPGame';
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_qp_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_qp_gameinfo_after_delete` AFTER DELETE ON `api_qp_gameinfo` FOR EACH ROW BEGIN
   DELETE FROM betting_qp WHERE Turn_Number = OLD.TurnNumber;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'QP' AND platformid = OLD.TurnNumber;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_qt_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_qt_gameinfo_after_insert` AFTER INSERT ON `api_qt_gameinfo` FOR EACH ROW BEGIN


   	       
        REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'QT' platformtype, NEW.id AS platformid, employeecode, NEW.bettime AS bettime,NEW.betmoney AS betmoney, NEW.betmoney AS validbet, NEW.netmoney AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype ,'QTGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.playerid
   	       AND gametype = 'QTGame';
		
   REPLACE INTO betting_qt
    SELECT NEW.id AS id,      
         
           NEW.playergameroundid AS playergameroundid,
           NEW.gameid AS gameid,
           NEW.amount AS amount,
           NEW.balance AS balance,
           NEW.created AS created,
           NEW.gameprovider AS gameprovider,
           NEW.gtype AS gtype,
           NEW.gameclienttype AS gameclienttype,
           NEW.gamecategory AS gamecategory,
           NEW.currency AS currency,
           NEW.playerdevice AS playerdevice,           
           NEW.operatorid AS operatorid,
           NEW.playerid AS playerid,           
           NEW.wallettransactionid AS wallettransactionid,
           NEW.roundstatus AS roundstatus,
                    
           
           NEW.createtime AS createtime,
           NEW.bettime AS bettime,
           NEW.betmoney AS betmoney,
           NEW.netmoney AS netmoney,
           
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,
           
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,
           'DZ' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.playerid
   AND gametype = 'QTGame';
   
   
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_qt_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_qt_gameinfo_after_delete` AFTER DELETE ON `api_qt_gameinfo` FOR EACH ROW BEGIN

        DELETE FROM betting_qt WHERE id = OLD.id;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'QT' AND platformid = OLD.id;
        
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_qwp_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_qwp_gameinfo_after_insert` AFTER INSERT ON `api_qwp_gameinfo` FOR EACH ROW BEGIN

	
	REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
    SELECT 'QWP' AS platformtype,NEW.TurnNumber AS platformid,employeecode,NEW.StartTime AS bettime,NEW.TurnScore AS betmoney,NEW.TurnScore AS validbet,NEW.Score AS netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,'QP' AS gamebigtype,'QWPGame' AS gametype
	FROM employee_api_accout
  WHERE gameaccount = NEW.Account
	AND gametype = 'QWPGame';
	
	REPLACE INTO betting_qwp
	SELECT NEW.TurnNumber AS TurnNumber,
				 NEW.ServerId AS ServerId,
				 NEW.KindId AS KindId,
				 NEW.RoomName AS RoomName,
				 NEW.StartTime AS StartTime,
				 NEW.EndTime AS EndTime,
				 NEW.RecordTime AS RecordTime,
				 NEW.CardData AS CardData,
				 NEW.Account AS Account,
				 NEW.Score AS Score,
				 NEW.TurnScore AS TurnScore,
				 NEW.Revenue AS Revenue,
	
				 enterprisecode AS enterprisecode,
				 brandcode AS brandcode,   
				 employeecode AS employeecode,
				 parentemployeecode AS parentemployeecode,
				 loginaccount AS loginaccount,
				 'QP' AS gamebigtype,
				 0 AS status
	FROM employee_api_accout
	WHERE gameaccount = NEW.Account
	AND gametype = 'QWPGame';		

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_qwp_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_qwp_gameinfo_after_delete` AFTER DELETE ON `api_qwp_gameinfo` FOR EACH ROW BEGIN

DELETE FROM betting_qwp WHERE TurnNumber = OLD.TurnNumber;
DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'QWP' AND platformid = OLD.TurnNumber;
   
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_sa_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_sa_gameinfo_after_insert` AFTER INSERT ON `api_sa_gameinfo` FOR EACH ROW BEGIN
   
   
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'SA' platformtype, NEW.BetID AS platformid, employeecode, NEW.BetTime AS bettime, NEW.BetAmount AS betmoney, NEW.validbet AS validbet, NEW.ResultAmount AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,CASE NEW.GameType WHEN 'bac' THEN 'SX'
                             WHEN 'dtx' THEN 'SX'
                             WHEN 'sicbo' THEN 'SX'
                             WHEN 'ftan' THEN 'SX'
                             WHEN 'rot' THEN 'SX'
                             WHEN 'lottery' THEN 'CP'
                           ELSE  'DZ'
           END AS gamebigtype ,'SAGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.Username
   	       AND gametype = 'SAGame';
		
   REPLACE INTO betting_sa
    SELECT NEW.BetID AS betid,
           enterprisecode,
           brandcode,
           employeecode,
           parentemployeecode,
           loginaccount,
           CASE NEW.GameType WHEN 'bac' THEN 'SX'
                             WHEN 'dtx' THEN 'SX'
                             WHEN 'sicbo' THEN 'SX'
                             WHEN 'ftan' THEN 'SX'
                             WHEN 'rot' THEN 'SX'
                             WHEN 'lottery' THEN 'CP'
                           ELSE  'DZ'
           END AS gamebigtype,
           NEW.BetTime AS bettime,
           NEW.PayoutTime AS payouttime,
           NEW.Username AS username,
           NEW.HostID AS hostid,
           NEW.GameID AS gameid,
           NEW.Round AS round,
           NEW.Sets AS sets,
           NEW.BetAmount AS betamount,
           NEW.ResultAmount AS resultamount,
           NEW.GameType AS gametype,
           NEW.BetType AS bettype,
           NEW.BetSource AS betsource,
           NEW.State AS state,
           NEW.Detail AS detail,
           NEW.createtime AS createtime,
           0 AS status,
           NEW.validbet AS validbet
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.Username
   AND gametype = 'SAGame';
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_sa_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_sa_gameinfo_after_delete` AFTER DELETE ON `api_sa_gameinfo` FOR EACH ROW BEGIN
   DELETE FROM betting_sa WHERE betid = OLD.BetID;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'SA' AND platformid = OLD.BetID;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_sgs_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_sgs_gameinfo_after_insert` AFTER INSERT ON `api_sgs_gameinfo` FOR EACH ROW BEGIN

   
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'SGS' platformtype, NEW.ugsbetid AS platformid, employeecode, NEW.bettime AS bettime,NEW.betmoney AS betmoney, NEW.validmoney AS validbet, NEW.netmoney AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,CASE WHEN NEW.gameprovider = 'Sunbet' THEN 'SX'
                ELSE 'DZ'
	       END AS gamebigtype ,'SGSGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.userid
   	       AND gametype = 'SGSGame';
		
   REPLACE INTO betting_sgs
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
           
           CASE WHEN NEW.gameprovider = 'Sunbet' THEN 'SX'
                ELSE 'DZ'
	       END AS gamebigtype,
           0 AS status,
           NEW.validmoney AS validmoney
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.userid
   AND gametype = 'SGSGame';
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_sgs_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_sgs_gameinfo_after_delete` AFTER DELETE ON `api_sgs_gameinfo` FOR EACH ROW BEGIN

DELETE FROM betting_sgs WHERE ugsbetid = OLD.ugsbetid;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'SGS' AND platformid = OLD.ugsbetid;


END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_tag_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_tag_gameinfo_after_insert` AFTER INSERT ON `api_tag_gameinfo` FOR EACH ROW BEGIN
   
   IF NEW.platformType = 'PNG' THEN
   
      REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
            SELECT 'PNG' AS platformtype, NEW.billNo AS platformid,employeecode, NEW.betTime AS bettime, NEW.betAmount AS betmoney, NEW.validBetAmount AS validbet, NEW.netAmount AS netmoney
            ,enterprisecode,brandcode,loginaccount,parentemployeecode,ufn_get_gamebigtype_from_tag  (NEW.platformType, NEW.gameType) AS gamebigtype ,'PNGGame' AS gametype
      	      FROM employee_api_accout
      	     WHERE gameaccount = NEW.playerName
      	       AND gametype = 'PNGGame';
			
      REPLACE INTO betting_hq_png
       SELECT NEW.billNo AS bill_No,
              brandcode AS brandcode,
              enterprisecode AS enterprisecode,
              employeecode AS employeecode,
              parentemployeecode AS parentemployeecode,
              loginaccount AS loginaccount,
              ufn_get_gamebigtype_from_tag  (NEW.platformType, NEW.gameType) AS gamebigtype,
              NEW.playerName AS player_Name,
              NEW.agentCode AS agent_Code,
              NEW.gameCode AS game_Code,
              NEW.netAmount AS net_Amount,
              NEW.betTime AS bet_Time,
              NEW.gameType AS game_Type,
              NEW.betAmount AS bet_Amount,
              NEW.validBetAmount AS valid_Bet_Amount,
              NEW.flag AS flag,
              NEW.playType AS play_Type,
              NEW.currency AS currency,
              NEW.tableCode AS table_Code,
              NEW.loginIP AS login_IP,
              NEW.recalcuTime AS recalcu_Time,
              NEW.platformId AS platform_Id,
              NEW.platformType AS platform_Type,
              NEW.remark AS remark,
              NEW.round AS round,
              NEW.stringex AS stringex,
              NEW.createtime AS createtime,
              NEW.result AS result,
              NEW.beforeCredit AS before_Credit,
              NEW.deviceType AS device_Type,
              CURRENT_TIMESTAMP AS Last_Time,
              0 AS status
      	 FROM employee_api_accout
       WHERE gameaccount = NEW.playerName
      AND gametype = 'PNGGame';
   ELSE
   
      REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype, gametype)
            SELECT 'TAG' AS platformtype, NEW.billNo AS platformid,employeecode ,NEW.betTime AS bettime, NEW.betAmount AS betmoney, NEW.validBetAmount AS validbet, NEW.netAmount AS netmoney
            ,enterprisecode,brandcode,loginaccount,parentemployeecode,ufn_get_gamebigtype_from_tag  (NEW.platformType, NEW.gameType) AS gamebigtype ,'TAGGame' AS gametype
      	      FROM employee_api_accout
      	     WHERE gameaccount = NEW.playerName
      	       AND gametype = 'TAGGame';
			   
      REPLACE INTO betting_hq_ag
       SELECT NEW.billNo AS bill_No,
              brandcode AS brandcode,
              enterprisecode AS enterprisecode,
              employeecode AS employeecode,
              parentemployeecode AS parentemployeecode,
              loginaccount AS loginaccount,
              ufn_get_gamebigtype_from_tag  (NEW.platformType, NEW.gameType) AS gamebigtype,
              NEW.playerName AS player_Name,
              NEW.agentCode AS agent_Code,
              NEW.gameCode AS game_Code,
              NEW.netAmount AS net_Amount,
              NEW.betTime AS bet_Time,
              NEW.gameType AS game_Type,
              NEW.betAmount AS bet_Amount,
              NEW.validBetAmount AS valid_Bet_Amount,
              NEW.flag AS flag,
              NEW.playType AS play_Type,
              NEW.currency AS currency,
              NEW.tableCode AS table_Code,
              NEW.loginIP AS login_IP,
              NEW.recalcuTime AS recalcu_Time,
              NEW.platformId AS platform_Id,
              NEW.platformType AS platform_Type,
              NEW.remark AS remark,
              NEW.round AS round,
              NEW.stringex AS stringex,
              NEW.createtime AS createtime,
              NEW.result AS result,
              NEW.beforeCredit AS before_Credit,
              NEW.deviceType AS device_Type,
              CURRENT_TIMESTAMP AS Last_Time,
              0 AS status
      	 FROM employee_api_accout
       WHERE gameaccount = NEW.playerName
      AND gametype = 'TAGGame';
   END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_tag_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_tag_gameinfo_after_delete` AFTER DELETE ON `api_tag_gameinfo` FOR EACH ROW BEGIN
   IF OLD.platformType = 'PNG' THEN
      DELETE FROM betting_hq_png WHERE bill_No = OLD.billNo;
      DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'PNG' AND platformid = OLD.billNo;
   ELSE
      DELETE FROM betting_hq_ag WHERE bill_No = OLD.billNo;
      DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'TAG' AND platformid = OLD.billNo;
   END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_tgp_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_tgp_gameinfo_after_insert` AFTER INSERT ON `api_tgp_gameinfo` FOR EACH ROW BEGIN


        
        REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney,enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'TGP' platformtype, NEW.ugsbetid AS platformid, employeecode, NEW.bettime AS bettime,NEW.betmoney AS betmoney, NEW.validmoney AS validbet, NEW.netmoney AS netmoney,
         enterprisecode,brandcode,loginaccount,parentemployeecode,CASE WHEN NEW.gameprovider = 'Sunbet' THEN 'SX'
                ELSE 'DZ'
	       END AS gamebigtype ,'TGPGame' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = LOWER(NEW.userid)
   	       AND gametype = 'TGPGame';
		
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
           
           CASE WHEN NEW.gameprovider = 'Sunbet' THEN 'SX'
                ELSE 'DZ'
	       END AS gamebigtype,
           0 AS status,
           NEW.validmoney AS validmoney
   	 FROM employee_api_accout
    WHERE gameaccount = LOWER(NEW.userid)
   AND gametype = 'TGPGame';
        
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_tgp_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_tgp_gameinfo_after_delete` AFTER DELETE ON `api_tgp_gameinfo` FOR EACH ROW BEGIN

        DELETE FROM betting_tgp WHERE ugsbetid = OLD.ugsbetid;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'TGP' AND platformid = OLD.ugsbetid;
        
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_ttg_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_ttg_gameinfo_after_insert` AFTER INSERT ON `api_ttg_gameinfo` FOR EACH ROW BEGIN
   DECLARE l_transactionId BIGINT;
       SET l_transactionId = IFNULL(ufn_min_transactionId_from_api_ttg_gameinfo(NEW.handId),NEW.transactionId);
		  
   
   IF NEW.transactionSubType = 'Wager' THEN
   
      IF EXISTS (SELECT 1 FROM betting_all_game_winlose_detail WHERE platformtype = 'TTG' AND platformid = l_transactionId) THEN
         UPDATE betting_all_game_winlose_detail
            SET betmoney = -NEW.amount, 
		   	    validbet = -NEW.amount, 
		   	    netmoney = IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Resolve'),0)+NEW.amount
          WHERE platformtype = 'TTG' AND platformid = l_transactionId;
	  ELSE
         INSERT INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
              SELECT 'TTG' AS platformtype, 
		   	         IFNULL(ufn_min_transactionId_from_api_ttg_gameinfo(NEW.handId),NEW.transactionId) AS platformid,
			         employeecode,
		   	         INSERT(INSERT(NEW.transactionDate,7,0,'-'),5,0,'-') AS bettime, 
		   	         -NEW.amount AS betmoney, 
		   	         -NEW.amount AS validbet, 
		   	         IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Resolve'),0)+NEW.amount AS netmoney
		   	         ,enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype ,'TTGGame' AS gametype
         	     FROM employee_api_accout
         	    WHERE gameaccount = NEW.playerId
         	      AND gametype = 'TTGGame';
	  END IF;
	  
      REPLACE INTO betting_ttg
      SELECT IFNULL(ufn_min_transactionId_from_api_ttg_gameinfo(NEW.handId),NEW.transactionId) AS transaction_Id,
             NEW.requestId AS request_Id,
             NEW.partnerId AS partner_Id,
             NEW.playerId AS player_Id,
             -NEW.amount AS amount,
             NEW.handId AS hand_Id,
             NEW.transactionType AS transaction_Type,
             NEW.transactionSubType AS transaction_Sub_Type,
             NEW.currency AS currency,
             NEW.game AS game,
             NEW.transactionDate AS transaction_Date,
             NEW.createtime AS createtime,
             NEW.Platformflag AS Platformflag,
             enterprisecode AS enterprisecode,
             brandcode AS brandcode,
             employeecode AS employeecode,
             parentemployeecode AS parentemployeecode,
             loginaccount AS loginaccount,
             'DZ' AS gamebigtype,
             0 AS status,
             INSERT(INSERT(NEW.transactionDate,7,0,'-'),5,0,'-') AS bettime,
             IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Resolve'),0)+NEW.amount AS net_Money, 
             INSERT(INSERT(NEW.transactionDate,7,0,'-'),5,0,'-') AS resolvetime
        FROM employee_api_accout 
	   WHERE gameaccount = NEW.playerId
		 AND gametype = 'TTGGame';
   ELSE
   
      IF EXISTS (SELECT 1 FROM betting_all_game_winlose_detail WHERE platformtype = 'TTG' AND platformid = l_transactionId) THEN
         UPDATE betting_all_game_winlose_detail
            SET betmoney = -IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Wager'),0), 
		   	    validbet = -IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Wager'),0), 
		   	    netmoney = IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Wager'),0)+NEW.amount
          WHERE platformtype = 'TTG' AND platformid = l_transactionId;
	  ELSE
         INSERT INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
              SELECT 'TTG' AS platformtype, 
		   	         IFNULL(ufn_min_transactionId_from_api_ttg_gameinfo(NEW.handId),NEW.transactionId) AS platformid,
			         employeecode,
		   	         INSERT(INSERT(NEW.transactionDate,7,0,'-'),5,0,'-') AS bettime, 
		   	         -IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Wager'),0) AS betmoney, 
		   	         -IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Wager'),0) AS validbet, 
		   	         IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Wager'),0)+NEW.amount AS netmoney
		   	         ,enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype ,'TTGGame' AS gametype
         	     FROM employee_api_accout
         	    WHERE gameaccount = NEW.playerId
         	      AND gametype = 'TTGGame';
	  END IF;
	  
      REPLACE INTO betting_ttg
      SELECT IFNULL(ufn_min_transactionId_from_api_ttg_gameinfo(NEW.handId),NEW.transactionId) AS transaction_Id,
             NEW.requestId AS request_Id,
             NEW.partnerId AS partner_Id,
             NEW.playerId AS player_Id,
             -IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Wager'),0) AS amount,
             NEW.handId AS hand_Id,
             NEW.transactionType AS transaction_Type,
             NEW.transactionSubType AS transaction_Sub_Type,
             NEW.currency AS currency,
             NEW.game AS game,
             NEW.transactionDate AS transaction_Date,
             NEW.createtime AS createtime,
             NEW.Platformflag AS Platformflag,
             enterprisecode AS enterprisecode,
             brandcode AS brandcode,
             employeecode AS employeecode,
             parentemployeecode AS parentemployeecode,
             loginaccount AS loginaccount,
             'DZ' AS gamebigtype,
             0 AS status,
             INSERT(INSERT(NEW.transactionDate,7,0,'-'),5,0,'-') AS bettime,
             IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Wager'),0) + NEW.amount AS net_Money, 
             INSERT(INSERT(NEW.transactionDate,7,0,'-'),5,0,'-') AS resolvetime
        FROM employee_api_accout 
	   WHERE gameaccount = NEW.playerId
		 AND gametype = 'TTGGame';
	END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_ttg_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_ttg_gameinfo_after_delete` AFTER DELETE ON `api_ttg_gameinfo` FOR EACH ROW BEGIN
   DELETE FROM betting_ttg WHERE transaction_Id = OLD.transactionId;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'TTG' AND platformid = OLD.transactionId;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_win88_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_win88_gameinfo_after_insert` AFTER INSERT ON `api_win88_gameinfo` FOR EACH ROW BEGIN

   	       
        REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'W88' platformtype, NEW.pt_gamecode AS platformid, employeecode, NEW.pt_gamedate AS bettime,NEW.pt_bet AS betmoney, NEW.pt_bet AS validbet, NEW.pt_win AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,CASE WHEN NEW.pt_gametype = 'Live Games' THEN 'SX'
                ELSE 'DZ'
	       END AS gamebigtype ,'W88Game' AS gametype
   	      FROM employee_api_accout
   	     WHERE gameaccount = LOWER(NEW.pt_username)
   	       AND gametype = 'W88Game';
		
   REPLACE INTO betting_win88
    SELECT NEW.pt_gamecode AS pt_gamecode,           
           NEW.pt_username AS pt_username,
           NEW.pt_windowcode AS pt_windowcode,           
           NEW.pt_gameid AS pt_gameid,
           NEW.pt_gametype AS pt_gametype,
           NEW.pt_gamename AS pt_gamename,         
           NEW.pt_bet AS pt_bet,
           NEW.pt_win AS pt_win,
           NEW.pt_balance AS pt_balance,
           NEW.pt_gamedate AS pt_gamedate,
           NEW.pt_info AS pt_info,
           NEW.pt_sessionid AS pt_sessionid,
           NEW.pt_progressivebet AS pt_progressivebet,
           NEW.pt_progressivewin AS pt_progressivewin,
           NEW.pt_currentbet AS pt_currentbet,
           NEW.pt_livenetwork AS pt_livenetwork,
           NEW.pt_rnum AS pt_rnum,
           NEW.pt_createtime AS pt_createtime,
           NEW.Platformflag AS Platformflag,
           
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           employeecode AS employeecode,
           parentemployeecode AS parentemployeecode,
           loginaccount AS loginaccount,           
           CASE WHEN NEW.pt_gametype = 'Live Games' THEN 'SX'
                ELSE 'DZ'
	       END AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = LOWER(NEW.pt_username)
   AND gametype = 'W88Game';
   
   
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_win88_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_win88_gameinfo_after_delete` AFTER DELETE ON `api_win88_gameinfo` FOR EACH ROW BEGIN

        DELETE FROM betting_win88 WHERE pt_gamecode = OLD.pt_gamecode;
        DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'W88' AND platformid = OLD.pt_gamecode;
        
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_xcp_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_xcp_gameinfo_after_insert` AFTER INSERT ON `api_xcp_gameinfo` FOR EACH ROW BEGIN
   
   
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype)
         SELECT 'CP' platformtype, NEW.xcp_projectid AS platformid, employeecode, NEW.xcp_writetime AS bettime, NEW.xcp_totalprice AS betmoney, NEW.xcp_totalprice AS validbet, NEW.xcp_prize-NEW.xcp_totalprice AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,'CP' AS gamebigtype
   	      FROM employee_api_accout
   	     WHERE gameaccount = NEW.xcp_username
   	       AND gametype = 'XCPGame';
		
   REPLACE INTO betting_hq_xcp
    SELECT NEW.xcp_projectid AS xcp_projectid,
           enterprisecode AS enterprisecode,
           brandcode AS brandcode,
           NEW.xcp_bonus AS xcp_bonus,
           NEW.xcp_prize AS xcp_prize,
           NEW.xcp_writetime AS xcp_writetime,
           NEW.xcp_username AS xcp_username,
           NEW.xcp_code AS xcp_code,
           NEW.xcp_totalprice AS xcp_totalprice,
           NEW.xcp_isgetprize AS xcp_isgetprize,
           NEW.xcp_updatetime AS xcp_updatetime,
           NEW.xcp_lotteryid AS xcp_lotteryid,
           NEW.xcp_issue AS xcp_issue,
           NEW.xcp_codetimes AS xcp_codetimes,
           NEW.xcp_createtime AS xcp_createtime,
           CURRENT_TIMESTAMP AS Last_Time,
           employeecode AS employeecode,
           loginaccount AS loginaccount,
           parentemployeecode AS parentemployeecode,
           'CP' AS gamebigtype,
           0 AS status
   	 FROM employee_api_accout
    WHERE gameaccount = NEW.xcp_username
      AND gametype = 'XCPGame';
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_xcp_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_xcp_gameinfo_after_delete` AFTER DELETE ON `api_xcp_gameinfo` FOR EACH ROW BEGIN
   DELETE FROM betting_hq_xcp WHERE xcp_projectid = OLD.xcp_projectid;
   DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'CP' AND platformid = OLD.xcp_projectid;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_yoplay_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_yoplay_gameinfo_after_insert` AFTER INSERT ON `api_yoplay_gameinfo` FOR EACH ROW BEGIN

     
      REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
            SELECT 'YoPLAY' AS platformtype, NEW.billNo AS platformid,employeecode ,NEW.betTime AS bettime, NEW.betmoney AS betmoney, NEW.validmoney AS validbet, NEW.netmoney AS netmoney
            ,enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype,'YoPLAYGame' AS gametype
      	      FROM employee_api_accout
      	     WHERE gameaccount = NEW.playerName
      	       AND gametype = 'YoPLAYGame';   
      
      REPLACE INTO betting_yoplay
       SELECT NEW.billNo AS bill_No,              
              NEW.playerName AS player_Name,
              NEW.agentCode AS agent_Code,
              NEW.gameCode AS game_Code,
              NEW.netAmount AS net_Amount,
              NEW.betTime AS bet_Time,
              NEW.gameType AS game_Type,
              NEW.betAmount AS bet_Amount,
              NEW.validBetAmount AS valid_Bet_Amount,
              NEW.flag AS flag,
              NEW.playType AS play_Type,
              NEW.currency AS currency,
              NEW.tableCode AS table_Code,
              NEW.loginIP AS login_IP,
              NEW.recalcuTime AS recalcu_Time,
              NEW.platformType AS platform_Type,
              NEW.remark AS remark,
              NEW.round AS round,
              NEW.slottype AS slottype,
              NEW.result AS result,
              NEW.mainbillno AS mainbillno,
              NEW.beforeCredit AS before_Credit,
              NEW.deviceType AS device_Type,              
              NEW.betAmountBase AS bet_Amount_Base,
              NEW.betAmountBonus AS bet_Amount_Bonus,
              NEW.netAmountBase AS net_Amount_Base,
              NEW.netAmountBonus AS net_Amount_Bonus,
              
              NEW.createtime AS createtime,
              NEW.betmoney AS betmoney,
              NEW.netmoney AS netmoney,
              NEW.validmoney AS validmoney,
              
              enterprisecode AS enterprisecode,
              brandcode AS brandcode,
              employeecode AS employeecode,
              parentemployeecode AS parentemployeecode,
              loginaccount AS loginaccount,
              'DZ' AS gamebigtype,
              0 AS status
      	 FROM employee_api_accout
       WHERE gameaccount = NEW.playerName
      AND gametype = 'YoPLAYGame';  
        
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_yoplay_gameinfo_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_api_yoplay_gameinfo_after_delete` AFTER DELETE ON `api_yoplay_gameinfo` FOR EACH ROW BEGIN

DELETE FROM betting_all_game_winlose_detail WHERE platformtype = 'YoPLAY' AND platformid = OLD.billNo;

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_employee_all_uplevels_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_employee_all_uplevels_after_insert` AFTER INSERT ON `enterprise_employee` FOR EACH ROW BEGIN
   REPLACE INTO enterprise_employee_all_uplevels VALUES (NEW.employeecode, NEW.parentemployeecode, NEW.employeetypecode, ufn_get_employee_all_uplevels(NEW.employeecode), NEW.brandcode, NEW.loginaccount);
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_employee_all_uplevels_after_delete`;
DELIMITER ;;
CREATE TRIGGER `trg_employee_all_uplevels_after_delete` AFTER DELETE ON `enterprise_employee` FOR EACH ROW BEGIN
   DELETE FROM enterprise_employee_all_uplevels WHERE employeecode = OLD.employeecode;
END
;;
DELIMITER ;
