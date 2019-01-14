package com.maven.payment.fy;

import java.text.DecimalFormat;

import com.maven.entity.ThirdpartyPaymentType.Enum_ThirdpartyPaymentType;
import com.maven.payment.PayInterface;
import com.maven.util.RandomString;

public class FYPayMent<M extends FYMerchantConfig,O extends FYOrderConfig> implements PayInterface<M, O>{

	@Override
	public String save(FYMerchantConfig merchant, FYOrderConfig order) throws Exception {
		StringBuilder params = new StringBuilder();
		params.append("cid=" + merchant.getCid());
		params.append("&uid=" + order.getUid());
		params.append("&time=" + order.getTime());
		params.append("&amount=" + order.getAmount());
		params.append("&order_id=" + order.getOrderId());
		params.append("&ip=" + order.getIp());
		
		String type = order.getType();
		if (type.equals(Enum_ThirdpartyPaymentType.风云聚合网银.value)) {
			params.append("&type=online");
			params.append("&tflag=" + order.getBankCode());
		} else {
			params.append("&type="+merchant.getType());
			params.append("&tflag=" + merchant.gettFlag());
		}
		String[] stringArray = params.toString().split("&");
		StringBuilder hmacString = new StringBuilder();
		for (String string : stringArray) {
			System.out.println(string);
			String[] tempArray = string.split("=");
			hmacString.append(tempArray[1]);
		}
		System.out.println("**************");
		System.out.println(hmacString.toString());
		System.out.println("**************");
		String sign = FYSave.getRequestSign(merchant.getCid(), order.getUid(), order.getTime(), order.getAmount(),
				order.getOrderId(), order.getIp(), merchant.getApiKey());
		params.append("&sign=" + sign);
		
		return merchant.getUrl() + "?" + params.toString();
	}

	@Override
	public String pay(FYMerchantConfig merchant, FYOrderConfig order) throws Exception {
		return null;
	}
	
	public static void main(String[] args) throws Exception {
		FYMerchantConfig merchant = new FYMerchantConfig();
		merchant.setApiKey("");
		merchant.setCid("");
		merchant.settFlag("");
		merchant.setType("");
		merchant.setUrl("");

		FYOrderConfig order = new FYOrderConfig();
		order.setOrderId(RandomString.UUID());
		order.setAmount(new DecimalFormat("0.00").format(10.00));
		order.setUid(new RandomString().createRandomString(8));
		order.setType("P110");
		order.setIp("103.5.4.246");
		// 网银支付
		order.setBankCode("ABC");
		FYPayMent<FYMerchantConfig, FYOrderConfig> payMent = new FYPayMent<FYMerchantConfig, FYOrderConfig>();
		System.out.println(payMent.save(merchant, order));
	}

}
