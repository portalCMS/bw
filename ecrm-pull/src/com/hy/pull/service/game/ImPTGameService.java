package com.hy.pull.service.game;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hy.pull.common.util.DateUtil;
import com.hy.pull.common.util.game.ImPTGame;
import com.hy.pull.mapper.DataHandleLogsMapper;
import com.hy.pull.mapper.DataHandleMapper;
import com.hy.pull.mapper.PtGameinfoMapper;
import com.hy.pull.mapper.TbProxyKeyMapper;
import com.hy.pull.service.BaseService;

@Service
public class ImPTGameService extends BaseService {

	Logger logger = LogManager.getLogger(ImPTGameService.class.getName());

	@Autowired
	private PtGameinfoMapper ptGameinfoMapper;

	@Autowired
	private TbProxyKeyMapper tbProxyKeyMapper;

	@Autowired
	private DataHandleMapper dataHandleMapper;
	@Autowired
	private DataHandleLogsMapper dataHandleLogsMapper;

	@Override
	public Integer pullData(Map<String, Object> entity) throws Exception {
		/********************** 获取上次拉取的最大值 ***********************/
		Map<String, Object> dataHandle = dataHandleMapper.selectByPrimaryKey(LogUtil.HANDLE_IMPT);
		dataHandle.put("lastnum", "0");
		String updatetime = dataHandle.get("updatetime").toString();

		int count = 0;// 累计执行总数量

		List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
		if (entity == null) {// 判断是否为空，空则创建一个新的对象
			entity = new HashMap<String, Object>();
		}
		if (!entity.containsKey("GAME_ID")) {// 判断是否存在游戏编号，没则默认初始化为PT游戏
			entity.put("GAME_ID", "39");// 设置所属游戏编号
		}

		// 获取IMPT游戏的所有代理密钥列表
		List<Map<String, Object>> list = tbProxyKeyMapper.selectByEntity(entity);
		int size = list.size();
		if (size > 0) {
			String apiUrl = null;// 接口URL
			String agent = null;// 代理名称
			String stardate = null;// 开始日期
			String BEGIN_DATE = null;// 开始日期
			String enddate = null;// 开始日期
			String code = null;// 代理编码
			if (entity.get("BEGIN_DATE") != null) {// 判断是否存在开始日期
				stardate = entity.get("BEGIN_DATE").toString();
				BEGIN_DATE = entity.get("BEGIN_DATE").toString();
			}
			if (entity.get("END_DATE") != null) {// 判断是否存在结束日期
				enddate = entity.get("END_DATE").toString();
			}

			// 间隔分钟数（不得超过10）
			int intervalnum = 10;
			intervalnum = Integer.valueOf(dataHandle.get("intervalnum").toString());

			/***********************
			 * 设定开始结束时间，每次只拉取10分钟内的数据（注意：超过10分钟将获取不到数据，也不会报错）
			 *****************************/
			stardate = DateUtil.parse(
					DateUtil.add(DateUtil.parse(updatetime, "yyyy-MM-dd HH:mm:ss"), Calendar.MINUTE,0),
					"yyyy-MM-dd HH:mm:ss");//
			enddate = DateUtil.parse(
					DateUtil.add(DateUtil.parse(stardate, "yyyy-MM-dd HH:mm:ss"), Calendar.MINUTE, intervalnum),
					"yyyy-MM-dd HH:mm:ss");//
			if (DateUtil.parse(enddate, "yyyy-MM-dd HH:mm:ss").getTime() > new Date().getTime()) {
				// 最后时间不能超过当前时间
				enddate = DateUtil.parse(new Date(), "yyyy-MM-dd HH:mm:ss");
			}

			Map<String, Object> map = new HashMap<String, Object>();
			int len = 0;

			boolean flag = true;

			for (int i = 0; i < size; i++) {
				entity = list.get(i);
				apiUrl = entity.get("PROXY_API_URL").toString();
				agent = entity.get("PROXY_NAME").toString();
				code = entity.get("PROXY_CODE") == null ? agent : entity.get("PROXY_CODE").toString();
				if (BEGIN_DATE == null) {// 如果为空则获取数据库最大值
					map.put("Platformflag", agent);
				}
				data = ImPTGame.getPTData(apiUrl, stardate, enddate);
				if (data != null) {
					len = data.size();
					count += len;// 累计执行结果
					if (len > 0) {// 如果有数据就入库
						ptGameinfoMapper.batchInsert(data);// 批量入库
						dataHandle.put("lastnum", Integer.parseInt(dataHandle.get("lastnum").toString()) + len);
						dataHandle.put("allnum", Integer.parseInt(dataHandle.get("allnum").toString()) + len);
					}
				} else {
					// 为null表示出现异常
					flag = false;
					dataHandleLogsMapper.insert(LogUtil.saveLog(LogUtil.HANDLE_IMPT, null, "返回NULL数据", agent, Enum_flag.异常.value));
					break;
				}
			}
			/*************** 更新配置管理库 ****************/
			if (flag) {
				dataHandle.put("updatetime", enddate);
				dataHandle.put("lasttime", DateUtil.parse(new Date(), "yyyyMMddHHmmss"));
				dataHandleMapper.update(dataHandle);
			}
		}
		logger.debug("IMPT游戏数据拉取结束。。。");
		return count;
	}
	
	
	/**
	 * 每日补单
	 * 
	 * 
	 */
	public Integer pullDataPatch(Map<String, Object> entity) throws Exception {
		int count = 0;
		/**********每次拉一天的（北京时间昨日）**************/
		List<String> listTime = getListStartEndTime( "yyyy-MM-dd HH:mm:ss", 10, Calendar.MINUTE);
		for (String string : listTime) {
			String stardate = string.split("=")[0];
			String enddate = string.split("=")[1];
			count += pullDataPatch(entity, stardate, enddate);
		}
		return count;
	}
	
	
	/**
	 * 补单数据
	 * 
	 * @return 数据行数
	 */
	private Integer pullDataPatch(Map<String, Object> entity,String stardate,String enddate) throws Exception {
		/**********************获取上次拉取的最大值***********************/
		int count = 0;//累计执行总数量
		//System.out.println("PT游戏数据拉取开始，参数列表："+entity);
		List<Map<String,Object>> data = new ArrayList<Map<String,Object>>();
		if(entity==null){//判断是否为空，空则创建一个新的对象
			entity = new HashMap<String,Object>();
		}
		if(!entity.containsKey("GAME_ID")){//判断是否存在游戏编号，没则默认初始化为PT游戏
			entity.put("GAME_ID", "39");//设置所属游戏编号				
		}
		//获取PT游戏的所有代理密钥列表
		List<Map<String,Object>> list = tbProxyKeyMapper.selectByEntity(entity);
		int size = list.size();		
		if(size > 0){
			String apiUrl = null;//接口URL
			String agent = null;//代理名称
			String code = null;//代理编码
			
			Map<String,Object> map = new HashMap<String,Object>();
			Map<String,String> info = null;
			int len = 0;
			
			boolean flag = true;
			for(int i = 0; i < size; i++){
				entity = list.get(i);
				info = new HashMap<String,String>();
				apiUrl = entity.get("PROXY_API_URL").toString();
				agent = entity.get("PROXY_NAME").toString();
				code = entity.get("PROXY_CODE") == null ? agent : entity.get("PROXY_CODE").toString();
				info.put("fileurl", entity.get("PROXY_KEY2").toString());
				info.put("keyStore", entity.get("PROXY_KEY1").toString());
				info.put("entity",entity.get("PROXY_MD5_KEY").toString());
				map.put("Platformflag", agent);
				data = ImPTGame.getPTData(apiUrl, stardate, enddate);
				if(data != null){
					len = data.size();
					count += len;//累计执行结果
					if(len > 0){//如果有数据就入库
						ptGameinfoMapper.batchInsert(data);//批量入库
					}
				} else {
					//为null表示出现异常
					flag = false;
					dataHandleLogsMapper.insert(LogUtil.saveLog(LogUtil.HANDLE_IMPT, null, "返回NULL数据", agent, Enum_flag.异常.value));
					break;
				}
			}
			/***************更新配置管理库****************/
		}
		logger.debug("IMPT补单游戏数据拉取结束。。。");
		return count;
	}

}
