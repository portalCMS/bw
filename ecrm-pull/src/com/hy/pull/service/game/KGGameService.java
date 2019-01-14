package com.hy.pull.service.game;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.hy.pull.common.util.DateUtil;
import com.hy.pull.common.util.game.KGGame;
import com.hy.pull.mapper.ApiKGGameinfoMapper;
import com.hy.pull.mapper.DataHandleMapper;
import com.hy.pull.mapper.TbProxyKeyMapper;
import com.hy.pull.service.BaseService;

@Service
public class KGGameService extends BaseService {
	private Logger logger = LoggerFactory.getLogger(KGGameService.class);
	
	private final String KG_QUERY_TIME_FORMAT  = "yyyy-MM-dd HH:mm";

	private final String KG_SAVE_TIME_FORMAT = "yyyy-MM-dd HH:mm";
			
	@Autowired
	private ApiKGGameinfoMapper apiKGGameinfoMapper;

	@Autowired
	private TbProxyKeyMapper tbProxyKeyMapper;

	@Autowired
	private DataHandleMapper dataHandleMapper;

	@Override
	public Integer pullData(Map<String, Object> entity) throws Exception {
		Map<String, Object> dataHandle = dataHandleMapper.selectByPrimaryKey(LogUtil.HANDLE_KG_GAME);
		if(null==dataHandle){
			dataHandle = new HashMap<String, Object>();
		}
		dataHandle.put("lastnum", "0");
		String updatetime = dataHandle.get("updatetime").toString();// agent=10;agent=10;
		String[] maxvalue = updatetime.split(";");
		Map<String, String> mapMaxValue = new HashMap<String, String>();
		for (String string : maxvalue) {
			if (string != null && !string.equals("")) {
				mapMaxValue.put(string.split("=")[0], string.split("=")[1]);
			}
		}
		List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
		if (entity == null) {// 判断是否为空，空则创建一个新的对象
			entity = new HashMap<String, Object>();
		}
		if (!entity.containsKey("GAME_ID")) {
			entity.put("GAME_ID", "38");
		}
		List<Map<String, Object>> list = tbProxyKeyMapper.selectByEntity(entity);
		int len = 0;
		int size = list.size();
		if (size > 0) {
			String apiUrl = null;// 接口URL
			String vendorId = null;
			String secretKey = null;
			String agent = null;// 代理名称
			String startId = null;// 最大id
			String code = null;// 代理编码
			if (entity.get("MAX_VALUE") != null) {// 判断是否存在最大值
				startId = entity.get("MAX_VALUE").toString();
			}

			Map<String, Object> map = new HashMap<String, Object>();
			for (int i = 0; i < size; i++) {
				entity = list.get(i);
				logger.info("请求参数：" + entity.toString());
				apiUrl = entity.get("PROXY_API_URL").toString();
				//msgId = entity.get("PROXY_KEY1").toString();
				vendorId = entity.get("PROXY_KEY2").toString();
				secretKey = entity.get("PROXY_MD5_KEY").toString();
				code = entity.get("PROXY_CODE") == null ? agent : entity.get("PROXY_CODE").toString();
				startId = mapMaxValue.get(code);
				map.put("apiUrl", apiUrl);
				map.put("vendorId", vendorId);
				map.put("secretKey", secretKey);
				//延迟10分钟
				Long nowTime = new Date().getTime()-600000;
				Long startTime = new SimpleDateFormat(KG_SAVE_TIME_FORMAT).parse(DateUtil.getDate2Str(DateUtil.add(new Date(), Calendar.DATE, -1),KG_SAVE_TIME_FORMAT)).getTime();
				if (startId != null) {// 如果为空则获取数据库最大值
					startTime = new SimpleDateFormat(KG_SAVE_TIME_FORMAT).parse(startId).getTime();
				} 

				while(startTime<nowTime){
					String kgQueryTimeStr = new SimpleDateFormat(KG_QUERY_TIME_FORMAT).format(new Date(startTime))+":00";
					logger.info("KG游戏拉取时间************："+kgQueryTimeStr);
					map.put("Time",kgQueryTimeStr);
					logger.info("******map：" + map);
					data = KGGame.collectionData(map);// 获取拉取数据列表;
					if (data != null) {
						Map<String, Object> conditionMap =new HashMap<>();
						for (int j = 0; j < data.size(); j++) {
							conditionMap.put("betId", data.get(j).get("betId"));
							if(null !=apiKGGameinfoMapper.selectByEntity(conditionMap)){
								logger.info("betId="+data.get(j).get("betId")+"已存在，刪除記錄。");
								apiKGGameinfoMapper.delete(conditionMap);
								apiKGGameinfoMapper.deleteBetting(conditionMap);
								apiKGGameinfoMapper.deleteWinlost(conditionMap);
							}
						}
						len+= data.size();
					}
					if (data.size() > 0) {// 如果有数据就入库
						apiKGGameinfoMapper.batchInsert(data);// 批量入库
						dataHandle.put("lastnum", Integer.parseInt(dataHandle.get("lastnum").toString()) + len);
						dataHandle.put("allnum", Integer.parseInt(dataHandle.get("allnum").toString()) + len);
					}
					mapMaxValue.put(code, new SimpleDateFormat(KG_SAVE_TIME_FORMAT).format(new Date(startTime)));// 更新
					//循环一次加10分钟
					startTime+=600000;
				}
				logger.info("本次拉取返回结果：" + data);
			}
			//if (!CollectionUtils.isEmpty(data)) {
				String value = "";
				for (String key : mapMaxValue.keySet()) {
					value += (key + "=" + mapMaxValue.get(key) + ";");
				}
				dataHandle.put("updatetime", value);
			//}
			dataHandle.put("lasttime", DateUtil.parse(new Date(), "yyyyMMddHHmmss"));
			dataHandleMapper.update(dataHandle);
		}
		logger.info("KG游戏数据拉取结束。。。");
		return len;
	}
	public Integer pullDataLoss(Map<String, Object> entity) throws Exception {
		String startTimeStr = entity.get("BEGIN_DATE").toString();
		String endTimeStr = entity.get("END_DATE").toString();
		Map<String, Object> dataHandle = dataHandleMapper.selectByPrimaryKey(LogUtil.HANDLE_KG_GAME);
		if(null==dataHandle){
			dataHandle = new HashMap<String, Object>();
		}
		dataHandle.put("lastnum", "0");
		String updatetime = dataHandle.get("updatetime").toString();// agent=10;agent=10;
		String[] maxvalue = updatetime.split(";");
		Map<String, String> mapMaxValue = new HashMap<String, String>();
		for (String string : maxvalue) {
			if (string != null && !string.equals("")) {
				mapMaxValue.put(string.split("=")[0], string.split("=")[1]);
			}
		}
		List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> dataLoss = new ArrayList<Map<String, Object>>();
		if (entity == null) {// 判断是否为空，空则创建一个新的对象
			entity = new HashMap<String, Object>();
		}
		if (!entity.containsKey("GAME_ID")) {
			entity.put("GAME_ID", "38");
		}
		List<Map<String, Object>> list = tbProxyKeyMapper.selectByEntity(entity);
		int len = 0;
		int size = list.size();
		if (size > 0) {
			String apiUrl = null;// 接口URL
			String vendorId = null;
			String secretKey = null;
			String agent = null;// 代理名称
			String startId = null;// 最大id
			String code = null;// 代理编码
			if (entity.get("MAX_VALUE") != null) {// 判断是否存在最大值
				startId = entity.get("MAX_VALUE").toString();
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			for (int i = 0; i < size; i++) {
				entity = list.get(i);
				logger.info("请求参数：" + entity.toString());
				apiUrl = entity.get("PROXY_API_URL").toString();
				//msgId = entity.get("PROXY_KEY1").toString();
				vendorId = entity.get("PROXY_KEY2").toString();
				secretKey = entity.get("PROXY_MD5_KEY").toString();
				code = entity.get("PROXY_CODE") == null ? agent : entity.get("PROXY_CODE").toString();
				startId = mapMaxValue.get(code);
				map.put("apiUrl", apiUrl);
				map.put("vendorId", vendorId);
				map.put("secretKey", secretKey);
				//延迟10分钟
				Long nowTime = new Date().getTime()-600000;
				Long startTime = new Date().getTime()-1800000;
				if(null!=startTimeStr&&null!=endTimeStr){
					 startTime = new SimpleDateFormat(KG_QUERY_TIME_FORMAT).parse(startTimeStr).getTime();
					 nowTime = new SimpleDateFormat(KG_QUERY_TIME_FORMAT).parse(endTimeStr).getTime();
				}
				while(startTime<nowTime){
					String kgQueryTimeStr = new SimpleDateFormat(KG_QUERY_TIME_FORMAT).format(new Date(startTime))+":00";
					logger.info("KG补单游戏拉取时间************："+kgQueryTimeStr);
					logger.info("KG补单游戏拉取时间************："+kgQueryTimeStr);
					map.put("Time",kgQueryTimeStr);
					logger.info("******map：" + map);
					data = KGGame.collectionData(map);// 获取拉取数据列表;
					if (data != null) {
						dataLoss = new ArrayList<Map<String, Object>>();
						Map<String, Object> conditionMap =new HashMap<>();
						for (int j = 0; j < data.size(); j++) {
							conditionMap.put("betId", data.get(j).get("betId"));
							List<Map<String,Object>> selectByEntityMap =apiKGGameinfoMapper.selectByEntity(conditionMap);
							if(null ==selectByEntityMap||selectByEntityMap.size()==0){
								logger.info("betId="+data.get(j).get("betId")+"不存在，添加記錄。");
								dataLoss.add(data.get(j));
							}
						}
						len+= dataLoss.size();
					}
					if (dataLoss.size() > 0) {// 如果有数据就入库
						apiKGGameinfoMapper.batchInsert(dataLoss);// 批量入库
					}
					//循环一次加10分钟
					startTime+=600000;
				}
				logger.info("本次拉取返回结果：" + data);
			}
		}
		logger.info("KG游戏补单数据拉取结束。。。");
		return len;
	}
	public static void main(String[] args)  {
		
		try {
			Date endTime = new Date();
			Long startTime = new SimpleDateFormat("yyyyMMddHHmm").parse("201805312300").getTime();
			while(startTime<endTime.getTime()){
			//map.put("Time", "2018-05-30 14:40:00");
			
			String dd = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date(startTime))+":00";
			System.out.println("KG游戏拉取时间："+dd);
			
			startTime+=600000;
			//System.out.println("KG游戏拉取时间startTime："+startTime+"endTime.getTime():"+endTime.getTime());
		}
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
}
