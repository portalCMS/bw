package com.maven.payment.sulong;

public class SuLongMerchantConfig {
	
	/** 商户号 */
	private String spid;//商户id
	/** 签名Key */
	private String privateKey;//约定好的md5key进行的签名key
	/** 支付接口地址 */
	private String payUrl;//请求接口的url
	
	public String getPayUrl() {
		return payUrl;
	}
	public String getSpid() {
		return spid;
	}
	public void setSpid(String spid) {
		this.spid = spid;
	}
	
	public String getPrivateKey() {
		return privateKey;
	}
	public void setPrivateKey(String privateKey) {
		this.privateKey = privateKey;
	}
	public void setPayUrl(String payUrl) {
		this.payUrl = payUrl;
	}

}