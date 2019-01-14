package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67SLLiveDao;
import com.maven.entity.BettingBet67SLLive;

@Repository
public class BettingBet67SLLiveDaoImpl extends BaseDaoImpl<BettingBet67SLLive> implements BettingBet67SLLiveDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67SLLive.takeRecordCountMoney", object);
	}

}
