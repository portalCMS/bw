package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67MGSlotDao;
import com.maven.entity.BettingBet67MGSlot;

@Repository
public class BettingBet67MGSlotDaoImpl extends BaseDaoImpl<BettingBet67MGSlot> implements BettingBet67MGSlotDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67MGSlot.takeRecordCountMoney", object);
	}

}
