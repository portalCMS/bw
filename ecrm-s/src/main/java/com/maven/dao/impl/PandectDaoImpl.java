package com.maven.dao.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.maven.dao.PandectDao;

@Repository
public class PandectDaoImpl extends SqlSessionDaoSupport implements PandectDao {

	@Override
	public BigDecimal usp_takeLoseWin(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.usp_takeLoseWin", object);
	}

	@Override
	public List<Map<String, Object>> usp_performanceForBrand(Map<String, Object> object) {
		return getSqlSession().selectList("Pandect.usp_performanceForBrand", object);
	}

	@Override
	public List<Map<String, Object>> usp_useractivity(Map<String, Object> object) {
		return getSqlSession().selectList("Pandect.usp_useractivity", object);
	}

	@Override
	public BigDecimal usp_balance(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.usp_balance", object);
	}

	@Override
	public BigDecimal usp_savemoney(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.usp_savemoney", object);
	}

	@Override
	public BigDecimal usp_takemoney(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.usp_takemoney", object);
	}

	@Override
	public List<Map<String, Object>> usp_performance(Map<String, Object> object) {
		return getSqlSession().selectList("Pandect.usp_performance", object);
	}
	
	@Override
	public Map<String, Object> usp_takemoney_inspect(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.usp_takemoney_inspect", object);
	}

	/*============================== 新增功能 ==============================*/
	@Override
	public BigDecimal dailyActiveMembers(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.dailyActiveMembers", object);
	}

	@Override
	public BigDecimal hoursActiveMembers(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.hoursActiveMembers", object);
	}

	@Override
	public BigDecimal dailyRegisteredMembers(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.dailyRegisteredMembers", object);
	}

	@Override
	public BigDecimal totalMembers(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.totalMembers", object);
	}

	@Override
	public BigDecimal dailyDeposits(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.dailyDeposits", object);
	}

	@Override
	public BigDecimal dailyWithdrawals(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.dailyWithdrawals", object);
	}

	@Override
	public Map<String, Object> uspDailyDepositReport(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.ups_daily_deposit_report", object);
	}

	@Override
	public Map<String, Object> uspDailyWithdrawalReport(Map<String, Object> object) {
		return getSqlSession().selectOne("Pandect.ups_daily_withdrawal_report", object);
	}
}