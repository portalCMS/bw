package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingNBDao;
import com.maven.entity.BettingNB;
import com.maven.service.BettingGameService;

@Service
public class BettingNBServiceImpl  extends BaseServiceImpl<BettingNB> implements BettingGameService<BettingNB>{

	@Autowired
	private BettingNBDao bettingNBDao;
	@Override
	public List<BettingNB> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingNBDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingNB> baseDao() {
		return bettingNBDao;
	}

	@Override
	public Class<BettingNB> getClazz() {
		return BettingNB.class;
	}
}
