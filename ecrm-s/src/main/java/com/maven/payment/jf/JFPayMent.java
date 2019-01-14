package com.maven.payment.jf;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import com.maven.entity.ThirdpartyPaymentType.Enum_ThirdpartyPaymentType;
import com.maven.payment.PayInterface;
import com.maven.payment.ch.CHOrderConfig;
import com.maven.util.Encrypt;

import net.sf.json.JSONObject;

public class JFPayMent<M extends JFMerchantConfig, O extends JFOrderConfig> implements PayInterface<M, O> {
	@Override
	public String save(JFMerchantConfig merchant, JFOrderConfig order) throws Exception {
		String paramsMapStr =  JFPayUtil.getJFRequestParams(merchant,order);
		System.out.println("****捷付请求参数************************************");
		System.out.println(paramsMapStr);
		System.out.println("****捷付请求参数************************************");
		//直接拿到这串url请求
		return merchant.getPayUrl() + "?"+paramsMapStr;
	}

	@Override
	public String pay(JFMerchantConfig merchant, JFOrderConfig order) throws Exception {
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
}