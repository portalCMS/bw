package com.maven.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hy.pull.common.util.DateUtil;
import com.hy.pull.common.util.MoneyHelper;
import com.hy.pull.common.util.SCom;
import com.maven.entity.Enterprise;
import com.maven.entity.EnterpriseReportDates;
import com.maven.entity.EmployeeMoneyChangeType.Enum_moneychangetype;
import com.maven.logger.LoggerManager;
import com.maven.logger.OutputManager;
import com.maven.logger.SystemVisiteLog;
import com.maven.service.BettingAllDayService;
import com.maven.service.EnterpriseReportDatesService;
import com.maven.service.EnterpriseService;
import com.maven.util.SmsUtilPublic;



@Controller
@RequestMapping("/SystemVisite")
public class SystemVisiteLogController extends BaseController{
	
	@Autowired
	private EnterpriseReportDatesService enterpriseReportDatesService;
	
	@Autowired
	private EnterpriseService enterpriseService;
	
	@Autowired
	private BettingAllDayService bettingAllDayService;

	private static LoggerManager log = LoggerManager.getLogger(
			SystemVisiteLogController.class.getName(), OutputManager.LOG_SYSTEMVISITELOG);
	
	@RequestMapping("/ApiVisiteLog")
	public String VisiteLog(HttpServletRequest request,Model model){
		model.addAttribute("APILOG", new ArrayList<SystemVisiteLog>(SystemVisiteLog.getApiVisiteStat().values()));
		model.addAttribute("APILOGSWITH", SystemVisiteLog.isAPIVisiteLogSwith());
		return "/logger/apivisistelog";
	}
	
	@RequestMapping("/SysVisiteLog")
	public String SYSVisiteLog(HttpServletRequest request,Model model){
		model.addAttribute("APILOG", new ArrayList<SystemVisiteLog>(SystemVisiteLog.getSystemVisiteStat().values()));
		model.addAttribute("APILOGSWITH", SystemVisiteLog.isSysVisiteLogSwith());
		return "/logger/sysvisistelog";
	}
	
	@RequestMapping("/ApiSwith")
	public String SwithAPI(HttpServletRequest request,Model model){
		try {
			String  swith = request.getParameter("swith");
			if(swith.equals("on")){
				SystemVisiteLog.setAPIVisiteLogSwith(true);
			}else{
				SystemVisiteLog.setAPIVisiteLogSwith(false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.Error(e.getMessage(), e);
		}
		return "redirect:/SystemVisite/ApiVisiteLog";
	}
	
	@RequestMapping("/ApiCycleSwith")
	public String SwithAPICycleStat(HttpServletRequest request,Model model){
		try {
			String  url = request.getParameter("url");
			String  swith = request.getParameter("swith");
			SystemVisiteLog visiteLog = SystemVisiteLog.getApiVisiteStat().get(url);
			if(swith.equals("on")){
				visiteLog.setOpencyclestat(true);
			}else{
				visiteLog.setOpencyclestat(false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.Error(e.getMessage(), e);
		}
		return "redirect:/SystemVisite/ApiVisiteLog";
	}
	
	@RequestMapping("/SysSwith")
	public String SwithSYS(HttpServletRequest request,Model model){
		try {
			String  swith = request.getParameter("swith");
			if(swith.equals("on")){
				SystemVisiteLog.setSysVisiteLogSwith(true);
			}else{
				SystemVisiteLog.setSysVisiteLogSwith(false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.Error(e.getMessage(), e);
		}
		return "redirect:/SystemVisite/SysVisiteLog";
	}
	
	@RequestMapping("/SysCycleSwith")
	public String SwithSYSCycleStat(HttpServletRequest request,Model model){
		try {
			String  url = request.getParameter("url");
			String  swith = request.getParameter("swith");
			SystemVisiteLog visiteLog = SystemVisiteLog.getSystemVisiteStat().get(url);
			if(swith.equals("on")){
				visiteLog.setOpencyclestat(true);
			}else{
				visiteLog.setOpencyclestat(false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.Error(e.getMessage(), e);
		}
		return "redirect:/SystemVisite/SysVisiteLog";
	}
	
	@RequestMapping("/UpdateApiStatCycle")
	public String updateAPIStatCycle(HttpServletRequest request,Model model){
		try {
			String  url = request.getParameter("url");
			String  cycle = request.getParameter("cycle");
			SystemVisiteLog visiteLog = SystemVisiteLog.getApiVisiteStat().get(url);
			int statCycle = Integer.parseInt(cycle.trim());
			visiteLog.setStatcycle(statCycle);
		} catch (Exception e) {
			e.printStackTrace();
			log.Error(e.getMessage(), e);
		}
		return "redirect:/SystemVisite/ApiVisiteLog";
	}
	
	@RequestMapping("/UpdateSysStatCycle")
	public String updateSYSStatCycle(HttpServletRequest request,Model model){
		try {
			String  url = request.getParameter("url");
			String  cycle = request.getParameter("cycle");
			SystemVisiteLog visiteLog = SystemVisiteLog.getSystemVisiteStat().get(url);
			int statCycle = Integer.parseInt(cycle.trim());
			visiteLog.setStatcycle(statCycle);
		} catch (Exception e) {
			e.printStackTrace();
			log.Error(e.getMessage(), e);
		}
		return "redirect:/SystemVisite/SysVisiteLog";
	}
	
	@RequestMapping("/ApiCycleVisiteLog")
	public String viewApiCycleVisitLog(HttpServletRequest request,Model model){
		try {
			String  url = request.getParameter("url");
			SystemVisiteLog visiteLog = SystemVisiteLog.getApiVisiteStat().get(url);
			model.addAttribute("URL", visiteLog.getVisiteURL());
			model.addAttribute("APILOG", visiteLog.getCycle());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/logger/apivisistecyclelog";
	}
	
	@RequestMapping("/SysCycleVisiteLog")
	public String viewSysCycleVisitLog(HttpServletRequest request,Model model){
		try {
			String  url = request.getParameter("url");
			SystemVisiteLog visiteLog = SystemVisiteLog.getSystemVisiteStat().get(url);
			model.addAttribute("URL", visiteLog.getVisiteURL());
			model.addAttribute("APILOG", visiteLog.getCycle());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/logger/sysvisistecyclelog";
	}
	/**
	 *  手动重算计算今日报表
	 *  add by link
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping("/calcDayReport")
	public void calcDayReport(HttpServletRequest request,HttpServletResponse response,Model model){
		Integer reportdate = Integer.parseInt(request.getParameter("calcDate"));
		
		
		log.Error("#########################开始手动企业生成每日的报表统计数据#########################");
		try {
			//先删除计算日期的数据calcDate=20180306
			enterpriseReportDatesService.Cacldatedel(reportdate);
			
			List<Enterprise> es = enterpriseService.selectAll(new HashMap<String, Object>());
			List<EnterpriseReportDates> __list = new ArrayList<EnterpriseReportDates>();
			Date createtime = new Date();
			
			//int reportdate = SCom.getInt(DateUtil.parse(DateUtil.add(new Date(), Calendar.DATE, calcDate), "yyyyMMdd"));
			
			Map<String, Object> paramObj = new HashMap<String, Object>();
			
			//以企业级为基数执行
			for (Enterprise enterprise : es) { 
				String enterprisecode = enterprise.getEnterprisecode();
				
				paramObj.clear();
				paramObj.put("in_enterprisecode", enterprisecode);
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
				
				
				__list.add(
				new EnterpriseReportDates(enterprisecode, reportdate, memberRegeditCount,
						agentRegeditCount,  loginCount,  firstDepositCount,  firstDepositMoney,
						 secondDepositCount,  secondDepositMoney,  noSecondCount,  noThreeCount,
						 todayDepositCount,  todayDepositCount1,  todayDepositMoney,  todayTakeCount,
						 todayTakeCount1,  todayTakeMoney,  todayBetmoney,  todayNetmoney,
						 todayVaildmoney,  todayProsmoney,  todayConsmoney,  todayPreferentialCount,
						 todayPreferentialMoney,  todayWashCount,  todayWashMoney,  createtime));
			}
			
			if(__list.size() > 0) {
				enterpriseReportDatesService.saveBatchRecord(__list);
				log.Error("#########################批量生成记录数："+__list.size()+"条#########################");
			}
			
			response.getWriter().write("ok");
		} catch (Exception e) {
			e.printStackTrace();
			SmsUtilPublic.sendSmsByGet01(SmsUtilPublic.__NOTI_PHONENO, "企业生成每日的报表统计数据");
		}
		
		log.Error("#########################完成企业生成每日的报表统计数据#########################");
		
	}
	/**
	 * 手动计算利润报表
	 * add by link
	 * @param calcDate
	 * @throws Exception 
	 */
	@RequestMapping("/handCaclBettingAllDay")
	public void handCaclBettingAllDay(HttpServletResponse response,String betdate) throws Exception{
		String patchno = "99" +System.currentTimeMillis() + "";
		System.out.println("****************手动计算利润报表开始betdate:"+betdate+"  patchno:"+patchno);
		bettingAllDayService.updateDoPlanByHand(betdate, patchno);
		response.getWriter().write("ok");
	}
	
	
	@Override
	public LoggerManager getLogger() {
		return log;
	}

}
