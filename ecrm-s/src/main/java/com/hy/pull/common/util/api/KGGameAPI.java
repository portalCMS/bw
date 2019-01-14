package com.hy.pull.common.util.api;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;

import com.hy.pull.common.util.MapUtil;
import com.maven.util.XMLUtil;

/**
 * 开元游戏接口
 * 
 * @author temdy
 */
public class KGGameAPI implements BaseInterface {
	private Logger logger = LoggerFactory.getLogger(KGGameAPI.class);

	private String apiUrl = "http://api.ky34.com/channelHandle";
	private String apiKey = "http://api.ky34.com/channelHandle";
	private String vendorSite = "http://api.ky34.com/channelHandle";
	private String fundLink = "http://api.ky34.com/channelHandle";
	private String vendorId = "";
	
	/**
	 * 默认构造函数
	 */
	@Deprecated
	public KGGameAPI() {

	}

	/**
	 * 构建函数，初始化参数
	 * 
	 * @param API_URL
	 *            API接口URL
	 * @param MD5_KEY
	 *            MD5密钥
	 */
	public KGGameAPI(String apiUrl,String vendorId, String apiKey, String vendorSite, String fundLink
			) {
		this.apiUrl = apiUrl;
		this.apiKey = apiKey;
		this.vendorSite = vendorSite;
		this.fundLink = fundLink;
		this.vendorId = vendorId;
	}

	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
	private SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmmssSSS");// 设置日期格式

	/**
	 * 创建用户接口
	 * 
	 * @param entity
	 *            参数列表 username,password username 用户名 大于6小于20（建议加前缀） password 密码
	 *            大于6小于20
	 * @return 返回结果
	 */
	@Override
	public Object createAccount(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "createAccount", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "userName,userId")) {
				if (String.valueOf(entity.get("username")).length() > 20) {
					return Enum_MSG.参数错误.message("用户长度不能大于20位，当前" + String.valueOf(entity.get("username")).length())
							+ "位";
				}
				if (String.valueOf(entity.get("password")).length() > 20) {
					return Enum_MSG.参数错误.message("密码长度不能大于20位，当前" + String.valueOf(entity.get("password")).length())
							+ "位";
				}

				String userName = (String) entity.get("userName");
				StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>");
				sb.append("<methodCall>");
				sb.append("<methodName>PlayerLanding</methodName>");
				sb.append("<params>");
				sb.append("<param>");
				sb.append("<value>");
				sb.append("<struct>");
				sb.append("<member><name>VendorSite</name><value><string>%s</string></value></member>");
				sb.append("<member><name>FundLink</name><value><string>%s</string></value></member>");
				sb.append("<member><name>VendorId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerRealName</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerCurrency</name><value><string>C01</string></value></member>");//c01  货币类型
				sb.append("<member><name>PlayerCredit</name><value><string>0</string></value></member>");
				sb.append("<member><name>PlayerAllowStake</name><value><string>%s</string></value></member>");
				sb.append("<member><name>Trial</name><value><string>0</string></value></member>");
				sb.append("<member><name>GameType</name><value><string>%s</string></value></member>");
				sb.append("<member><name>Language</name><value><string>SC</string></value></member>");
				sb.append("<member><name>APIKey</name><value><string>%s</string></value></member>");
				sb.append("<member><name>RebateLevel</name><value><string>1</string></value></member>");
				sb.append("<member><name>PlayerIP</name><value><string>%s</string></value></member>");
				sb.append("<member><name>EditPassword</name><value><string>0</string></value></member>");
				sb.append("</struct>");
				sb.append("</value>");
				sb.append("</param>");
				sb.append("</params>");
				sb.append("</methodCall>");
				String param = String.format(sb.toString(),this.vendorSite, this.fundLink, this.vendorId,
						entity.get("userId"), entity.get("userName"), "1,2,3", entity.get("gameType"), this.apiKey,
						entity.get("loginIp"));
				logger.info(userName + "创建KG账号请求参数：" + param);
				param = this.post(this.apiUrl + "/player_enter_keno.php", param);
				logger.info(userName + "创建KG账号返回结果：" + param);

				Document doc = XMLUtil.string2Doc(param.toString());
				param = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1)
						.getTextContent();
				if ("Error".equals(param)) {
					return Enum_MSG.失败.message(param, "创建账号异常");
				}
				return Enum_MSG.成功.message("创建账号成功");
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			return Enum_MSG.接口调用错误.message(ex.getMessage());
		}
	}

	/**
	 * 获取余额
	 * 
	 * @param entity
	 *            参数列表 username username 用户名
	 * @return 返回结果
	 */
	@Override
	public Object getBalance(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getBalance", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "username")) {

				String userName = (String) entity.get("username");
				StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>");
				sb.append("<methodCall>");
				sb.append("<methodName>GetCredit</methodName>");
				sb.append("<params>");
				sb.append("<param>");
				sb.append("<value>");
				sb.append("<struct>");
				sb.append("<member><name>VendorId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerId</name><value><string>%s</string></value></member>");
				sb.append("</struct>");
				sb.append("</value>");
				sb.append("</param>");
				sb.append("</params>");
				sb.append("</methodCall>");
				String param = String.format(sb.toString(), this.vendorId, userName);
				logger.info(userName + "查询KG请求参数：" + param);
				param = this.post(this.apiUrl + "/player_get_credit.php", param);
				logger.info(userName + "查询KG返回结果：" + param);
				Document doc = XMLUtil.string2Doc(param.toString());
				param = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1)
						.getTextContent().trim();
				if ("Error".equals(param)) {
					return Enum_MSG.失败.message(param, "查询余额异常");
				}
				return Enum_MSG.成功.message(doc.getDocumentElement().getElementsByTagName("member").item(0)
						.getChildNodes().item(3).getTextContent().trim());

			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			return Enum_MSG.接口调用错误.message(ex.getMessage());
		}
	}

	/**
	 * 下分（取款）的接口
	 * 
	 * @param entity
	 *            参数列表 username,money username 用户名 money 分数
	 * @return 返回结果 返回订单确认码，需要存储起来
	 */
	@Override
	public Object withdraw(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "withdraw", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "username,money")) {

				String userName = (String) entity.get("username");
				entity.put("money", 0-Double.valueOf(entity.get("money").toString()));
				StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>");
				sb.append("<methodCall>");
				sb.append("<methodName>FundInOutFirst</methodName>");
				sb.append("<params>");
				sb.append("<param>");
				sb.append("<value>");
				sb.append("<struct>");
				sb.append("<member><name>VendorId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>Amount</name><value><string>%s</string></value></member>");
				sb.append("</struct>");
				sb.append("</value>");
				sb.append("</param>");
				sb.append("</params>");
				sb.append("</methodCall>");
				String param = String.format(sb.toString(), this.vendorId, userName, entity.get("money"));
				logger.info(userName + "转出KG请求参数：" + param);
				param = this.post(this.apiUrl + "/player_fund_in_out_first.php", param);
				logger.info(userName + "转出KG返回结果：" + param);
				
				
				Document doc = XMLUtil.string2Doc(param);
				String fundIntegrationId = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1).getTextContent()
						.trim();
				if (!"FundIntegrationId".equals(fundIntegrationId)) {
					return Enum_MSG.失败.message(fundIntegrationId, "上分异常");
				}
				String fundIntegrationIdValue = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(3)
						.getTextContent().trim();
				entity.put("fundIntegrationId", fundIntegrationIdValue);
				entity.put("loginIp", "130.105.204.162");
				System.out.println("229fundIntegrationIdValue:"+fundIntegrationIdValue);
				System.out.println("entity:"+entity);
				String getOrderResult = this.getOrder(entity);
				System.out.println("231");
				if("false".equals(getOrderResult)){
					return Enum_MSG.失败.message(getOrderResult, "上分异常");
				}
				
				/*Document doc = XMLUtil.string2Doc(param.toString());

				String data = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1)
						.getTextContent().trim();
				if (!"FundIntegrationId".equals(data)) {
					return Enum_MSG.失败.message(data, "下分异常");
				}
				data = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(3)
						.getTextContent().trim();
				entity.put("fundIntegrationId", data);
				entity.put("amount", (0 - Double.valueOf(entity.get("money") + "")));
				data = this.getOrder(entity) + "";
				doc = XMLUtil.string2Doc(data);
				data = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1)
						.getTextContent().trim();
				if (!"Remain".equals(data)) {
					return Enum_MSG.失败.message(data, "下分异常");
				}

				if (Double.valueOf(entity.get("money").toString()) < 1.0) {
					return Enum_MSG.参数错误.message("取款金额不能小于1元");
				}*/
				return Enum_MSG.成功.message("下分成功");
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			return Enum_MSG.接口调用错误.message(ex.getMessage());
		}
	}

	/**
	 * 上分（存款）的接口
	 * 
	 * @param entity
	 *            参数列表 username,money username 用户名 money 分数
	 * @return 返回结果 返回订单确认码，需要存储起来
	 */
	@Override
	public Object deposit(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "deposit", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "username,money")) {
				String userName = (String) entity.get("username");
				StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>");
				sb.append("<methodCall>");
				sb.append("<methodName>FundInOutFirst</methodName>");
				sb.append("<params>");
				sb.append("<param>");
				sb.append("<value>");
				sb.append("<struct>");
				sb.append("<member><name>VendorId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>Amount</name><value><string>%s</string></value></member>");
				sb.append("</struct>");
				sb.append("</value>");
				sb.append("</param>");
				sb.append("</params>");
				sb.append("</methodCall>");
				String param = String.format(sb.toString(), this.vendorId, userName, entity.get("money"));
				logger.info(userName + "转入KG请求参数：" + param);
				param = this.post(this.apiUrl + "/player_fund_in_out_first.php", param);
				logger.info(userName + "转入KG返回结果：" + param);		
				Document doc = XMLUtil.string2Doc(param);
				String fundIntegrationId = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1).getTextContent()
						.trim();
				if (!"FundIntegrationId".equals(fundIntegrationId)) {
					return Enum_MSG.失败.message(fundIntegrationId, "上分异常");
				}
				String fundIntegrationIdValue = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(3)
						.getTextContent().trim();
				entity.put("fundIntegrationId", fundIntegrationIdValue);
				entity.put("amount", entity.get("money"));
				System.out.println("296");
				String getOrderResult = this.getOrder(entity);
				System.out.println("298");
				if("false".equals(getOrderResult)){
					return Enum_MSG.失败.message(getOrderResult, "上分异常");
				}
			/*	System.out.println("302");
				doc = XMLUtil.string2Doc(getOrderResult);
				System.out.println("304");
				String  remain = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1)
						.getTextContent().trim();
				System.out.println("307");
				if (!"Remain".equals(remain)) {
					return Enum_MSG.失败.message(remain, "上分异常");
				}*/
				return Enum_MSG.成功.message("上分成功");
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			return Enum_MSG.接口调用错误.message(ex.getMessage());
		}

	}

	/**
	 * 获取游戏结果
	 * 
	 * @param entity
	 *            参数列表
	 * @return 返回结果
	 */
	@Override
	public Object getRecord(Map<String, Object> entity) {
		return null;
	}

	/**
	 * 更新信息接口
	 * 
	 * @param entity
	 *            参数列表 username,password,newpassword
	 * @return 返回结果
	 */
	@Override
	public Object updateInfo(Map<String, Object> entity) {
		return null;
	}

	/**
	 * 获取订单接口
	 * 
	 * @param entity
	 *            参数列表 orderid,type
	 * 
	 *            orderid=订单编号，上分或者下分时接口主动返回的单号
	 *            type=上分或者下分类型，confirmdeposit=上分确认，confirmwithdraw=下分确认
	 * 
	 * @return 返回结果 返回单号
	 */
	@Override
	public String getOrder(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "transferCreditConfirm", entity.toString());
				String userName = (String) entity.get("username");
				StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>");
				sb.append("<methodCall>");
				sb.append("<methodName>FundInOutConfirm</methodName>");
				sb.append("<params>");
				sb.append("<param>");
				sb.append("<value>");
				sb.append("<struct>");
				sb.append("<member><name>VendorId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>Amount</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerIP</name><value><string>%s</string></value></member>");
				sb.append("<member><name>FundIntegrationId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>VendorRef</name><value><string>%s</string></value></member>");
				sb.append("</struct>");
				sb.append("</value>");
				sb.append("</param>");
				sb.append("</params>");
				sb.append("</methodCall>");
				String param = String.format(sb.toString(), this.vendorId, userName, entity.get("money"),
						entity.get("loginIp"), entity.get("fundIntegrationId"), entity.get("billno"));
				logger.info(userName + "确认转账KG请求参数：" + param);
				System.out.println(userName + "sys确认转账KG请求参数：" + param);
				param = this.post(this.apiUrl + "/player_fund_in_out_confirm.php", param);
				logger.info(userName + "确认转账KG返回结果：" + param);
				System.out.println(userName + "sys确认转账KG返回结果：" + param);
				Document doc = XMLUtil.string2Doc(param);
				param = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1)
						.getTextContent().trim();
				if (!"Remain".equals(param)) {
					return "false";
				}
				return param;
	}

	/**
	 * 登录的接口
	 * 
	 * @param entity
	 *            参数列表 username 用户名 password 密码 lang 语言选择
	 * @return 返回结果
	 */
	@Override
	public Object login(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "login", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "userName,userId")) {
				if (String.valueOf(entity.get("username")).length() > 20) {
					return Enum_MSG.参数错误.message("用户长度不能大于20位，当前" + String.valueOf(entity.get("username")).length())
							+ "位";
				}
				if (String.valueOf(entity.get("password")).length() > 20) {
					return Enum_MSG.参数错误.message("密码长度不能大于20位，当前" + String.valueOf(entity.get("password")).length())
							+ "位";
				}

				String userName = (String) entity.get("userName");
				StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>");
				sb.append("<methodCall>");
				sb.append("<methodName>PlayerLanding</methodName>");
				sb.append("<params>");
				sb.append("<param>");
				sb.append("<value>");
				sb.append("<struct>");
				sb.append("<member><name>VendorSite</name><value><string>%s</string></value></member>");
				sb.append("<member><name>FundLink</name><value><string>%s</string></value></member>");
				sb.append("<member><name>VendorId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerRealName</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerCurrency</name><value><string>C01</string></value></member>");//c01  货币类型
				sb.append("<member><name>PlayerCredit</name><value><string>0</string></value></member>");
				sb.append("<member><name>PlayerAllowStake</name><value><string>%s</string></value></member>");
				sb.append("<member><name>Trial</name><value><string>0</string></value></member>");
				sb.append("<member><name>GameType</name><value><string>%s</string></value></member>");
				sb.append("<member><name>Language</name><value><string>SC</string></value></member>");
				sb.append("<member><name>APIKey</name><value><string>%s</string></value></member>");
				sb.append("<member><name>RebateLevel</name><value><string>1</string></value></member>");
				sb.append("<member><name>PlayerIP</name><value><string>%s</string></value></member>");
				sb.append("<member><name>EditPassword</name><value><string>0</string></value></member>");
				sb.append("</struct>");
				sb.append("</value>");
				sb.append("</param>");
				sb.append("</params>");
				sb.append("</methodCall>");
				String param = String.format(sb.toString(),this.vendorSite, this.fundLink, this.vendorId,
						entity.get("userId"), entity.get("userName"), "1,2,3", entity.get("gameType"), this.apiKey,
						entity.get("loginIp"));
				logger.info(userName + "创建KG账号请求参数：" + param);
				param = this.post(this.apiUrl + "/player_enter_keno.php", param);
				logger.info(userName + "创建KG账号返回结果：" + param);

				Document doc = XMLUtil.string2Doc(param.toString());
				param = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1)
						.getTextContent();
				
				String loginUrl =  doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(3).getTextContent().trim();
				if ("Error".equals(param)) {
					return Enum_MSG.失败.message(param, "登陆账号异常");
				}
				return Enum_MSG.成功.message(loginUrl);
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			return Enum_MSG.接口调用错误.message(ex.getMessage());
		}
	}

	/**
	 * 是否在线接口
	 * 
	 * @param entity
	 *            参数列表
	 * @return 返回结果
	 */
	@Override
	public Object isOnLine(Map<String, Object> entity) {
		// TODO Auto-generated method stub
		return null;
	}

	public static String post(String url, String xmlString) {
		// 关闭
		System.setProperty("org.apache.commons.logging.Log", "org.apache.commons.logging.impl.SimpleLog");
		System.setProperty("org.apache.commons.logging.simplelog.showdatetime", "true");
		System.setProperty("org.apache.commons.logging.simplelog.log.org.apache.commons.httpclient", "stdout");

		// 创建httpclient工具对象
		HttpClient client = new HttpClient();
		// 创建post请求方法
		PostMethod myPost = new PostMethod(url);
		// 设置请求超时时间
		client.setConnectionTimeout(300 * 1000);
		String responseString = null;
		try {
			// 设置请求头部类型
			myPost.setRequestHeader("Content-Type", "text/xml");
			myPost.setRequestHeader("charset", "utf-8");

			// 设置请求体，即xml文本内容，注：这里写了两种方式，一种是直接获取xml内容字符串，一种是读取xml文件以流的形式
			myPost.setRequestBody(xmlString);

			// InputStream
			// body=this.getClass().getResourceAsStream("/"+xmlFileName);
			// myPost.setRequestBody(body);
			// myPost.setRequestEntity(new
			// StringRequestEntity(xmlString,"text/xml","utf-8"));
			int statusCode = client.executeMethod(myPost);
			if (statusCode == HttpStatus.SC_OK) {
				BufferedInputStream bis = new BufferedInputStream(myPost.getResponseBodyAsStream());
				byte[] bytes = new byte[1024];
				ByteArrayOutputStream bos = new ByteArrayOutputStream();
				int count = 0;
				while ((count = bis.read(bytes)) != -1) {
					bos.write(bytes, 0, count);
				}
				byte[] strByte = bos.toByteArray();
				responseString = new String(strByte, 0, strByte.length, "utf-8");
				bos.close();
				bis.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		myPost.releaseConnection();
		return responseString;
	}

	public static void main(String[] args) throws Exception {
	
				/*StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>");
				sb.append("<methodCall>");
				sb.append("<methodName>PlayerLanding</methodName>");
				sb.append("<params>");
				sb.append("<param>");
				sb.append("<value>");
				sb.append("<struct>");
				sb.append("<member><name>VendorSite</name><value><string>%s</string></value></member>");
				sb.append("<member><name>FundLink</name><value><string>%s</string></value></member>");
				sb.append("<member><name>VendorId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerId</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerRealName</name><value><string>%s</string></value></member>");
				sb.append("<member><name>PlayerCurrency</name><value><string>C01</string></value></member>");//c01  货币类型
				sb.append("<member><name>PlayerCredit</name><value><string>0</string></value></member>");
				sb.append("<member><name>PlayerAllowStake</name><value><string>%s</string></value></member>");
				sb.append("<member><name>Trial</name><value><string>0</string></value></member>");
				sb.append("<member><name>GameType</name><value><string>%s</string></value></member>");
				sb.append("<member><name>Language</name><value><string>SC</string></value></member>");
				sb.append("<member><name>APIKey</name><value><string></string></value></member>");
				sb.append("<member><name>RebateLevel</name><value><string>1</string></value></member>");
				sb.append("<member><name>PlayerIP</name><value><string>%s</string></value></member>");
				sb.append("<member><name>EditPassword</name><value><string>0</string></value></member>");
				sb.append("</struct>");
				sb.append("</value>");
				sb.append("</param>");
				sb.append("</params>");
				sb.append("</methodCall>");
				String param = String.format(sb.toString(),"http://gate.51baowang.net", "http://gate.51baowang.net", "264",
						"linkkg01","linkkg01", "1,2,3","0", "130.105.220.82");
				param = post(" http://integrate2.v88kgg.com/player_enter_keno.php", param);
				System.out.println("创建KG账号返回结果：" + param);

				Document doc = XMLUtil.string2Doc(param.toString());
				param = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1)
						.getTextContent();
		*/
		
		
		
		
		
		
		
		String str = "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?><methodResponse><params><param><value><struct>"
				+ "<member><name>Link</name><value><string>123</string></value></member></struct></value></param></params></methodResponse>";
		str = "<methodResponse><params><param><value><struct> <member><name>Link</name><value>"
				+ "<string>http://www.play8.asia/client?YTo5OntzOjQ6InNpdGUiO3M6MjE6Imh0dHA6Ly93d3cucGxheTguYXNpYSI7czo0OiJmdW5kIjtzOjIxOiJodHRwOi8vd3d3LnBsYXk4LmFzaWEiO3M6Nzoic2Vzc2lvbiI7czozMToiRTg2eVB4QmJJVUphMzBMT3RhcEFoUXVvNjdtUm9BZyI7czoyOiJpcCI7czoxMDoiMTI3LjAuMTAuMSI7czo0OiJwb3J0IjtzOjQ6IjMxMjgiO3M6NDoibGFuZyI7czoyOiJTQyI7czoxMToiY29tcGV0aXRpb24iO047czoxNToiY29tcGV0aXRpb25UeXBlIjtOO3M6MTM6ImNvbXBldGl0aW9uSWQiO047fQ%3D%3D</string></value></member></struct></value></param></params></methodResponse>";
		str = "<methodResponse>";
		str += "<params>";
		str += " <param>";
		str += " <value>";
		str += "   <struct>";
		str += "    <member>";
		str += "    <name>FundIntegrationId</name>";
		str += "     <value>";
		str += "      <string>345874</string>";
		str += "     </value>";
		str += "  </member>";
		str += "  </struct>";
		str += "  </value>";
		str += "  </param>";
		str += " </params>";
		str += " </methodResponse>";
		Document doc = XMLUtil.string2Doc(str.toString());
		str = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1).getTextContent()
				.trim();
		System.out.println(str);
		str = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(3).getTextContent()
				.trim();
		System.out.println(str);
		
		
		
		
		String ramin = "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>"
					+"<methodResponse>"
					+"<params>"
					+"<param>"
					+" <value>"
					+"  <struct>"
					+"   <member>"
					+"    <name>Remain</name>"
					+"    <value>"
					+"    <double>182</double>"
					+"    </value>"
					+"   </member>"
					+"  </struct>"
					+"  </value>"
					+" </param>"
					+"</params>"
					+"</methodResponse>";
		
		Document docramin = XMLUtil.string2Doc(ramin);
		String raminValue = docramin.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1)
				.getTextContent().trim();
		System.out.println(raminValue);

	}
}
