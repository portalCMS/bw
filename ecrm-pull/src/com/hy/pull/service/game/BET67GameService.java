package com.hy.pull.service.game;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hy.pull.common.util.DateUtil;
import com.hy.pull.common.util.game.BET67Game;
import com.hy.pull.mapper.ApiBet67AGFishGameinfoMapper;
import com.hy.pull.mapper.ApiBet67AGLiveGameinfoMapper;
import com.hy.pull.mapper.ApiBet67BBINLiveGameinfoMapper;
import com.hy.pull.mapper.ApiBet67EBETLiveGameinfoMapper;
import com.hy.pull.mapper.ApiBet67ELGSlotGameinfoMapper;
import com.hy.pull.mapper.ApiBet67GDLiveGameinfoMapper;
import com.hy.pull.mapper.ApiBet67HGLiveGameinfoMapper;
import com.hy.pull.mapper.ApiBet67HYLiveGameinfoMapper;
import com.hy.pull.mapper.ApiBet67MGSlotGameinfoMapper;
import com.hy.pull.mapper.ApiBet67OBLiveGameinfoMapper;
import com.hy.pull.mapper.ApiBet67OGLiveGameinfoMapper;
import com.hy.pull.mapper.ApiBet67OGLotteryGameinfoMapper;
import com.hy.pull.mapper.ApiBet67SLFishGameinfoMapper;
import com.hy.pull.mapper.ApiBet67SLLiveGameinfoMapper;
import com.hy.pull.mapper.ApiBet67TSSportGameinfoMapper;
import com.hy.pull.mapper.ApiBet67VGGameinfoMapper;
import com.hy.pull.mapper.DataHandleMapper;
import com.hy.pull.mapper.TbProxyKeyMapper;
import com.hy.pull.service.BaseService;

/**
 * 67BET游戏注单捞取
 * 
 * @author admin
 *
 */
@Service
public class BET67GameService extends BaseService {
	Logger logger = LogManager.getLogger(BET67GameService.class.getName());

	@Autowired
	private ApiBet67HYLiveGameinfoMapper apiBet67HyLiveGameinfoMapper;
	@Autowired
	private ApiBet67OGLotteryGameinfoMapper apiBet67OGLotteryGameinfoMapper;
	@Autowired
	private ApiBet67OBLiveGameinfoMapper apiBet67OBLiveGameinfoMapper;
	@Autowired
	private ApiBet67TSSportGameinfoMapper apiBet67TSSportGameinfoMapper;
	@Autowired
	private ApiBet67EBETLiveGameinfoMapper apiBet67EBETLiveGameinfoMapper;
	@Autowired
	private ApiBet67VGGameinfoMapper apiBet67VGGameinfoMapper;
	@Autowired
	private ApiBet67AGLiveGameinfoMapper apiBet67AGLiveGameinfoMapper;
	@Autowired
	private ApiBet67AGFishGameinfoMapper apiBet67AGFishGameinfoMapper;
	@Autowired
	private ApiBet67BBINLiveGameinfoMapper apiBet67BBINLiveGameinfoMapper;
	@Autowired
	private ApiBet67GDLiveGameinfoMapper apiBet67GDLiveGameinfoMapper;
	@Autowired
	private ApiBet67HGLiveGameinfoMapper apiBet67HGLiveGameinfoMapper;
	@Autowired
	private ApiBet67SLLiveGameinfoMapper apiBet67SLLiveGameinfoMapper;
	@Autowired
	private ApiBet67SLFishGameinfoMapper apiBet67SLFishGameinfoMapper;
	@Autowired
	private ApiBet67OGLiveGameinfoMapper apiBet67OGLiveGameinfoMapper;
	@Autowired
	private ApiBet67ELGSlotGameinfoMapper apiBet67ELGSlotGameinfoMapper;
	@Autowired
	private ApiBet67MGSlotGameinfoMapper apiBet67MGSlotGameinfoMapper;
	@Autowired
	private TbProxyKeyMapper tbProxyKeyMapper;

	@Autowired
	private DataHandleMapper dataHandleMapper;

	// @Autowired
	// private DataHandleLogsMapper dataHandleLogsMapper;

	/**
	 * 按条件拉取数据的方法
	 * 
	 * @param param
	 *            条件集合{GAME_ID:游戏编号,PROXY_ID:代理编号,MAX_VALUE:上次拉取的最大值}
	 * @return 数据行数
	 */
	@Override
	public Integer pullData(Map<String, Object> param){
		try {
		Map<String, Object> dataHandle = dataHandleMapper.selectByPrimaryKey(param.get("dataHandle") + "");
		if (param.containsKey("repeat")) {
			String repeatTime = dataHandle.get("repeattime") == null ? "" : dataHandle.get("repeattime").toString();// agent=10;
			Map<String, String> mapMaxValue = new HashMap<String, String>();
			if (StringUtils.isNotEmpty(repeatTime)) {
				String[] maxvalue = repeatTime.split(";");
				for (String str : maxvalue) {
					if (StringUtils.isNotEmpty(str)) {
						mapMaxValue.put(str.split("=")[0], str.split("=")[1]);
					}
				}
			}
			int count = 0;// 累计执行总数量
			List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
			if (param == null) {// 判断是否为空，空则创建一个新的对象
				param = new HashMap<String, Object>();
			}
			if (!param.containsKey("GAME_ID")) {// 判断是否存在游戏编号，没则默认初始化为东方游戏
				param.put("GAME_ID", "33");// 设置所属游戏编号
			}
			// 获取东方游戏的所有代理密钥列表
			List<Map<String, Object>> list = tbProxyKeyMapper.selectByEntity(param);
			int size = list.size();
			if (size > 0) {
				String apiUrl = null;// 接口URL
				String md5Key = null;// 密钥
				String gameAgent = null;// 代理名称
				String userAgent = null;// 代理编码

				Map<String, Object> deleteMap = new HashMap<>();
				for (int i = 0; i < size; i++) {
					param = list.get(i);
					apiUrl = param.get("PROXY_API_URL").toString();
					gameAgent = param.get("PROXY_KEY1").toString();
					md5Key = param.get("PROXY_KEY2").toString();
					userAgent = param.get("PROXY_CODE") == null ? gameAgent : param.get("PROXY_CODE").toString();
					String platform = dataHandle.get("remark") + "";
					if (data != null) {
						if (platform.equals("og_lottery")) {
							// System.out.println("67BET游戏og_lottery数据更新开始，参数列表："
							// + param);
							Map<String, Object> entity = new HashMap<>();
							entity.put("betStatus", "未结算");
							List<Map<String, Object>> dataList = apiBet67OGLotteryGameinfoMapper.selectByEntity(entity);
							if (CollectionUtils.isNotEmpty(dataList)) {
								for (Map<String, Object> map : dataList) {
									data = BET67Game.get67BetData(apiUrl.concat("/GetRecordById"), userAgent,
											String.valueOf(map.get("id")), platform, gameAgent, md5Key,
											dataHandle + "");
									// System.out.println("og_lottery="+dataList.get(0)+"
									// data="+data);
									if (data != null && data.get(0).containsKey("betStatus")) {
										if (String.valueOf(data.get(0).get("betStatus")).equals("已结算")) {
											deleteMap.put("betId", map.get("betId"));
											apiBet67OGLotteryGameinfoMapper.delete(deleteMap);
											apiBet67OGLotteryGameinfoMapper.deleteBetting(deleteMap);
											apiBet67OGLotteryGameinfoMapper.deleteWinlost(deleteMap);

											apiBet67OGLotteryGameinfoMapper.batchInsert(data);
										}
									}
								}
							} else {
								return 0;
							}
						} else if (platform.equals("ts_sport")) {
							// System.out.println("67BET游戏ts_sport数据更新开始，参数列表："
							// + param);
							Map<String, Object> entity = new HashMap<>();
							entity.put("isBill", "0");
							List<Map<String, Object>> dataList = apiBet67TSSportGameinfoMapper.selectByEntity(entity);
							if (CollectionUtils.isNotEmpty(dataList)) {
								for (Map<String, Object> map : dataList) {
									data = BET67Game.get67BetData(apiUrl.concat("/GetRecordById"), userAgent,
											String.valueOf(map.get("id")), platform, gameAgent, md5Key,
											dataHandle + "");
									// System.out.println("ts_sport="+dataList.get(0)+"
									// data="+data);
									if (data != null && data.get(0).containsKey("isBill")) {
										if (Integer.valueOf(data.get(0).get("isBill") + "") == 1) {
											deleteMap.put("betId", map.get("betId"));
											apiBet67TSSportGameinfoMapper.delete(deleteMap);
											apiBet67TSSportGameinfoMapper.deleteBetting(deleteMap);
											apiBet67TSSportGameinfoMapper.deleteWinlost(deleteMap);

											apiBet67TSSportGameinfoMapper.batchInsert(data);
										}
									}
								}
							} else {
								return 0;
							}
						} else if (platform.equals("elg_slot")) {
							// System.out.println("67BET游戏elg_slot数据更新开始，参数列表："
							// + param);
							Map<String, Object> entity = new HashMap<>();
							entity.put("isBill", "0");
							List<Map<String, Object>> dataList = apiBet67ELGSlotGameinfoMapper.selectByEntity(entity);
							if (CollectionUtils.isNotEmpty(dataList)) {
								for (Map<String, Object> map : dataList) {
									data = BET67Game.get67BetData(apiUrl.concat("/GetRecordById"), userAgent,
											String.valueOf(map.get("id")), platform, gameAgent, md5Key,
											dataHandle + "");
									// System.out.println("elg_slot="+dataList.get(0)+"
									// data="+data);
									if (data != null && data.get(0).containsKey("isBill")) {
										if (Integer.valueOf(data.get(0).get("isBill") + "") == 1) {
											deleteMap.put("betId", map.get("betId"));
											apiBet67ELGSlotGameinfoMapper.delete(deleteMap);
											apiBet67ELGSlotGameinfoMapper.deleteBetting(deleteMap);
											apiBet67ELGSlotGameinfoMapper.deleteWinlost(deleteMap);

											apiBet67ELGSlotGameinfoMapper.batchInsert(data);
										}
									}
								}
							} else {
								return 0;
							}
						} else if (platform.equals("mg_slot")) {
							// System.out.println("67BET游戏mg_slot数据更新开始，参数列表：" +
							// param);
							Map<String, Object> entity = new HashMap<>();
							entity.put("isBill", "未结算");
							List<Map<String, Object>> dataList = apiBet67MGSlotGameinfoMapper.selectByEntity(entity);
							if (CollectionUtils.isNotEmpty(dataList)) {

								for (Map<String, Object> map : dataList) {
									data = BET67Game.get67BetData(apiUrl.concat("/GetRecordById"), userAgent,
											String.valueOf(map.get("id")), platform, gameAgent, md5Key,
											dataHandle + "");
									// System.out.println("mg_slot="+dataList.get(0)+"
									// data="+data);
									if (data != null && data.get(0).containsKey("isBill")) {
										if (data.get(0).get("isBill").equals("已结算")) {
											deleteMap.put("betId", map.get("betId"));
											apiBet67MGSlotGameinfoMapper.delete(deleteMap);
											apiBet67MGSlotGameinfoMapper.deleteBetting(deleteMap);
											apiBet67MGSlotGameinfoMapper.deleteWinlost(deleteMap);

											apiBet67MGSlotGameinfoMapper.batchInsert(data);
										}
									}
								}
							} else {
								return 0;
							}
						}
					}
				}
			}

			logger.debug("67BET " + dataHandle.get("remark") + "游戏更新数据拉取结束。。。");
			return count;
		} else {
			System.out.println(dataHandle.toString());
			String updatetime = dataHandle.get("updatetime") == null ? "" : dataHandle.get("updatetime").toString();// agent=10;
//			String lasttime =dataHandle.get("lasttime") == null ? DateUtil.parse(new Date(), "yyyyMMdd") : dataHandle.get("lasttime").toString();// agent=10;
			Map<String, String> mapMaxValue = new HashMap<String, String>();
			if (StringUtils.isNotEmpty(updatetime)) {
				String[] maxvalue = updatetime.split(";");
				for (String str : maxvalue) {
					if (StringUtils.isNotEmpty(str)) {
						mapMaxValue.put(str.split("=")[0], str.split("=")[1]);
					}
				}
			}

			int count = 0;// 累计执行总数量
			System.out.println("67BET游戏数据拉取开始，参数列表：" + param);
			List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
			if (param == null) {// 判断是否为空，空则创建一个新的对象
				param = new HashMap<String, Object>();
			}
			if (!param.containsKey("GAME_ID")) {// 判断是否存在游戏编号，没则默认初始化为东方游戏
				param.put("GAME_ID", "33");// 设置所属游戏编号
			}
			// 获取东方游戏的所有代理密钥列表
			List<Map<String, Object>> list = tbProxyKeyMapper.selectByEntity(param);
			System.out.println(list.get(0).toString());
			int size = list.size();
			if (size > 0) {
				String apiUrl = null;// 接口URL
				String md5Key = null;// 密钥
				String gameAgent = null;// 代理名称
				String recordId = null;// 上次拉取的最大值
				String userAgent = null;// 代理编码

				int len = 0;

				for (int i = 0; i < size; i++) {
					param = list.get(i);
					apiUrl = param.get("PROXY_API_URL").toString();
					gameAgent = param.get("PROXY_KEY1").toString();
					md5Key = param.get("PROXY_KEY2").toString();
					userAgent = param.get("PROXY_CODE") == null ? gameAgent : param.get("PROXY_CODE").toString();
					String platform = dataHandle.get("remark") + "";
					if (platform.equals("hy_live")) {
						recordId = apiBet67HyLiveGameinfoMapper.maxId();
					} else if (platform.equals("og_lottery")) {
						recordId = apiBet67OGLotteryGameinfoMapper.maxId();
					} else if (platform.equals("ob_live")) {
						recordId = apiBet67OBLiveGameinfoMapper.maxId();
					} else if (platform.equals("ts_sport")) {
						recordId = apiBet67TSSportGameinfoMapper.maxId();
					} else if (platform.equals("ebet_live")) {
						recordId = apiBet67EBETLiveGameinfoMapper.maxId();
					} else if (platform.equals("vg")) {
						recordId = apiBet67VGGameinfoMapper.maxId();
					} else if (platform.equals("ag_live")) {
						recordId = apiBet67AGLiveGameinfoMapper.maxId();
					} else if (platform.equals("bbin_live")) {
						recordId = apiBet67BBINLiveGameinfoMapper.maxId();
					} else if (platform.equals("gd_live")) {
						recordId = apiBet67GDLiveGameinfoMapper.maxId();
					} else if (platform.equals("hg_live")) {
						recordId = apiBet67HGLiveGameinfoMapper.maxId();
					} else if (platform.equals("sl_live")) {
						recordId = apiBet67SLLiveGameinfoMapper.maxId();
					} else if (platform.equals("og_live")) {
						recordId = apiBet67OGLiveGameinfoMapper.maxId();
					} else if (platform.equals("elg_slot")) {
						recordId = apiBet67ELGSlotGameinfoMapper.maxId();
					} else if (platform.equals("mg_slot")) {
						recordId = apiBet67MGSlotGameinfoMapper.maxId();
					}
					// 获取拉取最大值
					if (StringUtils.isEmpty(recordId)) {
						recordId = "0";
					}
					System.out.println("platform:"+platform+" recordId:"+recordId);
					data = BET67Game.get67BetData(apiUrl.concat("/GetRecord"), userAgent, recordId, platform, gameAgent,
							md5Key, dataHandle + "");
					if (data != null) {
						Iterator<Map<String, Object>> iterator = data.iterator();
						List<Map<String, Object>> newData = new ArrayList<Map<String, Object>>();
						List<Map<String, Object>> result =null;
						len = data.size();
						count += len;// 累计执行结果
						if (len > 0) {// 如果有数据就入库
							if (platform.equals("hy_live")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result =apiBet67HyLiveGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}
								}
								if(CollectionUtils.isNotEmpty(newData)){
									apiBet67HyLiveGameinfoMapper.batchInsert(data);
								}
							} else if (platform.equals("og_lottery")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result = apiBet67OGLotteryGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}
								}
								if(CollectionUtils.isNotEmpty(newData)){
									apiBet67OGLotteryGameinfoMapper.batchInsert(data);
								}
							} else if (platform.equals("ob_live")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result = apiBet67OBLiveGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}							}
									if(CollectionUtils.isNotEmpty(newData)){
										apiBet67OBLiveGameinfoMapper.batchInsert(data);
									}
							} else if (platform.equals("ts_sport")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result = apiBet67TSSportGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}
								}
								if(CollectionUtils.isNotEmpty(newData)){
									apiBet67TSSportGameinfoMapper.batchInsert(data);
								}
							} else if (platform.equals("ebet_live")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result = apiBet67EBETLiveGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}	
								}
								if(CollectionUtils.isNotEmpty(newData)){
									apiBet67EBETLiveGameinfoMapper.batchInsert(data);
								}
							} else if (platform.equals("vg")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result = apiBet67VGGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}
								}
								if(CollectionUtils.isNotEmpty(newData)){
									apiBet67VGGameinfoMapper.batchInsert(data);
								}
							} else if (platform.equals("ag_live")) {
								List<Map<String, Object>> agLiveList = new ArrayList<Map<String, Object>>();
								List<Map<String, Object>> agFishList = new ArrayList<Map<String, Object>>();
								for (Map<String, Object> map : data) {
									if ("捕魚王".equals(map.get("gameType") + "")) {
										result = apiBet67AGFishGameinfoMapper.selectByEntity(map);
										if(!CollectionUtils.isNotEmpty(result)){
											agFishList.add(map);
										}
									} else{
										result = apiBet67AGLiveGameinfoMapper.selectByEntity(map);
										if(!CollectionUtils.isNotEmpty(result)){
											agLiveList.add(map);
										}
									}
								}
								if (CollectionUtils.isNotEmpty(agLiveList)) {
									apiBet67AGLiveGameinfoMapper.batchInsert(agLiveList);
								}
								if (CollectionUtils.isNotEmpty(agFishList)) {
									apiBet67AGFishGameinfoMapper.batchInsert(agFishList);
								}
							} else if (platform.equals("bbin_live")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result = apiBet67BBINLiveGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}
								}
								if(CollectionUtils.isNotEmpty(newData)){
									apiBet67BBINLiveGameinfoMapper.batchInsert(data);
								}
							} else if (platform.equals("gd_live")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result = apiBet67GDLiveGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}
								}
								if(CollectionUtils.isNotEmpty(newData)){
									apiBet67GDLiveGameinfoMapper.batchInsert(data);
								}
							} else if (platform.equals("hg_live")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result = apiBet67HGLiveGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}
								}
								if(CollectionUtils.isNotEmpty(newData)){
									apiBet67HGLiveGameinfoMapper.batchInsert(data);
								}
							} else if (platform.equals("sl_live")) {
								List<Map<String, Object>> saLiveList = new ArrayList<Map<String, Object>>();
								List<Map<String, Object>> saFishList = new ArrayList<Map<String, Object>>();
								for (Map<String, Object> map : data) {
									if ("多人游戏：FishermenGold".equals(map.get("gameCode") + "")) {
										result = apiBet67AGFishGameinfoMapper.selectByEntity(map);
										if(!CollectionUtils.isNotEmpty(result)){
											saFishList.add(map);
										}
									} else{
										result = apiBet67SLLiveGameinfoMapper.selectByEntity(map);
										if(!CollectionUtils.isNotEmpty(result)){
											saLiveList.add(map);
										}
									}
								}
								if (CollectionUtils.isNotEmpty(saLiveList)) {
									apiBet67SLLiveGameinfoMapper.batchInsert(saLiveList);
								}

								if (CollectionUtils.isNotEmpty(saFishList)) {
									apiBet67SLFishGameinfoMapper.batchInsert(saFishList);
								}
							} else if (platform.equals("og_live")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result = apiBet67OGLiveGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}
								}
								if(CollectionUtils.isNotEmpty(newData)){
									apiBet67OGLiveGameinfoMapper.batchInsert(data);
								}
							} else if (platform.equals("elg_slot")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result = apiBet67ELGSlotGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}
								}
								if(CollectionUtils.isNotEmpty(newData)){
									apiBet67ELGSlotGameinfoMapper.batchInsert(data);
								}
							} else if (platform.equals("mg_slot")) {
								while(iterator.hasNext()){
									Map<String, Object> next = iterator.next();
									result = apiBet67MGSlotGameinfoMapper.selectByEntity(next);
									if(!CollectionUtils.isNotEmpty(result)){
										newData.add(next);
									}
								}
								if(CollectionUtils.isNotEmpty(newData)){
									apiBet67MGSlotGameinfoMapper.batchInsert(data);
								}
							}
							// 取这批数据的最大值recordId
							Map<String, Object> map2 = data.get(data.size() - 1);
							recordId = map2.get("id").toString();
							mapMaxValue.put(userAgent, recordId);// 更新
						}
					}
				}
				// 跨天更新一次
//				String nowStr=DateUtil.parse(new Date(), "yyyyMMdd");
//				if(lasttime.substring(0,8).equals(nowStr)){
					if (count > 0) {
						String value = "";
						for (String key : mapMaxValue.keySet()) {
							value += (key + "=" + mapMaxValue.get(key) + ";");
						}
						dataHandle.put("updatetime", value);
					}
					dataHandle.put("lasttime", DateUtil.parse(new Date(), "yyyy-MM-dd HH:mm:ss"));
					dataHandleMapper.update(dataHandle);
//				}
			}
			logger.debug("67BET " + dataHandle.get("remark") + "游戏数据拉取结束。。。");
			return count;
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
