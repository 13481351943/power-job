package com.zy.power.mem.service;

import com.zy.power.mem.core.support.IBaseService;
import com.zy.power.mem.entity.SystemLog;

public interface ISysLogService extends IBaseService<SystemLog> {

	public Integer save(SystemLog sysLog);
}
