package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67HYLiveDao;
import com.maven.entity.BettingBet67HYLive;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67HYLiveServiceImpl  extends BaseServiceImpl<BettingBet67HYLive> implements BettingGameService<BettingBet67HYLive>{

	@Autowired
	private BettingBet67HYLiveDao bettingBet67HYLiveDao;
	@Override
	public List<BettingBet67HYLive> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67HYLiveDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67HYLive> baseDao() {
		return bettingBet67HYLiveDao;
	}

	@Override
	public Class<BettingBet67HYLive> getClazz() {
		return BettingBet67HYLive.class;
	}
}
