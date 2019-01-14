package com.maven.payment.zp;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import com.maven.util.DateUtils;
import com.maven.util.MD5Util;

import net.sf.json.JSONObject;

public class ZpPaySignUtil {
	public static String getRequestUrl(ZpMerchantConfig merchant, ZpOrderConfig order) {

		String key = merchant.getKey();

		String trade_no = order.getTrade_no();

		String money = (Integer.parseInt(order.getMoney()) * 100) + "";

		String platform = merchant.getPlatform();

		String mobile = order.getMobile();

		String timestamp = DateUtils.getTodayByNowDateTime();

		String notify = merchant.getNotifyUrl();

		String redirect = merchant.getRedirect();

		String secret = merchant.getSecret();

		try {
			List<NameValuePair> urlParameters = new ArrayList<>();
			urlParameters.add(new BasicNameValuePair("key", key));
			urlParameters.add(new BasicNameValuePair("method", "easypay.trade.pay"));
			urlParameters.add(new BasicNameValuePair("trade_no", trade_no));
			urlParameters.add(new BasicNameValuePair("title", "apple6"));
			urlParameters.add(new BasicNameValuePair("money", money));

			urlParameters.add(new BasicNameValuePair("platform", platform));
			urlParameters.add(new BasicNameValuePair("mobile", mobile));
			urlParameters.add(new BasicNameValuePair("timestamp", timestamp));
			urlParameters.add(new BasicNameValuePair("notify", notify));

			urlParameters.add(new BasicNameValuePair("redirect", redirect));

			String str = "key=" + key + "&method=easypay.trade.pay&mobile=" + mobile + "&money=" + money + "&notify="
					+ notify + "&platform=" + platform + "&redirect=" + redirect + "&timestamp=" + timestamp
					+ "&title=apple6&trade_no=" + trade_no + "&secret=" + secret + "";

			System.out.println("加密前的明文" + str);

			String sgin = MD5Util.getMD5Encode(str);

			System.out.println("加密的秘钥" + sgin);

			urlParameters.add(new BasicNameValuePair("sign", sgin));

			CloseableHttpClient httpclient = HttpClients.createDefault();
			HttpPost post = new HttpPost(merchant.getPayUrl());

			post.setEntity(new UrlEncodedFormEntity(urlParameters, HTTP.UTF_8));
			CloseableHttpResponse response = httpclient.execute(post);

			String responsejson = EntityUtils.toString(response.getEntity(), "UTF-8");
			
			System.out.println("responsejson" + responsejson);

			if (StringUtils.isNotEmpty(responsejson)) {
				JSONObject jsonObject = JSONObject.fromObject(responsejson);
				if (jsonObject != null) {
					Integer code = Integer.parseInt(jsonObject.getString("code"));
					if (code == 2000) {
						JSONObject jsonObjectChild = JSONObject.fromObject(jsonObject.getString("data"));
						return jsonObjectChild.getString("page_url");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static ZpResponseVo queryOrderStatus(HttpServletRequest request, Map<String, Object> __mer_params) {
		String key = (String) request.getParameter("key");
		String trade_no = (String) request.getParameter("trade_no");
		String timestamp = DateUtils.getTodayByNowDateTime();
		String secret = __mer_params.get("merKey").toString();

		String str = "key=" + key + "&method=easypay.trade.query&timestamp=" + timestamp + "&trade_no=" + trade_no
				+ "&secret=" + secret + "";

		System.out.println("回调加密前字段 " + str);
		String sign = MD5Util.getMD5Encode(str);
		try {

			List<NameValuePair> urlParameters = new ArrayList<>();
			urlParameters.add(new BasicNameValuePair("key", key));
			urlParameters.add(new BasicNameValuePair("method", "easypay.trade.query"));
			urlParameters.add(new BasicNameValuePair("trade_no", trade_no));
			urlParameters.add(new BasicNameValuePair("timestamp", timestamp));
			urlParameters.add(new BasicNameValuePair("sign", sign));

			CloseableHttpClient httpclient = HttpClients.createDefault();
			HttpPost post = new HttpPost("https://g99.liangdiming.com/gateway.php");

			post.setEntity(new UrlEncodedFormEntity(urlParameters, HTTP.UTF_8));
			CloseableHttpResponse response = httpclient.execute(post);

			String responsejson = EntityUtils.toString(response.getEntity(), "UTF-8");

			if (StringUtils.isNotEmpty(responsejson)) {
				JSONObject jsonObject = JSONObject.fromObject(responsejson);
				if (jsonObject != null) {
					String platform = null;
					Integer code = Integer.parseInt(jsonObject.getString("code"));
					String trade_status = jsonObject.getString("trade_status");
					String trade_number = jsonObject.getString("trade_no");
					if (StringUtils.equals(jsonObject.getString("platform"), "0")) {
						platform = "alipay";
					}
					if (code == 2000 && StringUtils.equals(trade_status, "SUCCESS")) {
						return new ZpResponseVo(trade_number, trade_status, platform);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static boolean checkResponseSign(HttpServletRequest request, String app_key) {

		try {
			String key = (String) request.getParameter("key");
			String sn = (String) request.getParameter("sn");
			String trade_no = (String) request.getParameter("trade_no");
			String platform = (String) request.getParameter("platform");
			String title = (String) request.getParameter("title");
			String money = (String) request.getParameter("money");
			String sysid = (String) request.getParameter("sysid");
			String finish = (String) request.getParameter("finish");
			String time = (String) request.getParameter("time");
			String sign = (String) request.getParameter("sign");

			String str = "finish=" + finish + "&key=" + key + "&money=" + money + "&platform=" + platform + "&sn=" + sn
					+ "&sysid=" + sysid + "&time=" + time + "&title=" + title + "&trade_no=" + trade_no + "&secret="
					+ app_key + "";

			System.out.println("回调加密前字段 " + str);
			String signObject = MD5Util.getMD5Encode(str);

			System.out.println("sign " + sign +"== signObject "+signObject);
			
			if (StringUtils.equals(sign, signObject)) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;

	}

}
