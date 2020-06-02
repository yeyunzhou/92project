<template>
  <div>
    <el-container>
      <el-header>
        <el-row>
          <el-col :span="5" :offset="10" >
                <h1>万家园物业管系统</h1>
            </el-col>
             <el-col :span="3" :offset="5"  >
            <el-button   type="danger" round  @click="logout" >注销</el-button>
            </el-col>
        </el-row>
      
         
      </el-header>
      <el-container>
        <el-aside width="200px">
          <el-row class="tac">
            <el-col :span="12">
              <el-menu
                class="el-menu-vertical-demo"
                background-color="#D3DCE6"
                active-text-color="#ffd04b"
                router
              >  
                    <el-menu-item index="/family">业主信息</el-menu-item> 
                     <el-menu-item index="/house">房屋信息</el-menu-item> 
                    <el-menu-item index="/staff">员工信息</el-menu-item>
                    <el-menu-item index="/cost">缴费信息</el-menu-item>
                    <el-menu-item index="/facility">设备管理</el-menu-item>
                    <el-menu-item index="/feedback">投诉处理</el-menu-item>
                    <el-menu-item index="/maintain">维修处理</el-menu-item>
                    <el-menu-item index="/exit">出入管理</el-menu-item> 
              </el-menu>
            </el-col>
          </el-row>
        </el-aside>
        <el-main>
          <router-view></router-view>
        </el-main>
      </el-container>
      <el-footer style="text-align: right;">
        <div style="margin-top: 15px;">
          {{$store.getters.getUsername}}管理员,欢迎你
          <br />
        </div>
      </el-footer>
    </el-container>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return { 
    };
  }, 

     methods: {
       logout(){
        
      this.$confirm("确认退出?", "提示", {})
        .then(() => {
          sessionStorage.removeItem("user");
          this.$store.dispatch("logout");
          this.$router.push("/");
        })
        .catch(() => {});

       }
     }
};
</script>

<style  scoped>
</style>
