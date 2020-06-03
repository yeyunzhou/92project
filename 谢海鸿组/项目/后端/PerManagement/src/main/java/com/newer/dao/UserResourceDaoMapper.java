package com.newer.dao;

import com.newer.domain.Resource;
import com.newer.domain.UserResource;
import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.mapping.FetchType;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * Create by 何辉
 * 2020/6/1 14:38
 */
public interface UserResourceDaoMapper extends Mapper<UserResource>{
    @Select("select * from t_user_resource where userid=#{userid}")
    @Results({
            @Result(column = "resourceid",property = "resources",many=@Many(select="com.newer.dao.ResourceDaoMapper.showResource",fetchType= FetchType.EAGER))
    })
    public List<UserResource> findResource(Integer userid);
}
