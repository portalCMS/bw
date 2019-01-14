package com.maven.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.maven.base.service.BaseServcie;
import com.maven.entity.NBGameInfo;

@Service
public interface NBGameInfoService extends BaseServcie<NBGameInfo> {

	void addRecord(NBGameInfo nbGameInfo);

	NBGameInfo selectRecord(Map<String, Object> map);

	void deleteRecord(Map<String, Object> map);

	void updateRecord(NBGameInfo nbGameInfo);

}
