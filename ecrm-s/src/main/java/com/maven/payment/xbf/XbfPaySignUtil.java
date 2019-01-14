package com.maven.payment.xbf;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.maven.util.HttpClientUtil;
import com.maven.util.MD5Util;

import net.sf.json.JSONObject;

public class XbfPaySignUtil {

	public static String getRequestUrl(XbfMerchantConfig merchant, XbfOrderConfig order) {
		String app_id = merchant.getApp_id();
		String app_key = merchant.getApp_key();
		String notifyUrl = merchant.getNotifyUrl();
		String returnUrl = merchant.getReturnUrl();
		String amount = order.getAmount();
		String nonce_str = order.getNonce_str();
		String order_sn = order.getOrder_sn();
		String channel = merchant.getChannel();

		try {
			JSONObject jSONObject = new JSONObject();
			jSONObject.put("app_id", app_id);
			jSONObject.put("channel", channel);
			jSONObject.put("amount", amount);
			jSONObject.put("notify_url", notifyUrl);
			jSONObject.put("return_url", returnUrl);
			jSONObject.put("order_sn", order_sn);
			jSONObject.put("nonce_str", nonce_str);

			String str = "amount=" + amount + "&app_id=" + app_id + "&channel=" + channel + "&nonce_str=" + nonce_str
					+ "&notify_url=" + notifyUrl + "&order_sn=" + order_sn + "&return_url=" + returnUrl + "&app_key="
					+ app_key + "";

			System.out.println("MD5原文=" + str.toString());

			String sgin = MD5Util.getMD5Encode(str);

			System.out.println("MD5加密=" + sgin);

			jSONObject.put("sign", sgin);

			String responseJson = HttpClientUtil.doPost(merchant.getPayUrl(), null, jSONObject.toString());

			System.out.println("支付返回信息=" + responseJson);

			if (responseJson == null) {
				return null;
			}
			JSONObject jsonObject = JSONObject.fromObject(responseJson);
			if (jsonObject != null) {
				Integer code = Integer.parseInt(jsonObject.getString("code"));
				if (code == 200) {
					JSONObject jsonObjectChild = JSONObject.fromObject(jsonObject.getString("data"));
					return jsonObjectChild.getString("cashier_url");

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static boolean checkResponseSign(HttpServletRequest request, Map<String, Object> __mer_params) {
		try {
			request.setCharacterEncoding("UTF-8");
			String app_id = (String) request.getParameter("app_id");
			String order_sn = (String) request.getParameter("order_sn");
			String amount = (String) request.getParameter("amount");
			String payment_sn = (String) request.getParameter("payment_sn");
			String nonce_str = (String) request.getParameter("nonce_str");
			String notify_count = (String) request.getParameter("notify_count");
			String sign = (String) request.getParameter("sign");

			String str = "amount=" + amount + "&app_id=" + app_id + "&nonce_str=" + nonce_str + "&notify_count="
					+ notify_count + "&order_sn=" + order_sn + "&payment_sn=" + payment_sn + "&app_key=" + __mer_params.get("merKey") + "";
			
			System.out.println("回调加密前字段 "+str);

			String sginObject = MD5Util.getMD5Encode(str);
			if (StringUtils.equals(sign, sginObject)) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public static XbResponseVo queryOrderStatus(HttpServletRequest request, String app_key) {
		
		try {
			request.setCharacterEncoding("UTF-8");
			String app_id = (String) request.getParameter("app_id");
			String order_sn = (String) request.getParameter("order_sn");
			String nonce_str = (String) request.getParameter("nonce_str");

			String str = "app_id=" + app_id + "&nonce_str=" + nonce_str + "&order_sn=" + order_sn + "&app_key="
					+ app_key + "";

			String sign = MD5Util.getMD5Encode(str);

			JSONObject jSONObject = new JSONObject();
			jSONObject.put("app_id", app_id);
			jSONObject.put("order_sn", order_sn);
			jSONObject.put("nonce_str", nonce_str);
			jSONObject.put("sign", sign);

			String responseJson = HttpClientUtil.doPost("http://www.qqavv.cn/query", null, jSONObject.toString());

			System.out.println("查询支付返回信息=" + responseJson);

			if (responseJson == null) {
				return null;
			}

			JSONObject jsonObject = JSONObject.fromObject(responseJson);
			if (jsonObject != null) {
				Integer code = Integer.parseInt(jsonObject.getString("code"));
				if (code == 200) {
					JSONObject jsonObjectChild = JSONObject.fromObject(jsonObject.getString("data"));
					return new XbResponseVo(jsonObjectChild.getString("order_sn"),jsonObjectChild.getString("status"),jsonObjectChild.getString("channel"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static void main(String[] args) {
		

		
		
		
		JSONObject jSONObject = new JSONObject();
		jSONObject.put("app_id", "CCZEabfCtb2nPzmOkOj9QjDvU4HD3yQG");
		jSONObject.put("order_sn", "2EB16724014A44E497187B7412F7F588");
		jSONObject.put("nonce_str", "jVb9DxX3zcEGVJtU2qFfUdOQ2MHCwlyO");
		jSONObject.put("amount", "1.00");
		jSONObject.put("payment_sn", "2018061021001004130587185534");
		jSONObject.put("notify_count", "1");
		
		

		String app_key = "twKRV4YiVhHfYtdeCVsQ2V09NWfLUplW";


		String str = "amount=" + jSONObject.getString("amount") + "&app_id=" + jSONObject.getString("app_id") + "&nonce_str=" + jSONObject.getString("nonce_str") + "&notify_count="
				+ jSONObject.getString("notify_count") + "&order_sn=" + jSONObject.getString("order_sn") + "&payment_sn=" + jSONObject.getString("payment_sn") + "&app_key=" +app_key + "";

		String sign = MD5Util.getMD5Encode(str);
		
		System.out.println("sign" +sign);

		//jSONObject.put("sign", sign);

		//System.out.println(jSONObject.toString());

		String responseJson = HttpClientUtil.doPost("http://www.qqavv.cn/query", null, jSONObject.toString());

		System.out.println(" responseJson " + responseJson);

	}
}
