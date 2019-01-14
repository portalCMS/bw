package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67TSSportDao;
import com.maven.entity.BettingBet67TSSport;

@Repository
public class BettingBet67TSSportDaoImpl extends BaseDaoImpl<BettingBet67TSSport> implements BettingBet67TSSportDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67TSSport.takeRecordCountMoney", object);
	}

}
