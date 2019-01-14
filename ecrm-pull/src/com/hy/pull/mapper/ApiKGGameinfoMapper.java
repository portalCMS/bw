package com.hy.pull.mapper;

import java.util.Map;

/**
 * 对应数据api_KG_gameinfo的操作接
 * @author link
 */
public interface ApiKGGameinfoMapper extends BaseMapper{
	
	int deleteBetting(Map<String, Object> entity);
	
	int deleteWinlost(Map<String, Object> entity);
}
