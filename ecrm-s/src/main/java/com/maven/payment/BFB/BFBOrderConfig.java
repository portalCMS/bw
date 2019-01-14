package com.maven.payment.BFB;

public class BFBOrderConfig {

	// 固定值
	public static final String p3_Cur = "CNY"; // 交易币种
	public static final String p0_Cmd = "Buy"; // 业务类型
	
	// 必须参数
	private String TRAN_AMT; // 訂單金額
	private String version; // 版本
	private String MERCHANT_ID; // 商店編號
	private String TRAN_CODE ; // 商店訂單號
	private String TYPE; // 付款方式
	private String NO_URL; // 通知地址(可公開訪問)
	private String SUBMIT_TIME; // 時間戳記
	private String SIGNED_MSG ; // 簽名
	// 非必须参数
	private String REMARK; // 商品名稱，原值返回
	
	//支付结果异步通知接口
	private String SYS_ORDER; // 必付宝流水号
	
	
	//H5支付必穿参数
	//private String returnUrl; // 支付成功返回網址(可公開訪問)
	
	//代付必传参数
	private String NAME; // 受款人姓名(敏感数据)
	private String BANK_NO; // 收款帳戶
	private String BANK_CODE ; // 銀行代碼
	
	
	// 网银支付必传
	private String RET_URL; // 回调地址
	private String BANK_ID; // 银行代码
	public String getTRAN_AMT() {
		return TRAN_AMT;
	}
	public void setTRAN_AMT(String tRAN_AMT) {
		TRAN_AMT = tRAN_AMT;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getMERCHANT_ID() {
		return MERCHANT_ID;
	}
	public void setMERCHANT_ID(String mERCHANT_ID) {
		MERCHANT_ID = mERCHANT_ID;
	}
	public String getTRAN_CODE() {
		return TRAN_CODE;
	}
	public void setTRAN_CODE(String tRAN_CODE) {
		TRAN_CODE = tRAN_CODE;
	}
	public String getTYPE() {
		return TYPE;
	}
	public void setTYPE(String tYPE) {
		TYPE = tYPE;
	}
	public String getNO_URL() {
		return NO_URL;
	}
	public void setNO_URL(String nO_URL) {
		NO_URL = nO_URL;
	}
	public String getSUBMIT_TIME() {
		return SUBMIT_TIME;
	}
	public void setSUBMIT_TIME(String sUBMIT_TIME) {
		SUBMIT_TIME = sUBMIT_TIME;
	}
	public String getSIGNED_MSG() {
		return SIGNED_MSG;
	}
	public void setSIGNED_MSG(String sIGNED_MSG) {
		SIGNED_MSG = sIGNED_MSG;
	}
	public String getREMARK() {
		return REMARK;
	}
	public void setREMARK(String rEMARK) {
		REMARK = rEMARK;
	}
	public String getSYS_ORDER() {
		return SYS_ORDER;
	}
	public void setSYS_ORDER(String sYS_ORDER) {
		SYS_ORDER = sYS_ORDER;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getBANK_NO() {
		return BANK_NO;
	}
	public void setBANK_NO(String bANK_NO) {
		BANK_NO = bANK_NO;
	}
	public String getBANK_CODE() {
		return BANK_CODE;
	}
	public void setBANK_CODE(String bANK_CODE) {
		BANK_CODE = bANK_CODE;
	}
	public String getRET_URL() {
		return RET_URL;
	}
	public void setRET_URL(String rET_URL) {
		RET_URL = rET_URL;
	}
	public String getBANK_ID() {
		return BANK_ID;
	}
	public void setBANK_ID(String bANK_ID) {
		BANK_ID = bANK_ID;
	}
	
	// 必须参数
	/*private String p2_Order; // 商户订单号
	private String p4_Amt; // 支付金额
	private String pa_FrpId; // 支付通道编码
	private String hmac;// 签名数据

	// 网银支付必传
	private String pg_BankCode; // 银行编码

	// 快捷支付直连参数
	private String pc_CardNo; // 卡号
	private String pd_Name;// 姓名
	private String pe_CredType;// 证件类型
	private String pe_IdNum;// 证件号
	private String pf_PhoneNum;// 银行预留手机号
	private String pf_SmsTrxId; // 短信验证码标识
	private String pf_kaptcha;// 短信验证码
	// 快捷支付直连且是信用卡时必传
	private String pc_ExpireYear;// 信用卡有效期年
	private String pc_ExpireMonth;// 信用卡有效期月
	private String pc_CVV; // 信用卡 CVV 3 或 4 位
*/	
	
	
	
}