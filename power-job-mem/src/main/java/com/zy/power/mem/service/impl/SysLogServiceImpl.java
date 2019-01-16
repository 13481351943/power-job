package com.zy.power.mem.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zy.power.mem.core.support.BaseMapper;
import com.zy.power.mem.core.support.BaseServiceImpl;
import com.zy.power.mem.entity.SystemLog;
import com.zy.power.mem.mapper.SystemLogMapper;
import com.zy.power.mem.service.ISysLogService;

@Service
public class SysLogServiceImpl extends BaseServiceImpl<SystemLog> implements ISysLogService{
	
	private static Logger logger = LoggerFactory.getLogger(SysLogServiceImpl.class);

	private static final String BASE_MESSAGE = "系统化模块类SysLogServiceImpl增删改查";

	@Autowired
	SystemLogMapper sysLogMapper;
	
	@Override
	protected BaseMapper<SystemLog> getBaseMapper() {
		return this.sysLogMapper;
	}

	@Override
	protected String getBaseMessage() {
		return BASE_MESSAGE;
	}

	@Override
	protected Logger getLogger() {
		return logger;
	}
	
	@Override
	public Integer save(SystemLog sysLog) {
		Integer count = sysLogMapper.save(sysLog);
		return count;
	}
}
