package com.newer.dao;

import com.newer.domain.User;
import com.newer.dto.UserDto;
import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.mapping.FetchType;
import tk.mybatis.mapper.common.Mapper;

import javax.persistence.Column;
import java.util.List;

/**
 * Create by 何辉
 * 2020/3/28 21:13
 */
public interface UserDaoMapper extends Mapper<User> {
    @Select("select * from t_tree_user where username=#{username}")
    @Results({
            @Result(column = "userid",property = "userid"),
            @Result(column = "userid",property = "userRoles",many=@Many(select="com.newer.dao.UserRoleDaoMapper.getUserRolebyUserId",fetchType= FetchType.EAGER))
    })
    public User login(String username);


    //谢海鸿  05-04 14:58 查询相关主管的下属
    @Select("select * from t_tree_user  where description='员工' and upno=#{id}")
    public List<User> findExecutor(Integer id);

    @Select(" select * from t_tree_user a where a.description='员工' and  upno=#{id} and userid not in(select distinct(userid) from t_pro_task where userid=#{userid})")
    public List<User> findUsers(Integer id,Integer userid);

    @Select("select * from t_tree_user where userid=#{userid}")
    @Results(
            @Result(column = "id",property = "userRoles",many=@Many(select="com.newer.dao.UserRoleDaoMapper.getUserRolebyUserId",fetchType= FetchType.EAGER))
    )
    public User findUserById(Integer userid);

    @Select("select a.*,b.deptname from t_tree_user a,t_department b where a.deptid=b.deptid and a.deletestatus=0 ")
    @Results({
            @Result(column = "deptname",property = "department.deptname")
    })
    public List<User> showUser();


    @Select("select * from t_tree_user where description='经理' and deptid=#{deptid}")
    public List<User> findDeptMager(Integer deptid);//查询部门经理

    @Select(" select a.*,b.deptname from t_tree_user a,t_department b where a.deptid=b.deptid and a.deletestatus=0 ")
    @Results({
            @Result(column = "userid",property = "userid"),
            @Result(column = "deptname",property = "department.deptname"),
            @Result(column = "userid",property = "tasks",many = @Many(select = "com.newer.dao.TaskMapper.selectByUserId",fetchType = FetchType.EAGER))
    })
    public List<User> findUserTaskDept();

}
