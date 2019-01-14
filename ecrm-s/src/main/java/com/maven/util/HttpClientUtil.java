package com.maven.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

import com.google.gson.JsonObject;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 利用HttpClient进行post请求的工具类(为了避免需要证书,忽略校验过程)。
 * 
 * @author sum
 *
 */
@SuppressWarnings("all")
public class HttpClientUtil {
	/**
	 * httpClient 提交post请求。
	 * 
	 * @param url
	 *            请求地址
	 * @param headerMap
	 *            头部参数
	 * @return
	 */
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

	/**
	 * httpClient 提交put请求。
	 * 
	 * @param url
	 *            请求地址
	 * @param headerMap
	 *            头部参数
	 * @param parameterMap
	 *            包体参数
	 * @return
	 */
	public static String doPut(String url, Map<String, Object> headerMap, String param) {
		HttpClient httpClient = null;
		HttpPut httpPut = null;
		String result = null;
		try {
			httpClient = new SSLClient();
			httpPut = new HttpPut();
			httpPut.setURI(new URI(url));
			// 设置头部参数。
			if (headerMap != null) {
				Iterator iterator = headerMap.entrySet().iterator();
				while (iterator.hasNext()) {
					Entry entry = (Entry) iterator.next();
					httpPut.setHeader(entry.getKey().toString(), entry.getValue().toString());
				}
			}
			StringEntity se = new StringEntity(param);
			se.setContentEncoding("UTF-8");
			se.setContentType("application/json");
			httpPut.setEntity(se);
			HttpResponse response = httpClient.execute(httpPut);
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
	public static String doPost2(String url, Map<String, Object> headerMap, String param) {
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
			se.setContentType("application/x-www-form-urlencoded");
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

	public static void readContentFromPost() throws IOException {

		String key = "ep2018061109683808";

		String method = "easypay.trade.pay";

		String trade_no = "2018060835737";

		String title = "apple6";

		String money = "1000";

		String platform = "alipay";

		String mobile = "Y";

		String timestamp = "20180612213600";

		String notify = "http://180.178.61.130/notify/easypay/callback";

		String redirect = "http://180.178.61.130/notify/easypay/callback";

		String secret = "373d5f5a0ccf84466bb2b36f64e316dc1653de1d";

		Map<String, Object> map1 = new HashMap<String, Object>();

		JSONObject jSONObject = new JSONObject();
		map1.put("key", key);
		map1.put("method", method);
		map1.put("trade_no", trade_no);
		map1.put("title", title);
		map1.put("money", money);
		map1.put("platform", platform);
		map1.put("mobile", mobile);
		map1.put("timestamp", timestamp);
		map1.put("notify", notify);
		map1.put("redirect", redirect);

		String srr = "key=" + key + "&method=" + method + "&mobile=" + mobile + "&money=" + money + "&notify=" + notify
				+ "&platform=" + platform + "&redirect=" + redirect + "&timestamp=" + timestamp + "&title=" + title
				+ "&trade_no=" + trade_no + "&sign=46826391cf9294524e4ca299b2dfd65b";

		System.out.println("加密前报文 " + srr);

		String sgin = MD5Util.getMD5Encode(srr);

		System.out.println("sgin " + sgin);

		jSONObject.put("sign", sgin);

		System.out.println("jSONObject " + map1.toString());

		// Post请求的url，与get不同的是不需要带参数
		URL postUrl = new URL("https://g99.liangdiming.com/gateway.php");
		// 打开连接
		HttpURLConnection connection = (HttpURLConnection) postUrl.openConnection();

		// 设置是否向connection输出，因为这个是post请求，参数要放在
		// http正文内，因此需要设为true
		connection.setDoOutput(true);
		// Read from the connection. Default is true.
		connection.setDoInput(true);
		// 默认是 GET方式
		connection.setRequestMethod("POST");

		// Post 请求不能使用缓存
		connection.setUseCaches(false);

		connection.setInstanceFollowRedirects(true);

		// 配置本次连接的Content-type，配置为application/x-www-form-urlencoded的
		// 意思是正文是urlencoded编码过的form参数，下面我们可以看到我们对正文内容使用URLEncoder.encode
		// 进行编码
		connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		// 连接，从postUrl.openConnection()至此的配置必须要在connect之前完成，
		// 要注意的是connection.getOutputStream会隐含的进行connect。
		connection.connect();
		DataOutputStream out = new DataOutputStream(connection.getOutputStream());
		// The URL-encoded contend
		// 正文，正文内容其实跟get的URL中 '? '后的参数字符串一致

		String content = URLEncoder.encode(srr, "UTF-8");
		// \ content +="&pswd="+URLEncoder.encode("两个个大肥人", "UTF-8");;
		// DataOutputStream.writeBytes将字符串中的16位的unicode字符以8位的字符形式写到流里面
		out.writeBytes(content);
		out.flush();
		out.close();

		BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		String line;

		while ((line = reader.readLine()) != null) {
			System.out.println(line);
		}

		reader.close();
		connection.disconnect();
	}

	public static void main(String[] args) throws IOException {
		

		 String key="ep2018061109683808";
		
		 String method="easypay.trade.pay";
		
		 String trade_no="2018060835739";
		
		 String title="apple6";
		
		 String money="1000";
		
		 String platform="alipay";
		
		 String mobile="Y";
		
		 String timestamp="20180612213600";
		
		 String notify="http://180.178.61.130/notify/easypay/callback";
		
		 String redirect="http://180.178.61.130/notify/easypay/callback";
		
		 String secret="373d5f5a0ccf84466bb2b36f64e316dc1653de1d";

		// String
		// srr="key="+key+"&method="+method+"&mobile="+mobile+"&money="+money+"&notify="+notify+"&platform="+platform+"&redirect="+redirect+"&timestamp="+timestamp+"&title="+title+"&trade_no="+trade_no+"&secret="+secret+"";
		
		 //System.out.println("加密前报文 "+srr);
		
		 //String sgin=MD5Util.getMD5Encode(srr);
		
		// System.out.println("sgin "+sgin);
		 
//		List<NameValuePair> urlParameters = new ArrayList<>();
//		urlParameters.add(new BasicNameValuePair("key", key));
//		urlParameters.add(new BasicNameValuePair("method", method));
//		urlParameters.add(new BasicNameValuePair("trade_no", trade_no));
//		urlParameters.add(new BasicNameValuePair("title", title));
//		urlParameters.add(new BasicNameValuePair("money", money));
//		
//		
//		urlParameters.add(new BasicNameValuePair("platform", platform));
//		urlParameters.add(new BasicNameValuePair("mobile", mobile));
//		urlParameters.add(new BasicNameValuePair("timestamp", timestamp));
//		urlParameters.add(new BasicNameValuePair("notify", notify));
//		
//		urlParameters.add(new BasicNameValuePair("redirect", redirect));
//		urlParameters.add(new BasicNameValuePair("sign", sgin));
		 
		 
		 
			List<NameValuePair> urlParameters = new ArrayList<>();
			urlParameters.add(new BasicNameValuePair("key", key));
			urlParameters.add(new BasicNameValuePair("method", "easypay.trade.query"));
			urlParameters.add(new BasicNameValuePair("trade_no", trade_no));
			urlParameters.add(new BasicNameValuePair("timestamp", timestamp));
			
			
			String str = "key=" + key + "&method=easypay.trade.query&timestamp=" + timestamp + "&trade_no=" + trade_no
					+ "&secret=" + secret + "";
			
			 System.out.println("加密前报文 "+str);
			
			 String sgin=MD5Util.getMD5Encode(str);
			
			
			urlParameters.add(new BasicNameValuePair("sign", sgin));
		
		
		CloseableHttpClient httpclient = HttpClients.createDefault();
		CloseableHttpResponse response = null;
		HttpPost post = new HttpPost("https://g99.liangdiming.com/gateway.php");
		
		
		try
		{
			  post.setEntity(new UrlEncodedFormEntity(urlParameters, HTTP.UTF_8));
			  response = httpclient.execute(post);
			  
			  String content = EntityUtils.toString(response.getEntity(), "UTF-8");
			  
			  System.out.println(content);


		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		
		
		
		

		// JsonObject jonsObject=new JsonObject();
		// jonsObject.addProperty("11111", "2222222222");

		// // 异步回调地址
		// String notify_url = "http://example.com/notify";
		// // 收银台支付完成跳转链接
		// String return_url = "https://www.baidu.com";
		//
		// String app_id="sokb1waAo1FeCj8ghhVvYYybwfGLbELN";
		//
		// String app_key="R6R0NRQYjm6GokWEfXbSLmFYhnT8OCn7";
		//
		// String channel="alipay";
		//
		// String amount="1";
		//
		// String order_sn="2Ckx64mEb5SORWZfBiQ1zuVSnOvnWSdV";
		//
		// String nonce_str="blt0DXrdzkBnGCjMuikLfrXMI2wHtF24";

		// String nonce_str = RandomStringUtils.randomAlphanumeric(32);
		//
		//
		// JSONObject jSONObject = new JSONObject();
		// jSONObject.put("app_id", app_id);
		// jSONObject.put("channel", channel);
		// jSONObject.put("amount", amount);
		// jSONObject.put("notify_url", notify_url);
		// jSONObject.put("return_url", return_url);
		// jSONObject.put("order_sn", order_sn);
		// jSONObject.put("nonce_str", nonce_str);

		// String
		// str="amount="+amount+"&app_id="+app_id+"&channel="+channel+"&nonce_str="+nonce_str+"&notify_url="+notify_url+"&order_sn="+order_sn+"&return_url="+return_url+"&app_key="+app_key+"";

		// String sgin=MD5Util.getMD5Encode(str);

		// System.out.println("sign" +sgin);

		// String
		// str="app_id=&amount=&channel=&notify_url=&nonce_str=&order_sn=&return_url=";

		// jSONObject.put("sign", sgin);

		// System.out.println("params" +jSONObject.toString());

		// System.out.println(doPost("http://qrpay.naodaida.com/pay/json",null,
		// jSONObject.toString()));

		// String str1="{'code':200}";

		// JSONObject jsonObject=JSONObject.fromObject(str1);

		// System.out.println(jsonObject.get("data"));

		// System.out.println(jSONArray.getJSONObject(0).getString("amount"));

		// System.out.println(jsonObject.getString("code"));

		// System.out.println(jsonObject.getString("data"));

	}
}
