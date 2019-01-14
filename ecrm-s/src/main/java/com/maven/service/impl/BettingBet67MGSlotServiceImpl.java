package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67MGSlotDao;
import com.maven.entity.BettingBet67MGSlot;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67MGSlotServiceImpl  extends BaseServiceImpl<BettingBet67MGSlot> implements BettingGameService<BettingBet67MGSlot>{

	@Autowired
	private BettingBet67MGSlotDao bettingBet67MGSlotDao;
	@Override
	public List<BettingBet67MGSlot> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67MGSlotDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67MGSlot> baseDao() {
		return bettingBet67MGSlotDao;
	}

	@Override
	public Class<BettingBet67MGSlot> getClazz() {
		return BettingBet67MGSlot.class;
	}
}
