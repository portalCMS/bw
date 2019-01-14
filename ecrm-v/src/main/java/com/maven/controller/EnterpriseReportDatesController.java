package com.maven.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hy.pull.common.util.DateUtil;
import com.hy.pull.common.util.MoneyHelper;
import com.hy.pull.common.util.SCom;
import com.maven.config.SystemConstant;
import com.maven.constant.Constant;
import com.maven.entity.EmployeeMoneyChangeType.Enum_moneychangetype;
import com.maven.entity.EnterpriseEmployee;
import com.maven.entity.EnterpriseReportDates;
import com.maven.logger.LoggerManager;
import com.maven.logger.OutputManager;
import com.maven.service.EnterpriseReportDatesService;
import com.maven.utils.StringUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/EnterpriseReportDates")
public class EnterpriseReportDatesController extends BaseController {

	private static LoggerManager log = LoggerManager.getLogger(BettingHqHqController.class.getName(),
			OutputManager.LOG_BETTINGALLDAY);
	@Autowired
	private EnterpriseReportDatesService enterpriseReportDatesService;
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	/**
	 * index
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/index")
	public String index(HttpServletRequest request, HttpSession session, Model model) {
		
		try {
			//获取7天内的日期
			Calendar ca = Calendar.getInstance();
			ca.add(Calendar.DATE, -7);
			String startDate = sdf.format(ca.getTime());
			model.addAttribute("startDate", startDate);
			
			String endDate = sdf.format(new Date());
			model.addAttribute("endDate", endDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/enterprise/reportDates";
	}

	/**
	 * list页面请求数据
	 * 
	 * @param request
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("/data")
	@ResponseBody
	public Map<String, Object> data(HttpServletRequest request, HttpSession session) {
		try {
			Map<String, Object> parameter = getRequestParamters(request);

			EnterpriseEmployee loginEmployee = (EnterpriseEmployee) session.getAttribute(Constant.USER_SESSION);

			/********* 非超级管理员时只能查询本团队内的数据 ************/
			if (!SystemConstant.getProperties("admin.employeecode").equals(loginEmployee.getEmployeecode())) {
				parameter.put("enterprisecode", loginEmployee.getEnterprisecode());
			}

			List<EnterpriseReportDates> betrecords = enterpriseReportDatesService.selectBetRecord(parameter);
			if(!parameter.containsKey("enterprisecode")) {
				for (EnterpriseReportDates enterpriseReportDates : betrecords) {
					enterpriseReportDates.setEnterprisecode(enterpriseReportDates.getReportdate()+"="+enterpriseReportDates.getEnterprisecode());
				}
			} else {
				for (EnterpriseReportDates enterpriseReportDates : betrecords) {
					enterpriseReportDates.setEnterprisecode(enterpriseReportDates.getReportdate().toString());
				}
			}
			Map<String, Object> summary = new HashMap<String, Object>();
			Map<String, Object> data = new HashMap<String,Object>();
			int reportdate = SCom.getInt(DateUtil.parse(DateUtil.add(new Date(), Calendar.DATE, 0), "yyyyMMdd"));
			if(String.valueOf(reportdate).equals(parameter.get("startDate").toString().trim())){ //查询今日数据
				Date createtime = new Date();
				
				Map<String, Object> paramObj = new HashMap<String, Object>();
				
				paramObj.clear();
				paramObj.put("in_enterprisecode", loginEmployee.getEnterprisecode());
				paramObj.put("in_reportdate", reportdate);
				List<EnterpriseReportDates> listdata = enterpriseReportDatesService.call_userDepositTakeReport(paramObj);
				
				int memberRegeditCount = SCom.getInt(paramObj.get("memberRegeditCount"));
				int agentRegeditCount = SCom.getInt(paramObj.get("agentRegeditCount"));
				int loginCount = SCom.getInt(paramObj.get("loginCount"));
				
				int firstDepositCount = SCom.getInt(paramObj.get("firstDepositCount"));
				double firstDepositMoney = SCom.getDouble(paramObj.get("firstDepositMoney"));
				
				int secondDepositCount = SCom.getInt(paramObj.get("secondDepositCount"));
				double secondDepositMoney = SCom.getDouble(paramObj.get("secondDepositMoney"));
				int noSecondCount = SCom.getInt(paramObj.get("noSecondCount"));
				int noThreeCount = SCom.getInt(paramObj.get("noThreeCount"));
				
				int todayDepositCount = SCom.getInt(paramObj.get("todayDepositCount"));
				int todayDepositCount1 = 0;//存款人次
				double todayDepositMoney = 0;
				
				int todayTakeCount = SCom.getInt(paramObj.get("todayTakeCount"));
				int todayTakeCount1 = 0;//取款人次
				double todayTakeMoney = 0;
				
				double todayBetmoney = SCom.getDouble(paramObj.get("todayBetmoney"));
				double todayNetmoney = SCom.getDouble(paramObj.get("todayNetmoney"));
				double todayVaildmoney = SCom.getDouble(paramObj.get("todayVaildmoney"));
				
				double todayProsmoney = 0;
				double todayConsmoney = 0;
				
				int todayPreferentialCount = 0;
				double todayPreferentialMoney = 0;
				
				int todayWashCount = 0;
				double todayWashMoney = 0;
				
				for (EnterpriseReportDates item : listdata) {
					String code = item.getMoneychangetypecode();
					String amount = item.getMoneychangeamount();
					String count = item.getMoneychangecount();
					
					if(Enum_moneychangetype.存款.value.equals(code)) {
						todayDepositCount1 = SCom.getInt(count);
						todayDepositMoney = SCom.getDouble(amount);
					} else if(Enum_moneychangetype.取款.value.equals(code) || 
							Enum_moneychangetype.取款驳回.value.equals(code) || 
							Enum_moneychangetype.取款拒绝.value.equals(code)) {
						todayTakeCount1 += SCom.getInt(count);
						todayTakeMoney += SCom.getDouble(amount);
					} else if(Enum_moneychangetype.冲正.value.equals(code)) {
						todayProsmoney = SCom.getDouble(amount);
					} else if(Enum_moneychangetype.冲负.value.equals(code)) {
						todayConsmoney = SCom.getDouble(amount);
					} else if(Enum_moneychangetype.优惠活动.value.equals(code)) {
						todayPreferentialCount = SCom.getInt(count);
						todayPreferentialMoney = SCom.getDouble(amount);
					} else if(Enum_moneychangetype.洗码日结.value.equals(code) ||
							 Enum_moneychangetype.周结校验补发.value.equals(code) ||
							 Enum_moneychangetype.洗码周结.value.equals(code) ||
							 Enum_moneychangetype.洗码冲减.value.equals(code) ) {
						todayWashCount += SCom.getInt(count);
						todayWashMoney += SCom.getDouble(amount);
					} 
				}
				
				firstDepositMoney = MoneyHelper.moneyFormatDouble(firstDepositMoney);
				secondDepositMoney = MoneyHelper.moneyFormatDouble(secondDepositMoney);
				todayDepositMoney = MoneyHelper.moneyFormatDouble(todayDepositMoney);
				todayTakeMoney = MoneyHelper.moneyFormatDouble(todayTakeMoney);
				todayBetmoney = MoneyHelper.moneyFormatDouble(todayBetmoney);
				todayNetmoney = MoneyHelper.moneyFormatDouble(todayNetmoney);
				todayVaildmoney = MoneyHelper.moneyFormatDouble(todayVaildmoney);
				todayProsmoney = MoneyHelper.moneyFormatDouble(todayProsmoney);
				todayConsmoney = MoneyHelper.moneyFormatDouble(todayConsmoney);
				todayPreferentialMoney = MoneyHelper.moneyFormatDouble(todayPreferentialMoney);
				todayWashMoney = MoneyHelper.moneyFormatDouble(todayWashMoney);
				EnterpriseReportDates enterpriseReportDates	= new EnterpriseReportDates(String.valueOf(reportdate), reportdate, memberRegeditCount,
						agentRegeditCount,  loginCount,  firstDepositCount,  firstDepositMoney,
						 secondDepositCount,  secondDepositMoney,  noSecondCount,  noThreeCount,
						 todayDepositCount,  todayDepositCount1,  todayDepositMoney,  todayTakeCount,
						 todayTakeCount1,  todayTakeMoney,  todayBetmoney,  todayNetmoney,
						 todayVaildmoney,  todayProsmoney,  todayConsmoney,  todayPreferentialCount,
						 todayPreferentialMoney,  todayWashCount,  todayWashMoney,  createtime);
				System.out.println("======今天数据报表"+JSONObject.fromObject(enterpriseReportDates));
				betrecords.add(enterpriseReportDates);
				data = super.formatPagaMap(betrecords, 1);
				summary.put("memberRegeditCount",memberRegeditCount);
				summary.put("agentRegeditCount", agentRegeditCount);
				summary.put("loginCount", loginCount);
				
				summary.put("firstDepositCount",firstDepositCount);
				summary.put("firstDepositMoney",firstDepositMoney);
				summary.put("secondDepositCount", secondDepositCount);
				summary.put("secondDepositMoney",secondDepositMoney);
				
				summary.put("todayDepositCount", todayDepositCount);
				summary.put("todayDepositCount1",todayDepositCount1);
				summary.put("todayDepositMoney",todayDepositMoney);
				
				summary.put("todayTakeCount",todayTakeCount);
				summary.put("todayTakeCount1",todayTakeCount1);
				summary.put("todayTakeMoney", todayTakeMoney);
				
				summary.put("todayBetmoney",todayBetmoney);
				summary.put("todayNetmoney", todayNetmoney);
				summary.put("todayVaildmoney",todayVaildmoney);
				
				summary.put("todayProsmoney",todayProsmoney);
				summary.put("todayConsmoney",todayConsmoney);
				summary.put("todayPreferentialCount",todayPreferentialCount);
				summary.put("todayPreferentialMoney",todayPreferentialMoney);
				
				summary.put("todayWashCount",todayWashCount);
				summary.put("todayWashMoney",todayWashMoney);
			}else{
				Map<String, Object> result = enterpriseReportDatesService.selectBetRecordCountMoney(parameter);
				int countRecord = StringUtil.getInt(result.get("count"));
				data = super.formatPagaMap(betrecords, countRecord);
				summary.put("memberRegeditCount", StringUtil.getDouble(result.get("memberRegeditCount")));
				summary.put("agentRegeditCount", StringUtil.getDouble(result.get("agentRegeditCount")));
				summary.put("loginCount", StringUtil.getDouble(result.get("loginCount")));
				
				summary.put("firstDepositCount", StringUtil.getDouble(result.get("firstDepositCount")));
				summary.put("firstDepositMoney", StringUtil.getDouble(result.get("firstDepositMoney")));
				summary.put("secondDepositCount", StringUtil.getDouble(result.get("secondDepositCount")));
				summary.put("secondDepositMoney", StringUtil.getDouble(result.get("secondDepositMoney")));
				
				summary.put("todayDepositCount", StringUtil.getDouble(result.get("todayDepositCount")));
				summary.put("todayDepositCount1", StringUtil.getDouble(result.get("todayDepositCount1")));
				summary.put("todayDepositMoney", StringUtil.getDouble(result.get("todayDepositMoney")));
				
				summary.put("todayTakeCount", StringUtil.getDouble(result.get("todayTakeCount")));
				summary.put("todayTakeCount1", StringUtil.getDouble(result.get("todayTakeCount1")));
				summary.put("todayTakeMoney", StringUtil.getDouble(result.get("todayTakeMoney")));
				
				summary.put("todayBetmoney", StringUtil.getDouble(result.get("todayBetmoney")));
				summary.put("todayNetmoney", StringUtil.getDouble(result.get("todayNetmoney")));
				summary.put("todayVaildmoney", StringUtil.getDouble(result.get("todayVaildmoney")));
				
				summary.put("todayProsmoney", StringUtil.getDouble(result.get("todayProsmoney")));
				summary.put("todayConsmoney", StringUtil.getDouble(result.get("todayConsmoney")));
				summary.put("todayPreferentialCount", StringUtil.getDouble(result.get("todayPreferentialCount")));
				summary.put("todayPreferentialMoney", StringUtil.getDouble(result.get("todayPreferentialMoney")));
				
				summary.put("todayWashCount", StringUtil.getDouble(result.get("todayWashCount")));
				summary.put("todayWashMoney", StringUtil.getDouble(result.get("todayWashMoney")));
				
			}
			
			data.put("summary", summary);
			
			return data;
			
		} catch (Exception e) {
			log.Error(e.getMessage(), e);
			return null;
		}
	}

	
	@Override
	public LoggerManager getLogger() {
		return log;
	}
}