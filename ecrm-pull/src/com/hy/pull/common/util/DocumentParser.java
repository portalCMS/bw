package com.hy.pull.common.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class DocumentParser {

	public static List<Map<String, Object>> parsePtBetorderXml(String xml, String agent) {

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		if (StringUtils.isNotEmpty(xml)) {
			try {
				JSONObject balJson = JSONObject.fromObject(xml);
				JSONArray betDarr = balJson.getJSONArray("Result");
				Map<String, Object> entity = null;
				JSONObject info = null;
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
				if (null != betDarr) {
					for (int i = 0; i < betDarr.size(); i++) {
						info = betDarr.getJSONObject(i);
						entity = new HashMap<String, Object>();
						entity.put("pt_gamecode", info.getString("GameCode"));
						entity.put("pt_username", info.getString("PlayerName"));
						entity.put("pt_windowcode", info.getString("WindowCode"));
						entity.put("pt_gametype", info.getString("GameType"));
						String gamename = info.getString("GameName").replace("'", "");
						entity.put("pt_gamename", gamename);
						gamename = gamename.split("\\(")[1].replaceAll("\\)", "");
						gamename = gamename.trim();
						entity.put("pt_gameid", gamename);// GAMEID字段是PT返回的他们的ID字段，并无实际作用
						entity.put("pt_bet", info.getString("Bet"));
						entity.put("pt_currentbet", info.getString("Win"));// 此字段用来存储原生的WIN金额=info.getString("CURRENTBET")
						double win = Double.valueOf(info.getString("Win"));
						double bet = Double.valueOf(info.getString("Bet"));
						entity.put("pt_win", MoneyHelper.doubleFormat(win - bet));// 输的时候这里显示0，赢的时候显示盈利
						entity.put("pt_balance", info.getString("Balance"));
						entity.put("pt_gamedate", info.getString("GameDate"));
						entity.put("pt_info", "");
						entity.put("pt_sessionid", info.getString("SessionId"));
						entity.put("pt_progressivebet", info.getString("ProgressiveBet"));
						entity.put("pt_progressivewin", info.getString("ProgressiveWin"));
						entity.put("pt_livenetwork", info.getString("LiveNetwork"));
						entity.put("pt_rnum", info.has("RNum") ? info.getString("RNum") : "0");
						entity.put("pt_createtime", sdf.format(new Date()));
						entity.put("Platformflag", agent);
						list.add(entity);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
}
