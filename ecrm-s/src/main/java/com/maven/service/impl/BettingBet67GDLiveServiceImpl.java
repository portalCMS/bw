package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67GDLiveDao;
import com.maven.entity.BettingBet67GDLive;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67GDLiveServiceImpl  extends BaseServiceImpl<BettingBet67GDLive> implements BettingGameService<BettingBet67GDLive>{

	@Autowired
	private BettingBet67GDLiveDao bettingBet67GDLiveDao;
	@Override
	public List<BettingBet67GDLive> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67GDLiveDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67GDLive> baseDao() {
		return bettingBet67GDLiveDao;
	}

	@Override
	public Class<BettingBet67GDLive> getClazz() {
		return BettingBet67GDLive.class;
	}
}
