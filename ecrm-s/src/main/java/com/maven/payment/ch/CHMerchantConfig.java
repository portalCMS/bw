package com.maven.payment.ch;

public class CHMerchantConfig {
	
	/** 商户号 */
	private String merCode;
	/** 签名Key */
	private String sha1Key;
	/** 支付接口地址 */
	private String payUrl;
	
//	pd_FrpId参数值	对应支付通道名称
//	ALIPAY 支付宝
//	ALIPAYPOS	支付宝刷卡
//	WEIXIN	微信
//	WEIXINPB	微信公众号支付
//	WEIXINPOS	微信刷卡
//	CHANGCODEPAY	畅码支付
//	OnlinePay	网银支付
//	Nocard	快捷支付
//	Nocard_H5	快捷支付h5
//	Nocard_P2P	快捷支付直连
//	QQ       	qq扫码支付
//	private String paFrpId;
	
//	pg_BankCode	对应支付通道名称
//	BOC	中国银行
//	ICBC	工商银行
//	CCB	建设银行
//	ECITIC	中信银行
//	CMBC	民生银行
//	CIB	兴业银行
//	CGB	广发银行
//	ABC	农业银行
//	BOCO	交通银行
//	BOB	北京银行
//	SPDB	上海浦东发展银行
//	SRCB	上海农商
//	PAB	平安银行
//	SHB	上海银行
//	CMBCHINA	招商银行
//	CEB	光大银行
//	POST	中国邮政储蓄银行
//	BRCB	北京农村商业银行
//	HXB	华夏银行
//	HZB	杭州银行
//	NJCB	南京银行
//	CZB	浙商银行
//	CBHB	渤海银行
	
	public String getMerCode() {
		return merCode;
	}
	public void setMerCode(String merCode) {
		this.merCode = merCode;
	}
	public String getSha1Key() {
		return sha1Key;
	}
	public void setSha1Key(String sha1Key) {
		this.sha1Key = sha1Key;
	}
	public String getPayUrl() {
		return payUrl;
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