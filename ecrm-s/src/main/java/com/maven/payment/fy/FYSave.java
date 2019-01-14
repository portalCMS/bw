package com.maven.payment.fy;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URLEncoder;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;

import com.thoughtworks.xstream.core.util.Base64Encoder;

public class FYSave {

	/**
	 * 支付请求做MD5参数签名
	 * 
	 * @param cid
	 * @param uid
	 * @param time
	 * @param amount
	 * @param orderId
	 * @param ip
	 * @param key
	 * @return
	 */
	public static String getRequestSign(String cid, String uid, long time, String amount, String orderId, String ip,
			String key) {
		String signStr = String.format("cid=%s&uid=%s&time=%s&amount=%s&order_id=%s&ip=%s", cid, uid, time, amount,
				orderId, ip);
		System.out.println("风云支付签名原串：" + signStr);
		SecretKeySpec signingKey = new SecretKeySpec(key.getBytes(), "HmacSHA1");
		Mac mac;
		try {
			mac = Mac.getInstance("HmacSHA1");
			mac.init(signingKey);
			byte[] rawHmac = mac.doFinal(signStr.getBytes());
			signStr = URLEncoder.encode(new Base64Encoder().encode(rawHmac));
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("风云支付签名：" + signStr);
		return signStr;
	}

	/**
	 * 结果通知回参做签名
	 * 
	 * @param request
	 * @param apiKey
	 * @return
	 */
	public static String getResponeSign(HttpServletRequest request, String apiKey) {
		String param = "";
		String signMsg = "";
		try {
			StringBuffer sb = new StringBuffer();
			InputStreamReader reader = new InputStreamReader(request.getInputStream());
			BufferedReader br = new BufferedReader(reader);
			while ((param = br.readLine()) != null) {
				sb.append(param);
			}
			param = sb.toString();
			String sign = request.getHeader("Content-Hmac");
			System.out.println("风云支付回调参数：" + param + "\n签名：" + sign);
			SecretKeySpec signingKey = new SecretKeySpec(apiKey.getBytes(), "HmacSHA1");
			Mac mac = Mac.getInstance("HmacSHA1");
			mac.init(signingKey);
			byte[] rawHmac = mac.doFinal(param.getBytes());
			signMsg = new Base64Encoder().encode(rawHmac);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return signMsg;
	}

	/**
	 * 结果通知回参做签名校验
	 * 
	 * @param req
	 * @param MER_KEY
	 * @return
	 */
	public static boolean checkResponseSign(HttpServletRequest req, String MER_KEY) {
		String sign = req.getHeader("Content-Hmac");
		String return_sign = getResponeSign(req, MER_KEY);
		return sign.equals(return_sign);
	}

}
