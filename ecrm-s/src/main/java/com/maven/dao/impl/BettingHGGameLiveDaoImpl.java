package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingHGGameLiveDao;
import com.maven.entity.BettingHGGameLive;

@Repository
public class BettingHGGameLiveDaoImpl extends BaseDaoImpl<BettingHGGameLive> implements BettingHGGameLiveDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingHGGameLive.takeRecordCountMoney", object);
	}

}
