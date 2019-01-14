package com.hy.pull.common.util.api;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;

import com.hy.pull.common.util.AESUtil2Net;
import com.hy.pull.common.util.MapUtil;
import com.maven.game.enums.GameEnum;
import com.maven.util.HttpClientUtil;
import com.maven.util.RandomString;
import com.maven.util.XMLUtil;

/**
 * 易胜博体育游戏接口
 * 
 * @author temdy
 */
public class YSBGameAPI implements BaseInterface {
	private Logger logger = LoggerFactory.getLogger(YSBGameAPI.class);
	//https://tp-login.webbridge.net/XMLExchange.aspx
	//	http://testagent.a1sport88.com/		
	//	play8admin		
	//	123456		

	private String API_URL = "http://testsportapi.a1sport88.com/XMLExchange.aspx";
	private String THIRD_PARTY_ID = "51BW";
	private String VENDOR_ID = "51BW";
	private String LOGIN_WEB_GAME_URL = "http://testsport.a1sport88.com/login.aspx";
	private String LOGIN_MOBILE_GAME_URL = "http://mwhitelabel.a1go.org/login.aspx";

	private String xmlElement = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";

	/**
	 * 默认构造函数
	 */
	@Deprecated
	public YSBGameAPI() {

	}

	/**
	 * 构建函数，初始化参数
	 * 
	 * @param API_URL
	 *            API接口URL
	 * @param MD5_KEY
	 *            MD5密钥
	 */
	public YSBGameAPI(String API_URL, String THIRD_PARTY_ID, String VENDOR_ID, String LOGIN_WEB_GAME_URL,
			String LOGIN_MOBILE_GAME_URL) {
		this.API_URL = API_URL;
		this.THIRD_PARTY_ID = THIRD_PARTY_ID;
		this.VENDOR_ID = VENDOR_ID;
		this.LOGIN_WEB_GAME_URL = LOGIN_WEB_GAME_URL;
		this.LOGIN_MOBILE_GAME_URL = LOGIN_MOBILE_GAME_URL;
	}

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
		return Enum_MSG.成功.message("账号创建成功");
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
				String username = (String) entity.get("username");
				String url = this.API_URL + "?TrancType=1&ThirdPartyID=" + this.THIRD_PARTY_ID;
				logger.info("请求地址："+url);
				StringBuilder data = new StringBuilder(xmlElement);
				data.append("<request action=\"EBaccountbalance\">");
				data.append("<element id=\"id001\">");
				data.append("<properties name=\"UN\">%s</properties>"); // Prefix
																		// _xxxxx
				data.append("<properties name=\"SN\">%s</properties>");
				data.append("</element>");
				data.append("</request>");
				String param = String.format(data.toString(), entity.get("username"),
						RandomString.createRandomString(10));
				logger.info(username + "查询YSB余额请求参数：" + param);
				if(url.startsWith("https")){
					param =HttpClientUtil.doPost(url, null, param);
				}else{
					param = this.post(url, param);
				}
				logger.info(username + "查询YSB余额返回结果：" + param);
				Document doc = XMLUtil.string2Doc(param.toString());
				String status = doc.getDocumentElement().getElementsByTagName("properties").item(0).getTextContent();
				if ("0".equals(status)) {
					return Enum_MSG.成功.message(doc.getElementsByTagName("properties").item(3).getTextContent());
				}
				return Enum_MSG.参数错误.message(Enum_MSG.系统错误.desc);
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
				if (Double.valueOf(entity.get("money").toString()) < 1.0) {
					return Enum_MSG.参数错误.message("取款金额不能小于1元");
				}
				String username = (String) entity.get("username");
				String url = this.API_URL + "?TrancType=4&ThirdPartyID=" + this.THIRD_PARTY_ID;
				logger.info("请求地址："+url);
				StringBuilder data = new StringBuilder(xmlElement);
				data.append("<request action=\"EBwithdrawal\">");
				data.append("<element id=\"id001\">");
				data.append("<properties name=\"UID\">%s</properties>");
				data.append("<properties name=\"UN\">%s</properties>");// Prefix
																		// _xxxxx
				data.append("<properties name=\"SN\">%s</properties>");
				data.append("<properties name=\"VID\">%s</properties>");
				data.append("<properties name=\"CI\">RMB</properties>");
				data.append("<properties name=\"LI\">1</properties>");
				data.append("<properties name=\"AMT\">%s</properties>");
				data.append("<properties name=\"RN\">%s</properties>");
				data.append("</element>");
				data.append("</request>");
				String param = String.format(data.toString(), entity.get("uid"), username, entity.get("billno"),
						this.VENDOR_ID, entity.get("money"), RandomString.createRandomString(20));
				logger.info(username + "转出YSB请求参数：" + param);
				if(url.startsWith("https")){
					param =HttpClientUtil.doPost(url, null, param);
				}else{
					param = this.post(url, param);
				}
				logger.info(username + "转出YSB返回结果：" + param);

				Document doc = XMLUtil.string2Doc(param);
				String status = doc.getDocumentElement().getElementsByTagName("properties").item(0).getTextContent();
				if (!"0".equals(status)) {
					return Enum_MSG.失败.message(status, "下分异常");
				}
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
				String username = (String) entity.get("username");
				String url = this.API_URL + "?TrancType=2&ThirdPartyID=" + this.THIRD_PARTY_ID;
				logger.info("请求地址："+url);
				StringBuilder data = new StringBuilder(xmlElement);
				data.append("<request action=\"EBdeposit\">");
				data.append("<element id=\"id001\">");
				data.append("<properties name=\"UID\">%s</properties>");
				data.append("<properties name=\"UN\">%s</properties>");// Prefix
																		// _xxxxx
				data.append("<properties name=\"SN\">%s</properties>");
				data.append("<properties name=\"VID\">%s</properties>");
				data.append("<properties name=\"CI\">RMB</properties>");
				data.append("<properties name=\"LI\">1</properties>");
				data.append("<properties name=\"AMT\">%s</properties>");
				data.append("<properties name=\"RN\">%s</properties>");
				data.append("</element>");
				data.append("</request>");
				String param = String.format(data.toString(), entity.get("uid"), username, entity.get("billno"),
						this.VENDOR_ID, entity.get("money"), entity.get("billno"));
				logger.info(username + "转入YSB请求参数：" + param);
				if(url.startsWith("https")){
					param =HttpClientUtil.doPost(url, null, param);
				}else{
					param = this.post(url, param);
				}
				logger.info(username + "转入YSB返回结果：" + param);
				Document doc = XMLUtil.string2Doc(param);
				String status = doc.getDocumentElement().getElementsByTagName("properties").item(0).getTextContent();
				String paymentId = doc.getDocumentElement().getElementsByTagName("properties").item(3).getTextContent();
				if (!"0".equals(status)) {
					return Enum_MSG.失败.message(status, "上分异常");
				}
				entity.put("paymentId", paymentId);
				entity.put("status", status);
				this.getOrder(entity);
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
	public Object getOrder(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "transferCreditConfirm", entity.toString());
		String url = API_URL + "?TrancType=3&ThirdPartyID=" + this.THIRD_PARTY_ID;
		logger.info("请求地址："+url);
		StringBuilder data = new StringBuilder(xmlElement);
		data.append("<response action=\"EBdepositConfirm\">");
		data.append("<element id=\"id001\">");
		data.append("<properties name=\"UN\">%s</properties>"); // Prefix _xxxxx
		data.append("<properties name=\"ST\">%s</properties>");
		data.append("<properties name=\"SN\">%s</properties>");
		data.append("<properties name=\"PI\">%s</properties>");
		data.append("<properties name=\"ED\">RMB</properties>");
		data.append("</element>");
		data.append("</response>");
		String param = String.format(data.toString(), entity.get("username"), entity.get("status"),
				entity.get("billno"), entity.get("paymentId"));
		logger.info(entity.get("username") + "转入YSB确认转入回复参数：" + param);
		if(url.startsWith("https")){
			param =HttpClientUtil.doPost(url, null, param);
		}else{
			param = this.post(url, param);
		}
		logger.info(entity.get("username") + "转入YSB确认转入回复结果：" + param);
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
			if (MapUtil.isNulls(entity, "username,password,deviceType")) {
				logger.info("登录YSB请求参数："+entity.toString());
				// username+(password)employeecode
				String sign = AESUtil2Net.encryptAES(String.valueOf(entity.get("username"))+","+entity.get("password").toString(),AESUtil2Net.key,AESUtil2Net.iv);
				sign =AESUtil2Net.parseByte2HexStr(sign.getBytes("utf-8"));
				String domain = this.LOGIN_WEB_GAME_URL;
				if (String.valueOf(entity.get("deviceType")).equals(GameEnum.Enum_deviceType.手机.code)) {
					domain = this.LOGIN_MOBILE_GAME_URL;
				}
				String loginUrl = domain + "?username=" + entity.get("username") + "&langcode=zh-cn&sign=" + sign
						+ "&v=" + this.VENDOR_ID;
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

	public static void main(String[] args) throws Exception {
//		String str = "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?><methodResponse><params><param><value><struct><member><name>Link</name><value><string>123</string></value></member></struct></value></param></params></methodResponse>";
//		str = "<methodResponse><params><param><value><struct> <member><name>Link</name><value><string>http://www.play8.asia/client?YTo5OntzOjQ6InNpdGUiO3M6MjE6Imh0dHA6Ly93d3cucGxheTguYXNpYSI7czo0OiJmdW5kIjtzOjIxOiJodHRwOi8vd3d3LnBsYXk4LmFzaWEiO3M6Nzoic2Vzc2lvbiI7czozMToiRTg2eVB4QmJJVUphMzBMT3RhcEFoUXVvNjdtUm9BZyI7czoyOiJpcCI7czoxMDoiMTI3LjAuMTAuMSI7czo0OiJwb3J0IjtzOjQ6IjMxMjgiO3M6NDoibGFuZyI7czoyOiJTQyI7czoxMToiY29tcGV0aXRpb24iO047czoxNToiY29tcGV0aXRpb25UeXBlIjtOO3M6MTM6ImNvbXBldGl0aW9uSWQiO047fQ%3D%3D</string></value></member></struct></value></param></params></methodResponse>";
//		str = "<methodResponse>";
//		str += "<params>";
//		str += " <param>";
//		str += " <value>";
//		str += "   <struct>";
//		str += "    <member>";
//		str += "    <name>FundIntegrationId</name>";
//		str += "     <value>";
//		str += "      <string>345874</string>";
//		str += "     </value>";
//		str += "  </member>";
//		str += "  </struct>";
//		str += "  </value>";
//		str += "  </param>";
//		str += " </params>";
//		str += " </methodResponse>";
//		Document doc = XMLUtil.string2Doc(str.toString());
//		str = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(1).getTextContent()
//				.trim();
//		System.out.println(str);
//		str = doc.getDocumentElement().getElementsByTagName("member").item(0).getChildNodes().item(3).getTextContent()
//				.trim();
//		System.out.println(str);
		
		//System.out.println(AESUtil2Net.encryptAES("DFH_testelon19,E000K4N3",AESUtil2Net.key,AESUtil2Net.iv));
		
		System.out.println(AESUtil2Net.decryptAES("Me0OtiZQaSPD0WdBHc0B4dM eh68MWvSCplyjtrnBRo=",AESUtil2Net.key,AESUtil2Net.iv));
	}

	@SuppressWarnings("deprecation")
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
}
