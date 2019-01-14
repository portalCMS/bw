package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67EbetLiveDao;
import com.maven.entity.BettingBet67EbetLive;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67EbetLiveServiceImpl  extends BaseServiceImpl<BettingBet67EbetLive> implements BettingGameService<BettingBet67EbetLive>{

	@Autowired
	private BettingBet67EbetLiveDao BettingBet67EbetLiveDao;
	@Override
	public List<BettingBet67EbetLive> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return BettingBet67EbetLiveDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67EbetLive> baseDao() {
		return BettingBet67EbetLiveDao;
	}

	@Override
	public Class<BettingBet67EbetLive> getClazz() {
		return BettingBet67EbetLive.class;
	}
}
