package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.BettingYSBDao;
import com.maven.entity.BettingYSB;

@Repository
public class BettingYSBDaoImpl extends BaseDaoImpl<BettingYSB> implements BettingYSBDao {

	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return getSqlSession().selectOne("BettingYSB.takeRecordCountMoney", object);
	}

}
