package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67BBINLiveDao;
import com.maven.entity.BettingBet67BBINLive;

@Repository
public class BettingBet67BBINLiveDaoImpl extends BaseDaoImpl<BettingBet67BBINLive> implements BettingBet67BBINLiveDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67BBINLive.takeRecordCountMoney", object);
	}

}
