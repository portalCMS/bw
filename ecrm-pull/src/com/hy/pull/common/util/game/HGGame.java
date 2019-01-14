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
import org.dom4j.DocumentException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hy.pull.common.util.XmlUtils;

public class HGGame {
	private static Logger logger = LoggerFactory.getLogger(HGGame.class);
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
		StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>");
		sb.append("<GetAllBetDetailsPerTimeInterval>");
		sb.append("<Username>%s</Username>");
		sb.append("<Password>%s</Password>");
		sb.append("<CasinoId>%s</CasinoId>");
		sb.append("<startTime>%s</startTime>");
		sb.append("<EndTime>%s</EndTime>");
		sb.append("</GetAllBetDetailsPerTimeInterval>");//,param.get("startTime"),param.get("endTime")
		String paramXMLStr = String.format(sb.toString(),param.get("userName"),param.get("password"),param.get("casinoId"),param.get("startTime"),param.get("endTime"));
		logger.info("确认拉取HG数据请求参数：" + paramXMLStr);
		String data = post(url, paramXMLStr.trim()).replace("&lt;", "<").replace("&gt;", ">");
		logger.info("HGGame请求地址:" + url + ",返回结果："+data);
		if(null!=data&&-1!=data.indexOf("<BetInfos>")){
			data = data.substring(data.indexOf("<BetInfos>"),data.indexOf("</BetInfos>"))+"</BetInfos>";
			logger.info("处理后的data:" + url + ",返回结果："+data);
			listMap  =   (List<Map<String,Object>>)XmlUtils.parseXmlStr(data).get("BetInfos");
		}
		Map<String, Object> entity = null;
		for (int i = 0; i < listMap.size(); i++) {
			Map<String, Object> map = listMap.get(i);
			entity = new HashMap<String, Object>();
			entity.put("BetId", map.get("BetId")); // 投注注单编号
			entity.put("GameId", map.get("GameId")); // 显示注单属于KENO 或  SSC或 PK10
			entity.put("AccountId", map.get("AccountId")); // 游戏编号与符号‘-
			entity.put("TableId", map.get("TableId")); // 独特的玩家名称
			entity.put("GameType", map.get("GameType")); // 赛事 ID
			entity.put("BetSpot", map.get("BetSpot")); // 赛事 ID
			entity.put("BetAmount", map.get("BetAmount")); // 游戏编号
			entity.put("Payout", map.get("Payout")); // 玩家的下注金额
			entity.put("returnTime",null); // 玩家结算时间
			if(null !=map.get("BetStartDate")){
				entity.put("BetStartDate", format(map.get("BetStartDate")+"")); // 投注时间
			}else{
				entity.put("BetStartDate", format("2001/01/01 01:01:02")); // 投注时间
			}
			if(null !=map.get("BetEndDate")){
				entity.put("BetEndDate", format(map.get("BetEndDate")+"")); // 结算时间
				entity.put("returnTime",new Date()); // 玩家结算时间
			}else{
				entity.put("BetEndDate", format("2001/01/01 01:01:02")); // 结算时间
			}
			resultList.add(entity);
		}
		return resultList;
	}
	
	private static String format(String dateStr) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.ENGLISH);
		TimeZone timeZone = TimeZone.getTimeZone("GMT+0");
		sdf.setTimeZone(timeZone);
		try {
			Date date = sdf.parse(dateStr);
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			timeZone = TimeZone.getTimeZone("GMT+8");
			sdf.setTimeZone(timeZone);
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
		/*StringBuilder sb = new StringBuilder("<?xml version=\"1.0\"?>");
		sb.append("<GetAllBetDetailsPerTimeInterval>");
		sb.append("<Username>web@play8live.com</Username>");
		sb.append("<Password>1qaz@WSX</Password>");
		sb.append("<CasinoId>play8live1segame</CasinoId>");
		sb.append("<startTime>2018/06/08 17:20:00</startTime>");
		sb.append("<EndTime>2018/06/08 17:30:00</EndTime>");
		sb.append("</GetAllBetDetailsPerTimeInterval>");
		String data = post("http://webapi-asia.hointeractive.com/Betapi.asmx/GetAllBetDetailsPerTimeInterval",sb.toString());
		System.out.println(data.replace("&lt;", "<").replace("&gt;", ">"));*/
		System.out.println(format("2018/06/13 13:00:00"));
		;
	}
}
