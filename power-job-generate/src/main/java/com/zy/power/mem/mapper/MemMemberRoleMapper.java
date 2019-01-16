package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.MemMemberRole;
import com.zy.power.mem.entity.MemMemberRoleCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface MemMemberRoleMapper extends Mapper<MemMemberRole> {
    long countByExample(MemMemberRoleCriteria example);

    int deleteByExample(MemMemberRoleCriteria example);

    List<MemMemberRole> selectByExample(MemMemberRoleCriteria example);

    int updateByExampleSelective(@Param("record") MemMemberRole record, @Param("example") MemMemberRoleCriteria example);

    int updateByExample(@Param("record") MemMemberRole record, @Param("example") MemMemberRoleCriteria example);
}