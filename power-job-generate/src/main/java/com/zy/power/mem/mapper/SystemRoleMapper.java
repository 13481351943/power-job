package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.SystemRole;
import com.zy.power.mem.entity.SystemRoleCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface SystemRoleMapper extends Mapper<SystemRole> {
    long countByExample(SystemRoleCriteria example);

    int deleteByExample(SystemRoleCriteria example);

    List<SystemRole> selectByExample(SystemRoleCriteria example);

    int updateByExampleSelective(@Param("record") SystemRole record, @Param("example") SystemRoleCriteria example);

    int updateByExample(@Param("record") SystemRole record, @Param("example") SystemRoleCriteria example);
}