package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.SystemLog;
import com.zy.power.mem.entity.SystemLogCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface SystemLogMapper extends Mapper<SystemLog> {
    long countByExample(SystemLogCriteria example);

    int deleteByExample(SystemLogCriteria example);

    List<SystemLog> selectByExample(SystemLogCriteria example);

    int updateByExampleSelective(@Param("record") SystemLog record, @Param("example") SystemLogCriteria example);

    int updateByExample(@Param("record") SystemLog record, @Param("example") SystemLogCriteria example);
}