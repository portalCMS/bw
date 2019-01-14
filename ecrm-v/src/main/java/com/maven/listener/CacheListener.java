package com.maven.listener;

import javax.servlet.ServletContextEvent;

import org.springframework.web.context.ContextLoaderListener;

import com.maven.cache.factory.impl.LocalCache;
import com.maven.service.BusinessEmployeeTypeService;
import com.maven.utility.SpringContextHolder;

public class CacheListener extends ContextLoaderListener {
	
	@Override
	public void contextInitialized(ServletContextEvent event) {
		initEnterpriseEmployeeType();
	}
	
	/**
	 * 初始化用户类型
	 */
	private void initEnterpriseEmployeeType(){
		BusinessEmployeeTypeService businessEmployeeTypeService =(BusinessEmployeeTypeService)SpringContextHolder.getBean(BusinessEmployeeTypeService.class);
		LocalCache.getInstance().setEnterpriseEmployeeType(businessEmployeeTypeService.getAllEmployeeType());
	}
}
