package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.MemExceptionJob;
import com.zy.power.mem.entity.MemExceptionJobCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface MemExceptionJobMapper extends Mapper<MemExceptionJob> {
    long countByExample(MemExceptionJobCriteria example);

    int deleteByExample(MemExceptionJobCriteria example);

    List<MemExceptionJob> selectByExample(MemExceptionJobCriteria example);

    int updateByExampleSelective(@Param("record") MemExceptionJob record, @Param("example") MemExceptionJobCriteria example);

    int updateByExample(@Param("record") MemExceptionJob record, @Param("example") MemExceptionJobCriteria example);
}