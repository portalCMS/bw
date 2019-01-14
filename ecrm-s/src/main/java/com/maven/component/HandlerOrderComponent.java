package com.maven.component;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.maven.service.TakeDepositRecoredService;
/**
 *定期处理存款订单状态 
 */
@Component
@Lazy(false)
public class HandlerOrderComponent {
	private Logger logger = LoggerFactory.getLogger(HandlerOrderComponent.class);

	@Autowired
	private TakeDepositRecoredService takeDepositRecoredService;

	/**
	 * 每10分钟修改一次过期订单状态
	 */
	@Scheduled(cron = "0 0/10 * * * ?")
	public void report() {
		logger.info("开始处理超时支付订单。。。");
		takeDepositRecoredService.batchRefuseOrder();
		logger.info("结束处理超时支付订单。。。");
	}
}
