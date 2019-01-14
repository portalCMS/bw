package com.maven.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface PandectService {
	
	/**
	 * 列表-团队品牌贡献 
	 * @param object
	 * @return
	 */
	List<Map<String, Object>> usp_performanceForBrand(Map<String,Object> object) throws Exception;
	
	/**
	 * 列表-用户活跃度
	 * @param object
	 * @return
	 */
	List<Map<String,Object>> usp_useractivity(Map<String,Object> object) throws Exception;
	
	/**
	 * 总计-团队余额 
	 * @param object
	 * @return
	 */
	BigDecimal usp_balance(Map<String,Object> object) throws Exception;
	
	/**
	 * 总计-团队输赢
	 * @param object
	 * @return
	 */
	BigDecimal usp_takeLoseWin(Map<String,Object> object) throws Exception;
	
	/**
	 * 总计-团队存款
	 * @param object
	 * @return
	 */
	BigDecimal usp_savemoney(Map<String,Object> object) throws Exception;
	
	/**
	 * 总计-团队取款
	 * @param object
	 * @return
	 */
	BigDecimal usp_takemoney(Map<String,Object> object) throws Exception;
	
	
	/**
	 * 列表-团队贡献
	 * @param object
	 * @return
	 */
	List<Map<String,Object>> usp_performance(Map<String,Object> object) throws Exception;
	
	/**
	 * 总计-取款稽查
	 * @param object
	 * @return
	 */
	Map<String, Object> usp_takemoney_inspect(Map<String, Object> object) throws Exception ;

	/*============================== 新增功能 ==============================*/
	/**
	 * 日活跃用户数
	 * @param object
	 * @return
	 */
	BigDecimal dailyActiveMembers(Map<String,Object> object);
	
	/**
	 * 时活跃用户数
	 * @param object
	 * @return
	 */
	BigDecimal hoursActiveMembers(Map<String,Object> object);
	/**
	 * 日新注册用户数
	 * @param object
	 * @return
	 */
	BigDecimal dailyRegisteredMembers(Map<String,Object> object);
	/**
	 * 会员总数
	 * @param object
	 * @return
	 */
	BigDecimal totalMembers(Map<String,Object> object);
	/**
	 * 今日存款次数
	 * @param object
	 * @return
	 */
	BigDecimal dailyDeposits(Map<String,Object> object);
	/**
	 * 今日取款次数
	 * @param object
	 * @return
	 */
	BigDecimal dailyWithdrawals(Map<String,Object> object);
	/**
	 * 每日存款统计数据
	 * @param object
	 * @return
	 */
	Map<String, Object> uspDailyDepositReport(Map<String, Object> object);
	/**
	 * 每日取款统计数据
	 * @param object
	 * @return
	 */
	Map<String, Object> uspDailyWithdrawalReport(Map<String, Object> object);
}