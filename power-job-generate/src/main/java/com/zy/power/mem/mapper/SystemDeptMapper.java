package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.SystemDept;
import com.zy.power.mem.entity.SystemDeptCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface SystemDeptMapper extends Mapper<SystemDept> {
    long countByExample(SystemDeptCriteria example);

    int deleteByExample(SystemDeptCriteria example);

    List<SystemDept> selectByExample(SystemDeptCriteria example);

    int updateByExampleSelective(@Param("record") SystemDept record, @Param("example") SystemDeptCriteria example);

    int updateByExample(@Param("record") SystemDept record, @Param("example") SystemDeptCriteria example);
}