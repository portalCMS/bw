package com.maven.payment.jf;

public class JFMerchantConfig {
	
	/** 商户号 */
	private String spid;//商户id
	/** 签名Key */
	private String md5Key;//约定好的md5key进行的签名key
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
	public String getMd5Key() {
		return md5Key;
	}
	public void setMd5Key(String md5Key) {
		this.md5Key = md5Key;
	}
	public void setPayUrl(String payUrl) {
		this.payUrl = payUrl;
	}
//	public String getPaFrpId() {
//		return paFrpId;
//	}
//	public void setPaFrpId(String paFrpId) {
//		this.paFrpId = paFrpId;
//	}
}