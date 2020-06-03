package com.newer.service;

import com.newer.domain.Resource;

import java.util.List;

/**
 * Create by 何辉
 * 2020/4/4 13:59
 */
public interface ResourceService {
    public List<Resource> findAll();

    //tree树形结构
    List<Resource> tree(Integer id);
    List<Resource> showResource(Integer resourceid);
}
