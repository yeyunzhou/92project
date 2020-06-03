<template>
        <el-container>
            <el-main :style="note">
                <div id="div">
            <h1 style="color:white;font-size:40px;">后 台 系 统</h1>
               <i class="el-icon-s-custom" style="font-size:30px;"></i>：<el-input v-model="username" placeholder="请输入账号" clearable style="width:250px;"></el-input>
                <br/>
                <i class="el-icon-lock" style="font-size:30px;"></i>：<el-input v-model="password" clearable placeholder="请输入密码" show-password style="width:250px;"></el-input>
                <br/>
                <el-button type="primary" @click="login1" @keyup.enter="login1" plain style="width:100px;">登录</el-button>
                <el-button type="info" @click="resetForm" plain style="width:100px;">重置</el-button>
                </div>
            </el-main>
        </el-container>
</template>

<script>
import {mapMutations,mapActions} from 'vuex';
export default {
    name: "",
    data() {
        return {
            username:"",password:"",
            returnMessage:this.$store.state.returnMessage,
            note:{
            backgroundImage: "url("+require('@/assets/login.jpg')+')',
            backgroundRepeat:'no-repeat',
    backgroundSize:'100% 100%'
            },
            }
    },
    components: {},
    created(){
       this.keyupEnter();
 },
    methods: {
        resetForm() {
        this.username="";
        this.password="";
      },
      
      
      keyupEnter(){
                document.onkeydown = e =>{
                    let body = document.getElementsByTagName('body')[0]
                    if (e.keyCode === 13 && e.target.baseURI.match(/inputbook/) && e.target === body) {
                        console.log('enter');
                        this.login1();
                    }
                }
    },
    

    
    login1(){
       this.$store.dispatch("login",{username:this.username,password:this.password});
      },
},
watch:{
    'returnMessage':function(){
        console.log("监听");
         this.$message.error(this.$store.state.returnMessage);
    }
}
}
</script>

<style  scoped>

  

  .el-main {
    color: gray;
    text-align: center;
    line-height: 50px;
    position: absolute;
    width: 100%;
    height: 100%;
  }
 #div{
    background: rgba(187,255,255,0.2);
    height:300px;
    width:400px;
    border-radius: 50px;
    border: solid #525150 1px;
    position: absolute;
    top: 20%;
    left: 35%;
 }
 

</style>
