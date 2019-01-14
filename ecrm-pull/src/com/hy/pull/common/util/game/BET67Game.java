package com.hy.pull.common.util.game;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.io.IOUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.hy.pull.common.util.DateUtil;
import com.hy.pull.common.util.Encrypt;
import com.hy.pull.service.BaseService.Enum_flag;
import com.hy.pull.service.game.LogUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 拉取东方游戏数据工具类 创建日期：2016-10-10
 * 
 * @author temdy
 */
public class BET67Game {
	private static Logger logger = LogManager.getLogger(BET67Game.class.getName());
	private static final String CHARSET = "UTF-8";

	/**
	 * 流水号(每次会取该流水号之后的100条数据返回，取最后一条数据的ID做为下一次提交的recordid)
	 * @param apiUrl
	 * @param agent
	 * @param recordId
	 * @param platform
	 * @param agentId
	 * @param md5Key
	 * @param dataHandle
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> get67BetData(String apiUrl, String agent, String recordId, String platform,
			String agentId, String md5Key,String dataHandle) {
		List<Map<String, Object>> list = new ArrayList<>();
		StringBuilder param = new StringBuilder();
		try {
			if (recordId == null) {
				recordId = "0";
			}
			// 加密串：recordid|platform|agentid|key
			StringBuffer sb = new StringBuffer();
			sb.append(recordId).append("|").append(platform).append("|").append(agentId)
					.append("|").append(md5Key);
			String hashcode = Encrypt.MD5(sb.toString());
			Map<String, Object> map = new HashMap<>();
			map.put("agentid", agentId);
			map.put("hashcode", hashcode);
			map.put("recordid", recordId);
			map.put("platform", platform);
			String result = doPost(apiUrl, map);
			System.out.println("数据抓取请求参数 ："+map.toString()+",返回数据结果："+result);
			if (result == null || "null".equals(result) || "[]".equals(result) || "{}".equals(result)) {
				return null;
			}
			if (result != null) {
				Map<String, Object> entity = null;
				JSONObject info = null;
				JSONArray jsonArr =new JSONArray();
				if(apiUrl.endsWith("GetRecordById")){
					jsonArr.add(JSONObject.fromObject(result));
				}else{
					 jsonArr = JSONArray.fromObject(result);
				}
				for(int j=0;j<jsonArr.size();j++){
					info =jsonArr.getJSONObject(j);
					entity = new LinkedHashMap<String, Object>();
					entity.put("id", info.get("Id"));
					entity.put("returnTime",new Date());
					//不过最好的统计有效投注，取WinOrLoss<>0且IsBill为已结算的BetAmount总和
					if(platform.equals("hy_live")){
						//[{"Id":"20180127-0251-0163-6248-6300edc6850e","UserName":"pytestelon13","GameRoundId":"48","GameTypeName":"百家乐","BetTime":"2018-01-27 02:45:29","BetAmount":"20.00","WinOrLoss":"-20.000","BetTypeName":"和","PlatformName":"旗舰厅","GameKind":"标准百家乐","Balance":"3.00","IsBill":"已结算","BetId":"1287577065"}]
						entity.put("userName", info.get("UserName"));
						entity.put("gameRoundId", info.get("GameRoundId"));
						entity.put("gameTypeName", info.get("GameTypeName"));
						entity.put("betTime", dateFormat(info.getString("BetTime")));
						entity.put("betAmount", info.get("BetAmount"));
						if(info.getDouble("WinOrLoss") !=0 && "已结算".equals(info.get("IsBill"))){
							entity.put("validAmount", info.get("BetAmount"));
						}else{
							entity.put("validAmount", "0");
							entity.put("returnTime",null);
						}
						entity.put("winOrLoss", info.get("WinOrLoss"));
						entity.put("betTypeName", info.get("BetTypeName"));
						entity.put("gameResult", info.get("GameResult"));
						entity.put("tableName", info.get("TableName"));
						entity.put("billTime", dateFormat(info.getString("BillTime")));
						entity.put("isBill", info.get("IsBill"));
						entity.put("betId", info.get("BetId"));
						entity.put("betBefore", info.get("BetBefore"));
						entity.put("billAfter", info.get("BillAfter"));
					}else if(platform.equals("og_lottery")){
						entity.put("userName", info.get("UserName"));
						entity.put("betId", info.get("BetId"));
						entity.put("gameName", info.get("GameName"));
						entity.put("phaseNum", info.get("PhaseNum"));
						entity.put("betTime", dateFormat(info.getString("BetTime")));
						entity.put("betAmount", info.get("BetAmount"));
						if(info.getDouble("WinOrLoss") !=0 && "已结算".equals(info.get("Status"))){
							entity.put("validAmount", info.get("BetAmount"));
						}else{
							entity.put("validAmount", "0");
							entity.put("returnTime",null);
						}
						entity.put("winOrLoss", info.get("WinOrLoss"));
						entity.put("betTypeName", info.get("BetTypeName"));
						entity.put("betStatus", info.get("Status"));
					}else if(platform.equals("ob_live")){
						entity.put("userName", info.get("UserName"));
						entity.put("betId", info.get("GameRoundId"));
						entity.put("gameTypeName", info.get("GameTypeName"));
						entity.put("betTime", dateFormat(info.getString("BetTime")));
						entity.put("betAmount", info.get("BetAmount"));
						if(info.getDouble("WinOrLoss") !=0){
							entity.put("validAmount", info.get("BetAmount"));
						}else{
							entity.put("validAmount", "0");
							entity.put("returnTime",null);
						}
						entity.put("winOrLoss", info.get("WinOrLoss"));
						entity.put("betStatus", info.get("Status"));
						entity.put("betTypeName", info.get("BetTypeName"));
						entity.put("gameResult", info.get("GameResult"));
						entity.put("tableName", info.get("TableName"));
						entity.put("commissionName", info.get("CommissionName"));
						entity.put("gameStartTime", dateFormat(info.getString("GameStartTime")));
						entity.put("gameEndTime", dateFormat(info.getString("GameEndTime")));
					}else if(platform.equals("ts_sport")){
						//[{"Id":"20180127-0240-5549-e24d-1565f3f7b25d","BetId":"AH12963360","IsNormalWager":true,"PlayTypeName":"足球","UserName":"pytestelon13","MatchName":"印度I联赛U18","EventName":"拉庄U18 VS 兰达吉德联U18","MatchDate":"2018-01-27 03:30:00","BetTypeName":"让球","TeamBetName":"主","BetTime":"2018-01-27 02:38:45","WagerOdds":"0.720","WagerStake":"5.00","WinAmt":"3.60","Score":"0:0","Status":"有效","Remark":"","Handicap":"-1.25","BillTime":"2018-01-27 05:31:13","IsBill":"1","BetDetail":"<font color=\"#eb6307\">主 -1.25 @ 0.720</font><br/><font color=\"#666666\"><b>让球</b></font><br/>拉庄U18 VS 兰达吉德联U18<br/><font color=\"blue\"><b>足球</b></font>印度I联赛U18"},{"Id":"20180127-0240-5644-1feb-8fd1710aa203","BetId":"OE12963377","IsNormalWager":true,"PlayTypeName":"足球","UserName":"pytestelon13","MatchName":"香港高级组银牌赛","EventName":"东方体育会 VS 元朗","MatchDate":"2018-01-27 03:00:00","BetTypeName":"单/双","TeamBetName":"双","BetTime":"2018-01-27 02:39:08","WagerOdds":"1.930","WagerStake":"5.00","WinAmt":"-5.00","Score":"0:0","Status":"有效","Remark":"","Handicap":"0.00","BillTime":"2018-01-27 05:00:05","IsBill":"1","BetDetail":"<font color=\"#eb6307\">双 0.00 @ 1.930</font><br/><font color=\"#666666\"><b>单/双</b></font><br/>东方体育会 VS 元朗<br/><font color=\"blue\"><b>足球</b></font>香港高级组银牌赛"}]
						entity.put("betId", info.get("BetId"));
						entity.put("isNormalWager", info.get("IsNormalWager"));
						entity.put("playTypeName", info.get("PlayTypeName"));
						entity.put("userName", info.get("UserName"));
						entity.put("matchName", info.get("MatchName"));
						entity.put("eventName", info.get("EventName"));
						entity.put("matchDate", info.get("MatchDate"));
						entity.put("betTypeName", info.get("BetTypeName"));
						entity.put("teamBetName", info.get("TeamBetName"));
						entity.put("betTime", dateFormat(info.getString("BetTime")));
						entity.put("wagerOdds", info.get("WagerOdds"));
						entity.put("wagerStake", info.get("WagerStake"));
						if(info.getDouble("WinAmt") !=0 && "有效".equals(info.get("Status"))){
							entity.put("validAmount", info.get("WagerStake"));
						}else{
							entity.put("validAmount", "0");
							entity.put("returnTime",null);
						}
						entity.put("winAmt", info.get("WinAmt"));
						entity.put("score", info.get("Score"));
						entity.put("betStatus", info.get("Status"));
						entity.put("remark", info.get("Remark"));
						entity.put("handicap", info.get("Handicap"));
						if("1".equals(info.getString("IsBill"))){
							entity.put("billTime", dateFormat(info.getString("BillTime")));
						}else{
							entity.put("billTime", null);
							entity.put("returnTime",null);
						}
						entity.put("isBill", info.get("IsBill"));
						entity.put("betDetail", info.get("BetDetail"));
					}else if(platform.equals("ebet_live")){
						entity.put("userName", info.get("UserName"));
						entity.put("betId", info.get("BetId"));
						entity.put("gameRoundId", info.get("GameRoundId"));
						entity.put("gameTypeName", info.get("GameTypeName"));
						entity.put("betTime", dateFormat(info.getString("BetTime")));
						entity.put("betAmount", info.get("BetAmount"));
						if(info.getDouble("WinOrLoss") !=0 && "已结算".equals(entity.get("IsBill"))){
							entity.put("validAmount", info.get("BetAmount"));
						}else{
							entity.put("validAmount", "0");
							entity.put("returnTime",null);
						}
						entity.put("winOrLoss", info.get("WinOrLoss"));
						entity.put("betTypeName", info.get("BetTypeName"));
						entity.put("gameResult", info.get("GameResult"));
						entity.put("billTime", dateFormat(info.getString("BillTime")));
						entity.put("isBill", info.get("IsBill"));
					}else if(platform.equals("vg")){
						entity.put("userName", info.get("UserName"));
						entity.put("betId", info.get("BetId"));
						entity.put("roomName", info.get("RoomName"));
						entity.put("gameName", info.get("GameName"));
						entity.put("betTime", dateFormat(info.getString("BetTime")));
						entity.put("isLord", info.get("IsLord"));
						entity.put("betAmount", info.get("BetAmount"));
						entity.put("serviceMoney", info.get("ServiceMoney"));
						entity.put("winOrLoss", info.get("WinOrLoss"));
					}else if(platform.equals("ag_live")){
						//[{"ID":"224696810","orderid":"180130005462307","bettime":"2018/1/30 0:12:56","playType":"闲","BetMoney":"200.00","OkBetMoney":"200.00","BetResult":"200.00","username":"pymak1124","gameType":"百家乐","isbill":"已结算","gameCode":"GC0011813000D","tableCode":"C132"},{"ID":"224697528","orderid":"180130005590767","bettime":"2018/1/30 0:15:58","playType":"闲","BetMoney":"50.00","OkBetMoney":"50.00","BetResult":"-50.00","username":"pymak1124","gameType":"多台","isbill":"已结算","gameCode":"GC005181291BA","tableCode":"C005"},{"ID":"224697851","orderid":"180130005616249","bettime":"2018/1/30 0:16:35","playType":"闲","BetMoney":"90.00","OkBetMoney":"90.00","BetResult":"-90.00","username":"pymak1124","gameType":"多台","isbill":"已结算","gameCode":"GC005181291BB","tableCode":"C005"},{"ID":"224697886","orderid":"180130005599740","bettime":"2018/1/30 0:16:15","playType":"庄","BetMoney":"40.00","OkBetMoney":"38.00","BetResult":"38.00","username":"pymak1124","gameType":"多台","isbill":"已结算","gameCode":"GC0011813000H","tableCode":"C001"},{"ID":"224698233","orderid":"180130005649787","bettime":"2018/1/30 0:17:22","playType":"闲","BetMoney":"100.00","OkBetMoney":"100.00","BetResult":"-100.00","username":"pymak1124","gameType":"多台","isbill":"已结算","gameCode":"GC002181291L3","tableCode":"C002"},{"ID":"224698290","orderid":"180130005639954","bettime":"2018/1/30 0:17:12","playType":"闲","BetMoney":"100.00","OkBetMoney":"100.00","BetResult":"100.00","username":"pymak1124","gameType":"多台","isbill":"已结算","gameCode":"GC0011813000I","tableCode":"C001"},{"ID":"224699394","orderid":"180130005806522","bettime":"2018/1/30 0:21:14","playType":"凤","BetMoney":"90.00","OkBetMoney":"90.00","BetResult":"-90.00","username":"pymak1124","gameType":"炸金花","isbill":"已结算","gameCode":"GC0161813000K","tableCode":"ZJH1"},{"ID":"224699565","orderid":"180130005873760","bettime":"2018/1/30 0:22:47","playType":"顺子","BetMoney":"10.00","OkBetMoney":"10.00","BetResult":"-10.00","username":"pymak1124","gameType":"炸金花","isbill":"已结算","gameCode":"GC0161813000L","tableCode":"ZJH1"},{"ID":"224699566","orderid":"180130005873758","bettime":"2018/1/30 0:22:47","playType":"同花","BetMoney":"10.00","OkBetMoney":"10.00","BetResult":"-10.00","username":"pymak1124","gameType":"炸金花","isbill":"已结算","gameCode":"GC0161813000L","tableCode":"ZJH1"},{"ID":"224699567","orderid":"180130005873754","bettime":"2018/1/30 0:22:47","playType":"豹子","BetMoney":"10.00","OkBetMoney":"10.00","BetResult":"-10.00","username":"pymak1124","gameType":"炸金花","isbill":"已结算","gameCode":"GC0161813000L","tableCode":"ZJH1"},{"ID":"224699568","orderid":"180130005873747","bettime":"2018/1/30 0:22:47","playType":"同花顺","BetMoney":"10.00","OkBetMoney":"10.00","BetResult":"-10.00","username":"pymak1124","gameType":"炸金花","isbill":"已结算","gameCode":"GC0161813000L","tableCode":"ZJH1"},{"ID":"224699569","orderid":"180130005871363","bettime":"2018/1/30 0:22:44","playType":"凤","BetMoney":"140.00","OkBetMoney":"140.00","BetResult":"-140.00","username":"pymak1124","gameType":"炸金花","isbill":"已结算","gameCode":"GC0161813000L","tableCode":"ZJH1"},{"ID":"224699895","orderid":"180130005905214","bettime":"2018/1/30 0:23:30","playType":"凤","BetMoney":"28.00","OkBetMoney":"28.00","BetResult":"-28.00","username":"pymak1124","gameType":"炸金花","isbill":"已结算","gameCode":"GC0161813000M","tableCode":"ZJH1"}]
						entity.put("id", info.get("ID"));
						entity.put("betId", info.get("orderid"));
						entity.put("betTime", dateFormat(info.getString("bettime").replace("/", "-")));
						entity.put("playType", info.get("playType"));
						entity.put("betMoney", info.get("BetMoney"));
						entity.put("okBetMoney", info.get("OkBetMoney"));
						entity.put("betResult", info.get("BetResult"));
						entity.put("userName", info.get("username"));
						entity.put("gameType", info.get("gameType"));
						entity.put("isbill", info.get("isbill"));
						entity.put("gameCode", info.get("gameCode"));
						entity.put("tableCode", info.get("tableCode"));
					}else if(platform.equals("bbin_live")){
						//[{"ID":"44596008","bettime":"2018-01-29 09:29:48","gkind":"3","gtype":"百家乐","OrderNo":"16324693901","SerialID":"117628667","OkBetMoney":"20.00","BetMoney":"20.00","BetResult":"-20.00","username":"pymak1124","isbill":"1"},{"ID":"44596009","bettime":"2018-01-29 09:29:59","gkind":"3","gtype":"百家乐","OrderNo":"16324696178","SerialID":"117628672","OkBetMoney":"20.00","BetMoney":"20.00","BetResult":"19.00","username":"pymak1124","isbill":"1"},{"ID":"44596010","bettime":"2018-01-29 09:30:07","gkind":"3","gtype":"龙虎斗","OrderNo":"16324698040","SerialID":"117628675","OkBetMoney":"10.00","BetMoney":"10.00","BetResult":"10.00","username":"pymak1124","isbill":"1"},{"ID":"44596011","bettime":"2018-01-29 09:30:49","gkind":"3","gtype":"龙虎斗","OrderNo":"16324707040","SerialID":"117628703","OkBetMoney":"10.00","BetMoney":"10.00","BetResult":"10.00","username":"pymak1124","isbill":"1"},{"ID":"44596012","bettime":"2018-01-29 09:31:22","gkind":"3","gtype":"百家乐","OrderNo":"16324712691","SerialID":"117628729","OkBetMoney":"20.00","BetMoney":"20.00","BetResult":"20.00","username":"pymak1124","isbill":"1"},{"ID":"44596013","bettime":"2018-01-29 09:32:00","gkind":"3","gtype":"龙虎斗","OrderNo":"16324721118","SerialID":"117628754","OkBetMoney":"20.00","BetMoney":"20.00","BetResult":"20.00","username":"pymak1124","isbill":"1"},{"ID":"44596014","bettime":"2018-01-29 09:32:05","gkind":"3","gtype":"百家乐","OrderNo":"16324722910","SerialID":"117628747","OkBetMoney":"10.00","BetMoney":"10.00","BetResult":"-10.00","username":"pymak1124","isbill":"1"},{"ID":"44596015","bettime":"2018-01-29 09:32:25","gkind":"3","gtype":"百家乐","OrderNo":"16324726983","SerialID":"117628766","OkBetMoney":"20.00","BetMoney":"20.00","BetResult":"20.00","username":"pymak1124","isbill":"1"},{"ID":"44596016","bettime":"2018-01-29 09:32:29","gkind":"3","gtype":"百家乐","OrderNo":"16324727570","SerialID":"117628768","OkBetMoney":"40.00","BetMoney":"40.00","BetResult":"-40.00","username":"pymak1124","isbill":"1"},{"ID":"44596017","bettime":"2018-01-29 09:33:11","gkind":"3","gtype":"百家乐","OrderNo":"16324736367","SerialID":"117628795","OkBetMoney":"40.00","BetMoney":"40.00","BetResult":"-40.00","username":"pymak1124","isbill":"1"},{"ID":"44596018","bettime":"2018-01-29 09:33:18","gkind":"3","gtype":"龙虎斗","OrderNo":"16324738515","SerialID":"117628801","OkBetMoney":"30.00","BetMoney":"30.00","BetResult":"30.00","username":"pymak1124","isbill":"1"},{"ID":"44596019","bettime":"2018-01-29 09:33:25","gkind":"3","gtype":"百家乐","OrderNo":"16324740379","SerialID":"117628802","OkBetMoney":"30.00","BetMoney":"30.00","BetResult":"30.00","username":"pymak1124","isbill":"1"}]
						entity.put("id", info.get("ID"));
						entity.put("betId", info.get("OrderNo"));
						entity.put("betTime", dateFormat(info.getString("bettime")));
						entity.put("userName", info.get("username"));
						if("3".equals(info.getString("gkind"))){
							entity.put("gKind", "真人");
						}else if("5".equals(info.getString("gkind"))){
							entity.put("gKind", "电子");
						}else{
							entity.put("gKind", info.get("gkind"));
						}
						entity.put("gType", info.get("gtype"));
						entity.put("serialId", info.get("SerialID"));
						entity.put("betMoney", info.get("BetMoney"));
						entity.put("betResult", info.get("BetResult"));
						entity.put("isbill", (info.get("isbill")==null || !"1".equals(info.getString("isbill")))?"未结算":"已结算");
						//和局
						if(info.getDouble("BetResult") !=0 && "已结算".equals(entity.get("isbill"))){
							entity.put("okBetMoney", info.get("OkBetMoney"));
						}else{
							entity.put("okBetMoney", "0");
							entity.put("returnTime",null);
						}
					}else if(platform.equals("gd_live")){
						entity.put("id", info.get("ID"));
						entity.put("betId", info.get("BetID"));
						entity.put("betTime", dateFormat(info.getString("bettime")));
						entity.put("gameId", info.get("GameID"));
						entity.put("betMoney", info.get("BetMoney"));
						if(info.getDouble("BetResult") !=0 && !"和".equals(info.get("state"))){
							entity.put("validAmount", info.get("BetMoney"));
						}else{
							entity.put("validAmount", "0");
							entity.put("returnTime",null);
						}
						entity.put("betResult", info.get("BetResult"));
						entity.put("userName", info.get("username"));
						entity.put("gameType", info.get("gametype"));
						entity.put("subBetType", info.get("SubBetType"));
						entity.put("startBalance", info.get("StartBalance"));
						entity.put("openDetail", info.get("opendetail"));
						entity.put("state", info.get("state"));
					}else if(platform.equals("hg_live")){
						entity.put("id", info.get("ID"));
						entity.put("betId", info.get("BetId"));
						entity.put("betTime", dateFormat(info.getString("betstartdate")));
						entity.put("gameId", info.get("gameid"));
						entity.put("betAmount", info.get("betamount"));
						if(info.getDouble("payout") !=0){
							entity.put("validAmount", info.get("betamount"));
						}else{
							entity.put("validAmount", "0");
							entity.put("returnTime",null);
						}
						entity.put("payOut", info.get("payout"));
						entity.put("userName", info.get("accountid"));
						entity.put("gameType", info.get("gametype"));
						entity.put("openDetail", info.get("opendetail"));
						entity.put("billTime", dateFormat(info.getString("betenddate")));
						entity.put("betDetail", info.get("betdetail"));
					}else if(platform.equals("sl_live")){
						//[{"ID":"16033617","recId":"1190730865","bettime":"2018/2/26 22:25:12","desNo":null,"BetMoney":"7.50","Round":"-1","BetResult":"0.00","username":"pytestelon15","gameCode":"电子游艺：三星报?","betRgn":"玩法ID：30","chipLeft":"--","openAnswer":"--","opendetail":"--","bSuccess":"成功"},{"ID":"16033622","recId":"1190731297","bettime":"2018/2/26 22:25:29","desNo":null,"BetMoney":"7.50","Round":"-1","BetResult":"-7.50","username":"pytestelon15","gameCode":"电子游艺：三星报?","betRgn":"玩法ID：30","chipLeft":"--","openAnswer":"--","opendetail":"--","bSuccess":"成功"},{"ID":"16033625","recId":"1190731399","bettime":"2018/2/26 22:25:36","desNo":null,"BetMoney":"7.50","Round":"-1","BetResult":"-7.50","username":"pytestelon15","gameCode":"电子游艺：三星报?","betRgn":"玩法ID：30","chipLeft":"--","openAnswer":"--","opendetail":"--","bSuccess":"成功"},{"ID":"16033626","recId":"1190731475","bettime":"2018/2/26 22:25:41","desNo":null,"BetMoney":"7.50","Round":"-1","BetResult":"12.50","username":"pytestelon15","gameCode":"电子游艺：三星报?","betRgn":"玩法ID：30","chipLeft":"--","openAnswer":"--","opendetail":"--","bSuccess":"成功"},{"ID":"16033629","recId":"1190731758","bettime":"2018/2/26 22:25:54","desNo":null,"BetMoney":"7.50","Round":"-1","BetResult":"-7.50","username":"pytestelon15","gameCode":"电子游艺：三星报?","betRgn":"玩法ID：30","chipLeft":"--","openAnswer":"--","opendetail":"--","bSuccess":"成功"},{"ID":"16033632","recId":"1190731882","bettime":"2018/2/26 22:26:00","desNo":null,"BetMoney":"7.50","Round":"-1","BetResult":"-7.50","username":"pytestelon15","gameCode":"电子游艺：三星报?","betRgn":"玩法ID：30","chipLeft":"--","openAnswer":"--","opendetail":"--","bSuccess":"成功"},{"ID":"16033635","recId":"1190731983","bettime":"2018/2/26 22:26:04","desNo":null,"BetMoney":"7.50","Round":"-1","BetResult":"-7.50","username":"pytestelon15","gameCode":"电子游艺：三星报?","betRgn":"玩法ID：30","chipLeft":"--","openAnswer":"--","opendetail":"--","bSuccess":"成功"},{"ID":"16033637","recId":"1190732084","bettime":"2018/2/26 22:26:11","desNo":null,"BetMoney":"7.50","Round":"-1","BetResult":"-7.50","username":"pytestelon15","gameCode":"电子游艺：三星报?","betRgn":"玩法ID：30","chipLeft":"--","openAnswer":"--","opendetail":"--","bSuccess":"成功"},{"ID":"16033641","recId":"1190732191","bettime":"2018/2/26 22:26:16","desNo":null,"BetMoney":"7.50","Round":"-1","BetResult":"-7.50","username":"pytestelon15","gameCode":"电子游艺：三星报?","betRgn":"玩法ID：30","chipLeft":"--","openAnswer":"--","opendetail":"--","bSuccess":"成功"},{"ID":"16033763","recId":"1190731172","bettime":"2018/2/26 22:25:23","desNo":null,"BetMoney":"7.50","Round":"-1","BetResult":"-7.50","username":"pytestelon15","gameCode":"电子游艺：三星报?","betRgn":"玩法ID：30","chipLeft":"--","openAnswer":"--","opendetail":"--","bSuccess":"成功"}]
						entity.put("id", info.get("ID"));
						entity.put("betId", info.get("recId"));
						entity.put("betTime", dateFormat(info.getString("bettime")));
						entity.put("desNo", info.get("deskNo"));
						entity.put("betMoney", info.get("BetMoney"));
						if(info.getDouble("BetResult") !=0 && "成功".equals(info.get("bSuccess"))){
							entity.put("validAmount", info.get("BetMoney"));
						}else{
							entity.put("validAmount", "0");
							entity.put("returnTime",null);
						}
						entity.put("round", info.get("Round"));
						entity.put("betResult", info.get("BetResult"));
						entity.put("userName", info.get("username"));
						entity.put("gameCode", info.get("gameCode"));
						entity.put("betRgn", info.get("betRgn"));
						entity.put("chipLeft", info.get("chipLeft"));
						entity.put("openAnswer", info.get("openAnswer"));
						entity.put("openDetail", info.get("opendetail"));
						entity.put("bSuccess", info.get("bSuccess"));
					}else if(platform.equals("og_live")){
						entity.put("id", info.get("Id"));
						entity.put("userName", info.get("UserName"));
						entity.put("gameRoundId", info.get("GameRoundId"));
						entity.put("gameTypeName", info.get("GameTypeName"));
						entity.put("betTime", dateFormat(info.getString("BetTime")));
						entity.put("betAmount", info.get("BetAmount"));
						if(info.getDouble("WinOrLoss") !=0 && "已结算".equals(info.get("IsBill"))){
							entity.put("validAmount", info.get("BetAmount"));
						}else{
							entity.put("validAmount", "0");
							entity.put("returnTime",null);
						}
						entity.put("winOrLoss", info.get("WinOrLoss"));
						entity.put("betTypeName", info.get("BetTypeName"));
						entity.put("platformName", info.get("PlatformName"));
						entity.put("gameKind", info.get("GameKind"));
						entity.put("balance", info.get("Balance"));
						entity.put("isBill", info.get("IsBill"));
						entity.put("betId", info.get("BetId"));
					}else if(platform.equals("elg_slot")){
						entity.put("id", info.get("ID"));
						entity.put("userName", info.get("username"));
						entity.put("betId", info.get("gameSetId"));
						entity.put("gameCode", info.get("gamecode"));
						entity.put("gameName", info.get("gamename"));
						entity.put("betTime", dateFormat(info.getString("bettime")));
						entity.put("betMoney", info.get("BetMoney"));
						if(info.getDouble("WinOrLoss") !=0){
							entity.put("validAmount", info.get("BetMoney"));
						}else{
							entity.put("validAmount", "0");
							entity.put("returnTime",null);
						}
						entity.put("winOrLoss", info.get("WinOrLoss"));
						entity.put("betBefore", info.get("BetBefore"));
						entity.put("billBefore", info.get("BillBefore"));
						entity.put("isBill", info.get("IsBill"));
					}else if(platform.equals("mg_slot")){
						entity.put("id", info.get("Id"));
						entity.put("userName", info.get("UserName"));
						entity.put("gameCode", info.get("GameCode"));
						entity.put("gameName", info.get("GameName"));
						entity.put("betId", info.get("GameRoundId"));
						entity.put("betTime", dateFormat(info.getString("BetTime")));
						entity.put("betAmount", info.get("BetAmount"));
						if(info.getDouble("WinOrLoss") !=0 && "已结算".equals(info.get("IsBill"))){
							entity.put("validAmount", info.get("BetAmount"));
						}else{
							entity.put("validAmount", "0");
							entity.put("returnTime",null);
						}
						entity.put("winOrLoss", info.get("WinOrLoss"));
						entity.put("isBill", info.get("IsBill"));
					}
					list.add(entity);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error(ex);
			LogUtil.addListLog(dataHandle, apiUrl + "?" + param, ex.getMessage(), agent, Enum_flag.异常.value);
			return null;
		}
		return list;
	}

	/**
	 * 发起POST请求
	 * 
	 * @param url
	 *            请求地址
	 * @param params
	 *            请求参数
	 * @return
	 * @throws IOException
	 * @throws HttpException
	 */
	private static String doPost(String url, Map<String, Object> params) {
		InputStream is = null;
		try {
			PostMethod post = new PostMethod(url);
			// 表单方式提交
			post.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			// 请求字符UTF8
			post.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, CHARSET);
			// 若有参数, 则生成NameValuePair, 放入post中
			if (params != null && params.size() > 0) {
				NameValuePair[] parametersBody = new NameValuePair[params.size()];
				Set<Entry<String, Object>> sets = params.entrySet();
				Iterator<Entry<String, Object>> ite = sets.iterator();
				Entry<String, Object> entry;
				int i = 0;
				while (ite.hasNext()) {
					entry = ite.next();
					parametersBody[i++] = new NameValuePair(entry.getKey(), entry.getValue().toString());
				}
				post.setRequestBody(parametersBody);
			}
			HttpClient httpClient = new HttpClient();
			httpClient.executeMethod(post);
			is = post.getResponseBodyAsStream();
			String response = IOUtils.toString(is);
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("捞取BET67投注记录异常：", e);
		} finally {
			try {
				if (is != null) {
					is.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return null;

	}
	
	private static String dateFormat(String date){
		String sdf ="yyyy-MM-dd HH:mm:ss";
		Date betTime = DateUtil.add(DateUtil.parse(date.replace("/", "-"), sdf), Calendar.HOUR	, 12);
		return DateUtil.parse(betTime, sdf);
	}
}
