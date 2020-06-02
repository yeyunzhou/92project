<template>
  <div class="app">
    <el-container>
      <el-aside
        class="app-side app-side-left"
        :class="isCollapse ? 'app-side-collapsed' : 'app-side-expanded'"
      >
        <div>
          <img src="@/assets/1.png" height="60" width="230px" />
        </div>
        <div style="text-align: center;">
         <img src="@/assets/3.jpg" height="600px"  width="210px"/>
         
        </div>
      </el-aside>

      <el-container>
        <el-header class="app-header">
          <!--菜单-->
          <el-menu
            :default-active="this.$router.path"
            class="el-menu-demo"
            mode="horizontal"
            router
          >
            <el-menu-item index="/family">家庭成员信息</el-menu-item>
            <el-menu-item index="/car">车辆信息</el-menu-item>
            <el-menu-item index="/cost">缴费信息</el-menu-item>
            <el-menu-item index="/feedback">投诉</el-menu-item>
            <el-menu-item index="/maintain">维修</el-menu-item> 
          </el-menu>

          <div class="app-header-userinfo">
            <el-button @click="drawer = true" type="primary" style="margin-left: 16px;">个人中心</el-button>
            <el-drawer title="我是标题" :visible.sync="drawer" :with-header="false">
              <div style="text-align: center;">
                <el-avatar
                  :size="70"
                  :src="user.img"
                ></el-avatar>
                <!--  <image class="diqu_img" src="user.proprietor.sex == 1? '/images/icon/nan.png': '/images/icon/nv.png'">
                </image>可以将男设置为1，女设置为0-->
               
               <img v-if="user.proprietor.sex==1" src="@/assets/female.png" height="20px" width="20px" />
                <img v-else src="@/assets/male.png" height="20px" width="20px" />
                <el-row>
                  <el-col :span="12">
                    <h3>用户名</h3>
                  </el-col>
                  <el-col :span="12">
                    <h3> {{$store.getters.getUserName}}</h3>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="12">
                    <h3>身份证</h3>
                  </el-col>
                  <el-col :span="12">
                    <h3>{{$store.getters.getidentityCard}}</h3>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="12">
                    <h3>电话号码</h3>
                  </el-col>
                  <el-col :span="12">
                    <h3>{{$store.getters.getPhone}}</h3>
                  </el-col>
                </el-row>
                <el-row>
                  <el-col :span="12">
                    <el-button type="info" round   @click="update">修改信息</el-button>
                  </el-col>
                  <el-col :span="12">
                    <el-button type="primary" round @click="logout">退出登录</el-button>
                  </el-col>
                </el-row>
              </div>
            </el-drawer>
          </div>
        </el-header>

        <el-main class="app-body" >
          <template>
            <router-view />
          </template>
        </el-main>
      </el-container>
    </el-container>
<el-dialog
  title="修改个人信息"
  :visible.sync="dialogVisible"
  width="50%"
 >
  <el-row>
  <el-col :span="4">头像：</el-col>
  <el-col :span="8">
   <el-upload
  class="avatar-uploader"
  action="http://localhost:9090/Login/upload"
  :show-file-list="false"
  :on-success="handleAvatarSuccess"
  name="img"
  >
  <img v-if="imageUrl" :src="imageUrl" class="avatar">
  <i v-else class="el-icon-plus avatar-uploader-icon"></i>
</el-upload>
  </el-col>
</el-row>
<el-row>
  <el-col :span="4">用户民：</el-col>
  <el-col :span="8">
    <el-input placeholder="请输入用户名" v-model="user.uname"></el-input>
  </el-col>
</el-row>
<el-row>
  <el-col :span="4">密码：</el-col>
  <el-col :span="8">
    <el-input   placeholder="请输入密码" show-password  v-model="user.pwd"></el-input>
  </el-col>
</el-row>
<el-row>
  <el-col :span="4">手机号码：</el-col>
  <el-col :span="8">
    <el-input   placeholder="请输入密码"   v-model="user.proprietor.phone"></el-input>
  </el-col>
</el-row>

  <span slot="footer" class="dialog-footer">
    <el-button type="primary" @click="save()">确 定</el-button>
     
  </span>
</el-dialog>



<el-dialog
  title="提示信息"
  :visible.sync="dialogVisible2"
  width="50%"
  center
 >
 <el-row>
 尊敬的用户你好：
 </el-row>
 <el-row>
  <el-col push="5" :span="18">
    <div >
   {{msg}}
    </div>
  </el-col>

</el-row>
   
      <span slot="footer" class="dialog-footer">
  
    <el-button type="primary" @click="dialogVisible2 = false">确 定</el-button>
  </span>

</el-dialog>



  </div>
</template>

<script>
export default {
  name: "Container",
  data() {
    return {
      imageUrl:'',
      dialogVisible:false,
       dialogVisible2:false,
      drawer: false,
      drawer2: true,
      backgroundImg: {
        backgroundImage: "url(" + require("@/assets/1.jpg") + ")"
      },
      username: "",
      isCollapse: false,
      user:null,
      msg:'',
     
    };
  },
  methods: {
  
    
 handleAvatarSuccess(res, file) {
          console.log(file);
          console.log(res);
        this.imageUrl ="http://localhost:9090/img/"+res;
       
      },
    update(){
       this.imageUrl=this.user.img;
          this.dialogVisible=true;
    },
    toggleSideBar() {
      this.isCollapse = !this.isCollapse;
    },
    logout: function() {
      this.$confirm("确认退出?", "提示", {})
        .then(() => {
          sessionStorage.removeItem("user");
           this.$store.dispatch("logout");
          this.$router.push("/");
        })
        .catch(() => {});
    },
    handleOpen(key, keyPath) {
      console.log(key, keyPath);
    },
    handleClose(key, keyPath) {
      console.log(key, keyPath);
    },
    handleSelect(key, keyPath) {
      console.log(key, keyPath);
    },

     save(){
           let url="Users/save";
           console.log(this.user);
            this.user.img=this.imageUrl;
             this.$axios.post(url,this.user).then(resp=>{
                console.log(resp.date);
               
                 if(resp.data>0){
                    this.dialogVisible=false;
                       this.$message.success("修改成功");
                         this.$store.dispatch("login",user);
                 }
             }).catch(ex=>{});
      },

      find(){
        if(this.drawer2){
          let url="Login/inform";
             this.$axios.get(url).then(resp=>{
                 if(resp.data !=""){
                    console.log(resp.data);
                    this.msg+="您的车库"
                    resp.data.forEach(list=> {
                      this.msg+=list.garage.location;
                      this.msg+=",";
                    });
                     this.msg+="即将到期，或已到期为。不影响您的正常使用请及时续费。";
                     this.find2();
                    this.dialogVisible2=true;
                         this.drawer2=false;   
                 }
             }).catch(ex=>{});

        }  
      },


      find2(){
          let url="Login/inform2";
             this.$axios.get(url).then(resp=>{
                 if(resp.data !=""){
                    console.log(resp.data);
                    this.msg+="您的房屋"
                    resp.data.forEach(list=> {
                      this.msg+=list.houseString;
                      this.msg+=",";
                    });
                     this.msg+="物业费用已到期或快到期，请及时缴纳";
                    this.dialogVisible2=true;
                         this.drawer2=false;   
                 }
             }).catch(ex=>{});

           
      },

      
  },
  mounted(){
    this.user=this.$store.state.loginmodu.user;
    this.imageUrl=this.user.img;
     console.log(this.user);
     this.find();
  }
};
</script>

<style  scoped>


 .avatar-uploader .avatar-uploader-icon {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .avatar-uploader-icon:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }

  .img{
    width: 50px;
  }


.el-aside {
  height: 700px;
}
.inps input {
  font-size: 15px;
  width: 200px;
}
</style>