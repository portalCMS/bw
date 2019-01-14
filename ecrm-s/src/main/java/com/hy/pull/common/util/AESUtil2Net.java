package com.hy.pull.common.util;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class AESUtil2Net {
	
	public static String key="rGKpfj0RsSzaSnl0";
	public static String iv="6bG0cht1zu3J2qp9";
	/**
	 * @author miracle.qu
	 * @see AES算法加密明文
	 * @param data
	 *            明文
	 * @param key
	 *            密钥，长度16
	 * @param iv
	 *            偏移量，长度16
	 * @return 密文
	 */
	public static String encryptAES(String data, String key, String iv) throws Exception {
		try {
			Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
			int blockSize = cipher.getBlockSize();
			byte[] dataBytes = data.getBytes();
			int plaintextLength = dataBytes.length;

			if (plaintextLength % blockSize != 0) {
				plaintextLength = plaintextLength + (blockSize - (plaintextLength % blockSize));
			}

			byte[] plaintext = new byte[plaintextLength];
			System.arraycopy(dataBytes, 0, plaintext, 0, dataBytes.length);

			SecretKeySpec keyspec = new SecretKeySpec(key.getBytes(), "AES");
			IvParameterSpec ivspec = new IvParameterSpec(iv.getBytes());

			cipher.init(Cipher.ENCRYPT_MODE, keyspec, ivspec);
			byte[] encrypted = cipher.doFinal(plaintext);

			return Base64Helper.encode(encrypted).trim();

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static String encryptAES(String data) throws Exception {
		try {
			Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
			int blockSize = cipher.getBlockSize();
			byte[] dataBytes = data.getBytes();
			int plaintextLength = dataBytes.length;

			if (plaintextLength % blockSize != 0) {
				plaintextLength = plaintextLength + (blockSize - (plaintextLength % blockSize));
			}

			byte[] plaintext = new byte[plaintextLength];
			System.arraycopy(dataBytes, 0, plaintext, 0, dataBytes.length);

			SecretKeySpec keyspec = new SecretKeySpec(key.getBytes(), "AES");
			IvParameterSpec ivspec = new IvParameterSpec(iv.getBytes());

			cipher.init(Cipher.ENCRYPT_MODE, keyspec, ivspec);
			byte[] encrypted = cipher.doFinal(plaintext);

			return Base64Helper.encode(encrypted).trim();

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * @author miracle.qu
	 * @see AES算法解密密文
	 * @param data
	 *            密文
	 * @param key
	 *            密钥，长度16
	 * @param iv
	 *            偏移量，长度16
	 * @return 明文
	 */
	public static String decryptAES(String data, String key, String iv) throws Exception {
		try {
			byte[] encrypted1 = Base64Helper.decode(data);

			Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
			SecretKeySpec keyspec = new SecretKeySpec(key.getBytes("utf-8"), "AES");
			IvParameterSpec ivspec = new IvParameterSpec(iv.getBytes("utf-8"));

			cipher.init(Cipher.DECRYPT_MODE, keyspec, ivspec);
			byte[] original = cipher.doFinal(encrypted1);
			String originalString = new String(original);
			return originalString.trim();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static String decryptAES(String data){
		try {
			byte[] encrypted1 = Base64Helper.decode(data);

			Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
			SecretKeySpec keyspec = new SecretKeySpec(key.getBytes("utf-8"), "AES");
			IvParameterSpec ivspec = new IvParameterSpec(iv.getBytes("utf-8"));

			cipher.init(Cipher.DECRYPT_MODE, keyspec, ivspec);
			byte[] original = cipher.doFinal(encrypted1);
			String originalString = new String(original);
			return originalString.trim();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**将二进制转换成16进制 
	 * @param buf 
	 * @return 
	 */  
	public static String parseByte2HexStr(byte buf[]) {  
	        StringBuffer sb = new StringBuffer();  
	        for (int i = 0; i < buf.length; i++) {  
	                String hex = Integer.toHexString(buf[i] & 0xFF);  
	                if (hex.length() == 1) {  
	                        hex = '0' + hex;  
	                }  
	                sb.append(hex.toUpperCase());  
	        }  
	        return sb.toString();  
	}  
	
	/**将16进制转换为二进制 
	 * @param hexStr 
	 * @return 
	 */  
	public static byte[] parseHexStr2Byte(String hexStr) {  
	        if (hexStr.length() < 1)  
	                return null;  
	        byte[] result = new byte[hexStr.length()/2];  
	        for (int i = 0;i< hexStr.length()/2; i++) {  
	                int high = Integer.parseInt(hexStr.substring(i*2, i*2+1), 16);  
	                int low = Integer.parseInt(hexStr.substring(i*2+1, i*2+2), 16);  
	                result[i] = (byte) (high * 16 + low);  
	        }  
	        return result;  
	}  
	
	public static void main(String[] args) {
		try {
			//System.out.println(encryptAES("uid=88988&sid=4685cf53-13bc-4fe9-b785-35469797172c&tryit=n&ts=1492163232496&ck=39f75e8b89376738d139cb906157077f", "rGKpfj0RsSzaSnl0", "6bG0cht1zu3J2qp9"));
			String encryptResultStr = parseByte2HexStr("Me0OtiZQaSPD0WdBHc0B4dM+eh68MWvSCplyjtrnBRo=".getBytes("utf-8"));
			System.out.println(encryptResultStr);
			//System.out.println(decryptAES("Me0OtiZQaSPD0WdBHc0B4dM eh68MWvSCplyjtrnBRo=", "rGKpfj0RsSzaSnl0", "6bG0cht1zu3J2qp9"));
			byte[] decryptFrom = parseHexStr2Byte(encryptResultStr); 
			String decryptResult = decryptAES(new String(decryptFrom) , "rGKpfj0RsSzaSnl0", "6bG0cht1zu3J2qp9");  
			System.out.println("解密后：" + decryptResult); 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
