package com.maven.payment.xbf;

public class XbfAppConstants {
	
	public enum Xb_PayType {
		微信扫码支付("wxpay"), 
		支付宝扫码支付("alipay");
		public String value;

		private Xb_PayType(String value) {
			this.value = value;
		}
	}
}
