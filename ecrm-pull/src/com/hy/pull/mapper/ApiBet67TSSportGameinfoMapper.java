package com.hy.pull.mapper;

import java.util.Map;

/**
 * 对应数据api_bet67_tssport_gameinfo的操作接
 * @author temdy
 */
public interface ApiBet67TSSportGameinfoMapper extends BaseMapper{

	int deleteBetting(Map<String, Object> entity);
	
	int deleteWinlost(Map<String, Object> entity);
}
