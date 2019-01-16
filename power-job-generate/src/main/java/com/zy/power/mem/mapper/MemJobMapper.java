package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.MemJob;
import com.zy.power.mem.entity.MemJobCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface MemJobMapper extends Mapper<MemJob> {
    long countByExample(MemJobCriteria example);

    int deleteByExample(MemJobCriteria example);

    List<MemJob> selectByExample(MemJobCriteria example);

    int updateByExampleSelective(@Param("record") MemJob record, @Param("example") MemJobCriteria example);

    int updateByExample(@Param("record") MemJob record, @Param("example") MemJobCriteria example);
}