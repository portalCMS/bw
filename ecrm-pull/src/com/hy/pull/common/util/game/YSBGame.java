package com.hy.pull.common.util.game;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hy.pull.common.util.DateUtil;
import com.hy.pull.common.util.game.sa.MD5Encoder;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class YSBGame {
	private static Logger logger = LoggerFactory.getLogger(YSBGame.class);

	private static String msgId = "BD";
	private static String vendorId = "51BW";
	private static String url = "http://webapi.a1sport88.com/api/client";
	private static String secretKey = "Sf83Mg9V5GfG72dH";

	/**
	 * 获取ZJ游戏数据
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
		logger.info("请求原参数:" +param.toString());
		JSONObject json = new JSONObject();
		json.put("MsgId", param.get("msgId"));
		json.put("DateFrom", DateUtil.format(DateUtil.getStr2Date(param.get("dateFrom") + "", "yyyy-MM-dd HH:mm:ss"),
				"GMT+0", "yy-MM-dd'T'HH:mm"));
		json.put("DateTo", DateUtil.format(DateUtil.getStr2Date(param.get("dateTo") + "", "yyyy-MM-dd HH:mm:ss"),
				"GMT+0", "yy-MM-dd'T'HH:mm"));
		json.put("VendorId", param.get("vendorId"));
		json.put("HashPassword", MD5Encoder.encode(param.get("msgId") + "" + json.get("DateFrom") + json.get("DateTo")
				+ param.get("vendorId") + param.get("secretKey")).toUpperCase());
		JSONObject params = new JSONObject();
		params.put("Params", json);
		String data = post(param.get("apiUrl") + "", params.toString());
		logger.info("请求地址:" + param.get("apiUrl") + ",请求参数：" + params.toString()+" 返回结果："+data);
		List<Map<String, Object>> list = new ArrayList<>();
		json = JSONObject.fromObject(data);
		if (json.getBoolean("Status")) {
			Map<String, Object> entity = null;
			JSONArray jsonArr = JSONArray.fromObject(json.get("Data"));
			for (int i = 0; i < jsonArr.size(); i++) {
				json = jsonArr.getJSONObject(i);
				entity = new HashMap<String, Object>();
//				entity.put("VendorId", json.get("VendorId")); // 运营商 ID
				entity.put("betId", json.get("BetId")); // 运营商 ID
				entity.put("eventId", json.get("EventId")); // 赛事 ID
				// entity.put("EventSession",info.get("EventSession")); //参考
				// appendix 8.2.5 关于赛事会期
				// entity.put("ParentEventId",info.get("ParentEventId")); //赛事母公
				// ID
				// entity.put("SelectionId",info.get("SelectionId")); //选择 ID
				// entity.put("BetTypeId",info.get("BetTypeId")); //参考 appendix
				// 8.2.1 关于投注类型
				// entity.put("CombinationId",info.get("CombinationId")); //连串投注
				// ID
				// entity.put("TeamType",info.get("TeamType").toString()); //参考
				// appendix 8.2.3 关于投注状态
//				if ("0".equals(json.getString("TeamType"))) {
//					entity.put("TeamType", "主队");
//				} else if ("1".equals(json.getString("TeamType"))){
//					entity.put("TeamType", "客队");
//				} else {
//					entity.put("TeamType", "和局");
//				}

				// entity.put("Status",info.get("Status").toString()); //参考
				// appendix 8.2.3 关于投注状态
				if ("0".equals(json.getString("Status"))) {
					entity.put("status", "投注成功");
				} else if ("1".equals(json.getString("Status"))) {
					entity.put("status", "赢");
				} else if ("2".equals(json.getString("Status"))) {
					entity.put("status", "输");
				} else if ("3".equals(json.getString("Status"))) {
					entity.put("status", "取消");
					continue;
				} else if ("4".equals(json.getString("Status"))) {
					entity.put("status", "复原");
				} else if ("5".equals(json.getString("Status"))) {
					entity.put("status", "赢半");
				} else if ("6".equals(json.getString("Status"))) {
					entity.put("status", "输半");
				}
				// entity.put("BetMode",info.get("BetMode").toString()); //参考
				// appendix 8.2.8 关于投注模式
				entity.put("betAmount", json.get("BetAmount")); // 玩家的下注金额
				entity.put("bonusAmount", json.get("BonusAmount")); // 玩家的奖金数额
				// entity.put("Void",info.get("Void")); //投注金额无效
				entity.put("profit", 0-json.getDouble("Profit")); // 运营商获得的利润
				// entity.put("Correction",info.get("Correction")); //纠正投注金额
				// entity.put("PayoutPercentage",sdf.format(info.get("PayoutPercentage")));
				// //玩家的支付比例
				// entity.put("DecimalPrice",info.get("DecimalPrice")); //欧洲盘
				// entity.put("PostedPrice",info.get("PostedPrice")); //发布价钱
				// entity.put("SelectionPlace",info.get("SelectionPlace")); //参考
				// appendix 8.2.4 关于选择大小盘
				if ("0".equals(json.getString("SelectionPlace"))) {
					entity.put("selectionPlace", "小");
				} else {
					entity.put("selectionPlace", "大");
				}
				// entity.put("SelectionValue",info.get("SelectionValue"));
				// //投注的选择价值
				if (null != json.get("TrxDate") && !StringUtils.isEmpty(json.getString("TrxDate"))) {
					entity.put("betTime", format(json.getString("TrxDate"))); // 投注交易日期
				}
     			entity.put("Score", json.get("Score")); // 下注时的赛事比分
				entity.put("sportType", json.get("SportType")); // 赛事的体育类型
				// entity.put("Inning", info.get("Inning"));//参考 appendix 8.2.6
				// 关于赛局
				// entity.put("OddFormat", info.get("OddFormat")); //参考 appendix
				// 8.2.7 关于奇数格式
				if ("0".equals(json.getString("OddFormat"))) {
					entity.put("oddFormat", "欧洲盘");
				} else if ("3".equals(json.getString("OddFormat"))) {
					entity.put("oddFormat", "马来盘");
				} else if ("4".equals(json.getString("OddFormat"))) {
					entity.put("oddFormat", "印尼盘");
				} else if ("5".equals(json.getString("OddFormat"))) {
					entity.put("oddFormat", "香港盘");
				}
				if (null != json.get("ProcessDate") && !StringUtils.isEmpty(json.getString("ProcessDate"))) {
					entity.put("processDate", format(json.getString("ProcessDate"))); // 赛事的处理日期
				}
				entity.put("userName", json.get("LoginID")); // 用户名称
				logger.info("转换后："+entity.toString());
				list.add(valiDate(entity));
			}
		}
		return list;
	}
	

	private static String format(String dateStr) {
		if(null==dateStr||dateStr.trim()==""){
			return "2001-01-01 01:01:02";
		}
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss", Locale.US);
		TimeZone timeZone = TimeZone.getTimeZone("GMT+0");
		sdf.setTimeZone(timeZone);
		try {
			Date date = sdf.parse(dateStr);
			sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			timeZone = TimeZone.getTimeZone("GMT+12");
			sdf.setTimeZone(timeZone);
			return sdf.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private static Map<String, Object> valiDate(Map<String, Object> entity1){
		Map<String, Object> entity =  new LinkedHashMap<String, Object>();
		if(null==entity1.get("VendorId")||entity1.get("VendorId").toString().trim()==""){
			entity.put("VendorId","264"); // 运营商 ID
		}else{
			entity.put("VendorId",entity1.get("VendorId").toString());
		}
		
		if(null==entity1.get("betId")||entity1.get("betId").toString().trim()==""){
			entity.put("BetId",new Date().getTime()); // 运营商 ID
		}else{
			entity.put("BetId",entity1.get("betId"));
		}
		if(null==entity1.get("eventId")||entity1.get("eventId").toString().trim()==""){
			entity.put("EventId",new Date().getTime()); // 运营商 ID
		}else{
			entity.put("EventId",entity1.get("eventId").toString());
		}
/*		if(null==entity1.get("VendorId")||entity1.get("VendorId").toString().trim()==""){
			entity.put("VendorId","264"); // 运营商 ID
		}else{
			entity.put("VendorId",entity1.get("VendorId"));
		}*/
		if(null==entity1.get("TeamType")||entity1.get("TeamType").toString().trim()==""){
			entity.put("TeamType","无"); // 运营商 ID
		}else{
			entity.put("TeamType",entity1.get("TeamType").toString());
		}
		
		if(null==entity1.get("status")||entity1.get("status").toString().trim()==""){
			entity.put("Status","无"); // 运营商 ID
		}else{
			entity.put("Status",entity1.get("status").toString());
		}
		if(null==entity1.get("betAmount")||entity1.get("betAmount").toString().trim()==""){
			entity.put("BetAmount","0.0"); // 运营商 ID
		}else{
			entity.put("BetAmount",entity1.get("betAmount").toString());
		}
		if(null==entity1.get("bonusAmount")||entity1.get("bonusAmount").toString().trim()==""){
			entity.put("BonusAmount","0.0"); // 运营商 ID
		}else{
			entity.put("BonusAmount",entity1.get("bonusAmount").toString());
		}
		if(null==entity1.get("profit")||entity1.get("profit").toString().trim()==""){
			entity.put("Profit","0.0"); // 运营商 ID
		}else{
			entity.put("Profit",entity1.get("profit").toString());
		}
		if(null==entity1.get("selectionPlace")||entity1.get("selectionPlace").toString().trim()==""){
			entity.put("SelectionPlace","无"); // 运营商 ID
		}else{
			entity.put("SelectionPlace",entity1.get("selectionPlace").toString());
		}
		if(null==entity1.get("betTime")||entity1.get("betTime").toString().trim()==""){
			entity.put("betTime","2001-01-01 01:01:01"); // 运营商 ID
		}else{
			entity.put("betTime",entity1.get("betTime").toString());
		}
		if(null==entity1.get("Score")||entity1.get("Score").toString().trim()==""){
			entity.put("Score","0"); // 运营商 ID
		}else{
			entity.put("Score",entity1.get("Score").toString());
		}
		if(null==entity1.get("sportType")||entity1.get("sportType").toString().trim()==""){
			entity.put("SportType","0"); // 运营商 ID
		}else{
			entity.put("SportType",entity1.get("sportType").toString());
		}
		
		if(null==entity1.get("oddFormat")||entity1.get("oddFormat").toString().trim()==""){
			entity.put("OddFormat","无"); // 运营商 ID
		}else{
			entity.put("OddFormat",entity1.get("oddFormat").toString());
		}
		
		if(null==entity1.get("processDate")||entity1.get("processDate").toString().trim()==""){
			entity.put("ProcessDate","2001-01-01 01:01:01"); // 运营商 ID
		}else{
			entity.put("ProcessDate",entity1.get("processDate").toString());
		}
		
		if(null==entity1.get("userName")||entity1.get("userName").toString().trim()==""){
			entity.put("userName","l"); // 运营商 ID
		}else{
			entity.put("userName",entity1.get("userName").toString());
		}
		return entity;
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
}
