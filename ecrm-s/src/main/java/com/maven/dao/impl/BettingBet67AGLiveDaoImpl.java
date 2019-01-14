package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67AGLiveDao;
import com.maven.entity.BettingBet67AGLive;

@Repository
public class BettingBet67AGLiveDaoImpl extends BaseDaoImpl<BettingBet67AGLive> implements BettingBet67AGLiveDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67AGLive.takeRecordCountMoney", object);
	}

}
