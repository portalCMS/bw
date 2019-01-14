package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingHGGameLiveDao;
import com.maven.entity.BettingHGGameLive;
import com.maven.service.BettingGameService;

@Service
public class BettingHGGameLiveServiceImpl  extends BaseServiceImpl<BettingHGGameLive> implements BettingGameService<BettingHGGameLive>{

	@Autowired
	private BettingHGGameLiveDao bettingHGGameLiveDao;
	@Override
	public List<BettingHGGameLive> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingHGGameLiveDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingHGGameLive> baseDao() {
		return bettingHGGameLiveDao;
	}

	@Override
	public Class<BettingHGGameLive> getClazz() {
		return BettingHGGameLive.class;
	}
}
