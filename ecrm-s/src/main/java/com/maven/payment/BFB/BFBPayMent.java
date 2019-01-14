package com.maven.payment.BFB;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import com.maven.entity.ThirdpartyPaymentType.Enum_ThirdpartyPaymentType;
import com.maven.payment.PayInterface;
import com.maven.util.Encrypt;

import net.sf.json.JSONObject;

public class BFBPayMent<M extends BFBMerchantConfig, O extends BFBOrderConfig> implements PayInterface<M, O> {
	@Override
	public String save(BFBMerchantConfig merchant, BFBOrderConfig order) throws Exception {	
		String type  =  order.getTYPE();
		Map<String, Object> paramsMap = new HashMap<String, Object>();	
		paramsMap.put("MERCHANT_ID", merchant.getSpid());
		paramsMap.put("TRAN_CODE", order.getTRAN_CODE());
		paramsMap.put("TRAN_AMT", order.getTRAN_AMT());
		paramsMap.put("REMARK", new Date().getTime());
		paramsMap.put("NO_URL", order.getNO_URL());
		paramsMap.put("SUBMIT_TIME",order.getSUBMIT_TIME());
		paramsMap.put("VERSION", "1");
		
		if(type.equals(Enum_ThirdpartyPaymentType.必付宝微信.value)){
			paramsMap.put("TYPE","1");
		}else if(type.equals(Enum_ThirdpartyPaymentType.必付宝支付宝.value)){
			paramsMap.put("TYPE","2");
		}else if(type.equals(Enum_ThirdpartyPaymentType.必付宝QQ.value)){
			paramsMap.put("TYPE","3");
		}else if (type.equals(Enum_ThirdpartyPaymentType.必付宝网银支付.value)) {
			paramsMap.put("BANK_ID",order.getBANK_ID());
		}
		//生成sign
		String sign = Encrypt.MD5(buildSignStr(paramsMap)+merchant.getMd5Key());
		paramsMap.put("SIGNED_MSG",sign);
		String paramsMapStr = buildSignStr(paramsMap);
		System.out.println("****必付宝请求参数************************************");
		System.out.println(paramsMapStr);
		System.out.println("****必付宝请求参数************************************");
		// 网银的直接拿到这串url请求,其他需要先请求,拿到报文的qrCodeUrl
		if (type.equals(Enum_ThirdpartyPaymentType.必付宝网银支付.value)) {
			return merchant.getPayUrl() + "?"+paramsMapStr;
		} else {
			JSONObject json = JSONObject.fromObject(BFBPayUtil.sendPost(merchant.getPayUrl(), paramsMapStr));
			System.out.println("******必付宝请求返回结果*****************************");
			System.out.println(json.toString());
			System.out.println("******必付宝请求返回结果*****************************");
			return json.getString("QR_CODE");
		}
	}

	@Override
	public String pay(BFBMerchantConfig merchant, BFBOrderConfig order) throws Exception {
		return null;
	}
	
	public static String buildSignStr(Map<String, Object> params) {
        StringBuilder sb = new StringBuilder();
        // 将参数以参数名的字典升序排序
        Map<String, Object> sortParams = new TreeMap<String, Object>(params);
        // 遍历排序的字典,并拼接"key=value"格式
        for (Map.Entry<String, Object> entry : sortParams.entrySet()) {
            if (sb.length()!=0) {
                sb.append("&");
            }
            sb.append(entry.getKey()).append("=").append(entry.getValue());
        }
        return sb.toString();
    }

	public static void main(String[] args) throws Exception {
		BFBMerchantConfig merchant = new BFBMerchantConfig();
		//merchant.setMerCode("CHANG1510227664035");
		//merchant.setSha1Key("4d2d553c9ffc4c49845d247d691fab99");
		merchant.setPayUrl("https://changcon.92up.cn/controller.action");

		BFBOrderConfig order = new BFBOrderConfig();
		/*order.setP2_Order(RandomString.UUID());
		order.setP4_Amt(new DecimalFormat("0.00").format(10.00));
		order.setP8_Url("wwww");
		order.setPa_FrpId("P100");
		// 网银支付
		order.setPg_BankCode("WEIXIN");*/
		BFBPayMent<BFBMerchantConfig, BFBOrderConfig> payMent = new BFBPayMent<BFBMerchantConfig, BFBOrderConfig>();
		System.out.println(payMent.save(merchant, order));
	}
}