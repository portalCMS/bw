package com.maven.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.BaseDao;
import com.maven.entity.BettingBet67ELGSlot;
import com.maven.entity.BettingBet67GDLive;

@Repository
public interface BettingBet67GDLiveDao extends BaseDao<BettingBet67GDLive> {
	/**
	 * 获取游戏记录总数之金额统计
	 * 
	 * @param object
	 * @return
	 */
	Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception;
}
