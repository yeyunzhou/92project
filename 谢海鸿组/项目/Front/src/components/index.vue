<template>
    <div>
      <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" >
      <el-menu-item index="1"><router-link to="/one" tag="span">Emperor皇帝诏曰</router-link></el-menu-item>
      <el-menu-item index="3"><router-link to="/about" tag="span"><i class="el-icon-info"></i>关于皇帝诏曰</router-link></el-menu-item>
      <el-menu-item index="4"><router-link to="/" replace><i class="el-icon-news"></i>新闻动态</router-link></el-menu-item>
      </el-menu>
			 <router-view></router-view>
     </div>    
</template>

<script>
import one from '@/components/one.vue'
import two from '@/components/two.vue'
import two_1 from '@/components/two_1.vue'
import about from '@/components/about.vue'
import cooperation from '@/components/cooperation.vue'
export default {
    data() {
      return {
        activeIndex: '1',
        drawer: false,
        url: 'https://cube.elemecdn.com/6/94/4d3ea53c084bad6931a56d5158a48jpeg.jpeg'
      };
    },
    components: {
      one,
      two,
      two_1,
      about,
      cooperation,
    },
    methods:{
       one(){
       this.$store.dispatch("one");
      },
       two(){
       this.$store.dispatch("two");
      },
       two_1(){
       this.$store.dispatch("two_1");
      },
       about(){
       this.$store.dispatch("about");
      },
       cooperation(){
       this.$store.dispatch("cooperation");
      },
       
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