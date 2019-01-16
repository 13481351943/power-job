package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.MemAttament;
import com.zy.power.mem.entity.MemAttamentCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface MemAttamentMapper extends Mapper<MemAttament> {
    long countByExample(MemAttamentCriteria example);

    int deleteByExample(MemAttamentCriteria example);

    List<MemAttament> selectByExample(MemAttamentCriteria example);

    int updateByExampleSelective(@Param("record") MemAttament record, @Param("example") MemAttamentCriteria example);

    int updateByExample(@Param("record") MemAttament record, @Param("example") MemAttamentCriteria example);
}