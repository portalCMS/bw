package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67EbetLiveDao;
import com.maven.entity.BettingBet67EbetLive;

@Repository
public class BettingBet67EbetLiveDaoImpl extends BaseDaoImpl<BettingBet67EbetLive> implements BettingBet67EbetLiveDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67EbetLive.takeRecordCountMoney", object);
	}

}
