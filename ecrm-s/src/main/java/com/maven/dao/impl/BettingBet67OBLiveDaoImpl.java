package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67OBLiveDao;
import com.maven.entity.BettingBet67OBLive;

@Repository
public class BettingBet67OBLiveDaoImpl extends BaseDaoImpl<BettingBet67OBLive> implements BettingBet67OBLiveDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67OBLive.takeRecordCountMoney", object);
	}

}
