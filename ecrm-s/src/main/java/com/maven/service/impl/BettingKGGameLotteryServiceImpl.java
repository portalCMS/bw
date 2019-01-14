package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingKGGameLotteryDao;
import com.maven.entity.BettingKGGameLottery;
import com.maven.service.BettingGameService;

@Service
public class BettingKGGameLotteryServiceImpl  extends BaseServiceImpl<BettingKGGameLottery> implements BettingGameService<BettingKGGameLottery>{

	@Autowired
	private BettingKGGameLotteryDao bettingKGGameLotteryDao;
	@Override
	public List<BettingKGGameLottery> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingKGGameLotteryDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingKGGameLottery> baseDao() {
		return bettingKGGameLotteryDao;
	}

	@Override
	public Class<BettingKGGameLottery> getClazz() {
		return BettingKGGameLottery.class;
	}
}
