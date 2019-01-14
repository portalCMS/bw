package com.maven.util;

import java.security.MessageDigest;

public class MD5Util {

	private static final String hexDigits[] = { "0", "1", "2", "3", "4", "5",
			"6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };
	private static final String CHAR_SET = "UTF-8";
	/**
	 * 将md5加密后的字符串转为16进制
	 * @param b
	 * @return
	 */
	public static String byteArrayToHexString(byte b[]) {
		StringBuffer resultSb = new StringBuffer();
		for (int i = 0; i < b.length; i++) {
			resultSb.append(byteToHexString(b[i]));
		}
		return resultSb.toString();
	}

	/**
	 * 将字节转换为16进制字符串
	 * @param b  将要转换的数字
	 * @return   返回的16进制数字
	 */
	private static String byteToHexString(byte b) {
		int n = b;
		if (n < 0) {
			n = 256 + n;
		}
		int d1 = n / 16;
		int d2 = n % 16;
		return hexDigits[d1] + hexDigits[d2];

	}

	/**
	 * md5加密
	 * @param origin  被加密的字符串
	 * @return  加密后的字符串
	 */
	public static String getMD5Encode(String origin) {
		String resultString = null;
		try {
			resultString = new String(origin);
			MessageDigest md = MessageDigest.getInstance("MD5");
			resultString = byteArrayToHexString(md.digest(resultString
					.getBytes()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultString;
	}
	
	public static String signByMD5(String sourceData, String key) throws Exception {
		String data = sourceData + key;
		MessageDigest md5 = MessageDigest.getInstance("MD5");
		byte[] sign = md5.digest(data.getBytes(CHAR_SET));

		return Bytes2HexString(sign).toUpperCase();
	}
	
	/**
	 * 将byte数组转成十六进制的字符串
	 * 
	 * @param b
	 *            byte[]
	 * @return String
	 */
	public static String Bytes2HexString(byte[] b) {
		StringBuffer ret = new StringBuffer(b.length);
		String hex = "";
		for (int i = 0; i < b.length; i++) {
			hex = Integer.toHexString(b[i] & 0xFF);

			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			ret.append(hex.toUpperCase());
		}
		return ret.toString();
	}
	
	public static void main(String[] args) {
		System.out.println(MD5Util.getMD5Encode("liangchongzao123"));
	}
}
