package com.maven.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.BaseDao;
import com.maven.entity.BettingBet67HYLive;
import com.maven.entity.BettingBet67OGLive;
@Repository
public interface BettingBet67OGLiveDao extends BaseDao<BettingBet67OGLive>{
	/**
	 * 获取游戏记录总数之金额统计
	 * @param object
	 * @return
	 */
	Map<String, Object> takeRecordCountMoney(Map<String, Object> object) throws Exception;
}
