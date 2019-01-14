package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67BBINLiveDao;
import com.maven.entity.BettingBet67BBINLive;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67BBINLiveServiceImpl  extends BaseServiceImpl<BettingBet67BBINLive> implements BettingGameService<BettingBet67BBINLive>{

	@Autowired
	private BettingBet67BBINLiveDao bettingBet67BBINLiveDao;
	@Override
	public List<BettingBet67BBINLive> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67BBINLiveDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67BBINLive> baseDao() {
		return bettingBet67BBINLiveDao;
	}

	@Override
	public Class<BettingBet67BBINLive> getClazz() {
		return BettingBet67BBINLive.class;
	}
}
