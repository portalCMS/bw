package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67TSSportDao;
import com.maven.entity.BettingBet67TSSport;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67TSSportServiceImpl  extends BaseServiceImpl<BettingBet67TSSport> implements BettingGameService<BettingBet67TSSport>{

	@Autowired
	private BettingBet67TSSportDao bettingBet67TSSportDao;
	@Override
	public List<BettingBet67TSSport> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67TSSportDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67TSSport> baseDao() {
		return bettingBet67TSSportDao;
	}

	@Override
	public Class<BettingBet67TSSport> getClazz() {
		return BettingBet67TSSport.class;
	}
}
