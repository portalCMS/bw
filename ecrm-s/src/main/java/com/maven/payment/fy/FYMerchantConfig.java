package com.maven.payment.fy;

public class FYMerchantConfig {
	public String apiKey = "";
	// URL: https://www.dsdfpay.com/dsdf/customer_pay/init_din
	// 或: https://fengyun.dsdfpay.com/dsdf/customer_pay/init_din
	private String url = "";

	private String cid = "";

	/**
	 * remit: 银行卡转账 , qrcode: 二维码存款, online: 在线网银 quick: 快捷支付, quickh5: 快捷H5,
	 * quickp2p: 快捷直连 如果没有带入此参数，则自动进去风云聚合收付的收银台，由会员选择存款方式
	 */
	private String type = "qrcode";

	/**
	 * 存款银行，可选，如果没有传入 type 参数，则此参数无效 ALIPAY: 支付宝 , WebMM: 微信支付, QQPAY: QQ钱包 ABC:
	 * 农业银行...
	 */
	private String tFlag = "WebMM";

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getApiKey() {
		return apiKey;
	}

	public void setApiKey(String apiKey) {
		this.apiKey = apiKey;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String gettFlag() {
		return tFlag;
	}

	public void settFlag(String tFlag) {
		this.tFlag = tFlag;
	}
}
