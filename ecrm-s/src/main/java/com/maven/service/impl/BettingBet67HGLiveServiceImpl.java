package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67HGLiveDao;
import com.maven.entity.BettingBet67HGLive;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67HGLiveServiceImpl  extends BaseServiceImpl<BettingBet67HGLive> implements BettingGameService<BettingBet67HGLive>{

	@Autowired
	private BettingBet67HGLiveDao bettingBet67HGLiveDao;
	@Override
	public List<BettingBet67HGLive> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67HGLiveDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67HGLive> baseDao() {
		return bettingBet67HGLiveDao;
	}

	@Override
	public Class<BettingBet67HGLive> getClazz() {
		return BettingBet67HGLive.class;
	}
}
