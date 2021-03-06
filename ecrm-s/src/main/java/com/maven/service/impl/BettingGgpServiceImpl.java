package com.maven.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.BettingGbDao;
import com.maven.dao.BettingGgDao;
import com.maven.dao.BettingGgpDao;
import com.maven.dao.BettingHqNhqDao;
import com.maven.entity.BettingGb;
import com.maven.entity.BettingGg;
import com.maven.entity.BettingGgp;
import com.maven.entity.BettingHqNhq;
import com.maven.service.BettingGameService;
@Service
public class BettingGgpServiceImpl extends BaseServiceImpl<BettingGgp> implements BettingGameService<BettingGgp> {
	
	@Autowired
	private BettingGgpDao bettingHqNhqDaoImpl;

	@Override
	public BaseDao<BettingGgp> baseDao() {
		return bettingHqNhqDaoImpl;
	}

	@Override
	public Class<BettingGgp> getClazz() {
		return BettingGgp.class;
	}

	@Override
	public List<BettingGgp> takeRecord(Map<String, Object> object) throws Exception {
		return super.selectAll(object);
	}

	@Override
	public int takeRecordCount(Map<String, Object> object) throws Exception {
		return super.selectAllCount(object);
	}
	/**
	 * 获取游戏记录总数之金额统计
	 * @param object
	 * @return
	 */
	@Override
	public Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception {
		return bettingHqNhqDaoImpl.takeRecordCountMoney(object);
	}
}
