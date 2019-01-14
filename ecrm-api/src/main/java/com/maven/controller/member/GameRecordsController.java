package com.maven.controller.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hy.pull.common.util.MoneyHelper;
import com.hy.pull.common.util.SCom;
import com.maven.constant.Enum_MSG;
import com.maven.controller.BaseController;
import com.maven.entity.ApiSoltGametype;
import com.maven.entity.BettingAllDay;
import com.maven.entity.BettingAllGameWinloseDetail;
import com.maven.entity.BettingBet67AGFish;
import com.maven.entity.BettingBet67AGLive;
import com.maven.entity.BettingBet67BBINLive;
import com.maven.entity.BettingBet67ELGSlot;
import com.maven.entity.BettingBet67EbetLive;
import com.maven.entity.BettingBet67GDLive;
import com.maven.entity.BettingBet67HGLive;
import com.maven.entity.BettingBet67HYLive;
import com.maven.entity.BettingBet67MGSlot;
import com.maven.entity.BettingBet67OBLive;
import com.maven.entity.BettingBet67OGLive;
import com.maven.entity.BettingBet67OGLottery;
import com.maven.entity.BettingBet67SAFish;
import com.maven.entity.BettingBet67SLLive;
import com.maven.entity.BettingBet67TSSport;
import com.maven.entity.BettingEbet;
import com.maven.entity.BettingEibc;
import com.maven.entity.BettingGb;
import com.maven.entity.BettingGg;
import com.maven.entity.BettingGgp;
import com.maven.entity.BettingHab;
import com.maven.entity.BettingHqAg;
import com.maven.entity.BettingHqBbin;
import com.maven.entity.BettingHqNhq;
import com.maven.entity.BettingHqOgAg;
import com.maven.entity.BettingHqOgIbc;
import com.maven.entity.BettingHqOgOg;
import com.maven.entity.BettingHqPng;
import com.maven.entity.BettingHqPt;
import com.maven.entity.BettingHqXcp;
import com.maven.entity.BettingIdn2;
import com.maven.entity.BettingIm;
import com.maven.entity.BettingJdb;
import com.maven.entity.BettingKGGameLottery;
import com.maven.entity.BettingKrAv;
import com.maven.entity.BettingM88;
import com.maven.entity.BettingMg;
import com.maven.entity.BettingNB;
import com.maven.entity.BettingQp;
import com.maven.entity.BettingQt;
import com.maven.entity.BettingQwp;
import com.maven.entity.BettingSa;
import com.maven.entity.BettingSgs;
import com.maven.entity.BettingTgp;
import com.maven.entity.BettingTtg;
import com.maven.entity.BettingWin88;
import com.maven.entity.BettingYSB;
import com.maven.entity.BettingYoplay;
import com.maven.entity.BettingZj;
import com.maven.entity.EnterpriseOperatingBrandGame;
import com.maven.entity.Game;
import com.maven.exception.ArgumentValidationException;
import com.maven.exception.LogicTransactionRollBackException;
import com.maven.game.enums.GameEnum;
import com.maven.game.enums.GameEnum.Enum_GameType;
import com.maven.logger.LoggerManager;
import com.maven.logger.OutputManager;
import com.maven.service.ApiSoltGametypeService;
import com.maven.service.BettingAllDayService;
import com.maven.service.BettingAllGameWinloseDetailService;
import com.maven.service.BettingGameService;
import com.maven.service.EnterpriseEmployeeService;
import com.maven.service.EnterpriseGameService;
import com.maven.service.EnterpriseOperatingBrandGameService;
import com.maven.service.GameService;
import com.maven.util.AGUtils;
import com.maven.util.AttrCheckout;
import com.maven.util.BBINUtils;
import com.maven.util.BeanToMapUtil;
import com.maven.util.HQOGUtils;
import com.maven.util.NHQUtils;
import com.maven.util.PTUtils;
import com.maven.util.SAUtils;
import com.maven.util.SGSUtils;
import com.maven.util.StringUtils;

@Controller
@RequestMapping("/GRecords")
public class GameRecordsController extends BaseController{
	
	/** 游戏 */
	@Autowired
	private GameService gameService;
	/** 企业游戏 */
	@Autowired
	private EnterpriseGameService enterpriseGameService;
	/** 品牌游戏中间表 */
	@Autowired
	private EnterpriseOperatingBrandGameService enterpriseOperatingBrandGameService;
	
	private static LoggerManager log = LoggerManager.getLogger(
			GameRecordsController.class.getName(), OutputManager.LOG_USER_GAMERECORDS);
	
	@Resource(name="bettingHqAgServiceImpl")
	private BettingGameService<BettingHqAg> bettingHqAgService;
	@Resource(name="bettingHqPngServiceImpl")
	private BettingGameService<BettingHqPng> bettingHqPngService;
	
	@Resource(name="bettingHqBbinServiceImpl")
	private BettingGameService<BettingHqBbin> bettingHqBbinService;
	
	@Resource(name="bettingHqNhqServiceImpl")
	private BettingGameService<BettingHqNhq> bettingHqNhqService;
	
	@Resource(name="bettingHqOgAgServiceImpl")
	private BettingGameService<BettingHqOgAg> bettingHqOgAgService;
	
	@Resource(name="bettingHqOgIbcServiceImpl")
	private BettingGameService<BettingHqOgIbc> bettingHqOgIbcService;
	
	@Resource(name="bettingHqOgOgServiceImpl")
	private BettingGameService<BettingHqOgOg> bettingHqOgOgService;
	
	@Resource(name="bettingHqPtServiceImpl")
	private BettingGameService<BettingHqPt> bettingHqPtService;
	
	@Resource(name="bettingHqXcpServiceImpl")
	private BettingGameService<BettingHqXcp> bettingHqXcpService;
	
	@Resource(name="bettingKrAvServiceImpl")
	private BettingGameService<BettingKrAv> bettingKrAvService;
	
	@Resource(name="bettingSaServiceImpl")
	private BettingGameService<BettingSa> bettingSaService;
	
	@Resource(name="bettingZjServiceImpl")
	private BettingGameService<BettingZj> bettingZjService;
	
	@Resource(name="bettingMgServiceImpl")
	private BettingGameService<BettingMg> bettingMgService;
	
	@Resource(name="bettingTtgServiceImpl")
	private BettingGameService<BettingTtg> bettingTtgService;
	
	@Resource(name="bettingQpServiceImpl")
	private BettingGameService<BettingQp> bettingQpService;
	
	@Resource(name="bettingGgServiceImpl")
	private BettingGameService<BettingGg> bettingGgService;
	@Resource(name="bettingSgsServiceImpl")
	private BettingGameService<BettingSgs> bettingSgsService;
//	@Resource(name="bettingIdnServiceImpl")
//	private BettingGameService<BettingIdn> bettingIdnService;
	@Resource(name="bettingIdn2ServiceImpl")
	private BettingGameService<BettingIdn2> bettingIdn2Service;
	
	@Resource(name="bettingM88ServiceImpl")
	private BettingGameService<BettingM88> bettingM88Service;
	@Resource(name="bettingHabServiceImpl")
	private BettingGameService<BettingHab> bettingHabService;
	
	@Resource(name="bettingEbetServiceImpl")
	private BettingGameService<BettingEbet> bettingEbetService;
	@Resource(name="bettingGbServiceImpl")
	private BettingGameService<BettingGb> bettingGbService;
	@Resource(name="bettingQtServiceImpl")
	private BettingGameService<BettingQt> bettingQtService;
	@Resource(name="bettingTgpServiceImpl")
	private BettingGameService<BettingTgp> bettingTgpService;
	@Resource(name="bettingWin88ServiceImpl")
	private BettingGameService<BettingWin88> bettingWin88Service;
	@Resource(name="bettingEibcServiceImp")
	private BettingGameService<BettingEibc> bettingEibcService;
	@Resource(name="bettingGgpServiceImpl")
	private BettingGameService<BettingGgp> bettingGgpService;
	@Resource(name="bettingYoplayServiceImpl")
	private BettingGameService<BettingYoplay> bettingYoplayService;
	@Resource(name="bettingImServiceImpl")
	private BettingGameService<BettingIm> bettingImService;
	@Resource(name="bettingQwpServiceImpl")
	private BettingGameService<BettingQwp> bettingQwpService;
	@Resource(name="bettingJdbServiceImpl")
	private BettingGameService<BettingJdb> bettingJdbService;
	
	@Autowired
	private BettingAllDayService bettingAllDayService;
	@Autowired
	private BettingAllGameWinloseDetailService bettingAllGameWinloseDetailService;
	@Autowired
	private EnterpriseEmployeeService enterpriseEmployeeService;
	@Autowired
	private ApiSoltGametypeService apiSoltGametypeService;
	
	//bet67类
	@Resource(name="bettingBet67AGLiveServiceImpl")
	private BettingGameService<BettingBet67AGLive> bettingBet67AGLiveService;
	@Resource(name="bettingBet67AGFishServiceImpl")
	private BettingGameService<BettingBet67AGFish> bettingBet67AGFishService;
	@Resource(name="bettingBet67BBINLiveServiceImpl")
	private BettingGameService<BettingBet67BBINLive> bettingBet67BBINLiveService;
	@Resource(name="bettingBet67EbetLiveServiceImpl")
	private BettingGameService<BettingBet67EbetLive> bettingBet67EbetLiveService;
	@Resource(name="bettingBet67ELGSlotServiceImpl")
	private BettingGameService<BettingBet67ELGSlot> bettingBet67ELGSlotService;
	@Resource(name="bettingBet67GDLiveServiceImpl")
	private BettingGameService<BettingBet67GDLive> bettingBet67GDLiveService;
	@Resource(name="bettingBet67HGLiveServiceImpl")
	private BettingGameService<BettingBet67HGLive> bettingBet67HGLiveService;
	@Resource(name="bettingBet67HYLiveServiceImpl")
	private BettingGameService<BettingBet67HYLive> bettingBet67HYLiveService;
	@Resource(name="bettingBet67MGSlotServiceImpl")
	private BettingGameService<BettingBet67MGSlot> bettingBet67MGSlotService;
	@Resource(name="bettingBet67OBLiveServiceImpl")
	private BettingGameService<BettingBet67OBLive> bettingBet67OBLiveService;
	@Resource(name="bettingBet67OGLiveServiceImpl")
	private BettingGameService<BettingBet67OGLive> bettingBet67OGLiveService;
	@Resource(name="bettingBet67OGLotteryServiceImpl")
	private BettingGameService<BettingBet67OGLottery> bettingBet67OGLotteryService;
	@Resource(name="bettingBet67SLLiveServiceImpl")
	private BettingGameService<BettingBet67SLLive> bettingBet67SLLiveService;
	@Resource(name="bettingBet67SAFishServiceImpl")
	private BettingGameService<BettingBet67SAFish> bettingBet67SAFishService;
	@Resource(name="bettingBet67TSSportServiceImpl")
	private BettingGameService<BettingBet67TSSport> bettingBet67TSSportService;
	@Resource(name="bettingKGGameLotteryServiceImpl")
	private BettingGameService<BettingKGGameLottery> bettingKGGameLotteryService;
	@Resource(name="bettingNBServiceImpl")
	private BettingGameService<BettingNB> bettingNBService;
	@Resource(name="bettingYSBServiceImpl")
	private BettingGameService<BettingYSB> bettingYSBService;
	
	/**
	 * 获取游戏数据
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/Records",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String data(HttpServletRequest request){
		try {
			Map<String,Object> object = super.apiDecode(super.getRequestParamters(request));
			AttrCheckout.checkout(object, false, new String[]{"employeecode","gametype","start","limit"});
			String gametype = String.valueOf(object.get("gametype"));
			String orderid = String.valueOf(object.get("orderid"));
			if(!"null".equals(orderid)) object.remove("orderid");
			if(!Enum_GameType.validate(gametype)){
				return Enum_MSG.参数错误.message(Enum_MSG.游戏类型错误.desc);
			}
			Map<String,Object> returnObject = new HashMap<String,Object>();
			object.put("direction", "desc");
			object.remove("gametype");//传递的参数删掉
			
			System.out.println("===============================查询游戏记录条件="+object);
			
			
			
			
			//转换为yyyyMMdd格式，同时传入最终的统一的查询条件StartDate/EndDate，避免影响后台的不同的参数
			if(object.get("startDate") != null ) {
				if(object.get("startDate").toString().length() == 10) {
					object.put("StartDate", object.get("startDate").toString().replaceAll("-", ""));
				} 
			}
			if(object.get("endDate") != null ) {
				if(object.get("endDate").toString().length() == 10) {
					object.put("EndDate", object.get("endDate").toString().replaceAll("-", ""));
				} 
			}
					
			//移除其他不统一的参数，避免影响查询条件
			object.remove("startDate");
			object.remove("endDate");
			object.remove("starttime");
			object.remove("startime");
			object.remove("endtime");
			
			
			
			if(gametype.equals(Enum_GameType.Bet67AG真人.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67AGLive> list = bettingBet67AGLiveService.takeRecord(object);
				Map<String, Object> result = bettingBet67AGLiveService.takeRecordCountMoney(object);
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betMoney", StringUtil.getDouble(result.get("betMoney")));
//				summary.put("okBetMoney", StringUtil.getDouble(result.get("okBetMoney")));
//				summary.put("betResult", StringUtil.getDouble(result.get("betResult")));
				
				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betMoney"));//投注额
				returnObject.put("winningCredits", result.get("betResult"));//输赢金额
				returnObject.put("washCodeCredits", result.get("okBetMoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.KG彩票.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingKGGameLottery> list = bettingKGGameLotteryService.takeRecord(object);
				Map<String, Object> result = bettingKGGameLotteryService.takeRecordCountMoney(object);
				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betAmount"));//投注额
				returnObject.put("winningCredits", result.get("winOrLoss"));//输赢金额
				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.NB体育.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingNB> list = bettingNBService.takeRecord(object);
				Map<String, Object> result = bettingNBService.takeRecordCountMoney(object);
				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betAmount"));//投注额
				returnObject.put("winningCredits", result.get("winOrLoss"));//输赢金额
				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.YSB体育.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingYSB> list = bettingYSBService.takeRecord(object);
				Map<String, Object> result = bettingYSBService.takeRecordCountMoney(object);
				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betAmount"));//投注额
				returnObject.put("winningCredits", result.get("winOrLoss"));//输赢金额
				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67AG捕鱼.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67AGFish> list = bettingBet67AGFishService.takeRecord(object);
				Map<String, Object> result = bettingBet67AGFishService.takeRecordCountMoney(object);
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betMoney", StringUtil.getDouble(result.get("betMoney")));
//				summary.put("okBetMoney", StringUtil.getDouble(result.get("okBetMoney")));
//				summary.put("betResult", StringUtil.getDouble(result.get("betResult")));
				
				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betMoney"));//投注额
				returnObject.put("winningCredits", result.get("betResult"));//输赢金额
				returnObject.put("washCodeCredits", result.get("okBetMoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67BBIN真人.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				
				List<BettingBet67BBINLive> list = bettingBet67BBINLiveService.takeRecord(object);
				Map<String, Object> result = bettingBet67BBINLiveService.takeRecordCountMoney(object);
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betMoney", StringUtil.getDouble(result.get("betMoney")));
//				summary.put("okBetMoney", StringUtil.getDouble(result.get("okBetMoney")));
//				summary.put("betResult", StringUtil.getDouble(result.get("betResult")));

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betMoney"));//投注额
				returnObject.put("winningCredits", result.get("betResult"));//输赢金额
				returnObject.put("washCodeCredits", result.get("okBetMoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67EBET真人.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67EbetLive> list = bettingBet67EbetLiveService.takeRecord(object);
				Map<String, Object> result = bettingBet67EbetLiveService.takeRecordCountMoney(object);
//				int countRecord = StringUtil.getInt(result.get("count"));
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betAmount", StringUtil.getDouble(result.get("betAmount")));
//				summary.put("validAmount", StringUtil.getDouble(result.get("validAmount")));
//				summary.put("winOrLoss", StringUtil.getDouble(result.get("winOrLoss")));

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betAmount"));//投注额
				returnObject.put("winningCredits", result.get("winOrLoss"));//输赢金额
				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67ELG电子.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67ELGSlot> list = bettingBet67ELGSlotService.takeRecord(object);
				Map<String, Object> result = bettingBet67ELGSlotService.takeRecordCountMoney(object);
//				int countRecord = StringUtil.getInt(result.get("count"));
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				
//				summary.put("betMoney", StringUtil.getDouble(result.get("betMoney")));
//				summary.put("winOrLoss", StringUtil.getDouble(result.get("winOrLoss")));
				
				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betMoney"));//投注额
				returnObject.put("winningCredits", result.get("winOrLoss"));//输赢金额
//				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67GD真人.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67GDLive> list = bettingBet67GDLiveService.takeRecord(object);
				Map<String, Object> result = bettingBet67GDLiveService.takeRecordCountMoney(object);
//				int countRecord = StringUtil.getInt(result.get("count"));
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betMoney", StringUtil.getDouble(result.get("betMoney")));
//				summary.put("betResult", StringUtil.getDouble(result.get("betResult")));

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betMoney"));//投注额
				returnObject.put("winningCredits", result.get("betResult"));//输赢金额
//				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67HG真人.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67HGLive> list = bettingBet67HGLiveService.takeRecord(object);
				Map<String, Object> result = bettingBet67HGLiveService.takeRecordCountMoney(object);
//				int countRecord = StringUtil.getInt(result.get("count"));
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betAmount", StringUtil.getDouble(result.get("betAmount")));
//				summary.put("payOut", StringUtil.getDouble(result.get("payOut")));

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betAmount"));//投注额
				returnObject.put("winningCredits", result.get("payOut"));//输赢金额
//				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67HY好赢真人.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67HYLive> list = bettingBet67HYLiveService.takeRecord(object);
				Map<String, Object> result = bettingBet67HYLiveService.takeRecordCountMoney(object);
//				int countRecord = StringUtil.getInt(result.get("count"));
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betAmount", StringUtil.getDouble(result.get("betAmount")));
//				summary.put("validAmount", StringUtil.getDouble(result.get("validAmount")));
//				summary.put("winOrLoss", StringUtil.getDouble(result.get("winOrLoss")));

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betAmount"));//投注额
				returnObject.put("winningCredits", result.get("winOrLoss"));//输赢金额
				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67MG电子.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67MGSlot> list = bettingBet67MGSlotService.takeRecord(object);
				Map<String, Object> result = bettingBet67MGSlotService.takeRecordCountMoney(object);
//				int countRecord = StringUtil.getInt(result.get("count"));
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betAmount", StringUtil.getDouble(result.get("betAmount")));
//				summary.put("winOrLoss", StringUtil.getDouble(result.get("winOrLoss")));

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betAmount"));//投注额
				returnObject.put("winningCredits", result.get("winOrLoss"));//输赢金额
//				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67Allbet欧博真人.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67OBLive> list = bettingBet67OBLiveService.takeRecord(object);
				Map<String, Object> result = bettingBet67OBLiveService.takeRecordCountMoney(object);
//				int countRecord = StringUtil.getInt(result.get("count"));
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betAmount", StringUtil.getDouble(result.get("betAmount")));
//				summary.put("validAmount", StringUtil.getDouble(result.get("validAmount")));
//				summary.put("winOrLoss", StringUtil.getDouble(result.get("winOrLoss")));

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betAmount"));//投注额
				returnObject.put("winningCredits", result.get("winOrLoss"));//输赢金额
				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67OG真人.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67OGLive> list = bettingBet67OGLiveService.takeRecord(object);
				Map<String, Object> result = bettingBet67OGLiveService.takeRecordCountMoney(object);
//				int countRecord = StringUtil.getInt(result.get("count"));
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betAmount", StringUtil.getDouble(result.get("betAmount")));
//				summary.put("winOrLoss", StringUtil.getDouble(result.get("winOrLoss")));

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betAmount"));//投注额
				returnObject.put("winningCredits", result.get("winOrLoss"));//输赢金额
//				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67OG彩票.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67OGLottery> list = bettingBet67OGLotteryService.takeRecord(object);
				Map<String, Object> result = bettingBet67OGLotteryService.takeRecordCountMoney(object);
//				int countRecord = StringUtil.getInt(result.get("count"));
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betAmount", StringUtil.getDouble(result.get("betAmount")));
//				summary.put("winOrLoss", StringUtil.getDouble(result.get("winOrLoss")));

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betAmount"));//投注额
				returnObject.put("winningCredits", result.get("winOrLoss"));//输赢金额
//				returnObject.put("washCodeCredits", result.get("validAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67SA真人.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67SLLive> list = bettingBet67SLLiveService.takeRecord(object);
				Map<String, Object> result = bettingBet67SLLiveService.takeRecordCountMoney(object);
//				int countRecord = StringUtil.getInt(result.get("count"));
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("betMoney", StringUtil.getDouble(result.get("betMoney")));
//				summary.put("okBetMoney", StringUtil.getDouble(result.get("okBetMoney")));
//				summary.put("betResult", StringUtil.getDouble(result.get("betResult")));

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betMoney"));//投注额
				returnObject.put("winningCredits", result.get("betResult"));//输赢金额
				returnObject.put("washCodeCredits", result.get("okBetMoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67SA捕鱼.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67SAFish> list = bettingBet67SAFishService.takeRecord(object);
				Map<String, Object> result = bettingBet67SAFishService.takeRecordCountMoney(object);

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("betMoney"));//投注额
				returnObject.put("winningCredits", result.get("betResult"));//输赢金额
				returnObject.put("washCodeCredits", result.get("okBetMoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.Bet67TS三升体育.gametype)){
				if(!"null".equals(orderid)) object.put("betId", orderid);
				object.put("field", "betTime");
				List<BettingBet67TSSport> list = bettingBet67TSSportService.takeRecord(object);
				Map<String, Object> result = bettingBet67TSSportService.takeRecordCountMoney(object);
//				int countRecord = StringUtil.getInt(result.get("count"));
//				returnObject = super.formatPagaMap(list, countRecord);
//				Map<String, Object> summary = new HashMap<String, Object>();
//				summary.put("wagerStake", StringUtil.getDouble(result.get("wagerStake")));
//				summary.put("winAmt", StringUtil.getDouble(result.get("winAmt")));

				returnObject.put("record", list);
				returnObject.put("count", result.get("count"));
				returnObject.put("bettingCredits", result.get("wagerStake"));//投注额
				returnObject.put("winningCredits", result.get("winAmt"));//输赢金额
//				returnObject.put("washCodeCredits", result.get("okBetMoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.环球.gametype)){
				if(!"null".equals(orderid)) {
					object.put("bettingNo", orderid);
				}
				object.put("field", "Betting_Date");
				List<BettingHqNhq> list = bettingHqNhqService.takeRecord(object);
				for (BettingHqNhq bettingHqNhq : list) {
					bettingHqNhq.setGameType(NHQUtils.__gameType.get(bettingHqNhq.getGameType()));
				}
				Map<String, Object> mapresult = bettingHqNhqService.takeRecordCountMoney(object);
				returnObject.put("record", list);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("bettingCredits"));
				returnObject.put("winningCredits", mapresult.get("winningCredits"));
				returnObject.put("washCodeCredits", mapresult.get("washCodeCredits"));
			}else if(gametype.equals(Enum_GameType.波音.gametype)){
				if(!"null".equals(orderid)) {
					object.put("bbinWagersId", orderid);
				}
				object.put("field", "bbin_Wagers_Date");
				List<BettingHqBbin> record = bettingHqBbinService.takeRecord(object);
				if(null != record && record.size() > 0) {
					for (BettingHqBbin bettingHqBbin : record) {
						bettingHqBbin.setBbinGameType(BBINUtils.getGameName(bettingHqBbin.getBbinGameType()));
					}
				}
				returnObject.put("record", record);
				Map<String, Object> mapresult = bettingHqBbinService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("bbinBetAmount"));//投注额
				returnObject.put("winningCredits", SCom.getDouble(mapresult.get("bbinPayoff")) );//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("bbinCommissionable"));//有效投注
			}else if(gametype.equals(Enum_GameType.AG.gametype)){
				if(!"null".equals(orderid)) {
					object.put("billNo", orderid);
				}
				object.put("field", "bet_Time");
				List<BettingHqAg> record = bettingHqAgService.takeRecord(object);
				if(null != record && record.size() > 0) {
					for (BettingHqAg bettingHqAg : record) {
						bettingHqAg.setGameType(AGUtils.getGameName(bettingHqAg.getGameType()));
						bettingHqAg.setPlayType(AGUtils.getPlayType(bettingHqAg.getPlayType(), bettingHqAg.getGameType()));
						bettingHqAg.setPlatformType(AGUtils.__PlatformType.get(bettingHqAg.getPlatformType()));
						bettingHqAg.setRound(AGUtils.__Roundype.get(bettingHqAg.getRound()));
					}
				}
				returnObject.put("record", record);
				Map<String, Object> mapresult = bettingHqAgService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betAmount"));//投注额
				returnObject.put("winningCredits", mapresult.get("netAmount"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("validBetAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.东方.gametype)){
				if(!"null".equals(orderid)) {
					object.put("aoiProductId", orderid);
				}
				object.put("field", "aoi_Add_Time");
				
				List<BettingHqOgOg> list = bettingHqOgOgService.takeRecord(object);
				if (list != null && list.size() > 0) {
					String gameId;
					for (BettingHqOgOg og : list) {
						gameId = og.getAoiGameNameId();
						og.setAoiGameNameId(HQOGUtils.getGameName(gameId));
					}	
				}
				
				returnObject.put("record", list);
				Map<String, Object> mapresult = bettingHqOgOgService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("aoiBettingAmount"));//投注额
				returnObject.put("winningCredits", mapresult.get("aoiWinLoseAmount"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("aoiValidAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.东方AG.gametype)){//作废
				if(!"null".equals(orderid)) {
					object.put("aoiProductId", orderid);
					
				}
				object.put("field", "aoi_Add_Time");
				returnObject.put("record", bettingHqOgAgService.takeRecord(object));
				returnObject.put("count", bettingHqOgAgService.takeRecordCount(object));
			}else if(gametype.equals(Enum_GameType.PT.gametype)){
				if(!"null".equals(orderid)) {
					object.put("ptGamecode", orderid);
				}
				object.put("field", "pt_gamedate");
				
				List<BettingHqPt> list = bettingHqPtService.takeRecord(object);
				ApiSoltGametype apiSoltGametype = null;
				for (BettingHqPt bettingHqPt : list) {
					String ptGametype = bettingHqPt.getPtGametype();
					String ptGamename = bettingHqPt.getPtGamename();
					
					String name = ptGamename.split("\\(")[1].replaceAll("\\)", "");
					
					bettingHqPt.setPtGametype(PTUtils.__GameType.get(ptGametype) == null ? ptGametype : PTUtils.__GameType.get(ptGametype) );
					
					apiSoltGametype = new ApiSoltGametype();
					apiSoltGametype.setBiggametype(GameEnum.Enum_GameType.PT.gametype);
					apiSoltGametype.setGamecodeweb(name);
					apiSoltGametype = apiSoltGametypeService.selectFirst(apiSoltGametype);
					if(apiSoltGametype != null) {
						bettingHqPt.setPtGamename(apiSoltGametype.getCnname());
					}
				}
				
				returnObject.put("record", list);
				Map<String, Object> mapresult = bettingHqPtService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("ptBet"));//投注额
				returnObject.put("winningCredits", mapresult.get("ptWin"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("ptBet"));//有效投注
				
			}else if(gametype.equals(Enum_GameType.沙巴.gametype)){//作废
				if(!"null".equals(orderid)) {
					object.put("ibcRowguid", orderid);
				}
				object.put("field", "ibc_updatetime");
				returnObject.put("record", bettingHqOgIbcService.takeRecord(object));
				returnObject.put("count", bettingHqOgIbcService.takeRecordCount(object));
			}else if(gametype.equals(Enum_GameType.祥瑞.gametype)){//作废
				if(!"null".equals(orderid)) {
					object.put("xcpProjectid", orderid);
					
				}
				object.put("field", "xcp_writetime");
				returnObject.put("record", bettingHqXcpService.takeRecord(object));
				returnObject.put("count", bettingHqXcpService.takeRecordCount(object));
			}else if(gametype.equals(Enum_GameType.棋牌.gametype)){
				if(!"null".equals(orderid)) {
					object.put("turnNumber", orderid);
					
				}
				object.put("field", "bettime");
				returnObject.put("record", bettingQpService.takeRecord(object));
				Map<String, Object> mapresult = bettingQpService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("revenue"));//有效投注-返水
				
			}else if(gametype.equals(Enum_GameType.AV老虎机.gametype)){//作废
				if(!"null".equals(orderid)) {
					object.put("tid", orderid);
					
				}
				object.put("field", "time");
				returnObject.put("record", bettingKrAvService.takeRecord(object));
				returnObject.put("count", bettingKrAvService.takeRecordCount(object));
			}else if(gametype.equals(Enum_GameType.沙龙.gametype)){
				if(!"null".equals(orderid)) {
					object.put("betid", orderid);
					
				}
				object.put("field", "bettime");
				List<BettingSa> record = bettingSaService.takeRecord(object);
				if (null != record && record.size() > 0) {
					for (BettingSa bettingSa : record) {
						bettingSa.setDetail(SAUtils.getGameName(bettingSa.getDetail()));
						bettingSa.setGametype(SAUtils.__GameType.get(bettingSa.getGametype()));
					}
				}
				returnObject.put("record", record);
				Map<String, Object> mapresult = bettingSaService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betamount"));//投注额
				returnObject.put("winningCredits", mapresult.get("resultamount"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("validbet"));//有效投注
			}else if(gametype.equals(Enum_GameType.洲际.gametype)){//作废
				if(!"null".equals(orderid)) {
					object.put("id", orderid);
					
				}
				object.put("field", "bettime");
				returnObject.put("record", bettingZjService.takeRecord(object));
				returnObject.put("count", bettingZjService.takeRecordCount(object));
			}else if(gametype.equals(Enum_GameType.MG.gametype)){
				if(!"null".equals(orderid)) {
					object.put("mgTransId", orderid);
					
				}
				object.put("field", "bettime");
				
				List<BettingMg> list = bettingMgService.takeRecord(object);
				ApiSoltGametype apiSoltGametype = null;
				for (BettingMg bettingMg : list) {
					apiSoltGametype = new ApiSoltGametype();
					apiSoltGametype.setBiggametype(GameEnum.Enum_GameType.MG.gametype);
					apiSoltGametype.setGamecodeweb(bettingMg.getMgGameId());
					apiSoltGametype = apiSoltGametypeService.selectFirst(apiSoltGametype);
					if(apiSoltGametype != null) {
						bettingMg.setMgMgsGameId(apiSoltGametype.getCnname());
					} else {
						//查H5
						apiSoltGametype = new ApiSoltGametype();
						apiSoltGametype.setBiggametype(GameEnum.Enum_GameType.MG.gametype);
						apiSoltGametype.setGamecodeh5(bettingMg.getMgGameId());
						apiSoltGametype = apiSoltGametypeService.selectFirst(apiSoltGametype);
						if(apiSoltGametype != null) {
							bettingMg.setMgMgsGameId(apiSoltGametype.getCnname());
						} 
					}
				}
				returnObject.put("record", list);
				Map<String, Object> mapresult = bettingMgService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betAmount"));//投注额
				returnObject.put("winningCredits", mapresult.get("netAmount"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("betAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.TTG.gametype)){
				if(!"null".equals(orderid)) {
					object.put("transactionid", orderid);
					
				}
				object.put("field", "bettime");
				returnObject.put("record", bettingTtgService.takeRecord(object));
				Map<String, Object> mapresult = bettingTtgService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betAmount"));//投注额
				returnObject.put("winningCredits", mapresult.get("netAmount"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("betAmount"));//有效投注
			}else if(gametype.equals(Enum_GameType.PNG.gametype)){//作废
				if(!"null".equals(orderid)) {
					object.put("billNo", orderid);
					
				}
				object.put("field", "bet_Time");
				returnObject.put("record", bettingHqPngService.takeRecord(object));
				returnObject.put("count", bettingHqPngService.takeRecordCount(object));
			}else if(gametype.equals(Enum_GameType.GG.gametype)){
				if(!"null".equals(orderid)) {
					object.put("autoid", orderid);
					
				}
				object.put("field", "bettime");
				returnObject.put("record", bettingGgService.takeRecord(object));
				Map<String, Object> mapresult = bettingGgService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("betmoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.SGS.gametype)){//暂时没有客户使用
				if(!"null".equals(orderid)) {
					object.put("ugsbetid", orderid);
					
				}
				object.put("field", "bettime");
				List<BettingSgs> record = bettingSgsService.takeRecord(object);
				if(null != record && record.size() >0) {
					String gameId = null;
					for (int i = 0; i < record.size(); i++) {
						gameId = record.get(i).getGameid();
						record.get(i).setGamename(SGSUtils.getGameName(gameId));
						gameId = null;
					}
				}
				returnObject.put("record", record);
				Map<String, Object> mapresult = bettingSgsService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("validmoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.IDN.gametype)){//客户已经停止使用
				if(!"null".equals(orderid)) {
					object.put("lsh", orderid);
					
				}
				object.put("field", "turnoverdate");
				returnObject.put("record", bettingIdn2Service.takeRecord(object));
				returnObject.put("count", bettingIdn2Service.takeRecordCount(object));
				
			}else if(gametype.equals(Enum_GameType.M88.gametype)){//没有使用到
				if(!"null".equals(orderid)) {
					object.put("transid", orderid);
					
				}
				object.put("field", "bettime");
				returnObject.put("record", bettingM88Service.takeRecord(object));
				returnObject.put("count", bettingM88Service.takeRecordCount(object));
			}else if(gametype.equals(Enum_GameType.HAB.gametype)){
				if(!"null".equals(orderid)) {
					object.put("friendlygameinstanceid", orderid);
					
				}
				object.put("field", "bettime");
				returnObject.put("record", bettingHabService.takeRecord(object));
				Map<String, Object> mapresult = bettingHabService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("betmoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.EBet.gametype)){
				if(!"null".equals(orderid)) {
					object.put("bethistoryid", orderid);
					
				}
				object.put("field", "bettime");
				returnObject.put("record", bettingEbetService.takeRecord(object));
				Map<String, Object> mapresult = bettingEbetService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("validbet"));//有效投注
			}else if(gametype.equals(Enum_GameType.GB彩票.gametype)){
				if(!"null".equals(orderid)) {
					object.put("settleid", orderid);
					
				}
				object.put("field", "bettime");
				
				List<BettingGb> list = bettingGbService.takeRecord(object);
				for (BettingGb bettingGb : list) {
					if(bettingGb.getKenolist() != null && bettingGb.getKenolist().length() > 5) {
						bettingGb.setGametype("keno彩票");
					} else if(bettingGb.getSsclist() != null && bettingGb.getSsclist().length() > 5) {
						bettingGb.setGametype("ssc时时彩");
					} else if(bettingGb.getLottolist() != null && bettingGb.getLottolist().length() > 5) {
						bettingGb.setGametype("lotto乐透");
					} else if(bettingGb.getPkxlist()!= null && bettingGb.getPkxlist().length() > 5) {
						bettingGb.setGametype("PK10");
					} 
				}
				returnObject.put("record", list);
				Map<String, Object> mapresult = bettingGbService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("betmoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.QTtech.gametype)){
				if(!"null".equals(orderid)) {
					object.put("playergameroundid", orderid);
					
				}
				object.put("field", "bettime");
				returnObject.put("record", bettingQtService.takeRecord(object));
				Map<String, Object> mapresult = bettingQtService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("betmoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.TGPlayer.gametype)){
				if(!"null".equals(orderid)) object.put("ugsbetid", orderid);
					
				object.put("field", "bettime");
				returnObject.put("record", bettingTgpService.takeRecord(object));
				Map<String, Object> mapresult = bettingTgpService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("validmoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.WIN88.gametype)){//暂时没有客户用到
				if(!"null".equals(orderid)) {
					object.put("ptGamecode", orderid);
					
				}
				object.put("field", "pt_gamedate");
				returnObject.put("record", bettingWin88Service.takeRecord(object));
				returnObject.put("count", bettingWin88Service.takeRecordCount(object));
			}else if(gametype.equals(Enum_GameType.eIBCGame.gametype)){
				if(!"null".equals(orderid)) {
					object.put("transid", orderid);
				}
				object.put("field", "bettime");
				returnObject.put("record", bettingEibcService.takeRecord(object));
				Map<String, Object> mapresult = bettingEibcService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("betmoney"));//有效投注
				
			}else if(gametype.equals(Enum_GameType.GGPoker.gametype)){
				if(!"null".equals(orderid)) {
					object.put("lsh", orderid);
					
				}
				object.put("field", "gamedate");
				
				//转人民币
				List<BettingGgp> list = bettingGgpService.takeRecord(object);
//				double usd = 1;// 2017/10/09 GGP数据按美金USD显示
				for (BettingGgp bettingGgp : list) {
					double real_money = MoneyHelper.moneyFormatDouble(bettingGgp.getBetmoney());//转人民币
					bettingGgp.setBetmoney(real_money);
				}
				returnObject.put("record", list);
				Map<String, Object> mapresult = bettingGgpService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				double money = MoneyHelper.moneyFormatDouble(SCom.getDouble(mapresult.get("betmoney")));
				returnObject.put("bettingCredits", money);//投注额
				returnObject.put("winningCredits", money);//输赢金额
				returnObject.put("washCodeCredits", money);//有效投注
				
			}else if(gametype.equals(Enum_GameType.YoPLAY.gametype)){
				if(!"null".equals(orderid)) {
					object.put("billNo", orderid);
				}
				object.put("field", "bet_Time");
				returnObject.put("record", bettingYoplayService.takeRecord(object));
				Map<String, Object> mapresult = bettingYoplayService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("validmoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.IM体育.gametype)){
				object.put("field", "bettime");
				returnObject.put("record", bettingImService.takeRecord(object));
				Map<String, Object> mapresult = bettingImService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("betmoney"));//有效投注
			}else if (gametype.equals(Enum_GameType.去玩棋牌.gametype)){
				object.put("field", "RecordTime");
				returnObject.put("record", bettingQwpService.takeRecord(object));
				Map<String, Object> mapresult = bettingQwpService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("betmoney"));//有效投注
			}else if (gametype.equals(Enum_GameType.JDB168.gametype)){
				object.put("field", "gameDate");
				returnObject.put("record", bettingJdbService.takeRecord(object));
				Map<String, Object> mapresult = bettingJdbService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("betmoney"));//有效投注
			}else if(gametype.equals(Enum_GameType.TGPGame.gametype)){
				if(!"null".equals(orderid)) object.put("ugsbetid", orderid);
					
				object.put("field", "bettime");
				returnObject.put("record", bettingTgpService.takeRecord(object));
				Map<String, Object> mapresult = bettingTgpService.takeRecordCountMoney(object);
				returnObject.put("count", mapresult.get("count"));
				returnObject.put("bettingCredits", mapresult.get("betmoney"));//投注额
				returnObject.put("winningCredits", mapresult.get("netmoney"));//输赢金额
				returnObject.put("washCodeCredits", mapresult.get("validmoney"));//有效投注
			}
			return Enum_MSG.成功.message(returnObject);
		}catch(ArgumentValidationException e){
			log.Error(e.getMessage(), e);
			return Enum_MSG.参数错误.message(e.getMessage());
		}catch(LogicTransactionRollBackException e){
			return Enum_MSG.逻辑事物异常.message(e.getMessage());
		}catch (Exception e) {
			log.Error(e.getMessage(), e);
			return Enum_MSG.系统错误.message(null);
		}
	}
	
	/**
	 * 获取企业品牌游戏列表
	 * 
	 * 根据品牌
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/BrandGameAll",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String BrandGameAll(HttpServletRequest request){
		try {
			
			Map<String,Object> object = super.apiDecode(super.getRequestParamters(request));
			AttrCheckout.checkout(object, false, new String[]{"brandcode"});
			
			List<Game> data = gameService.takeBrandGames(String.valueOf(object.get("brandcode")),EnterpriseOperatingBrandGame.Enum_flag.正常.value);
			for (Game game : data) {
				game.setAndroid("");
				game.setDownloadurl("");
				game.setGamecode("");
				game.setH5("");
				game.setIso("");
			}
			
			Map<String,Object> returnObject = new HashMap<String,Object>();
			
			returnObject.put("record", data);
			returnObject.put("count", data.size());
			
			return Enum_MSG.成功.message(returnObject);
		}catch(ArgumentValidationException e){
			log.Error(e.getMessage(), e);
			return Enum_MSG.参数错误.message(e.getMessage());
		}catch(LogicTransactionRollBackException e){
			return Enum_MSG.逻辑事物异常.message(e.getMessage());
		}catch (Exception e) {
			log.Error(e.getMessage(), e);
			return Enum_MSG.系统错误.message(null);
		}
	}
	
	/**
	 * 获取游戏数据，汇总数据
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/RecordsAll",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String dataAll(HttpServletRequest request){
		try {
			
//			以下参数可选：
//			startDate
//			endDate
//			gameBigType
//			gamePlatform
			
			Map<String,Object> object = super.apiDecode(super.getRequestParamters(request));
			AttrCheckout.checkout(object, false, new String[]{"employeecode","start","limit"});
			
			System.out.println("查游戏记录原参数："+object);
			
			String gametype = String.valueOf(object.get("gamePlatform"));//GGPGame
			String gameBigType = String.valueOf(object.get("gameBigType"));
			String startDate = String.valueOf(object.get("startDate"));
			String endDate = String.valueOf(object.get("endDate"));
			/*
			if(!gametype.equals("null") && !Enum_GameType.validate(gametype)){
				return Enum_MSG.参数错误.message(Enum_MSG.游戏类型错误.desc);
			}
			*/
			if(!gametype.equals("null") && gametype.length() > 0) {
				object.put("platformtype", Enum_GameType.getByGametype(gametype).bettingcode);
			}
			if(!gameBigType.equals("null") && gameBigType.length() > 0) {
				object.put("gameBigType", gameBigType);
			}
			
			if(!startDate.equals("null") && startDate.length() > 0) {
				object.put("startdate", startDate.replaceAll("-", ""));
				object.remove("startDate");
			} else {
				object.put("startdate", StringUtils.getDate());//默认当日
				object.remove("startDate");
			}
			if(!endDate.equals("null") && endDate.length() > 0) {
				object.put("enddate", endDate.replaceAll("-", ""));
				object.remove("endDate");
			} else {
				object.put("enddate", StringUtils.getDate());//默认当日
				object.remove("endDate");
			}
			
			
			Map<String,Object> returnObject = new HashMap<String,Object>();
			object.put("direction", "desc");
			object.put("field", "bettime");
			
			System.out.println("查游戏记录后参数："+object);
			
			
//			double USDRate = 1; // 2017/10/09 GGP数据按美金USD显示
			
			List<BettingAllGameWinloseDetail> list = bettingAllGameWinloseDetailService.selectForPage(object);
			List<Map<String, Object>> list2 = new ArrayList<Map<String, Object>>();
			for (BettingAllGameWinloseDetail item : list) {
				
				
				BettingAllDay data = new BettingAllDay();
				data.setUserName(item.getLoginaccount());
				data.setGamePlatform(Enum_GameType.getnameByBettingcode(item.getPlatformtype()) );
				data.setGameBigType(item.getGamebigtype());
				data.setBetDay(item.getBettime());
				if (gametype.equals(Enum_GameType.GGPoker.gametype)) {
					data.setBetMoney(MoneyHelper.moneyFormatDouble(item.getBetmoney()));//投注
					data.setNetMoney(MoneyHelper.moneyFormatDouble(item.getNetmoney()));//输赢/抽水
					data.setValidMoney(MoneyHelper.moneyFormatDouble(item.getValidbet()));//投注/有效投注
				} else {
					data.setBetMoney(item.getBetmoney());//投注
					data.setNetMoney(item.getNetmoney());//输赢/抽水
					data.setValidMoney(item.getValidbet());//投注/有效投注
				}
				
				list2.add(BeanToMapUtil.convertBean(AttrCheckout.checkout(data, true, 
						new String[]{"userName","gamePlatform","gameBigType","betDay","betMoney","netMoney","validMoney"}), false));
			}
			Map<String, Object> map = bettingAllGameWinloseDetailService.takeRecordCountMoney(object);
			returnObject.put("record", list2);
			returnObject.put("count", map.get("count"));
			
			if (gametype.equals(Enum_GameType.GGPoker.gametype)) {
				returnObject.put("betMoneyAll", map.get("betmoney") == null ? "0" : MoneyHelper.moneyFormat(((Double)map.get("betmoney"))));
				returnObject.put("netMoneyAll", map.get("netMoney") == null ? "0" : MoneyHelper.moneyFormat(((Double)map.get("netMoney"))));
			} else {
				returnObject.put("betMoneyAll", map.get("betmoney") == null ? "0" : map.get("betmoney"));
				returnObject.put("netMoneyAll", map.get("netMoney") == null ? "0" : map.get("netMoney"));
			}
			
			return Enum_MSG.成功.message(returnObject);
		}catch(ArgumentValidationException e){
			log.Error(e.getMessage(), e);
			return Enum_MSG.参数错误.message(e.getMessage());
		}catch(LogicTransactionRollBackException e){
			return Enum_MSG.逻辑事物异常.message(e.getMessage());
		}catch (Exception e) {
			log.Error(e.getMessage(), e);
			return Enum_MSG.系统错误.message(null);
		}
	}
	
	
	
	/**
	 * 获取日结报表汇总数据
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/RecordsDayAll",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String RecordsDayAll(HttpServletRequest request){
		try {
			
			
			Map<String,Object> object = super.apiDecode(super.getRequestParamters(request));
			AttrCheckout.checkout(object, false, new String[]{"employeecode","start","limit"});
			
			System.out.println("查游戏记录原参数："+object);
			
			String startDate = String.valueOf(object.get("startDate"));
			String endDate = String.valueOf(object.get("endDate"));
			
			if(!startDate.equals("null") && startDate.length() > 0) {
				object.put("startdate", startDate.replaceAll("-", ""));
				object.remove("startDate");
			} else {
				object.put("startdate", StringUtils.getDate());//默认当日
				object.remove("startDate");
			}
			if(!endDate.equals("null") && endDate.length() > 0) {
				object.put("enddate", endDate.replaceAll("-", ""));
				object.remove("endDate");
			} else {
				object.put("enddate", StringUtils.getDate());//默认当日
				object.remove("endDate");
			}
			
			
			Map<String,Object> returnObject = new HashMap<String,Object>();
			object.put("direction", "desc");
			object.put("field", "Add_Time");
			
			System.out.println("查游戏记录后参数："+object);
			
			
			List<BettingAllDay> list = bettingAllDayService.selectForPage(object);
			List<Map<String, Object>> list2 = new ArrayList<Map<String, Object>>();
			for (BettingAllDay item : list) {
				
				item.setGamePlatform(Enum_GameType.getname(item.getGamePlatform()) );
				
			}
			Map<String, Object> map = bettingAllDayService.takeRecordCountMoney(object);
			returnObject.put("record", list2);
			returnObject.put("count", map.get("count"));
			returnObject.put("betMoneyAll", map.get("betmoney") == null ? "0" : map.get("betmoney"));
			returnObject.put("netMoneyAll", map.get("netMoney") == null ? "0" : map.get("netMoney"));
			returnObject.put("validMoneyAll", map.get("validMoney") == null ? "0" : map.get("validMoney"));
			
			return Enum_MSG.成功.message(returnObject);
		}catch(ArgumentValidationException e){
			log.Error(e.getMessage(), e);
			return Enum_MSG.参数错误.message(e.getMessage());
		}catch(LogicTransactionRollBackException e){
			return Enum_MSG.逻辑事物异常.message(e.getMessage());
		}catch (Exception e) {
			log.Error(e.getMessage(), e);
			return Enum_MSG.系统错误.message(null);
		}
	}
	
	

	@Override
	public LoggerManager getLogger() {
		return log;
	}
}
