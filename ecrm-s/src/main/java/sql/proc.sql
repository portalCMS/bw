DROP PROCEDURE IF EXISTS `dhp_tn_betrecord_rinse_bbin`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `dhp_tn_betrecord_rinse_bbin`(IN in_begintime datetime,IN in_endtime datetime)
BEGIN
  DECLARE done boolean DEFAULT FALSE;

  DECLARE limit_start int DEFAULT 0;

  DECLARE limit_pagesize int DEFAULT 0;

  DECLARE e_employeecode CHAR(8);
  
  DECLARE u_record longtext;  

  DECLARE e_em CURSOR FOR SELECT employeecode FROM enterprise_employee WHERE employeetypecode='T003';

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = true;

  SELECT COUNT(1) INTO @employeecount FROM enterprise_employee WHERE employeetypecode='T003';

  SELECT COUNT(1) INTO @recordcount FROM betting_hq_bbin bhn WHERE bhn.bbin_Wagers_Date BETWEEN in_begintime AND in_endtime;

  SET limit_pagesize = floor(@recordcount/@employeecount);

  IF limit_pagesize >0 THEN 
    OPEN e_em;
  
      REPEAT
        FETCH e_em INTO e_employeecode;
        SELECT GROUP_CONCAT(temp.bbin_Wagers_Id) INTO u_record FROM (SELECT bhn.bbin_Wagers_Id  FROM betting_hq_bbin bhn WHERE bhn.bbin_Wagers_Date BETWEEN in_begintime AND in_endtime LIMIT limit_start,limit_pagesize) AS temp;
        -- SELECT COUNT(1) INTO @u_count FROM betting_hq_nhq WHERE FIND_IN_SET( Betting_ID,u_record)>0;
        UPDATE betting_hq_bbin set employeecode = e_employeecode WHERE FIND_IN_SET(bbin_Wagers_Id,u_record)>0;
        set limit_start = limit_start+limit_pagesize;
      until done end REPEAT;       
  
    CLOSE e_em;
  
    UPDATE betting_hq_bbin bhn LEFT JOIN enterprise_employee ee ON bhn.employeecode = ee.employeecode 
    SET bhn.enterprisecode=ee.enterprisecode , bhn.brandcode=ee.brandcode ,bhn.loginaccount=ee.loginaccount , bhn.parentemployeecode=ee.parentemployeecode;
  END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for dhp_tn_betrecord_rinse_ibc
-- ----------------------------
DROP PROCEDURE IF EXISTS `dhp_tn_betrecord_rinse_ibc`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `dhp_tn_betrecord_rinse_ibc`(IN in_begintime datetime,IN in_endtime datetime)
BEGIN
  DECLARE done boolean DEFAULT FALSE;

  DECLARE limit_start int DEFAULT 0;

  DECLARE limit_pagesize int DEFAULT 0;

  DECLARE e_employeecode CHAR(8);
  
  DECLARE u_record longtext;  

  DECLARE e_em CURSOR FOR SELECT employeecode FROM enterprise_employee WHERE employeetypecode='T003';

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = true;

  SELECT COUNT(1) INTO @employeecount FROM enterprise_employee WHERE employeetypecode='T003';

  SELECT COUNT(1) INTO @recordcount FROM betting_hq_og_ibc bhn WHERE bhn.ibc_updatetime BETWEEN in_begintime AND in_endtime;

  SET limit_pagesize = floor(@recordcount/@employeecount);

  IF limit_pagesize >0 THEN 
    OPEN e_em;
  
      REPEAT
        FETCH e_em INTO e_employeecode;
        SELECT GROUP_CONCAT(temp.ibc_rowguid) INTO u_record FROM (SELECT bhn.ibc_rowguid  FROM betting_hq_og_ibc bhn WHERE bhn.ibc_updatetime BETWEEN in_begintime AND in_endtime LIMIT limit_start,limit_pagesize) AS temp;
        -- SELECT COUNT(1) INTO @u_count FROM betting_hq_nhq WHERE FIND_IN_SET( Betting_ID,u_record)>0;
        UPDATE betting_hq_og_ibc set employeecode = e_employeecode WHERE FIND_IN_SET(ibc_rowguid,u_record)>0;
        set limit_start = limit_start+limit_pagesize;
      until done end REPEAT;       
  
    CLOSE e_em;
  
    UPDATE betting_hq_og_ibc bhn LEFT JOIN enterprise_employee ee ON bhn.employeecode = ee.employeecode 
    SET bhn.enterprisecode=ee.enterprisecode , bhn.brandcode=ee.brandcode ,bhn.loginaccount=ee.loginaccount , bhn.parentemployeecode=ee.parentemployeecode;
 END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for dhp_tn_betrecord_rinse_nhq
-- ----------------------------
DROP PROCEDURE IF EXISTS `dhp_tn_betrecord_rinse_nhq`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `dhp_tn_betrecord_rinse_nhq`(IN in_begintime datetime,IN in_endtime datetime)
BEGIN
  DECLARE done boolean DEFAULT FALSE;

  DECLARE limit_start int DEFAULT 0;

  DECLARE limit_pagesize int DEFAULT 0;

  DECLARE e_employeecode CHAR(8);
  
  DECLARE u_record longtext;  

  DECLARE e_em CURSOR FOR SELECT employeecode FROM enterprise_employee WHERE employeetypecode='T003';

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = true;

  SELECT COUNT(1) INTO @employeecount FROM enterprise_employee WHERE employeetypecode='T003';

  SELECT COUNT(1) INTO @recordcount FROM betting_hq_nhq bhn WHERE bhn.Betting_Date BETWEEN in_begintime AND in_endtime;

  SET limit_pagesize = floor(@recordcount/@employeecount);

  IF limit_pagesize >0 THEN 
    
      OPEN e_em;
    
        REPEAT
          FETCH e_em INTO e_employeecode;
          SELECT GROUP_CONCAT(temp.Betting_ID) INTO u_record FROM (
            SELECT bhn.Betting_ID  FROM betting_hq_nhq bhn WHERE bhn.Betting_Date BETWEEN in_begintime AND in_endtime LIMIT limit_start,limit_pagesize) AS temp;
          -- SELECT COUNT(1) INTO @u_count FROM betting_hq_nhq WHERE FIND_IN_SET( Betting_ID,u_record)>0;
          UPDATE betting_hq_nhq set employeecode = e_employeecode WHERE FIND_IN_SET( Betting_ID,u_record)>0;
          set limit_start = limit_start+limit_pagesize;
        until done end REPEAT;       
    
      CLOSE e_em;

      UPDATE betting_hq_nhq bhn LEFT JOIN enterprise_employee ee ON bhn.employeecode = ee.employeecode 
      SET bhn.enterprisecode=ee.enterprisecode , bhn.brandcode=ee.brandcode ,bhn.loginaccount=ee.loginaccount , bhn.parentemployeecode=ee.parentemployeecode;
  END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for dhp_tn_betrecord_rinse_oag
-- ----------------------------
DROP PROCEDURE IF EXISTS `dhp_tn_betrecord_rinse_oag`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `dhp_tn_betrecord_rinse_oag`(IN in_begintime datetime,IN in_endtime datetime)
BEGIN
  DECLARE done boolean DEFAULT FALSE;

  DECLARE limit_start int DEFAULT 0;

  DECLARE limit_pagesize int DEFAULT 0;

  DECLARE e_employeecode CHAR(8);
  
  DECLARE u_record longtext;  

  DECLARE e_em CURSOR FOR SELECT employeecode FROM enterprise_employee WHERE employeetypecode='T003';

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = true;

  SELECT COUNT(1) INTO @employeecount FROM enterprise_employee WHERE employeetypecode='T003';

  SELECT COUNT(1) INTO @recordcount FROM betting_hq_og_ag bhn WHERE bhn.aoi_Add_Time BETWEEN in_begintime AND in_endtime;

  SET limit_pagesize = floor(@recordcount/@employeecount);

  IF limit_pagesize >0 THEN 
  OPEN e_em;

    REPEAT
      FETCH e_em INTO e_employeecode;
      SELECT GROUP_CONCAT(temp.aoi_Product_Id) INTO u_record FROM (SELECT bhn.aoi_Product_Id  FROM betting_hq_og_ag bhn LIMIT limit_start,limit_pagesize) AS temp;
      -- SELECT COUNT(1) INTO @u_count FROM betting_hq_nhq WHERE FIND_IN_SET( Betting_ID,u_record)>0;
      UPDATE betting_hq_og_ag set employeecode = e_employeecode WHERE FIND_IN_SET(aoi_Product_Id,u_record)>0;
      set limit_start = limit_start+limit_pagesize;
    until done end REPEAT;       

  CLOSE e_em;

  UPDATE betting_hq_og_ag bhn LEFT JOIN enterprise_employee ee ON bhn.employeecode = ee.employeecode 
  SET bhn.enterprisecode=ee.enterprisecode , bhn.brandcode=ee.brandcode ,bhn.loginaccount=ee.loginaccount , bhn.parentemployeecode=ee.parentemployeecode;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for dhp_tn_betrecord_rinse_og
-- ----------------------------
DROP PROCEDURE IF EXISTS `dhp_tn_betrecord_rinse_og`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `dhp_tn_betrecord_rinse_og`(IN in_begintime datetime,IN in_endtime datetime)
BEGIN
  DECLARE done boolean DEFAULT FALSE;

  DECLARE limit_start int DEFAULT 0;

  DECLARE limit_pagesize int DEFAULT 0;

  DECLARE e_employeecode CHAR(8);
  
  DECLARE u_record longtext;  

  DECLARE e_em CURSOR FOR SELECT employeecode FROM enterprise_employee WHERE employeetypecode='T003';

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = true;

  SELECT COUNT(1) INTO @employeecount FROM enterprise_employee WHERE employeetypecode='T003';

  SELECT COUNT(1) INTO @recordcount FROM betting_hq_og_og bhn WHERE bhn.aoi_Add_Time BETWEEN in_begintime AND in_endtime;

  SET limit_pagesize = floor(@recordcount/@employeecount);

  IF limit_pagesize >0 THEN 
    OPEN e_em;
      REPEAT
        FETCH e_em INTO e_employeecode;
        SELECT GROUP_CONCAT(temp.aoi_Product_Id) INTO u_record FROM (SELECT bhn.aoi_Product_Id  FROM betting_hq_og_og bhn WHERE bhn.aoi_Add_Time BETWEEN in_begintime AND in_endtime LIMIT limit_start,limit_pagesize) AS temp;
        -- SELECT COUNT(1) INTO @u_count FROM betting_hq_nhq WHERE FIND_IN_SET( Betting_ID,u_record)>0;
        UPDATE betting_hq_og_og set employeecode = e_employeecode WHERE FIND_IN_SET(aoi_Product_Id,u_record)>0;
        set limit_start = limit_start+limit_pagesize;
      until done end REPEAT;       
  
    CLOSE e_em;
  
    UPDATE betting_hq_og_og bhn LEFT JOIN enterprise_employee ee ON bhn.employeecode = ee.employeecode 
    SET bhn.enterprisecode=ee.enterprisecode , bhn.brandcode=ee.brandcode ,bhn.loginaccount=ee.loginaccount , bhn.parentemployeecode=ee.parentemployeecode;
  END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for dhp_tn_betrecord_rinse_pt
-- ----------------------------
DROP PROCEDURE IF EXISTS `dhp_tn_betrecord_rinse_pt`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `dhp_tn_betrecord_rinse_pt`(IN in_begintime datetime,IN in_endtime datetime)
BEGIN
  DECLARE done boolean DEFAULT FALSE;

  DECLARE limit_start int DEFAULT 0;

  DECLARE limit_pagesize int DEFAULT 0;

  DECLARE e_employeecode CHAR(8);
  
  DECLARE u_record longtext;  

  DECLARE e_em CURSOR FOR SELECT employeecode FROM enterprise_employee WHERE employeetypecode='T003';

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = true;

  SELECT COUNT(1) INTO @employeecount FROM enterprise_employee WHERE employeetypecode='T003';

  SELECT COUNT(1) INTO @recordcount FROM betting_hq_pt as bhn WHERE bhn.pt_gamedate BETWEEN in_begintime AND in_endtime;

  SET limit_pagesize = floor(@recordcount/@employeecount);

  IF limit_pagesize >0 THEN 
    OPEN e_em;
  
      REPEAT
        FETCH e_em INTO e_employeecode;
        SELECT GROUP_CONCAT(temp.pt_gamecode) INTO u_record FROM (SELECT bhn.pt_gamecode  FROM betting_hq_pt bhn WHERE bhn.pt_gamedate BETWEEN in_begintime AND in_endtime LIMIT limit_start,limit_pagesize) AS temp;
        -- SELECT COUNT(1) INTO @u_count FROM betting_hq_nhq WHERE FIND_IN_SET( Betting_ID,u_record)>0;
        UPDATE betting_hq_pt set employeecode = e_employeecode WHERE FIND_IN_SET(pt_gamecode,u_record)>0;
        set limit_start = limit_start+limit_pagesize;
      until done end REPEAT;       
  
    CLOSE e_em;
  
    UPDATE betting_hq_pt bhn LEFT JOIN enterprise_employee ee ON bhn.employeecode = ee.employeecode 
    SET bhn.enterprisecode=ee.enterprisecode , bhn.brandcode=ee.brandcode ,bhn.loginaccount=ee.loginaccount , bhn.parentemployeecode=ee.parentemployeecode;
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for dhp_tn_betrecord_rinse_tag
-- ----------------------------
DROP PROCEDURE IF EXISTS `dhp_tn_betrecord_rinse_tag`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `dhp_tn_betrecord_rinse_tag`(IN in_begintime datetime,IN in_endtime datetime)
BEGIN
  DECLARE done boolean DEFAULT FALSE;

  DECLARE limit_start int DEFAULT 0;

  DECLARE limit_pagesize int DEFAULT 0;

  DECLARE e_employeecode CHAR(8);
  
  DECLARE u_record longtext;  

  DECLARE e_em CURSOR FOR SELECT employeecode FROM enterprise_employee WHERE employeetypecode='T003';

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = true;

  SELECT COUNT(1) INTO @employeecount FROM enterprise_employee WHERE employeetypecode='T003';

  SELECT COUNT(1) INTO @recordcount FROM betting_hq_ag bhn WHERE bhn.bet_Time BETWEEN in_begintime AND in_endtime;

  SET limit_pagesize = floor(@recordcount/@employeecount);

  IF limit_pagesize >0 THEN 
  OPEN e_em;

    REPEAT
      FETCH e_em INTO e_employeecode;
      SELECT GROUP_CONCAT(temp.bill_No) INTO u_record FROM (SELECT bhn.bill_No  FROM betting_hq_ag bhn WHERE bhn.bet_Time BETWEEN in_begintime AND in_endtime LIMIT limit_start,limit_pagesize) AS temp;
      -- SELECT COUNT(1) INTO @u_count FROM betting_hq_nhq WHERE FIND_IN_SET( Betting_ID,u_record)>0;
      UPDATE betting_hq_ag set employeecode = e_employeecode WHERE FIND_IN_SET(bill_No,u_record)>0;
      set limit_start = limit_start+limit_pagesize;
    until done end REPEAT;       

  CLOSE e_em;

  UPDATE betting_hq_ag bhn LEFT JOIN enterprise_employee ee ON bhn.employeecode = ee.employeecode 
  SET bhn.enterprisecode=ee.enterprisecode , bhn.brandcode=ee.brandcode ,bhn.loginaccount=ee.loginaccount , bhn.parentemployeecode=ee.parentemployeecode;
  END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for dhp_tn_betrecord_rinse_xcp
-- ----------------------------
DROP PROCEDURE IF EXISTS `dhp_tn_betrecord_rinse_xcp`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `dhp_tn_betrecord_rinse_xcp`(IN in_begintime datetime,IN in_endtime datetime)
BEGIN
  DECLARE done boolean DEFAULT FALSE;

  DECLARE limit_start int DEFAULT 0;

  DECLARE limit_pagesize int DEFAULT 0;

  DECLARE e_employeecode CHAR(8);
  
  DECLARE u_record longtext;  

  DECLARE e_em CURSOR FOR SELECT employeecode FROM enterprise_employee WHERE employeetypecode='T003';

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = true;

  SELECT COUNT(1) INTO @employeecount FROM enterprise_employee WHERE employeetypecode='T003';

  SELECT COUNT(1) INTO @recordcount FROM betting_hq_xcp bhn WHERE bhn.xcp_writetime BETWEEN in_begintime AND in_endtime;

  SET limit_pagesize = floor(@recordcount/@employeecount);
  IF limit_pagesize >0 THEN 
  OPEN e_em;

    REPEAT
      FETCH e_em INTO e_employeecode;
      SELECT GROUP_CONCAT(temp.xcp_projectid) INTO u_record FROM (SELECT bhn.xcp_projectid  FROM betting_hq_xcp bhn WHERE bhn.xcp_writetime BETWEEN in_begintime AND in_endtime LIMIT limit_start,limit_pagesize) AS temp;
      -- SELECT COUNT(1) INTO @u_count FROM betting_hq_nhq WHERE FIND_IN_SET( Betting_ID,u_record)>0;
      UPDATE betting_hq_xcp set employeecode = e_employeecode WHERE FIND_IN_SET(xcp_projectid,u_record)>0;
      set limit_start = limit_start+limit_pagesize;
    until done end REPEAT;       

  CLOSE e_em;

  UPDATE betting_hq_xcp bhn LEFT JOIN enterprise_employee ee ON bhn.employeecode = ee.employeecode 
  SET bhn.enterprisecode=ee.enterprisecode , bhn.brandcode=ee.brandcode ,bhn.loginaccount=ee.loginaccount , bhn.parentemployeecode=ee.parentemployeecode;
 END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for dhp_tn_betrecord_rinse_yag
-- ----------------------------
DROP PROCEDURE IF EXISTS `dhp_tn_betrecord_rinse_yag`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `dhp_tn_betrecord_rinse_yag`(IN in_begintime datetime,IN in_endtime datetime)
BEGIN
  DECLARE done boolean DEFAULT FALSE;

  DECLARE limit_start int DEFAULT 0;

  DECLARE limit_pagesize int DEFAULT 0;

  DECLARE e_employeecode CHAR(8);
  
  DECLARE u_record longtext;  

  DECLARE e_em CURSOR FOR SELECT employeecode FROM enterprise_employee WHERE employeetypecode='T003';

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = true;

  SELECT COUNT(1) INTO @employeecount FROM enterprise_employee WHERE employeetypecode='T003';

  SELECT COUNT(1) INTO @recordcount FROM betting_yg_ag bhn WHERE bhn.createtime BETWEEN in_begintime AND in_endtime;

  SET limit_pagesize = floor(@recordcount/@employeecount);

  IF limit_pagesize >0 THEN 

  OPEN e_em;

    REPEAT
      FETCH e_em INTO e_employeecode;
      SELECT GROUP_CONCAT(temp.bet_id) INTO u_record FROM (SELECT bhn.bet_id  FROM betting_yg_ag bhn WHERE bhn.createtime BETWEEN in_begintime AND in_endtime LIMIT limit_start,limit_pagesize) AS temp;
      -- SELECT COUNT(1) INTO @u_count FROM betting_hq_nhq WHERE FIND_IN_SET( Betting_ID,u_record)>0;
      UPDATE betting_yg_ag set employeecode = e_employeecode WHERE FIND_IN_SET(bet_id,u_record)>0;
      set limit_start = limit_start+limit_pagesize;
    until done end REPEAT;       

  CLOSE e_em;

  UPDATE betting_yg_ag bhn LEFT JOIN enterprise_employee ee ON bhn.employeecode = ee.employeecode 
  SET bhn.enterprisecode=ee.enterprisecode , bhn.brandcode=ee.brandcode ,bhn.loginaccount=ee.loginaccount , bhn.parentemployeecode=ee.parentemployeecode;
  END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for dhp_tn_betrecord_rinse_zj
-- ----------------------------
DROP PROCEDURE IF EXISTS `dhp_tn_betrecord_rinse_zj`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `dhp_tn_betrecord_rinse_zj`(IN in_begintime datetime,IN in_endtime datetime)
BEGIN
  DECLARE done boolean DEFAULT FALSE;

  DECLARE limit_start int DEFAULT 0;

  DECLARE limit_pagesize int DEFAULT 0;

  DECLARE e_employeecode CHAR(8);
  
  DECLARE u_record longtext;  

  DECLARE e_em CURSOR FOR SELECT employeecode FROM enterprise_employee WHERE employeetypecode='T003';

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = true;

  SELECT COUNT(1) INTO @employeecount FROM enterprise_employee WHERE employeetypecode='T003';

  SELECT COUNT(1) INTO @recordcount FROM betting_zj bhn WHERE bhn.bettime BETWEEN in_begintime AND in_endtime;

  SET limit_pagesize = floor(@recordcount/@employeecount);

  IF limit_pagesize >0 THEN 
    OPEN e_em;
  
      REPEAT
        FETCH e_em INTO e_employeecode;
        SELECT GROUP_CONCAT(temp.id) INTO u_record FROM (SELECT bhn.id  FROM betting_zj bhn WHERE bhn.bettime BETWEEN in_begintime AND in_endtime LIMIT limit_start,limit_pagesize) AS temp;
        -- SELECT COUNT(1) INTO @u_count FROM betting_hq_nhq WHERE FIND_IN_SET( Betting_ID,u_record)>0;
        UPDATE betting_zj set employeecode = e_employeecode WHERE FIND_IN_SET(id,u_record)>0;
        set limit_start = limit_start+limit_pagesize;
      until done end REPEAT;       
  
    CLOSE e_em;
  
    UPDATE betting_zj bhn LEFT JOIN enterprise_employee ee ON bhn.employeecode = ee.employeecode 
    SET bhn.enterprisecode=ee.enterprisecode , bhn.brandcode=ee.brandcode ,bhn.loginaccount=ee.loginaccount , bhn.parentemployeecode=ee.parentemployeecode;
  END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_acting_contribution_ranking
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_acting_contribution_ranking`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_acting_contribution_ranking`(IN employeecode varchar(10),
IN date_begin date,
IN date_end date)
BEGIN
  /*
代理贡献排名
*/

  SELECT
    FF.employeecode,
    FF.loginaccount,
    CASE
        WHEN FF.employeetypecode = 'T004' THEN ufn_down_recursion_team_of_agent_count(FF.employeecode) ELSE 0
      END AS row1,
    CASE
        WHEN FF.employeetypecode = 'T003' THEN (SELECT
            COUNT(1)
          FROM enterprise_employee
          WHERE parentemployeecode = FF.employeecode) ELSE 0
      END AS row2,
    GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
    ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare)

  FROM (SELECT
      A.employeecode,
      A.enterprisecode,
      A.brandcode,
      A.loginaccount,
      A.employeetypecode,
      SUM(dividend) AS dividend,
      SUM(share) AS hare
    FROM enterprise_employee A
    WHERE parentemployeecode = employeecode
    AND A.lastlogintime BETWEEN date_begin AND date_end
    GROUP BY A.loginaccount,
             A.employeecode,
             A.employeetypecode) FF
    INNER JOIN (SELECT
        C.employeecode,
        C.enterprisecode,
        C.brandcode,
        SUM(C.net_money) AS net_money,
        SUM(C.Valid_Money) AS Valid_Money,
        SUM(D.bonus) AS bonus
      FROM betting_all_day AS C
        INNER JOIN employee_gamecataloy_bonus AS D
          ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
      GROUP BY C.employeecode,
               C.enterprisecode,
               C.brandcode) AS GG
      ON FF.employeecode = GG.employeecode
      AND FF.enterprisecode = GG.enterprisecode;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_acting_contribution_ranking_bak
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_acting_contribution_ranking_bak`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_acting_contribution_ranking_bak`(IN employeecode varchar(10),
IN date_begin date,
IN date_end date)
BEGIN
  SELECT
    FF.employeecode,
    FF.loginaccount,
    '',
    '',
    GG.net_money - (GG.Valid_Money * GG.bonus) - ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend) -
    ((GG.net_money - (GG.Valid_Money * GG.bonus) - ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare)

  FROM (SELECT
      A.employeecode,
      A.enterprisecode,
      A.brandcode,
      A.loginaccount,
      A.employeetypecode,
      SUM(dividend) AS dividend,
      SUM(share) AS hare
    FROM enterprise_employee A
    WHERE EXISTS (SELECT
        employeecode
      FROM enterprise_employee AS B
      WHERE parentemployeecode = employeecode
      AND B.employeecode = A.parentemployeecode) AND A.lastlogintime BETWEEN date_begin AND date_end
    GROUP BY A.loginaccount,
             A.employeecode,
             A.employeetypecode) FF
    INNER JOIN (SELECT
        C.employeecode,
        C.enterprisecode,
        C.brandcode,
        SUM(C.net_money) AS net_money,
        SUM(C.Valid_Money) AS Valid_Money,
        SUM(D.bonus) AS bonus
      FROM betting_all_day AS C
        INNER JOIN employee_gamecataloy_bonus AS D
          ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype) AS GG
      ON FF.employeecode = GG.employeecode
      AND FF.enterprisecode = GG.enterprisecode AND FF.brandcode = GG.brandcode;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Acting_contribution_user_lose_win_Ranking
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Acting_contribution_user_lose_win_Ranking`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_Acting_contribution_user_lose_win_Ranking`(IN employee_id varchar(10),
IN begin_date date,
IN end_date date)
BEGIN
  /*
 二次查询代理贡献排名 ---返回客户输赢统计
*/
  IF ISNULL(begin_date) = 1 AND ISNULL(end_date) = 1 THEN
    SET begin_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET end_date = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;

  SELECT
    GROUP_AA.loginaccount,
    ufn_down_recursion_team_of_agent_number(GROUP_AA.employeecode) AS num,
    GROUP_AA.employeecode,
    Game_B.Bet_Money AS game_betting_amount,
    Game_B.bonus,
    CASE
        WHEN Game_B.net_money > 0 THEN (Game_B.net_money + Game_B.bonus) * GROUP_AA.dividend ELSE 0
      END AS dividend,
    CASE
        WHEN Game_B.net_money > 0 THEN (Game_B.net_money + Game_B.bonus + ((Game_B.net_money - Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share ELSE (Game_B.net_money + Game_B.bonus) * GROUP_AA.share
      END AS share,
    CASE
        WHEN Game_B.net_money > 0 THEN (Game_B.net_money + Game_B.bonus + ((Game_B.net_money + Game_B.bonus)) * GROUP_AA.dividend) -
        ((Game_B.net_money + Game_B.bonus + ((Game_B.net_money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share) ELSE Game_B.net_money + Game_B.bonus - ((Game_B.net_money + Game_B.bonus) * GROUP_AA.share)
      END AS user_lose_win_amount
  FROM enterprise_employee GROUP_AA
    INNER JOIN (SELECT
        A.enterprisecode,
        A.employeecode,
        A.parentemployeecode,
        A.Game_Platform,
        A.Game_Type,
        SUM(A.Bet_Money) AS Bet_Money,
        SUM(A.Net_Money) AS Net_Money,
        SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
      FROM betting_all_day AS A
        INNER JOIN employee_gamecataloy_bonus AS B
          ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
          AND A.Game_Big_Type = B.categorytype
          AND A.Bet_Day BETWEEN begin_date AND end_date
      GROUP BY A.enterprisecode,
               A.employeecode,
               A.parentemployeecode,
               A.Game_Platform,
               A.Game_Type) AS Game_B
      ON GROUP_AA.employeecode = Game_B.employeecode
      AND GROUP_AA.parentemployeecode = Game_B.parentemployeecode
      AND GROUP_AA.enterprisecode = Game_B.enterprisecode
  WHERE GROUP_AA.parentemployeecode = employee_id
  AND GROUP_AA.employeetypecode = 'T004'
  UNION ALL
  SELECT
    '直线会员' AS loginaccount,
    num,
    employee_id AS employeecode,
    Bet_Money AS game_betting_amount,
    bonus,
    CASE
        WHEN net_money > 0 THEN (net_money + bonus) * dividend ELSE 0
      END AS dividend,
    CASE
        WHEN net_money > 0 THEN (net_money + bonus + ((net_money - bonus) * dividend)) * share ELSE (net_money + bonus) * share
      END AS share,
    CASE
        WHEN net_money > 0 THEN (net_money + bonus + ((net_money + bonus)) * dividend) - ((net_money + bonus + ((net_money + bonus) * dividend)) * share) ELSE net_money + bonus - ((net_money + bonus) * share)
      END AS user_lose_win_amount

  FROM (SELECT
      LINE_AA.loginaccount,
      COUNT(1) AS num,
      LINE_AA.employeecode,
      Game_B.Bet_Money,
      Game_B.net_Money,
      Game_B.bonus,
      LINE_AA.dividend,
      LINE_AA.share
    FROM enterprise_employee AS LINE_AA
      INNER JOIN (SELECT
          A.enterprisecode,
          A.employeecode,
          A.parentemployeecode,
          A.Game_Platform,
          A.Game_Type,
          SUM(A.Bet_Money) AS Bet_Money,
          SUM(A.Net_Money) AS Net_Money,
          SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
        FROM betting_all_day AS A
          INNER JOIN employee_gamecataloy_bonus AS B
            ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
            AND A.Game_Big_Type = B.categorytype
            AND A.Bet_Day BETWEEN begin_date AND end_date
        GROUP BY A.enterprisecode,
                 A.employeecode,
                 A.parentemployeecode,
                 A.Game_Platform,
                 A.Game_Type) AS Game_B
        ON LINE_AA.employeecode = Game_B.employeecode
        AND LINE_AA.parentemployeecode = Game_B.parentemployeecode
        AND LINE_AA.enterprisecode = Game_B.enterprisecode
    WHERE LINE_AA.parentemployeecode = employee_id
    AND LINE_AA.employeetypecode = 'T003') AS FF
  WHERE FF.num > 0;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_activity_butmoney_by_enterprisecode_bigtype
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_activity_butmoney_by_enterprisecode_bigtype`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_activity_butmoney_by_enterprisecode_bigtype`(IN in_enterprisecode CHAR(8),IN in_brandcode CHAR(8), IN in_begindate datetime, IN in_enddate datetime, IN in_gamebigtype CHAR(8) )
    READS SQL DATA
BEGIN
        
        /*************统计企业的所有会员在指定时间内的有效投注额，按人员分组 （按大类）*************/
                
        select employeecode,loginaccount,sum(mm) game_betting_amount from (
                /***AG**/                
                select employeecode,loginaccount,sum(valid_Bet_Amount) mm from betting_hq_ag where 
                enterprisecode=in_enterprisecode 
                and (bet_Time >= in_begindate and bet_Time <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***BBIN**/
                select employeecode,loginaccount,sum(bbin_Commissionable) mm from betting_hq_bbin where 
                enterprisecode=in_enterprisecode 
                and (bbin_Wagers_Date >= in_begindate and bbin_Wagers_Date <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***NHQ**/
                select employeecode,loginaccount,sum(Wash_Code_Credits) mm from betting_hq_nhq where
                enterprisecode=in_enterprisecode 
                and (Betting_Date >= in_begindate and Betting_Date <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***OG_AG**/
                select employeecode,loginaccount,sum(aoi_Valid_Amount) mm from betting_hq_og_ag where                 
                enterprisecode=in_enterprisecode 
                and (aoi_Add_Time >= in_begindate and aoi_Add_Time <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***OG_IBC**/
                select employeecode,loginaccount,sum(ibc_tzmoney) mm from betting_hq_og_ibc where
                enterprisecode=in_enterprisecode 
                and (ibc_balltime >= in_begindate and ibc_balltime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***OG_OG**/
                select employeecode,loginaccount,sum(aoi_Valid_Amount) mm from betting_hq_og_og where 
                enterprisecode=in_enterprisecode 
                and (aoi_Add_Time >= in_begindate and aoi_Add_Time <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                                
                UNION  ALL
                /***PT**/
                select employeecode,loginaccount,sum(pt_bet) mm from betting_hq_pt where                 
                enterprisecode=in_enterprisecode 
                and (pt_gamedate >= in_begindate and pt_gamedate <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***XCP**/
                select employeecode,loginaccount,sum(xcp_totalprice) mm from betting_hq_xcp where                 
                enterprisecode=in_enterprisecode 
                and (xcp_writetime >= in_begindate and xcp_writetime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***KR_AV**/
                select employeecode,loginaccount,sum(amount) mm from betting_kr_av where                 
                enterprisecode=in_enterprisecode 
                and (time >= in_begindate and time <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***SA**/
                select employeecode,loginaccount,sum(betamount) mm from betting_sa where                 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***YG_AG**/
                select employeecode,loginaccount,sum(valid_money) mm from betting_yg_ag where                 
                enterprisecode=in_enterprisecode 
                and (time >= in_begindate and time <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***ZJ**/
                select employeecode,loginaccount,sum(validstake) mm from betting_zj where                 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***TTG**/
                select employeecode,loginaccount,sum(amount) mm from betting_ttg where                 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***MG**/
                select employeecode,loginaccount,sum(mg_amount) mm from betting_mg where                 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***PNG**/                
                select employeecode,loginaccount,sum(valid_Bet_Amount) mm from betting_hq_png where 
                enterprisecode=in_enterprisecode 
                and (bet_Time >= in_begindate and bet_Time <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                
                UNION  ALL
                /***QP**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_qp where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***GG**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_gg where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***SGS**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_sgs where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***IDN**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_idn where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***M88**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_m88 where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***haba**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_hab where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                
                UNION  ALL
                /***WIN88**/
                select employeecode,loginaccount,sum(pt_bet) mm from betting_win88 where                 
                enterprisecode=in_enterprisecode 
                and (pt_gamedate >= in_begindate and pt_gamedate <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***TGP**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_tgp where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***QT**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_qt where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***GB**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_gb where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***EBET**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_ebet where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***EIBC**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_eibc where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gamebigtype=in_gamebigtype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                                
        ) as a group by a.employeecode;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_activity_butmoney_by_enterprisecode_smalltype
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_activity_butmoney_by_enterprisecode_smalltype`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_activity_butmoney_by_enterprisecode_smalltype`(IN in_enterprisecode CHAR(8),IN in_brandcode CHAR(8), IN in_begindate datetime, IN in_enddate datetime, IN in_gametype VARCHAR(50) )
    READS SQL DATA
BEGIN
        
        /*************统计企业的所有会员在指定时间内的有效投注额，按人员分组 （按小类）*************/
                
        select employeecode,loginaccount,sum(mm) game_betting_amount from (
                /***AG**/                
                select employeecode,loginaccount,sum(valid_Bet_Amount) mm from betting_hq_ag where 
                enterprisecode=in_enterprisecode 
                and (bet_Time >= in_begindate and bet_Time <= in_enddate)
                and game_type=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***BBIN**/
                select employeecode,loginaccount,sum(bbin_Commissionable) mm from betting_hq_bbin where 
                enterprisecode=in_enterprisecode 
                and (bbin_Wagers_Date >= in_begindate and bbin_Wagers_Date <= in_enddate)
                and bbin_game_type=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***NHQ**/
                select employeecode,loginaccount,sum(Wash_Code_Credits) mm from betting_hq_nhq where
                enterprisecode=in_enterprisecode 
                and (Betting_Date >= in_begindate and Betting_Date <= in_enddate)
                and game_type=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***OG_AG**/
                select employeecode,loginaccount,sum(aoi_Valid_Amount) mm from betting_hq_og_ag where                 
                enterprisecode=in_enterprisecode 
                and (aoi_Add_Time >= in_begindate and aoi_Add_Time <= in_enddate)
                and aoi_Game_Name_Id=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***OG_IBC**/
                select employeecode,loginaccount,sum(ibc_tzmoney) mm from betting_hq_og_ibc where
                enterprisecode=in_enterprisecode 
                and (ibc_balltime >= in_begindate and ibc_balltime <= in_enddate)
                and ibc_isbk=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***OG_OG**/
                select employeecode,loginaccount,sum(aoi_Valid_Amount) mm from betting_hq_og_og where 
                enterprisecode=in_enterprisecode 
                and (aoi_Add_Time >= in_begindate and aoi_Add_Time <= in_enddate)
                and aoi_Game_Name_Id=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                                
                UNION  ALL
                /***PT**/
                select employeecode,loginaccount,sum(pt_bet) mm from betting_hq_pt where                 
                enterprisecode=in_enterprisecode 
                and (pt_gamedate >= in_begindate and pt_gamedate <= in_enddate)
                and pt_gametype=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***XCP 此类无小类**/
                select employeecode,loginaccount,sum(xcp_totalprice) mm from betting_hq_xcp where                 
                enterprisecode=in_enterprisecode 
                and (xcp_writetime >= in_begindate and xcp_writetime <= in_enddate)
                
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***KR_AV**/
                select employeecode,loginaccount,sum(amount) mm from betting_kr_av where                 
                enterprisecode=in_enterprisecode 
                and (time >= in_begindate and time <= in_enddate)
                and provider=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***SA**/
                select employeecode,loginaccount,sum(betamount) mm from betting_sa where                 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gametype=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***YG_AG**/
                select employeecode,loginaccount,sum(valid_money) mm from betting_yg_ag where                 
                enterprisecode=in_enterprisecode 
                and (time >= in_begindate and time <= in_enddate)
                and game_id=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***ZJ**/
                select employeecode,loginaccount,sum(validstake) mm from betting_zj where                 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gametype=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***TTG**/
                select employeecode,loginaccount,sum(amount) mm from betting_ttg where                 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gametype=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***MG**/
                select employeecode,loginaccount,sum(mg_amount) mm from betting_mg where                 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gametype=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                
                UNION  ALL
                /***PNG**/                
                select employeecode,loginaccount,sum(valid_Bet_Amount) mm from betting_hq_png where 
                enterprisecode=in_enterprisecode 
                and (bet_Time >= in_begindate and bet_Time <= in_enddate)
                and game_type=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                
                UNION  ALL
                /***QP**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_qp where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and Kind_ID=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***GG**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_gg where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gameid=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                
                UNION  ALL
                /***SGS**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_sgs where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gameid=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***IDN**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_idn where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gameid=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***M88**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_m88 where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gameid=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***haba**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_hab where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gameid=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***WIN88**/
                select employeecode,loginaccount,sum(pt_bet) mm from betting_win88 where                 
                enterprisecode=in_enterprisecode 
                and (pt_gamedate >= in_begindate and pt_gamedate <= in_enddate)
                and pt_gametype=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***TGP**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_tgp where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gameid=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***QT**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_qt where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gameid=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***GB**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_gb where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gameid=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***EBET**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_ebet where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gameid=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                UNION  ALL
                /***EIBC**/                
                select employeecode,loginaccount,sum(netmoney) mm from betting_eibc where 
                enterprisecode=in_enterprisecode 
                and (bettime >= in_begindate and bettime <= in_enddate)
                and gameid=in_gametype
                and IF (in_brandcode is NULL, 0 = 0, brandcode=in_brandcode) group by employeecode
                
                
        ) as a group by a.employeecode;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_activity_by_member_employeecode_one
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_activity_by_member_employeecode_one`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_activity_by_member_employeecode_one`(IN `in_employeecode` char(8),IN `in_begindate` datetime,IN `in_enddate` datetime,OUT `activity_money` decimal(14,2))
BEGIN
	/***********根据会员独立计算时间段内的涉及活动的总金额**********/
	
	select sum(moneychangeamount) into activity_money from employee_money_change 
where employeecode = in_employeecode 
and (moneychangedate >= in_begindate and moneychangedate <= in_enddate) 
and moneychangetypecode='D6B0C11A0AC44EBBB1538BE69B004811';
	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_agent_contribution
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_agent_contribution`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_agent_contribution`(IN employee_id varchar(10),
IN date_begin date,
IN date_end date)
BEGIN
  /*
	代理贡献排名
*/

  IF ISNULL(date_begin) = 1 AND ISNULL(date_end) = 1 THEN
    SET date_begin = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;

  SELECT
    employeecode,
    loginaccount,
    agentCount,
    memberCount,
    employeetypename,
    SUM(Profit_amount) AS Profit_amount

  FROM (SELECT
      FF.employeecode,
      FF.loginaccount,
      CASE
          WHEN FF.employeetypecode = 'T004' THEN ufn_down_recursion_team_of_agent_number(FF.employeecode) ELSE 0
        END AS agentCount,
      CASE
          WHEN FF.employeetypecode = 'T003' THEN (SELECT
              COUNT(1)
            FROM enterprise_employee
            WHERE parentemployeecode = FF.employeecode
            AND employeetypecode = 'T003') ELSE 0
        END AS memberCount,
      employeetypename,
      GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
      ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) AS profit_amount

    FROM (SELECT
        A.employeecode,
        A.enterprisecode,
        A.brandcode,
        A.loginaccount,
        A.employeetypecode,
        N.employeetype AS employeetypename,
        SUM(dividend) AS dividend,
        SUM(share) AS hare
      FROM enterprise_employee A
        INNER JOIN enterprise_employee_type AS N
          ON A.employeetypecode = N.employeetypecode
      WHERE A.parentemployeecode = employee_id
      AND A.employeetypecode = 'T004'
      GROUP BY A.loginaccount,
               A.employeecode,
               A.employeetypecode) FF
      INNER JOIN (SELECT
          C.employeecode,
          C.enterprisecode,
          C.brandcode,
          C.Game_Platform,
          C.Game_Big_Type,
          SUM(C.net_money) AS net_money,
          SUM(C.Valid_Money) AS Valid_Money,
          SUM(D.bonus) AS bonus
        FROM betting_all_day AS C
          INNER JOIN employee_gamecataloy_bonus AS D
            ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
            AND C.Bet_Day BETWEEN date_begin AND date_end
        GROUP BY C.employeecode,
                 C.enterprisecode,
                 C.brandcode,
                 C.Game_Platform,
                 C.Game_Big_Type) AS GG
        ON FF.employeecode = GG.employeecode
        AND FF.enterprisecode = GG.enterprisecode) AS HH
  GROUP BY employeecode,
           loginaccount,
           agentCount,
           memberCount,
           employeetypename
  ORDER BY profit_amount DESC LIMIT 0, 10;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_agent_contribution_detail
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_agent_contribution_detail`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_agent_contribution_detail`(IN employee_id varchar(10),
IN begin_date date,
IN end_date date,
IN startsd int,
IN endsd int,
OUT param1 int)
BEGIN
  /*
 二次查询代理贡献排名 ---返回客户输赢统计
*/
  IF ISNULL(begin_date) = 1 AND ISNULL(end_date) = 1 THEN
    SET begin_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET end_date = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;
  SELECT
    COUNT(1) INTO param1
  FROM (SELECT
      GROUP_AA.loginaccount,
      ufn_down_recursion_team_of_agent_number(GROUP_AA.employeecode) AS num,
      GROUP_AA.employeecode,
      Game_B.Bet_Money AS game_betting_amount,
      Game_B.bonus,
      CASE
          WHEN Game_B.net_money > 0 THEN (Game_B.net_money + Game_B.bonus) * GROUP_AA.dividend ELSE 0
        END AS dividend,
      CASE
          WHEN Game_B.net_money > 0 THEN (Game_B.net_money + Game_B.bonus + ((Game_B.net_money - Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share ELSE (Game_B.net_money + Game_B.bonus) * GROUP_AA.share
        END AS share,
      CASE
          WHEN Game_B.net_money > 0 THEN (Game_B.net_money + Game_B.bonus + ((Game_B.net_money + Game_B.bonus)) * GROUP_AA.dividend) -
          ((Game_B.net_money + Game_B.bonus + ((Game_B.net_money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share) ELSE Game_B.net_money + Game_B.bonus - ((Game_B.net_money + Game_B.bonus) * GROUP_AA.share)
        END AS user_lose_win_amount
    FROM enterprise_employee GROUP_AA
      INNER JOIN (SELECT
          A.enterprisecode,
          A.employeecode,
          A.parentemployeecode,
          A.Game_Platform,
          A.Game_Type,
          SUM(A.Bet_Money) AS Bet_Money,
          SUM(A.Net_Money) AS Net_Money,
          SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
        FROM betting_all_day AS A
          INNER JOIN employee_gamecataloy_bonus AS B
            ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
            AND A.Game_Big_Type = B.categorytype
            AND A.Bet_Day BETWEEN begin_date AND end_date
        GROUP BY A.enterprisecode,
                 A.employeecode,
                 A.parentemployeecode,
                 A.Game_Platform,
                 A.Game_Type) AS Game_B
        ON GROUP_AA.employeecode = Game_B.employeecode
        AND GROUP_AA.parentemployeecode = Game_B.parentemployeecode
        AND GROUP_AA.enterprisecode = Game_B.enterprisecode
    WHERE GROUP_AA.parentemployeecode = employee_id
    AND GROUP_AA.employeetypecode = 'T004'
    UNION ALL
    SELECT
      '直线会员' AS loginaccount,
      num,
      employee_id AS employeecode,
      Bet_Money AS game_betting_amount,
      bonus,
      CASE
          WHEN net_money > 0 THEN (net_money + bonus) * dividend ELSE 0
        END AS dividend,
      CASE
          WHEN net_money > 0 THEN (net_money + bonus + ((net_money - bonus) * dividend)) * share ELSE (net_money + bonus) * share
        END AS share,
      CASE
          WHEN net_money > 0 THEN (net_money + bonus + ((net_money + bonus)) * dividend) - ((net_money + bonus + ((net_money + bonus) * dividend)) * share) ELSE net_money + bonus - ((net_money + bonus) * share)
        END AS user_lose_win_amount

    FROM (SELECT
        LINE_AA.loginaccount,
        COUNT(1) AS num,
        LINE_AA.employeecode,
        Game_B.Bet_Money,
        Game_B.net_Money,
        Game_B.bonus,
        LINE_AA.dividend,
        LINE_AA.share
      FROM enterprise_employee AS LINE_AA
        INNER JOIN (SELECT
            A.enterprisecode,
            A.employeecode,
            A.parentemployeecode,
            A.Game_Platform,
            A.Game_Type,
            SUM(A.Bet_Money) AS Bet_Money,
            SUM(A.Net_Money) AS Net_Money,
            SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
          FROM betting_all_day AS A
            INNER JOIN employee_gamecataloy_bonus AS B
              ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
              AND A.Game_Big_Type = B.categorytype
              AND A.Bet_Day BETWEEN begin_date AND end_date
          GROUP BY A.enterprisecode,
                   A.employeecode,
                   A.parentemployeecode,
                   A.Game_Platform,
                   A.Game_Type) AS Game_B
          ON LINE_AA.employeecode = Game_B.employeecode
          AND LINE_AA.parentemployeecode = Game_B.parentemployeecode
          AND LINE_AA.enterprisecode = Game_B.enterprisecode
      WHERE LINE_AA.parentemployeecode = employee_id
      AND LINE_AA.employeetypecode = 'T003') AS FF
    WHERE FF.num > 0) AS HH;

  SELECT
    GROUP_AA.loginaccount,
    ufn_down_recursion_team_of_agent_number(GROUP_AA.employeecode) AS num,
    GROUP_AA.employeecode,
    N.employeetype AS employeetypename,
    Game_B.Bet_Money AS game_betting_amount,
    Game_B.bonus,
    CASE
        WHEN Game_B.net_money > 0 THEN (Game_B.net_money + Game_B.bonus) * GROUP_AA.dividend ELSE 0
      END AS dividend,
    CASE
        WHEN Game_B.net_money > 0 THEN (Game_B.net_money + Game_B.bonus + ((Game_B.net_money - Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share ELSE (Game_B.net_money + Game_B.bonus) * GROUP_AA.share
      END AS share,
    CASE
        WHEN Game_B.net_money > 0 THEN (Game_B.net_money + Game_B.bonus + ((Game_B.net_money + Game_B.bonus)) * GROUP_AA.dividend) -
        ((Game_B.net_money + Game_B.bonus + ((Game_B.net_money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share) ELSE Game_B.net_money + Game_B.bonus - ((Game_B.net_money + Game_B.bonus) * GROUP_AA.share)
      END AS user_lose_win_amount
  FROM enterprise_employee GROUP_AA
    INNER JOIN (SELECT
        A.enterprisecode,
        A.employeecode,
        A.parentemployeecode,
        A.Game_Platform,
        A.Game_Type,
        SUM(A.Bet_Money) AS Bet_Money,
        SUM(A.Net_Money) AS Net_Money,
        SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
      FROM betting_all_day AS A
        INNER JOIN employee_gamecataloy_bonus AS B
          ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
          AND A.Game_Big_Type = B.categorytype
          AND A.Bet_Day BETWEEN begin_date AND end_date
      GROUP BY A.enterprisecode,
               A.employeecode,
               A.parentemployeecode,
               A.Game_Platform,
               A.Game_Type) AS Game_B
      ON GROUP_AA.employeecode = Game_B.employeecode
      AND GROUP_AA.parentemployeecode = Game_B.parentemployeecode
      AND GROUP_AA.enterprisecode = Game_B.enterprisecode
    INNER JOIN enterprise_employee_type AS N
      ON GROUP_AA.employeetypecode = N.employeetypecode
  WHERE GROUP_AA.parentemployeecode = employee_id
  AND GROUP_AA.employeetypecode = 'T004'
  UNION ALL
  SELECT
    '直线会员' AS loginaccount,
    num,
    employee_id AS employeecode,
    '会员' AS employeetypename,
    Bet_Money AS game_betting_amount,
    bonus,
    CASE
        WHEN net_money > 0 THEN (net_money + bonus) * dividend ELSE 0
      END AS dividend,
    CASE
        WHEN net_money > 0 THEN (net_money + bonus + ((net_money - bonus) * dividend)) * share ELSE (net_money + bonus) * share
      END AS share,
    CASE
        WHEN net_money > 0 THEN (net_money + bonus + ((net_money + bonus)) * dividend) - ((net_money + bonus + ((net_money + bonus) * dividend)) * share) ELSE net_money + bonus - ((net_money + bonus) * share)
      END AS user_lose_win_amount

  FROM (SELECT
      LINE_AA.loginaccount,
      COUNT(1) AS num,
      LINE_AA.employeecode,
      Game_B.Bet_Money,
      Game_B.net_Money,
      Game_B.bonus,
      LINE_AA.dividend,
      LINE_AA.share
    FROM enterprise_employee AS LINE_AA
      INNER JOIN (SELECT
          A.enterprisecode,
          A.employeecode,
          A.parentemployeecode,
          A.Game_Platform,
          A.Game_Type,
          SUM(A.Bet_Money) AS Bet_Money,
          SUM(A.Net_Money) AS Net_Money,
          SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
        FROM betting_all_day AS A
          INNER JOIN employee_gamecataloy_bonus AS B
            ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
            AND A.Game_Big_Type = B.categorytype
            AND A.Bet_Day BETWEEN begin_date AND end_date
        GROUP BY A.enterprisecode,
                 A.employeecode,
                 A.parentemployeecode,
                 A.Game_Platform,
                 A.Game_Type) AS Game_B
        ON LINE_AA.employeecode = Game_B.employeecode
        AND LINE_AA.parentemployeecode = Game_B.parentemployeecode
        AND LINE_AA.enterprisecode = Game_B.enterprisecode
    WHERE LINE_AA.parentemployeecode = employee_id
    AND LINE_AA.employeetypecode = 'T003') AS FF
  WHERE FF.num > 0;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_agent_lose_win__detail
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_agent_lose_win__detail`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_agent_lose_win__detail`(IN employee_id varchar(10),
IN begin_date date,
IN end_date date,
IN startd int,
IN endsd int)
BEGIN
  /*
 二次查询客户输赢统计
*/
  IF ISNULL(begin_date) = 1 AND ISNULL(end_date) = 1 THEN
    SET begin_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET end_date = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;
  SELECT
    GROUP_AA.loginaccount,
    ufn_down_recursion_team_of_agent_count(GROUP_AA.employeecode) AS num,
    GROUP_AA.employeecode,
    Game_B.Bet_Money AS game_betting_amount,
    Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend) -
    ((Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share) AS lose_win_amount,
    Game_B.bonus,
    (Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend AS dividend,
    (Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share AS share
  FROM enterprise_employee GROUP_AA
    INNER JOIN (SELECT
        A.enterprisecode,
        A.employeecode,
        A.parentemployeecode,
        A.Game_Platform,
        A.Game_Type,
        SUM(A.Bet_Money) AS Bet_Money,
        SUM(A.Net_Money) AS Net_Money,
        SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
      FROM betting_all_day AS A
        INNER JOIN employee_gamecataloy_bonus AS B
          ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
          AND A.Game_Big_Type = B.categorytype
          AND A.Bet_Day BETWEEN begin_date AND end_date
      GROUP BY A.enterprisecode,
               A.employeecode,
               A.parentemployeecode,
               A.Game_Platform,
               A.Game_Type) AS Game_B
      ON GROUP_AA.employeecode = Game_B.employeecode
      AND GROUP_AA.parentemployeecode = Game_B.parentemployeecode
      AND GROUP_AA.enterprisecode = Game_B.enterprisecode
  WHERE GROUP_AA.parentemployeecode = employee_id
  AND GROUP_AA.employeetypecode = 'T004'
  UNION ALL
  SELECT
    '直线会员' AS loginaccount,
    SUM(num) AS num,
    employee_id AS employeecode,
    Bet_Money AS game_betting_amount,
    net_Money + bonus + dividend - share AS lose_win_amount,
    bonus,
    dividend,
    share
  FROM (SELECT
      LINE_AA.loginaccount,
      COUNT(1) AS num,
      LINE_AA.employeecode,
      Game_B.Bet_Money,
      Game_B.net_Money,
      Game_B.bonus,
      (Game_B.Net_Money + Game_B.bonus) * LINE_AA.dividend AS dividend,
      (Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * LINE_AA.dividend)) * LINE_AA.share AS share
    FROM enterprise_employee AS LINE_AA
      INNER JOIN (SELECT
          A.enterprisecode,
          A.employeecode,
          A.parentemployeecode,
          A.Game_Platform,
          A.Game_Type,
          SUM(A.Bet_Money) AS Bet_Money,
          SUM(A.Net_Money) AS Net_Money,
          SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
        FROM betting_all_day AS A
          INNER JOIN employee_gamecataloy_bonus AS B
            ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
            AND A.Game_Big_Type = B.categorytype
            AND A.Bet_Day BETWEEN begin_date AND end_date
        GROUP BY A.enterprisecode,
                 A.employeecode,
                 A.parentemployeecode,
                 A.Game_Platform,
                 A.Game_Type) AS Game_B
        ON LINE_AA.employeecode = Game_B.employeecode
        AND LINE_AA.parentemployeecode = Game_B.parentemployeecode
        AND LINE_AA.enterprisecode = Game_B.enterprisecode
    WHERE LINE_AA.parentemployeecode = employee_id
    AND LINE_AA.employeetypecode = 'T003') AS FF
  WHERE FF.num > 0 LIMIT startd, endsd;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Customer_Access_Statistics
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Customer_Access_Statistics`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_Customer_Access_Statistics`(IN employeecode varchar(10),
IN date_begin date,
IN date_end date,
IN var_start int,
IN var_end int)
BEGIN
  /*
用户存取统计
*/
  SELECT
    AA.loginaccount,
    AA.employeecode,
    BB.deposit_mount,
    BB.deposit_num,
    CC.take_mount,
    CC.take_num
  FROM (SELECT
      loginaccount,
      employeecode,
      parentemployeecode,
      enterprisecode,
      brandcode
    FROM enterprise_employee
    WHERE parentemployeecode = employeecode
    AND logindatetime BETWEEN date_begin AND date_end) AS AA
    INNER JOIN (SELECT
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode,
        SUM(orderamount) AS deposit_mount,
        COUNT(1) AS deposit_num
      FROM deposit_withdraw_order
      WHERE ordertype = 1
      GROUP BY employeecode,
               parentemployeecode,
               enterprisecode,
               brandcode) AS BB
      ON AA.employeecode = BB.employeecode
      AND AA.parentemployeecode = BB.parentemployeecode AND AA.enterprisecode = BB.enterprisecode
      AND AA.brandcode = BB.brandcode
    INNER JOIN (SELECT
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode,
        SUM(orderamount) AS take_mount,
        COUNT(1) AS take_num
      FROM deposit_withdraw_order
      WHERE ordertype = 2
      GROUP BY employeecode,
               parentemployeecode,
               enterprisecode,
               brandcode) AS CC
      ON AA.employeecode = CC.employeecode
      AND AA.parentemployeecode = CC.parentemployeecode AND AA.enterprisecode = CC.enterprisecode
      AND AA.brandcode = CC.brandcode LIMIT var_start, var_end;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_customer_line_winning_loseing_count
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_customer_line_winning_loseing_count`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_customer_line_winning_loseing_count`(IN employee_id varchar(10),
IN start_date date,
IN date_end date,
IN startd int,
IN endsd int)
BEGIN
  /*
 二次查询客户输赢统计----直线会员报表显示
*/
  IF startd = 0 THEN
    SET startd = 0;
  END IF;
  IF endsd = 0 THEN
    SET endsd = 10;
  END IF;

  SELECT
    AA.employeecode,
    AA.loginaccount,
    COUNT(1) AS num,
    GG.Bet_Money AS game_betting_amount,
    GG.Net_Money + GG.Valid_Money * GG.bonus + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend + ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS lose_win_amount,
    GG.Valid_Money * GG.bonus AS bonus,
    (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend AS Dividend,
    ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS share
  FROM enterprise_employee AS AA
    INNER JOIN (SELECT
        BB.employeecode,
        BB.parentemployeecode,
        BB.enterprisecode,
        BB.Game_Platform,
        BB.Game_Type,
        SUM(BB.Bet_Money) AS Bet_Money,
        SUM(BB.Net_Money) AS Net_Money,
        SUM(BB.Valid_Money) AS Valid_Money,
        SUM(DD.bonus) AS bonus
      FROM betting_all_day BB
        INNER JOIN employee_gamecataloy_bonus AS DD
          ON BB.employeecode = DD.employeecode AND BB.Game_Platform = DD.gametype AND BB.Game_Big_Type = DD.categorytype
      GROUP BY BB.employeecode,
               BB.parentemployeecode,
               BB.enterprisecode,
               BB.Game_Platform,
               BB.Game_Type) AS GG
      ON AA.employeecode = GG.employeecode AND AA.parentemployeecode = GG.parentemployeecode AND AA.enterprisecode = GG.enterprisecode
  WHERE AA.parentemployeecode = employee_id
  AND AA.employeetypecode = 'T003'
  AND DATE_FORMAT(AA.logindatetime, '%Y-%m-%d') BETWEEN start_date AND date_end
  GROUP BY AA.employeecode,
           AA.loginaccount LIMIT startd, endsd;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_customers_lose_ranking
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_customers_lose_ranking`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_customers_lose_ranking`(IN employeecode varchar(10),
IN start_end date,
IN date_end date)
BEGIN
  /*
 客户输排名
*/
  SELECT
    B.User_Name,
    A.employeecode,
    SUM(B.Net_Money) AS Money,
    start_end AS date_ben,
    date_end AS date_end
  FROM (SELECT
      *
    FROM enterprise_employee
    WHERE parentemployeecode = employeecode
    AND logindatetime BETWEEN start_end AND date_end) AS A
    INNER JOIN betting_all_day AS B
      ON A.employeecode = B.employeecode
  GROUP BY B.User_Name,
           A.employeecode
  ORDER BY Money DESC LIMIT 0, 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_customers_profit_count
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_customers_profit_count`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_customers_profit_count`(IN employee_id varchar(10),
IN begin_date date,
IN end_date date,
IN startd int,
IN endsd int)
BEGIN
  /*
 二次查询利润表
*/
  SELECT
    GROUP_AA.loginaccount,
    ufn_down_recursion_team_of_agent_count(GROUP_AA.employeecode) AS num,
    GROUP_AA.employeecode,
    Game_B.Bet_Money AS game_betting_amount,
    Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend) -
    ((Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share) AS lose_win_amount,
    Game_B.bonus,
    (Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend AS dividend,
    (Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share AS share
  FROM enterprise_employee GROUP_AA
    INNER JOIN (SELECT
        A.enterprisecode,
        A.employeecode,
        A.parentemployeecode,
        A.Game_Platform,
        A.Game_Type,
        SUM(A.Bet_Money) AS Bet_Money,
        SUM(A.Net_Money) AS Net_Money,
        SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
      FROM betting_all_day AS A
        INNER JOIN employee_gamecataloy_bonus AS B
          ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
          AND A.Game_Big_Type = B.categorytype) AS Game_B
      ON GROUP_AA.employeecode = Game_B.employeecode
      AND GROUP_AA.parentemployeecode = Game_B.parentemployeecode
      AND GROUP_AA.enterprisecode = Game_B.enterprisecode
  WHERE GROUP_AA.parentemployeecode = employee_id
  AND DATE_FORMAT(GROUP_AA.logindatetime, '%Y-%m-%d') BETWEEN begin_date AND end_date
  AND GROUP_AA.employeetypecode = 'T004'
  UNION ALL
  SELECT
    '直线会员' AS loginaccount,
    SUM(num) AS num,
    'E00000BN' AS employeecode,
    Bet_Money AS game_betting_amount,
    net_Money + bonus + dividend - share AS lose_win_amount,
    bonus,
    dividend,
    share
  FROM (SELECT
      LINE_AA.loginaccount,
      COUNT(1) AS num,
      LINE_AA.employeecode,
      Game_B.Bet_Money,
      Game_B.net_Money,
      Game_B.bonus,
      (Game_B.Net_Money + Game_B.bonus) * LINE_AA.dividend AS dividend,
      (Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * LINE_AA.dividend)) * LINE_AA.share AS share
    FROM enterprise_employee AS LINE_AA
      INNER JOIN (SELECT
          A.enterprisecode,
          A.employeecode,
          A.parentemployeecode,
          A.Game_Platform,
          A.Game_Type,
          SUM(A.Bet_Money) AS Bet_Money,
          SUM(A.Net_Money) AS Net_Money,
          SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
        FROM betting_all_day AS A
          INNER JOIN employee_gamecataloy_bonus AS B
            ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
            AND A.Game_Big_Type = B.categorytype) AS Game_B
        ON LINE_AA.employeecode = Game_B.employeecode
        AND LINE_AA.parentemployeecode = Game_B.parentemployeecode
        AND LINE_AA.enterprisecode = Game_B.enterprisecode
    WHERE LINE_AA.parentemployeecode = employee_id
    AND DATE_FORMAT(GROUP_AA.logindatetime, '%Y-%m-%d') BETWEEN begin_date AND end_date
    AND LINE_AA.employeetypecode = 'T003') AS FF
  WHERE FF.num > 0 LIMIT startd, endsd;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_customers_win_ranking
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_customers_win_ranking`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_customers_win_ranking`(IN employeecode varchar(10),
IN start_end date,
IN date_end date)
BEGIN
  /*
 客户赢排名
*/
  SELECT
    B.User_Name,
    A.employeecode,
    SUM(B.Net_Money) AS Money,
    start_end AS date_ben,
    date_end AS date_end
  FROM (SELECT
      *
    FROM enterprise_employee
    WHERE parentemployeecode = employeecode
    AND logindatetime BETWEEN start_end AND date_end) AS A
    INNER JOIN betting_all_day AS B
      ON A.employeecode = B.employeecode
  GROUP BY B.User_Name,
           A.employeecode
  ORDER BY Money ASC LIMIT 0, 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_customers_winning_losing_count
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_customers_winning_losing_count`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_customers_winning_losing_count`(IN employee_id varchar(10),
IN begin_date date,
IN end_date date,
IN startd int,
IN endsd int)
BEGIN
  /*
 二次查询客户输赢统计
*/
  SELECT
    GROUP_AA.loginaccount,
    ufn_down_recursion_team_of_agent_count(GROUP_AA.employeecode) AS num,
    GROUP_AA.employeecode,
    Game_B.Bet_Money AS game_betting_amount,
    Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend) -
    ((Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share) AS lose_win_amount,
    Game_B.bonus,
    (Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend AS dividend,
    (Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share AS share
  FROM enterprise_employee GROUP_AA
    INNER JOIN (SELECT
        A.enterprisecode,
        A.employeecode,
        A.parentemployeecode,
        A.Game_Platform,
        A.Game_Type,
        SUM(A.Bet_Money) AS Bet_Money,
        SUM(A.Net_Money) AS Net_Money,
        SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
      FROM betting_all_day AS A
        INNER JOIN employee_gamecataloy_bonus AS B
          ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
          AND A.Game_Big_Type = B.categorytype) AS Game_B
      ON GROUP_AA.employeecode = Game_B.employeecode
      AND GROUP_AA.parentemployeecode = Game_B.parentemployeecode
      AND GROUP_AA.enterprisecode = Game_B.enterprisecode
  WHERE GROUP_AA.parentemployeecode = employee_id
  AND DATE_FORMAT(GROUP_AA.logindatetime, '%Y-%m-%d') BETWEEN begin_date AND end_date
  AND GROUP_AA.employeetypecode = 'T004'
  UNION ALL
  SELECT
    loginaccount,
    num,
    employeecode,
    game_betting_amount,
    lose_win_amount,
    bonus,
    dividend,
    share
  FROM (SELECT
      '直线会员' AS loginaccount,
      SUM(num) AS num,
      employee_id AS employeecode,
      Bet_Money AS game_betting_amount,
      net_Money + bonus + dividend - share AS lose_win_amount,
      bonus,
      dividend,
      share
    FROM (SELECT
        LINE_AA.loginaccount,
        COUNT(1) AS num,
        LINE_AA.employeecode,
        Game_B.Bet_Money,
        Game_B.net_Money,
        Game_B.bonus,
        (Game_B.Net_Money + Game_B.bonus) * LINE_AA.dividend AS dividend,
        (Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * LINE_AA.dividend)) * LINE_AA.share AS share
      FROM enterprise_employee AS LINE_AA
        INNER JOIN (SELECT
            A.enterprisecode,
            A.employeecode,
            A.parentemployeecode,
            A.Game_Platform,
            A.Game_Type,
            SUM(A.Bet_Money) AS Bet_Money,
            SUM(A.Net_Money) AS Net_Money,
            SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
          FROM betting_all_day AS A
            INNER JOIN employee_gamecataloy_bonus AS B
              ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
              AND A.Game_Big_Type = B.categorytype
          GROUP BY A.enterprisecode,
                   A.employeecode,
                   A.parentemployeecode,
                   A.Game_Platform,
                   A.Game_Type) AS Game_B
          ON LINE_AA.employeecode = Game_B.employeecode
          AND LINE_AA.parentemployeecode = Game_B.parentemployeecode
          AND LINE_AA.enterprisecode = Game_B.enterprisecode
      WHERE LINE_AA.parentemployeecode = employee_id
      AND DATE_FORMAT(LINE_AA.logindatetime, '%Y-%m-%d') BETWEEN begin_date AND end_date
      AND LINE_AA.employeetypecode = 'T003') AS FF
    WHERE FF.num > 0) AS TT
  WHERE num > 0 LIMIT startd, endsd;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_domainlink_user_dom
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_domainlink_user_dom`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_domainlink_user_dom`(IN employee_id varchar(10),
IN link_code varchar(64),
IN startsd int,
IN endsd int,
OUT param1 int)
BEGIN
  /*
品牌编码，品牌名称， 企业编码，企业名称, 域名, 注册用户数量, 用户编码, 用户登录账号
*/
  DECLARE rownums int DEFAULT 0;
  DECLARE rownumd int DEFAULT 0;

  IF ISNULL(employee_id) = 1 THEN
    SET rownums = 1;
  END IF;

  IF ISNULL(link_code) = 1 THEN
    SET rownumd = 1;
  END IF;

  SELECT
    COUNT(1) INTO param1
  FROM (SELECT
      A.brandcode,
      brand.brandname,
      A.enterprisecode,
      EN.enterprisename,
      A.domainlink,
      nn.num,
      A.employeecode,
      nn.loginaccount
    FROM brand_domain A
      INNER JOIN (SELECT
          employeecode,
          loginaccount,
          COUNT(1) num
        FROM enterprise_employee
        WHERE datastatus = 1
        GROUP BY employeecode,
                 loginaccount) AS nn
        ON A.employeecode = nn.employeecode
      LEFT JOIN enterprise AS EN
        ON A.enterprisecode = EN.enterprisecode
      LEFT JOIN enterprise_operating_brand AS brand
        ON A.brandcode = brand.brandcode
    WHERE A.domaintype = 2 AND A.datastatus = 1
    AND ((rownums = 1) OR (rownums = 0 AND A.employeecode = employee_id))
    AND ((rownumd = 1) OR (rownumd = 0 AND A.domainlink = link_code))) AS HH;


  SELECT
    A.brandcode,
    brand.brandname,
    A.enterprisecode,
    EN.enterprisename,
    A.domainlink,
    nn.num,
    A.employeecode,
    nn.loginaccount
  FROM brand_domain A
    INNER JOIN (SELECT
        employeecode,
        loginaccount,
        COUNT(1) num
      FROM enterprise_employee
      WHERE datastatus = 1
      GROUP BY employeecode,
               loginaccount) AS nn
      ON A.employeecode = nn.employeecode
    LEFT JOIN enterprise AS EN
      ON A.enterprisecode = EN.enterprisecode
    LEFT JOIN enterprise_operating_brand AS brand
      ON A.brandcode = brand.brandcode
  WHERE A.domaintype = 2 AND A.datastatus = 1
  AND ((rownums = 1) OR (rownums = 0 AND A.employeecode = employee_id))
  AND ((rownumd = 1) OR (rownumd = 0 AND A.domainlink = link_code))
  LIMIT startsd, endsd;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_down_recursion_team_of_agent
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_down_recursion_team_of_agent`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_down_recursion_team_of_agent`(IN in_parentemployeecode char(8))
    READS SQL DATA
BEGIN
  DECLARE l_parentemployeecode longtext;
  DECLARE lc_parentemployeecode longtext;

  SET l_parentemployeecode = in_parentemployeecode;
  SET lc_parentemployeecode = in_parentemployeecode;

LABLE_LP:
LOOP
  SELECT
    GROUP_CONCAT(employeecode SEPARATOR ',') INTO lc_parentemployeecode
  FROM enterprise_employee
  WHERE FIND_IN_SET(parentemployeecode, lc_parentemployeecode) > 0 AND employeetypecode != 'T003';
  IF lc_parentemployeecode IS NULL OR lc_parentemployeecode = 'NULL' THEN
    LEAVE LABLE_LP;
  END IF;
  SET l_parentemployeecode = CONCAT_WS(',', l_parentemployeecode, lc_parentemployeecode);
END LOOP LABLE_LP;

  SELECT
    ee.employeecode,
    ee.parentemployeecode
  FROM enterprise_employee ee
  WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003';
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_employee_login_activity
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_employee_login_activity`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_employee_login_activity`(IN login varchar(10))
BEGIN
  /*
			客户活跃统计
	*/
  DECLARE rownum int DEFAULT 0;

  SELECT
    '三天内' AS Days,
    COUNT(1) AS num
  FROM enterprise_employee
  WHERE parentemployeecode = login
  AND datastatus = 1
  AND DATE_FORMAT(lastlogintime, '%Y-%m-%d') NOT BETWEEN DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 3 DAY)
  AND DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d')
  UNION ALL
  SELECT
    '七天内' AS Days,
    COUNT(1) AS num
  FROM enterprise_employee
  WHERE parentemployeecode = login
  AND datastatus = 1
  AND DATE_FORMAT(lastlogintime, '%Y-%m-%d') NOT BETWEEN DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 7 DAY)
  AND DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d')
  UNION ALL
  SELECT
    '十五天内' AS Days,
    COUNT(1) AS num
  FROM enterprise_employee
  WHERE parentemployeecode = login
  AND datastatus = 1
  AND DATE_FORMAT(lastlogintime, '%Y-%m-%d') NOT BETWEEN DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 15 DAY)
  AND DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d')
  UNION ALL
  SELECT
    '一个月内' AS Days,
    COUNT(1) AS num
  FROM enterprise_employee
  WHERE parentemployeecode = login
  AND datastatus = 1
  AND DATE_FORMAT(lastlogintime, '%Y-%m-%d') NOT BETWEEN DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY)
  AND DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d')
  UNION ALL
  SELECT
    '三个月内' AS Days,
    COUNT(1) AS num
  FROM enterprise_employee
  WHERE parentemployeecode = login
  AND datastatus = 1
  AND DATE_FORMAT(lastlogintime, '%Y-%m-%d') NOT BETWEEN DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 90 DAY)
  AND DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d')
  UNION ALL
  SELECT
    '三个月以上' AS Days,
    COUNT(1) AS num
  FROM enterprise_employee
  WHERE parentemployeecode = login
  AND datastatus = 1
  AND DATE_FORMAT(lastlogintime, '%Y-%m-%d') < DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 90 DAY);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_employeecode_income_statemet
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_employeecode_income_statemet`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_employeecode_income_statemet`(IN employeecode varchar(10),
IN date_begin date,
IN date_end date,
IN var_start int,
IN var_end int)
BEGIN
  /*
	利润表
*/

  SELECT
    FF.loginaccount,
    FF.num,
    FF.employeecode,
    GG.Bet_Money,
    GG.net_money,
    GG.Valid_Money * GG.bonus AS bonus_money,
    CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
      END AS dividend_money,
    CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
      END AS hare_money,
    CASE
        WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
        ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
      END AS money

  FROM (SELECT
      A.employeecode,
      A.enterprisecode,
      A.brandcode,
      A.loginaccount,
      A.employeetypecode,
      ufn_down_recursion_team_of_agent_count(A.employeecode) AS num,
      SUM(dividend) AS dividend,
      SUM(share) AS hare
    FROM enterprise_employee A
    WHERE EXISTS (SELECT
        employeecode
      FROM enterprise_employee AS B
      WHERE parentemployeecode = employeecode
      AND B.employeecode = A.parentemployeecode) AND A.lastlogintime BETWEEN date_begin AND date_end
    AND A.employeetypecode = 'T004'
    GROUP BY A.loginaccount,
             A.employeecode,
             A.employeetypecode) FF
    INNER JOIN (SELECT
        C.employeecode,
        C.enterprisecode,
        C.brandcode,
        SUM(C.Bet_Money) AS Bet_Money,
        SUM(C.net_money) AS net_money,
        SUM(C.Valid_Money) AS Valid_Money,
        SUM(D.bonus) AS bonus
      FROM betting_all_day AS C
        INNER JOIN employee_gamecataloy_bonus AS D
          ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype) AS GG
      ON FF.employeecode = GG.employeecode
      AND FF.enterprisecode = GG.enterprisecode AND FF.brandcode = GG.brandcode
  UNION ALL
  SELECT
    '直线会员' AS loginaccount,
    COUNT(1) AS num,
    employeecode AS employeecode,
    GG.Bet_Money,
    GG.net_money,
    SUM(GG.Valid_Money * GG.bonus) AS bonus_money,
    SUM(CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
      END) AS dividend_money,
    SUM(CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
      END) AS hare_money,
    SUM(CASE
        WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
        ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
      END) AS money
  FROM (SELECT
      A.employeecode,
      A.enterprisecode,
      A.brandcode,
      A.loginaccount,
      A.employeetypecode,
      SUM(dividend) AS dividend,
      SUM(share) AS hare
    FROM enterprise_employee A
    WHERE EXISTS (SELECT
        employeecode
      FROM enterprise_employee AS B
      WHERE parentemployeecode = employeecode
      AND B.employeecode = A.parentemployeecode) AND A.lastlogintime BETWEEN date_begin AND date_end
    AND A.employeetypecode = 'T003'
    GROUP BY A.loginaccount,
             A.employeecode,
             A.employeetypecode) FF
    INNER JOIN (SELECT
        C.employeecode,
        C.enterprisecode,
        C.brandcode,
        SUM(C.Bet_Money) AS Bet_Money,
        SUM(C.net_money) AS net_money,
        SUM(C.Valid_Money) AS Valid_Money,
        SUM(D.bonus) AS bonus
      FROM betting_all_day AS C
        INNER JOIN employee_gamecataloy_bonus AS D
          ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype) AS GG
      ON FF.employeecode = GG.employeecode
      AND FF.enterprisecode = GG.enterprisecode AND FF.brandcode = GG.brandcode
  LIMIT var_start, var_end;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_enterprise_user_count
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_enterprise_user_count`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_enterprise_user_count`( in  enterprise_id  VARCHAR(20))
BEGIN
/* 
  企业人数，近一个月的存款情况
*/
	DECLARE  start_date   date;
	DECLARE  date_end   date;

	SET start_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
  SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');

	SELECT count(1)+300000 as registernum, IF(sum(B.orderamount)IS NULL,0,sum(B.orderamount))+50000000 as saveamount
		FROM (SELECT DISTINCT employeecode,parentemployeecode, enterprisecode
						FROM enterprise_employee
					 WHERE enterprisecode = enterprise_id
						 AND datastatus = 1) as A LEFT JOIN  
				 (SELECT employeecode,parentemployeecode, enterprisecode, sum(orderamount) as orderamount
						FROM deposit_withdraw_order 
					 WHERE DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN start_date AND date_end
						 AND ordertype = 1
						 AND orderstatus = 2
					GROUP BY employeecode,parentemployeecode, enterprisecode)as B
			ON A.employeecode = B.employeecode AND A.parentemployeecode = B.parentemployeecode
			AND A.enterprisecode = B.enterprisecode;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_game_Reports
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_game_Reports`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_game_Reports`(IN employeecode varchar(10),
IN date_begin date,
IN date_end date,
IN var_start int,
IN var_end int,
OUT param1 int)
BEGIN
  /*
游戏报表
*/
  IF ISNULL(var_start) = 1 AND ISNULL(var_end) = 1 THEN
    SET var_start = 0;
    SET var_end = 10;
  END IF;
  IF ISNULL(date_begin) = 1 AND ISNULL(date_end) = 1 THEN
    SET date_begin = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;
  SELECT
    COUNT(1) INTO param1
  FROM (SELECT
      FF.loginaccount,
      FF.num,
      FF.employeecode,
      TT.employeetype,
      GG.Bet_Money AS game_betting_amount,
      GG.net_money + (GG.Valid_Money * GG.bonus) AS lose_win_amount,
      GG.Valid_Money * GG.bonus AS bonus

    FROM (SELECT
        A.employeecode,
        A.enterprisecode,
        A.brandcode,
        A.loginaccount,
        A.employeetypecode,
        ufn_down_recursion_team_of_agent_count(A.employeecode) AS num,
        SUM(dividend) AS dividend,
        SUM(share) AS hare
      FROM enterprise_employee A
      WHERE A.parentemployeecode = employeecode
      AND A.employeetypecode = 'T004'
      GROUP BY A.loginaccount,
               A.employeecode,
               A.employeetypecode) FF
      INNER JOIN (SELECT
          C.employeecode,
          C.enterprisecode,
          C.brandcode,
          SUM(C.Bet_Money) AS Bet_Money,
          SUM(C.net_money) AS net_money,
          SUM(C.Valid_Money) AS Valid_Money,
          SUM(D.bonus) AS bonus
        FROM betting_all_day AS C
          INNER JOIN employee_gamecataloy_bonus AS D
            ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
            AND C.Bet_Day BETWEEN date_begin AND date_end
        GROUP BY C.employeecode,
                 C.enterprisecode,
                 C.brandcode) AS GG
        ON FF.employeecode = GG.employeecode
        AND FF.enterprisecode = GG.enterprisecode
      INNER JOIN enterprise_employee_type AS TT
        ON FF.employeetypecode = TT.employeetypecode
    UNION ALL
    SELECT
      '直线会员' AS loginaccount,
      COUNT(1) AS num,
      employeecode AS employeecode,
      '会员' AS employeetype,
      SUM(GG.Bet_Money) AS game_betting_amount,
      SUM(GG.net_money + (GG.Valid_Money * GG.bonus)) AS lose_win_amount,
      SUM(GG.Valid_Money * GG.bonus) AS bonus

    FROM (SELECT
        A.employeecode,
        A.enterprisecode,
        A.brandcode,
        A.loginaccount,
        A.employeetypecode,
        SUM(dividend) AS dividend,
        SUM(share) AS hare
      FROM enterprise_employee A
      WHERE A.parentemployeecode = employeecode
      AND A.employeetypecode = 'T003'
      GROUP BY A.loginaccount,
               A.employeecode,
               A.employeetypecode) FF
      INNER JOIN (SELECT
          C.employeecode,
          C.enterprisecode,
          C.brandcode,
          SUM(C.Bet_Money) AS Bet_Money,
          SUM(C.net_money) AS net_money,
          SUM(C.Valid_Money) AS Valid_Money,
          SUM(D.bonus) AS bonus
        FROM betting_all_day AS C
          INNER JOIN employee_gamecataloy_bonus AS D
            ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
            AND C.Bet_Day BETWEEN date_begin AND date_end
        GROUP BY C.employeecode,
                 C.enterprisecode,
                 C.brandcode) AS GG
        ON FF.employeecode = GG.employeecode
        AND FF.enterprisecode = GG.enterprisecode) AS HH;

  SELECT
    FF.loginaccount,
    FF.num,
    FF.employeecode,
    TT.employeetype employeetypename,
    GG.Bet_Money AS game_betting_amount,
    GG.net_money + (GG.Valid_Money * GG.bonus) AS lose_win_amount,
    GG.Valid_Money * GG.bonus AS bonus

  FROM (SELECT
      A.employeecode,
      A.enterprisecode,
      A.brandcode,
      A.loginaccount,
      A.employeetypecode,
      ufn_down_recursion_team_of_agent_count(A.employeecode) AS num,
      SUM(dividend) AS dividend,
      SUM(share) AS hare
    FROM enterprise_employee A
    WHERE A.parentemployeecode = employeecode
    AND A.employeetypecode = 'T004'
    GROUP BY A.loginaccount,
             A.employeecode,
             A.employeetypecode) FF
    INNER JOIN (SELECT
        C.employeecode,
        C.enterprisecode,
        C.brandcode,
        SUM(C.Bet_Money) AS Bet_Money,
        SUM(C.net_money) AS net_money,
        SUM(C.Valid_Money) AS Valid_Money,
        SUM(D.bonus) AS bonus
      FROM betting_all_day AS C
        INNER JOIN employee_gamecataloy_bonus AS D
          ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
          AND C.Bet_Day BETWEEN date_begin AND date_end
      GROUP BY C.employeecode,
               C.enterprisecode,
               C.brandcode) AS GG
      ON FF.employeecode = GG.employeecode
      AND FF.enterprisecode = GG.enterprisecode
    INNER JOIN enterprise_employee_type AS TT
      ON FF.employeetypecode = TT.employeetypecode
  UNION ALL
  SELECT
    loginaccount,
    num,
    employeecode,
    employeetype,
    game_betting_amount,
    lose_win_amount,
    bonus
  FROM (SELECT
      '直线会员' AS loginaccount,
      COUNT(1) AS num,
      employeecode AS employeecode,
      '会员' AS employeetype,
      SUM(GG.Bet_Money) AS game_betting_amount,
      SUM(GG.net_money + (GG.Valid_Money * GG.bonus)) AS lose_win_amount,
      SUM(GG.Valid_Money * GG.bonus) AS bonus

    FROM (SELECT
        A.employeecode,
        A.enterprisecode,
        A.brandcode,
        A.loginaccount,
        A.employeetypecode,
        SUM(dividend) AS dividend,
        SUM(share) AS hare
      FROM enterprise_employee A
      WHERE A.parentemployeecode = employeecode
      AND A.employeetypecode = 'T003'
      GROUP BY A.loginaccount,
               A.employeecode,
               A.employeetypecode) FF
      INNER JOIN (SELECT
          C.employeecode,
          C.enterprisecode,
          C.brandcode,
          C.Game_Platform,
          C.Game_Big_Type,
          SUM(C.Bet_Money) AS Bet_Money,
          SUM(C.net_money) AS net_money,
          SUM(C.Valid_Money) AS Valid_Money,
          SUM(D.bonus) AS bonus
        FROM betting_all_day AS C
          INNER JOIN employee_gamecataloy_bonus AS D
            ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
            AND C.Bet_Day BETWEEN date_begin AND date_end
        GROUP BY C.employeecode,
                 C.enterprisecode,
                 C.brandcode,
                 C.Game_Platform,
                 C.Game_Big_Type) AS GG
        ON FF.employeecode = GG.employeecode
        AND FF.enterprisecode = GG.enterprisecode) AS TT
  WHERE num > 0 LIMIT var_start, var_end;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Linear_income_statement_Member
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Linear_income_statement_Member`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_Linear_income_statement_Member`(IN employee_id varchar(10),
IN start_date date,
IN date_end date,
IN startd int,
IN endsd int)
BEGIN
  /*
 直线会员报表显示
*/
  IF startd = 0 THEN
    SET startd = 0;
  END IF;
  IF endsd = 0 THEN
    SET endsd = 10;
  END IF;

  SELECT
    AA.employeecode,
    AA.loginaccount,
    COUNT(1) AS num,
    GG.Bet_Money,
    GG.Net_Money + GG.Valid_Money * GG.bonus + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend + ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS MONEY,
    GG.Valid_Money * GG.bonus AS wash,
    (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend AS Dividend,
    ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS Into_account
  FROM enterprise_employee AS AA
    INNER JOIN (SELECT
        BB.employeecode,
        BB.parentemployeecode,
        BB.enterprisecode,
        BB.Game_Platform,
        BB.Game_Type,
        SUM(BB.Bet_Money) AS Bet_Money,
        SUM(BB.Net_Money) AS Net_Money,
        SUM(BB.Valid_Money) AS Valid_Money,
        SUM(DD.bonus) AS bonus
      FROM betting_all_day BB
        INNER JOIN employee_gamecataloy_bonus AS DD
          ON BB.employeecode = DD.employeecode AND BB.Game_Platform = DD.gametype AND BB.Game_Big_Type = DD.categorytype
      GROUP BY BB.employeecode,
               BB.parentemployeecode,
               BB.enterprisecode,
               BB.Game_Platform,
               BB.Game_Type) AS GG
      ON AA.employeecode = GG.employeecode AND AA.parentemployeecode = GG.parentemployeecode AND AA.enterprisecode = GG.enterprisecode
  WHERE AA.parentemployeecode = employee_id
  AND AA.employeetypecode = 'T003'
  AND DATE_FORMAT(AA.logindatetime, '%Y-%m-%d') BETWEEN start_date AND date_end
  GROUP BY AA.employeecode,
           AA.loginaccount LIMIT startd, endsd;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_login_desc
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_login_desc`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_login_desc`(IN employeecode varchar(20), IN start_end date, IN date_end date)
BEGIN
  /*
  取款排名
*/
  SELECT
    GG.employeecode,
    GG.loginaccount,
    IFNULL(SUM(DD.orderamount), 0) AS orderamount,
    start_end AS start_end,
    date_end AS date_end
  FROM (SELECT
      employeecode,
      loginaccount
    FROM enterprise_employee AA
    WHERE parentemployeecode = employeecode) AS GG
    LEFT JOIN deposit_withdraw_order AS DD
      ON GG.employeecode = DD.employeecode
      AND DD.orderdate BETWEEN start_end AND date_end
      AND DD.ordertype = 2
  GROUP BY GG.employeecode,
           GG.loginaccount
  ORDER BY orderamount DESC LIMIT 0, 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_login_ranking
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_login_ranking`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_login_ranking`(IN employeecode varchar(20), IN start_end varchar(20), IN date_end varchar(20))
BEGIN
  /*
	存款排名
*/
  SELECT
    GG.employeecode,
    GG.loginaccount,
    IFNULL(SUM(DD.orderamount), 0) AS orderamount,
    start_end AS start_end,
    date_end AS date_end
  FROM (SELECT
      employeecode,
      loginaccount
    FROM enterprise_employee AA
    WHERE parentemployeecode = employeecode) AS GG
    LEFT JOIN deposit_withdraw_order AS DD
      ON GG.employeecode = DD.employeecode
      AND DD.orderdate BETWEEN start_end AND date_end
      AND DD.ordertype = 1
  GROUP BY GG.employeecode,
           GG.loginaccount
  ORDER BY orderamount DESC LIMIT 0, 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_member_lose_win_detail
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_member_lose_win_detail`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_member_lose_win_detail`(IN employee_id varchar(10),
IN start_date date,
IN date_end date,
IN startd int,
IN endsd int,
OUT param1 int)
BEGIN
  /*
 二次查询客户输赢统计----直线会员报表显示
*/
  IF startd = 0 THEN
    SET startd = 0;
  END IF;
  IF endsd = 0 THEN
    SET endsd = 10;
  END IF;
  IF ISNULL(start_date) = 1 AND ISNULL(date_end) = 1 THEN
    SET start_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;
  SELECT
    COUNT(1) INTO param1
  FROM (SELECT
      AA.employeecode,
      AA.loginaccount,
      COUNT(1) AS num,
      CONCAT(CC.employeetype, '_nodown') AS employeetypename,
      GG.Bet_Money AS game_betting_amount,
      GG.Net_Money AS lose_win_amount,
      GG.Net_Money + GG.Valid_Money * GG.bonus + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend + ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS user_lose_win_amount,
      GG.Valid_Money * GG.bonus AS bonus,
      (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend AS Dividend,
      ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS share
    FROM enterprise_employee AS AA
      INNER JOIN (SELECT
          BB.employeecode,
          BB.parentemployeecode,
          BB.enterprisecode,
          BB.Game_Platform,
          BB.Game_Type,
          SUM(BB.Bet_Money) AS Bet_Money,
          SUM(BB.Net_Money) AS Net_Money,
          SUM(BB.Valid_Money) AS Valid_Money,
          SUM(DD.bonus) AS bonus
        FROM betting_all_day BB
          INNER JOIN employee_gamecataloy_bonus AS DD
            ON BB.employeecode = DD.employeecode AND BB.Game_Platform = DD.gametype AND BB.Game_Big_Type = DD.categorytype
            AND DATE_FORMAT(BB.Bet_Day, '%Y-%m-%d') BETWEEN start_date AND date_end
        GROUP BY BB.employeecode,
                 BB.parentemployeecode,
                 BB.enterprisecode,
                 BB.Game_Platform,
                 BB.Game_Type) AS GG
        ON AA.employeecode = GG.employeecode AND AA.parentemployeecode = GG.parentemployeecode AND AA.enterprisecode = GG.enterprisecode
      INNER JOIN enterprise_employee_type AS CC
        ON AA.employeetypecode = CC.employeetypecode
    WHERE AA.parentemployeecode = employee_id
    GROUP BY AA.employeecode,
             AA.loginaccount) AS HH;

  SELECT
    AA.employeecode,
    AA.loginaccount,
    COUNT(1) AS num,
    CONCAT(CC.employeetype, '_nodown') AS employeetypename,
    GG.Bet_Money AS game_betting_amount,
    GG.Net_Money AS lose_win_amount,
    GG.Net_Money + GG.Valid_Money * GG.bonus + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend + ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS user_lose_win_amount,
    GG.Valid_Money * GG.bonus AS bonus,
    (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend AS Dividend,
    ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS share
  FROM enterprise_employee AS AA
    INNER JOIN (SELECT
        BB.employeecode,
        BB.parentemployeecode,
        BB.enterprisecode,
        BB.Game_Platform,
        BB.Game_Type,
        SUM(BB.Bet_Money) AS Bet_Money,
        SUM(BB.Net_Money) AS Net_Money,
        SUM(BB.Valid_Money) AS Valid_Money,
        SUM(DD.bonus) AS bonus
      FROM betting_all_day BB
        INNER JOIN employee_gamecataloy_bonus AS DD
          ON BB.employeecode = DD.employeecode AND BB.Game_Platform = DD.gametype AND BB.Game_Big_Type = DD.categorytype
          AND DATE_FORMAT(BB.Bet_Day, '%Y-%m-%d') BETWEEN start_date AND date_end
      GROUP BY BB.employeecode,
               BB.parentemployeecode,
               BB.enterprisecode,
               BB.Game_Platform,
               BB.Game_Type) AS GG
      ON AA.employeecode = GG.employeecode AND AA.parentemployeecode = GG.parentemployeecode AND AA.enterprisecode = GG.enterprisecode
    INNER JOIN enterprise_employee_type AS CC
      ON AA.employeetypecode = CC.employeetypecode
  WHERE AA.parentemployeecode = employee_id
  AND AA.employeetypecode = 'T003'

  GROUP BY AA.employeecode,
           AA.loginaccount LIMIT startd, endsd;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_pay_time
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_pay_time`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_pay_time`(IN pay_code varchar(10),
IN start_end date,
IN date_end date)
BEGIN
  /*
业务办理统计
*/
  DECLARE rownum int DEFAULT 0;

  IF ISNULL(start_end) = 1 AND ISNULL(date_end) = 1 THEN
    SET rownum = 1;
  END IF;
  SELECT
    '3-分钟' AS time,
    COUNT(1) AS mum,
    start_end AS start_date,
    date_end AS end_date
  FROM (SELECT
      (handleovertime - orderdate) time,
      ordernumber
    FROM deposit_withdraw_order
    WHERE enterprisecode = pay_code
    AND orderstatus = 2
    AND ((rownum = 1) OR (rownum = 0 AND orderdate BETWEEN start_end AND date_end))) AS A
  WHERE A.time BETWEEN '0' AND '300'
  UNION ALL
  SELECT
    '5-分钟' AS time,
    COUNT(1) AS mum,
    start_end AS start_date,
    date_end AS end_date
  FROM (SELECT
      (handleovertime - orderdate) time,
      ordernumber
    FROM deposit_withdraw_order
    WHERE enterprisecode = pay_code
    AND orderstatus = 2
    AND ((rownum = 1) OR (rownum = 0 AND orderdate BETWEEN start_end AND date_end))) AS A
  WHERE A.time BETWEEN '300' AND '500'
  UNION ALL
  SELECT
    '10-分钟' AS time,
    COUNT(1) AS mum,
    start_end AS start_date,
    date_end AS end_date
  FROM (SELECT
      (handleovertime - orderdate) time,
      ordernumber
    FROM deposit_withdraw_order
    WHERE enterprisecode = pay_code
    AND orderstatus = 2
    AND ((rownum = 1) OR (rownum = 0 AND orderdate BETWEEN start_end AND date_end))) AS A
  WHERE A.time BETWEEN '500' AND '1000'
  UNION ALL
  SELECT
    '30-分钟' AS time,
    COUNT(1) AS mum,
    start_end AS start_date,
    date_end AS end_date
  FROM (SELECT
      (handleovertime - orderdate) time,
      ordernumber
    FROM deposit_withdraw_order
    WHERE enterprisecode = pay_code
    AND orderstatus = 2
    AND ((rownum = 1) OR (rownum = 0 AND orderdate BETWEEN start_end AND date_end))) AS A
  WHERE A.time BETWEEN '1000' AND '3000'
  UNION ALL
  SELECT
    '60-分钟' AS time,
    COUNT(1) AS mum,
    start_end AS start_date,
    date_end AS end_date
  FROM (SELECT
      (handleovertime - orderdate) time,
      ordernumber
    FROM deposit_withdraw_order
    WHERE enterprisecode = pay_code
    AND orderstatus = 2
    AND ((rownum = 1) OR (rownum = 0 AND orderdate BETWEEN start_end AND date_end))) AS A
  WHERE A.time BETWEEN '3000' AND '10000'
  UNION ALL
  SELECT
    '60-分钟以上' AS time,
    COUNT(1) AS mum,
    start_end AS start_date,
    date_end AS end_date
  FROM (SELECT
      (handleovertime - orderdate) time,
      ordernumber
    FROM deposit_withdraw_order
    WHERE enterprisecode = pay_code
    AND orderstatus = 2
    AND ((rownum = 1) OR (rownum = 0 AND orderdate BETWEEN start_end AND date_end))) AS A
  WHERE A.time > '10000';
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_report_by_agent_employeecode
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_report_by_agent_employeecode`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_report_by_agent_employeecode`(IN `in_parentemployeecode` char(8),IN `in_begindate` datetime,IN `in_enddate` datetime,OUT `but_money` decimal(14,2),OUT `net_money` decimal(14,2),OUT `valid_money` decimal(14,2),OUT `rebates_cash` decimal(14,2) , OUT `countMember` INTEGER,  OUT `countAgent` INTEGER, OUT `countEmployee` INTEGER, OUT `activity_money` decimal(14,2), OUT depositMoney decimal(14,2) , OUT withdrawMoney decimal(14,2) )
BEGIN
	/****************根据代理编码统计时间段内的该代理下的整个团队的汇总数据****************/
	
	DECLARE l_parentemployeecode longtext;
  	DECLARE lc_parentemployeecode longtext;
	
	DECLARE temp_but_money decimal(14,2) default 0;
 	DECLARE temp_net_money decimal(14,2) default 0;
  	DECLARE temp_valid_money decimal(14,2) default 0;
  	DECLARE temp_rebates_cash decimal(14,2) default 0;


	SET but_money = 0 ;
        SET net_money = 0 ;
        SET valid_money = 0 ;
        SET rebates_cash = 0 ;

  	SET l_parentemployeecode = in_parentemployeecode;
  	SET lc_parentemployeecode = in_parentemployeecode;

	LABLE_LP:
	LOOP
  		SELECT
    			GROUP_CONCAT(employeecode SEPARATOR ',') INTO lc_parentemployeecode
  			FROM enterprise_employee
  		WHERE FIND_IN_SET(parentemployeecode, lc_parentemployeecode) > 0 AND employeetypecode != 'T003';
  	IF lc_parentemployeecode IS NULL OR lc_parentemployeecode = 'NULL' THEN
    		LEAVE LABLE_LP;
  	END IF;
  	SET l_parentemployeecode = CONCAT_WS(',', l_parentemployeecode, lc_parentemployeecode);
	END LOOP LABLE_LP;
        
        /********AG*****/
	select ifnull(sum(hh.bet_Amount),0) , ifnull(sum(hh.net_Amount),0), ifnull(sum(hh.valid_Bet_Amount),0), ifnull(sum(hh.valid_Bet_Amount * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_ag hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bet_Time >= in_begindate and hh.bet_Time <= in_enddate) and bb.gametype='TAGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********BBIN*****/
	select ifnull(sum(hh.bbin_Bet_Amount),0) , ifnull(sum(hh.bbin_Payoff),0), ifnull(sum(hh.bbin_Commissionable),0), ifnull(sum(hh.bbin_Commissionable * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_bbin hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	) and (hh.bbin_Wagers_Date >= in_begindate and hh.bbin_Wagers_Date <= in_enddate) and bb.gametype='BBINGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
	/********NHQ*****/
	select ifnull(sum(hh.Betting_Credits),0) , ifnull(sum(hh.Winning_Credits),0), ifnull(sum(hh.Wash_Code_Credits),0), ifnull(sum(hh.Wash_Code_Credits * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_nhq hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.Betting_Date >= in_begindate and hh.Betting_Date <= in_enddate) and bb.gametype='NHQGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
	
	/********OG_AG*****/
	select ifnull(sum(hh.aoi_Betting_Amount),0) , ifnull(sum(hh.aoi_Win_Lose_Amount),0), ifnull(sum(hh.aoi_Valid_Amount),0), ifnull(sum(hh.aoi_Valid_Amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_og_ag hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.aoi_Add_Time >= in_begindate and hh.aoi_Add_Time <= in_enddate) and bb.gametype='AGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********OG_IBC*****/
	select ifnull(sum(hh.ibc_tzmoney),0) , ifnull(sum(if(hh.ibc_lose>0, 0-hh.ibc_lose, hh.ibc_win)),0), ifnull(sum(hh.ibc_tzmoney),0), ifnull(sum(hh.ibc_tzmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_og_ibc hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.ibc_balltime >= in_begindate and hh.ibc_balltime <= in_enddate) and bb.gametype='IBCGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********OG_OG*****/
	select ifnull(sum(hh.aoi_Betting_Amount),0) , ifnull(sum(hh.aoi_Win_Lose_Amount),0), ifnull(sum(hh.aoi_Valid_Amount),0), ifnull(sum(hh.aoi_Valid_Amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_og_og hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.aoi_Add_Time >= in_begindate and hh.aoi_Add_Time <= in_enddate) and bb.gametype='OGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;

                
	/********PT*****/
	select ifnull(sum(hh.pt_bet),0) , ifnull(sum(hh.pt_win),0), ifnull(sum(hh.pt_bet),0), ifnull(sum(hh.pt_bet * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_pt hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.pt_gamedate >= in_begindate and hh.pt_gamedate <= in_enddate) and bb.gametype='PTGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********XCP*****/
	select ifnull(sum(hh.xcp_totalprice),0) , ifnull(sum(hh.xcp_prize-xcp_totalprice),0), ifnull(sum(hh.xcp_totalprice),0), ifnull(sum(hh.xcp_totalprice * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_xcp hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.xcp_writetime >= in_begindate and hh.xcp_writetime <= in_enddate) and bb.gametype='XCPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        /********KR_AV*****/
	select ifnull(sum(hh.amount),0) , ifnull(sum(hh.amount2),0), ifnull(sum(hh.amount),0), ifnull(sum(hh.amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_kr_av hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.time >= in_begindate and hh.time <= in_enddate) and bb.gametype='AVGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********SA*****/
	select ifnull(sum(hh.betamount),0) , ifnull(sum(hh.resultamount),0), ifnull(sum(hh.validbet),0), ifnull(sum(hh.validbet * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_sa hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='SAGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********YG_AG*****/
	select ifnull(sum(hh.money),0) , ifnull(sum(hh.result),0), ifnull(sum(hh.valid_money),0), ifnull(sum(hh.valid_money * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_yg_ag hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.time >= in_begindate and hh.time <= in_enddate) and bb.gametype='YAGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        /********ZJ*****/
	select ifnull(sum(hh.stakeamount),0) , ifnull(sum(hh.winloss),0), ifnull(sum(hh.validstake),0), ifnull(sum(hh.validstake * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_zj hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='ZJGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********TTG*****/
	select ifnull(sum(hh.amount),0) , ifnull(sum(hh.net_money),0), ifnull(sum(hh.amount),0), ifnull(sum(hh.amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_ttg hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='TTGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********MG*****/
	select ifnull(sum(hh.mg_amount),0) , ifnull(sum(hh.net_money),0), ifnull(sum(hh.mg_amount),0), ifnull(sum(hh.mg_amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_mg hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='MGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        /********PNG*****/
	select ifnull(sum(hh.bet_Amount),0) , ifnull(sum(hh.net_Amount),0), ifnull(sum(hh.valid_Bet_Amount),0), ifnull(sum(hh.valid_Bet_Amount * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_png hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bet_Time >= in_begindate and hh.bet_Time <= in_enddate) and bb.gametype='PNGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        /********QP*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_qp hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='QPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********GG*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_gg hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='GGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********SGS*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_sgs hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='SGSGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        
        /********M88*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_m88 hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='M88Game' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********haba*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hab hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='HABGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********WIN88*****/
	select ifnull(sum(hh.pt_bet),0) , ifnull(sum(hh.pt_win-hh.pt_bet),0), ifnull(sum(hh.pt_bet),0), ifnull(sum(hh.pt_bet * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_win88 hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.pt_gamedate >= in_begindate and hh.pt_gamedate <= in_enddate) and bb.gametype='W88Game' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********TGP*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_tgp hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='TGPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********QT*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_qt hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='QTGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********GB*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_gb hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='GBGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********EBET*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.validbet),0), ifnull(sum(hh.validbet * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_ebet hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='EBETGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********EIBC*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus ),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_eibc hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='eIBCGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        
        /********统计会员及代理整个团队数量*****/
        
        /***直线会员数***/
	SELECT count(1) into countMember FROM enterprise_employee WHERE parentemployeecode = in_parentemployeecode and datastatus=1 and employeetypecode='T003';
	/***所有代理数 注意：返回数量包含了当前代理用户，所以需要减去1***/
        SELECT if(count(1)=0,0,count(1)-1) into countAgent FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode = 'T004';
         /***下级员工数***/
	SELECT count(1) into countEmployee FROM enterprise_employee WHERE parentemployeecode = in_parentemployeecode and datastatus=1 and employeetypecode='T002';
	
	/********统计整个团队的涉及的活动金额*****/
	select sum(moneychangeamount) into activity_money from employee_money_change 
                where parentemployeecode in (SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003')
                and (moneychangedate >= in_begindate and moneychangedate <= in_enddate) 
                and moneychangetypecode='D6B0C11A0AC44EBBB1538BE69B004811';
        
        /********统计总存款*****/
        select IFNULL(sum(orderamount),0) into depositMoney from deposit_withdraw_order where orderstatus='2' and ordertype=1 and 
                parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
  	) and (orderdate >= in_begindate and orderdate <= in_enddate) ; 
  	
  	/********统计总取款*****/
  	select IFNULL(sum(orderamount),0) into withdrawMoney from deposit_withdraw_order where orderstatus='2' and ordertype=2 and 
                parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
  	) and (orderdate >= in_begindate and orderdate <= in_enddate) ;         

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_report_by_agent_employeecode_new
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_report_by_agent_employeecode_new`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_report_by_agent_employeecode_new`(
IN `in_parentemployeecode` char(8),
IN `in_begindate` datetime,
IN `in_enddate` datetime,
OUT `but_money` decimal(14,2),
OUT `net_money` decimal(14,2),
OUT `valid_money` decimal(14,2),
OUT `rebates_cash` decimal(14,2) , 
OUT `countMember` INTEGER,  
OUT `countAgent` INTEGER, 
OUT `countEmployee` INTEGER, 
OUT `activity_money` decimal(14,2), 
OUT depositMoney decimal(14,2) , 
OUT withdrawMoney decimal(14,2) 
)
BEGIN
  
  /****************根据代理编码统计时间段内的该代理下的整个团队的汇总数据****************/
	
	DECLARE l_parentemployeecode longtext;
  	DECLARE lc_parentemployeecode longtext;
	
	
	SET but_money = 0 ;
        SET net_money = 0 ;
        SET valid_money = 0 ;
        SET rebates_cash = 0 ;

  	SET l_parentemployeecode = in_parentemployeecode;
  	SET lc_parentemployeecode = in_parentemployeecode;

	LABLE_LP:
	LOOP
  		SELECT
    			GROUP_CONCAT(employeecode SEPARATOR ',') INTO lc_parentemployeecode
  			FROM enterprise_employee
  		WHERE FIND_IN_SET(parentemployeecode, lc_parentemployeecode) > 0 AND employeetypecode != 'T003';
  	IF lc_parentemployeecode IS NULL OR lc_parentemployeecode = 'NULL' THEN
    		LEAVE LABLE_LP;
  	END IF;
  	SET l_parentemployeecode = CONCAT_WS(',', l_parentemployeecode, lc_parentemployeecode);
	END LOOP LABLE_LP;
        
        
        
        /********统计汇总表的数据*****/
        select ifnull(sum(hh.Bet_Money),0) , ifnull(sum(hh.Net_Money),0), ifnull(sum(hh.Valid_Money),0)
	into but_money,net_money,valid_money
	from betting_all_day hh where hh.parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (date(hh.Bet_Day) >= date(in_begindate) and date(hh.Bet_Day) <= date(in_enddate)) ;
	
        
       

        
        /********统计会员及代理整个团队数量*****/
        
        /***直线会员数***/
	SELECT count(1) into countMember FROM enterprise_employee WHERE parentemployeecode = in_parentemployeecode and datastatus=1 and employeetypecode='T003';
	/***所有代理数 注意：返回数量包含了当前代理用户，所以需要减去1***/
        SELECT if(count(1)=0,0,count(1)-1) into countAgent FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode = 'T004';
         /***下级员工数***/
	SELECT count(1) into countEmployee FROM enterprise_employee WHERE parentemployeecode = in_parentemployeecode and datastatus=1 and employeetypecode='T002';
	
	/********统计整个团队的涉及的活动金额*****/
	select sum(moneychangeamount) into activity_money from employee_money_change 
                where parentemployeecode in (SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003')
                and (moneychangedate >= in_begindate and moneychangedate <= in_enddate) 
                and moneychangetypecode='D6B0C11A0AC44EBBB1538BE69B004811';
        
        
		
		
        /********统计整个团队的涉及的实际洗码金额
        //洗码日结("B1FF4C4ADC9C423C8D0344DDFD7DC279","洗码日结"),
        //洗码周结("6B06E77AA855454EB5ADF60B6CC37787","洗码周结"),
        //周结校验补发("56F82CC5B5DC4FFABBFD62F82CACA891","周结校验补发"), *****/       
	select sum(moneychangeamount) into rebates_cash from employee_money_change 
                where parentemployeecode in (SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003')
                and (moneychangedate >= in_begindate and moneychangedate <= in_enddate) 
                and moneychangetypecode in('B1FF4C4ADC9C423C8D0344DDFD7DC279','6B06E77AA855454EB5ADF60B6CC37787','56F82CC5B5DC4FFABBFD62F82CACA891');
                
                        
        
        /********统计总存款*****/
        select IFNULL(sum(orderamount),0) into depositMoney from deposit_withdraw_order where orderstatus='2' and ordertype=1 and 
                parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
  	) and (orderdate >= in_begindate and orderdate <= in_enddate) ; 
  	
  	/********统计总取款*****/
  	select IFNULL(sum(orderamount),0) into withdrawMoney from deposit_withdraw_order where orderstatus='2' and ordertype=2 and 
                parentemployeecode in (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
  	) and (orderdate >= in_begindate and orderdate <= in_enddate) ; 
  
  
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_report_by_member_employeecode
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_report_by_member_employeecode`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_report_by_member_employeecode`(IN `in_parentemployeecode` char(8),IN `in_begindate` datetime,IN `in_enddate` datetime,OUT `but_money` decimal(14,2),OUT `net_money` decimal(14,2),OUT `valid_money` decimal(14,2),OUT `rebates_cash` decimal(14,2), OUT `countMember` INTEGER, OUT `activity_money` decimal(14,2) ,   OUT depositMoney decimal(14,2) , OUT withdrawMoney decimal(14,2) )
BEGIN
	
	/****************?????????????????????????****************/

	
	DECLARE temp_but_money decimal(14,2) default 0;
 	DECLARE temp_net_money decimal(14,2) default 0;
  	DECLARE temp_valid_money decimal(14,2) default 0;
  	DECLARE temp_rebates_cash decimal(14,2) default 0;


	SET but_money = 0 ;
        SET net_money = 0 ;
        SET valid_money = 0 ;
        SET rebates_cash = 0 ;


	/********AG*****/
	select ifnull(sum(hh.bet_Amount),0) , ifnull(sum(hh.net_Amount),0), ifnull(sum(hh.valid_Bet_Amount),0), ifnull(sum(hh.valid_Bet_Amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_ag hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.bet_Time >= in_begindate and hh.bet_Time <= in_enddate) and bb.gametype='TAGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********BBIN*****/
	select ifnull(sum(hh.bbin_Bet_Amount),0) , ifnull(sum(hh.bbin_Payoff-bbin_Bet_Amount),0), ifnull(sum(hh.bbin_Commissionable),0), ifnull(sum(hh.bbin_Commissionable * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_bbin hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	) and (hh.bbin_Wagers_Date >= in_begindate and hh.bbin_Wagers_Date <= in_enddate) and bb.gametype='BBINGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
	/********NHQ*****/
	select ifnull(sum(hh.Betting_Credits),0) , ifnull(sum(hh.Winning_Credits),0), ifnull(sum(hh.Wash_Code_Credits),0), ifnull(sum(hh.Wash_Code_Credits * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_nhq hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.Betting_Date >= in_begindate and hh.Betting_Date <= in_enddate) and bb.gametype='NHQGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
	
	/********OG_AG*****/
	select ifnull(sum(hh.aoi_Betting_Amount),0) , ifnull(sum(hh.aoi_Win_Lose_Amount),0), ifnull(sum(hh.aoi_Valid_Amount),0), ifnull(sum(hh.aoi_Valid_Amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_og_ag hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.aoi_Add_Time >= in_begindate and hh.aoi_Add_Time <= in_enddate) and bb.gametype='AGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********OG_IBC*****/
	select ifnull(sum(hh.ibc_tzmoney),0) , ifnull(sum(if(hh.ibc_lose>0, 0-hh.ibc_lose, hh.ibc_win)),0), ifnull(sum(hh.ibc_tzmoney),0), ifnull(sum(hh.ibc_tzmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_og_ibc hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.ibc_balltime >= in_begindate and hh.ibc_balltime <= in_enddate) and bb.gametype='IBCGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********OG_OG*****/
	select ifnull(sum(hh.aoi_Betting_Amount),0) , ifnull(sum(hh.aoi_Win_Lose_Amount),0), ifnull(sum(hh.aoi_Valid_Amount),0), ifnull(sum(hh.aoi_Valid_Amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_og_og hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.aoi_Add_Time >= in_begindate and hh.aoi_Add_Time <= in_enddate) and bb.gametype='OGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;

                
	/********PT*****/
	select ifnull(sum(hh.pt_bet),0) , ifnull(sum(hh.pt_win-hh.pt_bet),0), ifnull(sum(hh.pt_bet),0), ifnull(sum(hh.pt_bet * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_pt hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.pt_gamedate >= in_begindate and hh.pt_gamedate <= in_enddate) and bb.gametype='PTGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********XCP*****/
	select ifnull(sum(hh.xcp_totalprice),0) , ifnull(sum(hh.xcp_prize-xcp_totalprice),0), ifnull(sum(hh.xcp_totalprice),0), ifnull(sum(hh.xcp_totalprice * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_xcp hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.xcp_writetime >= in_begindate and hh.xcp_writetime <= in_enddate) and bb.gametype='XCPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        /********KR_AV*****/
	select ifnull(sum(hh.amount),0) , ifnull(sum(hh.amount2),0), ifnull(sum(hh.amount),0), ifnull(sum(hh.amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_kr_av hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.time >= in_begindate and hh.time <= in_enddate) and bb.gametype='AVGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********SA*****/
	select ifnull(sum(hh.betamount),0) , ifnull(sum(hh.resultamount),0), ifnull(sum(hh.betamount),0), ifnull(sum(hh.betamount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_sa hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='SAGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********YG_AG*****/
	select ifnull(sum(hh.money),0) , ifnull(sum(hh.result),0), ifnull(sum(hh.valid_money),0), ifnull(sum(hh.valid_money * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_yg_ag hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.time >= in_begindate and hh.time <= in_enddate) and bb.gametype='YAGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        /********ZJ*****/
	select ifnull(sum(hh.stakeamount),0) , ifnull(sum(hh.winloss),0), ifnull(sum(hh.validstake),0), ifnull(sum(hh.validstake * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_zj hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='ZJGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;

	/********TTG*****/
        select ifnull(sum(hh.amount),0) , ifnull(sum(hh.net_money),0), ifnull(sum(hh.amount),0), ifnull(sum(hh.amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_ttg hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='TTGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;

	/********MG***** 2017-05-03 测试出现bug，从生产环境拷贝过来替换
	select ifnull(sum(hh.mg_amount),0) , ifnull(sum(hh.net_money),0), ifnull(sum(hh.mg_amount),0), ifnull(sum(hh.mg_amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_mg hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		SELECT ee.employeecode FROM enterprise_employee ee WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003'
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='MGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;*/

	select ifnull(sum(hh.mg_amount),0) , ifnull(sum(hh.net_money),0), ifnull(sum(hh.mg_amount),0), ifnull(sum(hh.mg_amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_mg hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='MGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;


	/********PNG*****/
	select ifnull(sum(hh.bet_Amount),0) , ifnull(sum(hh.net_Amount),0), ifnull(sum(hh.valid_Bet_Amount),0), ifnull(sum(hh.valid_Bet_Amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_png hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.bet_Time >= in_begindate and hh.bet_Time <= in_enddate) and bb.gametype='PNGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;


	/********QP*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_qp hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='QPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
	
	/********??????*****/
	select count(1) into countMember from enterprise_employee where parentemployeecode = in_parentemployeecode and datastatus=1 and employeetypecode='T003';
	
	/********??????????????*****/
	select sum(moneychangeamount) into activity_money from employee_money_change 
                where employeecode in ( SELECT ee.employeecode FROM enterprise_employee ee WHERE parentemployeecode =in_parentemployeecode AND ee.employeetypecode = 'T003' )
                and (moneychangedate >= in_begindate and moneychangedate <= in_enddate) 
                and moneychangetypecode='D6B0C11A0AC44EBBB1538BE69B004811';
                
        /********??????????*****/
        select IFNULL(sum(orderamount),0) into depositMoney from deposit_withdraw_order where orderstatus='2' and ordertype=1 and 
                parentemployeecode in (
  		in_parentemployeecode
  	) and (orderdate >= in_begindate and orderdate <= in_enddate) ; 
  	
  	/********??????????*****/
  	select IFNULL(sum(orderamount),0) into withdrawMoney from deposit_withdraw_order where orderstatus='2' and ordertype=2 and 
                parentemployeecode in (
  		in_parentemployeecode
  	) and (orderdate >= in_begindate and orderdate <= in_enddate) ;         
  

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_report_by_member_employeecode_new
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_report_by_member_employeecode_new`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_report_by_member_employeecode_new`(IN `in_parentemployeecode` char(8),IN `in_begindate` datetime,IN `in_enddate` datetime,OUT `but_money` decimal(14,2),OUT `net_money` decimal(14,2),OUT `valid_money` decimal(14,2),OUT `rebates_cash` decimal(14,2), OUT `countMember` INTEGER, OUT `activity_money` decimal(14,2) ,   OUT depositMoney decimal(14,2) , OUT withdrawMoney decimal(14,2) )
    READS SQL DATA
BEGIN
  
  
  /****************根据代理编码统计时间段内的该代理下直线会员汇总数据****************/

	

	SET but_money = 0 ;
        SET net_money = 0 ;
        SET valid_money = 0 ;
        SET rebates_cash = 0 ;


	
	 /********统计汇总表的数据*****/
        select ifnull(sum(hh.Bet_Money),0) , ifnull(sum(hh.Net_Money),0), ifnull(sum(hh.Valid_Money),0) 
	into but_money,net_money,valid_money
	from betting_all_day hh where  hh.parentemployeecode = (
  		in_parentemployeecode
	)  and (date(hh.Bet_Day) >= date(in_begindate) and date(hh.Bet_Day) <= date(in_enddate)) 
	;
        
        
        
	/********统计会员数量*****/
	select count(1) into countMember from enterprise_employee where parentemployeecode = in_parentemployeecode and datastatus=1 and employeetypecode='T003';
	
	/********统计直线会员的涉及的活动金额*****/
	select sum(moneychangeamount) into activity_money from employee_money_change 
                where employeecode in ( SELECT ee.employeecode FROM enterprise_employee ee WHERE parentemployeecode =in_parentemployeecode AND ee.employeetypecode = 'T003' )
                and (moneychangedate >= in_begindate and moneychangedate <= in_enddate) 
                and moneychangetypecode='D6B0C11A0AC44EBBB1538BE69B004811';
                
        /********统计整个团队的涉及的实际洗码金额
        //洗码日结("B1FF4C4ADC9C423C8D0344DDFD7DC279","洗码日结"),
        //洗码周结("6B06E77AA855454EB5ADF60B6CC37787","洗码周结"),
        //周结校验补发("56F82CC5B5DC4FFABBFD62F82CACA891","周结校验补发"), *****/       
	select sum(moneychangeamount) into rebates_cash from employee_money_change 
                where employeecode in ( SELECT ee.employeecode FROM enterprise_employee ee WHERE parentemployeecode =in_parentemployeecode AND ee.employeetypecode = 'T003' )
                and (moneychangedate >= in_begindate and moneychangedate <= in_enddate) 
                and moneychangetypecode in('B1FF4C4ADC9C423C8D0344DDFD7DC279','6B06E77AA855454EB5ADF60B6CC37787','56F82CC5B5DC4FFABBFD62F82CACA891');        
        
        
        /********统计总存款*****/
        select IFNULL(sum(orderamount),0) into depositMoney from deposit_withdraw_order where orderstatus='2' and ordertype=1 and 
                parentemployeecode = (
  		in_parentemployeecode
  	) and (orderdate >= in_begindate and orderdate <= in_enddate) ; 
  	
  	/********统计总取款*****/
  	select IFNULL(sum(orderamount),0) into withdrawMoney from deposit_withdraw_order where orderstatus='2' and ordertype=2 and 
                parentemployeecode = (
  		in_parentemployeecode
  	) and (orderdate >= in_begindate and orderdate <= in_enddate) ;               
  	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_report_by_member_employeecode_one
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_report_by_member_employeecode_one`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_report_by_member_employeecode_one`(IN `in_employeecode` char(8),IN `in_begindate` datetime,IN `in_enddate` datetime,OUT `but_money` decimal(14,2),OUT `net_money` decimal(14,2),OUT `valid_money` decimal(14,2),OUT `rebates_cash` decimal(14,2),OUT `activity_money` decimal(14,2) ,  OUT depositMoney decimal(14,2) , OUT withdrawMoney decimal(14,2) )
    READS SQL DATA
BEGIN
        
        
        /********统计会员时间段内的汇总数据*****/
  
        DECLARE temp_but_money decimal(14,2) default 0;
 	DECLARE temp_net_money decimal(14,2) default 0;
  	DECLARE temp_valid_money decimal(14,2) default 0;
  	DECLARE temp_rebates_cash decimal(14,2) default 0;


	SET but_money = 0 ;
        SET net_money = 0 ;
        SET valid_money = 0 ;
        SET rebates_cash = 0 ;
        SET activity_money = 0 ;


	/********AG*****/
	select ifnull(sum(hh.bet_Amount),0) , ifnull(sum(hh.net_Amount),0), ifnull(sum(hh.valid_Bet_Amount),0), ifnull(sum(hh.valid_Bet_Amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_ag hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bet_Time >= in_begindate and hh.bet_Time <= in_enddate) and bb.gametype='TAGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********BBIN*****/
	select ifnull(sum(hh.bbin_Bet_Amount),0) , ifnull(sum(hh.bbin_Payoff),0), ifnull(sum(hh.bbin_Commissionable),0), ifnull(sum(hh.bbin_Commissionable * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_bbin hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	) and (hh.bbin_Wagers_Date >= in_begindate and hh.bbin_Wagers_Date <= in_enddate) and bb.gametype='BBINGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
	/********NHQ*****/
	select ifnull(sum(hh.Betting_Credits),0) , ifnull(sum(hh.Winning_Credits),0), ifnull(sum(hh.Wash_Code_Credits),0), ifnull(sum(hh.Wash_Code_Credits * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_nhq hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.Betting_Date >= in_begindate and hh.Betting_Date <= in_enddate) and bb.gametype='NHQGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
	
	/********OG_AG*****/
	select ifnull(sum(hh.aoi_Betting_Amount),0) , ifnull(sum(hh.aoi_Win_Lose_Amount),0), ifnull(sum(hh.aoi_Valid_Amount),0), ifnull(sum(hh.aoi_Valid_Amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_og_ag hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.aoi_Add_Time >= in_begindate and hh.aoi_Add_Time <= in_enddate) and bb.gametype='AGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********OG_IBC*****/
	select ifnull(sum(hh.ibc_tzmoney),0) , ifnull(sum(if(hh.ibc_lose>0, 0-hh.ibc_lose, hh.ibc_win)),0), ifnull(sum(hh.ibc_tzmoney),0), ifnull(sum(hh.ibc_tzmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_og_ibc hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.ibc_balltime >= in_begindate and hh.ibc_balltime <= in_enddate) and bb.gametype='IBCGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********OG_OG*****/
	select ifnull(sum(hh.aoi_Betting_Amount),0) , ifnull(sum(hh.aoi_Win_Lose_Amount),0), ifnull(sum(hh.aoi_Valid_Amount),0), ifnull(sum(hh.aoi_Valid_Amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_og_og hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.aoi_Add_Time >= in_begindate and hh.aoi_Add_Time <= in_enddate) and bb.gametype='OGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;

                
	/********PT*****/
	select ifnull(sum(hh.pt_bet),0) , ifnull(sum(hh.pt_win),0), ifnull(sum(hh.pt_bet),0), ifnull(sum(hh.pt_bet * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_pt hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.pt_gamedate >= in_begindate and hh.pt_gamedate <= in_enddate) and bb.gametype='PTGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********XCP*****/
	select ifnull(sum(hh.xcp_totalprice),0) , ifnull(sum(hh.xcp_prize-xcp_totalprice),0), ifnull(sum(hh.xcp_totalprice),0), ifnull(sum(hh.xcp_totalprice * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_xcp hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.xcp_writetime >= in_begindate and hh.xcp_writetime <= in_enddate) and bb.gametype='XCPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        /********KR_AV*****/
	select ifnull(sum(hh.amount),0) , ifnull(sum(hh.amount2),0), ifnull(sum(hh.amount),0), ifnull(sum(hh.amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_kr_av hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.time >= in_begindate and hh.time <= in_enddate) and bb.gametype='AVGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********SA*****/
	select ifnull(sum(hh.betamount),0) , ifnull(sum(hh.resultamount),0), ifnull(sum(hh.validbet),0), ifnull(sum(hh.validbet * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_sa hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='SAGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********YG_AG*****/
	select ifnull(sum(hh.money),0) , ifnull(sum(hh.result),0), ifnull(sum(hh.valid_money),0), ifnull(sum(hh.valid_money * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_yg_ag hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.time >= in_begindate and hh.time <= in_enddate) and bb.gametype='YAGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        /********ZJ*****/
	select ifnull(sum(hh.stakeamount),0) , ifnull(sum(hh.winloss),0), ifnull(sum(hh.validstake),0), ifnull(sum(hh.validstake * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_zj hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='ZJGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********TTG*****/
        select ifnull(sum(hh.amount),0) , ifnull(sum(hh.net_money),0), ifnull(sum(hh.amount),0), ifnull(sum(hh.amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_ttg hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='TTGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;     
        
        /********MG*****/
	select ifnull(sum(hh.mg_amount),0) , ifnull(sum(hh.net_money),0), ifnull(sum(hh.mg_amount),0), ifnull(sum(hh.mg_amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_mg hh inner join employee_gamecataloy_bonus bb on  hh.parentemployeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='MGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash; 
        
        
        /********PNG*****/
	select ifnull(sum(hh.bet_Amount),0) , ifnull(sum(hh.net_Amount),0), ifnull(sum(hh.valid_Bet_Amount),0), ifnull(sum(hh.valid_Bet_Amount * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hq_png hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bet_Time >= in_begindate and hh.bet_Time <= in_enddate) and bb.gametype='PNGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        /********QP*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_qp hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='QPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********GG*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_gg hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='GGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********SGS*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_sgs hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='SGSGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        
        /********M88*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_m88 hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='M88Game' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********haba*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_hab hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='HABGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        
        /********WIN88*****/
	select ifnull(sum(hh.pt_bet),0) , ifnull(sum(hh.pt_win-hh.pt_bet),0), ifnull(sum(hh.pt_bet),0), ifnull(sum(hh.pt_bet * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_win88 hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.pt_gamedate >= in_begindate and hh.pt_gamedate <= in_enddate) and bb.gametype='W88Game' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;		
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********TGP*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_tgp hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='TGPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********QT*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_qt hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='QTGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********GB*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_gb hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='GBGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********EBET*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.validbet),0), ifnull(sum(hh.validbet * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_ebet hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='EBETGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
        
        /********EIBC*****/
	select ifnull(sum(hh.betmoney),0) , ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0), ifnull(sum(hh.betmoney * bb.bonus),0) 
	into temp_but_money,temp_net_money,temp_valid_money,temp_rebates_cash
	from betting_eibc hh inner join employee_gamecataloy_bonus bb on  hh.employeecode = (
  		in_employeecode
	)  and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='eIBCGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode ;	
	SET but_money = but_money + temp_but_money;    
        SET net_money = net_money + temp_net_money;
        SET valid_money = valid_money + temp_valid_money;
        SET rebates_cash = rebates_cash + temp_rebates_cash;
	
	
	/********统计直线会员的涉及的活动金额*****/
	select sum(moneychangeamount) into activity_money from employee_money_change 
                where employeecode = in_employeecode 
                and (moneychangedate >= in_begindate and moneychangedate <= in_enddate) 
                and moneychangetypecode='D6B0C11A0AC44EBBB1538BE69B004811';
                
        /********统计总存款*****/
        select IFNULL(sum(orderamount),0) into depositMoney from deposit_withdraw_order where orderstatus='2' and ordertype=1 and 
                employeecode =in_employeecode and (orderdate >= in_begindate and orderdate <= in_enddate) ; 
  	
  	/********统计总取款*****/
  	select IFNULL(sum(orderamount),0) into withdrawMoney from deposit_withdraw_order where orderstatus='2' and ordertype=2 and 
                employeecode =in_employeecode and (orderdate >= in_begindate and orderdate <= in_enddate) ;         
  	
  	        
        select but_money,net_money,valid_money,rebates_cash,activity_money, depositMoney, withdrawMoney;
  
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_report_by_member_employeecode_one_new
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_report_by_member_employeecode_one_new`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_report_by_member_employeecode_one_new`(IN `in_employeecode` char(8),IN `in_begindate` datetime,IN `in_enddate` datetime,OUT `but_money` decimal(14,2),OUT `net_money` decimal(14,2),OUT `valid_money` decimal(14,2),OUT `rebates_cash` decimal(14,2),OUT `activity_money` decimal(14,2) ,  OUT depositMoney decimal(14,2) , OUT withdrawMoney decimal(14,2) )
BEGIN
  
  
  /********统计会员时间段内的汇总数据*****/
  
        


	SET but_money = 0 ;
        SET net_money = 0 ;
        SET valid_money = 0 ;
        SET rebates_cash = 0 ;
        SET activity_money = 0 ;


	
	/********统计汇总表的数据*****/
        select ifnull(sum(hh.Bet_Money),0) , ifnull(sum(hh.Net_Money),0), ifnull(sum(hh.Valid_Money),0)
	into but_money,net_money,valid_money
	from betting_all_day hh where  hh.employeecode = (
  		in_employeecode
	)  and (date(hh.Bet_Day) >= date(in_begindate) and date(hh.Bet_Day) <= date(in_enddate)) ;
        
	
	/********统计直线会员的涉及的活动金额*****/
	select sum(moneychangeamount) into activity_money from employee_money_change 
                where employeecode = in_employeecode 
                and (moneychangedate >= in_begindate and moneychangedate <= in_enddate) 
                and moneychangetypecode='D6B0C11A0AC44EBBB1538BE69B004811';
        
        /********统计整个团队的涉及的实际洗码金额
        //洗码日结("B1FF4C4ADC9C423C8D0344DDFD7DC279","洗码日结"),
        //洗码周结("6B06E77AA855454EB5ADF60B6CC37787","洗码周结"),
        //周结校验补发("56F82CC5B5DC4FFABBFD62F82CACA891","周结校验补发"), *****/       
	select sum(moneychangeamount) into rebates_cash from employee_money_change 
                where employeecode = in_employeecode 
                and (moneychangedate >= in_begindate and moneychangedate <= in_enddate) 
                and moneychangetypecode in('B1FF4C4ADC9C423C8D0344DDFD7DC279','6B06E77AA855454EB5ADF60B6CC37787','56F82CC5B5DC4FFABBFD62F82CACA891');              
                
        /********统计总存款*****/
        select IFNULL(sum(orderamount),0) into depositMoney from deposit_withdraw_order where orderstatus='2' and ordertype=1 and 
                employeecode =in_employeecode and (orderdate >= in_begindate and orderdate <= in_enddate) ; 
  	
  	/********统计总取款*****/
  	select IFNULL(sum(orderamount),0) into withdrawMoney from deposit_withdraw_order where orderstatus='2' and ordertype=2 and 
                employeecode =in_employeecode and (orderdate >= in_begindate and orderdate <= in_enddate) ;         
  	
  	        
        select but_money,net_money,valid_money,rebates_cash,activity_money, depositMoney, withdrawMoney;
        
        
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_report_by_member_employeecode_page
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_report_by_member_employeecode_page`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_report_by_member_employeecode_page`(IN in_parentemployeecode CHAR(8), IN in_begindate DATETIME, IN in_enddate DATETIME,IN `var_start` INTEGER,IN `var_limit` INTEGER,OUT `but_money` decimal(14,2),OUT `net_money` decimal(14,2),OUT `valid_money` decimal(14,2),OUT `rebates_cash` decimal(14,2), OUT `countMember` INTEGER)
    READS SQL DATA
BEGIN
        
        /****************根据代理编码查询直线会员的按平台分类汇总数据，有分页******************/

SELECT sum(s1),sum(s2),sum(s3),sum(s4),count(1) into but_money,net_money,valid_money,rebates_cash,countMember FROM(
        /***AG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'TAGGame',ifnull(sum(hh.bet_Amount),0) s1, ifnull(sum(hh.net_Amount),0) s2, ifnull(sum(hh.valid_Bet_Amount),0) s3, ifnull(sum(hh.valid_Bet_Amount * bb.bonus),0) s4
        from betting_hq_ag hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bet_Time >= in_begindate and hh.bet_Time <= in_enddate) and bb.gametype='TAGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***BBIN**/
        select hh.EMPLOYEECODE,hh.loginaccount,'BBINGame',ifnull(sum(hh.bbin_Bet_Amount),0) s1, ifnull(sum(hh.bbin_Payoff),0) s2, ifnull(sum(hh.bbin_Commissionable),0) s3, ifnull(sum(hh.bbin_Commissionable * bb.bonus),0) s4 
        from betting_hq_bbin hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bbin_Wagers_Date >= in_begindate and hh.bbin_Wagers_Date <= in_enddate) and bb.gametype='BBINGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***NHQ**/
        select hh.EMPLOYEECODE,hh.loginaccount,'NHQGame',ifnull(sum(hh.Betting_Credits),0) s1, ifnull(sum(hh.Winning_Credits),0) s2, ifnull(sum(hh.Wash_Code_Credits),0) s3, ifnull(sum(hh.Wash_Code_Credits * bb.bonus),0) s4
        from betting_hq_nhq hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.Betting_Date >= in_begindate and hh.Betting_Date <= in_enddate) and bb.gametype='NHQGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***OG_AG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'AGGame',ifnull(sum(hh.aoi_Betting_Amount),0) s1, ifnull(sum(hh.aoi_Win_Lose_Amount),0) s2, ifnull(sum(hh.aoi_Valid_Amount),0) s3, ifnull(sum(hh.aoi_Valid_Amount * bb.bonus),0) s4
        from betting_hq_og_ag hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.aoi_Add_Time >= in_begindate and hh.aoi_Add_Time <= in_enddate) and bb.gametype='AGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***OG_IBC**/
        select hh.EMPLOYEECODE,hh.loginaccount,'IBCGame',ifnull(sum(hh.ibc_tzmoney),0) s1, ifnull(sum(if(hh.ibc_lose>0, 0-hh.ibc_lose, hh.ibc_win)),0) s2, ifnull(sum(hh.ibc_tzmoney),0) s3, ifnull(sum(hh.ibc_tzmoney * bb.bonus),0) s4
        from betting_hq_og_ibc hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.ibc_balltime >= in_begindate and hh.ibc_balltime <= in_enddate) and bb.gametype='IBCGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***OG_OG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'OGGame',ifnull(sum(hh.aoi_Betting_Amount),0) s1, ifnull(sum(hh.aoi_Win_Lose_Amount),0) s2, ifnull(sum(hh.aoi_Valid_Amount),0) s3, ifnull(sum(hh.aoi_Valid_Amount * bb.bonus),0) s4
        from betting_hq_og_og hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.aoi_Add_Time >= in_begindate and hh.aoi_Add_Time <= in_enddate) and bb.gametype='OGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***PT**/
        select hh.EMPLOYEECODE,hh.loginaccount,'PTGame',ifnull(sum(hh.pt_bet),0) s1, ifnull(sum(hh.pt_win),0) s2, ifnull(sum(hh.pt_bet),0) s3, ifnull(sum(hh.pt_bet * bb.bonus),0) s4
        from betting_hq_pt hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.pt_gamedate >= in_begindate and hh.pt_gamedate <= in_enddate) and bb.gametype='PTGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***XCP**/
        select hh.EMPLOYEECODE,hh.loginaccount,'XCPGame',ifnull(sum(hh.xcp_totalprice),0) s1, ifnull(sum(hh.xcp_prize-xcp_totalprice),0) s2, ifnull(sum(hh.xcp_totalprice),0) s3, ifnull(sum(hh.xcp_totalprice * bb.bonus),0) s4
        from betting_hq_xcp hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.xcp_writetime >= in_begindate and hh.xcp_writetime <= in_enddate) and bb.gametype='XCPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***KR_AV**/
        select hh.EMPLOYEECODE,hh.loginaccount,'AVGame',ifnull(sum(hh.amount),0) s1, ifnull(sum(hh.amount2),0) s2, ifnull(sum(hh.amount),0) s3, ifnull(sum(hh.amount * bb.bonus),0) s4
        from betting_kr_av hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.time >= in_begindate and hh.time <= in_enddate) and bb.gametype='AVGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***SA**/
        select hh.EMPLOYEECODE,hh.loginaccount,'SAGame',ifnull(sum(hh.betamount),0) s1, ifnull(sum(hh.resultamount),0) s2, ifnull(sum(hh.validbet),0) s3, ifnull(sum(hh.validbet * bb.bonus),0) s4
        from betting_sa hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='SAGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***YG_AG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'YAGGame',ifnull(sum(hh.money),0) s1, ifnull(sum(hh.result),0) s2, ifnull(sum(hh.valid_money),0) s3, ifnull(sum(hh.valid_money * bb.bonus),0) s4
        from betting_yg_ag hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.time >= in_begindate and hh.time <= in_enddate) and bb.gametype='YAGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***ZJ**/
        select hh.EMPLOYEECODE,hh.loginaccount,'ZJGame',ifnull(sum(hh.stakeamount),0) s1, ifnull(sum(hh.winloss),0) s2, ifnull(sum(hh.validstake),0) s3, ifnull(sum(hh.validstake * bb.bonus),0) s4
        from betting_zj hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='ZJGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
       
        UNION ALL 
        /***TTG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'TTGGame',ifnull(sum(hh.amount),0) s1, ifnull(sum(hh.net_money),0) s2, ifnull(sum(hh.amount),0) s3, ifnull(sum(hh.amount * bb.bonus),0) s4
        from betting_ttg hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='TTGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE 
        
        UNION ALL 
        /***MG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'MGGame',ifnull(sum(hh.mg_amount),0) s1, ifnull(sum(hh.net_money),0) s2, ifnull(sum(hh.mg_amount),0) s3, ifnull(sum(hh.mg_amount * bb.bonus),0) s4
        from betting_mg hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='MGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE 
        
        UNION ALL 
        /***PNG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'PNGGame',ifnull(sum(hh.bet_Amount),0) s1, ifnull(sum(hh.net_Amount),0) s2, ifnull(sum(hh.valid_Bet_Amount),0) s3, ifnull(sum(hh.valid_Bet_Amount * bb.bonus),0) s4
        from betting_hq_png hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bet_Time >= in_begindate and hh.bet_Time <= in_enddate) and bb.gametype='PNGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***QP**/
        select hh.EMPLOYEECODE,hh.loginaccount,'QPGame',ifnull(sum(hh.betmoney),0) s1, ifnull(sum(hh.netmoney),0) s2, ifnull(sum(hh.betmoney),0) s3, ifnull(sum(hh.betmoney * bb.bonus),0) s4
        from betting_qp hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='QPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***GG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'GGGame',ifnull(sum(hh.betmoney),0) s1, ifnull(sum(hh.netmoney),0) s2, ifnull(sum(hh.betmoney),0) s3, ifnull(sum(hh.betmoney * bb.bonus),0) s4
        from betting_gg hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='GGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***SGS**/
        select hh.EMPLOYEECODE,hh.loginaccount,'SGSGame',ifnull(sum(hh.betmoney),0) s1, ifnull(sum(hh.netmoney),0) s2, ifnull(sum(hh.betmoney),0) s3, ifnull(sum(hh.betmoney * bb.bonus),0) s4
        from betting_sgs hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='SGSGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        
        UNION ALL 
        /***M88**/
        select hh.EMPLOYEECODE,hh.loginaccount,'M88Game',ifnull(sum(hh.betmoney),0) s1, ifnull(sum(hh.netmoney),0) s2, ifnull(sum(hh.betmoney),0) s3, ifnull(sum(hh.betmoney * bb.bonus),0) s4
        from betting_m88 hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='M88Game' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***haba**/
        select hh.EMPLOYEECODE,hh.loginaccount,'HABGame',ifnull(sum(hh.betmoney),0) s1, ifnull(sum(hh.netmoney),0) s2, ifnull(sum(hh.betmoney),0) s3, ifnull(sum(hh.betmoney * bb.bonus),0) s4
        from betting_hab hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='HABGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        
        UNION ALL
        /***WIN88**/
        select hh.EMPLOYEECODE,hh.loginaccount,'W88Game',ifnull(sum(hh.pt_bet),0) s1, ifnull(sum(hh.pt_win-hh.pt_bet),0) s2, ifnull(sum(hh.pt_bet),0) s3, ifnull(sum(hh.pt_bet * bb.bonus),0) s4
        from betting_win88 hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.pt_gamedate >= in_begindate and hh.pt_gamedate <= in_enddate) and bb.gametype='W88Game' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        UNION ALL 
        /***TGP**/
        select hh.EMPLOYEECODE,hh.loginaccount,'TGPGame',ifnull(sum(hh.betmoney),0) s1, ifnull(sum(hh.netmoney),0) s2, ifnull(sum(hh.betmoney),0) s3, ifnull(sum(hh.betmoney * bb.bonus),0) s4
        from betting_tgp hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='TGPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        UNION ALL 
        /***QT**/
        select hh.EMPLOYEECODE,hh.loginaccount,'QTGame',ifnull(sum(hh.betmoney),0) s1, ifnull(sum(hh.netmoney),0) s2, ifnull(sum(hh.betmoney),0) s3, ifnull(sum(hh.betmoney * bb.bonus),0) s4
        from betting_qt hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='QTGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        UNION ALL 
        /***GB**/
        select hh.EMPLOYEECODE,hh.loginaccount,'GBGame',ifnull(sum(hh.betmoney),0) s1, ifnull(sum(hh.netmoney),0) s2, ifnull(sum(hh.betmoney),0) s3, ifnull(sum(hh.betmoney * bb.bonus),0) s4
        from betting_gb hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='GBGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        UNION ALL 
        /***EBET**/
        select hh.EMPLOYEECODE,hh.loginaccount,'EBETGame',ifnull(sum(hh.betmoney),0) s1, ifnull(sum(hh.netmoney),0) s2, ifnull(sum(hh.validbet),0) s3, ifnull(sum(hh.validbet * bb.bonus),0) s4
        from betting_ebet hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='EBETGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***EIBC**/
        select hh.EMPLOYEECODE,hh.loginaccount,'eIBCGame',ifnull(sum(hh.betmoney),0) s1, ifnull(sum(hh.netmoney),0) s2, ifnull(sum(hh.betmoney),0) s3, ifnull(sum(hh.betmoney * bb.bonus),0) s4
        from betting_eibc hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='eIBCGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
) 
as b;


SELECT a.* FROM(
        /***AG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'TAGGame' gametype,ifnull(sum(hh.bet_Amount),0) game_betting_amount, ifnull(sum(hh.net_Amount),0), ifnull(sum(hh.valid_Bet_Amount),0) lose_win_amount, ifnull(sum(hh.valid_Bet_Amount * bb.bonus),0) bonus
        from betting_hq_ag hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bet_Time >= in_begindate and hh.bet_Time <= in_enddate) and bb.gametype='TAGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***BBIN**/
        select hh.EMPLOYEECODE,hh.loginaccount,'BBINGame' gametype,ifnull(sum(hh.bbin_Bet_Amount),0) game_betting_amount, ifnull(sum(hh.bbin_Payoff-bbin_Bet_Amount),0) lose_win_amount, ifnull(sum(hh.bbin_Commissionable),0), ifnull(sum(hh.bbin_Commissionable * bb.bonus),0) bonus
        from betting_hq_bbin hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bbin_Wagers_Date >= in_begindate and hh.bbin_Wagers_Date <= in_enddate) and bb.gametype='BBINGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***NHQ**/
        select hh.EMPLOYEECODE,hh.loginaccount,'NHQGame' gametype,ifnull(sum(hh.Betting_Credits),0) game_betting_amount, ifnull(sum(hh.Winning_Credits),0) lose_win_amount, ifnull(sum(hh.Wash_Code_Credits),0), ifnull(sum(hh.Wash_Code_Credits * bb.bonus),0) bonus
        from betting_hq_nhq hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.Betting_Date >= in_begindate and hh.Betting_Date <= in_enddate) and bb.gametype='NHQGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***OG_AG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'AGGame' gametype,ifnull(sum(hh.aoi_Betting_Amount),0) game_betting_amount, ifnull(sum(hh.aoi_Win_Lose_Amount),0) lose_win_amount, ifnull(sum(hh.aoi_Valid_Amount),0), ifnull(sum(hh.aoi_Valid_Amount * bb.bonus),0) bonus
        from betting_hq_og_ag hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.aoi_Add_Time >= in_begindate and hh.aoi_Add_Time <= in_enddate) and bb.gametype='AGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***OG_IBC**/
        select hh.EMPLOYEECODE,hh.loginaccount,'IBCGame' gametype,ifnull(sum(hh.ibc_tzmoney),0) game_betting_amount, ifnull(sum(if(hh.ibc_lose>0, 0-hh.ibc_lose, hh.ibc_win)),0) lose_win_amount, ifnull(sum(hh.ibc_tzmoney),0), ifnull(sum(hh.ibc_tzmoney * bb.bonus),0) bonus
        from betting_hq_og_ibc hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.ibc_balltime >= in_begindate and hh.ibc_balltime <= in_enddate) and bb.gametype='IBCGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***OG_OG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'OGGame' gametype,ifnull(sum(hh.aoi_Betting_Amount),0) game_betting_amount, ifnull(sum(hh.aoi_Win_Lose_Amount),0) lose_win_amount, ifnull(sum(hh.aoi_Valid_Amount),0), ifnull(sum(hh.aoi_Valid_Amount * bb.bonus),0) bonus
        from betting_hq_og_og hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.aoi_Add_Time >= in_begindate and hh.aoi_Add_Time <= in_enddate) and bb.gametype='OGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***PT**/
        select hh.EMPLOYEECODE,hh.loginaccount,'PTGame' gametype,ifnull(sum(hh.pt_bet),0) game_betting_amount, ifnull(sum(hh.pt_win),0) lose_win_amount, ifnull(sum(hh.pt_bet),0), ifnull(sum(hh.pt_bet * bb.bonus),0) bonus
        from betting_hq_pt hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.pt_gamedate >= in_begindate and hh.pt_gamedate <= in_enddate) and bb.gametype='PTGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***XCP**/
        select hh.EMPLOYEECODE,hh.loginaccount,'XCPGame' gametype,ifnull(sum(hh.xcp_totalprice),0) game_betting_amount, ifnull(sum(hh.xcp_prize-xcp_totalprice),0) lose_win_amount, ifnull(sum(hh.xcp_totalprice),0), ifnull(sum(hh.xcp_totalprice * bb.bonus),0) bonus
        from betting_hq_xcp hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.xcp_writetime >= in_begindate and hh.xcp_writetime <= in_enddate) and bb.gametype='XCPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***KR_AV**/
        select hh.EMPLOYEECODE,hh.loginaccount,'AVGame' gametype,ifnull(sum(hh.amount),0) game_betting_amount, ifnull(sum(hh.amount2),0) lose_win_amount, ifnull(sum(hh.amount),0), ifnull(sum(hh.amount * bb.bonus),0) bonus
        from betting_kr_av hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.time >= in_begindate and hh.time <= in_enddate) and bb.gametype='AVGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***SA**/
        select hh.EMPLOYEECODE,hh.loginaccount,'SAGame' gametype,ifnull(sum(hh.betamount),0) game_betting_amount, ifnull(sum(hh.resultamount),0) lose_win_amount, ifnull(sum(hh.validbet),0), ifnull(sum(hh.validbet * bb.bonus),0) bonus
        from betting_sa hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='SAGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***YG_AG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'YAGGame' gametype,ifnull(sum(hh.money),0) game_betting_amount, ifnull(sum(hh.result),0) lose_win_amount, ifnull(sum(hh.valid_money),0), ifnull(sum(hh.valid_money * bb.bonus),0) bonus
        from betting_yg_ag hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.time >= in_begindate and hh.time <= in_enddate) and bb.gametype='YAGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***ZJ**/
        select hh.EMPLOYEECODE,hh.loginaccount,'ZJGame' gametype,ifnull(sum(hh.stakeamount),0) game_betting_amount, ifnull(sum(hh.winloss),0) lose_win_amount, ifnull(sum(hh.validstake),0), ifnull(sum(hh.validstake * bb.bonus),0) bonus
        from betting_zj hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='ZJGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        
        /***TTG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'TTGGame' gametype,ifnull(sum(hh.amount),0)     game_betting_amount, ifnull(sum(hh.net_money),0) lose_win_amount, ifnull(sum(hh.amount),0),   ifnull(sum(hh.amount * bb.bonus),0) bonus
        from betting_ttg hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='TTGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        
        UNION ALL 
        /***MG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'MGGame' gametype,ifnull(sum(hh.mg_amount),0)     game_betting_amount, ifnull(sum(hh.net_money),0) lose_win_amount, ifnull(sum(hh.mg_amount),0),   ifnull(sum(hh.mg_amount * bb.bonus),0) bonus
        from betting_mg hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='MGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***PNG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'PNGGame' gametype,ifnull(sum(hh.bet_Amount),0) game_betting_amount, ifnull(sum(hh.net_Amount),0), ifnull(sum(hh.valid_Bet_Amount),0) lose_win_amount, ifnull(sum(hh.valid_Bet_Amount * bb.bonus),0) bonus
        from betting_hq_png hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bet_Time >= in_begindate and hh.bet_Time <= in_enddate) and bb.gametype='PNGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***QP**/
        select hh.EMPLOYEECODE,hh.loginaccount,'QPGame' gametype,ifnull(sum(hh.betmoney),0) game_betting_amount, ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0) lose_win_amount, ifnull(sum(hh.betmoney * bb.bonus),0) bonus
        from betting_qp hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='QPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***GG**/
        select hh.EMPLOYEECODE,hh.loginaccount,'GGGame' gametype,ifnull(sum(hh.betmoney),0) game_betting_amount, ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0) lose_win_amount, ifnull(sum(hh.betmoney * bb.bonus),0) bonus
        from betting_gg hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='GGGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***SGS**/
        select hh.EMPLOYEECODE,hh.loginaccount,'SGSGame' gametype,ifnull(sum(hh.betmoney),0) game_betting_amount, ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0) lose_win_amount, ifnull(sum(hh.betmoney * bb.bonus),0) bonus
        from betting_sgs hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='SGSGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        
        UNION ALL 
        /***M88**/
        select hh.EMPLOYEECODE,hh.loginaccount,'M88Game' gametype,ifnull(sum(hh.betmoney),0) game_betting_amount, ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0) lose_win_amount, ifnull(sum(hh.betmoney * bb.bonus),0) bonus
        from betting_m88 hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='M88Game' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***haba**/
        select hh.EMPLOYEECODE,hh.loginaccount,'HABGame' gametype,ifnull(sum(hh.betmoney),0) game_betting_amount, ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0) lose_win_amount, ifnull(sum(hh.betmoney * bb.bonus),0) bonus
        from betting_hab hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='HABGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        
        UNION ALL 
        /***WIN88**/
        select hh.EMPLOYEECODE,hh.loginaccount,'W88Game' gametype,ifnull(sum(hh.pt_bet),0) game_betting_amount, ifnull(sum(hh.pt_win-hh.pt_bet),0) lose_win_amount, ifnull(sum(hh.pt_bet),0), ifnull(sum(hh.pt_bet * bb.bonus),0) bonus
        from betting_win88 hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.pt_gamedate >= in_begindate and hh.pt_gamedate <= in_enddate) and bb.gametype='W88Game' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        UNION ALL 
        /***TGP**/
        select hh.EMPLOYEECODE,hh.loginaccount,'TGPGame' gametype,ifnull(sum(hh.betmoney),0) game_betting_amount, ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0) lose_win_amount, ifnull(sum(hh.betmoney * bb.bonus),0) bonus
        from betting_tgp hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='TGPGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***QT**/
        select hh.EMPLOYEECODE,hh.loginaccount,'QTGame' gametype,ifnull(sum(hh.betmoney),0) game_betting_amount, ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0) lose_win_amount, ifnull(sum(hh.betmoney * bb.bonus),0) bonus
        from betting_qt hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='QTGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***GB**/
        select hh.EMPLOYEECODE,hh.loginaccount,'GBGame' gametype,ifnull(sum(hh.betmoney),0) game_betting_amount, ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0) lose_win_amount, ifnull(sum(hh.betmoney * bb.bonus),0) bonus
        from betting_gb hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='GBGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***EBET**/
        select hh.EMPLOYEECODE,hh.loginaccount,'EBETGame' gametype,ifnull(sum(hh.betmoney),0) game_betting_amount, ifnull(sum(hh.netmoney),0), ifnull(sum(hh.validbet),0) lose_win_amount, ifnull(sum(hh.validbet * bb.bonus),0) bonus
        from betting_ebet hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='EBETGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
        UNION ALL 
        /***EIBC**/
        select hh.EMPLOYEECODE,hh.loginaccount,'eIBCGame' gametype,ifnull(sum(hh.betmoney),0) game_betting_amount, ifnull(sum(hh.netmoney),0), ifnull(sum(hh.betmoney),0) lose_win_amount, ifnull(sum(hh.betmoney * bb.bonus),0) bonus
        from betting_eibc hh inner join employee_gamecataloy_bonus bb on hh.EMPLOYEECODE in(
                select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
        ) and (hh.bettime >= in_begindate and hh.bettime <= in_enddate) and bb.gametype='eIBCGame' and bb.categorytype=hh.gamebigtype and hh.employeecode=bb.employeecode group by EMPLOYEECODE
        
) 
as a ORDER BY a.EMPLOYEECODE DESC LIMIT var_start,var_limit;  



        
        
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_report_by_member_employeecode_page_new
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_report_by_member_employeecode_page_new`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_report_by_member_employeecode_page_new`(IN in_parentemployeecode CHAR(8), IN in_begindate DATETIME, IN in_enddate DATETIME,IN `var_start` INTEGER,IN `var_limit` INTEGER,OUT `but_money` decimal(14,2),OUT `net_money` decimal(14,2),OUT `valid_money` decimal(14,2),OUT `rebates_cash` decimal(14,2), OUT `countMember` INTEGER)
    READS SQL DATA
BEGIN
  
  
  /****************根据代理编码查询直线会员的按平台分类汇总数据，有分页******************/

SELECT sum(s1),sum(s2),sum(s3),sum(s4),count(1) into but_money,net_money,valid_money,rebates_cash,countMember FROM(
        
        /********统计汇总表的数据*****/
        select ifnull(sum(hh.Bet_Money),0) s1, ifnull(sum(hh.Net_Money),0) s2, ifnull(sum(hh.Valid_Money),0) s3, ifnull(sum(bb.moneychangeamount ),0)  s4
	from betting_all_day hh inner join employee_money_change bb on  hh.employeecode in (
  		select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
	)  and (date(hh.Bet_Day) >= date(in_begindate) and date(hh.Bet_Day) <= date(in_enddate)) 
	and bb.moneychangetypecode in('B1FF4C4ADC9C423C8D0344DDFD7DC279','6B06E77AA855454EB5ADF60B6CC37787','56F82CC5B5DC4FFABBFD62F82CACA891') 
	and (bb.moneychangedate >= date(in_begindate) and bb.moneychangedate <= date(in_enddate)) 
	and hh.employeecode=bb.employeecode 	
        
) 
as b;


SELECT a.* FROM(
        /********统计汇总表的数据*****/        
	select hh.EMPLOYEECODE,hh.User_Name,hh.Game_Platform,ifnull(sum(hh.Bet_Money),0) game_betting_amount, ifnull(sum(hh.Net_Money),0) lose_win_amount, ifnull(sum(hh.Valid_Money),0), ifnull(sum(bb.moneychangeamount),0) bonus
	from betting_all_day hh inner join employee_money_change bb on  hh.employeecode in (
  		select EMPLOYEECODE from enterprise_employee where PARENTEMPLOYEECODE = in_parentemployeecode and datastatus=1 and employeetypecode='T003'
	)  and (date(hh.Bet_Day) >= date(in_begindate) and date(hh.Bet_Day) <= date(in_enddate)) 
	and bb.moneychangetypecode in('B1FF4C4ADC9C423C8D0344DDFD7DC279','6B06E77AA855454EB5ADF60B6CC37787','56F82CC5B5DC4FFABBFD62F82CACA891') 
	and (bb.moneychangedate >= date(in_begindate) and bb.moneychangedate <= date(in_enddate)) 
	and hh.employeecode=bb.employeecode 
        
        
        
) 
as a ORDER BY a.EMPLOYEECODE DESC LIMIT var_start,var_limit;  


  
  
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_activity_raffle_signin
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_activity_raffle_signin`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_activity_raffle_signin`(IN in_employeecode varchar(8),IN in_enterpriseactivitycode int)
this_pro_lable:BEGIN
    -- 签到与抽奖次数映射关系
    DECLARE signin_faffle_mapping varchar(200) DEFAULT ''; -- '3:1,5:2,8:3,12:4,18:5';
    -- 映射组合数量
    DECLARE mapping_count SMALLINT DEFAULT 0;
    -- 单个映射单元
    DECLARE mapping_unit varchar(50);
    -- 映射关系循环变量
    DECLARE loop_variable smallint DEFAULT 1;
    -- 返回抽奖次数
    DECLARE rt_raffle_time smallint DEFAULT 0;
    
    
    -- 如果今天已签到提示签到成功
    SELECT COUNT(1) INTO @todaysign FROM activity_raffle_signin ars 
      WHERE ars.employeecode=in_employeecode AND ars.signintime >= CURDATE() AND ars.signintime<ADDDATE(CURDATE(),INTERVAL  1 DAY);
    IF(@todaysign>=1) THEN 
      SELECT 0 AS result;
      LEAVE this_pro_lable; 
    END IF;

  
    -- 查询用户今天的充值
    SELECT sum(dwo.orderamount),ufn_tn_person_betting(in_employeecode, CURDATE(), ADDDATE(CURDATE(),INTERVAL  1 DAY)) 
      INTO @savingmoney,@betting 
      FROM deposit_withdraw_order dwo 
      WHERE dwo.orderstatus=2 AND dwo.ordertype=1 AND dwo.employeecode=in_employeecode AND dwo.orderdate >= CURDATE() AND dwo.orderdate<ADDDATE(CURDATE(),INTERVAL  1 DAY);
     
    -- 是否满足签到条件
    IF @savingmoney>=50 AND @betting>=50 THEN 
      -- 签到
      INSERT INTO activity_raffle_signin(employeecode, signintime, depositamount, betamount ) VALUE(in_employeecode,NOW(),@savingmoney,@betting);
      
      -- 判断赠送抽奖次数
      SELECT eacs.agementvalue INTO signin_faffle_mapping FROM enterprise_brand_activity eba  
        LEFT JOIN enterprise_activity_customization_setting eacs ON eba.ecactivitycode = eacs.ecactivitycode 
        LEFT JOIN activity_template_setting ats ON eacs.activitysettingcode = ats.activitysettingcode
        WHERE eba.enterprisebrandactivitycode=in_enterpriseactivitycode AND ats.agementname='QDCJYS';
      -- 映射组合数量
      SET mapping_count := tool_jsonf_totallength(signin_faffle_mapping,',');
      -- 跳出循环标记
      while_lable:BEGIN
      WHILE loop_variable <= mapping_count DO 
        -- 循环顺序获取映射关系
        SET mapping_unit:= tool_jsonf_split(signin_faffle_mapping,',',loop_variable);
        -- 签到天数
        SET @signin_day := CAST(tool_jsonf_split(mapping_unit,':',1) AS decimal);
        -- 抽奖次数
        SET @raffle_time := CAST(tool_jsonf_split(mapping_unit,':',2) AS decimal);
        -- 映射时间内签到天数
        SELECT COUNT(1) INTO @sign_count  FROM activity_raffle_signin WHERE signintime BETWEEN ADDDATE(CURDATE(),INTERVAL  -(@signin_day-1) DAY) AND NOW() AND isexpires = 1;
        -- 赠送抽奖次数
        IF @sign_count < @signin_day THEN 
          LEAVE while_lable;
        ELSEIF @sign_count >= @signin_day THEN
          REPLACE INTO activity_raffle_control(employeecode, parentemployeecode, loginaccount, availabletimes,donatedate) SELECT ee.employeecode, ee.parentemployeecode, ee.loginaccount,@raffle_time,NOW() FROM enterprise_employee ee WHERE ee.employeecode=in_employeecode;
          SET rt_raffle_time := @raffle_time;
          IF loop_variable=mapping_count THEN 
            UPDATE activity_raffle_signin ars SET isexpires=0 WHERE ars.employeecode=in_employeecode;
          END IF;
        END IF  ;
        -- 循环变量递增
        SET loop_variable := loop_variable+1;
      END WHILE; 
      end while_lable;

      -- 返回赠送的抽奖次数
      IF rt_raffle_time > 0 THEN 
        SELECT rt_raffle_time AS result;
      ELSE
        SELECT 0 AS result;
      END IF ;
      
    ELSE 
    -- 签到失败
      SELECT -1 AS result;
    END IF;
   
  END this_pro_lable
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_enterprise_report_dates
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_enterprise_report_dates`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_enterprise_report_dates`(
IN in_enterprisecode CHAR(6), 
IN in_reportdate int,

OUT memberRegeditCount int,
OUT agentRegeditCount int,
OUT loginCount int,
OUT todayDepositCount int,
OUT todayTakeCount int,
OUT todayBetmoney double,
OUT todayNetmoney double,
OUT todayVaildmoney double,

OUT firstDepositCount int,
OUT firstDepositMoney double,

OUT secondDepositCount int,
OUT secondDepositMoney double,

OUT noSecondCount int,
OUT noThreeCount int

)
BEGIN

  
  
  ##返回投注的数据
  select sum(betmoney) ,sum(netmoney) ,sum(validbet) INTO todayBetmoney,todayNetmoney,todayVaildmoney  from betting_all_game_winlose_detail where 
  enterprisecode = in_enterprisecode and date(bettime)=in_reportdate ;
  
  ##返回存款和取款的人数（非人次）
  select count(1) INTO todayDepositCount from (
  select employeecode from deposit_withdraw_order where 
  orderstatus=2 and ordertype=1 and enterprisecode = in_enterprisecode and date(orderdate)=in_reportdate group by employeecode
  ) a;
  select count(1) INTO todayTakeCount from (
  select employeecode from deposit_withdraw_order where 
  orderstatus=2 and ordertype=2 and enterprisecode = in_enterprisecode and date(orderdate)=in_reportdate group by employeecode
  ) b;
  
  
  ##返回新注册人数
  select count(1) INTO memberRegeditCount from enterprise_employee where 
  enterprisecode = in_enterprisecode and date(logindatetime)=in_reportdate and employeetypecode='T003';  
  select count(1) INTO agentRegeditCount from enterprise_employee where 
  enterprisecode = in_enterprisecode and date(logindatetime)=in_reportdate and employeetypecode in('T004','T005');
  
  ##返回登录人数
  select count(1) INTO loginCount from (
  select count(1) from log_login where 
  enterprisecode = in_enterprisecode and date(logintime)=in_reportdate group by employeecode
  ) a;
  
  ############返回首存二存三存问题############
  ##返回首存金额和人数##
  select count(1),sum(orderamount) INTO firstDepositCount,firstDepositMoney from deposit_withdraw_order where employeecode in(
        select employeecode from deposit_withdraw_order where orderstatus=2 and ordertype=1 and enterprisecode = in_enterprisecode group by employeecode having count(1)=1
  ) and orderstatus=2 and ordertype=1 and enterprisecode = in_enterprisecode and date(orderdate)=in_reportdate;
  
  ##返回二存金额和人数##
  select count(1),sum(orderamount) INTO secondDepositCount,secondDepositMoney from deposit_withdraw_order where employeecode in(
        select employeecode from deposit_withdraw_order where orderstatus=2 and ordertype=1 and enterprisecode = in_enterprisecode and date(orderdate)=in_reportdate group by employeecode having count(1)=2
  ) and orderstatus=2 and ordertype=1 and enterprisecode = in_enterprisecode and date(orderdate)=in_reportdate;
  
  select 0,0 INTO noSecondCount,noThreeCount;
  
  ##返回金额和人次列表清单
  select moneychangetypecode,sum(moneychangeamount) as moneychangeamount,count(1) as moneychangecount from employee_money_change where 
  enterprisecode = in_enterprisecode and date(moneychangedate)=in_reportdate  group by moneychangetypecode;
  
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_list_team_performance_for_brand
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_list_team_performance_for_brand`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_list_team_performance_for_brand`(IN in_enterprisereport boolean,IN in_enterprisecode char(6),IN in_employeecode char(8),IN in_begintime datetime, IN in_endtime datetime)
BEGIN
  DECLARE l_like_employeeallupleves VARCHAR(1000);
  DECLARE l_employeeallupleves_len  INT;
  DECLARE l_teamemployeecode CHAR(8);
     
  IF in_enterprisereport THEN
     SELECT ufn_up_recursion_shareholder_of_user(in_employeecode) INTO l_teamemployeecode;
  ELSE
     SET l_teamemployeecode := in_employeecode;
  END IF;
  
  SELECT CONCAT(employeeallupleves,'%'),LENGTH(employeeallupleves)+1 INTO l_like_employeeallupleves,l_employeeallupleves_len
    FROM enterprise_employee_all_uplevels
   WHERE employeecode = l_teamemployeecode;
 
  SELECT osquery.totalnetmoney AS netmoney, eob.brandcode, eob.brandname
    FROM enterprise_operating_brand eob
         INNER JOIN ( SELECT squery.brandcode, sum(ba.netmoney) AS totalnetmoney
                        FROM betting_all_game_winlose_detail ba
                             INNER JOIN ( SELECT employeecode,
                      						     brandcode
                      					    FROM enterprise_employee_all_uplevels
                      					   WHERE employeeallupleves LIKE l_like_employeeallupleves and employeetypecode = 'T003' ) squery ON squery.employeecode = ba.employeecode
                       WHERE ba.bettime >= in_begintime
                         AND ba.bettime <= in_endtime
                      GROUP BY squery.brandcode ) osquery ON osquery.brandcode = eob.brandcode
   ORDER BY totalnetmoney;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_list_team_useractivity
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_list_team_useractivity`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_list_team_useractivity`(IN in_enterprisereport boolean,IN in_employeecode char(8))
BEGIN
  # 列表 - 用户活跃度
  
  # 根据报表类型获取团队编码
  IF in_enterprisereport  THEN 
    SELECT ufn_up_recursion_shareholder_of_user(in_employeecode) INTO in_employeecode;
  END IF;

  SET @all_subordinates := ufn_down_recursion_team_of_agent(in_employeecode);
  
SELECT atu.activearea,atu.ucount
 FROM ( SELECT COUNT(ee.loginaccount) ucount,
               CASE 
                 WHEN ee.lastlogintime >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 7 DAY) AND ee.lastlogintime < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY) THEN 3
                 WHEN ee.lastlogintime >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 15 DAY) AND ee.lastlogintime < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 7 DAY) THEN 7
                 WHEN ee.lastlogintime >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 30 DAY) AND ee.lastlogintime < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 15 DAY) THEN 15
                 WHEN ee.lastlogintime > DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 90 DAY) AND ee.lastlogintime < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 30 DAY) THEN 30
                 WHEN ee.lastlogintime < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 90 DAY) THEN 90
                 ELSE 0
               END AS activearea
	      FROM enterprise_employee ee
		 WHERE ee.employeecode = in_employeecode OR FIND_IN_SET (ee.parentemployeecode , @all_subordinates)
	  GROUP BY activearea) AS atu
ORDER BY activearea ASC;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_stat_all_total_money
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_stat_all_total_money`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_stat_all_total_money`(
IN in_employeecode CHAR(8), 
IN start_time DATETIME, 
IN end_time DATETIME
)
BEGIN
  
  DECLARE total_deposit_money DECIMAL(16,2);
  DECLARE total_take_money DECIMAL(16,2);
  DECLARE total_activity_money DECIMAL(16,2);
  DECLARE total_bet_money DECIMAL(16,2);
  DECLARE total_net_money DECIMAL(16,2);
  DECLARE total_stream_money DECIMAL(16,2);
  
  /********总的存款和取款********/
  select 
        SUM(CASE  WHEN s.ordertype=1 THEN s.orderamount ELSE 0 END ) AS savemoney , 
        SUM(CASE  WHEN s.ordertype=2 THEN s.orderamount ELSE 0 END ) AS getmoney 
        INTO total_deposit_money,total_take_money
        from deposit_withdraw_order s where s.orderstatus=2 and s.employeecode = in_employeecode 
        and ( IF (start_time is NULL, 0 = 0, orderdate>start_time) and IF (end_time is NULL, 0 = 0, orderdate<end_time));
        
        
  /****************所需打码流水****************/
  select sum(mustbet) INTO total_stream_money from activity_bet_record 
  where employeecode=in_employeecode 
        and ( IF (start_time is NULL, 0 = 0, createtime>start_time) and IF (end_time is NULL, 0 = 0, createtime<end_time));
        
  
   /****************游戏投注额和输赢总额****************/
  select sum(validbet) as validbet,sum(netmoney) as netmoney
  INTO total_bet_money,total_net_money
  from betting_all_game_winlose_detail 
  where employeecode=in_employeecode 
        and ( IF (start_time is NULL, 0 = 0, bettime>start_time) and IF (end_time is NULL, 0 = 0, bettime<end_time));
        
  
  /****************优惠总额****************/
  select sum(moneychangeamount) INTO total_activity_money
  from employee_money_change 
  where moneychangetypecode='D6B0C11A0AC44EBBB1538BE69B004811' and employeecode=in_employeecode 
        and ( IF (start_time is NULL, 0 = 0, moneychangedate>start_time) and IF (end_time is NULL, 0 = 0, moneychangedate<end_time));
        
  /**返回数据***/
  select
  IF(total_deposit_money IS NULL ,0,total_deposit_money) total_deposit_money,
  IF(total_take_money IS NULL ,0,total_take_money) total_take_money,
  IF(total_activity_money IS NULL ,0,total_activity_money) total_activity_money,
  IF(total_bet_money IS NULL ,0,total_bet_money) total_bet_money,
  IF(total_net_money IS NULL ,0,total_net_money) total_net_money,
  IF(total_stream_money IS NULL ,0,total_stream_money) total_stream_money
  ;    
  
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_stat_employee_allinfo_game
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_stat_employee_allinfo_game`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_stat_employee_allinfo_game`(

IN in_employeecode CHAR(8),

OUT pmoney_acvity decimal(16,2),
OUT pmoney_daily decimal(16,2),
OUT pmoney_up_fail decimal(16,2),
OUT pmoney_add decimal(16,2),
OUT pmoney_sub decimal(16,2)
)
BEGIN
  

  /****************优惠时间，优惠名称，优惠金额****************/
  select 
  sum(moneychangeamount) INTO pmoney_acvity
  from employee_money_change 
  where moneychangetypecode='D6B0C11A0AC44EBBB1538BE69B004811' and employeecode=in_employeecode  ;
  
  /****************洗码数据****************/
  select 
  sum(moneychangeamount) INTO pmoney_daily
  from employee_money_change 
  where moneychangetypecode in('B1FF4C4ADC9C423C8D0344DDFD7DC279','6B06E77AA855454EB5ADF60B6CC37787','56F82CC5B5DC4FFABBFD62F82CACA891') and employeecode=in_employeecode  ;
  
  /****************上分失败返还****************/
  select 
  sum(moneychangeamount) INTO pmoney_up_fail
  from employee_money_change 
  where moneychangetypecode='D6B0C11A0AC44EBBB1538BE69B004811' and employeecode=in_employeecode  ;
  
  /****************冲正****************/
  select 
  sum(moneychangeamount) INTO pmoney_add
  from employee_money_change 
  where moneychangetypecode='1A53AEC4179E4E46AEE7EE752C16E3B1' and employeecode=in_employeecode  ;
  
  /****************冲负****************/
  select 
  sum(moneychangeamount) INTO pmoney_sub
  from employee_money_change 
  where moneychangetypecode='831F252CEAE94DD0A740260EE151A437' and employeecode=in_employeecode  ;
  
  
    
    /****************游戏时间、游戏平台、累计金额****************/
  select max(bettime) as ptime,
  concat(platformtype,(CASE  WHEN gamebigtype='DZ' THEN '电子' WHEN gamebigtype='SX' THEN '真人' WHEN gamebigtype='TY' THEN '体育' WHEN gamebigtype='CP' THEN '彩票' WHEN gamebigtype='QP' THEN '棋牌' ELSE '其他' END)) as pcontent,
  sum(validbet) as pmoney,
  'GAME' as ptype 
  from betting_all_game_winlose_detail 
  where employeecode=in_employeecode group by platformtype,gamebigtype;
  
  
  
  
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_stat_employee_allinfo_order
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_stat_employee_allinfo_order`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_stat_employee_allinfo_order`(

IN in_employeecode CHAR(8),



OUT last_deposit_time timestamp,
OUT last_deposit_money decimal(16,2),
OUT last_deposit_ordernumber varchar(50),

OUT first_deposit_time timestamp,
OUT first_deposit_money decimal(16,2),
OUT first_deposit_ordernumber varchar(50),

OUT all_deposit_money decimal(16,2),
OUT all_deposit_count int,




OUT last_take_time timestamp,
OUT last_take_money decimal(16,2),
OUT last_take_ordernumber varchar(50),

OUT first_take_time timestamp,
OUT first_take_money decimal(16,2),
OUT first_take_ordernumber varchar(50),

OUT all_take_money decimal(16,2),
OUT all_take_count int


)
BEGIN
  

    
  
  /****************最近存款时间、操作类型，存款金额****************/
  select orderdate,orderamount,ordernumber INTO last_deposit_time,last_deposit_money,last_deposit_ordernumber from deposit_withdraw_order where ordertype=1 and orderstatus=2 and employeecode=in_employeecode order by orderdate desc limit 0,1;
    
  /****************查首存时间****************/
  select orderdate,orderamount,ordernumber INTO first_deposit_time,first_deposit_money,first_deposit_ordernumber from deposit_withdraw_order where ordertype=1 and orderstatus=2 and employeecode=in_employeecode order by orderdate asc limit 0,1;

  /****************存款金额，存款笔数****************/
  select sum(orderamount),sum(1) sm INTO all_deposit_money,all_deposit_count from deposit_withdraw_order where ordertype=1 and orderstatus=2 and employeecode=in_employeecode ;
  
  
  /****************最近取款时间、操作类型，取款金额****************/
  select orderdate,orderamount,ordernumber INTO last_take_time,last_take_money,last_take_ordernumber from deposit_withdraw_order where ordertype=2 and orderstatus=2 and employeecode=in_employeecode order by orderdate desc limit 0,1;
  
  /****************首次取款时间、操作类型，取款金额****************/
  select orderdate,orderamount,ordernumber INTO first_take_time,first_take_money,first_take_ordernumber from deposit_withdraw_order where ordertype=2 and orderstatus=2 and employeecode=in_employeecode order by orderdate asc limit 0,1;
  
  /****************存款金额，存款笔数****************/
  select sum(orderamount),sum(1) sm INTO all_take_money,all_take_count from deposit_withdraw_order where ordertype=2 and orderstatus=2 and employeecode=in_employeecode ;
  
  
  
  
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_stat_takemoney_inspect
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_stat_takemoney_inspect`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_stat_takemoney_inspect`(IN in_ordernumber varchar(32))
BEGIN
  # -- 取款稽查  jason20170420:此过程不再使用，不再维护

  -- 用户编码
  DECLARE a_employeecode char(8);
  -- 用户名
  DECLARE a_loginaccout varchar(20);
  -- 上一次存款时间
  DECLARE a_lastsavedate datetime;
  -- 上一次存款金额
  DECLARE a_lastsaveamount decimal(16,2);
  -- 存款后账户余额
  DECLARE a_aftersavebalance decimal(16,2);
  -- 本次取款时间
  DECLARE a_takemoneydate datetime;
  -- 本次取款金额
  DECLARE a_takeamount decimal(16,2);
  -- 本次存款后余额
  DECLARE a_aftertakebalance decimal(16,2);
  -- 稽查周期内帐变金额
  DECLARE a_moneychangeamout decimal(16,2);
  -- TAG游戏输赢 
  DECLARE a_taglosewin decimal(16,2);
  -- BBIN游戏输赢 
  DECLARE a_bbinlosewin decimal(16,2);
  -- NHQ游戏输赢 
  DECLARE a_nhqlosewin decimal(16,2);
  -- OAG游戏输赢 
  DECLARE a_oaglosewin decimal(16,2);
  -- IBC游戏输赢 
  DECLARE a_ibclosewin decimal(16,2);
  -- OG游戏输赢 
  DECLARE a_oglosewin decimal(16,2);
  -- PT游戏输赢 
  DECLARE a_ptlosewin decimal(16,2);
  -- XCP游戏输赢 
  DECLARE a_xcplosewin decimal(16,2);


      
  -- 游戏输赢
  DECLARE a_gamelosewin decimal(16,2);
  -- 存款后上分时间
  DECLARE a_aftersaveupidate datetime;
  -- 存款后上分金额
  DECLARE a_afterupiamount decimal(16,2);
  -- 存款上分后账户余额
  DECLARE a_afterupibalance decimal(16,2);
  
  /*********zj sa av ttg*********/   
  DECLARE a_zjlosewin decimal(16,2);
  DECLARE a_salosewin decimal(16,2);
  DECLARE a_avlosewin decimal(16,2);
  DECLARE a_ttglosewin decimal(16,2);
  DECLARE a_mglosewin decimal(16,2);
  DECLARE a_pnglosewin decimal(16,2);
  DECLARE a_qplosewin decimal(16,2);
  DECLARE a_gglosewin decimal(16,2);
  DECLARE a_sgslosewin decimal(16,2);
  DECLARE a_idnlosewin decimal(16,2);
  DECLARE a_m88losewin decimal(16,2);
  DECLARE a_hablosewin decimal(16,2);  

  #当前订单的取款时间，取款金额，取款后账户余额
  SELECT emc.employeecode,emc.moneychangedate,emc.moneychangeamount,(emc.settlementamount+emc.moneychangeamount) 
    INTO a_employeecode,a_takemoneydate,a_takeamount,a_aftertakebalance 
    FROM employee_money_change emc 
    WHERE emc.ordernumber=in_ordernumber and emc.moneychangetypecode='2BC2CB7FDD7B4720906B56812E075F94';

  SELECT ee.loginaccount INTO a_loginaccout FROM enterprise_employee ee WHERE ee.employeecode = a_employeecode;

  #当前订单的上一次存款时间，存款金额，存款后账户余额
  SELECT emc.moneychangedate,emc.moneychangeamount,(emc.settlementamount+emc.moneychangeamount) 
    INTO a_lastsavedate,a_lastsaveamount,a_aftersavebalance 
    FROM employee_money_change emc 
    WHERE emc.moneychangetypecode='8D37FD20D92043FA8D856590F0DFED0F' AND emc.employeecode=a_employeecode AND emc.moneychangedate<=a_takemoneydate 
    ORDER BY emc.moneychangedate DESC LIMIT 0,1;

  #充值上分后的上分金额，账户余额
  SELECT emc.moneychangedate,emc.moneychangeamount,(emc.settlementamount+emc.moneychangeamount) 
    INTO a_aftersaveupidate,a_afterupiamount,a_afterupibalance 
    FROM employee_money_change emc 
    WHERE emc.moneychangetypecode='AF0B2F04CCA64E3197F047402FEE5832' AND emc.employeecode=a_employeecode AND emc.moneychangedate>=a_lastsavedate AND emc.moneychangedate<=a_takemoneydate 
    ORDER BY emc.moneychangedate ASC LIMIT 0,1;
  
  

  #上一次存款到这一次取款之间的帐变金额
  SELECT SUM(emc.moneychangeamount) INTO a_moneychangeamout 
    FROM employee_money_change emc 
    WHERE emc.employeecode=a_employeecode AND emc.moneychangedate>=a_lastsavedate AND emc.moneychangedate<=a_takemoneydate;

  IF a_aftersaveupidate IS NOT NULL THEN
    
  #TAG游戏输赢 
  SELECT SUM(bha.net_Amount) INTO a_taglosewin  
    FROM betting_hq_ag bha 
    WHERE bha.employeecode=a_employeecode AND bha.bet_Time >= a_aftersaveupidate AND bha.bet_Time <=a_takemoneydate;
  
  #BBIN游戏输赢
  SELECT SUM(bhb.bbin_Payoff) INTO a_bbinlosewin 
    FROM betting_hq_bbin bhb 
    WHERE bhb.employeecode=a_employeecode AND bhb.bbin_Wagers_Date >= a_aftersaveupidate AND bhb.bbin_Wagers_Date <=a_takemoneydate;
  
  #新环球游戏输赢
  SELECT SUM(bhq.Winning_Credits) INTO a_nhqlosewin 
    FROM betting_hq_nhq bhq 
    WHERE bhq.employeecode=a_employeecode AND bhq.Betting_Date  >= a_aftersaveupidate AND bhq.Betting_Date<=a_takemoneydate;

  #OAG游戏输赢
  SELECT SUM(bhoa.aoi_Win_Lose_Amount) INTO a_oaglosewin 
    FROM  betting_hq_og_ag bhoa
    WHERE bhoa.employeecode=a_employeecode AND bhoa.aoi_Add_Time  >= a_aftersaveupidate AND bhoa.aoi_Add_Time <=a_takemoneydate;

  #IBC游戏输赢
  SELECT SUM((bhoi.ibc_win - bhoi.ibc_lose)) INTO a_ibclosewin  
    FROM  betting_hq_og_ibc bhoi
    WHERE bhoi.employeecode=a_employeecode AND bhoi.ibc_updatetime  >= a_aftersaveupidate AND bhoi.ibc_updatetime <=a_takemoneydate;

  #OG游戏输赢
  SELECT SUM(bhoo.aoi_Win_Lose_Amount) INTO a_oglosewin 
    FROM  betting_hq_og_og bhoo
    WHERE bhoo.employeecode=a_employeecode AND bhoo.aoi_Add_Time >= a_aftersaveupidate AND bhoo.aoi_Add_Time <=a_takemoneydate;

  #PT游戏输赢
  SELECT SUM((bhp.pt_win-bhp.pt_bet)) INTO a_ptlosewin 
    FROM  betting_hq_pt bhp
    WHERE bhp.employeecode=a_employeecode AND bhp.pt_gamedate >= a_aftersaveupidate  AND bhp.pt_gamedate <=a_takemoneydate; 

  #祥瑞彩游戏输赢
  SELECT SUM(bhx.xcp_bonus) INTO a_xcplosewin 
    FROM  betting_hq_xcp bhx
    WHERE bhx.employeecode=a_employeecode AND bhx.xcp_writetime >= a_aftersaveupidate  AND bhx.xcp_writetime <=a_takemoneydate; 
  
  /*********zj sa av ttg*********/   
  SELECT SUM(zj.winloss) INTO a_zjlosewin 
    FROM  betting_zj zj
    WHERE zj.employeecode=a_employeecode AND zj.bettime >= a_aftersaveupidate  AND zj.bettime <=a_takemoneydate; 
    
  SELECT SUM(sa.resultamount) INTO a_salosewin 
    FROM  betting_sa sa
    WHERE sa.employeecode=a_employeecode AND sa.bettime >= a_aftersaveupidate  AND sa.bettime <=a_takemoneydate;   
  
  SELECT SUM(av.amount2) INTO a_avlosewin 
    FROM  betting_kr_av av
    WHERE av.employeecode=a_employeecode AND av.time >= a_aftersaveupidate  AND av.time <=a_takemoneydate;     
  
  SELECT SUM(ttg.net_money) INTO a_ttglosewin 
    FROM  betting_ttg ttg
    WHERE ttg.employeecode=a_employeecode AND ttg.bettime >= a_aftersaveupidate  AND ttg.bettime <=a_takemoneydate;   
  
  SELECT SUM(mg.net_money) INTO a_mglosewin 
    FROM  betting_mg mg
    WHERE mg.employeecode=a_employeecode AND mg.bettime >= a_aftersaveupidate  AND mg.bettime <=a_takemoneydate;  
  
  SELECT SUM(bha.net_Amount) INTO a_pnglosewin  
    FROM betting_hq_png bha 
    WHERE bha.employeecode=a_employeecode AND bha.bet_Time >= a_aftersaveupidate AND bha.bet_Time <=a_takemoneydate;
  
  SELECT SUM(bha.netmoney) INTO a_qplosewin  
    FROM betting_qp bha 
    WHERE bha.employeecode=a_employeecode AND bha.bettime >= a_aftersaveupidate AND bha.bettime <=a_takemoneydate;
  
  SELECT SUM(bha.netmoney) INTO a_gglosewin  
    FROM betting_gg bha 
    WHERE bha.employeecode=a_employeecode AND bha.bettime >= a_aftersaveupidate AND bha.bettime <=a_takemoneydate;  
    
  SELECT SUM(bha.netmoney) INTO a_sgslosewin  
    FROM betting_sgs bha 
    WHERE bha.employeecode=a_employeecode AND bha.bettime >= a_aftersaveupidate AND bha.bettime <=a_takemoneydate;  
    
  SELECT SUM(bha.netmoney) INTO a_idnlosewin  
    FROM betting_idn bha 
    WHERE bha.employeecode=a_employeecode AND bha.bettime >= a_aftersaveupidate AND bha.bettime <=a_takemoneydate;      
    
  SELECT SUM(bha.netmoney) INTO a_m88losewin  
    FROM betting_m88 bha 
    WHERE bha.employeecode=a_employeecode AND bha.bettime >= a_aftersaveupidate AND bha.bettime <=a_takemoneydate;   
    
    SELECT SUM(bha.netmoney) INTO a_hablosewin  
    FROM betting_hab bha 
    WHERE bha.employeecode=a_employeecode AND bha.bettime >= a_aftersaveupidate AND bha.bettime <=a_takemoneydate;      
    
      
  #游戏总输赢
  set a_gamelosewin = IF(a_taglosewin IS NULL ,0,a_taglosewin) + IF(a_bbinlosewin IS NULL ,0,a_bbinlosewin) + IF(a_nhqlosewin IS NULL ,0,a_nhqlosewin) + 
                      IF(a_oaglosewin IS NULL ,0,a_oaglosewin) + IF(a_ibclosewin IS NULL ,0,a_ibclosewin) + IF(a_oglosewin IS NULL ,0,a_oglosewin) + 
                        IF(a_ptlosewin IS NULL ,0,a_ptlosewin) + IF(a_xcplosewin IS NULL ,0,a_xcplosewin) + 
                        IF(a_zjlosewin IS NULL ,0,a_zjlosewin)+
                        IF(a_salosewin IS NULL ,0,a_salosewin)+
                        IF(a_avlosewin IS NULL ,0,a_avlosewin)+
                        IF(a_ttglosewin IS NULL ,0,a_ttglosewin)+
                        IF(a_mglosewin IS NULL ,0,a_mglosewin)+
                        IF(a_pnglosewin IS NULL ,0,a_pnglosewin)+
                        IF(a_qplosewin IS NULL ,0,a_qplosewin)+
                        IF(a_gglosewin IS NULL ,0,a_gglosewin)+
                        IF(a_sgslosewin IS NULL ,0,a_sgslosewin)+
                        IF(a_idnlosewin IS NULL ,0,a_idnlosewin)+
                        IF(a_m88losewin IS NULL ,0,a_m88losewin)+
                        IF(a_hablosewin IS NULL ,0,a_hablosewin)
                        ;
  end IF;

  SELECT 
    a_employeecode AS employeecode,
    a_loginaccout AS loginaccount,
    IF(a_lastsavedate IS NULL ,'',a_lastsavedate) AS lastsavedate,
    IF(a_lastsaveamount IS NULL,0,a_lastsaveamount) AS lastsaveamount,
    IF(a_aftersavebalance IS NULL ,0,a_aftersavebalance) AS aftersavebalance,
    IF(a_aftersaveupidate IS NULL ,'',a_aftersaveupidate) AS aftersaveupidate,
    IF(a_afterupiamount IS NULL,0,a_afterupiamount) AS afterupiamount,
    IF(a_afterupibalance IS NULL ,0,a_afterupibalance) AS afterupibalance,
    IF(a_takemoneydate IS NULL ,'',a_takemoneydate) AS takemoneydate,
    IF(a_takeamount IS NULL ,0,a_takeamount) AS takeamount,
    IF(a_aftertakebalance IS NULL ,0,a_aftertakebalance) AS aftertakebalance,
    IF(a_moneychangeamout IS NULL ,0,a_moneychangeamout) AS moneychangeamout,
    IF(a_taglosewin IS NULL ,0,a_taglosewin) AS taglosewin,
    IF(a_bbinlosewin IS NULL ,0,a_bbinlosewin) AS bbinlosewin,
    IF(a_nhqlosewin IS NULL ,0,a_nhqlosewin) AS nhqlosewin,
    IF(a_oaglosewin IS NULL ,0,a_oaglosewin) AS oaglosewin,
    IF(a_ibclosewin IS NULL ,0,a_ibclosewin) AS ibclosewin,
    IF(a_oglosewin IS NULL ,0,a_oglosewin) AS oglosewin,
    IF(a_ptlosewin IS NULL ,0,a_ptlosewin) AS ptlosewin,
    IF(a_xcplosewin IS NULL ,0,a_xcplosewin) AS xcplosewin,    
    IF(a_zjlosewin IS NULL ,0,a_zjlosewin) AS zjlosewin,
    IF(a_salosewin IS NULL ,0,a_salosewin) AS salosewin,
    IF(a_avlosewin IS NULL ,0,a_avlosewin) AS avlosewin,
    IF(a_ttglosewin IS NULL ,0,a_ttglosewin) AS ttglosewin,
    IF(a_mglosewin IS NULL ,0,a_mglosewin) AS mglosewin,
    IF(a_pnglosewin IS NULL ,0,a_pnglosewin) AS pnglosewin,
    IF(a_qplosewin IS NULL ,0,a_qplosewin) AS qplosewin,    
    IF(a_gglosewin IS NULL ,0,a_gglosewin) AS gglosewin,
    IF(a_sgslosewin IS NULL ,0,a_sgslosewin) AS sgslosewin,
    IF(a_idnlosewin IS NULL ,0,a_idnlosewin) AS idnlosewin,
    
    IF(a_m88losewin IS NULL ,0,a_m88losewin) AS m88losewin,
    IF(a_hablosewin IS NULL ,0,a_hablosewin) AS hablosewin,
    
    IF(a_gamelosewin IS NULL ,0,a_gamelosewin) AS gamelosewin
    ;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_stat_takemoney_inspect_new
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_stat_takemoney_inspect_new`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_stat_takemoney_inspect_new`(
IN in_ordernumber VARCHAR(50),

OUT curren_money decimal(16,2),
OUT last_deposit_time timestamp,
OUT last_deposit_money decimal(16,2),
OUT last_deposit_balance decimal(16,2),
OUT last_take_time timestamp,
OUT last_take_money decimal(16,2),

OUT local_take_time timestamp,
OUT local_take_money decimal(16,2),

OUT need_stream_money decimal(16,2)
)
BEGIN
  
  DECLARE isonce int default 0;
  DECLARE in_employeecode CHAR(8);
  DECLARE last_deposit_ordernumber VARCHAR(36);
  
  DECLARE first_deposit_time timestamp;
    
  
  /****************本次取款时间、取款金额****************/      
  select orderdate,orderamount,employeecode INTO local_take_time,local_take_money,in_employeecode from deposit_withdraw_order where ordernumber=in_ordernumber ;
  
  /****************当前余额****************/     
  select balance INTO curren_money from enterprise_employee_capital_account where employeecode=in_employeecode;
  
  /****************最近存款时间、操作类型，存款金额****************/
  select orderdate,orderamount,ordernumber INTO last_deposit_time,last_deposit_money,last_deposit_ordernumber from deposit_withdraw_order where ordertype=1 and orderstatus=2 and employeecode=in_employeecode order by orderdate desc limit 0,1;
  /*******存款后余额*****/
  select (moneychangeamount + settlementamount) INTO last_deposit_balance from employee_money_change 
  where moneychangetypecode='8D37FD20D92043FA8D856590F0DFED0F' and ordernumber=last_deposit_ordernumber and employeecode=in_employeecode;
  
  
  /****************查首存时间****************/
  select orderdate INTO first_deposit_time from deposit_withdraw_order where ordertype=1 and orderstatus=2 and employeecode=in_employeecode order by orderdate asc limit 0,1;

  /****************最近取款时间、操作类型，取款金额****************/
  select orderdate,orderamount INTO last_take_time,last_take_money from deposit_withdraw_order where ordertype=2 and orderstatus=2 and employeecode=in_employeecode order by orderdate desc limit 0,1;
  
  /****************如果只有当前这一次取款，则最后一次取款时间要改为存款时间****************/
  IF local_take_time = last_take_time THEN 
  SET  last_take_time = first_deposit_time;
  SET  isonce = 1;
  END IF;
  
  IF last_take_time = null or last_take_time is null THEN 
  SET  last_take_time = first_deposit_time;
  SET  isonce = 1;
  END IF;
  
  
  /****************所需打码流水（上一次成功取款时间到本次取款时间）****************/
  select sum(mustbet) INTO need_stream_money from activity_bet_record where employeecode=in_employeecode and (createtime>=last_take_time and createtime<=local_take_time);
  
  /****************最近游戏时间、游戏平台、累计金额；（上一次成功取款时间到本次取款时间）****************/
  select max(bettime) as ptime,
  concat(platformtype,(CASE  WHEN gamebigtype='DZ' THEN '电子' WHEN gamebigtype='SX' THEN '真人' WHEN gamebigtype='TY' THEN '体育' WHEN gamebigtype='CP' THEN '彩票' WHEN gamebigtype='QP' THEN '棋牌' ELSE '其他' END)) as pcontent,
  sum(validbet) as pmoney,
  'GAME' as ptype 
  from betting_all_game_winlose_detail 
  where employeecode=in_employeecode and (bettime>last_take_time and bettime<local_take_time) group by platformtype,gamebigtype
  
  UNION ALL
  
  /****************最近优惠时间，优惠名称，优惠金额；（上一次成功取款时间到本次取款时间）****************/
  select moneychangedate as ptime,
  moneyinoutcomment as pcontent,
  moneychangeamount as pmoney,
  'ACTIVITY' as ptype
  from employee_money_change 
  where moneychangetypecode='D6B0C11A0AC44EBBB1538BE69B004811' and employeecode=in_employeecode and (moneychangedate>last_take_time and moneychangedate<local_take_time) 
  
  UNION ALL
  
  /****************最近上分时间，上分名称，上分金额；（上一次成功取款时间到本次取款时间）****************/
  select moneyinoutdate as ptime,
  concat(gametype, (CASE  WHEN opreatetype=1 THEN '上分' WHEN opreatetype=2 THEN '下分' ELSE '其他' END)  ) as pcontent,
  abs(moneyinoutamount) as pmoney, 
  'MONEY_INOUT' as ptype
  from user_money_in_and_out 
  where updatecapital=1 and employeecode=in_employeecode and (moneyinoutdate>last_take_time and moneyinoutdate<local_take_time)   ;
  
  
  /****************如果只有当前这一次取款，则最后一次取款时间要改为空值****************/
  IF isonce = 1 THEN 
  SET  last_take_time = null ;
  SET  last_take_money = null ;
  END IF;
  
  
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_stat_team_balance
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_stat_team_balance`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_stat_team_balance`(IN in_enterprisereport boolean,IN in_employeecode char(8))
    READS SQL DATA
BEGIN
  # 总计 - 团队余额
  DECLARE r_balance decimal(16,2) DEFAULT 0;

  # 根据报表类型获取团队编码
  IF in_enterprisereport  THEN 
    SELECT ufn_up_recursion_shareholder_of_user(in_employeecode) INTO in_employeecode;
  END IF;
  
  SET @all_subordinates := ufn_down_recursion_team_of_agent(in_employeecode);
  
  SELECT SUM(eeca.balance) INTO r_balance 
    FROM enterprise_employee_capital_account eeca 
   WHERE (eeca.employeecode = in_employeecode 
      OR FIND_IN_SET (eeca.parentemployeecode , @all_subordinates));
  SELECT IF(r_balance IS NULL ,0,r_balance)AS balance;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_stat_team_losewin
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_stat_team_losewin`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_stat_team_losewin`(IN in_enterprisereport boolean,IN in_employeecode char(8), IN in_begintime datetime, IN in_endtime datetime)
    READS SQL DATA
BEGIN
  DECLARE r_netmoney decimal(16,2) DEFAULT 0;
  DECLARE l_like_employeeallupleves VARCHAR(1000);
  DECLARE l_employeeallupleves_len  INT;
  DECLARE l_teamemployeecode CHAR(8);
     
  IF in_enterprisereport THEN
     SELECT ufn_up_recursion_shareholder_of_user(in_employeecode) INTO l_teamemployeecode;
  ELSE
     SET l_teamemployeecode := in_employeecode;
  END IF;
  
  SELECT CONCAT(employeeallupleves,'%'),LENGTH(employeeallupleves)+1 INTO l_like_employeeallupleves,l_employeeallupleves_len
    FROM enterprise_employee_all_uplevels
   WHERE employeecode = l_teamemployeecode;

   SELECT sum(IFNULL(ba.netmoney,0)) INTO r_netmoney
     FROM betting_all_game_winlose_detail ba
          INNER JOIN ( SELECT employeecode,
                              parentemployeecode,
                              SUBSTRING(employeeallupleves, l_employeeallupleves_len, 8) AS topparentemployeecode 
                         FROM enterprise_employee_all_uplevels
                        WHERE employeeallupleves LIKE l_like_employeeallupleves and employeetypecode = 'T003' ) squery ON squery.employeecode = ba.employeecode
    WHERE ba.bettime >= in_begintime
      AND ba.bettime <= in_endtime;
	
    SELECT r_netmoney;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_stat_team_savemoney
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_stat_team_savemoney`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_stat_team_savemoney`(IN in_enterprisereport boolean,IN in_employeecode char(8), IN in_begintime datetime, IN in_endtime datetime)
    READS SQL DATA
BEGIN
  # 总计 - 团队存款
  DECLARE r_savemoney decimal(16,2) DEFAULT 0;

# 根据报表类型获取团队编码
IF in_enterprisereport  THEN 
  SELECT ufn_up_recursion_shareholder_of_user(in_employeecode) INTO in_employeecode;
END IF;

SET @all_subordinates := ufn_down_recursion_team_of_agent(in_employeecode);

SELECT SUM(dwo.orderamount) INTO r_savemoney
  FROM deposit_withdraw_order dwo
 WHERE dwo.orderdate>=in_begintime
   AND dwo.orderdate<in_endtime
   AND dwo.ordertype=1
   AND dwo.orderstatus =2
   AND ( dwo.employeecode = in_employeecode
      OR FIND_IN_SET (dwo.parentemployeecode , @all_subordinates));
	  
 SELECT IF(r_savemoney IS NULL ,0,r_savemoney)AS savemoney;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_stat_team_takemoney
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_stat_team_takemoney`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_stat_team_takemoney`(IN in_enterprisereport boolean,IN in_employeecode char(8), IN in_begintime datetime, IN in_endtime datetime)
    READS SQL DATA
BEGIN
  # 总计 - 团队取款
  DECLARE r_takemoney decimal(16,2) DEFAULT 0;

# 根据报表类型获取团队编码
IF in_enterprisereport  THEN 
  SELECT ufn_up_recursion_shareholder_of_user(in_employeecode) INTO in_employeecode;
END IF;

SET @all_subordinates := ufn_down_recursion_team_of_agent(in_employeecode);

SELECT SUM(dwo.orderamount)  INTO r_takemoney
  FROM deposit_withdraw_order dwo
 WHERE dwo.orderdate>=in_begintime
   AND dwo.orderdate<in_endtime
   AND dwo.ordertype=2
   AND dwo.orderstatus =2
   AND ( dwo.employeecode = in_employeecode
      OR FIND_IN_SET (dwo.parentemployeecode , @all_subordinates));
  
SELECT IF(r_takemoney IS NULL ,0,r_takemoney)AS takemoney;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_tn_toplist_team_performance
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_tn_toplist_team_performance`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_tn_toplist_team_performance`(IN in_enterprisereport boolean,IN in_employeecode char(8),IN in_begintime datetime, IN in_endtime datetime)
BEGIN
  DECLARE l_like_employeeallupleves VARCHAR(1000);
  DECLARE l_employeeallupleves_len  INT;
  DECLARE l_teamemployeecode CHAR(8);
     
  IF in_enterprisereport THEN
     SELECT ufn_up_recursion_shareholder_of_user(in_employeecode) INTO l_teamemployeecode;
  ELSE
     SET l_teamemployeecode := in_employeecode;
  END IF;
  
  SELECT CONCAT(employeeallupleves,'%'),LENGTH(employeeallupleves)+1 INTO l_like_employeeallupleves,l_employeeallupleves_len
    FROM enterprise_employee_all_uplevels
   WHERE employeecode = l_teamemployeecode;
 
  SELECT ee.loginaccount, osquery.totalnetmoney AS netmoney
    FROM enterprise_employee_all_uplevels ee
         INNER JOIN ( SELECT squery.topparentemployeecode, sum(ba.netmoney) AS totalnetmoney
                        FROM betting_all_game_winlose_detail ba
                             INNER JOIN ( SELECT employeecode,
                      						     parentemployeecode,
                                                 SUBSTRING(employeeallupleves, l_employeeallupleves_len, 8) AS topparentemployeecode 
                      					    FROM enterprise_employee_all_uplevels
                      					   WHERE employeeallupleves LIKE l_like_employeeallupleves and employeetypecode = 'T003' ) squery ON squery.employeecode = ba.employeecode
                       WHERE ba.bettime >= in_begintime
                         AND ba.bettime <= in_endtime
                      GROUP BY squery.topparentemployeecode ) osquery ON osquery.topparentemployeecode = ee.employeecode
   LIMIT 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_day_report
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_day_report`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_day_report`(

in in_gametype VARCHAR(10),
in in_loginaccount VARCHAR(10),
in in_enterprisecode VARCHAR(10),
in in_start int,
in in_limit int,

in in_startdate int,
in in_enddate int,
out out_count int
)
BEGIN
  
  
  select COUNT(1) INTO out_count from (
          select  Game_Platform
          from betting_all_day where 1=1
          and 
          (IF (in_startdate = 0, 0 = 0, date(Bet_Day) >= in_startdate) )   
          and 
          (IF (in_enddate  = 0, 0 = 0, date(Bet_Day) <= in_enddate) )  
          and 
          (IF (in_gametype IS NULL, 0 = 0, Game_Platform = in_gametype) )
           and 
          (IF (in_loginaccount IS NULL, 0 = 0, User_Name = in_loginaccount) )   
          and 
          (IF (in_enterprisecode IS NULL, 0 = 0, enterprisecode = in_enterprisecode) ) 
          group by Game_Platform,employeecode
  ) AS a;
  
  select employeecode,betmoney,validbet,netmoney,Game_Platform AS platformtype,cnt from (
          select employeecode,SUM(Bet_Money) AS betmoney,SUM(Valid_Money) AS validbet,SUM(Net_Money) AS netmoney,Game_Platform,COUNT(1) cnt 
          from betting_all_day where 1=1
          and 
          (IF (in_startdate = 0, 0 = 0, date(Bet_Day) >= in_startdate) )   
          and 
          (IF (in_enddate  = 0, 0 = 0, date(Bet_Day) <= in_enddate) )  
          and 
          (IF (in_gametype IS NULL, 0 = 0, Game_Platform = in_gametype) )
           and 
          (IF (in_loginaccount IS NULL, 0 = 0, User_Name = in_loginaccount) )   
          and 
          (IF (in_enterprisecode IS NULL, 0 = 0, enterprisecode = in_enterprisecode) )   
            
          group by Game_Platform,employeecode
  ) AS a    order by betmoney desc limit in_start , in_limit;
  
  
  
  
  
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_deposit_money
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_deposit_money`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_deposit_money`(IN in_employeecode CHAR(8),IN in_flag int ,out allDepositMoney DECIMAL(14,2))
    READS SQL DATA
BEGIN
  
  
  /****************
         0=昨天 1=当天 2=历史累计
        ***************/
        
        if in_flag=0 then  
            select IFNULL(sum(orderamount),0) into allDepositMoney from deposit_withdraw_order where orderstatus='2' and ordertype=1 and employeecode=in_employeecode and date(orderdate)=date(date_add(now(), interval -1 day));
        
        elseif in_flag=1 then 
            select IFNULL(sum(orderamount),0) into allDepositMoney from deposit_withdraw_order where orderstatus='2' and ordertype=1 and employeecode=in_employeecode and date(orderdate)=date(now());
            
        else  
            select IFNULL(sum(orderamount),0) into allDepositMoney from deposit_withdraw_order where orderstatus='2' and ordertype=1 and employeecode=in_employeecode ;
        end if; 
  select allDepositMoney;
  
  
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_deposit_withdrawals
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_deposit_withdrawals`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_deposit_withdrawals`(IN employee_id varchar(10),
IN date_begin date,
IN date_end date,
IN var_start int,
IN var_end int,
OUT param1 int)
BEGIN
  /*
  用户存取统计 ---> 直线会员及代理团队
*/
  IF ISNULL(date_begin) = 1 AND ISNULL(date_end) = 1 THEN
    SET date_begin = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;
  /*分页*/
  SELECT
    COUNT(1) INTO param1
  FROM (SELECT
      AA.loginaccount,
      AA.employeecode,
      BB.deposit_mount AS allDepositMoney,
      BB.deposit_num AS depositNumber,
      CC.take_mount AS allTakeMoney,
      CC.take_num AS quantity
    FROM (SELECT
        loginaccount,
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode
      FROM enterprise_employee
      WHERE parentemployeecode IN (SELECT
          A.employeecode
        FROM enterprise_employee A
        WHERE FIND_IN_SET(A.parentemployeecode, (SELECT
            ufn_down_recursion_team_of_agent(ear.employeecode) AS code_id
          FROM enterprise_employee ear
          WHERE ear.employeecode = employee_id)) > 0 AND A.datastatus = 1)) AS AA
      LEFT JOIN (SELECT
          employeecode,
          parentemployeecode,
          enterprisecode,
          brandcode,
          SUM(orderamount) AS deposit_mount,
          COUNT(1) AS deposit_num
        FROM deposit_withdraw_order
        WHERE ordertype = 1
        AND orderstatus = 2
        AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
        GROUP BY employeecode,
                 parentemployeecode,
                 enterprisecode,
                 brandcode) AS BB
        ON AA.employeecode = BB.employeecode AND AA.parentemployeecode = BB.parentemployeecode
        AND AA.enterprisecode = BB.enterprisecode AND AA.brandcode = BB.brandcode
      LEFT JOIN (SELECT
          employeecode,
          parentemployeecode,
          enterprisecode,
          brandcode,
          SUM(orderamount) AS take_mount,
          COUNT(1) AS take_num
        FROM deposit_withdraw_order
        WHERE ordertype = 2
        AND orderstatus = 2
        AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
        GROUP BY employeecode,
                 parentemployeecode,
                 enterprisecode,
                 brandcode) AS CC
        ON AA.employeecode = CC.employeecode AND AA.parentemployeecode = CC.parentemployeecode
        AND AA.enterprisecode = CC.enterprisecode AND AA.brandcode = CC.brandcode
    WHERE (BB.deposit_num > 0 OR CC.take_num > 0)
    UNION ALL
    SELECT
      loginaccount,
      employeecode,
      allDepositMoney,
      depositNumber,
      allTakeMoney,
      quantity
    FROM (SELECT
        '直线会员' AS loginaccount,
        employee_id AS employeecode,
        SUM(BB.deposit_mount) AS allDepositMoney,
        SUM(BB.deposit_num) AS depositNumber,
        SUM(CC.take_mount) AS allTakeMoney,
        SUM(CC.take_num) AS quantity
      FROM (SELECT
          loginaccount,
          employeecode,
          parentemployeecode,
          enterprisecode,
          brandcode
        FROM enterprise_employee
        WHERE parentemployeecode = employee_id
        AND employeetypecode = 'T003'
        AND datastatus = 1) AS AA
        LEFT JOIN (SELECT
            employeecode,
            parentemployeecode,
            enterprisecode,
            brandcode,
            SUM(orderamount) AS deposit_mount,
            COUNT(1) AS deposit_num
          FROM deposit_withdraw_order
          WHERE ordertype = 1
          AND orderstatus = 2
          AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
          GROUP BY employeecode,
                   parentemployeecode,
                   enterprisecode,
                   brandcode) AS BB
          ON AA.employeecode = BB.employeecode AND AA.parentemployeecode = BB.parentemployeecode
          AND AA.enterprisecode = BB.enterprisecode AND AA.brandcode = BB.brandcode
        LEFT JOIN (SELECT
            employeecode,
            parentemployeecode,
            enterprisecode,
            brandcode,
            SUM(orderamount) AS take_mount,
            COUNT(1) AS take_num
          FROM deposit_withdraw_order
          WHERE ordertype = 2
          AND orderstatus = 2
          AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
          GROUP BY employeecode,
                   parentemployeecode,
                   enterprisecode,
                   brandcode) AS CC
          ON AA.employeecode = CC.employeecode AND AA.parentemployeecode = CC.parentemployeecode
          AND AA.enterprisecode = CC.enterprisecode AND AA.brandcode = CC.brandcode) AS UU
    WHERE (allDepositMoney > 0 OR allTakeMoney > 0)) AS HH;


  /*主体数据*/
  SELECT
    AA.loginaccount,
    AA.employeecode,
    BB.deposit_mount AS allDepositMoney,
    BB.deposit_num AS depositNumber,
    CC.take_mount AS allTakeMoney,
    CC.take_num AS quantity
  FROM (SELECT
      loginaccount,
      employeecode,
      parentemployeecode,
      enterprisecode,
      brandcode
    FROM enterprise_employee
    WHERE parentemployeecode IN (SELECT
        A.employeecode
      FROM enterprise_employee A
      WHERE FIND_IN_SET(A.parentemployeecode, (SELECT
          ufn_down_recursion_team_of_agent(ear.employeecode) AS code_id
        FROM enterprise_employee ear
        WHERE ear.employeecode = employee_id)) > 0 AND A.datastatus = 1)) AS AA
    LEFT JOIN (SELECT
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode,
        SUM(orderamount) AS deposit_mount,
        COUNT(1) AS deposit_num
      FROM deposit_withdraw_order
      WHERE ordertype = 1
      AND orderstatus = 2
      AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
      GROUP BY employeecode,
               parentemployeecode,
               enterprisecode,
               brandcode) AS BB
      ON AA.employeecode = BB.employeecode AND AA.parentemployeecode = BB.parentemployeecode
      AND AA.enterprisecode = BB.enterprisecode AND AA.brandcode = BB.brandcode
    LEFT JOIN (SELECT
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode,
        SUM(orderamount) AS take_mount,
        COUNT(1) AS take_num
      FROM deposit_withdraw_order
      WHERE ordertype = 2
      AND orderstatus = 2
      AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
      GROUP BY employeecode,
               parentemployeecode,
               enterprisecode,
               brandcode) AS CC
      ON AA.employeecode = CC.employeecode AND AA.parentemployeecode = CC.parentemployeecode
      AND AA.enterprisecode = CC.enterprisecode AND AA.brandcode = CC.brandcode
  WHERE (BB.deposit_num > 0 OR CC.take_num > 0)
  UNION ALL
  SELECT
    loginaccount,
    employeecode,
    allDepositMoney,
    depositNumber,
    allTakeMoney,
    quantity
  FROM (SELECT
      '直线会员' AS loginaccount,
      employee_id AS employeecode,
      SUM(BB.deposit_mount) AS allDepositMoney,
      SUM(BB.deposit_num) AS depositNumber,
      SUM(CC.take_mount) AS allTakeMoney,
      SUM(CC.take_num) AS quantity
    FROM (SELECT
        loginaccount,
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode
      FROM enterprise_employee
      WHERE parentemployeecode = employee_id
      AND employeetypecode = 'T003'
      AND datastatus = 1) AS AA
      LEFT JOIN (SELECT
          employeecode,
          parentemployeecode,
          enterprisecode,
          brandcode,
          SUM(orderamount) AS deposit_mount,
          COUNT(1) AS deposit_num
        FROM deposit_withdraw_order
        WHERE ordertype = 1
        AND orderstatus = 2
        AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
        GROUP BY employeecode,
                 parentemployeecode,
                 enterprisecode,
                 brandcode) AS BB
        ON AA.employeecode = BB.employeecode AND AA.parentemployeecode = BB.parentemployeecode
        AND AA.enterprisecode = BB.enterprisecode AND AA.brandcode = BB.brandcode
      LEFT JOIN (SELECT
          employeecode,
          parentemployeecode,
          enterprisecode,
          brandcode,
          SUM(orderamount) AS take_mount,
          COUNT(1) AS take_num
        FROM deposit_withdraw_order
        WHERE ordertype = 2
        AND orderstatus = 2
        AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
        GROUP BY employeecode,
                 parentemployeecode,
                 enterprisecode,
                 brandcode) AS CC
        ON AA.employeecode = CC.employeecode AND AA.parentemployeecode = CC.parentemployeecode
        AND AA.enterprisecode = CC.enterprisecode AND AA.brandcode = CC.brandcode) AS UU
  WHERE (allDepositMoney > 0 OR allTakeMoney > 0) LIMIT var_start, var_end;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_deposit_withdrawals_count
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_deposit_withdrawals_count`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_deposit_withdrawals_count`(IN employee_id varchar(10),
IN date_begin date,
IN date_end date,
IN var_start int,
IN var_end int,
OUT param1 int)
BEGIN
  /*
用户存取统计
*/
  IF ISNULL(date_begin) = 1 AND ISNULL(date_end) = 1 THEN
    SET date_begin = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;
  SELECT
    COUNT(1) INTO param1
  FROM (SELECT
      AA.loginaccount,
      AA.employeecode,
      BB.deposit_mount AS allDepositMoney,
      BB.deposit_num AS depositNumber,
      CC.take_mount AS allTakeMoney,
      CC.take_num AS quantity
    FROM (SELECT
        loginaccount,
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode
      FROM enterprise_employee
      WHERE parentemployeecode = employee_id
      AND employeetypecode = 'T003'
      AND datastatus = 1) AS AA
      LEFT JOIN (SELECT
          employeecode,
          parentemployeecode,
          enterprisecode,
          brandcode,
          SUM(orderamount) AS deposit_mount,
          COUNT(1) AS deposit_num
        FROM deposit_withdraw_order
        WHERE ordertype = 1
        AND orderstatus = 2
        AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
        GROUP BY employeecode,
                 parentemployeecode,
                 enterprisecode,
                 brandcode) AS BB
        ON AA.employeecode = BB.employeecode
        AND AA.parentemployeecode = BB.parentemployeecode AND AA.enterprisecode = BB.enterprisecode
        AND AA.brandcode = BB.brandcode
      LEFT JOIN (SELECT
          employeecode,
          parentemployeecode,
          enterprisecode,
          brandcode,
          SUM(orderamount) AS take_mount,
          COUNT(1) AS take_num
        FROM deposit_withdraw_order
        WHERE ordertype = 2
        AND orderstatus = 2
        AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
        GROUP BY employeecode,
                 parentemployeecode,
                 enterprisecode,
                 brandcode) AS CC
        ON AA.employeecode = CC.employeecode
        AND AA.parentemployeecode = CC.parentemployeecode AND AA.enterprisecode = CC.enterprisecode
        AND AA.brandcode = CC.brandcode) AS HH;

  SELECT
    AA.loginaccount,
    AA.employeecode,
    BB.deposit_mount AS allDepositMoney,
    BB.deposit_num AS depositNumber,
    CC.take_mount AS allTakeMoney,
    CC.take_num AS quantity
  FROM (SELECT
      loginaccount,
      employeecode,
      parentemployeecode,
      enterprisecode,
      brandcode
    FROM enterprise_employee
    WHERE parentemployeecode = employee_id
    AND employeetypecode = 'T003'
    AND datastatus = 1) AS AA
    LEFT JOIN (SELECT
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode,
        SUM(orderamount) AS deposit_mount,
        COUNT(1) AS deposit_num
      FROM deposit_withdraw_order
      WHERE ordertype = 1
      AND orderstatus = 2
      AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
      GROUP BY employeecode,
               parentemployeecode,
               enterprisecode,
               brandcode) AS BB
      ON AA.employeecode = BB.employeecode
      AND AA.parentemployeecode = BB.parentemployeecode AND AA.enterprisecode = BB.enterprisecode
      AND AA.brandcode = BB.brandcode
    LEFT JOIN (SELECT
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode,
        SUM(orderamount) AS take_mount,
        COUNT(1) AS take_num
      FROM deposit_withdraw_order
      WHERE ordertype = 2
      AND orderstatus = 2
      AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
      GROUP BY employeecode,
               parentemployeecode,
               enterprisecode,
               brandcode) AS CC
      ON AA.employeecode = CC.employeecode
      AND AA.parentemployeecode = CC.parentemployeecode AND AA.enterprisecode = CC.enterprisecode
      AND AA.brandcode = CC.brandcode LIMIT var_start, var_end;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_deposit_withdrawals_count_bak
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_deposit_withdrawals_count_bak`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_deposit_withdrawals_count_bak`(IN employee_id varchar(10),
IN date_begin date,
IN date_end date,
IN var_start int,
IN var_end int,
OUT param1 int)
BEGIN
  /*
   备份 --用户存取统计
*/
  IF ISNULL(date_begin) = 1 AND ISNULL(date_end) = 1 THEN
    SET date_begin = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;

  SELECT
    COUNT(1) INTO param1
  FROM (SELECT
      AA.loginaccount,
      AA.employeecode,
      BB.deposit_mount AS allDepositMoney,
      BB.deposit_num AS depositNumber,
      CC.take_mount AS allTakeMoney,
      CC.take_num AS quantity
    FROM (SELECT
        loginaccount,
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode
      FROM enterprise_employee
      WHERE parentemployeecode = employee_id
      AND employeetypecode = 'T003'
      AND datastatus = 1) AS AA
      LEFT JOIN (SELECT
          employeecode,
          parentemployeecode,
          enterprisecode,
          brandcode,
          SUM(orderamount) AS deposit_mount,
          COUNT(1) AS deposit_num
        FROM deposit_withdraw_order
        WHERE ordertype = 1
        AND orderstatus = 2
        AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
        GROUP BY employeecode,
                 parentemployeecode,
                 enterprisecode,
                 brandcode) AS BB
        ON AA.employeecode = BB.employeecode
        AND AA.parentemployeecode = BB.parentemployeecode AND AA.enterprisecode = BB.enterprisecode
        AND AA.brandcode = BB.brandcode
      LEFT JOIN (SELECT
          employeecode,
          parentemployeecode,
          enterprisecode,
          brandcode,
          SUM(orderamount) AS take_mount,
          COUNT(1) AS take_num
        FROM deposit_withdraw_order
        WHERE ordertype = 2
        AND orderstatus = 2
        AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
        GROUP BY employeecode,
                 parentemployeecode,
                 enterprisecode,
                 brandcode) AS CC
        ON AA.employeecode = CC.employeecode
        AND AA.parentemployeecode = CC.parentemployeecode AND AA.enterprisecode = CC.enterprisecode
        AND AA.brandcode = CC.brandcode) AS HH;

  /*会员存取统计*/
  SELECT
    AA.loginaccount,
    AA.employeecode,
    BB.deposit_mount AS allDepositMoney,
    BB.deposit_num AS depositNumber,
    CC.take_mount AS allTakeMoney,
    CC.take_num AS quantity
  FROM (SELECT
      loginaccount,
      employeecode,
      parentemployeecode,
      enterprisecode,
      brandcode
    FROM enterprise_employee
    WHERE parentemployeecode = employee_id
    AND employeetypecode = 'T003'
    AND datastatus = 1) AS AA
    LEFT JOIN (SELECT
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode,
        SUM(orderamount) AS deposit_mount,
        COUNT(1) AS deposit_num
      FROM deposit_withdraw_order
      WHERE ordertype = 1
      AND orderstatus = 2
      AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
      GROUP BY employeecode,
               parentemployeecode,
               enterprisecode,
               brandcode) AS BB
      ON AA.employeecode = BB.employeecode
      AND AA.parentemployeecode = BB.parentemployeecode AND AA.enterprisecode = BB.enterprisecode
      AND AA.brandcode = BB.brandcode
    LEFT JOIN (SELECT
        employeecode,
        parentemployeecode,
        enterprisecode,
        brandcode,
        SUM(orderamount) AS take_mount,
        COUNT(1) AS take_num
      FROM deposit_withdraw_order
      WHERE ordertype = 2
      AND orderstatus = 2
      AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN date_begin AND date_end
      GROUP BY employeecode,
               parentemployeecode,
               enterprisecode,
               brandcode) AS CC
      ON AA.employeecode = CC.employeecode
      AND AA.parentemployeecode = CC.parentemployeecode AND AA.enterprisecode = CC.enterprisecode
      AND AA.brandcode = CC.brandcode LIMIT var_start, var_end;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_deposit_withdrawals_rate
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_deposit_withdrawals_rate`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_deposit_withdrawals_rate`(IN in_enterprisecode char(8), IN in_loginaccount char(8), IN startDate datetime, IN endDate datetime, IN start_index INTEGER, IN limit_count INTEGER, OUT countNumber INTEGER)
    READS SQL DATA
BEGIN
        
        SELECT count(1) INTO countNumber FROM (
                SELECT s.employeecode  FROM deposit_withdraw_order s LEFT JOIN enterprise_employee ee ON ee.employeecode=s.employeecode 
                WHERE s.orderstatus='2' AND s.enterprisecode=in_enterprisecode AND (s.orderdate >= startDate AND s.orderdate <= endDate) and IF (in_loginaccount is NULL, 0 = 0, ee.loginaccount = in_loginaccount)
                GROUP BY employeecode
        ) as c;
        

        
        SELECT employeecode,loginaccount,savemoney,takemoney,savecount,takecount FROM (
        
                SELECT s.employeecode ,ee.loginaccount,
                        SUM(CASE  WHEN s.ordertype=1 THEN s.orderamount ELSE 0 END ) AS savemoney , 
                        SUM(CASE  WHEN s.ordertype=2 THEN s.orderamount ELSE 0 END ) AS takemoney ,
                        SUM(CASE  WHEN s.ordertype=1 THEN 1 ELSE 0 END ) AS savecount , 
                        SUM(CASE  WHEN s.ordertype=2 THEN 1 ELSE 0 END ) AS takecount 
                
                FROM deposit_withdraw_order s LEFT JOIN enterprise_employee ee ON ee.employeecode=s.employeecode 
                WHERE s.orderstatus='2' AND s.enterprisecode=in_enterprisecode AND (s.orderdate >= startDate AND s.orderdate <= endDate) and IF (in_loginaccount is NULL, 0 = 0, ee.loginaccount = in_loginaccount)
                GROUP BY s.employeecode 
                
        ) AS t ORDER BY takemoney,takecount DESC LIMIT start_index, limit_count;
          
          
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_game_down_member
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_game_down_member`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_game_down_member`(IN employee_id varchar(10),
IN start_date date,
IN date_end date,
IN startd int,
IN endsd int,
OUT param1 int,OUT param2 decimal,OUT param3 decimal,OUT param4 decimal)
BEGIN
  /*
 二次查询游戏报表----直线会员游戏报表显示
*/
  IF startd = 0 THEN
    SET startd = 0;
  END IF;
  IF endsd = 0 THEN
    SET endsd = 10;
  END IF;
  IF ISNULL(start_date) = 1 AND ISNULL(date_end) = 1 THEN
    SET start_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;

  SELECT
    COUNT(1) ,
   sum(HH.game_betting_amount) , 
   sum(HH.bonus) , 
   sum(HH.lose_win_amount) INTO param1,param2,param3, param4
   

  FROM (SELECT
      AA.employeecode,
      AA.loginaccount,
      COUNT(1) AS num,
      CONCAT(CC.employeetype, '_nodown') AS employeetypename,
      GG.Bet_Money AS game_betting_amount,
      GG.Net_Money AS lose_win_amount,
      GG.Net_Money + GG.Valid_Money * GG.bonus AS user_lose_win_amount,
      GG.Valid_Money * GG.bonus AS bonus
    FROM enterprise_employee AS AA
      INNER JOIN (SELECT
          BB.employeecode,
          BB.parentemployeecode,
          BB.enterprisecode,
          BB.Game_Platform,
          BB.Game_Type,
          game.gamename,
          SUM(BB.Bet_Money) AS Bet_Money,
          SUM(BB.Net_Money) AS Net_Money,
          SUM(BB.Valid_Money) AS Valid_Money,
          SUM(DD.bonus) AS bonus
        FROM betting_all_day BB
          INNER JOIN employee_gamecataloy_bonus AS DD
            ON BB.employeecode = DD.employeecode AND BB.Game_Platform = DD.gametype AND BB.Game_Big_Type = DD.categorytype
          INNER JOIN game
            ON BB.Game_Platform = game.gametype
            AND DATE_FORMAT(BB.Bet_Day, '%Y-%m-%d') BETWEEN start_date AND date_end
        GROUP BY BB.employeecode,
                 BB.parentemployeecode,
                 BB.enterprisecode,
                 BB.Game_Platform,
                 game.gamename,
                 BB.Game_Type) AS GG
        ON AA.employeecode = GG.employeecode AND AA.parentemployeecode = GG.parentemployeecode AND AA.enterprisecode = GG.enterprisecode
      INNER JOIN enterprise_employee_type AS CC
        ON AA.employeetypecode = CC.employeetypecode
    WHERE AA.parentemployeecode = employee_id
    AND AA.employeetypecode = 'T003'

    GROUP BY AA.employeecode,
             AA.loginaccount) AS HH;

  SELECT
    AA.employeecode,
    AA.loginaccount,
    COUNT(1) AS num,
    CONCAT(CC.employeetype, '_nodown') AS employeetypename,
    GG.Game_Platform AS gametype,
    GG.gamename,
    GG.Bet_Money AS game_betting_amount,
    GG.Net_Money AS lose_win_amount,
    GG.Net_Money + GG.Valid_Money * GG.bonus AS user_lose_win_amount,
    GG.Valid_Money * GG.bonus AS bonus
  FROM enterprise_employee AS AA
    INNER JOIN (SELECT
        BB.employeecode,
        BB.parentemployeecode,
        BB.enterprisecode,
        BB.Game_Platform,
        BB.Game_Type,
        game.gamename,
        SUM(BB.Bet_Money) AS Bet_Money,
        SUM(BB.Net_Money) AS Net_Money,
        SUM(BB.Valid_Money) AS Valid_Money,
        SUM(DD.bonus) AS bonus
      FROM betting_all_day BB
        INNER JOIN employee_gamecataloy_bonus AS DD
          ON BB.employeecode = DD.employeecode AND BB.Game_Platform = DD.gametype AND BB.Game_Big_Type = DD.categorytype
        INNER JOIN game
          ON BB.Game_Platform = game.gametype
          AND DATE_FORMAT(BB.Bet_Day, '%Y-%m-%d') BETWEEN start_date AND date_end
      GROUP BY BB.employeecode,
               BB.parentemployeecode,
               BB.enterprisecode,
               BB.Game_Platform,
               game.gamename,
               BB.Game_Type) AS GG
      ON AA.employeecode = GG.employeecode AND AA.parentemployeecode = GG.parentemployeecode AND AA.enterprisecode = GG.enterprisecode
    INNER JOIN enterprise_employee_type AS CC
      ON AA.employeetypecode = CC.employeetypecode
  WHERE AA.parentemployeecode = employee_id
  AND AA.employeetypecode = 'T003'

  GROUP BY AA.employeecode,
           AA.loginaccount,
           GG.Game_Platform,
           GG.gamename,
           GG.Bet_Money,
           GG.Net_Money,
           GG.Net_Money + GG.Valid_Money * GG.bonus,
           GG.Valid_Money * GG.bonus LIMIT startd, endsd;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_game_win_lose_rate
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_game_win_lose_rate`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_game_win_lose_rate`(
IN in_platformtype VARCHAR(10), 
IN in_loginaccount VARCHAR(20), 
IN in_enterprisecode CHAR(8), 
IN in_bettime_begin DATETIME, 
IN in_bettime_end DATETIME, 
IN in_start INTEGER,
IN in_limit INTEGER,
OUT countNumber INTEGER)
    READS SQL DATA
BEGIN
        
       select count(1) INTO  countNumber FROM (
       select loginaccount  from betting_all_game_winlose_detail 
                        WHERE (in_platformtype is null or platformtype=in_platformtype)
                        AND (in_loginaccount is null or loginaccount=in_loginaccount)
                        AND (enterprisecode=in_enterprisecode)                        
                        AND (bettime >= in_bettime_begin and bettime <= in_bettime_end)
                       group by platformtype,loginaccount
       ) as t1;
        
       select loginaccount,platformtype,sum1 as betmoney,sum2 as netmoney, FORMAT(rate,2) ratex from (      
                select loginaccount,platformtype,sum1,sum2,abs(sum2)/1.00/sum1*100 as rate from (
                        select loginaccount,platformtype,sum(betmoney) sum1,sum(netmoney) sum2  from betting_all_game_winlose_detail 
                        WHERE (in_platformtype is null or platformtype=in_platformtype)
                        AND (in_loginaccount is null or loginaccount=in_loginaccount)
                        AND (enterprisecode=in_enterprisecode)                        
                        AND (bettime >= in_bettime_begin and bettime <= in_bettime_end)
                        group by platformtype,loginaccount
                ) as t 
        ) as t2 order by rate desc limit in_start,in_limit ;
        
        
  
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_game_win_lose_work
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_game_win_lose_work`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_game_win_lose_work`(IN employee_id varchar(10),
IN begin_date date,
IN end_date date,
IN startsd int,
IN endsd int)
BEGIN
  /*
 二次查询游戏报表 ---代理团队下游戏报表
*/
  IF ISNULL(startsd) = 1 AND ISNULL(endsd) = 1 THEN
    SET startsd = 0;
    SET endsd = 10;
  END IF;
  IF ISNULL(begin_date) = 1 AND ISNULL(end_date) = 1 THEN
    SET begin_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET end_date = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;

  SELECT
    GROUP_AA.loginaccount,
    ufn_down_recursion_team_of_agent_count(GROUP_AA.employeecode) AS num,
    GROUP_AA.employeecode,
    Game_B.Bet_Money AS game_betting_amount,
    Game_B.bonus,
    Game_B.Net_Money + Game_B.bonus AS lose_win_amount
  FROM enterprise_employee GROUP_AA
    INNER JOIN (SELECT
        A.enterprisecode,
        A.employeecode,
        A.parentemployeecode,
        A.Game_Platform,
        A.Game_Type,
        SUM(A.Bet_Money) AS Bet_Money,
        SUM(A.Net_Money) AS Net_Money,
        SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
      FROM betting_all_day AS A
        INNER JOIN employee_gamecataloy_bonus AS B
          ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
          AND A.Game_Big_Type = B.categorytype
          AND A.Bet_Day BETWEEN begin_date AND end_date
      GROUP BY A.enterprisecode,
               A.employeecode,
               A.parentemployeecode,
               A.Game_Platform,
               A.Game_Type) AS Game_B
      ON GROUP_AA.employeecode = Game_B.employeecode
      AND GROUP_AA.parentemployeecode = Game_B.parentemployeecode
      AND GROUP_AA.enterprisecode = Game_B.enterprisecode
  WHERE GROUP_AA.parentemployeecode = employee_id
  AND GROUP_AA.employeetypecode = 'T004'
  UNION ALL
  SELECT
    '直线会员' AS loginaccount,
    num,
    employee_id AS employeecode,
    Bet_Money AS game_betting_amount,
    bonus,
    net_Money + bonus AS lose_win_amount
  FROM (SELECT
      LINE_AA.loginaccount,
      COUNT(1) AS num,
      LINE_AA.employeecode,
      Game_B.Bet_Money,
      Game_B.net_Money,
      Game_B.bonus,
      Game_B.Net_Money + Game_B.bonus
    FROM enterprise_employee AS LINE_AA
      INNER JOIN (SELECT
          A.enterprisecode,
          A.employeecode,
          A.parentemployeecode,
          A.Game_Platform,
          A.Game_Type,
          SUM(A.Bet_Money) AS Bet_Money,
          SUM(A.Net_Money) AS Net_Money,
          SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
        FROM betting_all_day AS A
          INNER JOIN employee_gamecataloy_bonus AS B
            ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
            AND A.Game_Big_Type = B.categorytype
            AND A.Bet_Day BETWEEN begin_date AND end_date
        GROUP BY A.enterprisecode,
                 A.employeecode,
                 A.parentemployeecode,
                 A.Game_Platform,
                 A.Game_Type) AS Game_B
        ON LINE_AA.employeecode = Game_B.employeecode
        AND LINE_AA.parentemployeecode = Game_B.parentemployeecode
        AND LINE_AA.enterprisecode = Game_B.enterprisecode
    WHERE LINE_AA.parentemployeecode = employee_id
    AND LINE_AA.employeetypecode = 'T003') AS FF
  WHERE FF.num > 0 LIMIT startsd, endsd;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_line_game_recording
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_line_game_recording`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_line_game_recording`(IN employee_id varchar(10),
IN start_date date,
IN date_end date,
IN startd int,
IN endsd int)
BEGIN
  /*
 二次查询游戏报表----直线会员游戏报表显示
*/
  IF startd = 0 THEN
    SET startd = 0;
  END IF;
  IF endsd = 0 THEN
    SET endsd = 10;
  END IF;
  IF ISNULL(start_date) = 1 AND ISNULL(date_end) = 1 THEN
    SET start_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;

  SELECT
    AA.employeecode,
    AA.loginaccount,
    COUNT(1) AS num,
    CONCAT(CC.employeetype, '_nodown') AS employeetypename,
    GG.Game_Platform,
    GG.gamename,
    GG.Bet_Money AS game_betting_amount,
    GG.Net_Money AS lose_win_amount,
    GG.Net_Money + GG.Valid_Money * GG.bonus AS user_lose_win_amount,
    GG.Valid_Money * GG.bonus AS bonus
  FROM enterprise_employee AS AA
    INNER JOIN (SELECT
        BB.employeecode,
        BB.parentemployeecode,
        BB.enterprisecode,
        BB.Game_Platform,
        game.gamename,
        BB.Game_Type,
        SUM(BB.Bet_Money) AS Bet_Money,
        SUM(BB.Net_Money) AS Net_Money,
        SUM(BB.Valid_Money) AS Valid_Money,
        SUM(DD.bonus) AS bonus
      FROM betting_all_day BB
        INNER JOIN employee_gamecataloy_bonus AS DD
          ON BB.employeecode = DD.employeecode AND BB.Game_Platform = DD.gametype AND BB.Game_Big_Type = DD.categorytype
        INNER JOIN game
          ON BB.Game_Platform = game.gametype
          AND DATE_FORMAT(BB.Bet_Day, '%Y-%m-%d') BETWEEN start_date AND date_end
      GROUP BY BB.employeecode,
               BB.parentemployeecode,
               BB.enterprisecode,
               BB.Game_Platform,
               game.gamename,
               BB.Game_Type) AS GG
      ON AA.employeecode = GG.employeecode AND AA.parentemployeecode = GG.parentemployeecode AND AA.enterprisecode = GG.enterprisecode
    INNER JOIN enterprise_employee_type AS CC
      ON AA.employeetypecode = CC.employeetypecode
  WHERE AA.parentemployeecode = employee_id
  AND AA.employeetypecode = 'T003'

  GROUP BY AA.employeecode,
           AA.loginaccount LIMIT startd, endsd;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_login_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_login_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_login_info`(IN login varchar(10),
IN ip varchar(20),
IN startd int,
IN send int,
OUT param1 int)
BEGIN
  /*
		客户登陆分析
  */
  DECLARE var_login varchar(12);
  DECLARE var_ip varchar(20);
  DECLARE var_start int;
  DECLARE var_end int;

  IF LENGTH(TRIM(login)) > 0 THEN
    SET var_login = login;
  ELSEIF ISNULL(login) = 1 THEN
    SET var_login = '';
  END IF;


  IF LENGTH(TRIM(ip)) > 0 THEN
    SET var_ip = ip;
  ELSEIF ISNULL(ip) = 1 THEN
    SET var_ip = '';
  END IF;

  IF startd = 0 THEN
    SET var_start = 0;
  ELSE
    SET var_start = startd;
  END IF;

  IF send = 0 THEN
    SET var_end = 10;
  ELSE
    SET var_end = send;
  END IF;

  IF ((LENGTH(TRIM(login)) <> 0 AND LENGTH(TRIM(ip)) <> 0) AND (ISNULL(ip) <> 1 AND ISNULL(login) <> 1)) THEN ##当用户和IP都为不为空时

    SELECT
      COUNT(1) INTO param1
    FROM (SELECT
        *
      FROM (SELECT
          loginip,
          CONCAT(var_login, ',', GROUP_CONCAT(DISTINCT loginaccount)) AS loginaccount
        FROM log_login
        WHERE loginip IN (SELECT DISTINCT
            loginip
          FROM log_login
          WHERE loginaccount = var_login) AND loginaccount <> var_login
        GROUP BY loginip
        UNION ALL
        SELECT
          loginip,
          GROUP_CONCAT(DISTINCT loginaccount) AS loginaccount
        FROM log_login
        WHERE loginip NOT IN (SELECT
            loginip
          FROM log_login
          WHERE loginip IN (SELECT DISTINCT
              loginip
            FROM log_login
            WHERE loginaccount = var_login) AND loginaccount <> var_login) AND loginaccount = var_login
        GROUP BY loginip) a
      WHERE loginip = var_ip) a;

    SELECT
      *
    FROM (SELECT
        loginip,
        CONCAT(var_login, ',', GROUP_CONCAT(DISTINCT loginaccount)) AS loginaccount
      FROM log_login
      WHERE loginip IN (SELECT DISTINCT
          loginip
        FROM log_login
        WHERE loginaccount = var_login) AND loginaccount <> var_login
      GROUP BY loginip
      UNION ALL
      SELECT
        loginip,
        GROUP_CONCAT(DISTINCT loginaccount) AS loginaccount
      FROM log_login
      WHERE loginip NOT IN (SELECT
          loginip
        FROM log_login
        WHERE loginip IN (SELECT DISTINCT
            loginip
          FROM log_login
          WHERE loginaccount = var_login) AND loginaccount <> var_login) AND loginaccount = var_login
      GROUP BY loginip) a
    WHERE loginip = var_ip;

  ELSEIF (LENGTH(TRIM(login)) > 0 AND ISNULL(login) <> 1) THEN ##用户不为空时
    SELECT
      COUNT(1) INTO param1
    FROM (SELECT
        loginip,
        CONCAT(var_login, ',', GROUP_CONCAT(DISTINCT loginaccount)) AS loginaccount
      FROM log_login
      WHERE loginip IN (SELECT DISTINCT
          loginip
        FROM log_login
        WHERE loginaccount = var_login) AND loginaccount <> var_login
      GROUP BY loginip
      UNION ALL
      SELECT
        loginip,
        GROUP_CONCAT(DISTINCT loginaccount) AS loginaccount
      FROM log_login
      WHERE loginip NOT IN (SELECT
          loginip
        FROM log_login
        WHERE loginip IN (SELECT DISTINCT
            loginip
          FROM log_login
          WHERE loginaccount = var_login) AND loginaccount <> var_login) AND loginaccount = var_login
      GROUP BY loginip) AS DD;

    SELECT
      loginip,
      CONCAT(var_login, ',', GROUP_CONCAT(DISTINCT loginaccount)) AS loginaccount
    FROM log_login
    WHERE loginip IN (SELECT DISTINCT
        loginip
      FROM log_login
      WHERE loginaccount = var_login) AND loginaccount <> var_login
    GROUP BY loginip
    UNION ALL
    SELECT
      loginip,
      GROUP_CONCAT(DISTINCT loginaccount) AS loginaccount
    FROM log_login
    WHERE loginip NOT IN (SELECT
        loginip
      FROM log_login
      WHERE loginip IN (SELECT DISTINCT
          loginip
        FROM log_login
        WHERE loginaccount = var_login) AND loginaccount <> var_login) AND loginaccount = var_login
    GROUP BY loginip;

  ELSEIF (LENGTH(TRIM(ip)) > 0 AND ISNULL(ip) <> 1) THEN ##当IP不为空时

    SELECT
      COUNT(1) INTO param1
    FROM (SELECT
        a.loginip AS loginip,
        GROUP_CONCAT(a.loginaccount) AS loginaccount
      FROM (SELECT DISTINCT
          loginip,
          loginaccount
        FROM log_login
        WHERE loginip = var_ip) a
      GROUP BY a.loginip LIMIT var_start, var_end) a;

    SELECT
      a.loginip AS loginip,
      GROUP_CONCAT(a.loginaccount) AS loginaccount
    FROM (SELECT DISTINCT
        loginip,
        loginaccount
      FROM log_login
      WHERE loginip = var_ip) a
    GROUP BY a.loginip LIMIT var_start, var_end;
  ELSEIF ((LENGTH(TRIM(login)) = 0 AND LENGTH(TRIM(ip)) = 0) OR (ISNULL(ip) = 1 AND ISNULL(login) = 1)) THEN ##当用户和IP都为空时
    SELECT
      COUNT(1) INTO param1
    FROM (SELECT
        a.loginip AS loginip,
        GROUP_CONCAT(a.loginaccount) AS loginaccount
      FROM (SELECT DISTINCT
          loginip,
          loginaccount
        FROM log_login) a
      GROUP BY a.loginip LIMIT var_start, var_end) a;

    SELECT
      a.loginip AS loginip,
      GROUP_CONCAT(a.loginaccount) AS loginaccount
    FROM (SELECT DISTINCT
        loginip,
        loginaccount
      FROM log_login) a
    GROUP BY a.loginip LIMIT var_start, var_end;
  END IF;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_lose_ranking
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_lose_ranking`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_lose_ranking`(IN employee_id varchar(10),
IN start_end date,
IN date_end date)
BEGIN
  /*
 客户输排名
*/
  IF ISNULL(start_end) = 1 AND ISNULL(date_end) = 1 THEN
    SET start_end = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;
  SELECT
    User_Name,
    employeecode,
    NetMoney,
    start_date,
    end_date
  FROM (SELECT
      B.User_Name,
      A.employeecode,
      SUM(B.Net_Money) AS NetMoney,
      start_end AS start_date,
      date_end AS end_date
    FROM (SELECT
        *
      FROM enterprise_employee
      WHERE parentemployeecode = employee_id) AS A
      INNER JOIN betting_all_day AS B
        ON A.employeecode = B.employeecode
    WHERE B.Bet_Day BETWEEN start_end AND date_end
    GROUP BY B.User_Name,
             A.employeecode) AS HH
  WHERE NetMoney < 0
  ORDER BY NetMoney ASC LIMIT 0, 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_lose_wins_count
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_lose_wins_count`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_lose_wins_count`(IN employeecode varchar(10),
IN date_begin date,
IN date_end date,
IN var_start int,
IN var_end int,
OUT param1 int)
BEGIN
  /*
	客户输赢统计
*/
  IF ISNULL(date_begin) = 1 AND ISNULL(date_end) = 1 THEN
    SET date_begin = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;
  SELECT
    COUNT(1) INTO param1
  FROM (SELECT
      FF.loginaccount,
      FF.num,
      FF.employeecode,
      FF.employeetypename,
      GG.Bet_Money AS game_betting_amount,
      GG.net_money AS lose_win_amount,
      GG.Valid_Money * GG.bonus AS bonus,
      CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
        END AS dividend,
      CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
        END AS share,
      CASE
          WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
          ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
        END AS user_lose_win_amount

    FROM (SELECT
        A.employeecode,
        A.enterprisecode,
        A.brandcode,
        A.loginaccount,
        A.employeetypecode,
        CC.employeetype AS employeetypename,
        ufn_down_recursion_team_of_agent_count(A.employeecode) AS num,
        SUM(dividend) AS dividend,
        SUM(share) AS hare
      FROM enterprise_employee A
        INNER JOIN enterprise_employee_type AS CC
          ON A.employeetypecode = CC.employeetypecode
      WHERE A.parentemployeecode = employeecode
      AND A.employeetypecode = 'T004'
      GROUP BY A.loginaccount,
               A.employeecode,
               A.employeetypecode) FF
      INNER JOIN (SELECT
          C.employeecode,
          C.enterprisecode,
          C.brandcode,
          SUM(C.Bet_Money) AS Bet_Money,
          SUM(C.net_money) AS net_money,
          SUM(C.Valid_Money) AS Valid_Money,
          SUM(D.bonus) AS bonus
        FROM betting_all_day AS C
          INNER JOIN employee_gamecataloy_bonus AS D
            ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
            AND DATE_FORMAT(C.Bet_Day, '%Y-%m-%d') BETWEEN date_begin AND date_end
        GROUP BY C.employeecode,
                 C.enterprisecode,
                 C.brandcode) AS GG
        ON FF.employeecode = GG.employeecode
        AND FF.enterprisecode = GG.enterprisecode
    UNION ALL
    SELECT
      '直线会员' AS loginaccount,
      COUNT(1) AS num,
      employeecode AS employeecode,
      (SELECT
          employeetype
        FROM enterprise_employee_type
        WHERE employeetypecode = 'T003') AS employeetypename,
      GG.Bet_Money AS game_betting_amount,
      GG.net_money AS lose_win_amount,
      SUM(GG.Valid_Money * GG.bonus) AS bonus,
      SUM(CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
        END) AS dividend,
      SUM(CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
        END) AS share,
      SUM(CASE
          WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
          ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
        END) AS user_lose_win_amount
    FROM (SELECT
        A.employeecode,
        A.enterprisecode,
        A.brandcode,
        A.loginaccount,
        A.employeetypecode,
        SUM(dividend) AS dividend,
        SUM(share) AS hare
      FROM enterprise_employee A
      WHERE A.parentemployeecode = employeecode
      AND A.employeetypecode = 'T003'
      GROUP BY A.loginaccount,
               A.employeecode,
               A.employeetypecode) FF
      INNER JOIN (SELECT
          C.employeecode,
          C.enterprisecode,
          C.brandcode,
          C.Game_Platform,
          C.Game_Big_Type,
          SUM(C.Bet_Money) AS Bet_Money,
          SUM(C.net_money) AS net_money,
          SUM(C.Valid_Money) AS Valid_Money,
          SUM(D.bonus) AS bonus
        FROM betting_all_day AS C
          INNER JOIN employee_gamecataloy_bonus AS D
            ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
            AND DATE_FORMAT(C.Bet_Day, '%Y-%m-%d') BETWEEN date_begin AND date_end
        GROUP BY C.employeecode,
                 C.enterprisecode,
                 C.brandcode,
                 C.Game_Platform,
                 C.Game_Big_Type) AS GG
        ON FF.employeecode = GG.employeecode
        AND FF.enterprisecode = GG.enterprisecode) AS HH;


  SELECT
    FF.loginaccount,
    FF.num,
    FF.employeecode,
    FF.employeetypename,
    GG.Bet_Money AS game_betting_amount,
    GG.net_money AS lose_win_amount,
    GG.Valid_Money * GG.bonus AS bonus,
    CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
      END AS dividend,
    CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
      END AS share,
    CASE
        WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
        ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
      END AS user_lose_win_amount

  FROM (SELECT
      A.employeecode,
      A.enterprisecode,
      A.brandcode,
      A.loginaccount,
      A.employeetypecode,
      CC.employeetype AS employeetypename,
      ufn_down_recursion_team_of_agent_count(A.employeecode) AS num,
      SUM(dividend) AS dividend,
      SUM(share) AS hare
    FROM enterprise_employee A
      INNER JOIN enterprise_employee_type AS CC
        ON A.employeetypecode = CC.employeetypecode
    WHERE A.parentemployeecode = employeecode
    AND A.employeetypecode = 'T004'
    GROUP BY A.loginaccount,
             A.employeecode,
             A.employeetypecode) FF
    INNER JOIN (SELECT
        C.employeecode,
        C.enterprisecode,
        C.brandcode,
        SUM(C.Bet_Money) AS Bet_Money,
        SUM(C.net_money) AS net_money,
        SUM(C.Valid_Money) AS Valid_Money,
        SUM(D.bonus) AS bonus
      FROM betting_all_day AS C
        INNER JOIN employee_gamecataloy_bonus AS D
          ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
          AND DATE_FORMAT(C.Bet_Day, '%Y-%m-%d') BETWEEN date_begin AND date_end
      GROUP BY C.employeecode,
               C.enterprisecode,
               C.brandcode) AS GG
      ON FF.employeecode = GG.employeecode
      AND FF.enterprisecode = GG.enterprisecode
  UNION ALL
  SELECT
    loginaccount,
    num,
    employeecode,
    employeetypename,
    game_betting_amount,
    lose_win_amount,
    bonus,
    dividend,
    share,
    user_lose_win_amount
  FROM (SELECT
      '直线会员' AS loginaccount,
      COUNT(1) AS num,
      employeecode AS employeecode,
      '会员' AS employeetypename,
      GG.Bet_Money AS game_betting_amount,
      GG.net_money AS lose_win_amount,
      SUM(GG.Valid_Money * GG.bonus) AS bonus,
      SUM(CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
        END) AS dividend,
      SUM(CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
        END) AS share,
      SUM(CASE
          WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
          ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
        END) AS user_lose_win_amount
    FROM (SELECT
        A.employeecode,
        A.enterprisecode,
        A.brandcode,
        A.loginaccount,
        A.employeetypecode,
        SUM(dividend) AS dividend,
        SUM(share) AS hare
      FROM enterprise_employee A
      WHERE A.parentemployeecode = employeecode
      AND A.employeetypecode = 'T003'
      GROUP BY A.loginaccount,
               A.employeecode,
               A.employeetypecode) FF
      INNER JOIN (SELECT
          C.employeecode,
          C.enterprisecode,
          C.brandcode,
          C.Game_Platform,
          C.Game_Big_Type,
          SUM(C.Bet_Money) AS Bet_Money,
          SUM(C.net_money) AS net_money,
          SUM(C.Valid_Money) AS Valid_Money,
          SUM(D.bonus) AS bonus
        FROM betting_all_day AS C
          INNER JOIN employee_gamecataloy_bonus AS D
            ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
            AND DATE_FORMAT(C.Bet_Day, '%Y-%m-%d') BETWEEN date_begin AND date_end
        GROUP BY C.employeecode,
                 C.enterprisecode,
                 C.brandcode,
                 C.Game_Platform,
                 C.Game_Big_Type) AS GG
        ON FF.employeecode = GG.employeecode
        AND FF.enterprisecode = GG.enterprisecode) AS TT
  WHERE num > 0
  LIMIT var_start, var_end;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_negative_ranking
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_negative_ranking`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_negative_ranking`(IN employee_id varchar(10),
IN start_end date,
IN date_end date)
BEGIN
  /*
 客户输排名
*/
  SELECT
    B.User_Name,
    A.employeecode,
    SUM(B.Net_Money) AS Money,
    start_end AS date_ben,
    date_end AS date_end
  FROM (SELECT
      *
    FROM enterprise_employee
    WHERE parentemployeecode = employee_id
    AND logindatetime BETWEEN start_end AND date_end) AS A
    INNER JOIN betting_all_day AS B
      ON A.employeecode = B.employeecode
  GROUP BY B.User_Name,
           A.employeecode
  ORDER BY Money DESC LIMIT 0, 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_profit
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_profit`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_profit`(IN employeecode varchar(10),
IN date_begin date,
IN date_end date,
IN var_start int,
IN var_end int)
BEGIN
  /*
	利润表
*/
  IF ISNULL(var_start) = 1 AND ISNULL(var_end) = 1 THEN
    SET var_start = 0;
    SET var_end = 10;
  END IF;

  IF ISNULL(date_begin) = 1 AND ISNULL(date_end) = 1 THEN
    SET date_begin = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;

  SELECT
    FF.loginaccount,
    FF.num,
    FF.employeecode,
    GG.Bet_Money,
    GG.net_money,
    GG.Valid_Money * GG.bonus AS bonus,
    CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
      END AS dividend,
    CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
      END AS share,
    CASE
        WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
        ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
      END AS user_lose_win_amount

  FROM (SELECT
      A.employeecode,
      A.enterprisecode,
      A.brandcode,
      A.loginaccount,
      A.employeetypecode,
      ufn_down_recursion_team_of_agent_count(A.employeecode) AS num,
      SUM(dividend) AS dividend,
      SUM(share) AS hare
    FROM enterprise_employee A
    WHERE A.parentemployeecode = employeecode
    AND A.employeetypecode = 'T004'
    GROUP BY A.loginaccount,
             A.employeecode,
             A.employeetypecode) FF
    INNER JOIN (SELECT
        C.employeecode,
        C.enterprisecode,
        C.brandcode,
        SUM(C.Bet_Money) AS Bet_Money,
        SUM(C.net_money) AS net_money,
        SUM(C.Valid_Money) AS Valid_Money,
        SUM(D.bonus) AS bonus
      FROM betting_all_day AS C
        INNER JOIN employee_gamecataloy_bonus AS D
          ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
          AND C.Bet_Day BETWEEN date_begin AND date_end
      GROUP BY C.employeecode,
               C.enterprisecode,
               C.brandcode) AS GG
      ON FF.employeecode = GG.employeecode
      AND FF.enterprisecode = GG.enterprisecode AND FF.brandcode = GG.brandcode
  UNION ALL
  SELECT
    loginaccount,
    num,
    employeecode,
    bet_money,
    net_money,
    bonus,
    dividend,
    share,
    user_lose_win_amount
  FROM (SELECT
      '直线会员' AS loginaccount,
      COUNT(1) AS num,
      employeecode AS employeecode,
      GG.Bet_Money,
      GG.net_money,
      SUM(GG.Valid_Money * GG.bonus) AS bonus,
      SUM(CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
        END) AS dividend,
      SUM(CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
        END) AS share,
      SUM(CASE
          WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
          ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
        END) AS user_lose_win_amount
    FROM (SELECT
        A.employeecode,
        A.enterprisecode,
        A.brandcode,
        A.loginaccount,
        A.employeetypecode,
        SUM(dividend) AS dividend,
        SUM(share) AS hare
      FROM enterprise_employee A
      WHERE A.parentemployeecode = employeecode
      AND A.employeetypecode = 'T003'
      GROUP BY A.loginaccount,
               A.employeecode,
               A.employeetypecode) FF
      INNER JOIN (SELECT
          C.employeecode,
          C.enterprisecode,
          C.brandcode,
          SUM(C.Bet_Money) AS Bet_Money,
          SUM(C.net_money) AS net_money,
          SUM(C.Valid_Money) AS Valid_Money,
          SUM(D.bonus) AS bonus
        FROM betting_all_day AS C
          INNER JOIN employee_gamecataloy_bonus AS D
            ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
            AND C.Bet_Day BETWEEN date_begin AND date_end
        GROUP BY C.employeecode,
                 C.enterprisecode,
                 C.brandcode,
                 C.Game_Platform,
                 C.Game_Big_Type) AS GG
        ON FF.employeecode = GG.employeecode
        AND FF.enterprisecode = GG.enterprisecode AND FF.brandcode = GG.brandcode) AS TT
  WHERE num > 0 LIMIT var_start, var_end;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_profit_agent
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_profit_agent`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_profit_agent`(IN employeecode varchar(10),
IN date_begin date,
IN date_end date,
IN var_start int,
IN var_end int,
OUT param1 int)
BEGIN
  /*
	利润表
*/
  IF ISNULL(var_start) = 1 AND ISNULL(var_end) = 1 THEN
    SET var_start = 0;
    SET var_end = 10;
  END IF;

  IF ISNULL(date_begin) = 1 AND ISNULL(date_end) = 1 THEN
    SET date_begin = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;
  SELECT
    COUNT(1) INTO param1
  FROM (SELECT
      FF.loginaccount,
      FF.num,
      FF.employeecode,
      GG.Bet_Money,
      GG.net_money,
      GG.Valid_Money * GG.bonus AS bonus,
      CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
        END AS dividend,
      CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
        END AS share,
      CASE
          WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
          ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
        END AS user_lose_win_amount

    FROM (SELECT
        A.employeecode,
        A.enterprisecode,
        A.brandcode,
        A.loginaccount,
        A.employeetypecode,
        ufn_down_recursion_team_of_agent_count(A.employeecode) AS num,
        SUM(dividend) AS dividend,
        SUM(share) AS hare
      FROM enterprise_employee A
      WHERE A.parentemployeecode = employeecode
      AND A.employeetypecode = 'T004'
      GROUP BY A.loginaccount,
               A.employeecode,
               A.employeetypecode) FF
      INNER JOIN (SELECT
          C.employeecode,
          C.enterprisecode,
          C.brandcode,
          SUM(C.Bet_Money) AS Bet_Money,
          SUM(C.net_money) AS net_money,
          SUM(C.Valid_Money) AS Valid_Money,
          SUM(D.bonus) AS bonus
        FROM betting_all_day AS C
          INNER JOIN employee_gamecataloy_bonus AS D
            ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
            AND C.Bet_Day BETWEEN date_begin AND date_end
        GROUP BY C.employeecode,
                 C.enterprisecode,
                 C.brandcode) AS GG
        ON FF.employeecode = GG.employeecode
        AND FF.enterprisecode = GG.enterprisecode AND FF.brandcode = GG.brandcode
    UNION ALL
    SELECT
      '直线会员' AS loginaccount,
      COUNT(1) AS num,
      employeecode AS employeecode,
      GG.Bet_Money,
      GG.net_money,
      SUM(GG.Valid_Money * GG.bonus) AS bonus,
      SUM(CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
        END) AS dividend,
      SUM(CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
        END) AS share,
      SUM(CASE
          WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
          ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
        END) AS user_lose_win_amount
    FROM (SELECT
        A.employeecode,
        A.enterprisecode,
        A.brandcode,
        A.loginaccount,
        A.employeetypecode,
        SUM(dividend) AS dividend,
        SUM(share) AS hare
      FROM enterprise_employee A
      WHERE A.parentemployeecode = employeecode
      AND A.employeetypecode = 'T003'
      GROUP BY A.loginaccount,
               A.employeecode,
               A.employeetypecode) FF
      INNER JOIN (SELECT
          C.employeecode,
          C.enterprisecode,
          C.brandcode,
          SUM(C.Bet_Money) AS Bet_Money,
          SUM(C.net_money) AS net_money,
          SUM(C.Valid_Money) AS Valid_Money,
          SUM(D.bonus) AS bonus
        FROM betting_all_day AS C
          INNER JOIN employee_gamecataloy_bonus AS D
            ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
            AND C.Bet_Day BETWEEN date_begin AND date_end
        GROUP BY C.employeecode,
                 C.enterprisecode,
                 C.brandcode) AS GG
        ON FF.employeecode = GG.employeecode
        AND FF.enterprisecode = GG.enterprisecode AND FF.brandcode = GG.brandcode) AS HH;

  SELECT
    FF.loginaccount,
    FF.num,
    FF.employeecode,
    GG.Bet_Money,
    GG.net_money,
    GG.Valid_Money * GG.bonus AS bonus,
    CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
      END AS dividend,
    CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
      END AS share,
    CASE
        WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
        ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
      END AS user_lose_win_amount

  FROM (SELECT
      A.employeecode,
      A.enterprisecode,
      A.brandcode,
      A.loginaccount,
      A.employeetypecode,
      ufn_down_recursion_team_of_agent_count(A.employeecode) AS num,
      SUM(dividend) AS dividend,
      SUM(share) AS hare
    FROM enterprise_employee A
    WHERE A.parentemployeecode = employeecode
    AND A.employeetypecode = 'T004'
    GROUP BY A.loginaccount,
             A.employeecode,
             A.employeetypecode) FF
    INNER JOIN (SELECT
        C.employeecode,
        C.enterprisecode,
        C.brandcode,
        SUM(C.Bet_Money) AS Bet_Money,
        SUM(C.net_money) AS net_money,
        SUM(C.Valid_Money) AS Valid_Money,
        SUM(D.bonus) AS bonus
      FROM betting_all_day AS C
        INNER JOIN employee_gamecataloy_bonus AS D
          ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
          AND C.Bet_Day BETWEEN date_begin AND date_end
      GROUP BY C.employeecode,
               C.enterprisecode,
               C.brandcode) AS GG
      ON FF.employeecode = GG.employeecode
      AND FF.enterprisecode = GG.enterprisecode AND FF.brandcode = GG.brandcode
  UNION ALL
  SELECT
    loginaccount,
    num,
    employeecode,
    bet_money,
    net_money,
    bonus,
    dividend,
    SHARE,
    user_lose_win_amount
  FROM (SELECT
      '直线会员' AS loginaccount,
      COUNT(1) AS num,
      employeecode AS employeecode,
      GG.Bet_Money,
      GG.net_money,
      SUM(GG.Valid_Money * GG.bonus) AS bonus,
      SUM(CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
        END) AS dividend,
      SUM(CASE
          WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
        END) AS share,
      SUM(CASE
          WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
          ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
        END) AS user_lose_win_amount
    FROM (SELECT
        A.employeecode,
        A.enterprisecode,
        A.brandcode,
        A.loginaccount,
        A.employeetypecode,
        SUM(dividend) AS dividend,
        SUM(share) AS hare
      FROM enterprise_employee A
      WHERE A.parentemployeecode = employeecode
      AND A.employeetypecode = 'T003'
      GROUP BY A.loginaccount,
               A.employeecode,
               A.employeetypecode) FF
      INNER JOIN (SELECT
          C.employeecode,
          C.enterprisecode,
          C.brandcode,
          C.Game_Platform,
          C.Game_Big_Type,
          SUM(C.Bet_Money) AS Bet_Money,
          SUM(C.net_money) AS net_money,
          SUM(C.Valid_Money) AS Valid_Money,
          SUM(D.bonus) AS bonus
        FROM betting_all_day AS C
          INNER JOIN employee_gamecataloy_bonus AS D
            ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
            AND C.Bet_Day BETWEEN date_begin AND date_end
        GROUP BY C.employeecode,
                 C.enterprisecode,
                 C.brandcode,
                 C.Game_Platform,
                 C.Game_Big_Type) AS GG
        ON FF.employeecode = GG.employeecode
        AND FF.enterprisecode = GG.enterprisecode AND FF.brandcode = GG.brandcode) AS TT
  WHERE num > 0
  LIMIT var_start, var_end;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_profit_count
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_profit_count`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_profit_count`(IN employee_id varchar(10),
IN begin_date date,
IN end_date date,
IN startd int,
IN endsd int,
OUT param1 int, OUT param2 decimal, OUT param3 decimal, OUT param4 decimal, OUT param5 decimal, OUT param6 decimal,OUT param7 decimal)
BEGIN
  /*
 二次查询利润表


*/
  IF ISNULL(startd) = 1 AND ISNULL(endsd) = 1 THEN
    SET startd = 0;
    SET endsd = 10;
  END IF;
  IF ISNULL(begin_date) = 1 AND ISNULL(end_date) = 1 THEN
    SET begin_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET end_date = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;

  SELECT
    COUNT(1) ,HH.game_betting_amount,HH.lose_win_amount,HH.bonus,HH.dividend,HH.share,HH.profit_amount
   INTO param1,param2,param3,param4,param5,param6,param7

  FROM (SELECT
      GROUP_AA.loginaccount,
      ufn_down_recursion_team_of_agent_count(GROUP_AA.employeecode) AS num,
      GROUP_AA.employeecode,
      TT.employeetype AS employeetypename,
      Game_B.Bet_Money AS game_betting_amount,
      Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend) -
      ((Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share) AS lose_win_amount,
      Game_B.bonus,
      (Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend AS dividend,
      (Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share AS share,
      ((Game_B.Net_Money + Game_B.bonus) + (Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend) * GROUP_AA.share AS profit_amount
    FROM enterprise_employee GROUP_AA
      INNER JOIN (SELECT
          A.enterprisecode,
          A.employeecode,
          A.parentemployeecode,
          A.Game_Platform,
          A.Game_Type,
          SUM(A.Bet_Money) AS Bet_Money,
          SUM(A.Net_Money) AS Net_Money,
          SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
        FROM betting_all_day AS A
          INNER JOIN employee_gamecataloy_bonus AS B
            ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
            AND A.Game_Big_Type = B.categorytype
            AND A.Bet_Day BETWEEN begin_date AND end_date
        GROUP BY A.enterprisecode,
                 A.employeecode,
                 A.parentemployeecode,
                 A.Game_Platform,
                 A.Game_Type) AS Game_B
        ON GROUP_AA.employeecode = Game_B.employeecode
        AND GROUP_AA.parentemployeecode = Game_B.parentemployeecode
        AND GROUP_AA.enterprisecode = Game_B.enterprisecode
      LEFT JOIN enterprise_employee_type AS TT
        ON GROUP_AA.employeetypecode = TT.employeetypecode
    WHERE GROUP_AA.parentemployeecode = employee_id
    AND GROUP_AA.employeetypecode = 'T004'
    UNION ALL
    SELECT
      '直线会员' AS loginaccount,
      SUM(num) AS num,
      employee_id AS employeecode,
      '会员' AS employeetypename,
      Bet_Money AS game_betting_amount,
      net_Money + bonus + dividend - share AS lose_win_amount,
      bonus,
      dividend,
      share,
      ((Net_Money + bonus) + (Net_Money + bonus) * dividend) * share AS profit_amount
    FROM (SELECT
        LINE_AA.loginaccount,
        COUNT(1) AS num,
        LINE_AA.employeecode,
        Game_B.Bet_Money,
        Game_B.net_Money,
        Game_B.bonus,
        (Game_B.Net_Money + Game_B.bonus) * LINE_AA.dividend AS dividend,
        (Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * LINE_AA.dividend)) * LINE_AA.share AS share
      FROM enterprise_employee AS LINE_AA
        INNER JOIN (SELECT
            A.enterprisecode,
            A.employeecode,
            A.parentemployeecode,
            A.Game_Platform,
            A.Game_Type,
            SUM(A.Bet_Money) AS Bet_Money,
            SUM(A.Net_Money) AS Net_Money,
            SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
          FROM betting_all_day AS A
            INNER JOIN employee_gamecataloy_bonus AS B
              ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
              AND A.Game_Big_Type = B.categorytype
              AND A.Bet_Day BETWEEN begin_date AND end_date
          GROUP BY A.enterprisecode,
                   A.employeecode,
                   A.parentemployeecode,
                   A.Game_Platform,
                   A.Game_Type) AS Game_B
          ON LINE_AA.employeecode = Game_B.employeecode
          AND LINE_AA.parentemployeecode = Game_B.parentemployeecode
          AND LINE_AA.enterprisecode = Game_B.enterprisecode
      WHERE LINE_AA.parentemployeecode = employee_id
      AND LINE_AA.employeetypecode = 'T003') AS FF
    WHERE FF.num > 0) AS HH;

  SELECT
    GROUP_AA.loginaccount,
    ufn_down_recursion_team_of_agent_count(GROUP_AA.employeecode) AS num,
    GROUP_AA.employeecode,
    TT.employeetype AS employeetypename,
    Game_B.Bet_Money AS game_betting_amount,
    Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend) -
    ((Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share) AS lose_win_amount,
    Game_B.bonus,
    (Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend AS dividend,
    (Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend)) * GROUP_AA.share AS share,
    ((Game_B.Net_Money + Game_B.bonus) + (Game_B.Net_Money + Game_B.bonus) * GROUP_AA.dividend) * GROUP_AA.share AS profit_amount
  FROM enterprise_employee GROUP_AA
    INNER JOIN (SELECT
        A.enterprisecode,
        A.employeecode,
        A.parentemployeecode,
        A.Game_Platform,
        A.Game_Type,
        SUM(A.Bet_Money) AS Bet_Money,
        SUM(A.Net_Money) AS Net_Money,
        SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
      FROM betting_all_day AS A
        INNER JOIN employee_gamecataloy_bonus AS B
          ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
          AND A.Game_Big_Type = B.categorytype
          AND A.Bet_Day BETWEEN begin_date AND end_date
      GROUP BY A.enterprisecode,
               A.employeecode,
               A.parentemployeecode,
               A.Game_Platform,
               A.Game_Type) AS Game_B
      ON GROUP_AA.employeecode = Game_B.employeecode
      AND GROUP_AA.parentemployeecode = Game_B.parentemployeecode
      AND GROUP_AA.enterprisecode = Game_B.enterprisecode
    LEFT JOIN enterprise_employee_type AS TT
      ON GROUP_AA.employeetypecode = TT.employeetypecode
  WHERE GROUP_AA.parentemployeecode = employee_id
  AND GROUP_AA.employeetypecode = 'T004'
  UNION ALL
  SELECT
    loginaccount,
    num,
    employeecode,
    employeetypename,
    game_betting_amount,
    lose_win_amount,
    bonus,
    dividend,
    share,
    profit_amount
  FROM (SELECT
      '直线会员' AS loginaccount,
      SUM(num) AS num,
      employee_id AS employeecode,
      '会员' AS employeetypename,
      Bet_Money AS game_betting_amount,
      net_Money + bonus + dividend - share AS lose_win_amount,
      bonus,
      dividend,
      share,
      ((Net_Money + bonus) + (Net_Money + bonus) * dividend) * share AS profit_amount
    FROM (SELECT
        LINE_AA.loginaccount,
        COUNT(1) AS num,
        LINE_AA.employeecode,
        Game_B.Bet_Money,
        Game_B.net_Money,
        Game_B.bonus,
        (Game_B.Net_Money + Game_B.bonus) * LINE_AA.dividend AS dividend,
        (Game_B.Net_Money + Game_B.bonus + ((Game_B.Net_Money + Game_B.bonus) * LINE_AA.dividend)) * LINE_AA.share AS share
      FROM enterprise_employee AS LINE_AA
        INNER JOIN (SELECT
            A.enterprisecode,
            A.employeecode,
            A.parentemployeecode,
            A.Game_Platform,
            A.Game_Type,
            SUM(A.Bet_Money) AS Bet_Money,
            SUM(A.Net_Money) AS Net_Money,
            SUM(A.Valid_Money) * SUM(B.bonus) AS bonus
          FROM betting_all_day AS A
            INNER JOIN employee_gamecataloy_bonus AS B
              ON A.employeecode = B.employeecode AND A.Game_Platform = B.gametype
              AND A.Game_Big_Type = B.categorytype
              AND A.Bet_Day BETWEEN begin_date AND end_date
          GROUP BY A.enterprisecode,
                   A.employeecode,
                   A.parentemployeecode,
                   A.Game_Platform,
                   A.Game_Type) AS Game_B
          ON LINE_AA.employeecode = Game_B.employeecode
          AND LINE_AA.parentemployeecode = Game_B.parentemployeecode
          AND LINE_AA.enterprisecode = Game_B.enterprisecode
      WHERE LINE_AA.parentemployeecode = employee_id
      AND LINE_AA.employeetypecode = 'T003') AS FF
    WHERE FF.num > 0) AS TT
  WHERE num > 0 LIMIT startd, endsd;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_profit_member
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_profit_member`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_profit_member`(IN employee_id varchar(10),
IN start_date date,
IN date_end date,
IN startd int,
IN endsd int,
OUT param1 int, OUT param2 decimal, OUT param3 decimal, OUT param4 decimal, OUT param5 decimal, OUT param6 decimal,OUT param7 decimal)
BEGIN
  /*
 直线会员报表显示
*/
  IF ISNULL(startd) = 1 AND ISNULL(endsd) = 1 THEN
    SET startd = 0;
    SET endsd = 10;
  END IF;
  IF ISNULL(start_date) = 1 AND ISNULL(date_end) = 1 THEN
    SET start_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;

  SELECT
    COUNT(1) ,HH.game_betting_amount,HH.lose_win_amount,HH.bonus,HH.dividend,HH.share,HH.profit_amount
   INTO param1,param2,param3,param4,param5,param6,param7

  FROM (SELECT
      AA.employeecode,
      AA.loginaccount,
      COUNT(1) AS num,
      GG.Bet_Money AS game_betting_amount,
      GG.Net_Money + GG.Valid_Money * GG.bonus + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend + ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS lose_win_amount,
      GG.Valid_Money * GG.bonus AS bonus,
      (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend AS Dividend,
(GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend AS share,

      ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS profit_amount
    FROM enterprise_employee AS AA
      INNER JOIN (SELECT
          BB.employeecode,
          BB.parentemployeecode,
          BB.enterprisecode,
          BB.Game_Platform,
          BB.Game_Type,
          SUM(BB.Bet_Money) AS Bet_Money,
          SUM(BB.Net_Money) AS Net_Money,
          SUM(BB.Valid_Money) AS Valid_Money,
          SUM(DD.bonus) AS bonus
        FROM betting_all_day BB
          INNER JOIN employee_gamecataloy_bonus AS DD
            ON BB.employeecode = DD.employeecode AND BB.Game_Platform = DD.gametype AND BB.Game_Big_Type = DD.categorytype
            AND BB.Bet_Day BETWEEN start_date AND date_end
        GROUP BY BB.employeecode,
                 BB.parentemployeecode,
                 BB.enterprisecode,
                 BB.Game_Platform,
                 BB.Game_Type) AS GG
        ON AA.employeecode = GG.employeecode AND AA.parentemployeecode = GG.parentemployeecode AND AA.enterprisecode = GG.enterprisecode
    WHERE AA.parentemployeecode = employee_id
    AND AA.employeetypecode = 'T003'
    GROUP BY AA.employeecode,
             AA.loginaccount) AS HH;

  SELECT
    AA.employeecode,
    AA.loginaccount,
    COUNT(1) AS num,
    CONCAT(TT.employeetype, '_nodown') AS employeetypename,
    GG.Bet_Money AS game_betting_amount,
    GG.Net_Money + GG.Valid_Money * GG.bonus + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend + ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS lose_win_amount,
    GG.Valid_Money * GG.bonus AS bonus,
    (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend AS dividend,
    ((GG.Net_Money + GG.Valid_Money * GG.bonus) + (GG.Net_Money + GG.Valid_Money * GG.bonus) * AA.dividend) * AA.share AS profit_amount
  FROM enterprise_employee AS AA
    INNER JOIN (SELECT
        BB.employeecode,
        BB.parentemployeecode,
        BB.enterprisecode,
        BB.Game_Platform,
        BB.Game_Type,
        SUM(BB.Bet_Money) AS Bet_Money,
        SUM(BB.Net_Money) AS Net_Money,
        SUM(BB.Valid_Money) AS Valid_Money,
        SUM(DD.bonus) AS bonus
      FROM betting_all_day BB
        INNER JOIN employee_gamecataloy_bonus AS DD
          ON BB.employeecode = DD.employeecode AND BB.Game_Platform = DD.gametype AND BB.Game_Big_Type = DD.categorytype
          AND BB.Bet_Day BETWEEN start_date AND date_end
      GROUP BY BB.employeecode,
               BB.parentemployeecode,
               BB.enterprisecode,
               BB.Game_Platform,
               BB.Game_Type) AS GG
      ON AA.employeecode = GG.employeecode AND AA.parentemployeecode = GG.parentemployeecode AND AA.enterprisecode = GG.enterprisecode
    LEFT JOIN enterprise_employee_type AS TT
      ON AA.employeetypecode = TT.employeetypecode
  WHERE AA.parentemployeecode = employee_id
  AND AA.employeetypecode = 'T003'
  GROUP BY AA.employeecode,
           AA.loginaccount LIMIT startd, endsd;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_registered
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_registered`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_registered`(IN employee_id varchar(10),
IN num_id int)
BEGIN
  /*
	客户注册统计
*/
  DECLARE employeeid varchar(8);
  DECLARE rangetime date;
  DECLARE q_date_begin date;
  DECLARE q_date_end date;
  DECLARE start_date date;
  DECLARE date_end date;

  IF ISNULL(num_id) = 1 OR num_id = 1 THEN
    SET start_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 7 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;
  IF num_id = 2 THEN
    SET start_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 15 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;
  IF num_id = 3 THEN
    SET start_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;


  SET rangetime = start_date;
  DROP TABLE IF EXISTS temp_employeecode;
  CREATE TEMPORARY TABLE temp_employeecode (
    startDate date NOT NULL,
    endDate date NOT NULL,
    num int,
    employeetypename varchar(6)
  )
  DEFAULT charset = utf8;
  WHILE rangetime < date_end DO
    SET q_date_begin = ADDDATE(rangetime, INTERVAL 1 DAY);
    SET q_date_end = ADDDATE(rangetime, INTERVAL 1 DAY);
    SET rangetime = q_date_end;
    -- 直线
    INSERT INTO temp_employeecode (startDate, endDate, num, employeetypename)
      VALUES (q_date_begin, q_date_end, (SELECT COUNT(1) FROM enterprise_employee A WHERE A.parentemployeecode = employee_id AND A.datastatus = 1 AND DATE_FORMAT(A.logindatetime, '%Y-%m-%d') BETWEEN q_date_begin AND q_date_end), 'member');


    -- 团队
    INSERT INTO temp_employeecode (startDate, endDate, num, employeetypename)
      VALUES (q_date_begin, q_date_end, (SELECT COUNT(1) FROM enterprise_employee A WHERE FIND_IN_SET(A.parentemployeecode, (SELECT ufn_down_recursion_team_of_agent(ear.employeecode) AS code_id FROM enterprise_employee ear WHERE ear.employeecode = employee_id)) > 0 AND A.datastatus = 1 AND DATE_FORMAT(A.logindatetime, '%Y-%m-%d') BETWEEN q_date_begin AND q_date_end), 'user');

  END WHILE;

  SELECT
    startDate,
    endDate,
    num,
    employeetypename
  FROM temp_employeecode
  ORDER BY employeetypename, startDate;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_registered_bak
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_registered_bak`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_registered_bak`(IN employee_id varchar(10),
IN timeStap int,
IN start_date date,
IN date_end date)
BEGIN
  /*
	客户注册统计
*/
  DECLARE employeeid varchar(8);
  DECLARE row_num int;
  DECLARE rangetime date;
  DECLARE q_date_begin date;
  DECLARE q_date_end date;

  SET rangetime = start_date;
  DROP TABLE IF EXISTS temp_employeecode;
  CREATE TEMPORARY TABLE temp_employeecode (
    begin_date varchar(20) NOT NULL,
    end_date varchar(20) NOT NULL,
    rownum int,
    falg varchar(6)
  )
  DEFAULT charset = utf8;
  WHILE rangetime < date_end DO
    SET q_date_begin = ADDDATE(rangetime, INTERVAL 1 DAY);
    SET q_date_end = ADDDATE(rangetime, INTERVAL timeStap DAY);
    SET rangetime = q_date_end;
    -- 直线
    INSERT INTO temp_employeecode (begin_date, end_date, rownum, falg)
      VALUES (q_date_begin, q_date_end, (SELECT COUNT(1) FROM enterprise_employee A WHERE A.parentemployeecode = employee_id AND DATE(A.logindatetime) BETWEEN q_date_begin AND q_date_end), '会员');


    -- 团队
    INSERT INTO temp_employeecode (begin_date, end_date, rownum, falg)
      VALUES (q_date_begin, q_date_end, (SELECT COUNT(1) FROM enterprise_employee A WHERE FIND_IN_SET(A.parentemployeecode, (SELECT ufn_down_recursion_team_of_agent(ear.employeecode) AS code_id FROM enterprise_employee ear WHERE ear.employeecode = employee_id)) AND DATE(A.logindatetime) BETWEEN q_date_begin AND q_date_end), '代理');

  END WHILE;

  SELECT
    begin_date,
    end_date,
    rownum,
    falg
  FROM temp_employeecode
  ORDER BY falg, begin_date;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_registered_copy
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_registered_copy`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_registered_copy`(IN employee_id varchar(10),
IN start_date date,
IN date_end date)
BEGIN
  /*
	客户注册统计
*/
  DECLARE employeeid varchar(8);
  DECLARE rangetime date;
  DECLARE q_date_begin date;
  DECLARE q_date_end date;

  IF ISNULL(start_date) = 1 THEN
    SET start_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 7 DAY);
  END IF;
  IF ISNULL(date_end) = 1 THEN
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;


  SET rangetime = start_date;
  DROP TABLE IF EXISTS temp_employeecode;
  CREATE TEMPORARY TABLE temp_employeecode (
    startDate date NOT NULL,
    endDate date NOT NULL,
    num int,
    employeetypename varchar(6)
  )
  DEFAULT charset = utf8;
  WHILE rangetime < date_end DO
    SET q_date_begin = ADDDATE(rangetime, INTERVAL 1 DAY);
    SET q_date_end = ADDDATE(rangetime, INTERVAL 1 DAY);
    SET rangetime = q_date_end;
    -- 直线
    INSERT INTO temp_employeecode (startDate, endDate, num, employeetypename)
      VALUES (q_date_begin, q_date_end, (SELECT COUNT(1) FROM enterprise_employee A WHERE A.parentemployeecode = employee_id AND A.employeetypecode = 'T003' AND DATE(A.logindatetime) BETWEEN q_date_begin AND q_date_end), '会员');


    -- 团队
    INSERT INTO temp_employeecode (startDate, endDate, num, employeetypename)
      VALUES (q_date_begin, q_date_end, (SELECT COUNT(1) FROM enterprise_employee A WHERE FIND_IN_SET(A.parentemployeecode, (SELECT ufn_down_recursion_team_of_agent(ear.employeecode) AS code_id FROM enterprise_employee ear WHERE ear.employeecode = employee_id)) AND DATE(A.logindatetime) BETWEEN q_date_begin AND q_date_end), '代理');

  END WHILE;

  SELECT
    startDate,
    endDate,
    num,
    employeetypename
  FROM temp_employeecode
  ORDER BY employeetypename, startDate;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_win_ranking
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_win_ranking`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_win_ranking`(IN employee_id varchar(10),
IN start_end date,
IN date_end date)
BEGIN
  /*
 客户赢排名
*/
  IF ISNULL(start_end) = 1 AND ISNULL(date_end) = 1 THEN
    SET start_end = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET date_end = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;

  SELECT
    User_Name,
    employeecode,
    NetMoney,
    start_date,
    end_date
  FROM (SELECT
      B.User_Name,
      A.employeecode,
      SUM(B.Net_Money) AS NetMoney,
      start_end AS start_date,
      date_end AS end_date
    FROM (SELECT
        *
      FROM enterprise_employee
      WHERE parentemployeecode = employee_id) AS A
      INNER JOIN betting_all_day AS B
        ON A.employeecode = B.employeecode
    WHERE B.Bet_Day BETWEEN start_end AND date_end
    GROUP BY B.User_Name,
             A.employeecode) AS HH
  WHERE NetMoney > 0
  ORDER BY NetMoney DESC LIMIT 0, 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_user_wins_ranking
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_user_wins_ranking`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_user_wins_ranking`(IN employee_id varchar(10),
IN start_end date,
IN date_end date)
BEGIN
  /*
 客户赢排名
*/
  SELECT
    User_Name,
    employeecode,
    NetMoney,
    start_date,
    end_date
  FROM (SELECT
      B.User_Name,
      A.employeecode,
      SUM(B.Net_Money) AS NetMoney,
      start_end AS start_date,
      date_end AS end_date
    FROM (SELECT
        *
      FROM enterprise_employee
      WHERE parentemployeecode = employee_id
      AND logindatetime BETWEEN start_end AND date_end) AS A
      INNER JOIN betting_all_day AS B
        ON A.employeecode = B.employeecode
    GROUP BY B.User_Name,
             A.employeecode) AS HH
  WHERE NetMoney > 0
  ORDER BY NetMoney ASC LIMIT 0, 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_win_and_lose_customer_statistics
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_win_and_lose_customer_statistics`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_win_and_lose_customer_statistics`(IN employeecode varchar(10),
IN date_begin date,
IN date_end date,
IN var_start int,
IN var_end int)
BEGIN
  /*
	客户输赢统计
*/

  SELECT
    FF.loginaccount,
    FF.num,
    FF.employeecode,
    GG.Bet_Money,
    GG.net_money,
    GG.Valid_Money * GG.bonus AS bonus_money,
    CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
      END AS dividend_money,
    CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
      END AS hare_money,
    CASE
        WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
        ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
      END AS money

  FROM (SELECT
      A.employeecode,
      A.enterprisecode,
      A.brandcode,
      A.loginaccount,
      A.employeetypecode,
      ufn_down_recursion_team_of_agent_count(A.employeecode) AS num,
      SUM(dividend) AS dividend,
      SUM(share) AS hare
    FROM enterprise_employee A
    WHERE A.parentemployeecode = employeecode
    AND A.employeetypecode = 'T004'
    GROUP BY A.loginaccount,
             A.employeecode,
             A.employeetypecode) FF
    INNER JOIN (SELECT
        C.employeecode,
        C.enterprisecode,
        C.brandcode,
        SUM(C.Bet_Money) AS Bet_Money,
        SUM(C.net_money) AS net_money,
        SUM(C.Valid_Money) AS Valid_Money,
        SUM(D.bonus) AS bonus
      FROM betting_all_day AS C
        INNER JOIN employee_gamecataloy_bonus AS D
          ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Type = D.categorytype
          AND C.Bet_Day BETWEEN date_begin AND date_end
      GROUP BY C.employeecode,
               C.enterprisecode,
               C.brandcode) AS GG
      ON FF.employeecode = GG.employeecode
      AND FF.enterprisecode = GG.enterprisecode
  UNION ALL
  SELECT
    '直线会员' AS loginaccount,
    COUNT(1) AS num,
    employeecode AS employeecode,
    GG.Bet_Money,
    GG.net_money,
    SUM(GG.Valid_Money * GG.bonus) AS bonus_money,
    SUM(CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend ELSE 0
      END) AS dividend_money,
    SUM(CASE
        WHEN GG.net_money > 0 THEN (GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money - (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare ELSE (GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare
      END) AS hare_money,
    SUM(CASE
        WHEN GG.net_money > 0 THEN GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend) -
        ((GG.net_money + (GG.Valid_Money * GG.bonus) + ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.dividend)) * FF.hare) ELSE GG.net_money + (GG.Valid_Money * GG.bonus) - ((GG.net_money + (GG.Valid_Money * GG.bonus)) * FF.hare)
      END) AS money
  FROM (SELECT
      A.employeecode,
      A.enterprisecode,
      A.brandcode,
      A.loginaccount,
      A.employeetypecode,
      SUM(dividend) AS dividend,
      SUM(share) AS hare
    FROM enterprise_employee A
    WHERE A.parentemployeecode = employeecode
    AND A.employeetypecode = 'T003'
    GROUP BY A.loginaccount,
             A.employeecode,
             A.employeetypecode) FF
    INNER JOIN (SELECT
        C.employeecode,
        C.enterprisecode,
        C.brandcode,
        SUM(C.Bet_Money) AS Bet_Money,
        SUM(C.net_money) AS net_money,
        SUM(C.Valid_Money) AS Valid_Money,
        SUM(D.bonus) AS bonus
      FROM betting_all_day AS C
        INNER JOIN employee_gamecataloy_bonus AS D
          ON C.employeecode = D.employeecode AND C.Game_Platform = D.gametype AND C.Game_Big_Type = D.categorytype
          AND C.Bet_Day BETWEEN date_begin AND date_end
      GROUP BY C.employeecode,
               C.enterprisecode,
               C.brandcode) AS GG
      ON FF.employeecode = GG.employeecode
      AND FF.enterprisecode = GG.enterprisecode
  LIMIT var_start, var_end;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_withdrawals_number_ranking
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_withdrawals_number_ranking`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_withdrawals_number_ranking`(IN login varchar(10),
IN start_date date,
IN end_date date)
BEGIN
  /*
  取款次数排名
*/
  DECLARE rownum int DEFAULT 0;

  IF ISNULL(start_date) = 1 AND ISNULL(end_date) = 1 THEN
    SET start_date = DATE_SUB(DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'), INTERVAL 30 DAY);
    SET end_date = DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d');
  END IF;


  SELECT
    GG.employeecode,
    GG.loginaccount,
    DD.num,
    start_date AS start_date,
    end_date AS end_date
  FROM (SELECT
      employeecode,
      loginaccount
    FROM enterprise_employee AA
    WHERE parentemployeecode = login) AS GG
    LEFT JOIN (SELECT
        employeecode,
        COUNT(1) AS num
      FROM deposit_withdraw_order
      WHERE ordertype = 2
      AND orderstatus = '2'
      AND DATE_FORMAT(orderdate, '%Y-%m-%d') BETWEEN start_date AND end_date
      GROUP BY employeecode) AS DD
      ON GG.employeecode = DD.employeecode
  ORDER BY num DESC LIMIT 0, 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_withdrawals_pay
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_withdrawals_pay`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `usp_withdrawals_pay`(IN login varchar(20),
IN start_end date,
IN date_end date)
BEGIN
  /*
  取款次数排名
*/
  SELECT
    GG.employeecode,
    GG.loginaccount,
    COUNT(1) AS num,
    start_date AS start_date,
    end_date AS end_date
  FROM (SELECT
      employeecode,
      loginaccount
    FROM enterprise_employee AA
    WHERE parentemployeecode = login) AS GG
    LEFT JOIN deposit_withdraw_order AS DD
      ON GG.employeecode = DD.employeecode
      AND DD.orderdate BETWEEN start_date AND end_date
      AND DD.ordertype = 2
  GROUP BY GG.employeecode,
           GG.loginaccount
  ORDER BY num DESC LIMIT 0, 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for func_enterprisecode_exist
-- ----------------------------
DROP FUNCTION IF EXISTS `func_enterprisecode_exist`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `func_enterprisecode_exist`(enterprise_id  VARCHAR(10)) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
	DECLARE   log_row  boolean DEFAULT FALSE;
	-- 查询品牌是否存在企业，否则不能删除
		SELECT IF(count(1) > 0,TRUE,FALSE) INTO log_row
			FROM enterprise_operating_brand
		 WHERE enterprisecode = enterprise_id
			 AND datastatus = 1 LIMIT 1;

	-- 查询用户是否存在企业，否则不能删除
		SELECT IF(count(1) > 0,TRUE,FALSE) INTO log_row
			FROM enterprise_employee
		 WHERE enterprisecode = enterprise_id
			 AND datastatus = 1 LIMIT 1;

	-- 查询银行是否存在企业，否则不能删除
		SELECT IF(count(1) > 0,TRUE,FALSE) INTO log_row
			FROM enterprise_information
		 WHERE enterprisecode = enterprise_id
			 AND datastatus = 1 LIMIT 1;

	RETURN log_row;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for tool_jsonf_split
-- ----------------------------
DROP FUNCTION IF EXISTS `tool_jsonf_split`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `tool_jsonf_split`(f_string longtext,f_delimiter varchar(5),f_order int) RETURNS varchar(255) CHARSET utf8
    NO SQL
BEGIN 
    # 拆分传入的字符串，返回拆分后的新字符串 
        declare result varchar(255) default ''; 
        set result = reverse(substring_index(reverse(substring_index(f_string,f_delimiter,f_order)),f_delimiter,1)); 
        return result; 
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for tool_jsonf_totallength
-- ----------------------------
DROP FUNCTION IF EXISTS `tool_jsonf_totallength`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `tool_jsonf_totallength`(f_string longtext,f_delimiter varchar(5)) RETURNS int(11)
    NO SQL
BEGIN 
    # 计算传入字符串的总length 
    return 1+(length(f_string) - length(replace(f_string,f_delimiter,''))); 
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for tool_map_get
-- ----------------------------
DROP FUNCTION IF EXISTS `tool_map_get`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `tool_map_get`( map varchar(500), inputKey varchar(50) ) RETURNS varchar(255) CHARSET utf8
    NO SQL
BEGIN  
    DECLARE rowSeperator char(1) default ',';  -- 行分隔符  
    DECLARE fieldSeperator char(1) default ':';  --  键值对分隔符  
  
    DECLARE tempMap varchar(255) default map;  
    DECLARE isEnd boolean default false;  
  
    DECLARE rowIndex int default 0;  
    DECLARE pair varchar(255);  
    DECLARE pairIndex varchar(255);  
    DECLARE strKey varchar(255);  
    DECLARE strValue varchar(255);  
  
    WHILE isEnd = false do  
          
        set rowIndex = locate(rowSeperator,tempMap);  
        if rowIndex > 0 then  
            set pair = substring(tempMap,1,rowIndex-1);  
            set tempMap = substring(tempMap,rowIndex+1,9999999);  
        else  
            set pair = tempMap;  
            set isEnd = true;  
        end if;  
  
        set pairIndex = locate(fieldSeperator,pair);  
        if pairIndex > 0 then  
            set strKey = substring(pair,1,pairIndex-1);  
            set strValue = substring(pair,pairIndex+1,9999999);  
            if inputKey = strKey then  
                return strValue;  
            end if;  
        end if;  
          
    END WHILE;  
  
    return null;                                
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for tool_map_get_number
-- ----------------------------
DROP FUNCTION IF EXISTS `tool_map_get_number`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `tool_map_get_number`( map varchar(500), inputKey varchar(50) ) RETURNS decimal(10,0)
    NO SQL
BEGIN  
return cast(tool_map_get(map,inputKey) AS DECIMAL );  
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for tool_map_key
-- ----------------------------
DROP FUNCTION IF EXISTS `tool_map_key`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `tool_map_key`(jsonfstr varchar(500),keyindex int) RETURNS varchar(50) CHARSET utf8
    NO SQL
BEGIN
  -- 处理字符中转变量
  DECLARE handle_jsonstr varchar(500);

  


RETURN 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_count_employee_alluplevels_length
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_count_employee_alluplevels_length`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_count_employee_alluplevels_length`(p_employeecode char(8)) RETURNS int(11)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE r_length INT;
        SET r_length := 0;
        
    SELECT LENGTH(employeeallupleves) INTO r_length
	  FROM enterprise_employee_all_uplevels
	 WHERE employeecode = p_employeecode;
    
RETURN r_length;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_down_recursion_team_of_agent
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_down_recursion_team_of_agent`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_down_recursion_team_of_agent`(in_parentemployeecode CHAR(8)) RETURNS longtext CHARSET utf8
    READS SQL DATA
BEGIN
   DECLARE l_parentemployeecode LONGTEXT;
   DECLARE lc_parentemployeecode LONGTEXT;
    
   SET l_parentemployeecode = in_parentemployeecode;
   SET lc_parentemployeecode = in_parentemployeecode;


   LABLE_LP: LOOP
   SELECT group_concat(employeecode separator ',') into lc_parentemployeecode from enterprise_employee WHERE FIND_IN_SET(parentemployeecode,lc_parentemployeecode) >0 AND employeetypecode !='T003' and datastatus=1;
      IF lc_parentemployeecode IS NULL OR lc_parentemployeecode = 'NULL' THEN
         LEAVE LABLE_LP;
      END IF;
      SET l_parentemployeecode = CONCAT(l_parentemployeecode,',',lc_parentemployeecode);
   END LOOP LABLE_LP;
 
  RETURN l_parentemployeecode;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_down_recursion_team_of_agent_count
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_down_recursion_team_of_agent_count`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_down_recursion_team_of_agent_count`(in_parentemployeecode char(8)) RETURNS int(11)
    READS SQL DATA
BEGIN
  DECLARE l_parentemployeecode longtext;
  DECLARE lc_parentemployeecode longtext;
  DECLARE usercount int;


  SET l_parentemployeecode = in_parentemployeecode;
  SET lc_parentemployeecode = in_parentemployeecode;


LABLE_LP:
LOOP
  SELECT
    GROUP_CONCAT(employeecode SEPARATOR ',') INTO lc_parentemployeecode
  FROM enterprise_employee
  WHERE FIND_IN_SET(parentemployeecode, lc_parentemployeecode) > 0 AND employeetypecode != 'T003';
  IF lc_parentemployeecode IS NULL OR lc_parentemployeecode = 'NULL' THEN
    LEAVE LABLE_LP;
  END IF;
  SET l_parentemployeecode = CONCAT(l_parentemployeecode, ',', lc_parentemployeecode);
END LOOP LABLE_LP;

  SELECT
    COUNT(1) INTO usercount
  FROM enterprise_employee ee
  WHERE ee.parentemployeecode IN (SELECT
      ee.employeecode
    FROM enterprise_employee ee
    WHERE FIND_IN_SET(ee.employeecode, l_parentemployeecode) > 0 AND ee.employeetypecode != 'T003');
  RETURN usercount;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_down_recursion_team_of_agent_number
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_down_recursion_team_of_agent_number`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_down_recursion_team_of_agent_number`(in_parentemployeecode CHAR(8)) RETURNS int(11)
    READS SQL DATA
BEGIN
   DECLARE l_parentemployeecode 	LONGTEXT;
   DECLARE lc_parentemployeecode 	LONGTEXT;
	 DECLARE group_row							INT;
    
   SET l_parentemployeecode = in_parentemployeecode;
   SET lc_parentemployeecode = in_parentemployeecode;


   LABLE_LP: LOOP
   SELECT group_concat(employeecode separator ',') into lc_parentemployeecode from enterprise_employee 
         WHERE FIND_IN_SET(parentemployeecode,lc_parentemployeecode) >0 AND employeetypecode !='T003';
      IF lc_parentemployeecode IS NULL OR lc_parentemployeecode = 'NULL' THEN
         LEAVE LABLE_LP;
      END IF;
      SET l_parentemployeecode = CONCAT(l_parentemployeecode,',',lc_parentemployeecode);
   END LOOP LABLE_LP;
	 
	 SELECT count(1) INTO group_row from enterprise_employee where parentemployeecode in 
		(SELECT ee.employeecode
							FROM enterprise_employee ee
						 WHERE FIND_IN_SET(ee.employeecode,l_parentemployeecode) > 0 
		AND ee.employeetypecode !='T003');
  RETURN group_row;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_etl_amount_from_api_ttg_gameinfo
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_etl_amount_from_api_ttg_gameinfo`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_etl_amount_from_api_ttg_gameinfo`(p_handId VARCHAR(50), p_transactionSubType VARCHAR(50)) RETURNS varchar(50) CHARSET utf8
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE l_amount VARCHAR(50);
    SELECT amount INTO l_amount
      FROM api_ttg_gameinfo
	 WHERE handId = p_handId
	   AND transactionSubType = p_transactionSubType;
RETURN l_amount;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_get_employee_all_uplevels
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_get_employee_all_uplevels`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_get_employee_all_uplevels`(in_employeecode CHAR(8)) RETURNS varchar(1000) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
   DECLARE l_employeecode CHAR(8);
   DECLARE l_all_uplevels VARCHAR(1000);
   SET l_employeecode = in_employeecode;
   SET l_all_uplevels = CONCAT(',');
   
   LP: LOOP
      SELECT parentemployeecode INTO l_employeecode
        FROM enterprise_employee
	   WHERE employeecode=l_employeecode;
       
       IF l_employeecode <> in_employeecode THEN
          SET l_all_uplevels := CONCAT(',', l_employeecode, l_all_uplevels);
       END IF;
       
       IF l_employeecode = in_employeecode OR l_employeecode = '00000000' THEN
          LEAVE LP;
	   END IF;
   END LOOP;
   
   SET l_all_uplevels := CONCAT(l_all_uplevels,in_employeecode,',');
   
   RETURN l_all_uplevels;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_get_gamebigtype_from_tag
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_get_gamebigtype_from_tag`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_get_gamebigtype_from_tag`(platformType VARCHAR(32), gameType VARCHAR(32)) RETURNS varchar(5) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
   DECLARE l_find_gameType VARCHAR(33);
   DECLARE l_gamebigtype VARCHAR(5);
   DECLARE l_SX VARCHAR(1000);
   DECLARE l_DZ VARCHAR(1000);
   DECLARE l_TY VARCHAR(1000);
   
   SET l_find_gameType = CONCAT(',',gameType,',');
   SET l_SX = ',BAC,CBAC,LINK,DT,SHB,ROU,FT,';
   SET l_TY = ',FIFA,';
   
   IF platformType = 'PNG' THEN
      SET l_gamebigtype = 'DZ';
   ELSE
      IF LOCATE(l_find_gameType, l_SX )>0 THEN
	     SET l_gamebigtype = 'SX';
	  ELSEIF LOCATE(l_find_gameType, l_TY )>0 THEN
	     SET l_gamebigtype = 'TY';
	  ELSE
	     SET l_gamebigtype = 'DZ';
	  END IF;
   END IF;
   
   RETURN l_gamebigtype;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_get_next_string
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_get_next_string`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_get_next_string`(param_src_string varchar(128), param_dest_length tinyint) RETURNS varchar(128) CHARSET utf8 COLLATE utf8_bin
    DETERMINISTIC
BEGIN
  ## 定义常量字符串
  
  
  DECLARE vch_constant varchar(36) DEFAULT '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  ## 定义本地字符串
  DECLARE vch_source,
          vch_dest,
          vch_end varchar(128) DEFAULT '';

  ## 起始字符,结束字符
  DECLARE ch_start char(1) DEFAULT '0';
  DECLARE ch_end char(1) DEFAULT '';

  ## 定义参与计算的变量
  DECLARE int_string_len int DEFAULT 1;
  DECLARE int_search_char_position int DEFAULT 1;
  DECLARE int_loop int DEFAULT 1;

  SET vch_source = UPPER(param_src_string);
  SET int_string_len = LENGTH(vch_source);

#SET vch_dest = vch_source;

END_LOOP:
WHILE int_loop <= int_string_len + 1
  DO
BEGIN
  IF int_loop > int_string_len THEN
  BEGIN
    SET vch_source = CONCAT('0', vch_source);
    SET int_string_len = int_string_len + 1;
  END;
  END IF;

  SET ch_end = RIGHT(vch_source, 1);
  IF ch_end = 'Z' THEN
  BEGIN
    SET vch_source = SUBSTRING(vch_source, 1, int_string_len - int_loop);
    SET vch_end = CONCAT(vch_end, '0');
  END;
  ELSE
  BEGIN
    SET int_search_char_position = INSTR(vch_constant, ch_end);
    SET vch_dest = CONCAT(SUBSTRING(vch_source, 1, int_string_len - int_loop), SUBSTRING(vch_constant, int_search_char_position + 1, 1), IFNULL(vch_end, ''));
    LEAVE END_LOOP;
  END;
  END IF;

  SET int_loop = int_loop + 1;
END;
END WHILE;

  -- 判断目标字符串是否为NULL或空串
  IF IFNULL(vch_dest, '') = '' THEN
  BEGIN
    SET int_string_len = 1;
    SET vch_dest = '0';
  END;
  END IF;

  IF param_dest_length > int_string_len THEN
  BEGIN
    SET vch_dest = LPAD(vch_dest, param_dest_length, '0');
  END;
  END IF;

  RETURN vch_dest;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_get_next_string_by_tablename
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_get_next_string_by_tablename`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_get_next_string_by_tablename`(param_tablename varchar(128), param_performancefactor tinyint) RETURNS varchar(16) CHARSET utf8 COLLATE utf8_bin
    MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
  ## 为了并发线程安全，锁定修改的记录
  DECLARE vch_dest varchar(16);

  UPDATE table_pk_seed
  SET seed = ufn_get_next_string(seed, LENGTH(seed))
  WHERE tablename = param_tablename
  AND performancefactor = param_performancefactor;

  SELECT
    CONCAT(codeprefix, seed) INTO vch_dest
  FROM table_pk_seed
  WHERE tablename = param_tablename
  AND performancefactor = param_performancefactor
  FOR UPDATE;

  RETURN vch_dest;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_min_transactionId_from_api_ttg_gameinfo
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_min_transactionId_from_api_ttg_gameinfo`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_min_transactionId_from_api_ttg_gameinfo`(p_handId VARCHAR(50)) RETURNS bigint(20)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE l_transactionId BIGINT;
    SELECT MIN(transaction_Id) INTO l_transactionId
      FROM betting_ttg
	 WHERE hand_Id = p_handId;
RETURN l_transactionId;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_statistic_count_of_next_level
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_statistic_count_of_next_level`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_statistic_count_of_next_level`(in_employeetypecode char(4), ## T003, 统计会员  T003, 统计代理
in_parentemployeecode char(8)) RETURNS int(11)
    READS SQL DATA
BEGIN
  DECLARE l_count int;

  SELECT
    COUNT(1) INTO l_count
  FROM enterprise_employee
  WHERE parentemployeecode = in_parentemployeecode AND employeetypecode = in_employeetypecode AND datastatus = 1;

  RETURN l_count;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_tn_person_balances_jifen_parentcode
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_tn_person_balances_jifen_parentcode`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_tn_person_balances_jifen_parentcode`(parentemployeecode_IN CHAR(8)) RETURNS double
    READS SQL DATA
RETURN (select IFNULL(sum(balance),0) from enterprise_employee_capital_account where parentemployeecode = parentemployeecode_IN)
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_tn_person_balances_yuanbao_parentcode
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_tn_person_balances_yuanbao_parentcode`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_tn_person_balances_yuanbao_parentcode`(parentemployeecode_IN CHAR(8)) RETURNS double
    READS SQL DATA
RETURN (select IFNULL(sum(balance),0) from baccarath5_balance where parentemployeecode = parentemployeecode_IN)
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_tn_person_betting
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_tn_person_betting`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_tn_person_betting`(in_employeecode char(8), in_begintime datetime, in_endtime datetime) RETURNS decimal(16,2)
    READS SQL DATA
BEGIN
  DECLARE rt_netmoney decimal(16, 2) DEFAULT 0;
  -- 查询用户某段时间的投注量
  SELECT
    SUM(stat.netMoney) INTO rt_netmoney
  FROM (SELECT
      bha.bet_Amount AS netMoney
    FROM betting_hq_ag bha
    WHERE bha.bet_Time >= in_begintime AND bha.bet_Time < in_endtime AND bha.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhb.bbin_Bet_Amount AS netMoney
    FROM betting_hq_bbin bhb
    WHERE bhb.bbin_Wagers_Date >= in_begintime AND bhb.bbin_Wagers_Date < in_endtime AND bhb.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhq.Betting_Credits AS netMoney
    FROM betting_hq_nhq bhq
    WHERE bhq.Betting_Date >= in_begintime AND bhq.Betting_Date< in_endtime AND bhq.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhoa.aoi_Betting_Amount AS netMoney
    FROM betting_hq_og_ag bhoa
    WHERE bhoa.aoi_Add_Time >= in_begintime AND bhoa.aoi_Add_Time < in_endtime AND bhoa.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhoi.ibc_tzmoney AS netMoney
    FROM betting_hq_og_ibc bhoi
    WHERE bhoi.ibc_updatetime >= in_begintime AND bhoi.ibc_updatetime < in_endtime AND bhoi.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhoo.aoi_Betting_Amount AS netMoney
    FROM betting_hq_og_og bhoo
    WHERE bhoo.aoi_Add_Time >= in_begintime AND bhoo.aoi_Add_Time < in_endtime AND bhoo.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhp.pt_bet AS netMoney
    FROM betting_hq_pt bhp
    WHERE bhp.pt_gamedate >= in_begintime AND bhp.pt_gamedate < in_endtime AND bhp.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhx.xcp_totalprice AS netMoney
    FROM betting_hq_xcp bhx
    WHERE bhx.xcp_writetime >= in_begintime AND bhx.xcp_writetime < in_endtime AND bhx.employeecode = in_employeecode
    UNION ALL
    SELECT 
      bya.money AS netMoney
    FROM betting_yg_ag bya 
    WHERE bya.time >= in_begintime AND bya.time<in_endtime AND bya.employeecode = in_employeecode
    
    /*********zj sa av ttg*********/   
    UNION ALL
    SELECT zj.stakeamount AS netMoney FROM betting_zj zj WHERE zj.bettime >= in_begintime AND zj.bettime<in_endtime AND zj.employeecode = in_employeecode
      
    UNION ALL
    SELECT sa.betamount AS netMoney FROM betting_sa sa WHERE sa.bettime >= in_begintime AND sa.bettime<in_endtime AND sa.employeecode = in_employeecode
    
    UNION ALL
    SELECT av.amount AS netMoney FROM betting_kr_av av WHERE av.time >= in_begintime AND av.time<in_endtime AND av.employeecode = in_employeecode
    
    UNION ALL
    SELECT ttg.amount AS netMoney FROM betting_ttg ttg WHERE ttg.bettime >= in_begintime AND ttg.bettime<in_endtime AND ttg.employeecode = in_employeecode
    
    UNION ALL
    SELECT mg.mg_amount AS netMoney FROM betting_mg mg WHERE mg.bettime >= in_begintime AND mg.bettime<in_endtime AND mg.employeecode = in_employeecode
    
    UNION ALL
    SELECT bha.bet_Amount AS netMoney FROM betting_hq_png bha WHERE bha.bet_Time >= in_begintime AND bha.bet_Time < in_endtime AND bha.employeecode = in_employeecode
     
   UNION ALL
    SELECT bha.betmoney AS netMoney FROM betting_qp bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode
    
    UNION ALL
    SELECT bha.betmoney AS netMoney FROM betting_gg bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode
    
    UNION ALL
    SELECT bha.betmoney AS netMoney FROM betting_sgs bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode
    
    UNION ALL
    SELECT bha.betmoney AS netMoney FROM betting_idn bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode
    
    UNION ALL
    SELECT bha.betmoney AS netMoney FROM betting_m88 bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode
    
    UNION ALL
    SELECT bha.betmoney AS netMoney FROM betting_hab bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode
    
    UNION ALL
    SELECT bhp.pt_bet AS netMoney FROM betting_win88 bhp WHERE bhp.pt_gamedate >= in_begintime AND bhp.pt_gamedate < in_endtime AND bhp.employeecode = in_employeecode
    UNION ALL
    SELECT bha.betmoney AS netMoney FROM betting_tgp bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode
    UNION ALL
    SELECT bha.betmoney AS netMoney FROM betting_qt bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode
    UNION ALL
    SELECT bha.betmoney AS netMoney FROM betting_gb bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode
    UNION ALL
    SELECT bha.betmoney AS netMoney FROM betting_ebet bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode
    UNION ALL
    SELECT bha.betmoney AS netMoney FROM betting_eibc bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode
      
    
    
    
    
      ) AS stat;
  RETURN IF(rt_netmoney IS NULL ,0 ,rt_netmoney);
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_tn_person_losewin
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_tn_person_losewin`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_tn_person_losewin`(in_employeecode char(8), in_begintime datetime, in_endtime datetime) RETURNS decimal(16,2)
    READS SQL DATA
BEGIN
  DECLARE rt_netmoney decimal(16, 2) DEFAULT 0;
  -- 查询用户某段时间的投注量
  SELECT
    SUM(stat.netMoney) INTO rt_netmoney
  FROM (SELECT
      bha.net_Amount AS netMoney
    FROM betting_hq_ag bha
    WHERE bha.bet_Time >= in_begintime AND bha.bet_Time < in_endtime AND bha.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhb.bbin_Payoff AS netMoney
    FROM betting_hq_bbin bhb
    WHERE bhb.bbin_Wagers_Date >= in_begintime AND bhb.bbin_Wagers_Date < in_endtime AND bhb.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhq.Winning_Credits AS netMoney
    FROM betting_hq_nhq bhq
    WHERE bhq.Betting_Date >= in_begintime AND bhq.Betting_Date < in_endtime AND bhq.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhoa.aoi_Win_Lose_Amount AS netMoney
    FROM betting_hq_og_ag bhoa
    WHERE bhoa.aoi_Add_Time >= in_begintime AND bhoa.aoi_Add_Time < in_endtime AND bhoa.employeecode = in_employeecode
    UNION ALL
    SELECT
      (bhoi.ibc_win - bhoi.ibc_lose) AS netMoney
    FROM betting_hq_og_ibc bhoi
    WHERE bhoi.ibc_updatetime >= in_begintime AND bhoi.ibc_updatetime < in_endtime AND bhoi.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhoo.aoi_Win_Lose_Amount AS netMoney
    FROM betting_hq_og_og bhoo
    WHERE bhoo.aoi_Add_Time >= in_begintime AND bhoo.aoi_Add_Time < in_endtime AND bhoo.employeecode = in_employeecode
    UNION ALL
    SELECT
      (bhp.pt_win - bhp.pt_bet) AS netMoney
    FROM betting_hq_pt bhp
    WHERE bhp.pt_gamedate >= in_begintime AND bhp.pt_gamedate < in_endtime AND bhp.employeecode = in_employeecode
    UNION ALL
    SELECT
      bhx.xcp_bonus AS netMoney
    FROM betting_hq_xcp bhx
    WHERE bhx.xcp_writetime >= in_begintime AND bhx.xcp_writetime < in_endtime AND bhx.employeecode = in_employeecode
    
    /*********zj sa av ttg*********/   
    UNION ALL
    SELECT zj.winloss AS netMoney FROM betting_zj zj WHERE zj.bettime >= in_begintime AND zj.bettime<in_endtime AND zj.employeecode = in_employeecode
      
    UNION ALL
    SELECT sa.resultamount AS netMoney FROM betting_sa sa WHERE sa.bettime >= in_begintime AND sa.bettime<in_endtime AND sa.employeecode = in_employeecode
    
    UNION ALL
    SELECT av.amount2 AS netMoney FROM betting_kr_av av WHERE av.time >= in_begintime AND av.time<in_endtime AND av.employeecode = in_employeecode
    
    UNION ALL
    SELECT ttg.net_money AS netMoney FROM betting_ttg ttg WHERE ttg.bettime >= in_begintime AND ttg.bettime<in_endtime AND ttg.employeecode = in_employeecode
    
    UNION ALL
    SELECT mg.net_money AS netMoney FROM betting_mg mg WHERE mg.bettime >= in_begintime AND mg.bettime<in_endtime AND mg.employeecode = in_employeecode
    
    UNION ALL
    SELECT bha.net_Amount AS netMoney FROM betting_hq_png bha WHERE bha.bet_Time >= in_begintime AND bha.bet_Time < in_endtime AND bha.employeecode = in_employeecode

    UNION ALL
    SELECT bha.netmoney AS netMoney FROM betting_qp bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode      
    
    UNION ALL
    SELECT bha.netmoney AS netMoney FROM betting_gg bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode      
    
    UNION ALL
    SELECT bha.netmoney AS netMoney FROM betting_sgs bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode      
    
    UNION ALL
    SELECT bha.netmoney AS netMoney FROM betting_idn bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode   
    
    UNION ALL
    SELECT bha.netmoney AS netMoney FROM betting_m88 bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode     
    
    UNION ALL
    SELECT bha.netmoney AS netMoney FROM betting_hab bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode  
    
    UNION ALL
    SELECT  (bhp.pt_win - bhp.pt_bet) AS netMoney FROM betting_win88 bhp WHERE bhp.pt_gamedate >= in_begintime AND bhp.pt_gamedate < in_endtime AND bhp.employeecode = in_employeecode
    UNION ALL
    SELECT bha.netmoney AS netMoney FROM betting_tgp bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode   
    UNION ALL
    SELECT bha.netmoney AS netMoney FROM betting_qt bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode 
    UNION ALL
    SELECT bha.netmoney AS netMoney FROM betting_gb bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode 
    UNION ALL
    SELECT bha.netmoney AS netMoney FROM betting_ebet bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode 
    UNION ALL
    SELECT bha.netmoney AS netMoney FROM betting_eibc bha WHERE bha.bettime >= in_begintime AND bha.bettime < in_endtime AND bha.employeecode = in_employeecode 
    
    
    
    
    ) AS stat;
  RETURN IF(rt_netmoney IS NULL ,0 ,rt_netmoney);
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_tn_team_losewin
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_tn_team_losewin`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_tn_team_losewin`(in_employeecode char(8), in_begintime datetime, in_endtime datetime) RETURNS decimal(16,2)
    READS SQL DATA
BEGIN
SELECT SUM(stat.netMoney) INTO @netmoney FROM (
    SELECT bha.net_Amount AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_hq_ag bha 
      WHERE bha.bet_Time >= in_begintime AND bha.bet_Time <in_endtime 
      UNION ALL 
    SELECT bhb.bbin_Payoff AS netMoney , bhb.employeecode AS employeecode,bhb.parentemployeecode AS parentemployeecode FROM betting_hq_bbin bhb 
      WHERE bhb.bbin_Wagers_Date >= in_begintime AND bhb.bbin_Wagers_Date <in_endtime 
      UNION ALL 
    SELECT bhq.Winning_Credits AS netMoney , bhq.employeecode AS employeecode,bhq.parentemployeecode AS parentemployeecode FROM betting_hq_nhq bhq 
      WHERE bhq.Betting_Date  >= in_begintime AND bhq.Betting_Date<in_endtime 
      UNION ALL 
    SELECT bhoa.aoi_Win_Lose_Amount AS netMoney, bhoa.employeecode AS employeecode, bhoa.parentemployeecode AS parentemployeecode FROM  betting_hq_og_ag bhoa
      WHERE bhoa.aoi_Add_Time  >= in_begintime AND bhoa.aoi_Add_Time <in_endtime 
      UNION ALL
    SELECT (bhoi.ibc_win - bhoi.ibc_lose) AS netMoney, bhoi.employeecode AS employeecode, bhoi.parentemployeecode AS parentemployeecode FROM  betting_hq_og_ibc bhoi
      WHERE bhoi.ibc_updatetime  >= in_begintime AND bhoi.ibc_updatetime  <in_endtime 
      UNION ALL 
    SELECT bhoo.aoi_Win_Lose_Amount AS netMoney, bhoo.employeecode AS employeecode, bhoo.parentemployeecode AS parentemployeecode FROM  betting_hq_og_og bhoo
      WHERE bhoo.aoi_Add_Time >= in_begintime AND bhoo.aoi_Add_Time <in_endtime 
      UNION ALL 
    SELECT (bhp.pt_win-bhp.pt_bet) AS netMoney, bhp.employeecode AS employeecode, bhp.parentemployeecode AS parentemployeecode FROM  betting_hq_pt bhp
      WHERE bhp.pt_gamedate >= in_begintime AND bhp.pt_gamedate <in_endtime 
      UNION ALL 
    SELECT bhx.xcp_bonus AS netMoney, bhx.employeecode AS employeecode, bhx.parentemployeecode AS parentemployeecode FROM  betting_hq_xcp bhx
      WHERE bhx.xcp_writetime >= in_begintime AND bhx.xcp_writetime <in_endtime 
            
    /*********zj sa av ttg*********/   
    UNION ALL
    SELECT zj.winloss AS netMoney ,zj.employeecode AS employeecode, zj.parentemployeecode AS parentemployeecode
     FROM betting_zj zj WHERE zj.bettime >= in_begintime AND zj.bettime<in_endtime AND zj.employeecode = in_employeecode
      
    UNION ALL
    SELECT sa.resultamount AS netMoney ,sa.employeecode AS employeecode, sa.parentemployeecode AS parentemployeecode
    FROM betting_sa sa WHERE sa.bettime >= in_begintime AND sa.bettime<in_endtime AND sa.employeecode = in_employeecode
    
    UNION ALL
    SELECT av.amount2 AS netMoney ,av.employeecode AS employeecode, av.parentemployeecode AS parentemployeecode
    FROM betting_kr_av av WHERE av.time >= in_begintime AND av.time<in_endtime AND av.employeecode = in_employeecode
    
    UNION ALL
    SELECT ttg.net_money AS netMoney ,ttg.employeecode AS employeecode, ttg.parentemployeecode AS parentemployeecode
    FROM betting_ttg ttg WHERE ttg.bettime >= in_begintime AND ttg.bettime<in_endtime AND ttg.employeecode = in_employeecode
    
    UNION ALL
    SELECT mg.net_money AS netMoney ,mg.employeecode AS employeecode, mg.parentemployeecode AS parentemployeecode
    FROM betting_mg mg WHERE mg.bettime >= in_begintime AND mg.bettime<in_endtime AND mg.employeecode = in_employeecode
    
    UNION ALL
    SELECT bha.net_Amount AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_hq_png bha 
      WHERE bha.bet_Time >= in_begintime AND bha.bet_Time <in_endtime 
      
    UNION ALL
    SELECT bha.netmoney AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_qp bha 
      WHERE bha.bettime >= in_begintime AND bha.bettime <in_endtime       
    
    UNION ALL
    SELECT bha.netmoney AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_gg bha 
      WHERE bha.bettime >= in_begintime AND bha.bettime <in_endtime       
      
    UNION ALL
    SELECT bha.netmoney AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_sgs bha 
      WHERE bha.bettime >= in_begintime AND bha.bettime <in_endtime           
    
    UNION ALL
    SELECT bha.netmoney AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_idn bha 
      WHERE bha.bettime >= in_begintime AND bha.bettime <in_endtime
      
    UNION ALL
    SELECT bha.netmoney AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_m88 bha 
      WHERE bha.bettime >= in_begintime AND bha.bettime <in_endtime  
      
    UNION ALL
    SELECT bha.netmoney AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_hab bha 
      WHERE bha.bettime >= in_begintime AND bha.bettime <in_endtime     
      
    UNION ALL 
    SELECT (bhp.pt_win-bhp.pt_bet) AS netMoney, bhp.employeecode AS employeecode, bhp.parentemployeecode AS parentemployeecode FROM  betting_win88 bhp WHERE bhp.pt_gamedate >= in_begintime AND bhp.pt_gamedate <in_endtime   
    UNION ALL
    SELECT bha.netmoney AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_tgp bha  WHERE bha.bettime >= in_begintime AND bha.bettime <in_endtime           
    UNION ALL
    SELECT bha.netmoney AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_qt bha  WHERE bha.bettime >= in_begintime AND bha.bettime <in_endtime           
    UNION ALL
    SELECT bha.netmoney AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_gb bha  WHERE bha.bettime >= in_begintime AND bha.bettime <in_endtime           
    UNION ALL
    SELECT bha.netmoney AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_ebet bha  WHERE bha.bettime >= in_begintime AND bha.bettime <in_endtime            
    UNION ALL
    SELECT bha.netmoney AS netMoney , bha.employeecode AS employeecode,bha.parentemployeecode AS parentemployeecode FROM betting_eibc bha  WHERE bha.bettime >= in_begintime AND bha.bettime <in_endtime            
      
      
      
) AS stat WHERE (stat.employeecode = in_employeecode OR stat.parentemployeecode 
  IN (SELECT ee.employeecode FROM enterprise_employee ee 
        WHERE FIND_IN_SET(ee.employeecode,ufn_down_recursion_team_of_agent(in_employeecode))));
RETURN IF(@netmoney IS NULL ,0,@netmoney);
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_up_recursion_shareholder_of_user
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_up_recursion_shareholder_of_user`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_up_recursion_shareholder_of_user`(in_employeecode char(8)) RETURNS char(8) CHARSET utf8
    READS SQL DATA
BEGIN
  DECLARE l_parentemployeecode char(8);
  DECLARE l_employeecode char(8);
  DECLARE l_employeetype char(4);
  DECLARE lc_employeetype char(4);
  SET l_parentemployeecode = in_employeecode;

LABLE_LP:
LOOP
  SELECT
    employeecode,
    parentemployeecode,
    employeetypecode INTO l_employeecode, l_parentemployeecode, l_employeetype
  FROM enterprise_employee
  WHERE employeecode = l_parentemployeecode;
  IF l_employeetype = 'T001' OR lc_employeetype = l_employeetype THEN
    LEAVE LABLE_LP;
  END IF;
  SET lc_employeetype = l_employeetype;
END LOOP LABLE_LP;

  RETURN l_employeecode;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for ufn_up_recursion_upper_level_of_user
-- ----------------------------
DROP FUNCTION IF EXISTS `ufn_up_recursion_upper_level_of_user`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `ufn_up_recursion_upper_level_of_user`(in_employeecode char(8)) RETURNS longtext CHARSET utf8
    READS SQL DATA
BEGIN
  DECLARE l_parentemployeecode longtext;
  DECLARE lc_parentemployeecode longtext;

  SET l_parentemployeecode = in_employeecode;
  SET lc_parentemployeecode = in_employeecode;

LABLE_LP:
LOOP
  SELECT
    parentemployeecode INTO lc_parentemployeecode
  FROM enterprise_employee
  WHERE employeecode = lc_parentemployeecode;
  IF lc_parentemployeecode IS NULL OR lc_parentemployeecode = '00000000' THEN
    LEAVE LABLE_LP;
  END IF;
  SET l_parentemployeecode = CONCAT(l_parentemployeecode, ',', lc_parentemployeecode);
END LOOP LABLE_LP;

  RETURN l_parentemployeecode;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for usp_orderamount_by_employeecode
-- ----------------------------
DROP FUNCTION IF EXISTS `usp_orderamount_by_employeecode`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `usp_orderamount_by_employeecode`(in_employeecode CHAR(8),in_order_type CHAR(1)) RETURNS decimal(14,2)
    READS SQL DATA
RETURN (select IFNULL(sum(orderamount),0) sumorderamount from deposit_withdraw_order where orderstatus='2' and ordertype=in_order_type and employeecode=in_employeecode)
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_api_aoi_gameinfo_after_insert`;
DELIMITER ;;
CREATE TRIGGER `trg_api_aoi_gameinfo_after_insert` AFTER INSERT ON `api_aoi_gameinfo` FOR EACH ROW BEGIN
   ## 同步数据
   ## 同步数据到 betting_all_game_winlose_detail
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

        ## ????
   ## ????? betting_all_game_winlose_detail
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


   	###注意：沙巴体育和IM体育因为投注时间不重要，关键在结算时间所以这里用结算时间来存储####       
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
   ## 同步数据
   ## 同步数据到 betting_all_game_winlose_detail
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


###注意：沙巴体育和IM体育因为投注时间不重要，关键在结算时间所以这里用结算时间来存储####   

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

	## 同步数据到 betting_all_game_winlose_detail
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
                
        ####最后更新时间放到投注时间里面，便于统计结算，同IM体育和沙巴体育#####        
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
   ## 同步数据
   ## 同步数据到 betting_all_game_winlose_detail
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
   ## 同步数据到 betting_all_game_winlose_detail
   REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
         SELECT 'HY' platformtype, NEW.BettingID AS platformid,employeecode, NEW.BettingDate AS bettime, NEW.BettingCredits AS betmoney, NEW.WashCodeCredits AS validbet, NEW.WinningCredits AS netmoney
         ,enterprisecode,brandcode,loginaccount,parentemployeecode,'SX' AS gamebigtype,'NHQGame' AS gametype
   	       FROM employee_api_accout
   	      WHERE gameaccount = NEW.UserAccount
		    AND gametype = 'NHQGame';

   ## 同步数据到 betting_hq_nhq
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
          0 AS status ##数据汇总状态
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
   ## 同步数据
   ## 同步数据到 betting_all_game_winlose_detail
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
   ## 同步数据
   ## 同步数据到 betting_all_game_winlose_detail
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

	## 同步数据到 betting_all_game_winlose_detail
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
   ## 同步数据
   ## 同步数据到 betting_all_game_winlose_detail
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
## 同步数据
   ## 同步数据到 betting_all_game_winlose_detail
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
   ## 同步数据
   IF NEW.platformType = 'PNG' THEN
   ## 同步数据到 betting_all_game_winlose_detail
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
   ## 同步数据到 betting_all_game_winlose_detail
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
		  
   ## 同步数据 betting_ttg
   IF NEW.transactionSubType = 'Wager' THEN
   ## 同步数据到 betting_all_game_winlose_detail
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
             IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Resolve'),0)+NEW.amount AS net_Money, #Wager = 下注 Resolve = 奖金
             INSERT(INSERT(NEW.transactionDate,7,0,'-'),5,0,'-') AS resolvetime
        FROM employee_api_accout 
	   WHERE gameaccount = NEW.playerId
		 AND gametype = 'TTGGame';
   ELSE
   ## 同步数据到 betting_all_game_winlose_detail
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
             IFNULL(ufn_etl_amount_from_api_ttg_gameinfo(NEW.handId, 'Wager'),0) + NEW.amount AS net_Money, #Wager = 下注 Resolve = 奖金
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
   ## 同步数据
   ## 同步数据到 betting_all_game_winlose_detail
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

     ## 同步数据到 betting_all_game_winlose_detail
      REPLACE INTO betting_all_game_winlose_detail (platformtype,platformid,employeecode,bettime,betmoney,validbet,netmoney, enterprisecode,brandcode,loginaccount,parentemployeecode,gamebigtype,gametype)
            SELECT 'YoPLAY' AS platformtype, NEW.billNo AS platformid,employeecode ,NEW.betTime AS bettime, NEW.betmoney AS betmoney, NEW.validmoney AS validbet, NEW.netmoney AS netmoney
            ,enterprisecode,brandcode,loginaccount,parentemployeecode,'DZ' AS gamebigtype,'YoPLAYGame' AS gametype
      	      FROM employee_api_accout
      	     WHERE gameaccount = NEW.playerName
      	       AND gametype = 'YoPLAYGame';   
      /****/
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