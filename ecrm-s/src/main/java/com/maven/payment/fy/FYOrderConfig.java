package com.maven.payment.fy;

public class FYOrderConfig {
	private String uid;

	private String amount; // 单位：元

	private String orderId;

	private long time = System.currentTimeMillis() / 1000;

	private String ip;

	private String syncUrl = ""; // 同步跳转地址
	
	private String type; //支付类型

	private String bankCode = ""; //银行编码

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public long getTime() {
		return time;
	}

	public void setTime(long time) {
		this.time = time;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getSyncUrl() {
		return syncUrl;
	}

	public void setSyncUrl(String syncUrl) {
		this.syncUrl = syncUrl;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
}
