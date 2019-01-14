package com.maven.dao;

import com.maven.base.dao.BaseDao;
import com.maven.entity.NBGameInfo;

import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface NBGameInfoDao extends BaseDao<NBGameInfo>{

	public void addRecord(NBGameInfo nbGameInfo);
	
	public NBGameInfo selectRecord(Map<String, Object> map);
	
	public void deleteRecord(Map<String, Object> map);
	
	public void updateRecord(NBGameInfo nbGameInfo);
}
