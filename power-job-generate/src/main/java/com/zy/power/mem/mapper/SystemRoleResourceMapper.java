package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.SystemRoleResource;
import com.zy.power.mem.entity.SystemRoleResourceCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface SystemRoleResourceMapper extends Mapper<SystemRoleResource> {
    long countByExample(SystemRoleResourceCriteria example);

    int deleteByExample(SystemRoleResourceCriteria example);

    List<SystemRoleResource> selectByExample(SystemRoleResourceCriteria example);

    int updateByExampleSelective(@Param("record") SystemRoleResource record, @Param("example") SystemRoleResourceCriteria example);

    int updateByExample(@Param("record") SystemRoleResource record, @Param("example") SystemRoleResourceCriteria example);
}