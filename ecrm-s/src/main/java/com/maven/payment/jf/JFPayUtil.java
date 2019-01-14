package com.maven.payment.jf;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.hy.pull.common.util.game.av.JsonToMap;
import com.maven.entity.ThirdpartyPaymentType.Enum_ThirdpartyPaymentType;
import com.maven.util.Encrypt;

public class JFPayUtil {

	private static String encodingCharset = "UTF-8";

	/**
	 * @param aValue
	 * @param aKey
	 * @return
	 */
	public static String hmacSign(String aValue, String aKey) {
		byte k_ipad[] = new byte[64];
		byte k_opad[] = new byte[64];
		byte keyb[];
		byte value[];
		try {
			keyb = aKey.getBytes(encodingCharset);
			value = aValue.getBytes(encodingCharset);
		} catch (UnsupportedEncodingException e) {
			keyb = aKey.getBytes();
			value = aValue.getBytes();
		}

		Arrays.fill(k_ipad, keyb.length, 64, (byte) 54);
		Arrays.fill(k_opad, keyb.length, 64, (byte) 92);
		for (int i = 0; i < keyb.length; i++) {
			k_ipad[i] = (byte) (keyb[i] ^ 0x36);
			k_opad[i] = (byte) (keyb[i] ^ 0x5c);
		}

		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {

			return null;
		}
		md.update(k_ipad);
		md.update(value);
		byte dg[] = md.digest();
		md.reset();
		md.update(k_opad);
		md.update(dg, 0, 16);
		dg = md.digest();
		return toHex(dg);
	}

	public static String toHex(byte input[]) {
		if (input == null)
			return null;
		StringBuffer output = new StringBuffer(input.length * 2);
		for (int i = 0; i < input.length; i++) {
			int current = input[i] & 0xff;
			if (current < 16)
				output.append("0");
			output.append(Integer.toString(current, 16));
		}

		return output.toString();
	}

	/**
	 * 
	 * @param args
	 * @param key
	 * @return
	 */
	public static String getHmac(String[] args, String key) {
		if (args == null || args.length == 0) {
			return (null);
		}
		StringBuffer str = new StringBuffer();
		for (int i = 0; i < args.length; i++) {
			str.append(args[i]);
		}
		return (hmacSign(str.toString(), key));
	}

	/**
	 * @param aValue
	 * @return
	 */
	public static String digest(String aValue) {
		aValue = aValue.trim();
		byte value[];
		try {
			value = aValue.getBytes(encodingCharset);
		} catch (UnsupportedEncodingException e) {
			value = aValue.getBytes();
		}
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("SHA");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
		return toHex(md.digest(value));

	}

	public static String sendPost(String url, String param) {
		PrintWriter out = null;
		BufferedReader in = null;
		StringBuilder result = new StringBuilder();
		try {
			URL realUrl = new URL(url);
			URLConnection conn = realUrl.openConnection();
			conn.setConnectTimeout(60000);// 连接超时时间
			conn.setReadTimeout(60000);
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("User-Agent", "WEB_LIB_GI_");
			// conn.setRequestProperty("Content-Type", "application/json");

			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);

			// 获取URLConnection对象对应的输出流
			out = new PrintWriter(conn.getOutputStream());
			// 发送请求参数
			out.print(param);
			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String line;
			while ((line = in.readLine()) != null) {
				result.append(line);
			}
			if (out != null) {
				out.close();
			}
			if (in != null) {
				in.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return result.toString();
	}

	public static boolean checkSign(Map<String, Object> params, String shalKey) {
		String sign = params.get("sign").toString();
		StringBuilder paramStr = new StringBuilder();
		paramStr.append("partner=" + params.get("partner"));
		paramStr.append("&ordernumber=" + params.get("ordernumber"));
		paramStr.append("&orderstatus=" + params.get("orderstatus"));
		paramStr.append("&paymoney=" + params.get("paymoney"));
		String signNow = Encrypt.MD5(paramStr+shalKey);
		System.out.println("加密前参数:"+paramStr+shalKey);
		System.out.println("=========signNow:"+signNow+"/t/tsign:"+sign);
		if (sign.equals(signNow)) {
			return true;
		}
		return false;
	}
	
	public static String getJFRequestParams(JFMerchantConfig merchant, JFOrderConfig order){
		StringBuilder paramStr = new StringBuilder();
			paramStr.append("partner=" + merchant.getSpid());
			paramStr.append("&banktype=" + order.getBanktype());
			paramStr.append("&paymoney=" + order.getPaymoney());
			paramStr.append("&ordernumber=" + order.getOrdernumber());
			paramStr.append("&callbackurl=" + order.getCallbackurl());
		String sign = Encrypt.MD5(paramStr+merchant.getMd5Key());
			paramStr.append("&sign=" + sign);
		return paramStr.toString();
	}
	
	public static String toBFBAmount(String amount){
		Double cash = Double.valueOf(amount)*100;
		return String.valueOf(cash.intValue());
	}
	public static String getBFBBankIdByBankCode(String bankCode){
		if(bankCode.equals("")){
			return "1000";//银联通道
		}else if(bankCode.equals("B015")){
			return "1004";//建设银行
		}else if(bankCode.equals("B005")){
			return "1002";//农业银行
		}else if(bankCode.equals("B006")){
			return "1001";//工商银行 
		}else if(bankCode.equals("B004")){
			return "1003";//中国银行
		}else if(bankCode.equals("B012")){
			return "1004";//浦发银行 
		}else if(bankCode.equals("B008")){
			return "1008";//光大银行 
		}else if(bankCode.equals("B010")){
			return "1011";//平安银行
		}else if(bankCode.equals("B007")){
			return "1013";//兴业银行
		}else if(bankCode.equals("B021")){
			return "1006";//邮政储蓄银行
		}else if(bankCode.equals("B013")){
			return "1007";//中信银行  
		}else if(bankCode.equals("B011")){
			return "1009";//华夏银行
		}else if(bankCode.equals("B016")){
			return "1012";//招商银行
		}else if(bankCode.equals("B019")){
			return "1017";//广发银行
		}else if(bankCode.equals("B002")){
			return "1016";//北京银行  
		}else if(bankCode.equals("B001")){
			return "1025";//上海银行
		}else if(bankCode.equals("B018")){
			return "1010";//民生银行
		}else if(bankCode.equals("B003")){
			return "1005";//交通银行
		}else if(bankCode.equals("B022")){
			return "1103";//北京农村商业银行 
		}
		return "";
	}
	
	public static void main(String[] args) {
		
		String data = "{\"MERCHANT_ID\":\"SP20180315145202\",\"PAY_TIME\":\"20180315205403\",\"REMARK\":\"1521118249358\",\"STATUS\":\"1\",\"SYS_CODE\":\"PA20180315205050YIMEI3160\",\"TRAN_AMT\":\"100\",\"TRAN_CODE\":\"B5AB1AD3A18E4581882DC78C7B5AA9EE\",\"TYPE\":\"3\"}";
		Map<String, Object> paramsMap = JsonToMap.parseJSON2Map(data);
		String jiamiStr = JFPayMent.buildSignStr(paramsMap)+"4944ab75bb2b2e6c";
		System.out.println(Encrypt.MD5(jiamiStr));
		
	}
}