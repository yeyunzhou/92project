<template>
    <div>
        <el-row class="row-bg">
            <el-col :span="21" align="left" style="margin-left:20px;" >
                <div class="grid-content">
                    <span style="font-size:30px;color:black;line-height:63px;">Emperor皇帝诏曰</span>
                </div>
            </el-col>
            <el-col :span="1" align="right" >
              <div class="grid-content">
                <el-tooltip class="item" effect="dark" content="点我试试" placement="bottom">
                  <el-button @click="drawer = true" type="primary" icon="el-icon-mouse" circle style="margin-top:12px;"></el-button>
                </el-tooltip>
                <el-drawer title="我是标题" :visible.sync="drawer" :with-header="false" text-align:center>
                  <div style="margin-top:60px">关注我们</div>
                    <img src="@/assets/二维码2.jpg" style="width: 80%; height: 300px" >
                    <div><a style="font-size:20px;color:red">使命</a><br/>
                      向上向善，利益人心<br/>
                      <a style="font-size:20px;color:red">愿景</a><br/>
                      成为有温度、可信赖的中国科技企业<br/>
                      <a style="font-size:20px;color:red">价值观</a><br/>
                      客户第一，拥抱变化，诚信正直<br/>
                      团结合作，积极敬业，追求卓越
                    </div>
                </el-drawer>
              </div>
            </el-col>
        </el-row>
        <el-container>
            <el-main>
              <el-carousel indicator-position="outside">
                <el-carousel-item  >
                  <router-link to="/two" ><img src="@/assets/1.jpg" style="width: 100%; height: 300px" ></router-link>
                </el-carousel-item>
                <el-carousel-item  >
                  <router-link to="/two" ><img src="@/assets/2.jpg" style="width: 100%; height: 300px"  ></router-link>
                </el-carousel-item>
              </el-carousel>
              <div style="height:50px;"></div>
              <div class="demo-image__placeholder">
                <el-row class="row-bg">
                  <el-col :span="6" align="center" >
                    <router-link to="/education_1" ><img src="@/assets/1-1.jpg" style="width: 300px; height: 270px"></router-link>
                  </el-col>
                  <el-col :span="6" align="center" >
                    <router-link to="/education_2" ><img src="@/assets/2-1.jpg" style="width: 300px; height: 270px"></router-link>
                  </el-col>
                  <el-col :span="6" align="center" >
                    <router-link to="/education_3" ><img src="@/assets/3-1.jpg" style="width: 300px; height: 270px"></router-link>
                  </el-col>
                  <el-col :span="6" align="center" >
                    <router-link to="/education_4" ><img src="@/assets/4-1.jpg" style="width: 300px; height: 270px"></router-link>
                  </el-col>
                </el-row>
              </div>

              <el-row>
                <el-col :span="24" align="center" >
                  <h2 style="color:blue;font-size:40px;">公司环境</h2>
                </el-col>
              </el-row>

              <el-row>
                <el-col :span="24">
                  <el-carousel :interval="4000" type="card" height="300px">
                    <el-carousel-item  >
                      <img src="@/assets/3-1 (1).jpg" style="width: 100%; height: 300px"  >
                    </el-carousel-item>
                    <el-carousel-item  >
                      <img src="@/assets/3-1 (2).jpg" style="width: 100%; height: 300px"  >
                    </el-carousel-item>
                    <el-carousel-item  >
                      <img src="@/assets/3-1 (4).jpg" style="width: 100%; height: 300px"  >
                    </el-carousel-item>
                    <el-carousel-item  >
                      <img src="@/assets/3-1 (5).jpg" style="width: 100%; height: 300px"  >
                    </el-carousel-item>
                  </el-carousel>
                </el-col>
              </el-row>
            </el-main>
        <el-backtop></el-backtop>
        </el-container>
    </div>
</template>

<script>
export default {    
    data() {
      return {
        user:{},
        drawer: false,
        url: 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg'
      };
    },
    methods:{
        handleClose(done) {
        this.$confirm('还有未保存的工作哦确定关闭吗？')
          .then(_ => {
            done();
          })
          .catch(_ => {});
      }    
    }
}
</script>

<style scoped>

  .grid-content1 {
    font-size: 27px;
    border-radius: 4px;
    min-height: 15px;
    color: brown;
  }
  .grid-content {
    font-size: 17px;
    border-radius: 4px;
    min-height: 15px;
    color: brown;
  }
.el-carousel__item h2 {
    color: #475669;
    font-size: 14px;
    opacity: 0.75;
    line-height: 300px;
    margin: 0;
  }
.el-carousel__item h3 {
    color: #475669;
    font-size: 18px;
    opacity: 0.75;
    line-height: 300px;
    margin: 0;
  }
  .el-carousel__item {
    height: 300px;
  }
  ul{
    height: 70px;
  }
  .el-carousel__indicators{
    margin-top: 100px;
  }
  .el-carousel__item:nth-child(2n) {
    background-color: #99a9bf;
  }
  
  .el-carousel__item:nth-child(2n+1) {
    background-color: #d3dce6;
  }
.el-header{
    background-color: rgb(222, 235, 252);
    color: #333;
    text-align: center;
    line-height: 60px;
  }
 .el-footer {
    text-align: center;
    line-height: 60px;
 }
.el-row {
    margin-bottom: 10px;
    &:last-child {
      margin-bottom: 0;
    }
  }
  .el-col {
    border-radius: 4px;
  }
  .bg-purple-dark {
    background: #99a9bf;
  }
  .bg-purple {
    background: #d3dce6;
  }
  .bg-purple-light {
    background: #e5e9f2;
  }
  .grid-content {
    border-radius: 4px;
    min-height: 36px;
  }
  .row-bg {
    padding: 10px 0;
    background-color: #f0f3f3;
  }

</style>