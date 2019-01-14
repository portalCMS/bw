package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67OGLotteryDao;
import com.maven.entity.BettingBet67OGLottery;

@Repository
public class BettingBet67OGLotteryDaoImpl extends BaseDaoImpl<BettingBet67OGLottery> implements BettingBet67OGLotteryDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67OGLottery.takeRecordCountMoney", object);
	}

}
