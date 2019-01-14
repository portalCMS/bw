package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67GDLiveDao;
import com.maven.entity.BettingBet67GDLive;

@Repository
public class BettingBet67GDLiveDaoImpl extends BaseDaoImpl<BettingBet67GDLive> implements BettingBet67GDLiveDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67GDLive.takeRecordCountMoney", object);
	}

}
