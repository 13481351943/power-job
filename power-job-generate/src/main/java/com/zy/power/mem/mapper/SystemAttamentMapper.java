package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.SystemAttament;
import com.zy.power.mem.entity.SystemAttamentCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface SystemAttamentMapper extends Mapper<SystemAttament> {
    long countByExample(SystemAttamentCriteria example);

    int deleteByExample(SystemAttamentCriteria example);

    List<SystemAttament> selectByExample(SystemAttamentCriteria example);

    int updateByExampleSelective(@Param("record") SystemAttament record, @Param("example") SystemAttamentCriteria example);

    int updateByExample(@Param("record") SystemAttament record, @Param("example") SystemAttamentCriteria example);
}