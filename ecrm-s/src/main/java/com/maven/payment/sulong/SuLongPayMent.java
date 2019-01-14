package com.maven.payment.sulong;

import java.util.Map;

import com.maven.payment.PayInterface;

public class SuLongPayMent<M extends SuLongMerchantConfig, O extends SuLongOrderConfig> implements PayInterface<M, O> {
	@Override
	public String save(SuLongMerchantConfig merchant, SuLongOrderConfig order) throws Exception {
		Map<String,String> suLongRequestParams =  SulongPayUtil.getSuLongRequestParams(merchant,order);
		System.out.println("****速龙请求参数************************************"+suLongRequestParams);
		if(order.getServiceType().indexOf("h5")!=-1){
			//h5类型跳转
			return merchant.getPayUrl()+"?"+SulongPayUtil.buildSignStr(suLongRequestParams);	
		}
		String suLongResponseXmlStr = SulongPayUtil.senPost(merchant.getPayUrl(), suLongRequestParams);
		System.out.println("****速龙返回XML************************************"+suLongResponseXmlStr);
		Map<String,String> resultMap = SulongPayUtil.getSuLongRespsonMap(suLongResponseXmlStr);
		System.out.println("****速龙请解析XML************************************"+resultMap);
		return resultMap.get("qrcode");
		//return "https://myun.tenpay.com/mqq/pay/qrcode.html?_wv=1027&_bid=2183&t=5V4eb1ebe7b557d9b8d5425ee8e97cd5";
	}
	@Override
	public String pay(SuLongMerchantConfig merchant, SuLongOrderConfig order) throws Exception {
		return null;
	}
	
	
}