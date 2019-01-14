package com.maven.controller.game;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hy.pull.common.util.AESUtil2Net;
import com.hy.pull.common.util.DateUtil;
import com.maven.cache.SystemCache;
import com.maven.controller.BaseController;
import com.maven.entity.EmployeeApiAccout;
import com.maven.entity.EmployeeMoneyChangeType;
import com.maven.entity.EmployeeMoneyChangeType.Enum_moneychangetype;
import com.maven.entity.EmployeeMoneyChangeType.Enum_moneyinouttype;
import com.maven.entity.EnterpriseEmployeeCapitalAccount;
import com.maven.entity.NBGameInfo;
import com.maven.game.OrderNewUtil;
import com.maven.game.enums.GameEnum;
import com.maven.logger.LoggerManager;
import com.maven.service.EnterpriseEmployeeCapitalAccountService;
import com.maven.service.NBGameInfoService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/nbgame")
public class NBController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(NBController.class);

	// 200 SUCCESS 成功
	// 202 FAIL 失败
	// 403 UNAUTHORIZED 未登陆
	// 400 PARAMETER_ERROR 参数错误
	// 401 UNSIGNATURE 未注册的用户
	// 404 DATA_UNEXIST 数据不存在
	// 409 DATA_EXIST
	// 500 SYSTEM_ERROR 系统错误
	// 501 SYSTEM_DEFINE
	// 300 USER_UNEXIST 用户不存在
	// 301 USER_BALANCE_INSUFFICIENT 用户余额不足

	@Autowired
	private EnterpriseEmployeeCapitalAccountService capitalAccountService;
	
	@Autowired
	private NBGameInfoService nbGameInfoService;
	

	/**
	 * 校验token
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/checktoken")
	@ResponseBody
	public String checkToken(HttpServletRequest request, HttpServletResponse response) {
		JSONObject result = new JSONObject();
		try {
			String param = getRequestParam(request);
			logger.info("NB checktoken请求参数：" + param);
			JSONObject json = JSONObject.fromObject(param);
			byte[] decryptFrom = AESUtil2Net.parseHexStr2Byte(json.getString("token"));
			String token = AESUtil2Net.decryptAES(new String(decryptFrom, "utf-8"));
			logger.info("NB checkToken：" + token);
			EmployeeApiAccout eea = SystemCache.getInstance().getEmployeeGameAccount(token.split(",")[0],
					GameEnum.Enum_GameType.NB体育.gametype);
			logger.info("enterprisecode：" + eea.getEnterprisecode() + ",employeecode：" + eea.getEmployeecode());
			if (eea != null && eea.getEnterprisecode().equals(token.split(",")[1])) {
				result.put("code", 200);
				result.put("msg", "SUCCESS");
				JSONObject data = new JSONObject();
				data.put("userId", eea.getEmployeecode());
				EnterpriseEmployeeCapitalAccount ec = capitalAccountService.takeCurrencyAccount(eea.getEmployeecode());
				if(null ==ec){
					result.put("code", 300);
					result.put("msg", "USER_UNEXIST");
				}else{
					data.put("balance", ec.getBalance());
					data.put("currency", "CNY");
					result.put("data", data);
				}
			}else{
				result.put("code", 300);
				result.put("msg", "USER_UNEXIST");
				JSONObject data = new JSONObject();
				data.put("userId", eea.getEmployeecode());
				data.put("balance", "0");
				data.put("currency", "CNY");
				result.put("data", data);
			}
			logger.info("NB checktoken返回结果：" + param);
			return result.toString();
		} catch (Exception e) {
			logger.error("NB checkToken失败");
			result.put("code", "500");
			result.put("msg", "SYSTEM_ERROR");
		}
		return result.toString();
	}
	
	/**
	 * 查询余额
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/balance")
	@ResponseBody
	public String balance(HttpServletRequest request, HttpServletResponse response) {
		String param = getRequestParam(request);
		JSONObject result = new JSONObject();
		logger.info("查询NB余额请求参数：" + param);
		JSONObject json = JSONObject.fromObject(param);
		try {
			EnterpriseEmployeeCapitalAccount ec = capitalAccountService.takeCurrencyAccount(json.getString("userId"));
			if(ec ==null){
				result.put("code", "300");
				result.put("msg", "USER_UNEXIST");
			}else{
				result.put("code", 200);
				result.put("msg", "SUCCESS");
				JSONObject data =new JSONObject();
				data.put("userId", ec.getEmployeecode());
				data.put("balance", ec.getBalance());
				data.put("currency", "CNY");
				result.put("data", data);
			}
		} catch (Exception e) {
			logger.error("查询NB余额失败：",e);
			result.put("code", "500");
			result.put("msg", "SYSTEM_ERROR");
		}
		logger.info("查询NB余额返回：" + result.toString());
		return result.toString();
	}
	
	/**
	 * 预下单
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/booking")
	@ResponseBody
	public String booking(HttpServletRequest request, HttpServletResponse response) {
		JSONObject result = new JSONObject();
		String param = getRequestParam(request);
		logger.info("查询NB预下单请求参数：" + param);
		JSONObject json = JSONObject.fromObject(param);
		try {
			EnterpriseEmployeeCapitalAccount ec = capitalAccountService.takeCurrencyAccount(json.getString("userId"));
			if(ec ==null){
				result.put("code", "300");
				result.put("msg", "USER_UNEXIST");
			}else if(ec.getBalance().doubleValue()<json.getDouble("amount")){
				result.put("code", "301");
				result.put("msg", "USER_BALANCE_INSUFFICIENT");
			}else{
				result.put("code", 200);
				result.put("msg", "SUCCESS");
				JSONObject data =new JSONObject();
				data.put("userId", ec.getEmployeecode());
				data.put("balance", ec.getBalance());
				data.put("amount", json.getDouble("amount"));
				data.put("date", DateUtil.getTimestamp(new Date()));
				result.put("data", data);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", "500");
			result.put("msg", "SYSTEM_ERROR");
		}
		logger.info("查询NB预下单返回：" + result.toString());
		return result.toString();
	}

	/**
	 * 下单
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/order")
	@ResponseBody
	public String order(HttpServletRequest request, HttpServletResponse response) {
		JSONObject result = new JSONObject();
		String param = getRequestParam(request);
		logger.info("查询NB下单请求参数：" + param);
		JSONObject json = JSONObject.fromObject(param);
		try {
			EnterpriseEmployeeCapitalAccount ec = capitalAccountService.takeCurrencyAccount(json.getString("userId"));
			if(ec ==null){
				result.put("code", "300");
				result.put("msg", "USER_UNEXIST");
			}else if(ec.getBalance().doubleValue()<json.getDouble("orderAmount")){
				result.put("code", "301");
				result.put("msg", "USER_BALANCE_INSUFFICIENT");
			}else{
				String patchno =OrderNewUtil.getPatchno();
				double orderamount =json.getDouble("orderAmount");
				//扣除账户金额
				capitalAccountService.tc_updateCapitalAccount(patchno,ec.getEmployeecode(), new BigDecimal(orderamount).negate(),
						new EmployeeMoneyChangeType(Enum_moneychangetype.游戏上分.value,Enum_moneychangetype.游戏上分.desc,Enum_moneyinouttype.出账),"操作人:API "+Enum_moneychangetype.游戏上分.desc+"【NB】 批次号："+patchno);
				logger.info("NB用户:"+ec.getEmployeecode()+"下注， 扣除用户账户资金,金额："+orderamount+"...批次号："+patchno);
				
				EmployeeApiAccout eea = SystemCache.getInstance().getEmployeeGameAccount(ec.getEmployeecode(),
						GameEnum.Enum_GameType.NB体育.gametype);
				NBGameInfo nbGame = null;
				JSONObject data = null;
				for (int i = 0; i < json.getJSONArray("betList").size(); i++) {
					data = json.getJSONArray("betList").getJSONObject(i);
					nbGame =new NBGameInfo();
					nbGame.setUserId(json.getString("userId"));
					nbGame.setUserName(eea.getGameaccount());
					nbGame.setOrderNo(json.getString("orderNo"));
					nbGame.setBetId(data.getString("betNo"));
					nbGame.setBetAmount(data.getString("betAmount"));
					nbGame.setValidbet(data.getString("betAmount"));
					nbGame.setWinorloss("0");
					nbGame.setGameType(data.getString("betType"));
					nbGame.setBetTime(DateUtil.getCursorDate("yyyy-MM-dd HH:mm:ss"));
					
					data = data.getJSONArray("optionArray").getJSONObject(0);
					nbGame.setSportNo(data.getString("sportNo"));
					nbGame.setRaceName(data.getString("raceName"));
					nbGame.setMacthId(data.getString("macthId"));
					nbGame.setMacthName(data.getString("macthName"));
//					nbGame.setGameType(data.getString("gameType"));
//					nbGame.setGameName(data.getString("gameName"));
					nbGame.setOptionId(data.getString("optionId"));
					nbGame.setOptionName(data.getString("optionName"));
					nbGame.setOdds(data.getString("odds"));
					nbGameInfoService.addRecord(nbGame);
				}
				
				//返回下单结果
				result.put("code", 200);
				result.put("msg", "SUCCESS");
				JSONObject jsonData=new JSONObject();
				//下注后查询最新余额
				ec = capitalAccountService.takeCurrencyAccount(json.get("userId")+"");
				jsonData.put("userId", ec.getEmployeecode());
				jsonData.put("balance", ec.getBalance());
				jsonData.put("amount", json.getDouble("orderAmount"));
				jsonData.put("date", DateUtil.getTimestamp(new Date()));
				result.put("data", jsonData);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", "500");
			result.put("msg", "SYSTEM_ERROR");
		}
		logger.info("查询NB下单返回：" + result.toString());
		return result.toString();
	}
	
	/**
	 * 结算
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/settlement")
	@ResponseBody
	public String settlement(HttpServletRequest request, HttpServletResponse response) {
		JSONObject result = new JSONObject();
		String param = getRequestParam(request);
		logger.info("查询NB结算请求参数：" + param);
		JSONObject json = JSONObject.fromObject(param);
		Map<String, Object> map = new HashMap<>();
		map.put("betId", json.getString("betNo"));
		map.put("orderNo", json.getString("orderNo"));
		map.put("userId", json.getString("userId"));
		
		NBGameInfo nbGameInfo =nbGameInfoService.selectRecord(map);
		nbGameInfo.setBillTime(DateUtil.getCursorDate("yyyy-MM-dd HH:mm:ss"));
		double settlementAmount =json.getDouble("settlementAmount");
		double winOrLoss =settlementAmount-Double.valueOf(nbGameInfo.getBetAmount());
		if(json.getInt("reSettlement") ==1){
			logger.info("投注编号："+json.getString("betNo")+"重新结算。");
			winOrLoss = winOrLoss-Double.valueOf(nbGameInfo.getWinorloss());
			// 重新结算，加净输赢
			settlementAmount =winOrLoss;
		}
		nbGameInfo.setWinorloss(winOrLoss+"");
		nbGameInfoService.deleteRecord(map);
		nbGameInfoService.addRecord(nbGameInfo);
		//扣除账户金额
		if(settlementAmount >0){
			String patchno =OrderNewUtil.getPatchno();
			EnterpriseEmployeeCapitalAccount ec;
			try {
				ec = capitalAccountService.takeCurrencyAccount(json.getString("userId"));
				capitalAccountService.tc_updateCapitalAccount(patchno,ec.getEmployeecode(), new BigDecimal(settlementAmount),
						new EmployeeMoneyChangeType(Enum_moneychangetype.游戏下分.value,Enum_moneychangetype.游戏下分.desc,Enum_moneyinouttype.进账),"操作人:API "+Enum_moneychangetype.游戏下分.desc+"【NB】 批次号："+patchno);
				logger.info("NB用户:"+ec.getEmployeecode()+" 结算订单派奖，用户账户资金,金额："+winOrLoss+"...批次号："+patchno);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error("NB订单结算异常。",e);
				result.put("code", 202);
				result.put("msg", "FAIL");
			}
		}
		
		result.put("code", 200);
		result.put("msg", "success");
		return result.toString();
	}
	
	
	/**
	 * 取消注单
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/cancelbet")
	@ResponseBody
	public String cancelbet(HttpServletRequest request, HttpServletResponse response) {
		JSONObject result = new JSONObject();
		String param = getRequestParam(request);
		logger.info("查询NB取消注单请求参数：" + param);
		JSONObject json = JSONObject.fromObject(param);
		Map<String, Object> map = new HashMap<>();
		map.put("betId", json.getString("betNo"));
		map.put("orderNo", json.getString("orderNo"));
		map.put("userId", json.getString("userId"));
		
		nbGameInfoService.deleteRecord(map);
		double betAmount =json.getDouble("betAmount");
		//扣除账户金额
		String patchno =OrderNewUtil.getPatchno();
		EnterpriseEmployeeCapitalAccount ec;
		try {
			ec = capitalAccountService.takeCurrencyAccount(json.getString("userId"));
			capitalAccountService.tc_updateCapitalAccount(patchno,ec.getEmployeecode(), new BigDecimal(betAmount),
					new EmployeeMoneyChangeType(Enum_moneychangetype.游戏下分.value,Enum_moneychangetype.游戏下分.desc,Enum_moneyinouttype.进账),"操作人:API "+Enum_moneychangetype.游戏下分.desc+"【NB】 批次号："+patchno);
			logger.info("用户:"+ec.getEmployeecode()+" 取消订单，返还用户账户资金,金额："+betAmount+"...批次号："+patchno);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("NB取消注单异常。",e);
			result.put("code", 202);
			result.put("msg", "FAIL");
		}
		
		result.put("code", 200);
		result.put("msg", "success");
		return result.toString();
	}
	
	
	/**
	 * 取消预订单
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/cancelbooking")
	@ResponseBody
	public String cancelbooking(HttpServletRequest request, HttpServletResponse response) {
		JSONObject result = new JSONObject();
		String param = getRequestParam(request);
		logger.info("查询NB取消预订单请求参数：" + param);
		JSONObject json = JSONObject.fromObject(param);
		Map<String, Object> map = new HashMap<>();
		map.put("betId", json.getString("betNo"));
		map.put("orderNo", json.getString("orderNo"));
		map.put("userId", json.getString("userId"));
		
		nbGameInfoService.deleteRecord(map);
		double amount =json.getDouble("amount");
		//扣除账户金额
		String patchno =OrderNewUtil.getPatchno();
		EnterpriseEmployeeCapitalAccount ec;
		try {
			ec = capitalAccountService.takeCurrencyAccount(json.get("userId")+"");
			capitalAccountService.tc_updateCapitalAccount(patchno,ec.getEmployeecode(), new BigDecimal(amount),
					new EmployeeMoneyChangeType(Enum_moneychangetype.游戏下分.value,Enum_moneychangetype.游戏下分.desc,Enum_moneyinouttype.进账),"操作人:API "+Enum_moneychangetype.游戏下分.desc+"【NB】 批次号："+patchno);
			logger.info("用户:"+ec.getEmployeecode()+" 取消取消预订单，返还用户账户资金,金额："+amount+"...批次号："+patchno);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("NB取消注单异常。",e);
			result.put("code", 202);
			result.put("msg", "FAIL");
		}
		
		result.put("code", 200);
		result.put("msg", "success");
		return result.toString();
	}
	
	@Override
	public LoggerManager getLogger() {
		return null;
	}

	private String getRequestParam(HttpServletRequest request) {
		InputStreamReader reader = null;
		BufferedReader br = null;
		String param = "";
		try {
			StringBuffer sb = new StringBuffer();
			reader = new InputStreamReader(request.getInputStream());
			br = new BufferedReader(reader);
			while ((param = br.readLine()) != null) {
				sb.append(param);
			}
			param = sb.toString();
			logger.info("NB接口请求参数："+param);
			return param;
		} catch (Exception e) {
			logger.error("NB TOKEN验证失败", e);
		} finally {
			try {
				br.close();
				reader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
