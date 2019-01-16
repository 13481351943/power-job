package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.MemRole;
import com.zy.power.mem.entity.MemRoleCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface MemRoleMapper extends Mapper<MemRole> {
    long countByExample(MemRoleCriteria example);

    int deleteByExample(MemRoleCriteria example);

    List<MemRole> selectByExample(MemRoleCriteria example);

    int updateByExampleSelective(@Param("record") MemRole record, @Param("example") MemRoleCriteria example);

    int updateByExample(@Param("record") MemRole record, @Param("example") MemRoleCriteria example);
}