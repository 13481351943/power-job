package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.MemJobRecord;
import com.zy.power.mem.entity.MemJobRecordCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface MemJobRecordMapper extends Mapper<MemJobRecord> {
    long countByExample(MemJobRecordCriteria example);

    int deleteByExample(MemJobRecordCriteria example);

    List<MemJobRecord> selectByExample(MemJobRecordCriteria example);

    int updateByExampleSelective(@Param("record") MemJobRecord record, @Param("example") MemJobRecordCriteria example);

    int updateByExample(@Param("record") MemJobRecord record, @Param("example") MemJobRecordCriteria example);
}