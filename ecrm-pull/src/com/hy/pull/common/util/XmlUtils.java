package com.hy.pull.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element; 
  
  
public class XmlUtils {  
	private static final String HEAD = "head";  
	private static final String BODY = "body";  
  
  
	public static void main(String[] args) throws DocumentException {  
		//解析XML为map
		/*String xmlStr = "<dinpay><response><interface_version>V3.1</interface_version><merchant_code>103103125016</merchant_code><order_amount>1.01</order_amount><order_no>1525877251111</order_no><order_time>2013-11-01 12:34:58</order_time><qrcode>https://myun.tenpay.com/mqq/pay/qrcode.html?_wv=1027&amp;_bid=2183&amp;t=5V693364d5873c885320911e7577f768</qrcode><resp_code>SUCCESS</resp_code><resp_desc>通讯成功</resp_desc><result_code>0</result_code><sign>qcPSjJmoUnIfTrm43ZC6HhVqR6QcRFhdqWlVJil8oN/DDOE4qx+BJTcthGvkQtjVo6PgEVnlthpXrT8qxjjxctOlAnVTnhwaNN+3NZG65NvnwZGOEHrByOUMjE5L+xnGnH3n12ETeZy4fU+9y0ePg1SQkaSKyDCqNUNftl7Rhck=</sign><sign_type>RSA-S</sign_type><trade_no>1000582385</trade_no><trade_time>2018-05-10 22:54:12</trade_time></response></dinpay>";
		String xml = "<ap>   <head>      <tr_code>330003</tr_code>      <corp_no>8000500436</corp_no>      <user_no>22222</user_no>      <req_no>123456789001</req_no>      <tr_acdt>20160510</tr_acdt>      <tr_time>151238</tr_time>      <atom_tr_count>1</atom_tr_count>      <channel>0</channel>      <reserved />   </head>   <body>      <cert_no>TEST01234</cert_no>      <pay_acno>310066865018010123060</pay_acno>      <type>S</type>      <sum>1</sum>      <sum_amt>0.01</sum_amt>      <pay_month>201605</pay_month>      <summary>测试0.01</summary>      <busi_no>3100012379</busi_no>      <selsec_flg>0</selsec_flg><tran><rcd><card_no>00000001</card_no><acname>测试账号</acname><card_flag>0</card_flag><amt>21.01</amt><busino>111111111</busino></rcd><rcd><card_no>00000001</card_no><acname>测试账号</acname><card_flag>0</card_flag><amt>21.01</amt><busino>111111111</busino></rcd></tran>   </body></ap>";  
		List<Map<String,String>> listMap = (List<Map<String,String>>)XmlUtils.parseXmlStr(xmlStr).get("dinpay");
		System.out.println(listMap.get(0).get("order_no"));  */
		
		
		//HG数据拉取
		String HGXML = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
						//+"<string xmlns=\"http://service.hogaming.info/\">"
						+"<BetInfos>"
						+"<Betinfo>"
						+"<BetStartDate>01/12/2001 00:00:05</BetStartDate>"
						+"<BetEndDate>01/12/2001 00:00:34</BetEndDate>"
						+"<AccountId>abcdef</AccountId>"
						+"<TableId>bacdhq2j04hjj8c1</TableId>"
						+"<GameId>sa53o3qjh493j32utsjhnpia</GameId>"
						+"<BetId>b136pxaccaedif567ahsip6vqnuy8t80</BetId>"
						+"<BetAmount>150.00</BetAmount>"
						+"<Payout>142.50</Payout>"
						+"<Currency>CNY</Currency>"
						+"<GameType>Baccarat</GameType>"
						+"<BetSpot>Banker</BetSpot>"
						+"<BetNo>b136pxaccaedif567ahsip6vqnuy8t80</BetNo>"
						+"<BetMode>WEB_V3</BetMode>"
						+"</Betinfo>"
						+"</BetInfos>";
		//+"</string>";
		System.out.println(HGXML.substring(HGXML.indexOf("<BetInfos>"),HGXML.indexOf("</BetInfos>")));
		System.out.println(XmlUtils.parseXmlStr(HGXML));
		List<Map<String,String>> listMap = (List<Map<String,String>>)XmlUtils.parseXmlStr(HGXML).get("BetInfos");
		System.out.println(listMap.get(0).get("BetStartDate"));
		
		
		//dom4J解析
		/*try {
			String responseXml = "<?xml version=\"1.0\"?><response action=\"registration\"><element><properties name=\"username\">linkhg01</properties><properties name=\"ticket\">Tqz49j312h0qpm3</properties><properties name=\"status\">0</properties><properties name=\"errdesc\"></properties></element></response>";
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			// 由工厂创建一个DocumentBuilder解析器
			
			DocumentBuilder db = factory.newDocumentBuilder();
			// 创建一个Document对象
			org.w3c.dom.Document doc = XMLUtil.string2Doc(responseXml);
			// 获取所有节点
			NodeList nodes = doc.getChildNodes();
			// 获取根节点
			org.w3c.dom.Node root = nodes.item(0);
			System.out.println(root.getNodeName());
			// 获取根节点的所有子节点
			NodeList students = root.getChildNodes();
			for (int i = 0; i < students.getLength(); i++) {
			// 遍历获得根节点的子节点
			org.w3c.dom.Node student = students.item(i);
			System.out.println(student.getNodeName());
			// 获得根节点下子节点的所有子节点
			NodeList texts = student.getChildNodes();
			for (int j = 0; j < texts.getLength(); j++) {
			// 遍历根节点下子节点的子节点,并输出其文本内容
			org.w3c.dom.Node text = texts.item(j);
			System.out.println(text.getNodeName());
			System.out.println(text.getAttributes().getNamedItem("username"));
			System.out.println(text.getAttributes().getNamedItem("name").getNodeValue());
			System.out.println(text.getTextContent());
			if (text.getNodeName().equals("stuno")) {
			System.out.println("学号：" + text.getTextContent());
			} else if (text.getNodeName().equals("name")) {
			System.out.println("姓名:" + text.getTextContent());
			} else if (text.getNodeName().equals("sex")) {
			System.out.println("性别:" + text.getTextContent());
			} else if (text.getNodeName().equals("grade")) {
			System.out.println("班级:" + text.getTextContent());
			}
			}

			}
			} catch (Exception e) {
			e.printStackTrace();
			}*/
		
	}  
  
  
	/** 
	* 解析XML字符串 
	*  
	* @param xml 
	* @return 
	* @throws DocumentException 
	*/  
	public static Map<String, Object> parseXmlStr(String xml)  
	throws DocumentException {  
	Document document = DocumentHelper.parseText(xml);  
	Element root = document.getRootElement();  
	return parseElement(root);  
	}  
  
  
	/** 
	* 解析Element 
	*  
	* @param root 
	* @return 
	*/  
	@SuppressWarnings("unchecked")  
	public static Map<String, Object> parseElement(Element root) {  
		String rootName = root.getName();  
		Iterator<Element> rootItor = root.elementIterator();  
		Map<String, Object> rMap = new HashMap<>();  
		List<Map<String, Object>> rList = new ArrayList<>();  
		Map<String, Object> rsltMap = null;  
		while (rootItor.hasNext()) {  
		Element tmpElement = rootItor.next();  
		String name = tmpElement.getName();  
		if (rsltMap == null || (!HEAD.equals(name) && !BODY.equals(name)  
		&& !tmpElement.isTextOnly())) {  
		if (!HEAD.equals(name) && !BODY.equals(name)  
		&& !tmpElement.isTextOnly() && rsltMap != null) {  
			rList.add(rsltMap);  
		}  
			rsltMap = new HashMap<>();  
		}  
		if (!tmpElement.isTextOnly()) {  
			Iterator<Element> headItor = tmpElement.elementIterator();  
			while (headItor.hasNext()) {  
			Element hElement = headItor.next();  
		if (hElement.isTextOnly()) {  
			rsltMap.put(hElement.getName(), hElement.getTextTrim());  
		} else {  
			rsltMap.putAll(parseElement(hElement));  
		}  
		}  
		}  
		}  
		rList.add(rsltMap);  
		rMap.put(rootName, rList);  
		return rMap;  
	} 
}