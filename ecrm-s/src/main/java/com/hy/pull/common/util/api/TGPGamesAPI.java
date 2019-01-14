package com.hy.pull.common.util.api;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.io.IOUtils;

import com.hy.pull.common.util.MapUtil;
import com.hy.pull.common.util.SGSUtil;
import com.maven.util.RandomString;

import net.sf.json.JSONObject;
/**
 * TGP 具体游戏的接口
 */
public class TGPGamesAPI implements BaseInterface {
	
	public static void main(String[] args) throws HttpException, IOException {
		String baseAPIUrl = "http://staging.tgpaccess.com";
		String gameAPIUrl = "http://staging.tgpasia.com";
		String clientId = "dfh";
		String clientSecret = "EO0jMfCFFixeBajuiFz1KsEgHTqQqsFJWF7aN3Z1iUfe";

		TGPGamesAPI api = new TGPGamesAPI(baseAPIUrl, gameAPIUrl, clientId, clientSecret);
		Map<String, Object> entity = new HashMap<String, Object>();

		String result = "";
		entity.put("ipaddress", "112.211.3.0");
		entity.put("username", "e88testaccount");
		entity.put("userid", "e88testaccount");
//		entity.put("istestplayer", true);
//		result = (String) api.createAccount(entity);
//		System.out.println("创建玩家结果: " + result);

//		entity.put("amt", "100.00");
//		entity.put("txid", "IN".concat(RandomString.UUID()));
//		result = (String) api.deposit(entity);
//		System.out.println("玩家上分结果: " + result);

		entity.put("amt", "30.00");
		entity.put("txid", "IN".concat(RandomString.UUID()));
		result = (String) api.withdraw(entity);
		System.out.println("玩家下分结果: " + result);

//		entity.put("gpcode", "SB");
//		entity.put("gcode", "Baccarat_1");
//		result = (String) api.login(entity);
//		System.out.println("登录游戏结果: " + result);

		result = (String) api.getBalance(entity);
		System.out.println("玩家账户余额: " + result);
	}
	private String baseAPIUrl;
	private String gameAPIUrl;
	private String authorization;
	
	public TGPGamesAPI(String baseAPIUrl, String gameAPIUrl, String clientId, String clientSecret) {
		this.baseAPIUrl = baseAPIUrl;
		this.gameAPIUrl = gameAPIUrl;
		this.authorization = getAuthorization(baseAPIUrl.concat("/api/oauth/token"), clientId, clientSecret);
//		this.authorization = "Bearer 5MlcCNLoKsiETBTI8Dkz7lB1J2Ekwt1AJuJO3xmZVhOzA3NBOcP0x4Pzl1DBtdje2";
	}
	@Override
	public Object createAccount(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "createAccount", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "ipaddress,username,userid")) {
				// 若未传语言参数, 则默认中文: zh-CN
				if (!entity.containsKey("lang"))
					entity.put("lang", "zh-CN");
				// 若未传货币参数, 则默认人民币: RMB
				if (!entity.containsKey("cur"))
					entity.put("cur", "RMB");
				// 游戏供应商的投注限額辨识码 非必须参数
				if (!entity.containsKey("betlimitid"))
					entity.put("betlimitid", 1);
				// 若未传是否测试账户参数, 则默认非测试账户
				if (!entity.containsKey("istestplayer"))
					entity.put("istestplayer", false);
				// 若未传平台类型, 则默认PC版: 0
				if (!entity.containsKey("platformtype"))
					entity.put("platformtype", 0);
				
				Map<String, Object> result = doPostSubmit(baseAPIUrl.concat("/api/player/authorize"), entity);
				if ((boolean) result.get(STATUS)) {
					String response = result.get(MESSAGE).toString();
					JSONObject jsonObject = JSONObject.fromObject(response);
					boolean isNew = jsonObject.getBoolean("isnew");
					if (isNew) return Enum_MSG.成功.message("创建玩家成功!");
					return Enum_MSG.账号已存在.message(null);
				} else {
					return Enum_MSG.失败.message("创建玩家失败: " + result.get(MESSAGE));
				}
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Enum_MSG.接口调用错误.message(e.getMessage());
		}
	}
	// 获取游戏账户余额
	@Override
	public Object getBalance(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getBalance", entity.toString());
		try {
			if (MapUtil.isNull(entity, "username")) {
				// 若未传货币参数, 默认人民币: RMB
				if (!entity.containsKey("cur"))
					entity.put("cur", "RMB");
				
				StringBuffer url = new StringBuffer(baseAPIUrl.concat("/api/player/balance"));
				url.append("?userid=").append(entity.get("username"));
				url.append("&cur=").append(entity.get("cur"));
				Map<String, Object> result = doGetSubmit(url.toString());
				if ((boolean) result.get(STATUS)) {
					String response = result.get(MESSAGE).toString();
					JSONObject jsonObject = JSONObject.fromObject(response);
					return Enum_MSG.成功.message(jsonObject.getString("bal"));
				} else {
					return Enum_MSG.失败.message("获取玩家余额失败: " + result.get(MESSAGE));
				}
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Enum_MSG.接口调用错误.message(e.getMessage());
		}
	}
	// 游戏下分
	@Override
	public Object withdraw(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "withdraw", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "userid,amt,txid")) {
				// 若未传货币参数, 默认人民币: RMB
				if (!entity.containsKey("cur")) 
					entity.put("cur", "RMB");
				entity.put("timestamp", SGSUtil.getIsoDateCurren());

				Map<String, Object> result = doPostSubmit(baseAPIUrl.concat("/api/wallet/debit"), entity);
				if ((boolean) result.get(STATUS)) {
					String response = result.get(MESSAGE).toString();
					return Enum_MSG.成功.message("游戏下分成功: " + response);
				} else {
					return Enum_MSG.失败.message("游戏下分失败: " + result.get(MESSAGE));
				}
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Enum_MSG.接口调用错误.message(e.getMessage());
		}
	}
	// 游戏上分
	@Override
	public Object deposit(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "deposit", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "userid,amt,txid")) {
				// 若未传货币参数, 默认人民币: RMB
				if (!entity.containsKey("cur"))
					entity.put("cur", "RMB");
				entity.put("timestamp", SGSUtil.getIsoDateCurren());
				
				Map<String, Object> result = doPostSubmit(baseAPIUrl.concat("/api/wallet/credit"), entity);
				if ((boolean) result.get(STATUS)) {
					String response = result.get(MESSAGE).toString();
					return Enum_MSG.成功.message("游戏上分成功: " + response);
				} else {
					return Enum_MSG.失败.message("游戏上分失败: " + result.get(MESSAGE));
				}
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Enum_MSG.接口调用错误.message(e.getMessage());
		}
	}
	// 获取游戏记录, 此项目没有使用
	@Override
	public Object getRecord(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getRecord", entity.toString());
		try {
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return Enum_MSG.接口调用错误.message(e.getMessage());
		}
	}

	@Override
	public Object updateInfo(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "updateInfo", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "")) {
				// 文档中无创建账户接口
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
			return Enum_MSG.失败.message("更新玩家信息失败: ");
		} catch (Exception e) {
			e.printStackTrace();
			return Enum_MSG.接口调用错误.message(e.getMessage());
		}
	}
	// 获取上下分记录, 该功能没有使用
	@Override
	public Object getOrder(Map<String, Object> entity) {
		return null;
	}

	@Override
	public Object login(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "login", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "ipaddress,username,userid,gpcode,gcode")) {
				// 若未传语言参数, 则默认中文: zh-CN
				if (!entity.containsKey("lang"))
					entity.put("lang", "zh-CN");
				// 若未传货币参数, 则默认人民币: RMB
				if (!entity.containsKey("cur"))
					entity.put("cur", "RMB");
				// 游戏供应商的投注限額辨识码 非必须参数
				if (!entity.containsKey("betlimitid"))
					entity.put("betlimitid", 1);
				// 若未传是否测试账户参数, 则默认非测试账户
				if (!entity.containsKey("istestplayer"))
					entity.put("istestplayer", false);
				// 若未传平台类型, 则默认PC版: 0
				if (!entity.containsKey("platformtype"))
					entity.put("platformtype", 0);
				
				Map<String, Object> result = doPostSubmit(baseAPIUrl.concat("/api/player/authorize"), entity);
				if ((boolean) result.get(STATUS)) {
					String response = result.get(MESSAGE).toString();
					JSONObject jsonObject = JSONObject.fromObject(response);
					String authtoken = jsonObject.getString("authtoken");
					StringBuffer url = new StringBuffer(gameAPIUrl.concat("/gamelauncher"));
					url.append("?gpcode=").append(entity.get("gpcode"))
					   .append("&gcode=").append(entity.get("gcode"))
					   .append("&platform=").append(entity.get("platformtype"))
					   .append("&token=").append(authtoken);
					return Enum_MSG.成功.message(url.toString());
				} else {
					return Enum_MSG.失败.message("登录游戏失败: " + result.get(MESSAGE));
				}
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Enum_MSG.接口调用错误.message(e.getMessage());
		}
	}

	@Override
	public Object isOnLine(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "isOnLine", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "")) {
				// 此方法未使用
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
			return Enum_MSG.失败.message("查询玩家在线状态失败: ");
		} catch (Exception e) {
			e.printStackTrace();
			return Enum_MSG.接口调用错误.message(e.getMessage());
		}
	}

	/**
	 * 
	 * @param url     接口请求连接
	 * @param params  请求参数
	 * @return
	 * @throws HttpException
	 * @throws IOException
	 */
	private Map<String, Object> doPostSubmit(String url, Map<String, Object> params) throws HttpException, IOException {
		System.err.println("请求地址: " + url);
		PostMethod post = new PostMethod(url);
		// 设置Header
		post.setRequestHeader("Authorization", this.authorization);
		post.setRequestHeader("Content-Type", APPLICATION_JSON);
		post.setRequestHeader("Accept", APPLICATION_JSON);		
		// 编码格式UTF-8
		post.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, CHARSET);
		// 判断是否有参数, 若有则生成参数
		if (params != null && params.size() > 0) {
			String jsonData = JSONObject.fromObject(params).toString();
			System.out.println("请求参数: " + jsonData);
			post.setRequestEntity(new StringRequestEntity(jsonData, APPLICATION_JSON, CHARSET));
		}
		
		Map<String, Object> result = new HashMap<String, Object>(2);
		HttpClient httpClient = new HttpClient();
		int statusCode = httpClient.executeMethod(post);
		InputStream is = post.getResponseBodyAsStream();
		String response = IOUtils.toString(is);
		System.out.println("请求结果: " + response);

		if (statusCode == HttpStatus.SC_OK) {
			result.put(STATUS, true);
			result.put(MESSAGE, response);
		} else {
			result.put(STATUS, false);
			result.put(MESSAGE, "[" + statusCode + "]" + response);
		}
		
		return result;
	}
	
	/**
	 * 
	 * @param url 接口请求连接
	 * @return
	 * @throws HttpException
	 * @throws IOException
	 */
	private Map<String, Object> doGetSubmit(String url) throws HttpException, IOException {
		System.err.println("请求地址: " + url);
		GetMethod get = new GetMethod(url);
		// 设置Header
		get.setRequestHeader("Authorization", this.authorization);
		get.setRequestHeader("Accept", APPLICATION_JSON);
		// 编码格式UTF-8
		get.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, CHARSET);
		
		Map<String, Object> result = new HashMap<String, Object>(2);
		HttpClient httpClient = new HttpClient();
		int statusCode = httpClient.executeMethod(get);
		InputStream is = get.getResponseBodyAsStream();
		String response = IOUtils.toString(is);
		System.out.println("请求结果: " + response);

		if (statusCode == HttpStatus.SC_OK) {
			result.put(STATUS, true);
			result.put(MESSAGE, response);
		} else {
			result.put(STATUS, false);
			result.put(MESSAGE, "[" + statusCode + "]" + response);
		}
		
		return result;
	}
	/**
	 * 请求获取Token
	 * @return
	 */
	private String getAuthorization(String baseAPIUrl, String clientId, String clientSecret) {
		try {
			PostMethod post = new PostMethod(baseAPIUrl);
			post.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			
			NameValuePair[] parametersBody = new NameValuePair[4];
			parametersBody[0] = new NameValuePair("client_id", clientId);
			parametersBody[1] = new NameValuePair("client_secret", clientSecret);
			parametersBody[2] = new NameValuePair("grant_type", "client_credentials");
			parametersBody[3] = new NameValuePair("scope", "playerapi");
			post.setRequestBody(parametersBody);
			
			HttpClient httpClient = new HttpClient();
			int statusCode = httpClient.executeMethod(post);
			InputStream is = post.getResponseBodyAsStream();
			String response = IOUtils.toString(is);
			System.out.println("请求结果: " + response);
			if (statusCode == HttpStatus.SC_OK) {
				JSONObject jsonObject = JSONObject.fromObject(response);
				String token = jsonObject.getString("access_token");
				String type = jsonObject.getString("token_type");
				String authorization = type + " " + token;
				System.out.println("授权码: " + authorization);
				return authorization;
			} else {
				return response;
			}
		} catch (HttpException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "error";
	}
	// 一些常量参数
	private static final String CHARSET = "UTF-8";
	private static final String STATUS = "status";
	private static final String MESSAGE = "message";
	private static final String APPLICATION_JSON = "application/json";
}