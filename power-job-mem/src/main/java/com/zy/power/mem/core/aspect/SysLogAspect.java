package com.zy.power.mem.core.aspect;

import java.lang.reflect.Method;
import java.util.Date;
import java.util.UUID;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zy.power.mem.common.util.ExceptionUtil;
import com.zy.power.mem.core.annotation.SysLogger;
import com.zy.power.mem.entity.SystemLog;
import com.zy.power.mem.service.ISysLogService;

/**
 * 系统日志，切面处理类
 */
@Aspect
@Component
public class SysLogAspect {
	private static Logger logger = LoggerFactory.getLogger(SysLogAspect.class);
	
	@Autowired
	ISysLogService sysLogService;

	@Pointcut("@annotation(com.zy.power.mem.core.annotation.SysLogger)")
	public void logPointCut() { 
		
	}
	
	@Around("logPointCut()")
	public Object around(ProceedingJoinPoint point) throws Throwable {
		long beginTime = System.currentTimeMillis();
		//执行方法
		Object result = point.proceed();
		//执行时长(毫秒)
		long time = System.currentTimeMillis() - beginTime;
		//保存日志
		try {
			saveSysLog(point, time);
		} catch (Exception e) {
			logger.debug("记录日志异常：{}",ExceptionUtil.getStackTraceAsString(e));
		}
		return result;
	}

	private void saveSysLog(ProceedingJoinPoint joinPoint, long time) {
		MethodSignature signature = (MethodSignature) joinPoint.getSignature();
		Method method = signature.getMethod();
		String description = method.getAnnotation(SysLogger.class).value();
		String name = method.getAnnotation(SysLogger.class).name();
		//请求的方法名
		String methodName = joinPoint.getTarget().getClass().getName()+
									":"+signature.getName();
		SystemLog sysLog = createSystemLog("",methodName,description,name);
		//保存系统日志
		sysLogService.insertSelective(sysLog);
	}
	
	private SystemLog createSystemLog(String userName,String methodName,String description,String name) {
		SystemLog sysLog = new SystemLog();
		sysLog.setId(UUID.randomUUID().toString());
		sysLog.setCreateBy(userName);
		sysLog.setCreateTime(new Date());
		sysLog.setUpdateBy(userName);
		sysLog.setUpdateTime(new Date());
		sysLog.setDescription(description);
		sysLog.setName(name);
		sysLog.setOpeMethod(methodName);
		return sysLog;
	}
    
}
