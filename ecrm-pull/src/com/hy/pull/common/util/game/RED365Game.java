package com.hy.pull.common.util.game;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.dom4j.DocumentException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class RED365Game {
	private static Logger logger = LoggerFactory.getLogger(RED365Game.class);
	private static String url = "http://webapi-asia.hointeractive.com/Betapi.asmx/GetAllBetDetailsPerTimeInterval";
	private static final String DATA_T = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
						//+"<string xmlns=\"http://service.hogaming.info/\">"
						+"<TotalRecords>1</TotalRecords>"
						+"<BetInfos>"
						+"<Betinfo>"
						+"<BetStartDate>2012/01/24 08:59:20</BetStartDate>"
						+"<BetEndDate>2012/01/24 08:59:27</BetEndDate>"
						+"<AccountId>test</AccountId>"
						+"<TableId>6wjz46hvko913lm4</TableId>"
						+"<TableName>Rng Carebbean Poker</TableName>"
						+"<GameId>R-0000000000000010322239</GameId>"
						+"<BetId>ipsngcvg5yffq6ulsb28c7ce56pbwipd</BetId>"
						+"<BetAmount>70.00</BetAmount>"
						+"<Payout>-70.00</Payout>"
						+"<Currency>CNY</Currency>"
						+"<GameType>Rng Carebbean Poker</GameType>"
						+"<BetSpot>Result</BetSpot>"
						+"<BetNo>ipsngcvg5yffq6ulsb28c7ce56pbwipd</BetNo>"
						+"<BetMode>WEB_V3</BetMode>"
						+"</Betinfo>"
						+"</BetInfos>";
						//+"</string>";

	/**
	 * 获取HG游戏数据
	 * @param agent 代理
	 * @param param 参数
	 * @return 游戏数据
	 * @throws Exception抛出异常
	 */
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> collectionData(Map<String, Object> param) throws Exception {
		List<Map<String, Object>> listMap =  new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> resultList =  new ArrayList<Map<String, Object>>();
		
		String agid = param.get("agId").toString();
		String start_date = param.get("start_date").toString();
		String end_date = param.get("end_date").toString();
		String key = param.get("key").toString();
		String apiUrl = param.get("apiUrl").toString();
		Map<String,String> pramsMap = new HashMap<String,String>();
		pramsMap.put("agid",agid);
		pramsMap.put("start_date",start_date);
		pramsMap.put("end_date",end_date);
		String signature = SHA1(agid+agid+start_date+end_date+key);
		pramsMap.put("signature", signature);
		logger.info("RED365拉取数据请求参数：" + pramsMap);
		String responseStr = post(apiUrl+"user_register", pramsMap.toString());

		JSONObject json = JSONObject.fromObject(responseStr);
		if("success".equals(json.getString("status"))){
			Map<String, Object> entity = null;
			JSONArray jsonArr = JSONArray.fromObject(json.get("DATA"));
			for (int i = 0; i < jsonArr.size(); i++) {
				json = jsonArr.getJSONObject(i);
				entity = new HashMap<String, Object>();
				entity.put("betId", json.getString("matchid")); // 投注注单编号
				entity.put("gameName", json.getString("game_type")); // 显示注单属于KENO 或  SSC或 PK10
				entity.put("gameId", json.getString("game_code")); // 游戏编号与符号‘-
				entity.put("userName", json.getString("username")); // 独特的玩家名称
				entity.put("regionId", json.getString("RegionId")); // 赛事 ID
				entity.put("betTypeName", json.getString("BetType")); // 赛事 ID
				entity.put("betSlip", json.getString("BetSlip")); // 游戏编号
				entity.put("betAmount", json.getString("bet")); // 玩家的下注金额
				entity.put("valBetAmount", json.getString("StakeAccurate")); // （有效流水）为不计个人奖金回退
				entity.put("credit", json.getString("Credit")); // 玩家的当前余额
				entity.put("winOrLoss", json.getString("winlose")); // 玩家的输赢金额-赢/输则出现负数如: (-) 
				entity.put("jackpot", json.getString("PJackpot")); // 玩家的个人累积奖金
				entity.put("betTime", json.getString("bet_time ")); //玩家下注该期的时间
				entity.put("updateTime", json.getString("UpdateTime")); //系统派彩该期的时间
				entity.put("odds", "55"); // 返点
				resultList.add(entity);
			}
		
		}
		return resultList;
	}
	
	public final static String SHA1(String decript) {
		try {
			MessageDigest digest = java.security.MessageDigest.getInstance("SHA-1");
			digest.update(decript.getBytes());
			byte messageDigest[] = digest.digest();
			// Create Hex String
			StringBuffer hexString = new StringBuffer();
			// 字节数组转换为 十六进制 数
			for (int i = 0; i < messageDigest.length; i++) {
				String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
				if (shaHex.length() < 2) {
					hexString.append(0);
				}
				hexString.append(shaHex);
			}
			return hexString.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
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
			myPost.setRequestHeader("Content-Type", "application/xml");
			myPost.setRequestHeader("charset", "utf-8");

			// 设置请求体，即xml文本内容，注：这里写了两种方式，一种是直接获取xml内容字符串，一种是读取xml文件以流的形式
			myPost.setRequestBody(xmlString);
			int statusCode = client.executeMethod(myPost);
			System.out.println("***************statusCode:"+statusCode);
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
	
	public static void main(String[] args) throws DocumentException {
		StringBuilder sb = new StringBuilder("<?xml version=\"1.0\"?>");
		sb.append("<GetAllBetDetailsPerTimeInterval>");
		sb.append("<Username>web@play8live.com</Username>");
		sb.append("<Password>1qaz@WSX</Password>");
		sb.append("<CasinoId>play8live1segame</CasinoId>");
		sb.append("<startTime>2018/06/08 17:20:00</startTime>");
		sb.append("<EndTime>2018/06/08 17:30:00</EndTime>");
		sb.append("</GetAllBetDetailsPerTimeInterval>");
		String data = post("http://webapi-asia.hointeractive.com/Betapi.asmx/GetAllBetDetailsPerTimeInterval",sb.toString());
		System.out.println(data.replace("&lt;", "<").replace("&gt;", ">"));
	}
}
