package com.newer.controller;

import com.github.pagehelper.PageInfo;
import com.newer.domain.*;
import com.newer.dto.PageDto;
import com.newer.dto.UpdatePowerDto;
import com.newer.dto.UserDto;
import com.newer.service.*;
import com.newer.util.CommonsResult;
import com.newer.util.Sessions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.multipart.MultipartFile;

import tk.mybatis.mapper.entity.Example;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Create by 何辉
 * 2020/5/10 21:28
 */
@RestController
@RequestMapping("admin")
@SessionAttributes(Sessions.SESSION_LOGIN_USER)
public class AdminController {
@Autowired
    private ResourceService resourceService;
@Autowired
    private DimissionService dimissionService;
@Autowired
private UserService userService;
@Autowired
private UserRoleService userRoleService;
@Autowired
private UserResourceService userResourceService;
    //树形结构查询
    @GetMapping("tree")
    public CommonsResult tree(){
        List<Resource> tree = this.resourceService.tree(1);
        return new CommonsResult(200,"树形结构",tree);
    }

    //离职申请
    @PostMapping("addDimission")
    public CommonsResult addDimission(@RequestBody Dimission dimission,HttpSession session,ModelMap modelMap) throws ParseException {
        User user =(User)modelMap.getAttribute(Sessions.SESSION_LOGIN_USER);
        System.out.println(user);
        dimission.setUserid(user.getUserid());
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String format = simpleDateFormat.format(new Date(System.currentTimeMillis()));
        dimission.setDimDate(simpleDateFormat.parse(format));
        dimission.setPosition(user.getDescription());
        CommonsResult commonsResult = this.dimissionService.addDimission(dimission);
        return commonsResult;
    }



    //查看离职申请
    @GetMapping("showDimission")
    public CommonsResult showDimission(HttpSession session,ModelMap modelMap)throws ParseException {
        User user =(User)modelMap.getAttribute(Sessions.SESSION_LOGIN_USER);
        System.out.println(user);
        PageInfo<Dimission> pageInfo = this.dimissionService.showDimission(user, new PageDto());
        return new CommonsResult(200,"操作成功",pageInfo);
    }

    @GetMapping("findUserTaskDept")
    public CommonsResult findUserTaskDept(){
        List<User> userTaskDept = this.userService.findUserTaskDept();
        System.out.println(userTaskDept);
        return new CommonsResult(200,"操作成功",userTaskDept);
    }
    //驳回离职请求
    @PostMapping("reject")
    public CommonsResult reject(@RequestBody Dimission dimission,HttpSession session,ModelMap modelMap)throws ParseException {
        User user =(User)modelMap.getAttribute(Sessions.SESSION_LOGIN_USER);
        CommonsResult reject = this.dimissionService.reject(user, dimission);
        return reject;
    }

    //批准离职请求
    @PostMapping("ratify")
    public CommonsResult ratify(@RequestBody Dimission dimission,HttpSession session,ModelMap modelMap)throws ParseException {
        User user =(User)modelMap.getAttribute(Sessions.SESSION_LOGIN_USER);
        CommonsResult reject = this.dimissionService.ratify(user,dimission);
        return reject;
    }

    //管理员操作，显示所有人员列表
    @GetMapping("showUser")
    public CommonsResult showUser(Integer page,Integer pageSize){
        PageInfo pageInfo = this.userService.showUser(page, pageSize);
        return new CommonsResult(200,"操作成功",pageInfo);
    }

    @PostMapping("updateLocked")
    public CommonsResult updateLocked(@RequestBody User user){
        CommonsResult<User> userCommonsResult = this.userService.updateLocked(user);
        return userCommonsResult;
    }


    @GetMapping("showRoleResource")
    public CommonsResult showRoleResource(Integer userid){
        List<UserResource> userResources = this.userResourceService.showResource(userid);
        Set<Integer> set=new HashSet<>();
        if(userResources!=null){
            for (UserResource userResource:userResources){
                for (Resource resource:userResource.getResources()){
                    if(resource.getUrl()!=null){
                        set.add(resource.getId());
                    }

                }
            }
        }

        return new CommonsResult(200,"操作成功",set);
    }

    @PostMapping("updatePower")
    public CommonsResult updatePower(@RequestBody UpdatePowerDto updatePowerDto){
        System.out.println(updatePowerDto);
         this.userResourceService.deleteId(updatePowerDto.getUserid());
        for(int i=0;i<updatePowerDto.getIntegers().length;i++){
            this.userResourceService.insert(updatePowerDto.getUserid(),updatePowerDto.getIntegers()[i]);
        }
        return new CommonsResult(200,"操作成功",null);
    }

//    @GetMapping("findUserTaskDept")
//    public CommonsResult findUserTaskDept(){
//        List<UserDto> userTaskDept = this.userService.findUserTaskDept();
//        return new CommonsResult(200,"操作成功",userTaskDept);
//    }

    @PostMapping("updateUser")
    public CommonsResult updateUser(@RequestBody User user){
        System.out.println(user);
        CommonsResult commonsResult = this.userService.updateUser(user);
        return commonsResult;
    }

    @GetMapping("showUpno")
    public CommonsResult showUpno(Integer upno) {
        CommonsResult commonsResult = this.userService.showUpno(upno);
        return commonsResult;
    }
    //管理员操作，显示所有人员列表
    @PostMapping("userFileUrl")
    public String userFileUrl(@RequestParam MultipartFile img,HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException {

        String path="/upload/";
        if(img!=null && !"".equals(img.getOriginalFilename())) {
            //文件上传处理
            String oldName=img.getOriginalFilename();
            //得到源文件的扩展名
            String ext=oldName.substring(oldName.lastIndexOf("."));
            //得新的名称
            String newName= UUID.randomUUID()+ext;
            //自己增加，每天上传的文件，对应一个文件夹2020-2-21
            //实际应用中，要考虑各种情况，本次例子中只讲了最简单的情况
            //得到绝对路径
            String realpath= session.getServletContext().getRealPath("upload")+"/"+newName;
            //保存
            img.transferTo(new File(realpath));



            return path+newName;
        }
        return null;
    }

    //保存头像
    @PostMapping("saveUserFileUrl")
    public void saveUserFileUrl(@RequestBody User user,HttpSession session,ModelMap modelMap) throws IOException {
        User user1 =(User)modelMap.getAttribute(Sessions.SESSION_LOGIN_USER);
        user.setUserid(user1.getUserid());
        this.userService.updateTitle(user);
    }
}
