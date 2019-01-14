package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67AGFishDao;
import com.maven.entity.BettingBet67AGFish;

@Repository
public class BettingBet67AGFishDaoImpl extends BaseDaoImpl<BettingBet67AGFish> implements BettingBet67AGFishDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67AGFish.takeRecordCountMoney", object);
	}

}
