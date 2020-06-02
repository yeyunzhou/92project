<template>
 <div>
   <router-view/>
 </div>
</template>

<script>
export default {
  name: 'App', 
  created() {
      //在页面加载时读取sessionStorage里的状态信息
      if (sessionStorage.getItem("store")) {
        this.$store.replaceState(Object.assign({}, this.$store.state, JSON.parse(sessionStorage.getItem("store"))))
      }

      //在页面刷新时将vuex里的信息保存到sessionStorage里
      window.addEventListener("beforeunload", () => {
        sessionStorage.setItem("store", JSON.stringify(this.$store.state))
      })
    },
    methods: {
      logout(){
            this.$store.dispatch("logout");
            this.$router.push("/login");
        } ,
      
    },
    
    
}
</script>

<style>
  .el-header,.el-footer {
    background-color: #B3C0D1;
    color:black;
    text-align: center;  
    
  }
  .el-menu-vertical-demo:not(.el-menu--collapse) {
    width: 200px;
    min-height: 400px;
  } 
  
  .el-aside {
    background-color: #D3DCE6;
    color: #333;
    text-align: center;
    line-height: 100px;
  }
  
  .el-main {
    background-color: #E9EEF3;
    color: #333;
    text-align: center;
    height: 560px;
  }
  
  
  
</style>
