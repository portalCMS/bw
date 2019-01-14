package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingYSBDao;
import com.maven.entity.BettingYSB;
import com.maven.service.BettingGameService;

@Service
public class BettingYSBServiceImpl  extends BaseServiceImpl<BettingYSB> implements BettingGameService<BettingYSB>{

	@Autowired
	private BettingYSBDao bettingYSBDao;
	@Override
	public List<BettingYSB> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingYSBDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingYSB> baseDao() {
		return bettingYSBDao;
	}

	@Override
	public Class<BettingYSB> getClazz() {
		return BettingYSB.class;
	}
}
