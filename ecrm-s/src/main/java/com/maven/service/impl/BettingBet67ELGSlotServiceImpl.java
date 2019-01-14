package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingBet67ELGSlotDao;
import com.maven.entity.BettingBet67ELGSlot;
import com.maven.service.BettingGameService;

@Service
public class BettingBet67ELGSlotServiceImpl  extends BaseServiceImpl<BettingBet67ELGSlot> implements BettingGameService<BettingBet67ELGSlot>{

	@Autowired
	private BettingBet67ELGSlotDao bettingBet67ELGSlotDao;
	@Override
	public List<BettingBet67ELGSlot> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingBet67ELGSlotDao.takeRecordCountMoney(object);
	}

	@Override
	public BaseDao<BettingBet67ELGSlot> baseDao() {
		return bettingBet67ELGSlotDao;
	}

	@Override
	public Class<BettingBet67ELGSlot> getClazz() {
		return BettingBet67ELGSlot.class;
	}
}
