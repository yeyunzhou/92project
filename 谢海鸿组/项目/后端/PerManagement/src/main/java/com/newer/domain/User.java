package com.newer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Create by 何辉
 * 2020/3/28 20:58
 * 用户表
 */
@Table(name = "t_tree_user")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class User{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator = " select seq_user_userid.nextval from dual ")
    private Integer userid;
    private String username;
    private String password;
    private String realname;
    private String salt;
    private BigDecimal basepay;
    private String description;
    private Integer locked;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createtime;
    private Integer deletestatus;
    private String sex;
    private Integer age;
    private String education;
    private String telephone;
    private String email;
    private String province;
    private String city;
    private String area;
    private String address;
    private Integer upno;
    private Integer deptid;
    private Department department;
//    private Integer sjide;
    private String title;
    private List<UserRole> userRoles;
    private List<Task> tasks;
    public String getCreatetimeString(){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(this.createtime!=null){
            return sdf.format(this.createtime);
        }
        return null;
    }
}
