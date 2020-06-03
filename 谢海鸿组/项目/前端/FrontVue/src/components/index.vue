<template>
    <el-container v-if="$store.getters.getUsers!=null">
  <el-header>

      <el-menu 
  class="el-menu-demo"
  mode="horizontal"
  background-color="#303133"
  text-color="#fff"
  active-text-color="#ffd04b">
<el-menu-item index="1">

  

  <el-avatar  style="margin:0px auto;" :src="imgUrl" :key="imgUrl" >
  </el-avatar>
  &nbsp;&nbsp;
 <el-popover
    placement="top-start"
    width="200"
    trigger="hover">
    <el-upload action="http://localhost:8088/admin/userFileUrl"
  list-type="picture-card"
  name="img"
  :show-file-list="false"
  :on-success="handleSuccess"
  >
  &nbsp;&nbsp;&nbsp;
  <i class="el-icon-plus"></i>
</el-upload>
  &nbsp;&nbsp;&nbsp;&nbsp;<ElButton type="primary" @click="isMe">修改个人信息</ElButton>

    <span slot="reference">{{$store.state.login.users.realname}}</span>
    </el-popover> &nbsp;&nbsp;
     <span>{{$store.state.login.users.description}}</span>
  </el-menu-item>
  

  <div style="float:right"><el-button type="danger" round style="line-height:0px;width:65px;font-size:10px;" @click="logOut">退出</el-button>
  </div>
</el-menu>
 
  </el-header>

  
  <el-container>
       <el-aside width="280px">
    <el-menu
      default-active="2"
      class="el-menu-vertical-demo"
      @open="handleOpen"
      @close="handleClose"
      background-color="#D3D3D3"
      >
      <el-submenu index="1" v-show="show.考勤管理 =='考勤管理'">
        <template slot="title">
          <i class="el-icon-menu"></i>
          <span>考勤管理</span>
        </template>
        <!-- <el-menu-item-group> -->
          <!-- <template slot="title">分组一</template> -->
          <el-menu-item index="/selectAttendance" @click="selectAttendance" v-show="show.考勤记录 =='考勤记录'">考勤记录</el-menu-item>
          <el-menu-item index="/saveOvertim" @click="saveOvertim" v-show="show.加班申请 =='加班申请'">加班申请</el-menu-item>
          <el-menu-item index="/findOvertimByUpno" @click="findOvertimByUpno" v-show="show.待处理加班记录 =='待处理加班记录'">待处理加班记录</el-menu-item>
           <el-menu-item index="/selectLeave" @click="selectLeave" v-show="show.请假记录 =='请假记录'">请假记录</el-menu-item>
                <el-menu-item index="/createLeave" @click="createLeave" v-show="show.请假申请 =='请假申请'">请假申请</el-menu-item>
                <!-- <el-menu-item index="/updateLeave" @click="updateLeave" v-show="show.待审批请假记录 =='待审批请假记录'">待审批请假记录</el-menu-item>-->
               <el-menu-item index="/updateLeave2" @click="updateLeave2" v-show="show.待审批请假 =='待处理请假记录'">待处理请假记录</el-menu-item>
        <!-- </el-menu-item-group> -->
        <!-- <el-menu-item-group title="分组2"> -->
          <el-menu-item index="/selectEvection" @click="selectEvection" v-show="show.出差记录 =='出差记录'">出差记录</el-menu-item>
           <el-menu-item index="/createEvection" @click="createEvection" v-show="show.出差申请 =='出差申请'">出差申请</el-menu-item>
         <el-menu-item index="/updateEvection" @click="updateEvection" v-show="show.出差审批 =='出差审批'">出差审批</el-menu-item>
        <!-- </el-menu-item-group> -->
        <!-- <el-submenu index="1-4"> -->
          <!-- <template slot="title">出差信息</template> -->
          <el-menu-item index="/selectEvectionaccount" @click="selectEvectionaccount" v-show="show.出差详细信息 =='出差详细信息'">出差详细信息</el-menu-item>
        <!-- </el-submenu>-->
      </el-submenu> 

       <el-submenu index="2"  v-show="show.薪资管理 =='薪资管理'">
        <template slot="title">
          <i class="el-icon-menu"></i>
          <span>薪资管理</span>
        </template>
          <el-menu-item index="/findWage" @click="findWage(editableTabsValue)"  v-show="show.查看记录 =='查看记录'">查看记录</el-menu-item>
          <el-menu-item index="/issueWage" @click="issueWage(editableTabsValue)"  v-show="show.薪资发放 =='薪资发放'">薪资发放</el-menu-item>
          <!--<el-menu-item index="/saveWage" @click="saveWage">添加工资条</el-menu-item>-->
          <el-menu-item index="/findWageState" @click="findWageState(editableTabsValue)"  v-show="show.待审批薪资 =='待审批薪资'">待审批薪资</el-menu-item>
          <el-menu-item index="/findWageByUserId" @click="findWageByUserId"  v-show="show.工资条 =='工资条'">工资条</el-menu-item>
      </el-submenu> 

 <el-submenu index="4" v-show="show.任务中心 =='任务中心'">
        <template slot="title">
          <i class="el-icon-menu"></i>
          <span>任务中心</span>
        </template>
          <el-menu-item index="/findTask" @click="findTask" v-show="show.查询任务 =='查询任务'">查询任务</el-menu-item>
          <el-menu-item index="/createTask" @click="createTask" v-show="show.分配任务 =='分配任务'">分配任务</el-menu-item>
          <el-menu-item index="/associateWith" @click="associateWith" v-show="show.任务交接 =='任务交接'">任务交接</el-menu-item>
          <el-menu-item index="/checkTask" @click="checkTask" v-show="show.任务审核 =='任务审核'">任务审核</el-menu-item>
          <el-menu-item index="/findTaskByUserId" @click="findTaskByUserId" v-show="show.个人任务 =='个人任务'">个人任务</el-menu-item>
          <el-menu-item index="/createPlan" @click="createPlan" v-show="show.制定计划 =='制定计划'">制定计划</el-menu-item>
      </el-submenu> 
      
           <el-submenu index="6" v-show="show.公告通知 =='公告通知'">
        <template slot="title">
          <i class="el-icon-menu"></i>
          <span>公告通知</span>
        </template>
          <el-menu-item index="/saveAffiche" @click="saveAffiche" v-show="show.公告拟稿 =='公告拟稿'">公告拟稿</el-menu-item>
          <el-menu-item index="/findAffiches" @click="findAffiches" v-show="show.查看公告 =='查看公告'">查看公告</el-menu-item>
      </el-submenu> 

      <el-submenu index="7" v-show="show.管理员操作 =='管理员操作'">
        <template slot="title">
          <i class="el-icon-setting"></i>
          <span>管理员操作</span>
        </template>
          <el-menu-item index="/showUser" @click="showUser" v-show="show.查看员工 =='查看员工'">查看员工</el-menu-item>
          <!--<el-menu-item index="/createUser" @click="createUser">添加员工</el-menu-item>-->
      </el-submenu> 

      <el-submenu index="8" v-show="show.人事操作 =='人事操作'">
        <template slot="title">
          <i class="el-icon-menu"></i>
          <span>人事操作</span>
        </template>
        <el-menu-item index="/saveUser" @click="saveUser" v-show="show.添加员工 =='添加员工'">添加员工</el-menu-item>
          <el-menu-item index="/createUser" @click="addDimission" v-show="show.离职申请 =='离职申请'">离职申请</el-menu-item>
          <el-menu-item index="/createUser" @click="showDimission" v-show="show.离职审批 =='离职审批'">离职审批</el-menu-item>
          <el-menu-item index="/createUser" @click="PersonnelAdjustment" v-show="show.人事调整 =='人事调整'">人事调整</el-menu-item>
      </el-submenu> 

    </el-menu>
     </el-aside>
 
    <!--<el-main>
      <el-tabs v-model="editableTabsValue" type="card" closable @tab-remove="removeTab">
        <el-tab-pane v-for="item in editableTabs" :key="item.name" :label="item.title" :name="item.name">
          <component :is="item.path"></component>
        </el-tab-pane>
      </el-tabs>
     <div class="test test-5">
      <div class="scrollbar"></div>
    </div>
    </el-main>-->
    <el-main>
     <component :is="$store.getters.getElmain"></component>
      <!-- <h1 style="font-size:75px;color:red;">欢迎登录</h1> -->
    </el-main>
  </el-container>
  <el-footer>
          <a target="_blank" href="https://element.eleme.cn/#/zh-CN">Element-UI</a>
      </el-footer>
</el-container>

</template>

<script>
import associateWith from '@/components/taskModule/associateWith'

import selectAttendance from '@/components/attendanceModule/selectAttendance'
import saveOvertim from '@/components/attendanceModule/saveOvertim'
import findOvertimByUpno from '@/components/attendanceModule/findOvertimByUpno'
import welcome from '@/components/welcome'
import createTask from '@/components/taskModule/createTask'
import creakAttendance from '@/components/attendanceModule/creakAttendance'
import findTask from '@/components/taskModule/findTask'
import findWage from '@/components/wageModule/findWage'
import issueWage from '@/components/wageModule/issueWage'
import findWageState from '@/components/wageModule/findWageState'
import findWageByUserId from '@/components/wageModule/findWageByUserId'
import saveWage from '@/components/wageModule/saveWage'
import createUser from '@/components/adminModule/createUser'
import showUser from '@/components/adminModule/showUser'
import PersonnelAdjustment from '@/components/adminModule/PersonnelAdjustment'
import showDimission from '@/components/adminModule/showDimission'
import addDimission from '@/components/adminModule/addDimission'
import isMe from '@/components/adminModule/isMe'
import findAffiches from '@/components/affiche/findAffiches'
import selectOvertim from '@/components/overtimModule/selectOvertim'
import selectLeave from '@/components/leaveModule/selectLeave'
import selectEvection from '@/components/evectionModule/selectEvection'
import saveAffiche from '@/components/affiche/saveAffiche'
import findTaskByUserId from '@/components/taskModule/findTaskByUserId'
import createPlan from '@/components/taskModule/createPlan'
import checkTask from '@/components/taskModule/checkTask'
import saveUser from '@/components/adminModule/saveUser'
import createLeave from '@/components/leaveModule/createLeave'
import updateLeave from '@/components/leaveModule/updateLeave'
import updateLeave2 from '@/components/leaveModule/updateLeave2'
import createEvection from '@/components/EvectionModule/createEvection'
import updateEvection from '@/components/evectionModule/updateEvection'
import selectEvectionaccount from '@/components/evectionAccountModule/selectEvectionaccount'
import {mapActions,mapMutations} from 'vuex';
export default {
    name: "",
    data() {
        return {
          show:{},
        editableTabsValue: '1',
        editableTabs: [{
          path:'welcome',
          title:'',
          name:'1',
        }],
        tabIndex: 1,
          imgUrl: '',
        }
    },

    components: {
      welcome,
      createTask,
      findTask,
      findWage
      ,issueWage
      ,findWageState
      ,findWageByUserId
      ,saveWage
      ,createUser
      ,selectAttendance,
      findAffiches,
      saveAffiche,
      findTaskByUserId,
      associateWith,
      createPlan,
      checkTask,
      addDimission,
      showDimission,
      saveOvertim,
      findOvertimByUpno,
      showUser,
      PersonnelAdjustment,
      creakAttendance,
      selectOvertim,
      selectEvection,
      selectLeave,
      createLeave,
      updateLeave,
      updateLeave2,
      createEvection,
      updateEvection,
      selectEvectionaccount,
      isMe,
      saveUser,
    // methods: { 
    //   removeTab(targetName) {
    //     let tabs = this.editableTabs;
    //     let activeName = this.editableTabsValue;
    //     if (activeName === targetName) {
    //       tabs.forEach((tab, index) => {
    //         if (tab.name === targetName) {
    //           let nextTab = tabs[index + 1] || tabs[index - 1];
    //           if (nextTab) {
    //             activeName = nextTab.name;
    //           }
    //         }
    //       });
    //     }
        
    //     this.editableTabsValue = activeName;
    //     this.editableTabs = tabs.filter(tab => tab.name !== targetName);
    //   },
    //    issueWage(targetName){
    //     let newTabName = ++this.tabIndex + '';
    //     console.log(newTabName);
    //     this.editableTabs.push({
    //       title: '发放工资',
    //       name: newTabName,
    //       path:issueWage
    //     });
    //     this.editableTabsValue = newTabName;
    //       console.log(this.editableTabsValue);
    //   },
    //    findWage(targetName){
    //     console.log("添加标签页");
    //     let newTabName = ++this.tabIndex + '';
    //     console.log(newTabName);
    //     this.editableTabs.push({
    //       title: '查询记录',
    //       name: newTabName,
    //       path:findWage
    //     });
    //     this.editableTabsValue = newTabName;
    //       console.log(this.editableTabsValue);
    //   },
    //    findWageState(targetName){
    //     console.log("添加标签页");
    //     let newTabName = ++this.tabIndex + '';
    //     this.editableTabs.push({
    //       title: '待审批薪资',
    //       name: newTabName,
    //       path:findWageState
    //     });
    //     this.editableTabsValue = newTabName;
    //   },
    //    findWageByUserId(targetName){
    //     console.log("添加标签页");
    //     let newTabName = ++this.tabIndex + '';
    //     this.editableTabs.push({
    //       title: '待审批薪资',
    //       name: newTabName,
    //       content: this.$store.dispatch("findWageByUserId"),
    //       path:findWageByUserId
    //     });
    //     this.editableTabsValue = newTabName;
    //    },
    },
computed: {
  host(){
            return this.$axios.defaults.baseURL;
        }
},
mounted(){
  this.showa();
      },
   
 methods: { 
   showa(){
     this.imgUrl=this.host+this.$store.state.login.users.title;
     this.show=this.$store.state.show;
      console.log(this.imgUrl);
   },
      PersonnelAdjustment(){
this.$store.dispatch("PersonnelAdjustment");
      },
      showUser(){
        this.$store.dispatch("showUser");
      },
      //文件上传后的回调函数
        handleSuccess(response, file, fileList){
            //response 上传之后的返回值
            file.url=this.host+response; 
            //第二个例子
            this.imgUrl=this.host+response;
            
            let user={};
            user.title=response;
            console.log(user);
            let url="admin/saveUserFileUrl";
            this.$axios.post(url,user).then(resp=>{
              
            }).catch(ex=>{

            });
            this.$message({
          message: '修改成功！！！',
          type: 'success'
        });
        },
      isMe(){
        this.$store.dispatch("isMe");
      },
      showDimission(){
        this.$store.dispatch("showDimission");
      },
      addDimission(){
        this.$store.dispatch("addDimission");
      },
       findWageState(){
       this.$store.dispatch("findWageState");
      },
       saveAffiche(){
       this.$store.dispatch("saveAffiche");
      },
       findAffiches(){
       this.$store.dispatch("findAffiches");
      },
       createTask(){
       this.$store.dispatch("createTask");
      },
      creakAttendance(){
       this.$store.dispatch("creakAttendance");
      },
      findPlans(){
        this.$store.dispatch("findPlans");
      },
      findTask(){
        this.$store.dispatch("findTask");
      },
      createUser(){
        //this.$store.state.elMain='createUser';
        this.$store.dispatch("createUser");
      },
      selectAttendance(){
       this.$store.dispatch("selectAttendance");
      },
       selectLeave(){
       this.$store.dispatch("selectLeave");
      },
       createLeave(){
       this.$store.dispatch("createLeave");
      },
       updateLeave(){
       this.$store.dispatch("updateLeave");
      },
       updateLeave2(){
       this.$store.dispatch("updateLeave2");
      },
       selectOvertim(){
       this.$store.dispatch("updateLeave");
      },
      
       selectEvection(){
       this.$store.dispatch("selectEvection");
      },
       createEvection(){
       this.$store.dispatch("createEvection");
      },
      updateEvection(){
       this.$store.dispatch("updateEvection");
      },
 selectEvectionaccount(){
       this.$store.dispatch("selectEvectionaccount");
      },
      handleOpen(key, keyPath) {
        console.log(key, keyPath);
      },
      handleClose(key, keyPath) {
        console.log(key, keyPath);
      },
      findTaskByUserId(){
       this.$store.dispatch("findTaskByUserId");
      },
      associateWith(){
       this.$store.dispatch("associateWith");
      },
      createPlan(){
       this.$store.dispatch("createPlan");
      },
      checkTask(){
       this.$store.dispatch("checkTask");
      },
       saveOvertim(){
       this.$store.dispatch("saveOvertim");
      },
       findOvertimByUpno(){
       this.$store.dispatch("findOvertimByUpno");
      },
      saveUser(){
       this.$store.dispatch("saveUser");
      },
       issueWage(){
       this.$store.dispatch("issueWage");
      },
       findWage(){
       this.$store.dispatch("findWage");
      },
       findWageState(){
       this.$store.dispatch("findWageState");
      },
       findWageByUserId(){
       this.$store.dispatch("findWageByUserId");
       },
      logOut(){
        this.$confirm('您确定退出吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$store.dispatch("logOut",null);
          this.$message({
            type: 'success',
            message: '退出成功!'
          });
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '取消退出'
          });          
        });
      },
      }
}
</script>

<style  scoped>
.el-header {
    background-color: #303133;
    color: #333;
    text-align: center;
    line-height: 50px;
  }
  .el-footer {
    background-color:  #303133;
    color: #333;
    text-align: center;
    height: 20px;
  }
  .el-menu-item{
    color: slateblue;
    text-align: center;
  }
  
  .el-aside {
    background-color:#D3D3D3;
    color: #333;
    min-height: 720px;
  }
  
  .el-main {
    background-color: white;
    color: #333;
    text-align: center;
  }
  body > .el-container {
    
    margin-bottom: 40px;
  }
  
</style>
