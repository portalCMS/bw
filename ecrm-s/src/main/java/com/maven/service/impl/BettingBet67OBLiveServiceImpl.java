package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67OBLiveDao;
import com.maven.entity.BettingBet67OBLive;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67OBLiveServiceImpl  extends BaseServiceImpl<BettingBet67OBLive> implements BettingGameService<BettingBet67OBLive>{

	@Autowired
	private BettingBet67OBLiveDao bettingBet67OBLiveDao;
	@Override
	public List<BettingBet67OBLive> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67OBLiveDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67OBLive> baseDao() {
		return bettingBet67OBLiveDao;
	}

	@Override
	public Class<BettingBet67OBLive> getClazz() {
		return BettingBet67OBLive.class;
	}
}
