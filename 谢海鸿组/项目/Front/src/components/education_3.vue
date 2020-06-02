<template>
    <div>
        <el-main>
            <router-link to="/cooperation" >
                <img src="@/assets/education-3-1.jpg" style="width: 100%; height: 300p" ><br/>
            </router-link>
            <h1><a style="color:blue">核心优势</a></h1><br/>
            
            <div class="demo-image__placeholder">
            <el-row>
                <el-col :span="8" align="center" >
                <img src="@/assets/education-3-2.png" style="width: 100%; height: 100%">
                </el-col>
                <el-col :span="8" align="center" >
                <img src="@/assets/education-3-2.jpg" style="width: 100%; height: 100%">
                </el-col>
                <el-col :span="8" align="center" >
                <img src="@/assets/education-3-3.jpg" style="width: 100%; height: 100%">
                </el-col>
            </el-row>
            </div>
        </el-main>
        <el-backtop></el-backtop>
               
    </div>
</template>

<script>
export default {
    
}
</script>

<style scoped>
.el-main,.el-header {
    color: #333;
    text-align: center;
  }
  div{
      margin: 0 auto;
      text-align: left;
  }

</style>