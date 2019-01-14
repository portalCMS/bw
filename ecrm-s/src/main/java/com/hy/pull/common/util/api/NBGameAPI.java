package com.hy.pull.common.util.api;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hy.pull.common.util.MapUtil;

/**
 * NB体育游戏接口
 * 
 * @author temdy
 */
public class NBGameAPI implements BaseInterface {
	private Logger logger = LoggerFactory.getLogger(NBGameAPI.class);
	private String API_URL = "";
	private String MERCHANT_NAME = "";// 客户端名称
	private String MERCHANT_CODE = "";// 运营商代码
	private String GAME_API_URL = "";

	public NBGameAPI() {
	}

	public NBGameAPI(String API_URL, String MERCHANT_NAME, String MERCHANT_CODE, String GAME_API_URL) {
		this.API_URL = API_URL;
		this.MERCHANT_NAME = MERCHANT_NAME;
		this.MERCHANT_CODE = MERCHANT_CODE;
		this.GAME_API_URL = GAME_API_URL;
	}

	@Override
	public Object createAccount(Map<String, Object> entity) {
		BaseInterfaceLogUtil.addAPILog(this.getClass().getSimpleName(), "createAccount", entity.toString());
		try {
			return Enum_MSG.成功.message("创建账号成功");
		} catch (Exception ex) {
			ex.printStackTrace();
			return Enum_MSG.接口调用错误.message(ex.getMessage());
		}
	}

	@Override
	public Object getBalance(Map<String, Object> entity) {
		return null;
	}

	@Override
	public Object withdraw(Map<String, Object> entity) {
		return null;
	}

	@Override
	public Object deposit(Map<String, Object> entity) {
		return null;
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
		return null;

	}

	@Override
	public Object getOrder(Map<String, Object> entity) {
		return null;
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
				String requestUrl = this.GAME_API_URL + "?game=" + entity.get("gameName") + "&language=CH";
				return Enum_MSG.成功.message(requestUrl);
			} else {
				return Enum_MSG.参数错误.message(Enum_MSG.缺少必须的参数.desc);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			return Enum_MSG.接口调用错误.message(ex.getMessage());
		}
	}

	@Override
	public Object isOnLine(Map<String, Object> entity) {
		return null;
	}

	public static void main(String[] a) {

	}
}