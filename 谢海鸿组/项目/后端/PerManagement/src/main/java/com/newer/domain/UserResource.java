package com.newer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.List;

/**
 * Create by 何辉
 * 2020/6/1 14:33
 */
@Table(name = "t_user_resource")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserResource {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator = " select t_user_resource_id.nextval from dual ")
    private Integer id;
    private Integer userid;
    private Integer resourceid;
    private List<Resource> resources;
}
