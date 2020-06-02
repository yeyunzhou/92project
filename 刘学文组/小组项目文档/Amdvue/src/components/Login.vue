<template>
  <div>
    <el-container>
      <el-header>
        <h1 style="color: white;">欢迎万家园物业系统</h1>
      </el-header>
      <el-main>
        <div style="margin-top: 120px;">
          <h2>
            <i class="el-icon-user-solid"></i>
            <el-input style="width:300px" v-model="users.userName" placeholder="请输入用户名"></el-input>
          </h2>
        </div>
        <div>
          <h2>
            <i class="el-icon-circle-check"></i>
            <el-input v-model="users.pwd" style="width:300px" type="password" placeholder="请输入密码"></el-input>
          </h2>
        </div>
        <el-button type="success" @click.prevent="login">登录</el-button>
        <el-button type="danger" @click.prevent="res">重置</el-button>
      </el-main>
    </el-container>
    <el-footer></el-footer>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "",
  data() {
    return {
      msg: null,
      users: {
        userName: null,
        pwd: null
      }
    };
  },
  components: {},
  methods: {
    login() {
      let url =
        "Login/logins?userName=" +
        this.users.userName +
        "&pwd=" +
        this.users.pwd;
      axios.post(url).then(response => {
          if (response.data!="") {

            this.$store.dispatch("login",response.data);
            this.msg = "登录成功";
            this.$router.push("/index");
          } else {
           this.$message.error("用户名或密码错误");
          }
        })
        .catch(ex => {
          console.log(ex);
        });
    },
    res() {

      users={};
     
    }
  }
};
</script>

<style  scoped>
 
</style>
