package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67HGLiveDao;
import com.maven.entity.BettingBet67HGLive;

@Repository
public class BettingBet67HGLiveDaoImpl extends BaseDaoImpl<BettingBet67HGLive> implements BettingBet67HGLiveDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67HGLive.takeRecordCountMoney", object);
	}

}
