package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67OGLotteryDao;
import com.maven.entity.BettingBet67OGLottery;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67OGLotteryServiceImpl  extends BaseServiceImpl<BettingBet67OGLottery> implements BettingGameService<BettingBet67OGLottery>{

	@Autowired
	private BettingBet67OGLotteryDao bettingBet67OGLotteryDao;
	@Override
	public List<BettingBet67OGLottery> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67OGLotteryDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67OGLottery> baseDao() {
		return bettingBet67OGLotteryDao;
	}

	@Override
	public Class<BettingBet67OGLottery> getClazz() {
		return BettingBet67OGLottery.class;
	}
}
