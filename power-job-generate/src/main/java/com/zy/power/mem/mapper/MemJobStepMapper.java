package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.MemJobStep;
import com.zy.power.mem.entity.MemJobStepCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface MemJobStepMapper extends Mapper<MemJobStep> {
    long countByExample(MemJobStepCriteria example);

    int deleteByExample(MemJobStepCriteria example);

    List<MemJobStep> selectByExample(MemJobStepCriteria example);

    int updateByExampleSelective(@Param("record") MemJobStep record, @Param("example") MemJobStepCriteria example);

    int updateByExample(@Param("record") MemJobStep record, @Param("example") MemJobStepCriteria example);
}