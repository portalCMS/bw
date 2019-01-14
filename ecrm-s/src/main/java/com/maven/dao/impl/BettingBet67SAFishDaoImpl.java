package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67SAFishDao;
import com.maven.entity.BettingBet67SAFish;

@Repository
public class BettingBet67SAFishDaoImpl extends BaseDaoImpl<BettingBet67SAFish> implements BettingBet67SAFishDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67SAFish.takeRecordCountMoney", object);
	}

}
