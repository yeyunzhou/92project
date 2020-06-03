package com.newer.service.impl;

import com.newer.dao.UserResourceDaoMapper;
import com.newer.domain.Resource;
import com.newer.domain.UserResource;
import com.newer.service.UserResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * Create by 何辉
 * 2020/6/1 14:35
 */
@Service
public class UserResourceServiceImpl implements UserResourceService {
    @Autowired
    private UserResourceDaoMapper daoMapper;
    @Override
    public boolean deleteId(Integer id) {
        Example example=new Example(UserResource.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("userid",id);
        int i = this.daoMapper.deleteByExample(example);
        return i>0?true:false;
    }

    @Override
    public int insert(Integer userId, Integer id) {
        UserResource userResource=new UserResource();
        userResource.setUserid(userId);
        userResource.setResourceid(id);
        int insert = this.daoMapper.insert(userResource);
        return insert;
    }

    @Override
    public List findResource(Integer userid) {
        List<UserResource> resource = this.daoMapper.findResource(userid);
        return resource;
    }

    @Override
    public List<UserResource> showResource(Integer id) {
        List<UserResource> resource = this.daoMapper.findResource(id);
        return resource;
    }
}
