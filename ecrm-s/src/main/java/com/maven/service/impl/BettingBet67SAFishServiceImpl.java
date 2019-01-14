package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67SAFishDao;
import com.maven.entity.BettingBet67SAFish;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67SAFishServiceImpl  extends BaseServiceImpl<BettingBet67SAFish> implements BettingGameService<BettingBet67SAFish>{

	@Autowired
	private BettingBet67SAFishDao bettingBet67SAFishDao;
	@Override
	public List<BettingBet67SAFish> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67SAFishDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67SAFish> baseDao() {
		return bettingBet67SAFishDao;
	}

	@Override
	public Class<BettingBet67SAFish> getClazz() {
		return BettingBet67SAFish.class;
	}
}
