package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67HYLiveDao;
import com.maven.dao.BettingBet67OGLiveDao;
import com.maven.entity.BettingBet67HYLive;
import com.maven.entity.BettingBet67OGLive;

@Repository
public class BettingBet67OGLiveDaoImpl extends BaseDaoImpl<BettingBet67OGLive> implements BettingBet67OGLiveDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67OGLive.takeRecordCountMoney", object);
	}

}
