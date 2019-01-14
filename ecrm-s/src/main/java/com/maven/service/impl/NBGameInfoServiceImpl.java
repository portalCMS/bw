package com.maven.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maven.base.dao.BaseDao;
import com.maven.dao.NBGameInfoDao;
import com.maven.entity.NBGameInfo;
import com.maven.service.NBGameInfoService;

@Service
public class NBGameInfoServiceImpl extends BaseServiceImpl<NBGameInfo> implements NBGameInfoService{

	@Autowired
	private NBGameInfoDao nbGameInfoDao;
	@Override
	public BaseDao<NBGameInfo> baseDao() {
		return nbGameInfoDao;
	}

	@Override
	public Class<NBGameInfo> getClazz() {
		return NBGameInfo.class;
	}

	@Override
	public void addRecord(NBGameInfo nbGameInfo) {
		nbGameInfoDao.addRecord(nbGameInfo);
	}

	@Override
	public NBGameInfo selectRecord(Map<String, Object> map) {
		return nbGameInfoDao.selectRecord(map);
	}

	@Override
	public void deleteRecord(Map<String, Object> map) {
		nbGameInfoDao.deleteRecord(map);		
	}

	@Override
	public void updateRecord(NBGameInfo nbGameInfo) {
		nbGameInfoDao.updateRecord(nbGameInfo);		
	}


	
}
