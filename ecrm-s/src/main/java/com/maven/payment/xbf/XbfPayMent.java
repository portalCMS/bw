package com.maven.payment.xbf;

import com.maven.payment.PayInterface;



public class XbfPayMent <M extends XbfMerchantConfig,O extends XbfOrderConfig> implements PayInterface<M,O>{
	
	@Override
	public String save(XbfMerchantConfig merchant, XbfOrderConfig order) throws Exception {
		String requestUrl = XbfPaySignUtil.getRequestUrl(merchant, order);
		System.out.println("支付请求链接="+requestUrl);
		return requestUrl;
	}
	
	@Override
	@Deprecated
	public String pay(XbfMerchantConfig merchant, XbfOrderConfig order) throws Exception {
		return "";
	}

}
