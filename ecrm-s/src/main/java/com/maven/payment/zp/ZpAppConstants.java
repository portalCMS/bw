package com.maven.payment.zp;

import com.maven.game.OrderNewUtil2;
import com.maven.util.RandomString;

public class ZpAppConstants {
	
	public static String getOrderNo() {
		return RandomString.createRandomString(2) + OrderNewUtil2.getPatchno();
	}
	
	public enum Zp_PayType {
		微信扫码支付("wxpay"), 
		支付宝扫码支付("alipay");
		public String value;

		private Zp_PayType(String value) {
			this.value = value;
		}
	}
}
