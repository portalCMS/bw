package com.hy.pull.service.game;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.hy.pull.common.util.DateUtil;
import com.hy.pull.common.util.game.YSBGame;
import com.hy.pull.mapper.ApiYSBGameinfoMapper;
import com.hy.pull.mapper.DataHandleMapper;
import com.hy.pull.mapper.TbProxyKeyMapper;
import com.hy.pull.service.BaseService;

@Service
public class YSBGameService extends BaseService {
	private Logger logger = LoggerFactory.getLogger(YSBGameService.class);

	@Autowired
	private ApiYSBGameinfoMapper apiYSBGameinfoMapper;

	@Autowired
	private TbProxyKeyMapper tbProxyKeyMapper;

	@Autowired
	private DataHandleMapper dataHandleMapper;

	@Override
	public Integer pullData(Map<String, Object> entity) throws Exception {
		Map<String, Object> dataHandle = dataHandleMapper.selectByPrimaryKey(LogUtil.HANDLE_YSB_TY);
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
			entity.put("GAME_ID", "35");
		}
		List<Map<String, Object>> list = tbProxyKeyMapper.selectByEntity(entity);
		int size = list.size();
		if (size > 0) {
			String apiUrl = null;// 接口URL
			String msgId = null;
			String vendorId = null;
			String secretKey = null;
			String agent = null;// 代理名称
			String startId = null;// 最大id
			String code = null;// 代理编码
			if (entity.get("MAX_VALUE") != null) {// 判断是否存在最大值
				startId = entity.get("MAX_VALUE").toString();
			}
			int len = 0;

			Map<String, Object> map = new HashMap<String, Object>();
			for (int i = 0; i < size; i++) {
				entity = list.get(i);
				logger.info("请求参数：" + entity.toString());
				apiUrl = entity.get("PROXY_API_URL").toString();
				msgId = entity.get("PROXY_KEY1").toString();
				vendorId = entity.get("PROXY_KEY2").toString();
				secretKey = entity.get("PROXY_MD5_KEY").toString();
				code = entity.get("PROXY_CODE") == null ? agent : entity.get("PROXY_CODE").toString();
				startId = mapMaxValue.get(code);
				map.put("apiUrl", apiUrl);
				map.put("msgId", msgId);
				map.put("vendorId", vendorId);
				map.put("secretKey", secretKey);
				if (startId == null) {// 如果为空则获取数据库最大值
					map.put("dateFrom",
							DateUtil.getDate2Str(DateUtil.add(new Date(), Calendar.DATE, -6), "yyyy-MM-dd HH:mm:ss"));
					map.put("dateTo", DateUtil.getDate2Str(new Date(), "yyyy-MM-dd HH:mm:ss"));
				} else {
					map.put("dateFrom", startId);
					map.put("dateTo", DateUtil.getDate2Str(new Date(),"yyyy-MM-dd HH:mm:ss"));
				}
				data = YSBGame.collectionData(map);// 获取拉取数据列表;
				logger.info("本次拉取返回结果：" + data);
				if (data != null) {
					Map<String, Object> conditionMap =new HashMap<>();
					for (int j = 0; j < data.size(); j++) {
						conditionMap.put("betId", data.get(i).get("betId"));
						if(!CollectionUtils.isEmpty(apiYSBGameinfoMapper.selectByEntity(conditionMap))){
							logger.info("betId="+data.get(i).get("BetId")+"已存在，刪除記錄。");
							apiYSBGameinfoMapper.delete(conditionMap);
							apiYSBGameinfoMapper.deleteBetting(conditionMap);
							apiYSBGameinfoMapper.deleteWinlost(conditionMap);
						}
					}
					
					len = data.size();
					if (len > 0) {// 如果有数据就入库
						apiYSBGameinfoMapper.batchInsert(data);// 批量入库
//						long id = 0;
//						for (Map<String, Object> map2 : data) {
//							if (Long.valueOf(map2.get("betTime").toString()) > id) {
//								id = Long.valueOf(map2.get("betTime").toString());
//							}
//						}
//						dataHandle.put("lastnum", Integer.parseInt(dataHandle.get("lastnum").toString()) + len);
//						dataHandle.put("allnum", Integer.parseInt(dataHandle.get("allnum").toString()) + len);
					}
					mapMaxValue.put(code, map.get("dateTo")+"");// 更新
				}
			}

			if (!CollectionUtils.isEmpty(data)) {
				String value = "";
				for (String key : mapMaxValue.keySet()) {
					value += (key + "=" + mapMaxValue.get(key) + ";");
				}
				dataHandle.put("updatetime", value);
			}
			dataHandle.put("lasttime", DateUtil.parse(new Date(), "yyyyMMddHHmmss"));
			dataHandleMapper.update(dataHandle);
		}
		logger.info("YSB游戏数据拉取结束。。。");
		return 0;
	}
}
