package com.maven.payment.zp;
import com.maven.payment.PayInterface;

public class ZpPayMent <M extends ZpMerchantConfig,O extends ZpOrderConfig> implements PayInterface<M,O>{

	@Override
	public String save(M merchant, O order) throws Exception {
		String requestUrl = ZpPaySignUtil.getRequestUrl(merchant, order);
		System.out.println("支付请求链接="+requestUrl);
		return requestUrl;
	}

	@Override
	public String pay(M merchant, O order) throws Exception {
		return null;
	}

}
