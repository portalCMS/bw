package com.maven.payment.sulong;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.DocumentException;

import com.itrus.util.sign.RSAWithSoftware;
import com.maven.util.Encrypt;
import com.maven.util.XmlUtils;

public class SulongPayUtil {

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
	
	public static String senPost(String url, Map<String,String> suLongParamsMap) {
		return  new HttpClientUtil().doPost(url, suLongParamsMap, "utf-8");
	}
	

	public static Map<String,String> getSuLongRespsonMap(String suLongResponseXmlStr) {
		 List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
		try {
			listMap = (List<Map<String,String>>)XmlUtils.parseXmlStr(suLongResponseXmlStr).get("dinpay");
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return listMap.get(0);
	}

	public static boolean checkSign(HttpServletRequest request) throws Exception {
		String interface_version = (String) request.getParameter("interface_version");
		String merchant_code = (String) request.getParameter("merchant_code");
		String notify_type = (String) request.getParameter("notify_type");
		String notify_id = (String) request.getParameter("notify_id");
		String sign_type = (String) request.getParameter("sign_type");
		String dinpaySign= (String) request.getParameter("sign");
		String order_no = (String) request.getParameter("order_no");
		String order_time = (String) request.getParameter("order_time");
		String order_amount = (String) request.getParameter("order_amount");
		String extra_return_param = (String) request.getParameter("extra_return_param");
		String trade_no = (String) request.getParameter("trade_no");
		String trade_time= (String) request.getParameter("trade_time");
		String trade_status = (String) request.getParameter("trade_status");
		String bank_seq_no= (String) request.getParameter("bank_seq_no");
		
		System.out.println(	"interface_version = " + interface_version + "\n" + 
							"merchant_code = " + merchant_code + "\n" +
							"notify_type = " + notify_type + "\n" +
							"notify_id = " + notify_id + "\n" +
							"sign_type = " + sign_type + "\n" +
							"dinpaySign = " + dinpaySign + "\n" +
							"order_no = " + order_no + "\n" +
							"order_time = " + order_time + "\n" +
							"order_amount = " + order_amount + "\n" +
							"extra_return_param = " + extra_return_param + "\n" +
							"trade_no = " + trade_no + "\n" +
							"trade_time = " + trade_time + "\n" +
							"trade_status = " + trade_status + "\n" +
							"bank_seq_no = " + bank_seq_no + "\n" 	); 		

		/** 数据签名
		签名规则定义如下：
		（1）参数列表中，除去sign_type、sign两个参数外，其它所有非空的参数都要参与签名，值为空的参数不用参与签名；
		（2）签名参数排序按照参数名a到z的顺序排序，若遇到相同首字母，则看第二个字母，以此类推，组成规则如下：
		参数名1=参数值1&参数名2=参数值2&……&参数名n=参数值n		*/
	 
	 	StringBuilder signStr = new StringBuilder();
	 	if(null != bank_seq_no && !bank_seq_no.equals("")) {
	 		signStr.append("bank_seq_no=").append(bank_seq_no).append("&");
	 	}
	 	if(null != extra_return_param && !extra_return_param.equals("")) {
	 		signStr.append("extra_return_param=").append(extra_return_param).append("&");
	 	}
	 	signStr.append("interface_version=").append(interface_version).append("&");
	 	signStr.append("merchant_code=").append(merchant_code).append("&"); 	
	 	signStr.append("notify_id=").append(notify_id).append("&");	 	
	 	signStr.append("notify_type=").append(notify_type).append("&"); 	
	 	signStr.append("order_amount=").append(order_amount).append("&");
	 	signStr.append("order_no=").append(order_no).append("&");
	 	signStr.append("order_time=").append(order_time).append("&");
	 	signStr.append("trade_no=").append(trade_no).append("&");	
	 	signStr.append("trade_status=").append(trade_status).append("&");
		signStr.append("trade_time=").append(trade_time);

	 		
		String signInfo =signStr.toString();
		System.out.println("速龙支付返回的签名参数排序：" + signInfo.length() + " -->" + signInfo);		
		System.out.println("速龙支付返回的签名：" + dinpaySign.length() + " -->" + dinpaySign);								
		boolean result = false;
		
		if("RSA-S".equals(sign_type)){ // sign_type = "RSA-S"			
			
			/**
			1)dinpay_public_key，速龙支付公钥，每个商家对应一个固定的速龙支付公钥（不是使用工具生成的商户公钥merchant_public_key，不要混淆），
			     即为速龙支付商家后台"支付管理"->"公钥管理"->"速龙支付公钥"里的绿色字符串内容
			2)demo提供的dinpay_public_key是测试商户号800003004321的速龙支付公钥，请自行复制对应商户号的速龙支付公钥进行调整和替换	*/		
						
			String dinpay_public_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC0R53kCdJ/DErcFvtj77ijX9NhCOCKRP4MXTo7R0gxZ+zSwXGLiytV5wdq3sVF2U7tMRVcdhJY8tSfqjwBPvJ5Q/Hd+teCyLvbGQKmxK+UMOjUF15aHh2oTeVja8kVd6mMWN4vE8WP2uBZ7DBlMWPP9Jysv/6R9mN1RTZ92nsfawIDAQAB"; 
			result = RSAWithSoftware.validateSignByPublicKey(signInfo, dinpay_public_key, dinpaySign);
					// 验签   signInfo速龙支付返回的签名参数排序， dinpay_public_key速龙支付公钥， dinpaySign速龙支付返回的签名
		}
		return result;
	}
	
	public static String buildSignStr(Map<String, String> params) {
        StringBuilder sb = new StringBuilder();
        // 将参数以参数名的字典升序排序
        Map<String, Object> sortParams = new TreeMap<String, Object>(params);
        // 遍历排序的字典,并拼接"key=value"格式
        for (Map.Entry<String, Object> entry : sortParams.entrySet()) {
            if (sb.length()!=0) {
                sb.append("&");
            }
            sb.append(entry.getKey()).append("=").append(entry.getValue());
        }
        return sb.toString();
    }
	
	
	public static Map<String,String> getSuLongRequestParams(SuLongMerchantConfig merchant, SuLongOrderConfig order) throws Exception{
		Map<String,String> suLongParamsMap = new HashMap<String,String>();
		String interface_version = "V3.1";
		suLongParamsMap.put("merchant_code", merchant.getSpid());
		suLongParamsMap.put("service_type",order.getServiceType());
		if(order.getServiceType().indexOf("h5")!=-1){
			suLongParamsMap.put("input_charset", "UTF-8");
			interface_version = "V3.0";
		}
		suLongParamsMap.put("notify_url",order.getNotifyUrl());
		suLongParamsMap.put("interface_version",interface_version);
		suLongParamsMap.put("client_ip", order.getClientIp());
		suLongParamsMap.put("order_no",order.getOrderNo());
		suLongParamsMap.put("order_time",order.getOrderTime());
		suLongParamsMap.put("order_amount", order.getOrderAmount());
		suLongParamsMap.put("product_name", "CPCZ001");
		final String signInfo =  buildSignStr(suLongParamsMap);	
		String sign = RSAWithSoftware.signByPrivateKey(signInfo,merchant.getPrivateKey());	
		suLongParamsMap.put("sign", sign);				
		suLongParamsMap.put("sign_type", "RSA-S");	
		return suLongParamsMap;
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
}