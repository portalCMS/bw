package com.maven.payment.jf;

public class JFOrderConfig {

	// 捷付  支付渠道必须参数
	private String partner; // 商店編號
	private String banktype; // 银行类型
	private String paymoney; // 银行类型
	private String ordernumber ; // 商店訂單號
	private String callbackurl; //回调接口
	private String sign; //sign
	
	private String bankCode;
	private String thirdpartypaymenttypecode;//本项目自己支付渠道代号
	
	private String hrefbackurl; // 下行同步通知地址
	private String attach; // 备注信息
	private String isshow ; // 该参数为支付宝扫码、微信、QQ钱包专用，默认为1，跳转到网关页面进行扫码，如设为0，则网关只返回二维码图片地址供用户自行调用
	public String getPartner() {
		return partner;
	}
	public void setPartner(String partner) {
		this.partner = partner;
	}
	public String getBanktype() {
		return banktype;
	}
	public void setBanktype(String banktype) {
		this.banktype = banktype;
	}
	public String getPaymoney() {
		return paymoney;
	}
	public void setPaymoney(String paymoney) {
		this.paymoney = paymoney;
	}
	public String getOrdernumber() {
		return ordernumber;
	}
	public void setOrdernumber(String ordernumber) {
		this.ordernumber = ordernumber;
	}
	public String getCallbackurl() {
		return callbackurl;
	}
	public void setCallbackurl(String callbackurl) {
		this.callbackurl = callbackurl;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getHrefbackurl() {
		return hrefbackurl;
	}
	public void setHrefbackurl(String hrefbackurl) {
		this.hrefbackurl = hrefbackurl;
	}
	public String getAttach() {
		return attach;
	}
	public void setAttach(String attach) {
		this.attach = attach;
	}
	public String getIsshow() {
		return isshow;
	}
	public void setIsshow(String isshow) {
		this.isshow = isshow;
	}
	public String getBankCode() {
		return bankCode;
	}
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
	public String getThirdpartypaymenttypecode() {
		return thirdpartypaymenttypecode;
	}
	public void setThirdpartypaymenttypecode(String thirdpartypaymenttypecode) {
		this.thirdpartypaymenttypecode = thirdpartypaymenttypecode;
	}

	
	
}