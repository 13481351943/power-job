package com.zy.power.mem.mapper;

import com.zy.power.mem.entity.SystemUser;
import com.zy.power.mem.entity.SystemUserCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface SystemUserMapper extends Mapper<SystemUser> {
    long countByExample(SystemUserCriteria example);

    int deleteByExample(SystemUserCriteria example);

    List<SystemUser> selectByExample(SystemUserCriteria example);

    int updateByExampleSelective(@Param("record") SystemUser record, @Param("example") SystemUserCriteria example);

    int updateByExample(@Param("record") SystemUser record, @Param("example") SystemUserCriteria example);
}