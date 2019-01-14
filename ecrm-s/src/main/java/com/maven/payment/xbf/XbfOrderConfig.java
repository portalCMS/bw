package com.maven.payment.xbf;

public class XbfOrderConfig {

	private String amount; // 金额
	private String order_sn; // 订单号
	private String nonce_str; // 随机字符串固定为32位不含符号

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getOrder_sn() {
		return order_sn;
	}

	public void setOrder_sn(String order_sn) {
		this.order_sn = order_sn;
	}

	public String getNonce_str() {
		return nonce_str;
	}

	public void setNonce_str(String nonce_str) {
		this.nonce_str = nonce_str;
	}

}
