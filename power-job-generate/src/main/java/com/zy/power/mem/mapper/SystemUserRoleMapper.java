package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.SystemUserRole;
import com.zy.power.mem.entity.SystemUserRoleCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface SystemUserRoleMapper extends Mapper<SystemUserRole> {
    long countByExample(SystemUserRoleCriteria example);

    int deleteByExample(SystemUserRoleCriteria example);

    List<SystemUserRole> selectByExample(SystemUserRoleCriteria example);

    int updateByExampleSelective(@Param("record") SystemUserRole record, @Param("example") SystemUserRoleCriteria example);

    int updateByExample(@Param("record") SystemUserRole record, @Param("example") SystemUserRoleCriteria example);
}