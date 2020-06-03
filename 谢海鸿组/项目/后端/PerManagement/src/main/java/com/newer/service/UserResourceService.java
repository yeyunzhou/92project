package com.newer.service;

import com.newer.domain.Resource;
import com.newer.domain.UserResource;

import java.util.List;

/**
 * Create by 何辉
 * 2020/6/1 14:35
 */
public interface UserResourceService {
    public boolean deleteId(Integer id);

    public int insert(Integer userId,Integer id);

    public List findResource(Integer userid);

    List<UserResource> showResource(Integer id);
}
