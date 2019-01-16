package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.MemDept;
import com.zy.power.mem.entity.MemDeptCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface MemDeptMapper extends Mapper<MemDept> {
    long countByExample(MemDeptCriteria example);

    int deleteByExample(MemDeptCriteria example);

    List<MemDept> selectByExample(MemDeptCriteria example);

    int updateByExampleSelective(@Param("record") MemDept record, @Param("example") MemDeptCriteria example);

    int updateByExample(@Param("record") MemDept record, @Param("example") MemDeptCriteria example);
}