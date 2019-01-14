package com.hy.pull.common.util.api;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hy.pull.common.util.Encrypt;
import com.hy.pull.common.util.MapUtil;
import com.maven.game.enums.GameEnum;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
/**
 * 游戏综合接口, 集成多个游戏的API
 */
public class Bet67IntegratedAPI implements BaseInterface {
	private Logger logger = LoggerFactory.getLogger(Bet67IntegratedAPI.class);
	/*
	 * agentid: 20171228-2342-4102-71c0-fed88b8fdd69
	 * key: 177D-C845B0E87F8E
	 * http://e88api.bestxlg.com
	 */
	public static void main(String[] args) {
		String apiUrl = "http://e88api.bestxlg.com/AgentPlatform";
		String agentId = "20171228-2342-4102-71c0-fed88b8fdd69";
		String md5Key = "177D-C845B0E87F8E";
		Bet67IntegratedAPI api = new Bet67IntegratedAPI(apiUrl, apiUrl, agentId, md5Key);
		
		// 请求参数
		Map<String, Object> entity = new HashMap<String, Object>();
		
		String result = "";// 请求结果
//		result = (String) api.createAccount(entity);
//		System.out.println("创建玩家结果: " + result);
		
//		result = (String) api.updateInfo(entity);
//		System.out.println("更新玩家结果: " + result);
		entity.put("username", "test001");
		entity.put("password", "123qwe");
		entity.put("platform", "sl_live");
		entity.put("credit", 1);
		
//		result = (String) api.deposit(entity);
//		System.out.println("玩家上分结果: " + result);
		
		result = (String) api.getBalance(entity);
		System.out.println("玩家账户余额: " + result);
//		
		result = (String) api.login(entity);
		System.out.println("登录游戏结果: " + result);
//		
//		result = (String) api.withdraw(entity);
//		System.out.println("玩家下分结果: " + result);
		
//		entity.put("recordid", "20180108-0508-3018-6cef-b48d41bb9a8a");
//		result = (String) api.getOrder(entity);
//		System.out.println("玩家上下分数据: " + result);
	}
	// 普通接口地址
	private String baseAPIUrl;
	// 游戏接口地址
	private String gameAPIUrl;
	// 代理编码
	private String agentId;
	// MD5秘钥
	private String md5Key;
	
	public Bet67IntegratedAPI(String baseAPIUrl, String gameAPIUrl, String agentId, String md5Key) {
		this.baseAPIUrl = baseAPIUrl;
		this.gameAPIUrl = gameAPIUrl;
		this.agentId = agentId;
		this.md5Key = md5Key;
	}
	
	// 创建游戏账户
	@Override
	public Object createAccount(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "createAccount", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "username,password")) {
				// 集成游戏平台无需创建游戏账号, 所以直接返回成功
				return Enum_MSG.成功.message("账号创建成功");
			} else {
				System.out.println("缺少必须的参数323**"+entity);
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
			if (MapUtil.isNulls(entity, "username,platform")) {
				// 加密串：username|platform|agentid|key
				StringBuffer sb = new StringBuffer();
				sb.append(entity.get("username")).append("|")
				  .append(entity.get("platform")).append("|")
				  .append(agentId).append("|").append(md5Key);
//				System.out.println("before md5："+sb.toString());
				String hashcode = Encrypt.MD5(sb.toString());
//				System.out.println("after md5："+hashcode);
				entity.put("agentid", agentId);
				entity.put("hashcode", hashcode);
				//isremote 1为远程，0为缓存
				if(entity.containsKey("isremote")){
					entity.put("isremote", entity.get("isremote"));
				}else{
					entity.put("isremote", 1);
				}
				Map<String, Object> result = doPostSubmit(baseAPIUrl.concat("/GetBalance"), entity);
				logger.info(entity.get("username")+"查询67Bet游戏："+entity.get("platform")+"，查询余额请求参数：【"+entity.toString()+"】余额返回："+result);
				if ((boolean) result.get(STATUS)) {
					String response = result.get(MESSAGE).toString();
					JSONObject jsonObject = JSONObject.fromObject(response);
					int code = jsonObject.getInt("code");
					double balance =0;
					if (code == 0) {
						// BBIN账号不存在查询余额返回：{message={"code":0,"msg":"","balance":"member not exist or member UP 1"}, status=true}
						if(entity.get("platform").toString().equals(GameEnum.Enum_GameType.Bet67BBIN真人.bettingcode) && "member not exist or member UP 1".equals(jsonObject.getString("balance"))){
							balance =0;
						}else{
							balance = StringUtils.isNotEmpty(jsonObject.getString("balance"))?jsonObject.getDouble("balance"):0;
						}
						return Enum_MSG.成功.message(balance+"");
					} else {
						String msg = jsonObject.getString("msg");
						return Enum_MSG.失败.message(msg);
					}
				} else {
					return Enum_MSG.失败.message(result.get(MESSAGE));
				}
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Enum_MSG.接口调用错误.message("0");
		}
	}
	// 游戏下分
	@Override
	public Object withdraw(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "withdraw", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "username,password,platform,credit")) {
				// 若没有指定设备, 则默认电脑办 - 0
				if (!entity.containsKey("ismobile"))
					entity.put("ismobile", "0");
				// 若没有指定语言, 则默认中文 - zh
				if (!entity.containsKey("lang"))
					entity.put("lang", "zh");
				// 若没有指定货币, 则默认人民币 - RMB
				if (!entity.containsKey("currency"))
					entity.put("currency", "RMB");
				// 加密串：username|password|platform|credit|flag|agentid|key
				StringBuffer sb = new StringBuffer();
				sb.append(entity.get("username")).append("|")
				  .append(entity.get("password")).append("|")
				  .append(entity.get("platform")).append("|")
				  .append(entity.get("credit")).append("|")
				  .append("OUT|").append(agentId).append("|").append(md5Key);
//				logger.info(entity.get("username")+"查询67Bet转出明文参数："+sb.toString());
				String hashcode = Encrypt.MD5(sb.toString());
				entity.put("agentid", agentId);
				entity.put("flag", "OUT");
				entity.put("hashcode", hashcode);
				logger.info(entity.get("username")+"查询67Bet转出参数："+entity.toString());
				
				Map<String, Object> result = doPostSubmit(baseAPIUrl.concat("/Transfer"), entity);
				logger.info(entity.get("username")+"查询67Bet游戏："+entity.get("platform")+"转出返回："+result);
				if ((boolean) result.get(STATUS)) {
					entity.put("isremote", 1);
					this.getBalance(entity); //更新第三方缓存余额
					String response = result.get(MESSAGE).toString();
					JSONObject jsonObject = JSONObject.fromObject(response);
					int code = jsonObject.getInt("code");
					String orderId = jsonObject.getString("transferid");
					if (code == 0) {
						return Enum_MSG.成功.message("游戏下分成功[" + orderId + "]");
					} else {
						String msg = jsonObject.getString("msg");
						return Enum_MSG.失败.message("游戏下分失败[" + orderId + "]: " + msg);
					}
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
			if (MapUtil.isNulls(entity, "username,password,platform,credit")) {
				// 若没有指定设备, 则默认电脑办 - 0
				if (!entity.containsKey("ismobile"))
					entity.put("ismobile", "0");
				// 若没有指定语言, 则默认中文 - zh
				if (!entity.containsKey("lang"))
					entity.put("lang", "zh");
				// 若没有指定货币, 则默认人民币 - RMB
				if (!entity.containsKey("currency"))
					entity.put("currency", "RMB");
				// 加密串：username|password|platform|credit|flag|agentid|key
				StringBuffer sb = new StringBuffer();
				sb.append(entity.get("username")).append("|")
				  .append(entity.get("password")).append("|")
				  .append(entity.get("platform")).append("|")
				  .append(entity.get("credit")).append("|")
				  .append("IN|").append(agentId).append("|").append(md5Key);
//				logger.info(entity.get("username")+"查询67Bet转入明文参数："+sb.toString());
//				System.out.println("before md5："+sb.toString());
				String hashcode = Encrypt.MD5(sb.toString());
//				System.out.println("after md5："+hashcode);
				entity.put("agentid", agentId);
				entity.put("flag", "IN");
				entity.put("hashcode", hashcode);
				logger.info(entity.get("username")+"查询67Bet转入参数："+entity.toString());
				
//				System.out.println("submit param："+entity.toString());
				Map<String, Object> result = doPostSubmit(baseAPIUrl.concat("/Transfer"), entity);
				logger.info(entity.get("username")+"查询67Bet游戏："+entity.get("platform")+"转出返回："+result);
				if ((boolean) result.get(STATUS)) {
					entity.put("isremote", 1);
					this.getBalance(entity); //更新第三方缓存余额
					String response = result.get(MESSAGE).toString();
					JSONObject jsonObject = JSONObject.fromObject(response);
					int code = jsonObject.getInt("code");
					String orderId = jsonObject.getString("transferid");
					if (code == 0) {
						return Enum_MSG.成功.message("游戏上分成功[" + orderId + "]");
					} else {
						String msg = jsonObject.getString("msg");
						return Enum_MSG.失败.message("游戏上分失败[" + orderId + "]: " + msg);
					}
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
	// 更新玩家信息, 主要是更新密码
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
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getOrder", entity.toString());
		try {
			if (MapUtil.isNull(entity, "recordid")) {
				StringBuffer sb = new StringBuffer();
				sb.append(entity.get("recordid")).append("|")
				  .append(agentId).append("|").append(md5Key);
				String hashcode = Encrypt.MD5(sb.toString());
				entity.put("agentid", agentId);
				entity.put("hashcode", hashcode);
				
				Map<String, Object> result = doPostSubmit(baseAPIUrl.concat("/TransferRecord"), entity);
				logger.info("查询67Bet查询转账记录返回："+result);
				if ((boolean) result.get(STATUS)) {
					String response = result.get(MESSAGE).toString();
					JSONArray jsonArr = JSONArray.fromObject(response);
					return Enum_MSG.成功.message(jsonArr);
				} else {
					return Enum_MSG.失败.message("获取上下分记录失败: " + result.get(MESSAGE));
				}
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return Enum_MSG.接口调用错误.message(e.getMessage());
		}
	}
	// 登录游戏
	@Override
	public Object login(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "login", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "username,password,platform")) {
				// 若没有指定设备, 则默认 0 电脑版 1手机版
				if(!entity.containsKey("deviceType")){
					entity.put("ismobile", "0");
				}else{
					if (entity.get("deviceType").toString().equals(GameEnum.Enum_deviceType.电脑.code)){
						entity.put("ismobile", "0");
					}else{
						entity.put("ismobile", "1");
					}
				}
				// 若没有指定语言, 则默认中文 - zh
				if (!entity.containsKey("lang")){
					entity.put("lang", "zh");
				}
				// 若没有指定货币, 则默认人民币 - RMB
				if (!entity.containsKey("currency")){
					entity.put("currency", "RMB");
				}
				// 加密串：username|password|platform|agentid|key
				StringBuffer sb = new StringBuffer();
				sb.append(entity.get("username")).append("|")
				  .append(entity.get("password")).append("|")
				  .append(entity.get("platform")).append("|")
				  .append(agentId).append("|").append(md5Key);
				String hashcode = Encrypt.MD5(sb.toString());
				entity.put("agentid", agentId);
				entity.put("hashcode", hashcode);
				
				Map<String, Object> result = doPostSubmit(baseAPIUrl.concat("/Login"), entity);
				logger.info(entity.get("username")+"登录67Bet游戏："+entity.get("platform")+"返回："+result);
				if ((boolean) result.get(STATUS)) {
					String response = result.get(MESSAGE).toString();
					JSONObject jsonObject = JSONObject.fromObject(response);
					int code = jsonObject.getInt("code");
					if (code == 0) {
						String url = jsonObject.getString("url").replaceAll("\"", "'");
						return Enum_MSG.成功.message(url);
					} else {
						String msg = jsonObject.getString("msg");
						return Enum_MSG.失败.message("登录游戏失败: " + msg);
					}
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
	// 用户在线状态, 该功能没有使用
	@Override
	public Object isOnLine(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "isOnLine", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "")) {
				// 文档中无创建账户接口
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
	 * 发起POST请求
	 * @param url    请求地址
	 * @param params 请求参数
	 * @return
	 * @throws IOException 
	 * @throws HttpException 
	 */
	private Map<String, Object> doPostSubmit(String url, Map<String, Object> params) throws HttpException, IOException {
		System.out.println("submit url："+url);
		PostMethod post = new PostMethod(url);
		// 表单方式提交
		post.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		// 请求字符UTF8
		post.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, CHARSET);
		// 若有参数, 则生成NameValuePair, 放入post中
		if (params != null && params.size() > 0) {
			NameValuePair[] parametersBody = new NameValuePair[params.size()];
			Set<Entry<String, Object>> sets = params.entrySet();
			Iterator<Entry<String, Object>> ite = sets.iterator();
			Entry<String, Object> entry;
			int i = 0;
			while (ite.hasNext()) {
				entry = ite.next();
				parametersBody[i++] = new NameValuePair(entry.getKey(), entry.getValue().toString());
			}
			post.setRequestBody(parametersBody);
		}
		
		Map<String, Object> result = new HashMap<String, Object>(2);
		HttpClient httpClient = new HttpClient();
		int statusCode = httpClient.executeMethod(post);
		InputStream is = post.getResponseBodyAsStream();
		String response = IOUtils.toString(is);
		logger.debug("请求结果：" + response);

		if (statusCode == HttpStatus.SC_OK) {
			result.put(STATUS, true);
			result.put(MESSAGE, response);
		} else {
			result.put(STATUS, false);
			result.put(MESSAGE, "[" + statusCode + "]" + response);
		}
		
		return result;
	}
	
	// 一些常用固定值
	private static final String CHARSET = "UTF-8";
	private static final String STATUS = "status";
	private static final String MESSAGE = "message";
}