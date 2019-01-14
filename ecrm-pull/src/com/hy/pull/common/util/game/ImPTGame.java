package com.hy.pull.common.util.game;

import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import com.hy.pull.common.util.DocumentParser;
import com.hy.pull.common.util.SSLClient;

import net.sf.json.JSONObject;

public class ImPTGame {
	private static Logger logger = LogManager.getLogger(ImPTGame.class.getName());

	private static String API_URL = "http://ws-keryxr.imapi.net";
	private static String MERCHANT_NAME = "51baowangprod";// 客户端名称
	private static String MERCHANT_CODE = "ebMhrZpVZ8KaXqUbZYgclRYXVbzju4Jh";// 运营商代码

	/**
	 * httpClient 提交post请求。
	 * 
	 * @param url
	 *            请求地址
	 * @param headerMap
	 *            头部参数
	 * @param parameterMap
	 *            包体参数
	 * @return
	 */
	public static String doPost(String url, Map<String, Object> headerMap, String param) {
		HttpClient httpClient = null;
		HttpPost httpPost = null;
		String result = null;
		try {
			httpClient = new SSLClient();
			httpPost = new HttpPost(url);
			// 设置头部参数。
			if (headerMap != null) {
				Iterator iterator = headerMap.entrySet().iterator();
				while (iterator.hasNext()) {
					Entry entry = (Entry) iterator.next();
					httpPost.setHeader(entry.getKey().toString(), entry.getValue().toString());
				}
			}
			// 设置包体参数。
			StringEntity se = new StringEntity(param);
			se.setContentEncoding("UTF-8");
			se.setContentType("application/json");
			httpPost.setEntity(se);
			HttpResponse response = httpClient.execute(httpPost);
			if (response != null) {
				HttpEntity resEntity = response.getEntity();
				if (resEntity != null) {
					result = EntityUtils.toString(resEntity, "UTF-8");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return result;
	}

	private static String getPTParams(String apiUrl, String stardate, String enddate, int page) {
		String url = "" + apiUrl + "/report/getbetlog/startdate/" + stardate.replace(" ", "%20").replace(":", ".")
				+ "/enddate/" + enddate.replace(" ", "%20").replace(":", ".") + "/page/" + page
				+ "/producttype/0/currency/CNY";
		return url;
	}
	
	
	public static void main(String[]args)
	{
		
		
		String responseJson="{\"Code\":\"0\",\"Message\":\"No Error\",\"Result\":[],\"Pagination\":{\"CurrentPage\":1,\"TotalPage\":1,\"ItemsPerPage\":1000,\"TotalCount\":0}}";
		
		JSONObject jsonObject = JSONObject.fromObject(responseJson);
		
		System.out.println(" jsonObject "+jsonObject);
		
		JSONObject pagination = jsonObject.getJSONObject("Pagination");
		
		System.out.println(" pagination "+pagination);
		
		
		
	}
	

	public static List<Map<String, Object>> getPTData(String apiUrl, String stardate, String enddate) throws Exception {
		if (stardate == null) {
			stardate = getDate();
			enddate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		}
		if (enddate == null) {
			enddate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		}

		Map<String, Object> headerMap = new HashMap<String, Object>();
		// 设置客户端名称、运营商代码。
		headerMap.put("merchantname", MERCHANT_NAME);
		headerMap.put("merchantcode", MERCHANT_CODE);

		Integer totalPage = 0;
		String url = null;
		String responseJson = null;
		List<Map<String, Object>> maps = null;
		try {
			int currentpage = 1;
			do {
				Thread.sleep(1 * 1000);
				do {
					url = getPTParams(API_URL, stardate.replace(" ", "%20").replace(":", "."),enddate.replace(" ", "%20").replace(":", "."), currentpage);
					responseJson = doGet(url, headerMap);
					JSONObject jsonObject = JSONObject.fromObject(responseJson);
					JSONObject pagination = jsonObject.getJSONObject("Pagination");
					logger.info(" responseJson " + responseJson);
					totalPage = pagination.getInt("TotalPage");
					maps = DocumentParser.parsePtBetorderXml(responseJson, MERCHANT_NAME);
				} while (responseJson == null);
			} while (totalPage > currentpage);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return maps;
	}

	/**
	 * 获取10分钟前的时间
	 * 
	 * @return 10分钟前的时间
	 */
	public static String getDate() {
		SimpleDateFormat t = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		Calendar c = Calendar.getInstance();
		c.setTime(new Date());
		c.set(Calendar.MINUTE, c.get(Calendar.MINUTE) - 10);
		return t.format(c.getTime());
	}

	public static String doGet(String url, Map<String, Object> headerMap) {
		HttpClient httpClient = null;
		HttpGet httpGet = null;
		String result = null;
		try {
			httpClient = new SSLClient();
			httpGet = new HttpGet();
			httpGet.setURI(new URI(url));
			// 设置头部参数。
			if (headerMap != null) {
				Iterator iterator = headerMap.entrySet().iterator();
				while (iterator.hasNext()) {
					Entry entry = (Entry) iterator.next();
					httpGet.setHeader(entry.getKey().toString(), entry.getValue().toString());
				}
			}
			HttpResponse response = httpClient.execute(httpGet);
			if (response != null) {
				HttpEntity resEntity = response.getEntity();
				if (resEntity != null) {
					result = EntityUtils.toString(resEntity, "UTF-8");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return result;
	}

}
