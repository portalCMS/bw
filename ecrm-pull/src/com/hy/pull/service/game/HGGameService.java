package com.hy.pull.service.game;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.hy.pull.common.util.DateUtil;
import com.hy.pull.common.util.game.HGGame;
import com.hy.pull.mapper.ApiHGGameinfoMapper;
import com.hy.pull.mapper.DataHandleMapper;
import com.hy.pull.mapper.TbProxyKeyMapper;
import com.hy.pull.service.BaseService;

@Service
public class HGGameService extends BaseService {
	private Logger logger = LoggerFactory.getLogger(HGGameService.class);
	
	private final static String HG_QUERY_TIME_FORMAT  = "yyyy/MM/dd HH:mm:ss";

	private final static String HG_SAVE_TIME_FORMAT = "yyyy/MM/dd HH:mm:ss";
			
	@Autowired
	private ApiHGGameinfoMapper apiHGGameinfoMapper;
	@Autowired
	private TbProxyKeyMapper tbProxyKeyMapper;
	@Autowired
	private DataHandleMapper dataHandleMapper;

	@Override
	public Integer pullData(Map<String, Object> entity) throws Exception {
		Map<String, Object> dataHandle = dataHandleMapper.selectByPrimaryKey(LogUtil.HANDLE_HG_GAME);
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
			entity.put("GAME_ID", "40");
		}
		List<Map<String, Object>> list = tbProxyKeyMapper.selectByEntity(entity);
		int len = 0;
		int size = list.size();
		if (size > 0) {
			String apiUrl = null;// 接口URL
			String userName = null;
			String password = null;
			String casinoId  = null;
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
				userName = entity.get("PROXY_KEY1").toString();
				password = entity.get("PROXY_KEY2").toString();
				casinoId = entity.get("PROXY_MD5_KEY").toString();
				code = entity.get("PROXY_CODE") == null ? agent : entity.get("PROXY_CODE").toString();
				startId = mapMaxValue.get(code);
				map.put("apiUrl", apiUrl);
				map.put("userName", userName);
				map.put("password", password);
				map.put("casinoId", casinoId);
				//延迟10分钟
				Long nowTime = new Date().getTime()-600000;
				Long startTime = new SimpleDateFormat(HG_SAVE_TIME_FORMAT).parse(DateUtil.getDate2Str(DateUtil.add(new Date(), Calendar.DATE, -1),HG_SAVE_TIME_FORMAT)).getTime();
				if (startId != null) {// 如果为空则获取数据库最大值
					startTime = new SimpleDateFormat(HG_SAVE_TIME_FORMAT).parse(startId).getTime();
				} 
				while(startTime<nowTime){
					String hgQueryTimeStr = new SimpleDateFormat(HG_QUERY_TIME_FORMAT).format(new Date(startTime));
					String hgQueryTimeEnd = new SimpleDateFormat(HG_QUERY_TIME_FORMAT).format(new Date(startTime+600000));
					logger.info("HG游戏拉取时间************："+hgQueryTimeStr+"**********"+hgQueryTimeEnd);
					map.put("startTime",formatTimeToHG(hgQueryTimeStr));
					map.put("endTime",formatTimeToHG(hgQueryTimeEnd));
					logger.info("******map：" + map);
					data = HGGame.collectionData(map);// 获取拉取数据列表;
					if (data != null) {
						Map<String, Object> conditionMap =new HashMap<>();
						for (int j = 0; j < data.size(); j++) {
							conditionMap.put("betId", data.get(j).get("BetId"));
							if(null !=apiHGGameinfoMapper.selectByEntity(conditionMap)){
								logger.info("BetId="+data.get(j).get("BetId")+"已存在，刪除記錄。");
								apiHGGameinfoMapper.delete(conditionMap);
								apiHGGameinfoMapper.deleteBetting(conditionMap);
								apiHGGameinfoMapper.deleteWinlost(conditionMap);
							}
						}
						len+= data.size();
					}
					if (len > 0) {// 如果有数据就入库
						apiHGGameinfoMapper.batchInsert(data);// 批量入库
						dataHandle.put("lastnum", Integer.parseInt(dataHandle.get("lastnum").toString()) + len);
						dataHandle.put("allnum", Integer.parseInt(dataHandle.get("allnum").toString()) + len);
					}
					mapMaxValue.put(code, new SimpleDateFormat(HG_SAVE_TIME_FORMAT).format(new Date(startTime)));// 更新
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
		String startTimeStr = entity.get("BEGIN_DATE").toString().replace("-", "/");
		String endTimeStr = entity.get("END_DATE").toString().replace("-", "/");
		Map<String, Object> dataHandle = dataHandleMapper.selectByPrimaryKey(LogUtil.HANDLE_HG_GAME);
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
			entity.put("GAME_ID", "40");
		}
		List<Map<String, Object>> list = tbProxyKeyMapper.selectByEntity(entity);
		int len = 0;
		int size = list.size();
		if (size > 0) {
			String apiUrl = null;// 接口URL
			String userName = null;
			String password = null;
			String casinoId  = null;
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
				userName = entity.get("PROXY_KEY1").toString();
				password = entity.get("PROXY_KEY2").toString();
				casinoId = entity.get("PROXY_MD5_KEY").toString();
				code = entity.get("PROXY_CODE") == null ? agent : entity.get("PROXY_CODE").toString();
				startId = mapMaxValue.get(code);
				map.put("apiUrl", apiUrl);
				map.put("userName", userName);
				map.put("password", password);
				map.put("casinoId", casinoId);
				//半小时补一次单
				Long  endTime = new Date().getTime();
				Long startTime = endTime - 1800000;
				
				if(null!=startTimeStr&&null!=endTimeStr){
					startTime = new SimpleDateFormat(HG_QUERY_TIME_FORMAT).parse(startTimeStr).getTime();
					endTime = new SimpleDateFormat(HG_QUERY_TIME_FORMAT).parse(endTimeStr).getTime();
				}
				//while(startTime<endTime){
					String hgQueryTimeStr = new SimpleDateFormat(HG_QUERY_TIME_FORMAT).format(new Date(startTime));
					String hgQueryTimeEnd = new SimpleDateFormat(HG_QUERY_TIME_FORMAT).format(new Date(endTime));
					logger.info("HG游戏补单拉取时间************："+hgQueryTimeStr+"**********"+hgQueryTimeEnd);
					map.put("startTime",formatTimeToHG(hgQueryTimeStr));
					map.put("endTime",formatTimeToHG(hgQueryTimeEnd));
					logger.info("******map：" + map);
					data = HGGame.collectionData(map);// 获取拉取数据列表;
					if (data != null) {
						Map<String, Object> conditionMap =new HashMap<>();
						for (int j = 0; j < data.size(); j++) {
							conditionMap.put("betId", data.get(j).get("BetId"));
							List<Map<String,Object>> selectByEntityMap = apiHGGameinfoMapper.selectByEntity(conditionMap);
							if(null ==selectByEntityMap||selectByEntityMap.size()==0){
								dataLoss.add(data.get(j));
							}
						}
					}
					//startTime+=600000;
				//}
				len+= dataLoss.size();
				if (len > 0) {// 如果有数据就入库
					apiHGGameinfoMapper.batchInsert(dataLoss);// 批量入库
				}
				}
				logger.info("本次补单拉取返回结果：" + data);
				logger.info("HG游戏数据补单拉取结束。。。");
		}
		return len;
	}
	
	private static String formatTimeToHG(String dateStr) {
		SimpleDateFormat sdf = new SimpleDateFormat(HG_QUERY_TIME_FORMAT, Locale.ENGLISH);
		TimeZone timeZone = TimeZone.getTimeZone("GMT+8");
		sdf.setTimeZone(timeZone);
		try {
			Date date = sdf.parse(dateStr);
			sdf = new SimpleDateFormat(HG_QUERY_TIME_FORMAT);
			timeZone = TimeZone.getTimeZone("GMT+0");
			sdf.setTimeZone(timeZone);
			return sdf.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
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
