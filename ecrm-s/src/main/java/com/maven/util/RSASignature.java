package com.maven.util;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SignatureException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.codec.binary.Base64;

import com.itrus.util.sign.RSAWithSoftware;
import com.maven.payment.sulong.HttpClientUtil;


/**
 * RSA签名验签类
 */
public class RSASignature {
	/**
	 * RSA Key的生成算法
	 */
	private static final String KEY_ALGORITHM = "RSA";

	/**
	 * RSA 签名算法为： SHA1WithRSA;
	 */
	private static final String SIGN_ALGORITHMS = "SHA1WithRSA";
	
	 // 公钥
    public static final String PUBLIC_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVTdDVOFay0TWqlKXhigCqbhmvewluFMZnfsAaaaodnIkTiOG+c8YWL615tQaxNU9zXAuSTSVn5A8nKJmEQs5wbS3JYSTOwCtLrXWLrMr8W4L7kFC81bd2/w6mSHISsOrQ6a1CVUQAkIktN1/TTuEpRYhR4S7PoS01HGMy1piqAwIDAQAB";
    // 私钥
    public static final String PRIVATE_KEY = "MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAJVN0NU4VrLRNaqUpeGKAKpuGa97CW4Uxmd+wBppqh2ciROI4b5zxhYvrXm1BrE1T3NcC5JNJWfkDycomYRCznBtLclhJM7AK0utdYusyvxbgvuQULzVt3b/DqZIchKw6tDprUJVRACQiS03X9NO4SlFiFHhLs+hLTUcYzLWmKoDAgMBAAECgYAtB7kydbmAWSTse8TED1FAFdDdYihn8RAd6taZoMDUCYA2ShR70oMt8ddKW9TW4ZNC4cIDsAzWFqyTTOVwRI3qWGxlxkJl5EnFu4hcWXFBZT9aQ4pZOMXcpZAadkk3lrintaNPsZXhqObHpxoFDkzQpPpr9AIu9VAAfP49ZW1DoQJBANGTtTHFt9/Qup97yb/u67SRCPFA2Pf1ensPUIcmhI90oVHSYbwsc6jLqXRTyRCm/ZnnM9T5jmRu1anc8rwUQ/sCQQC2YEK5brucahUQzD9TFAfdTlMMAJ+SPH1QJ9jYbkRVa4i/a/FzBR4BCrl8hGjWQQXNhc2w2JzqLZpqbugdfMuZAkAQhFCabJeyNvQOT6Y1zzGaWHfY86Bl4l3Vxv40uI9n8uwn06nKN8KhwfNH7LaC7nY8I+GM3mIffjCuo3Ap7HrzAkAVGs6d5tKPJzeI2hn54zeFxKqXmPreUWGvBO1zHk+KEwegHz2xscXnGPaeEjSPlra1Mea7sFV4RA66glsaDncBAkBO16bjDVgfCDGjEM+mzAERDuxSYWnoJJoYtzv+i6CeFqgaq96RoYVqo+RjgNumiSeTVr1JzXhBPsQooRJP7rJy";

	/**
	 * RSA 签名
	 * 
	 * @param content
	 *            待加密的数据文本
	 * @param privateKey
	 *            私钥
	 * @param encode
	 *            字符集编码
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws InvalidKeySpecException
	 * @throws InvalidKeyException
	 * @throws SignatureException
	 * @throws UnsupportedEncodingException
	 */
	public static String sign(String content, String privateKey, String encode) throws NoSuchAlgorithmException,
			InvalidKeySpecException, InvalidKeyException, SignatureException, UnsupportedEncodingException {

		PKCS8EncodedKeySpec priPKCS8 = new PKCS8EncodedKeySpec(Base64.decodeBase64(privateKey));

		KeyFactory keyf = KeyFactory.getInstance(KEY_ALGORITHM);
		PrivateKey priKey = keyf.generatePrivate(priPKCS8);

		java.security.Signature signature = java.security.Signature.getInstance(SIGN_ALGORITHMS);

		signature.initSign(priKey);
		signature.update(content.getBytes(encode));

		byte[] signed = signature.sign();

		String sign = Base64.encodeBase64String(signed);

//		return sign;
		return replaceBlank(sign);
	}

	/**
	 * RSA 签名 - 无编码格式
	 * 
	 * @param content
	 *            待加密的数据文本
	 * @param privateKey
	 *            私钥
	 * @return
	 * @throws InvalidKeySpecException
	 * @throws NoSuchAlgorithmException
	 * @throws InvalidKeyException
	 * @throws SignatureException
	 */
	public static String sign(String content, String privateKey)
			throws InvalidKeySpecException, NoSuchAlgorithmException, InvalidKeyException, SignatureException {

		PKCS8EncodedKeySpec priPKCS8 = new PKCS8EncodedKeySpec(Base64.decodeBase64(privateKey));

		KeyFactory keyf = KeyFactory.getInstance(KEY_ALGORITHM);
		PrivateKey priKey = keyf.generatePrivate(priPKCS8);

		java.security.Signature signature = java.security.Signature.getInstance(SIGN_ALGORITHMS);

		signature.initSign(priKey);
		signature.update(content.getBytes());

		byte[] signed = signature.sign();

		String sign = Base64.encodeBase64String(signed);

//		return sign;
		return replaceBlank(sign);
	}

	/**
	 * RSA签名校验
	 * 
	 * @param content
	 *            签名数据
	 * @param sign
	 *            签名值
	 * @param publicKey
	 *            公钥
	 * @param encode
	 *            字符集编码
	 * @return
	 * @throws InvalidKeySpecException
	 * @throws NoSuchAlgorithmException
	 * @throws InvalidKeyException
	 * @throws SignatureException
	 * @throws UnsupportedEncodingException
	 */
	public static boolean doCheck(String content, String sign, String publicKey, String encode)
			throws InvalidKeySpecException, NoSuchAlgorithmException, InvalidKeyException, SignatureException,
			UnsupportedEncodingException {

		KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
		byte[] encodedKey = Base64.decodeBase64(publicKey);
		PublicKey pubKey = keyFactory.generatePublic(new X509EncodedKeySpec(encodedKey));

		java.security.Signature signature = java.security.Signature.getInstance(SIGN_ALGORITHMS);

		signature.initVerify(pubKey);
		signature.update(content.getBytes(encode));

		boolean bverify = signature.verify(Base64.decodeBase64(sign));

		return bverify;
	}

	/**
	 * RSA签名校验 - 无编码格式
	 * 
	 * @param content
	 *            签名数据
	 * @param sign
	 *            签名只
	 * @param publicKey
	 *            公钥
	 * @return
	 * @throws InvalidKeySpecException
	 * @throws NoSuchAlgorithmException
	 * @throws InvalidKeyException
	 * @throws SignatureException
	 */
	public static boolean doCheck(String content, String sign, String publicKey)
			throws InvalidKeySpecException, NoSuchAlgorithmException, InvalidKeyException, SignatureException {

		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		byte[] encodedKey = Base64.decodeBase64(publicKey);
		PublicKey pubKey = keyFactory.generatePublic(new X509EncodedKeySpec(encodedKey));

		java.security.Signature signature = java.security.Signature.getInstance(SIGN_ALGORITHMS);

		signature.initVerify(pubKey);
		signature.update(content.getBytes());
		boolean bverify = signature.verify(Base64.decodeBase64(sign));

		return bverify;
	}
	/**
	 * 
	 * @param str
	 * @return
	 */
	public static String replaceBlank(String str) {
		String dest = "";
		if (str != null) {
			Pattern p = Pattern.compile("\\s*|\t|\r|\n");
			Matcher m = p.matcher(str);
			dest = m.replaceAll("");
		}
		return dest;
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
	
	 public static void main(String[] args) throws Exception {
	        /*String dataStr = "client_ip=130.105.220.28&interface_version=V3.1&merchant_code=103103125016&notify_url=www.baidu.com&order_amount=1.01&order_no=1525876764670&order_time=2013-11-01 12:34:58&product_name=DFHG750Y47JX-BL&service_type=tenpay_scan";
//	        String dataStr = "{\"v_pagecode\":\"1001\",\"v_mid\":\"110102\",\"v_oid\":\"20170514-110102-141221\",\"v_rcvname\":\"收货人名称\",\"v_rcvaddr\":\"地址\",\"v_rcvtel\":\"13513512345\",\"v_goodsname\":\"商品\",\"v_goodsdescription\":\"描述\",\"v_rcvpost\":\"10021\",\"v_qq\":\"1254545\",\"v_amount\":\"12\",\"v_ymd\":\"20170514\",\"v_orderstatus\":\"1\",\"v_ordername\":\"定货人名称\",\"v_bankno\":\"105100000017\",\"v_moneytype\":\"0\",\"v_url\":\"http://api.hyzonghe.net/TPayment/HRPayCallback\",\"v_md5info\":\"0e1db763c623d991f3b49bf1b3123aa3\"}";
	        System.out.println("数据原文：\n" + dataStr);
	        System.out.println("==================================================");
	        String encodedData = RSASignature.sign(dataStr, PRIVATE_KEY);
	        System.out.println("加密后密文：\n" + encodedData);
	        System.out.println("==================================================");
	        boolean resultData = RSASignature.doCheck(dataStr, "L3JGV5L9lp8lnt3xcZK1LWAAso1bnGq5mPH39ckGpxRjwIIdApbOeP6T+epJcgs+mTjvL+BRwNZcUSwAbmjEwErEQLaPJnkJqVNtRpShhB/xiEstUu2wpAp6l0JsCUh0mcVXaLTG9Vg//pdK9pwNqtq4Zc32BiOKwP4EFVUyRXc=", RSACoder.PUBLIC_KEY);
	        System.out.println("解密后原文：\n" + resultData);
	        System.out.println("==================================================");
	        */
	        
	        
	    	// 支付请求地址
			//String reqUrl = "https://api.islpay.com/gateway/api/scanpay";
		 String reqUrl = "https://pay.islpay.com/gateway";
			// 支付请求返回结果
			String result = null;
			
			Map<String,String> suLongParamsMap = new HashMap<String,String>();
			suLongParamsMap.put("merchant_code", "103103125016");
			suLongParamsMap.put("service_type", "h5_wx");
			suLongParamsMap.put("notify_url", "http://172.105.220.190:7070/ecrm-api/TPayment/suLongCallback");
			suLongParamsMap.put("interface_version", "V3.0");
			suLongParamsMap.put("client_ip", "172.105.220.190");
			suLongParamsMap.put("order_no","824ABE7EA5FA450FA68A7311437CF51");
			suLongParamsMap.put("order_time", "2018-05-12 02:07:01");
			suLongParamsMap.put("order_amount", "1.2");
			suLongParamsMap.put("product_name", "CPCZ001");
			suLongParamsMap.put("input_charset", "UTF-8");
			final String signInfo =  buildSignStr(suLongParamsMap);
			
			// 接收表单提交参数
		

			/** 数据签名
			签名规则定义如下：
			（1）参数列表中，除去sign_type、sign两个参数外，其它所有非空的参数都要参与签名，值为空的参数不用参与签名；
			（2）签名参数排序按照参数名a到z的顺序排序，若遇到相同首字母，则看第二个字母，以此类推，组成规则如下：
			参数名1=参数值1&参数名2=参数值2&……&参数名n=参数值n		*/

			String sign = "" ;
			if(true){ // sign_type = "RSA-S"			
				
				/**
				1)merchant_private_key，商户私钥，商户按照《密钥对获取工具说明》操作并获取商户私钥；获取商户私钥的同时，也要获取商户公钥（merchant_public_key）；调试运行
				代码之前首先先将商户公钥上传到速龙支付商家后台"支付管理"->"公钥管理"（如何获取和上传请查看《密钥对获取工具说明》），不上传商户公钥会导致调试运行代码时报错。
				2)demo提供的merchant_private_key是测试商户号800003004321的商户私钥，请自行获取商户私钥并且替换	*/	
				
				//String merchant_private_key ="MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANilQBp9xg6KdgB+6jVnIFnMl34jR3sGguvDjAgTLTqYd/FhkSbNl24rbRKDjZ4jqDKxFFUbFlqMd0YuSzhE+Utb1jNcBROTyIn/2O0cCmN0tPFaSgL/ywYhXSjT1FlAWuFbBV+bggj8CLDUpTGm31BofJA/qmg9Kn/wW2aF8QjNAgMBAAECgYEAyALgiNSfeqM4SELjxcPc6SrqngjCIIGlczbI3FegBR3odlBmatWaPZsYCuSrZVl0GsDDjcMBQz21jHSG+38qS0WTxWrMgw/k88ygbfDXWEZQd1v8Em7CDIFN5rZ7InS2GZsDDl5HhBHFKp6eoGug+Xo7Z5O8GokYaGKCdOuVcUECQQD9NRF05NTp0BzGxfVkcWmJeYI23vH+No8nPed4OZSA2gNtpz7mZ2NE7lw05skznf4bVxWTanlynorYD32fejfdAkEA2wjzKggsxfiy4FkPpq9Q04FooQt+W8efD4EOWuYMOVNoOAJYmjzE8YY2XUkaEZ80NHnCJcEZ/UtSX4OqL/f9sQJBANcazTCr8cCL/tZSd8yTmF+krR1mOtiGiwiAS3LUH7dy/jSaPxJHRIrbn9OFN+o0zxl02qx4aKIZ08QHLOZdUrUCQQDagA4a8va/Mv42QYIUdLV7mI+of8+4fOWW0NZiJTUyhprjrKt4iYCps4pN+tuvkpLAemoLwZtMi7QLpkvC+G+xAkAtOkom2PugToM5QiM4MS7puinFV89SEsVQuGvHyyJ/iH8O6igd5XrH1AR7kL879onPTvARTz+Ai7bHq3mUD3Wr";
				String merchant_private_key = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANqVmZiNpLm4fuW0"
						+"FAGZKAacHMUQYbI1zszo3ShDDs+hGL4oOI9zAUmZ0M+SunGgjqUwXDGdBmtmolSP"
						+"SGAFyaBTYLlt1pExL7OJ9GhvI31WSs6NtjLUv9ENnd/nLIJn/nL7CCc+wKUlJ3fq"
						+"lHz3zd6xuohB0PtvuK6kIbsRMa0bAgMBAAECgYBmQn6tA/cAe/PB+tExPjmffgFn"
						+"oBZUjR/GdVqhr12KfU9aBu8PDTqY+EDcG0TmS7rwRQOcol2SeV2QOcgeRBbi8PoD"
						+"7Q3KiXe/qHk0k5CMFgaYm4/+4PEZjw4tWZmHHN5rMyZY6oD8ov+JqYYVGbAVesFP"
						+"i1EeJYGj5J6hkl4mQQJBAPleLnjSkW78wbU0kPVV4OeP5vQTFEC2tl7Kwu4/92+f"
						+"KCPFqrEHZoxiiDlcpE1DgZuHL3twF8PtMQ+lpgFUYkMCQQDgZdRGU6h1/29GMnTx"
						+"j6BRlYsI4f0SWV+dwpxjxn71yaqMTOgF6L6UhrWR5HYs/EJ6TmFi8gb8HsZeua8w"
						+"IThJAkEA1mdf1YpWePLhKgfUStxXz0Eu9dQhqbJvAvmauHZPLK3POVKO/D68sR9W"
						+"uNsqeTP9j9efv6YVCOQ7NpTaMnJ3OQJBALMPjrwvtZWzJtAVI0w/F+cCNdf4vUEP"
						+"IEV7LeBQXK81JWqfU+ajOrC6bdjlPYfYJBQEx6F1EC3PQOwFr83wNEECQBd1SwTj"
						+"ItusloP18dMINa37pMrhrUJH70HbYbpDOkZ0Sq7wBF6goSQqVst7Ibug56V7dlAZ"
						+"Lxp2hwI8RrZKc1o=";
				
				sign = RSAWithSoftware.signByPrivateKey(signInfo,merchant_private_key);	// 签名   signInfo签名参数排序，  merchant_private_key商户私钥  				
				suLongParamsMap.put("sign", sign);				
				suLongParamsMap.put("sign_type", "RSA-S");			
				System.out.println("reqMap："+suLongParamsMap);
				System.out.println("GET请求URL："+reqUrl+"?"+buildSignStr(suLongParamsMap));
				result= new HttpClientUtil().doPost(reqUrl, suLongParamsMap, "utf-8");		 	// 向速龙支付发送POST请求							
			}
				
			System.out.println("签名参数排序：" + signInfo.length() + " --> " + signInfo);
			System.out.println("sign值：" + sign.length() + " --> " + sign);
			System.out.println("result值："+result);
	        System.out.println("---------------------------------------------------------------------------------------------------------------------------------------------");  
	  
	        List<Map<String,String>> listMap = (List<Map<String,String>>)XmlUtils.parseXmlStr(result).get("dinpay");
	        System.out.println(listMap);
	        System.out.println(listMap.get(0).get("qrcode"));
	        
	        String publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC0R53kCdJ/DErcFvtj77ijX9NhCOCKRP4MXTo7R0gxZ+zSwXGLiytV5wdq3sVF2U7tMRVcdhJY8tSfqjwBPvJ5Q/Hd+teCyLvbGQKmxK+UMOjUF15aHh2oTeVja8kVd6mMWN4vE8WP2uBZ7DBlMWPP9Jysv/6R9mN1RTZ92nsfawIDAQAB";
	       // RSAWithSoftware.validateSignByPublicKey(paramStr, publicKey, signedData)
	    }
}