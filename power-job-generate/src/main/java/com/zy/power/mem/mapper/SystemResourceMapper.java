package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.SystemResource;
import com.zy.power.mem.entity.SystemResourceCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface SystemResourceMapper extends Mapper<SystemResource> {
    long countByExample(SystemResourceCriteria example);

    int deleteByExample(SystemResourceCriteria example);

    List<SystemResource> selectByExample(SystemResourceCriteria example);

    int updateByExampleSelective(@Param("record") SystemResource record, @Param("example") SystemResourceCriteria example);

    int updateByExample(@Param("record") SystemResource record, @Param("example") SystemResourceCriteria example);
}