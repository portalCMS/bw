package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67HYLiveDao;
import com.maven.entity.BettingBet67HYLive;

@Repository
public class BettingBet67HYLiveDaoImpl extends BaseDaoImpl<BettingBet67HYLive> implements BettingBet67HYLiveDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67HYLive.takeRecordCountMoney", object);
	}

}
