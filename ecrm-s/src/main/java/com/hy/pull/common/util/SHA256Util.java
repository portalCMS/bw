package com.hy.pull.common.util;

import java.security.MessageDigest;

/**
 * @author Andy
 * @version 创建时间：2017年10月23日 下午12:23:44
 */
public class SHA256Util {
	public static final String ALGORITHM = "SHA-256";

	public static String SHA256Encrypt(String orignal) {
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance(ALGORITHM);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (null != md) {
			byte[] origBytes = orignal.getBytes();
			md.update(origBytes);
			byte[] digestRes = md.digest();
			String digestStr = getDigestStr(digestRes);
			return digestStr;
		}
		return null;
	}

	private static String getDigestStr(byte[] origBytes) {
		String tempStr = null;
		StringBuilder stb = new StringBuilder();
		for (int i = 0; i < origBytes.length; i++) {
			tempStr = Integer.toHexString(origBytes[i] & 0xff);
			if (tempStr.length() == 1) {
				stb.append("0");
			}
			stb.append(tempStr);

		}
		return stb.toString();
	}

	public static void main(String[] args) {
		System.out.println(SHA256Encrypt("9acace0c-c81c-4df2-a062-a70e403c1049gameType40000recordseJyLrlZKzM0vzStRstI1MtVRKqksSFWyMq7VQYgbw4VNkIVRlMcCAELZFp0%3Dtimestamp123userId4670759acace0c-c81c-4df2-a062-a70e403c1049"));
	}
}
