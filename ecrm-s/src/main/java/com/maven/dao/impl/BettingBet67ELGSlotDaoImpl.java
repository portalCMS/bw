package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingBet67ELGSlotDao;
import com.maven.entity.BettingBet67ELGSlot;

@Repository
public class BettingBet67ELGSlotDaoImpl extends BaseDaoImpl<BettingBet67ELGSlot> implements BettingBet67ELGSlotDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingBet67ELGSlot.takeRecordCountMoney", object);
	}

}
