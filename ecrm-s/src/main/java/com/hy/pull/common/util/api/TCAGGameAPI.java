package com.hy.pull.common.util.api;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hy.pull.common.util.MapUtil;
import com.hy.pull.common.util.SHA256Util;
import com.hy.pull.common.util.YoPlayDESEncrypt;

import net.sf.json.JSONObject;

/**
 * 天成AG游戏接口
 * 
 * @author admin
 *
 */
public class TCAGGameAPI implements BaseInterface {
	private Logger logger = LoggerFactory.getLogger(TCAGGameAPI.class);

	private String api_url = "http://www.connect4play.com/doBusiness.do";
	private String des_key = "D13snPFM";
	private String sha256_key = "yl2fORtI54F5RDMi";
	private String agent = "japlay8";
	private Integer productType = 4;

	private String game_api_url = "http://api.hyzonghe.net/";// 游戏使用的域名。代替api.hyzonghe.net

	// 0 成功
	// 1 未知的系统错误，请联系 TCG 客服
	// 2 缺少必需的参数
	// 3 此产品类型不支持此方法
	// 4 商家不允许使用此产品类型
	// 5 找不到商家
	// 6 参数无效，无法解密参数
	// 7签名无效
	// 8不支持的货币
	// 9帐户类型无效
	// 10产品类型无效
	// 11提现余额不足
	// 12交易序号已經存在
	// 14游戏代码无效
	// 15用户不存在
	// 16信用额度不足
	// 18此游戏代码不支持试用模式
	// 19批次理未准备好
	// 21找不到方法
	// 22参数验证失败
	/**
	 * 默认构造函数
	 */
	@Deprecated
	public TCAGGameAPI() {

	}

	/**
	 * 构建函数，初始化参数
	 * 
	 * @param API_URL
	 *            接口URL
	 * @param KEY
	 *            密钥
	 */
	public TCAGGameAPI(String api_url, String des_key, String sha256_key, String agent, String game_api_url) {
		this.api_url = api_url;
		this.des_key = des_key;
		this.sha256_key = sha256_key;
		this.agent = agent;
		this.game_api_url = game_api_url;
	}

	@Override
	public Object createAccount(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "createAccount", entity.toString());
		if (MapUtil.isNulls(entity, "username,password,currency")) {
			if (String.valueOf(entity.get("username")).length() > 14) {
				return Enum_MSG.参数错误.message("用户长度不能大于14位");
			}
			if (String.valueOf(entity.get("password")).length() > 12) {
				return Enum_MSG.参数错误.message("密码长度不能大于12位");
			}

			JSONObject json = new JSONObject();
			json.put("username", entity.get("username"));
			json.put("password", entity.get("password"));
			json.put("currency", entity.get("currency"));
			json.put("method", "cm");
			String params = YoPlayDESEncrypt.encrypt(des_key, json.toString());
			String sign = SHA256Util.SHA256Encrypt(params + sha256_key);
			Map<String, Object> data = new HashMap<>();
			data.put("merchant_code", agent);
			data.put("params", params);
			data.put("sign", sign);

			logger.info("创建账号参数明文：{},密文参数：{}", json.toString(), JSONObject.fromObject(data));
			String result = doPost(api_url, data);
			logger.info("创建账号返回结果：{}", result);

			BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "createAccount", entity.toString(), result);
			if (StringUtils.isNotEmpty(result)) {
				json = JSONObject.fromObject(result);
				if (json.getInt("status") == 0) {
					return Enum_MSG.成功.message("成功");
				}
			}
			return Enum_MSG.失败.message("返回错误代码：" + result + "，请对照错误代码");
		}
		return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
	}

	@Override
	public Object getBalance(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getBalance", entity.toString());

		JSONObject json = new JSONObject();
		json.put("username", entity.get("username"));
		json.put("product_type", productType);
		json.put("method", "gb");
		String params = YoPlayDESEncrypt.encrypt(des_key, json.toString());
		String sign = SHA256Util.SHA256Encrypt(params + sha256_key);
		Map<String, Object> data = new HashMap<>();
		data.put("merchant_code", agent);
		data.put("params", params);
		data.put("sign", sign);
		logger.info("查询余额参数明文：{},密文参数：{}", json.toString(), JSONObject.fromObject(data));
		String result = doPost(api_url, data);
		logger.info("查询余额返回结果：{}", result);
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getBalance", entity.toString(), result);
		if (StringUtils.isNotEmpty(result)) {
			json = JSONObject.fromObject(result);
			if (json.getInt("status") == 0) {
				return Enum_MSG.成功.message(json.getInt("balance"));
			}
		}
		return Enum_MSG.失败.message("返回错误代码：" + result + "，请对照错误代码");
	}

	@Override
	public Object withdraw(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "withdraw", entity.toString());

		if (MapUtil.isNulls(entity, "username,billno,credit")) {
			if (String.valueOf(entity.get("billno")).length() > 20) {
				return Enum_MSG.参数错误.message("订单号长度不能大于20位");
			}

			JSONObject json = new JSONObject();
			json.put("username", entity.get("username"));
			json.put("product_type", productType);
			json.put("fund_type", "1");
			DecimalFormat sf = new DecimalFormat("#.00");
			json.put("amount", sf.format(new BigDecimal(entity.get("credit") + "").doubleValue()));
			json.put("method", "ft");
			json.put("reference_no", entity.get("billno") + "");
			String params = YoPlayDESEncrypt.encrypt(des_key, json.toString());
			String sign = SHA256Util.SHA256Encrypt(params + sha256_key);
			Map<String, Object> data = new HashMap<>();
			data.put("merchant_code", agent);
			data.put("params", params);
			data.put("sign", sign);
			logger.info("提款参数明文：{},密文参数：{}", json.toString(), JSONObject.fromObject(data));
			String result = doPost(api_url, data);
			logger.info("提款返回结果：{}", result);

			BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "withdraw", entity.toString(), result);
			if (StringUtils.isNotEmpty(result)) {
				json = JSONObject.fromObject(result);
				if (json.getInt("status") == 0) {
					return Enum_MSG.成功.message("成功");
				}
			}
			return Enum_MSG.失败.message("返回错误代码：" + result + "，请对照错误代码");

		} else {
			return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
		}
	}

	@Override
	public Object deposit(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "deposit", entity.toString());

		if (MapUtil.isNulls(entity, "username,billno,credit")) {
			if (String.valueOf(entity.get("billno")).length() > 20) {
				return Enum_MSG.参数错误.message("订单号长度不能大于20位");
			}

			JSONObject json = new JSONObject();
			json.put("username", entity.get("username"));
			json.put("product_type", productType);
			json.put("fund_type", "1");
			DecimalFormat sf = new DecimalFormat("#.00");
			json.put("amount", sf.format(new BigDecimal(entity.get("credit") + "").doubleValue()));
			json.put("method", "ft");
			json.put("reference_no", entity.get("billno") + "");
			String params = YoPlayDESEncrypt.encrypt(des_key, json.toString());
			String sign = SHA256Util.SHA256Encrypt(params + sha256_key);
			Map<String, Object> data = new HashMap<>();
			data.put("merchant_code", agent);
			data.put("params", params);
			data.put("sign", sign);
			logger.info("存款参数明文：{},密文参数：{}", json.toString(), JSONObject.fromObject(data));
			String result = doPost(api_url, data);
			logger.info("存款返回结果：{}", result);
			// PENDING = 延迟，SUCCESS = 成功，FAILED = 失败，UNKNOWN = 未知
			BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "deposit", entity.toString(), result);

			if (StringUtils.isNotEmpty(result)) {
				json = JSONObject.fromObject(result);
				if (json.getInt("status") == 0) {
					return Enum_MSG.成功.message("成功");
				}
			}
			return Enum_MSG.失败.message("返回错误代码：" + result + "，请对照错误代码");
		} else {
			return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
		}
	}

	@Override
	public Object getRecord(Map<String, Object> entity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object updateInfo(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "updateInfo", entity.toString());
		if (MapUtil.isNulls(entity, "username,password")) {

			JSONObject json = new JSONObject();
			json.put("username", entity.get("username"));
			json.put("password", entity.get("password"));
			json.put("method", "up");
			String params = YoPlayDESEncrypt.encrypt(des_key, json.toString());
			String sign = SHA256Util.SHA256Encrypt(params + sha256_key);
			Map<String, Object> data = new HashMap<>();
			data.put("merchant_code", agent);
			data.put("params", params);
			data.put("sign", sign);
			logger.info("修改账号密码,参数明文：{},密文参数：{}", json.toString(), JSONObject.fromObject(data));
			String result = doPost(api_url, data);
			logger.info("修改账号密码返回结果：{}", result);
			if (StringUtils.isNotEmpty(result)) {
				json = JSONObject.fromObject(result);
				if (json.getInt("status") == 0) {
					return Enum_MSG.成功.message("成功");
				}
			}
			return Enum_MSG.失败.message("返回错误代码：" + result + "，请对照错误代码");
		} else {
			return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
		}
	}

	@Override
	public Object getOrder(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getOrder", entity.toString());

		if (MapUtil.isNulls(entity, "username,password,billno,credit,type")) {

			if (String.valueOf(entity.get("billno")).length() > 20) {
				return Enum_MSG.参数错误.message("订单号长度不能大于20位");
			}

			JSONObject json = new JSONObject();
			json.put("ref_no", entity.get("billno"));
			json.put("product_type", productType);
			json.put("method", "cs");
			String params = YoPlayDESEncrypt.encrypt(des_key, json.toString());
			String sign = SHA256Util.SHA256Encrypt(params + sha256_key);
			Map<String, Object> data = new HashMap<>();
			data.put("merchant_code", agent);
			data.put("params", params);
			data.put("sign", sign);
			logger.info("查询订单[" + entity.get("billno") + "]参数明文：{},密文参数：{}", json.toString(),
					JSONObject.fromObject(data));
			String result = doPost(api_url, data);
			logger.info("查询订单[" + entity.get("billno") + "]返回结果：{}", result);

			BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getOrder", entity.toString(), result);
			if (StringUtils.isNotEmpty(result)) {
				json = JSONObject.fromObject(result);
				if (json.getInt("status") == 0) {
					return Enum_MSG.成功.message("成功");
				}
			}
			return Enum_MSG.失败.message("返回错误代码：" + result + "，请对照错误代码");
		} else {
			return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
		}
	}

	@Override
	public Object login(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "login", entity.toString());

		if (MapUtil.isNulls(entity, "username,platform,gameMode")) {
			JSONObject json = new JSONObject();
			json.put("username", entity.get("username"));
			json.put("platform", entity.get("platform")); // flash , html5
			json.put("game_mode", entity.get("gameMode")); // 1=真实，0 =测试
			// {"status":0,"games":[{"displayStatus":0,"gameType":"LIVE","gameName":"AG
			// 真人游戏大厅","tcgGameCode":"A00070","productCode":"AG","productType":"4","platform":"flash,html5"},{"displayStatus":0,"gameType":"LIVE","gameName":"Baccarat
			// of AGQ (AGIN
			// Platform)_旗舰厅百家乐","tcgGameCode":"A00001","productCode":"AG","productType":"4","platform":"html5"},{"displayStatus":0,"gameType":"LIVE","gameName":"Baccarat
			// of AGIN (AGIN
			// Platform)_国际厅百家乐","tcgGameCode":"A00002","productCode":"AG","productType":"4","platform":"html5"},{"displayStatus":0,"gameType":"LIVE","gameName":"Dragon
			// Tiger of AGQ (AGIN
			// Platform)_旗舰厅龙虎","tcgGameCode":"A00003","productCode":"AG","productType":"4","platform":"html5"},{"displayStatus":0,"gameType":"LIVE","gameName":"Dragon
			// Tiger of AGIN (AGIN
			// Platform)_国际厅龙虎","tcgGameCode":"A00004","productCode":"AG","productType":"4","platform":"html5"},{"displayStatus":0,"gameType":"LIVE","gameName":"Roulette
			// of AGQ (AGIN
			// Platform)_旗舰厅轮盘","tcgGameCode":"A00005","productCode":"AG","productType":"4","platform":"flash"},{"displayStatus":0,"gameType":"LIVE","gameName":"Roulette
			// of AGIN (AGIN
			// Platform)_国际厅轮盘","tcgGameCode":"A00006","productCode":"AG","productType":"4","platform":"flash"},{"displayStatus":0,"gameType":"LIVE","gameName":"Sicbo
			// of AGQ (AGIN
			// Platform)_旗舰厅骰宝","tcgGameCode":"A00007","productCode":"AG","productType":"4","platform":"flash"},{"displayStatus":0,"gameType":"LIVE","gameName":"Sicbo
			// of AGIN (AGIN
			// Platform)_国际厅骰宝","tcgGameCode":"A00008","productCode":"AG","productType":"4","platform":"flash"},{"displayStatus":0,"gameType":"LIVE","gameName":"BID
			// (AGIN
			// Platform)_竞咪百家乐","tcgGameCode":"A00009","productCode":"AG","productType":"4","platform":"flash"},{"displayStatus":0,"gameType":"LIVE","gameName":"VIP
			// (AGIN
			// Platform)_包桌百家乐","tcgGameCode":"A00010","productCode":"AG","productType":"4","platform":"flash"},{"displayStatus":0,"gameType":"LIVE","gameName":"VIP(LED)
			// (AGIN
			// Platform)_LED包桌百家乐","tcgGameCode":"A00011","productCode":"AG","productType":"4","platform":"flash"},{"displayStatus":0,"gameType":"LIVE","gameName":"BJ
			// (AGIN
			// Platform)_21點AG国际厅","tcgGameCode":"A00142","productCode":"AG","productType":"4","platform":"flash"},{"displayStatus":0,"gameType":"LIVE","gameName":"AG
			// 真人直播厅","tcgGameCode":"A00165","productCode":"AG","productType":"4","platform":"flash,html5"},{"displayStatus":0,"gameType":"LIVE","gameName":"NN
			// of AGQ (AGIN
			// Platform)_旗舰厅牛牛","tcgGameCode":"A00073","productCode":"AG","productType":"4","platform":"flash"}],"error_desc":null,"page_info":{"totalPage":1,"currentPage":1,"totalCount":null}}
			json.put("game_code", entity.get("gameCode"));
			json.put("product_type", productType);
			json.put("method", "lg");
			String params = YoPlayDESEncrypt.encrypt(des_key, json.toString());
			String sign = SHA256Util.SHA256Encrypt(params + sha256_key);
			Map<String, Object> data = new HashMap<>();
			data.put("merchant_code", agent);
			data.put("params", params);
			data.put("sign", sign);
			logger.info("登入游戏参数明文：{},密文参数：{}", json.toString(), JSONObject.fromObject(data));
			String result = doPost(api_url, data);
			logger.info("登入游戏返回结果：" + result);
			BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "login", entity.toString(), result);

			if (StringUtils.isNotEmpty(result)) {
				json = JSONObject.fromObject(result);
				if (json.getInt("status") == 0) {
					return Enum_MSG.成功.message(json.getString("game_url"));
				}
			}
			return Enum_MSG.失败.message("返回错误代码：" + result + "，请对照错误代码");
		} else {
			return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
		}
	}

	@Override
	public Object isOnLine(Map<String, Object> entity) {
		// TODO Auto-generated method stub
		return null;
	}

	public static String doPost(String url, Map parameterMap) {
		Date data1 = new Date();
		byte[] content = null;
		Long time = null;
		String returnBody = null;
		HttpClient httpClient = new HttpClient();
		httpClient.setTimeout(30000);
		PostMethod postMethod = new PostMethod(url);
		if (parameterMap != null) {
			Iterator iterator = parameterMap.entrySet().iterator();
			while (iterator.hasNext()) {
				Entry entry = (Entry) iterator.next();
				String key = entry.getKey().toString();
				String value = entry.getValue().toString();
				postMethod.addParameter(key, value);
			}
		}
		// 设置成了默认的恢复策略，在发生异常时候将自动重试3次，在这里你也可以设置成自定义的恢复策略
		postMethod.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, 100000);
		InputStream inputStream = null;
		try {

			if (httpClient.executeMethod(postMethod) == HttpStatus.SC_OK) {
				// 读取内容
				inputStream = postMethod.getResponseBodyAsStream();
				content = IOUtils.toByteArray(inputStream);
				returnBody = content.length > 0 ? new String(content, "UTF-8") : null;
				time = new Date().getTime() - data1.getTime();
				System.out.println("请求花费时间：" + time);
			} else {
				System.err.println("Method failed: " + postMethod.getStatusLine());
			}
		} catch (IOException e) {
			e.printStackTrace();
			return Enum_MSG.接口调用错误.message(e.getMessage());
		} finally {
			IOUtils.closeQuietly(inputStream);
			postMethod.releaseConnection();
		}
		return returnBody;
	}
}
