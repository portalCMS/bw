package com.hy.pull.common.util.game;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class KGGame {
	private static Logger logger = LoggerFactory.getLogger(KGGame.class);


	private static String vendorId = "264";
	private static String url = "http://gameinfo2.v88kgg.com/GameInfo.php";
	private static String secretKey = "DUkgi3Cw3wSm1fBt";

	/**
	 * 获取KG游戏数据
	 * 
	 * @param agent
	 *            代理
	 * @param param
	 *            参数
	 * @return 游戏数据
	 * @throws Exception
	 *             抛出异常
	 */
	public static List<Map<String, Object>> collectionData(Map<String, Object> param) throws Exception {
		StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>");
		sb.append("<methodCall>");
		sb.append("<methodName>GetGameInfo</methodName>");
		sb.append("<params>");
		sb.append("<param>");
		sb.append("<value>");
		sb.append("<struct>");
		sb.append("<member><name>VendorId</name><value><string>%s</string></value></member>");
		sb.append("<member><name>Token</name><value><string>%s</string></value></member>");
		sb.append("<member><name>Time</name><value><string>%s</string></value></member>");
		sb.append("</struct>");
		sb.append("</value>");
		sb.append("</param>");
		sb.append("</params>");
		sb.append("</methodCall>");
		String paramXMLStr = String.format(sb.toString(),param.get("vendorId"),param.get("secretKey"),param.get("Time"));
		logger.info("确认拉取KG请求参数：" + paramXMLStr);
		String data = post(url, paramXMLStr.toString());
		//String data = "{\"STATUSCODE\":\"1\",\"STATUSDESC\":\"SUCCESS\",\"DATA\":[{\"RecorId\":\"0009393756\",\"GameCode\":\"KENO\",\"PlayerId\":\"8888\",\"RegionId\":\"SUP\",\"GameId\":\"761605\",\"Amount\":\"3042.50\",\"JackpotNo\":\"810\",\"CreateTime\":\"2015-08-31 12:40:04\"}]}";
		//String data = "{\"STATUSCODE\":\"1\",\"STATUSDESC\":\"SUCCESS\",\"DATA\":[{\"BetId\":\"0000000157\",\"GameCode\":\"BC\",\"PlayerId\":\"8888\",\"GameId\":\"148865\",\"RegionId\":\"SUPER_BC_4\",\"BetType\":\"PAIRS\",\"BetSlip\":\"PLAYER_PAIRS@12.00\",\"Amount\":10000,\"StakeAccurate\":\"10000.00\",\"Credit\":\"1089398.50\",\"Payout\":-10000,\"PJackpot\":\"0.00\",\"CreateTime\":\"2015-10-16 10:25:32\",\"UpdateTime\":\"2015-10-16 10:25:46\"}]}";
		//String data = "{\"STATUSCODE\":\"1\",\"STATUSDESC\":\"SUCCESS\",\"DATA\":[{\"BetId\":\"0035395847\",\"GameCode\":\"KENO\",\"PlayerId\":\"dfhpeter522\",\"BetType\":\"ODD_EVEN\",\"BetSlip\":\"EVEN\",\"Odds\":\"1.96\",\"RegionId\":\"PEK\",\"GameId\":\"893557\",\"Amount\":10,\"StakeAccurate\":\"10.00\",\"Credit\":\"49.20\",\"Payout\":-10,\"PJackpot\":\"0.00\",\"CreateTime\":\"2018-06-15 15:05:35\",\"UpdateTime\":\"2018-06-15 15:10:30\"},{\"BetId\":\"0035395848\",\"GameCode\":\"KENO\",\"PlayerId\":\"dfhpeter522\",\"BetType\":\"BIG_SMALL\",\"BetSlip\":\"SMALL\",\"Odds\":\"1.96\",\"RegionId\":\"PEK\",\"GameId\":\"893557\",\"Amount\":10,\"StakeAccurate\":\"10.00\",\"Credit\":\"39.20\",\"Payout\":-10,\"PJackpot\":\"0.00\",\"CreateTime\":\"2018-06-15 15:05:35\",\"UpdateTime\":\"2018-06-15 15:10:30\"},{\"BetId\":\"0016475740\",\"GameCode\":\"SSC\",\"PlayerId\":\"dfhpeter522\",\"BetType\":\"TOTAL_EVEN\",\"RegionId\":\"CKG\",\"GameId\":\"180615055\",\"BetSlip\":\"\",\"Odds\":\"1.96\",\"Amount\":10,\"StakeAccurate\":\"10.00\",\"Credit\":\"30.00\",\"Payout\":-10,\"PJackpot\":\"0.00\",\"CreateTime\":\"2018-06-15 15:04:55\",\"UpdateTime\":\"2018-06-15 15:13:17\"}]}";
		logger.info("请求地址:" + url + ",返回结果："+data);
		List<Map<String, Object>> list = new ArrayList<>();
		JSONObject json = JSONObject.fromObject(data);
		if (null!=json.getString("STATUSCODE")&&json.getString("STATUSCODE").equals("1")) {
			Map<String, Object> entity = null;
			JSONArray jsonArr = JSONArray.fromObject(json.get("DATA"));
			for (int i = 0; i < jsonArr.size(); i++) {
				json = jsonArr.getJSONObject(i);
				entity = new HashMap<String, Object>();
				//entity.put("vendorId", json.get("VendorId")); // 运营商 ID
				entity.put("betId", json.getString("BetId")); // 投注注单编号
				entity.put("gameName", json.getString("GameCode")); // 显示注单属于KENO 或  SSC或 PK10
				entity.put("gameId", json.getString("GameId")); // 游戏编号与符号‘-
				entity.put("userName", json.getString("PlayerId")); // 独特的玩家名称
				entity.put("regionId", json.getString("RegionId")); // 赛事 ID
				entity.put("betTypeName", json.getString("BetType")); // 赛事 ID
				entity.put("betSlip", json.getString("BetSlip").length()<1?"无":json.getString("BetSlip")); // 游戏编号
				entity.put("betAmount", json.getString("Amount")); // 玩家的下注金额
				entity.put("valBetAmount", json.getString("StakeAccurate")); // （有效流水）为不计个人奖金回退
				entity.put("credit", json.getString("Credit")); // 玩家的当前余额
				entity.put("winOrLoss", json.getString("Payout")); // 玩家的输赢金额-赢/输则出现负数如: (-) 
				entity.put("jackpot", json.getString("PJackpot")); // 玩家的个人累积奖金
				entity.put("betTime", json.getString("UpdateTime")); //玩家下注结算时间
				entity.put("returnTime", json.getString("UpdateTime")); //玩家结算时间，统一用returnTime计算结算时间
				entity.put("updateTime", json.getString("CreateTime")); //系统派彩该期的时间
				entity.put("odds", "55"); // 返点
				list.add(entity);
			}
		}
		return list;
	}

	private static String format(String dateStr) {
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss", Locale.ENGLISH);
		TimeZone timeZone = TimeZone.getTimeZone("GMT+8:00");
		sdf.setTimeZone(timeZone);
		try {
			Date date = sdf.parse(dateStr);
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return sdf.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("deprecation")
	public static String post(String url, String xmlString) {
		// 关闭
		System.setProperty("org.apache.commons.logging.Log", "org.apache.commons.logging.impl.SimpleLog");
		System.setProperty("org.apache.commons.logging.simplelog.showdatetime", "true");
		System.setProperty("org.apache.commons.logging.simplelog.log.org.apache.commons.httpclient", "stdout");

		// 创建httpclient工具对象
		HttpClient client = new HttpClient();
		// 创建post请求方法
		PostMethod myPost = new PostMethod(url);
		// 设置请求超时时间
		client.setConnectionTimeout(300 * 1000);
		String responseString = null;
		try {
			// 设置请求头部类型
			myPost.setRequestHeader("Content-Type", "application/json");
			myPost.setRequestHeader("charset", "utf-8");

			// 设置请求体，即xml文本内容，注：这里写了两种方式，一种是直接获取xml内容字符串，一种是读取xml文件以流的形式
			myPost.setRequestBody(xmlString);

			int statusCode = client.executeMethod(myPost);
			if (statusCode == HttpStatus.SC_OK) {
				BufferedInputStream bis = new BufferedInputStream(myPost.getResponseBodyAsStream());
				byte[] bytes = new byte[1024];
				ByteArrayOutputStream bos = new ByteArrayOutputStream();
				int count = 0;
				while ((count = bis.read(bytes)) != -1) {
					bos.write(bytes, 0, count);
				}
				byte[] strByte = bos.toByteArray();
				responseString = new String(strByte, 0, strByte.length, "utf-8");
				bos.close();
				bis.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		myPost.releaseConnection();
		return responseString;
	}
	public static void main(String[] args) {
		//String data = "{\"STATUSCODE\":\"1\",\"STATUSDESC\":\"SUCCESS\",\"DATA\":[{\"RecorId\":\"0009393756\",\"GameCode\":\"KENO\",\"PlayerId\":\"8888\",\"RegionId\":\"SUP\",\"GameId\":\"761605\",\"Amount\":\"3042.50\",\"JackpotNo\":\"810\",\"CreateTime\":\"2015-08-31 12:40:04\"}]}";
		String data = "{\"STATUSCODE\":\"1\",\"STATUSDESC\":\"SUCCESS\",\"DATA\":[{\"BetId\":\"0000000157\",\"GameCode\":\"BC\",\"PlayerId\":\"8888\",\"GameId\":\"148865\",\"RegionId\":\"SUPER_BC_4\",\"BetType\":\"PAIRS\",\"BetSlip\":\"PLAYER_PAIRS@12.00\",\"Amount\":10000,\"StakeAccurate\":\"10000.00\",\"Credit\":\"1089398.50\",\"Payout\":-10000,\"PJackpot\":\"0.00\",\"CreateTime\":\"2015-10-16 10:25:32\",\"UpdateTime\":\"2015-10-16 10:25:46\"}]}";
		logger.info("请求地址:" + url + ",返回结果："+data);
		List<Map<String, Object>> list = new ArrayList<>();
		JSONObject json = JSONObject.fromObject(data);
		if (json.getString("STATUSCODE").equals("1")) {
			Map<String, Object> entity = null;
			JSONArray jsonArr = JSONArray.fromObject(json.get("DATA"));
			for (int i = 0; i < jsonArr.size(); i++) {
				json = jsonArr.getJSONObject(i);
				entity = new HashMap<String, Object>();
				entity.put("VendorId", json.get("VendorId")); // 运营商 ID
				entity.put("BetId", json.get("BetId")); // 投注注单编号
				entity.put("gameName", json.get("GameCode")); // 显示注单属于KENO 或  SSC或 PK10
				entity.put("gameId", json.get("GameId")); // 游戏编号与符号‘-
				entity.put("userName", json.get("PlayerId")); // 独特的玩家名称
				entity.put("regionId", json.get("RegionId")); // 赛事 ID
				entity.put("betTypeName", json.get("BetType")); // 赛事 ID
				entity.put("betSlip", json.get("BetSlip")); // 游戏编号
				entity.put("betAmount", json.get("Amount")); // 玩家的下注金额
				entity.put("valBetAmount", json.get("StakeAccurate")); // （有效流水）为不计个人奖金回退
				entity.put("credit", json.get("Credit")); // 玩家的当前余额
				entity.put("winOrLoss", json.get("Payout")); // 玩家的输赢金额-赢/输则出现负数如: (-) 
				entity.put("jackpot", json.get("PJackpot")); // 玩家的个人累积奖金
				entity.put("betTime", json.get("CreateTime")); //玩家下注该期的时间
				entity.put("updateTime", json.get("UpdateTime")); //系统派彩该期的时间
				entity.put("odds", json.get("Odds")); // 返点
				list.add(entity);
			}
	}
	}
}
