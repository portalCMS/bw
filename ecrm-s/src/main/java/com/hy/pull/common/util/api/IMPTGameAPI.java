package com.hy.pull.common.util.api;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hy.pull.common.util.MapUtil;
import com.hy.pull.common.util.PlaytechApiResponse;
import com.hy.pull.common.util.game.pt.PTUtils;
import com.maven.util.HttpClientUtil;
import com.maven.util.JsonUtils;

import net.sf.json.JSONObject;

/**
 * PT游戏接口
 * 
 * @author temdy
 */
public class IMPTGameAPI implements BaseInterface {
	private Logger logger = LoggerFactory.getLogger(IMPTGameAPI.class);
	private String API_URL = "http://ws-keryxr.imapi.net";
	private String MERCHANT_NAME = "51baowangprod";// 客户端名称
	private String MERCHANT_CODE = "ebMhrZpVZ8KaXqUbZYgclRYXVbzju4Jh";// 运营商代码
	private String GAME_API_URL = "http://cache.download.banner.dragonfish88.com/casinoclient.html";
	//http://cache.download.banner.dragonfish88.com/casinoclient.html?language={languagecode}&game={gamecode}&mode=offline&affiliates=1&currency={currencycode}

	public IMPTGameAPI() {
	}

	/**
	 * 构建函数，初始化参数
	 * 
	 * @param ENTITY_KEY
	 *            密钥ENTITY
	 */
	public IMPTGameAPI(String API_URL, String MERCHANT_NAME, String MERCHANT_CODE, String GAME_API_URL) {
		this.API_URL = API_URL;
		this.MERCHANT_NAME = MERCHANT_NAME;
		this.MERCHANT_CODE = MERCHANT_CODE;
		this.GAME_API_URL = GAME_API_URL;
	}

	/**
	 * 创建用户接口
	 * 
	 * @param entity
	 *            参数列表 playername 玩家注册名 password 玩家密码 8位数
	 * 
	 * 
	 *            1.玩家注册必须加前缀，例如：HYAZHANG，PT玩家名称为大写（每个代理商都会分配一个前缀如HYL，
	 *            同时注册时的用户名要求也是大写。整个用户名就是大写的）； 2.玩家名称最多30个字符，含前缀；
	 *            3.调用结果返回json示例：{"result":{"result":
	 *            "New player has been created"
	 *            ,"playername":"HYLGFSD90FUDSF8DX2","password":"12345678",
	 *            "executiontime":{"webapi":"159.636 ms","skywind":"0.453 ms"}}}
	 *            4.错误：{"error":"Player password is too short","errorcode":50}
	 * @return 返回结果
	 */
	@Override
	public Object createAccount(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "createAccount", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "playername,password")) {
				if (String.valueOf(entity.get("playername")).length() > 20) {
					return Enum_MSG.参数错误.message("用户长度不能大于20位");
				}
				if (String.valueOf(entity.get("password")).length() > 20) {
					return Enum_MSG.参数错误.message("密码长度不能大于20位");
				}

				// 1.检测玩家是否存在
				String url = this.API_URL + "/player/checkplayerexists/membercode/" + entity.get("playername");
				Map<String, Object> headerMap = new HashMap<String, Object>();
				// 2.创建新玩家，设置客户端名称、运营商代码。
				headerMap.put("merchantname", this.MERCHANT_NAME);
				headerMap.put("merchantcode", this.MERCHANT_CODE);
				String result = HttpClientUtil.doGet(url, headerMap);
				logger.info("创建玩家账号操作前，检测玩家账号返回结果:" + result);
				PlaytechApiResponse response = JsonUtils.toBean(result, PlaytechApiResponse.class);
				if ("54".equals(response.getCode()) || "251".equals(response.getCode()) || "0".equals(response.getCode())) { // 玩家存在
					return Enum_MSG.成功.message(response.getCode(),response.getMessage());
				}

				url = this.API_URL + "/player/createplayer";
				// 设置玩家账号、密码、货币单位。
				JSONObject jsonParam = new JSONObject();
				jsonParam.put("membercode", entity.get("playername"));
				jsonParam.put("password", entity.get("password"));
				jsonParam.put("currency", "CNY");

				result = HttpClientUtil.doPost(url, headerMap, jsonParam.toString());
				logger.info("调用Playtech创建玩家账号接口返回结果:" + result);
				response = JsonUtils.toBean(result, PlaytechApiResponse.class);
				// 54:玩家已存在/0:创建成功/200:该玩家存在, 请再次创建玩家
				if ("54".equals(response.getCode()) || "0".equals(response.getCode()) || "200".equals(response.getCode())) {
					return Enum_MSG.成功.message(response.getCode(),response.getMessage());
				} else {
					return Enum_MSG.失败.message(response.getCode(),response.getMessage());
				}
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
	 *            参数列表 playername 玩家账号
	 * 
	 * @return 返回结果
	 */
	@Override
	public Object getBalance(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getBalance", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "playername")) {

				String url = this.API_URL + "/account/getbalance/membercode/" + entity.get("playername")
						+ "/producttype/0"; // 0=Playtech
				Map<String, Object> headerMap = new HashMap<String, Object>();
				// 2.创建新玩家，设置客户端名称、运营商代码。
				headerMap.put("merchantname", this.MERCHANT_NAME);
				headerMap.put("merchantcode", this.MERCHANT_CODE);
				String result = HttpClientUtil.doGet(url, headerMap);
				logger.info("调用Playtech查询玩家余额接口返回结果:" + result);
				PlaytechApiResponse response = JsonUtils.toBean(result, PlaytechApiResponse.class);
				// 存在该节点时，表示成功
				if ("0".equals(response.getCode())) {
					// 不返回相关数据。
					return Enum_MSG.成功.message(response.getBalance());
				} else {
					return Enum_MSG.失败.message(response.getCode(),response.getMessage());
				}
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
	 *            参数列表 playername 玩家 amount 分数 externaltranid 交易单号
	 * 
	 *            返回json示例：{"result":{"amount":"0.02","currentplayerbalance":
	 *            "1.12","executiontime":"206.003 ms"
	 *            ,"externaltransactionid":"1479803522117","instantcashtype":
	 *            null,"kiosktransactionid":"538963458","kiosktransactiontime":
	 *            "2016-11-22 16:32:06"
	 *            ,"ptinternaltransactionid":"84940361890","result":
	 *            "Withdraw OK"}}
	 * 
	 *            可能使用到的字段：amount=本次金额、currentplayerbalance=当前余额、result=本次操作结果
	 * 
	 * @return 返回结果
	 */
	@Override
	public Object withdraw(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "withdraw", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "playername,amount,externaltranid")) {
				if (Double.valueOf(entity.get("amount").toString()) < 1.0) {
					return Enum_MSG.参数错误.message("取款金额不能小于1元");
				}

				String url = this.API_URL + "/chip/createtransaction";
				Map<String, Object> headerMap = new HashMap<String, Object>();
				// 设置客户端名称、运营商代码。
				headerMap.put("merchantname", this.MERCHANT_NAME);
				headerMap.put("merchantcode", this.MERCHANT_CODE);
				// 设置玩家账号、类型。
				JSONObject jsonParam = new JSONObject();
				jsonParam.put("membercode", entity.get("playername"));
				jsonParam.put("amount", "-" + entity.get("amount"));
				jsonParam.put("externaltransactionid", entity.get("externaltranid"));
				jsonParam.put("producttype", 0);

				String result = HttpClientUtil.doPost(url, headerMap, jsonParam.toString());
				logger.info("调用Playtech游戏提款接口返回结果:" + result);
				PlaytechApiResponse response = JsonUtils.toBean(result, PlaytechApiResponse.class);
				// 1. Http Status 200
				// {
				// “Code”: ”100”
				// “Message”: “Required field cannot be empty or null.”
				// //必填字段不能为空
				// }
				// 2. Http Status 200
				// {
				// “Code”: ”104”
				// “Message”: “Invalid amount format.” // 金额格式无效
				// }
				// 3. Http Status 200
				// {
				// “Code”: ”105”
				// “Message”: “Invalid external transaction Id, its length
				// cannot more than 100 characters.” // 无效
				// 的外部交易 ID.
				// }
				// 4. Http Status 200
				// {
				// “Code”: ”103”
				// “Message”: “Invalid product type.” // 无效的产品类型
				// }
				// 5. Http Status 200
				// {
				// “Code”: ”53”
				// “Message”: “Player does not exists.” //该玩家不存在
				// }
				// 6. Http Status 200
				// {
				// “Code”: ”56”
				// “Message”: “Please try again later, the account is being
				// processed.”// 请稍后再试, 该帐户在
				// 被处理
				// }
				// 7. Http Status 200
				// {
				// “Code”: ”0”
				// “Message”: “No Error”
				// “TransactionId”: “1248”
				// “Status”: approved // 转账成功
				// }
				// 8. Http Status 200KeryxZwei API Web Services 开发者指南
				// Page 21 of 74
				// {
				// “code”: ”0”
				// “message”: “No Error”
				// “transactionid”: “”
				// “status”: declined // 转账失败
				// }
				// 9. Http Status 200
				// {
				// “code”: ”0”
				// “message”: “No Error”
				// “transactionid”: “”
				// “status”: processed //在处理
				// }
				// 10. Http Status 200
				// {
				// “Code”: ”400”
				// “Message”: “Deposit limit for the ongoing period has been
				// exceeded.” //
				// 存期已经超过
				// “TransactionId”: “”
				// “Status”: ”declined” //转账不成功
				// }
				// 11. Http Status 200
				// {
				// “Code”: ”401”
				// “Message”: “The agent has insufficient funds in his balance.”
				// // 中介账户余额不足
				// “TransactionId”: “”
				// “Status”: ”declined” // 转账不成功
				// }
				// 12. Http Status 200
				// {
				// “Code”: ”402”
				// “Message”: “Amount exceeds maximum limit.” // 金额超过上限
				// “TransactionId”: “”
				// “Status”: ”declined” // 转账不成功
				// }
				// 13. Http Status 200
				// {
				// “Code”: ”403”
				// “Message”: “Amount exceeds Minimum limit.” // 金额没有达到下限
				// “TransactionId”: “”
				// “Status”: ”declined” // 转账不成功
				// }
				// 14. Http Status 200KeryxZwei API Web Services 开发者指南
				// Page 22 of 74
				// {
				// “Code”: ”404”
				// “Message”: “Player’s balance is insufficient to withdraw.” //
				// 余额不足
				// “TransactionId”: “”
				// “Status”: ”declined” // 转账不成功
				// }
				// 15. Http Status 200
				// {
				// “Code”: ”405”
				// “Message”: “External transaction Id is duplicated in Keryx
				// system.” // 交易 ID 重复
				// “TransactionId”: “”
				// “Status”: ”declined” // 转账不成功
				// }
				// 16. Http Status 200
				// {
				// “Code”: ”407”
				// “Message”: “Transaction is processed, please use check
				// transaction API to get its status.” // 交易
				// 是在处理，请使用检查存取状态 API 来获取其状态
				// “TransactionId”: “”
				// “Status”: ”proccessed”
				// }
				// 17. Http Status : 200
				// {
				// "Code":"20"
				// "Message":"Playtech internal error."
				// "Status":"Declined"
				// "TransactionId":""
				// }
				if ("0".equals(response.getCode())) {
					return Enum_MSG.成功.message(response.getCode(),response.getMessage());
				} else {
					return Enum_MSG.失败.message(response.getCode(), response.getMessage());
				}
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
	 *            参数列表 playername 玩家 amount 分数 externaltranid 交易单号
	 * 
	 *            返回json示例：{"result":{"amount":"0.02","currentplayerbalance":
	 *            "1.14","executiontime":"551.757 ms"
	 *            ,"externaltransactionid":"1479803445736","instantcashtype":
	 *            null,"kiosktransactionid":"538962533","kiosktransactiontime":
	 *            "2016-11-22 16:30:52"
	 *            ,"ptinternaltransactionid":"84940152480","result":"Deposit OK"
	 *            }}
	 * 
	 *            可能使用到的字段：amount=本次金额、currentplayerbalance=当前余额、result=本次操作结果
	 * @return 返回结果
	 */
	@Override
	public Object deposit(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "deposit", entity.toString());
		try {

			if (MapUtil.isNulls(entity, "playername,amount,externaltranid")) {

				String url = this.API_URL + "/chip/createtransaction";
				Map<String, Object> headerMap = new HashMap<String, Object>();
				// 设置客户端名称、运营商代码。
				headerMap.put("merchantname", this.MERCHANT_NAME);
				headerMap.put("merchantcode", this.MERCHANT_CODE);
				// 设置玩家账号、类型。
				JSONObject jsonParam = new JSONObject();
				jsonParam.put("membercode", entity.get("playername"));
				jsonParam.put("amount", entity.get("amount"));
				jsonParam.put("externaltransactionid", entity.get("externaltranid"));
				jsonParam.put("producttype", 0);
				
				System.out.println("jsonParam  " +jsonParam.toString());
				System.out.println("url  " +url);

				String result = HttpClientUtil.doPost(url, headerMap, jsonParam.toString());
				logger.info("调用Playtech游戏存款接口返回结果:" + result);
				PlaytechApiResponse response = JsonUtils.toBean(result, PlaytechApiResponse.class);
				if ("0".equals(response.getCode())) {
					return Enum_MSG.成功.message(response.getCode(),response.getMessage());
				} else {
					return Enum_MSG.失败.message(response.getCode(), response.getMessage());
				}
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
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 更新信息接口（更新密码）
	 * 
	 * @param entity
	 *            参数列表 playername 玩家
	 * @return 返回结果
	 */
	@Override
	public Object updateInfo(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "updateInfo", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "playername,password")) {
				
				String url = this.API_URL + "/player/resetpassword";
				Map<String, Object> headerMap = new HashMap<String, Object>();
				// 设置客户端名称、运营商代码。
				headerMap.put("merchantname", this.MERCHANT_NAME);
				headerMap.put("merchantcode", this.MERCHANT_CODE);
				// 设置玩家账号、类型。
				JSONObject jsonParam = new JSONObject();
				jsonParam.put("membercode", entity.get("playername"));
				jsonParam.put("password", entity.get("password"));
		
				String result = HttpClientUtil.doPost(url, headerMap, jsonParam.toString());
				
				logger.info("调用Playtech游戏修改密码返回结果:" + result);
			
				PlaytechApiResponse response = JsonUtils.toBean(result, PlaytechApiResponse.class);
				if ("0".equals(response.getCode())) {
					return Enum_MSG.成功.message(response.getCode(),response.getMessage());
				} else {
					return Enum_MSG.失败.message(response.getCode(), response.getMessage());
				}
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			return Enum_MSG.接口调用错误.message(ex.getMessage());
		}

	}

	/**
	 * 获取订单接口
	 * 
	 * @param entity
	 *            参数列表
	 * 
	 *            externaltransactionid 交易单号
	 * 
	 *            返回json示例：{"result":{"status":"approved","type":"withdraw",
	 *            "amount":".02","currentplayerbalance":"1.12",
	 *            "kiosktransactiontime":"2016-11-22 16:32:06"
	 *            ,"kiosktransactionid":"538963458","ptinternaltransactionid":
	 *            "84940361890","ip":"180.232.108.150","username":
	 *            "HYLGFSD90FUDSF8DX2","admin":"VBETCNYHYL",
	 *            "externaltransactionid":"1479803522117","executiontime":
	 *            "22.766 ms"}}
	 * 
	 *            可能使用到的字段：status=approved审核完毕的、type=存款deposit或取款withdraw、
	 *            currentplayerbalance=当前余额、amount=本单号涉及的业务
	 * 
	 * @return 返回结果
	 */
	@Override
	public Object getOrder(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "getOrder", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "externaltransactionid")) {

				String url = this.API_URL + "/chip/checktransaction/membercode/" + entity.get("playername")
						+ "/externaltransactionid/" + entity.get("externaltranid") + "/producttype/0";
				Map<String, Object> headerMap = new HashMap<String, Object>();
				// 创建新玩家，设置客户端名称、运营商代码。
				headerMap.put("merchantname", this.MERCHANT_NAME);
				headerMap.put("merchantcode", this.MERCHANT_CODE);
				String result = HttpClientUtil.doGet(url, headerMap);
				logger.info("调用Playtech查询订单状态接口返回结果:" + result);
				PlaytechApiResponse response = JsonUtils.toBean(result, PlaytechApiResponse.class);
				if ("0".equals(response.getCode())) {
					return Enum_MSG.成功.message(response.getCode(),response.getMessage());
				} else {
					return Enum_MSG.失败.message(response.getCode(), response.getMessage());
				}
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			return Enum_MSG.接口调用错误.message(ex.getMessage());
		}
	}

	/**
	 * 登录的接口 playername,password,deviceType,playtype
	 * 
	 * playtype=DZ/SX
	 * 
	 * @param entity
	 *            参数列表
	 * @return 返回结果
	 */
	@Override
	public Object login(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "login", entity.toString());
		try {
			if (MapUtil.isNulls(entity, "playername,password,deviceType,playtype")) {
				String requestUrl = this.GAME_API_URL+"?game=" + entity.get("gameName") + "&language=CH";
				return Enum_MSG.成功.message(requestUrl);
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
	 *            参数列表 playername 玩家
	 * 
	 *            { "result": { "result": 0 } }
	 * 
	 * @return 返回结果 正确：0为否，1为是
	 */
	@Override
	public Object isOnLine(Map<String, Object> entity) {
		try {
			if (MapUtil.isNulls(entity, "playername")) {
				return null;
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			return Enum_MSG.接口调用错误.message(ex.getMessage());
		}
	}

	public static void main(String[] a) {
		
		
//		String startDate="2018-05-12 15:10:00";
//		String endDate="2018-05-12 15:15:00";
//		String url = "http://ws-keryxr.imapi.net/report/getbetlog/startdate/"+startDate.replace(" ", "%20").replace(":", ".")+"/enddate/"+endDate.replace(" ", "%20").replace(":", ".")+"/page/1/producttype/0/currency/CNY";
//
//		Map<String, Object> headerMap = new HashMap<String, Object>();
//		// 设置客户端名称、运营商代码。
//		headerMap.put("merchantname", "51baowangprod");
//		headerMap.put("merchantcode", "ebMhrZpVZ8KaXqUbZYgclRYXVbzju4Jh");
//		
//		System.out.println("url" +url);
//
//		try {
//			String result = HttpClientUtil.doGet(url, headerMap);
//			System.out.println(" result "+result);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
		
		
		//JSONObject object = JSONObject.fromObject("['Code':'0','Message':'No Error']'");
		
		  // String json = "{'code':'0','info':'{'Code':'0','Message':'No Error'}'}";
		//   JSONObject obj = JSONObject.fromObject(json);
		
		//ObjectMapper objectMapper=new ObjectMapper();
		//objectMapper.readValue("{'code':'0','info':'{'Code':'0','Message':'No Error'}'}", PlaytechApiResponse.class);
		
		
		//PlaytechApiResponse response = JsonUtils.toBean("{'Code':'0','info':'0'}", PlaytechApiResponse.class);
		
		//System.out.println("response" +response.getCode());
		
		
		IMPTGameAPI pt = new IMPTGameAPI();
		Map<String, Object> entity = new HashMap<String, Object>();
		entity.put("playername", "h5winloss1");// #&*
		entity.put("password", "12345678");
//		entity.put("newpassword", "1234567812");
//		entity.put("adminname", "VBETCNYHYL");
//		entity.put("kioskname", "VBETCNYHYL");
		entity.put("amount", "1");
//		entity.put("playtype", "SX");
//		entity.put("deviceType", "0");
		entity.put("externaltransactionid", "1479803522117125");
		entity.put("externaltranid", UUID.randomUUID().toString());
	// System.out.println(pt.createAccount(entity));
		System.out.println(pt.getBalance(entity));// 查询用户信息
		//System.out.println(pt.withdraw(entity));// 取款
		//System.out.println(pt.deposit(entity));// 存款
		//System.out.println(pt.getOrder(entity));// 订单查询
		// System.out.println(pt.isOnLine(entity));//是否在线

		// System.out.println(pt.login(entity));//
		// System.out.println(pt.updateInfo(entity));//

	}
}
