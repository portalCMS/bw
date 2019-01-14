package com.hy.pull.common.util.api;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.hy.pull.common.util.MapUtil;
import com.hy.pull.common.util.MyX509TrustManager;
import com.maven.util.XMLUtil;
import com.maven.util.XmlUtils;

import net.sf.json.JSONObject;

/**
 *HG游戏对接接口
 * @author link
 */
public class RED365GameAPI implements BaseInterface {
	private Logger logger = LoggerFactory.getLogger(RED365GameAPI.class);
	private String apiUrl = "https://ag-webgame-staging.winroad168.com/api/wsv1_0/";
	private String loginUrl = "https://gamehg.5199bo.net/login/visitor/checkLoginGI.jsp?lang=en&ticketId=";
	private String agId = "";
	private String key = "";
	/**
	 * 默认构造函数
	 */
	@Deprecated
	public RED365GameAPI() {

	}

	/**
	 * 构建函数，初始化参数
	 * @param API_URL
	 * @param MD5_KEY  MD5密钥
	 */
	public RED365GameAPI(String apiUrl,String loginUrl,String key,String agId) {
		this.apiUrl = apiUrl;
		this.loginUrl = loginUrl;
		this.key = key;
		this.agId = agId;
	}
	/**
	 * 创建用户接口
	 * 
	 * @param entity
	 * 参数列表 username,password username 用户名 大于6小于20（建议加前缀） password 密码
	 * 大于6小于20
	 * @return 返回结果
	 */
	@SuppressWarnings("static-access")
	@Override
	public Object createAccount(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "createAccount", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "username,password")) {
				if (String.valueOf(entity.get("username")).length() > 20) {
					return Enum_MSG.参数错误.message("用户长度不能大于20位，当前" + String.valueOf(entity.get("username")).length())
							+ "位";
				}
				if (String.valueOf(entity.get("password")).length() > 20) {
					return Enum_MSG.参数错误.message("密码长度不能大于20位，当前" + String.valueOf(entity.get("password")).length())
							+ "位";
				}
				Map<String,String> pramsMap = new HashMap<String,String>();
				pramsMap.put("agid",this.agId);
				pramsMap.put("username",entity.get("username").toString());
				pramsMap.put("password",entity.get("password").toString());
				pramsMap.put("lang", "chs");
				String signature = SHA1(this.agId+entity.get("username").toString()+entity.get("password").toString()+this.key);
				pramsMap.put("signature", signature);
				logger.info("创建RED365请求参数：" + pramsMap);
				String responseStr = this.post(this.apiUrl+"user_register", pramsMap.toString());
				logger.info("创建RED365账号返回结果：" + responseStr.trim());
				JSONObject json = JSONObject.fromObject(responseStr);
				if(!"success".equals(json.getString("status"))){
					return Enum_MSG.失败.message(responseStr, "创建账号异常");
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
	 * 登录的接口
	 * @param entity
	 *参数列表 username 用户名 password 密码 lang 语言选择
	 * @return 返回结果
	 */
	@SuppressWarnings("static-access")
	@Override
	public Object login(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "login", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "username,password")) {
				if (String.valueOf(entity.get("username")).length() > 20) {
					return Enum_MSG.参数错误.message("用户长度不能大于20位，当前" + String.valueOf(entity.get("username")).length())
							+ "位";
				}
				if (String.valueOf(entity.get("password")).length() > 20) {
					return Enum_MSG.参数错误.message("密码长度不能大于20位，当前" + String.valueOf(entity.get("password")).length())
							+ "位";
				}
				Map<String,String> pramsMap = new HashMap<String,String>();
				pramsMap.put("agid",this.agId);
				pramsMap.put("username",entity.get("username").toString());
				pramsMap.put("password",entity.get("password").toString());
				pramsMap.put("lang", "chs");
				String signature = SHA1(this.agId+entity.get("username").toString()+entity.get("password").toString()+this.key);
				pramsMap.put("signature", signature);
				logger.info("创建RED365请求参数：" + pramsMap);
				String responseStr = this.post(this.apiUrl+"​user_login", pramsMap.toString());
				logger.info("创建RED365账号返回结果：" + responseStr.trim());
				JSONObject json = JSONObject.fromObject(responseStr);
				if(!"success".equals(json.getString("status"))){
					return Enum_MSG.失败.message(responseStr, "登陆账号异常");
				}
				String sessiongToke = json.getString("sessiongToke");
				return Enum_MSG.成功.message(this.loginUrl+sessiongToke);
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
	 * @param entity
	 * 参数列表 username username 用户名
	 * @return 返回结果
	 */
	@SuppressWarnings("static-access")
	@Override
	public Object deposit(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getBalance", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "username")) {
				String username = (String) entity.get("username");
				String amount = (String) entity.get("money");
				String orderid = (String) entity.get("billno");
				Map<String,String> pramsMap = new HashMap<String,String>();
				pramsMap.put("agid",this.agId);
				pramsMap.put("amount",amount);
				pramsMap.put("username",username);
				pramsMap.put("orderid",orderid);
				String signature = SHA1(this.agId+amount+username+orderid+this.key);
				pramsMap.put("signature", signature);
				logger.info("创建RED365请求参数：" + pramsMap);
				String responseStr = this.post(this.apiUrl+"​user_transfer", pramsMap.toString());
				logger.info("创建RED365账号返回结果：" + responseStr.trim());
				JSONObject json = JSONObject.fromObject(responseStr);
				if(!"success".equals(json.getString("status"))){
					return Enum_MSG.失败.message(responseStr, "上分异常");
				}
				return Enum_MSG.成功.message("上分成功");
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			return Enum_MSG.接口调用错误.message(ex.getMessage());
		}
	}
	@SuppressWarnings("static-access")
	public String depositConfirm(Map<String,String> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getBalance", entity.toString());
		String username = (String) entity.get("username");
		StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>");
		sb.append("<request action=\"deposit-confirm\">");
		sb.append("<element>");
		sb.append("<properties name=\"status\">0</properties>");
		sb.append("<properties name=\"paymentid\">%s</properties>");
		sb.append("<properties name=\"errdesc\"></properties>");
		sb.append("</element>");
		sb.append("</request>");
		String param = String.format(sb.toString(),entity.get("paymentid"));
		logger.info(username + "HG充值确认请求参数：" + param);
		String responseStr = this.post(this.apiUrl, param);
		logger.info("HG充值确认返回结果：" + responseStr);
		Map<String,String> responseMap = parseHGXmlToMap(responseStr);
		logger.info("HG充值确认解析结果****：" + responseMap);
		if (!"0".equals(responseMap.get("status"))) {
			return "false";
		}
		return "true";
	}
	
	/**
	 * 上分（存款）的接口
	 * @param entity
	 * 参数列表 username,money username 用户名 money 分数
	 * @return 返回结果 返回订单确认码，需要存储起来
	 */
	@SuppressWarnings("static-access")
	@Override
	public Object getBalance(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "deposit", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "username")) {
				String username = (String) entity.get("username");
				Map<String,String> pramsMap = new HashMap<String,String>();
				pramsMap.put("agid",this.agId);
				pramsMap.put("username",username);
				String signature = SHA1(this.agId+username+this.key);
				pramsMap.put("signature", signature);
				logger.info("创建RED365请求参数：" + pramsMap);
				String responseStr = this.post(this.apiUrl+"​​user_detail", pramsMap.toString());
				logger.info("创建RED365账号返回结果：" + responseStr.trim());
				JSONObject json = JSONObject.fromObject(responseStr);
				if(!"success".equals(json.getString("status"))){
					return Enum_MSG.失败.message(responseStr, "查询余额常");
				}
				return Enum_MSG.成功.message(json.get("balance"));
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
	 * @param entity
	 * 参数列表 username,money username 用户名 money 分数
	 * @return 返回结果 返回订单确认码，需要存储起来
	 */
	@SuppressWarnings("static-access")
	@Override
	public Object withdraw(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "withdraw", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "username,money")) {
				String username = (String) entity.get("username");
				String amount = (String) entity.get("money");
				String orderid = (String) entity.get("billno");
				Map<String,String> pramsMap = new HashMap<String,String>();
				pramsMap.put("agid",this.agId);
				pramsMap.put("amount",amount);
				pramsMap.put("username",username);
				pramsMap.put("orderid",orderid);
				String signature = SHA1(this.agId+amount+username+orderid+this.key);
				pramsMap.put("signature", signature);
				logger.info("创建RED365请求参数：" + pramsMap);
				String responseStr = this.post(this.apiUrl+"​user_transfer", pramsMap.toString());
				logger.info("创建RED365账号返回结果：" + responseStr.trim());
				JSONObject json = JSONObject.fromObject(responseStr);
				if(!"success".equals(json.getString("status"))){
					return Enum_MSG.失败.message(responseStr, "下分异常");
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
	@SuppressWarnings("static-access")
	public String withdrawConfirm(Map<String,String> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getBalance", entity.toString());
		String username = (String) entity.get("username");
		StringBuilder sb = new StringBuilder("<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>");
		sb.append("<request action=\"withdrawal-confirm\">");
		sb.append("<element>");
		sb.append("<properties name=\"status\">0</properties>");
		sb.append("<properties name=\"paymentid\">%s</properties>");
		sb.append("<properties name=\"errdesc\"></properties>");
		sb.append("</element>");
		sb.append("</request>");
		String param = String.format(sb.toString(),entity.get("paymentid"));
		logger.info(username + "HG充值确认请求参数：" + param);
		String responseStr = this.post(this.apiUrl, param);
		logger.info("HG充值确认返回结果：" + responseStr);
		Map<String,String> responseMap = parseHGXmlToMap(responseStr);
		logger.info("HG充值确认解析结果****：" + responseMap);
		if (!"0".equals(responseMap.get("status"))) {
			return "false";
		}
		return "true";
	}



	/**
	 *获取游戏结果
	 *@param entity
	 *参数列表
	 * @return 返回结果
	 */
	@Override
	public Object getRecord(Map<String, Object> entity) {
		return null;
	}

	/**
	 *更新信息接口
	 *@param entity
	 *参数列表 username,password,newpassword
	 * @return 返回结果
	 */
	@Override
	public Object updateInfo(Map<String, Object> entity) {
		return null;
	}

	/**
	 * 获取订单接口
	 * @param entity
	 *参数列表 orderid,type
	 *rderid=订单编号，上分或者下分时接口主动返回的单号
	 *type=上分或者下分类型，confirmdeposit=上分确认，confirmwithdraw=下分确认
	 * @return 返回结果 返回单号
	 */
	@Override
	public String getOrder(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "transferCreditConfirm", entity.toString());
		return "";
	}

	

	/**
	 * 是否在线接口
	 * @param entity
	 *  参数列表
	 * @return 返回结果
	 */
	@Override
	public Object isOnLine(Map<String, Object> entity) {
		return null;
	}
	public static Map<String,String> parseHGXmlToMap(String HGResponseXMl){
		Map<String,String> resultMap = new HashMap<String,String>();
		//String responseXml = "<?xml version=\"1.0\"?><response action=\"registration\"><element><properties name=\"username\">linkhg01</properties><properties name=\"ticket\">Tqz49j312h0qpm3</properties><properties name=\"status\">0</properties><properties name=\"errdesc\"></properties></element></response>";
		// 创建一个Document对象
		org.w3c.dom.Document doc = XMLUtil.string2Doc(HGResponseXMl.trim());
		// 获取所有节点
		NodeList nodes = doc.getChildNodes();
		// 获取根节点
		org.w3c.dom.Node root = nodes.item(0);
		//System.out.println(root.getNodeName());
		// 获取根节点的所有子节点
		NodeList students = root.getChildNodes();
		for (int i = 0; i < students.getLength(); i++) {
			// 遍历获得根节点的子节点
			org.w3c.dom.Node student = students.item(i);
			//System.out.println(student.getNodeName());
			// 获得根节点下子节点的所有子节点
			NodeList texts = student.getChildNodes();
			for (int j = 0; j < texts.getLength(); j++) {
				// 遍历根节点下子节点的子节点,并输出其文本内容
				org.w3c.dom.Node text = texts.item(j);
				String name = text.getAttributes().getNamedItem("name").getNodeValue();
				String nameValue = text.getTextContent();
				resultMap.put(name, nameValue);
			}														
		}
		return resultMap ;
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
	
	public static String httpsRequest(String requestUrl,String requestMethod,String outputStr){  
	    StringBuffer buffer=null;  
	    try{  
	    //创建SSLContext  
	    SSLContext sslContext=SSLContext.getInstance("SSL");  
	    TrustManager[] tm={new MyX509TrustManager()};  
	    //初始化  
	    sslContext.init(null, tm, new java.security.SecureRandom());;  
	    //获取SSLSocketFactory对象  
	    SSLSocketFactory ssf=sslContext.getSocketFactory();  
	    URL url=new URL(requestUrl);  
	    HttpsURLConnection conn=(HttpsURLConnection)url.openConnection();  
	    conn.setDoOutput(true);  
	    conn.setDoInput(true);  
	    conn.setUseCaches(false);  
	    conn.setRequestMethod(requestMethod);  
	    //设置当前实例使用的SSLSoctetFactory  
	    conn.setSSLSocketFactory(ssf);  
	    conn.connect();  
	    //往服务器端写内容  
	    if(null!=outputStr){  
	        OutputStream os=conn.getOutputStream();  
	        os.write(outputStr.getBytes("utf-8"));  
	        os.close();  
	    }  
	      
	    //读取服务器端返回的内容  
	    InputStream is=conn.getInputStream();  
	    InputStreamReader isr=new InputStreamReader(is,"utf-8");  
	    BufferedReader br=new BufferedReader(isr);  
	    buffer=new StringBuffer();  
	    String line=null;  
	    while((line=br.readLine())!=null){  
	        buffer.append(line);  
	    }  
	    }catch(Exception e){  
	        e.printStackTrace();  
	    }  
	    return buffer.toString();  
	} 
	public final static String SHA1(String decript) {
		try {
			MessageDigest digest = java.security.MessageDigest.getInstance("SHA-1");
			digest.update(decript.getBytes());
			byte messageDigest[] = digest.digest();
			// Create Hex String
			StringBuffer hexString = new StringBuffer();
			// 字节数组转换为 十六进制 数
			for (int i = 0; i < messageDigest.length; i++) {
				String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
				if (shaHex.length() < 2) {
					hexString.append(0);
				}
				hexString.append(shaHex);
			}
			return hexString.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
	}
	public static void main(String[] args) throws Exception {
		Map<String,String> pramsMap = new HashMap<String,String>();
		pramsMap.put("agid", "linkred02");
		pramsMap.put("username", "linkred01");
		pramsMap.put("password", "linkred01");
		pramsMap.put("lang", "chs");
		
		String params = "linkred01linkred01linkred01";
		String privateKey = "3c99070a9c487191c5b172e4b13d65f5a27e024e";
		String signature = SHA1(params+privateKey);
		pramsMap.put("signature", signature);
		String date = post("https://ag-webgame-staging.winroad168.com/api/wsv1_0/user_register",pramsMap.toString());
		System.out.println(date);
		String resopnse = "{\"status\":\"error\",\"error_code\":\"PARAM_INVALID agid\"}";
	}
}
