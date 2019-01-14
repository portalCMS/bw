package com.hy.pull.service.game;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


public class LogUtil {

	
	
	/**
	 * 日志数据集合。每5分钟持久化一次到数据库
	 */
	public static List<Map<String, Object>> listDatalLog = new ArrayList<Map<String,Object>>();
	
	public static void addListLog(String gametype, String dataparams, String datalog, String agentaccount, int flag){
		Map<String, Object> dataxxxx = saveLog(gametype, dataparams, datalog, agentaccount, flag) ;
		listDatalLog.add(dataxxxx);
//		System.out.println("######################################################进入异常log："+dataxxxx);
	}
	
	public static Map<String, Object> saveLog(String gametype, String dataparams, String datalog, String agentaccount, int flag){
		if(dataparams == null ) {
			dataparams = "无参数";
		}
		Map<String, Object> dataxxxx = new HashMap<String, Object>();
		dataxxxx.put("lsh", UUID.randomUUID().toString());
		dataxxxx.put("gametype", gametype);
		dataxxxx.put("dataparams", dataparams);
		dataxxxx.put("datalog", datalog);
		dataxxxx.put("agentaccount", agentaccount);
		dataxxxx.put("flag", flag);
		dataxxxx.put("lasttime", new Date());
//		System.out.println(dataxxxx);
		return dataxxxx;
	}
	
	
	
	public static final String HANDLE_TAG = "begin.time.hq.ag";
	public static final String HANDLE_AOI = "begin.time.hq.og.og";
	public static final String HANDLE_IBC = "begin.time.hq.og.ibc";
	public static final String HANDLE_BBIN = "begin.time.hq.bbin";
	public static final String HANDLE_NHQ = "begin.time.hq.nhq";
	public static final String HANDLE_PT = "begin.time.hq.pt";
	public static final String HANDLE_IMPT = "begin.time.hq.impt";
	public static final String HANDLE_XCP = "begin.time.hq.xcp";
	public static final String HANDLE_AV = "begin.time.kr.av";
	public static final String HANDLE_MG = "begin.time.mg";
	public static final String HANDLE_QP = "begin.time.qp";
	public static final String HANDLE_SA = "begin.time.sa";
	public static final String HANDLE_TTG = "begin.time.ttg";
	public static final String HANDLE_ZJ = "begin.time.zj";
	public static final String HANDLE_DZDY = "begin.time.hq.dzdy";
	public static final String HANDLE_GG = "begin.time.hq.gg";
	public static final String HANDLE_SGS = "begin.time.hq.sgs";
	public static final String HANDLE_IDN = "begin.time.hq.idn";
	public static final String HANDLE_M88 = "begin.time.hq.m88";
	public static final String HANDLE_HAB = "begin.time.hq.hab";
	public static final String HANDLE_QT = "begin.time.hq.qt";
	public static final String HANDLE_TGP = "begin.time.hq.tgp";
	public static final String HANDLE_WIN88 = "begin.time.hq.win88";
	public static final String HANDLE_GB = "begin.time.hq.gb";
	public static final String HANDLE_EBET = "begin.time.hq.ebet";
	public static final String HANDLE_GGPoker = "begin.time.hq.ggpoker";
	public static final String HANDLE_EIBC = "begin.time.eibc";
	public static final String HANDLE_YoPLAY = "begin.time.yoplay";
	public static final String HANDLE_IM = "begin.time.im";
	public static final String HANDLE_QWP = "begin.time.qwp";
	public static final String HANDLE_JDB = "begin.time.jdb";
	
	public static final String HANDLE_BET67_HY_LIVE = "begin.time.bet67.hy.live";
	public static final String HANDLE_BET67_OG_LOTTERY = "begin.time.bet67.og.lottery";
	public static final String HANDLE_BET67_OB_LIVE = "begin.time.bet67.ob.live";
	public static final String HANDLE_BET67_TS_SPORT = "begin.time.bet67.ts.sport";
	public static final String HANDLE_BET67_EBET_LIVE = "begin.time.bet67.ebet.live";
	public static final String HANDLE_BET67_VG = "begin.time.bet67.vg";
	public static final String HANDLE_BET67_AG_LIVE = "begin.time.bet67.ag.live";
	public static final String HANDLE_BET67_BBIN_LIVE = "begin.time.bet67.bbin.live";
	public static final String HANDLE_BET67_GD_LIVE = "begin.time.bet67.gd.live";
	public static final String HANDLE_BET67_HG_LIVE = "begin.time.bet67.hg.live";
	public static final String HANDLE_BET67_SL_LIVE = "begin.time.bet67.sl.live";
	public static final String HANDLE_BET67_OG_LIVE = "begin.time.bet67.og.live";
	public static final String HANDLE_BET67_ELG_SLOT = "begin.time.bet67.elg.slot";
	public static final String HANDLE_BET67_MG_SLOT = "begin.time.bet67.mg.slot";
	
	
	public static final String HANDLE_YSB_TY = "begin.time.ysbgame";
	public static final String HANDLE_KG_GAME = "begin.time.kggame";
	public static final String HANDLE_HG_GAME = "begin.time.hggame";
	
}