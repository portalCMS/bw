package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67AGFishDao;
import com.maven.entity.BettingBet67AGFish;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67AGFishServiceImpl extends BaseServiceImpl<BettingBet67AGFish> implements BettingGameService<BettingBet67AGFish>{
	@Autowired
	private BettingBet67AGFishDao bettingBet67AGFishDao;
	
	@Override
	public List<BettingBet67AGFish> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67AGFishDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67AGFish> baseDao() {
		return bettingBet67AGFishDao;
	}

	@Override
	public Class<BettingBet67AGFish> getClazz() {
		return BettingBet67AGFish.class;
	}

}
