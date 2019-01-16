package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.MemMember;
import com.zy.power.mem.entity.MemMemberCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface MemMemberMapper extends Mapper<MemMember> {
    long countByExample(MemMemberCriteria example);

    int deleteByExample(MemMemberCriteria example);

    List<MemMember> selectByExample(MemMemberCriteria example);

    int updateByExampleSelective(@Param("record") MemMember record, @Param("example") MemMemberCriteria example);

    int updateByExample(@Param("record") MemMember record, @Param("example") MemMemberCriteria example);
}