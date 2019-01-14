package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingKGGameLotteryDao;
import com.maven.entity.BettingKGGameLottery;

@Repository
public class BettingKGGameLotteryDaoImpl extends BaseDaoImpl<BettingKGGameLottery> implements BettingKGGameLotteryDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingKGGameLottery.takeRecordCountMoney", object);
	}

}
