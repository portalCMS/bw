package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingNBDao;
import com.maven.entity.BettingNB;

@Repository
public class BettingNBDaoImpl extends BaseDaoImpl<BettingNB> implements BettingNBDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingNB.takeRecordCountMoney", object);
	}

}
