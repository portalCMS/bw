package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67SLLiveDao;
import com.maven.entity.BettingBet67SLLive;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67SLLiveServiceImpl  extends BaseServiceImpl<BettingBet67SLLive> implements BettingGameService<BettingBet67SLLive>{

	@Autowired
	private BettingBet67SLLiveDao bettingBet67SLLiveDao;
	@Override
	public List<BettingBet67SLLive> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67SLLiveDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67SLLive> baseDao() {
		return bettingBet67SLLiveDao;
	}

	@Override
	public Class<BettingBet67SLLive> getClazz() {
		return BettingBet67SLLive.class;
	}
}
