package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67AGLiveDao;
import com.maven.entity.BettingBet67AGLive;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67AGLiveServiceImpl  extends BaseServiceImpl<BettingBet67AGLive> implements BettingGameService<BettingBet67AGLive>{

	@Autowired
	private BettingBet67AGLiveDao bettingBet67AGLiveDao;
	@Override
	public List<BettingBet67AGLive> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67AGLiveDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67AGLive> baseDao() {
		return bettingBet67AGLiveDao;
	}

	@Override
	public Class<BettingBet67AGLive> getClazz() {
		return BettingBet67AGLive.class;
	}
}
