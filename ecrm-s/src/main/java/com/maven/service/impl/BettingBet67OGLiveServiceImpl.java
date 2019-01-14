package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67HYLiveDao;
import com.maven.dao.BettingBet67OGLiveDao;
import com.maven.entity.BettingBet67HYLive;
import com.maven.entity.BettingBet67OGLive;
import com.maven.entity.BettingBet67OGLive;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67OGLiveServiceImpl  extends BaseServiceImpl<BettingBet67OGLive> implements BettingGameService<BettingBet67OGLive>{

	@Autowired
	private BettingBet67OGLiveDao bettingBet67OgLiveDao;
	@Override
	public List<BettingBet67OGLive> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67OgLiveDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67OGLive> baseDao() {
		return bettingBet67OgLiveDao;
	}

	@Override
	public Class<BettingBet67OGLive> getClazz() {
		return BettingBet67OGLive.class;
	}
}
