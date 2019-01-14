package com.maven.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.maven.base.dao.impl.BaseDaoImpl;
import com.maven.dao.NBGameInfoDao;
import com.maven.entity.NBGameInfo;

/**
 * @author 3hlxw
 * @Description: ${description}
 * @date 2018-05-24 18:05:56
 */
@Repository
public class NBGameInfoDaoImpl extends BaseDaoImpl<NBGameInfo> implements NBGameInfoDao {

	@Override
	public void addRecord(NBGameInfo nbGameInfo) {
		getSqlSession().insert("NBGameInfo.addRecord", nbGameInfo);
	}

	@Override
	public NBGameInfo selectRecord(Map<String, Object> map) {
		return getSqlSession().selectOne("NBGameInfo.selectRecord", map);
	}

	@Override
	public void deleteRecord(Map<String, Object> map) {
		getSqlSession().delete("NBGameInfo.deleteRecord", map);
	}

	@Override
	public void updateRecord(NBGameInfo nbGameInfo) {
		getSqlSession().update("NBGameInfo.updateRecord", nbGameInfo);
	}
}
