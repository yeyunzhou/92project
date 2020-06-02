<template>
  <div>
    <el-row>
      <el-col :span="12">
        <el-input placeholder="请输入搜索关键字" v-model="name" type="text"></el-input>
      </el-col>
      <el-col :span="2">
        <el-button type="primary" icon="el-icon-search" circle @click="findCome()"></el-button>
      </el-col>
      <el-col :span="10">
        <el-button  @click="accesstoInfoTag=true" size="small">人员出入登记</el-button>
        <el-button @click="caroutInfoTag =true"  size="small">车辆出入信息</el-button>
      </el-col>
    </el-row>
    <br />
    <el-table :data="pageInfo.list" border ref="multipleTable" style="width: 100%;">
      <el-table-column v-for="item in props" :key="item.id" :prop="item.prop" :label="item.lable"></el-table-column>
    </el-table>
    <el-pagination
      :page-sizes="[3, 5, 8, 10]"
      :page-size="5"
      @current-change="handleCurrentChange"
      @size-change="handleSizeChange"
      layout="total, sizes, prev, pager, next, jumper"
      :total="pageInfo.total"
    ></el-pagination>

    <!--车辆出入信息-->
    <el-dialog title="车辆出入信息" :visible.sync="caroutInfoTag" width="900px"> 
        <el-table :data="pageInfo2.list" border ref="multipleTable" style="width: 100%;">
        <el-table-column v-for="item in carouts" :key="item.cid" :prop="item.prop" :label="item.lable"></el-table-column>
        </el-table>
        <el-pagination
        :page-sizes="[3, 5, 8, 10]"
        :page-size="5"
        @current-change="handleCurrentChange2"
        @size-change="handleSizeChange2"
        layout="total, sizes, prev, pager, next, jumper"
        :total="pageInfo2.total"
        ></el-pagination>
        <br />
        <div style="text-align: right;">
          <el-button @click="caroutAddTag = true">登记车辆信息</el-button>
          <el-button @click="caroutInfoTag = false">取 消</el-button>
        </div>
        </el-dialog>

    <!--人员出入信息登记-->
    <el-dialog title="人员出入信息登记" :visible.sync="accesstoInfoTag"> 
         <el-row>
            <el-col :span="5">姓名</el-col>
            <el-col :span="16"><el-input v-model="accessto.aname"></el-input></el-col>
          </el-row>
          <br /> 
          <el-row>  
            <el-col :span="5">身份证</el-col>
            <el-col :span="16"><el-input v-model="accessto.colidentityCard"></el-input></el-col>
          </el-row>
          <br /> 
          <el-row>  
            <el-col :span="5">事务</el-col>
            <el-col :span="16"><el-input v-model="accessto.affair"></el-input></el-col>
          </el-row>
          <br /> 
          <el-row>  
            <el-col :span="5">电话号码</el-col>
            <el-col :span="16"><el-input v-model="accessto.phone"></el-input></el-col>
          </el-row>
          <br />  
          <el-row>  
            <el-col :span="5">进入时间</el-col>
            <el-col :span="16"><el-input v-model="accessto.entryTime" type="date"></el-input></el-col>
          </el-row>
          <br /> 
          <el-row>  
            <el-col :span="5">离开时间</el-col>
            <el-col :span="16"><el-input v-model="accessto.departureTime" type="date"></el-input></el-col>
          </el-row>
          <br />  
        <div style="text-align: right;">
          <el-button @click="SaveAccressto">保存</el-button>
          <el-button @click="accesstoInfoTag = false">取 消</el-button>
        </div>
    </el-dialog>


    <!--车辆出入信息登记-->
    <el-dialog title="车辆出入信息登记" :visible.sync="caroutAddTag"> 
         <el-row>
            <el-col :span="5">车牌</el-col>
            <el-col :span="16"><el-input v-model="carout.plateNumber"></el-input></el-col>
          </el-row>
          <br />  
           <el-row>
            <el-col :span="5">姓名</el-col>
            <el-col :span="16"><el-input v-model="carout.cname"></el-input></el-col>
          </el-row>
          <br /> 
          <el-row>
            <el-col :span="5">电话</el-col>
            <el-col :span="16"><el-input v-model="carout.phone"></el-input></el-col>
          </el-row>
          <br /> 
          <el-row>
            <el-col :span="5">事件</el-col>
            <el-col :span="16"><el-input v-model="carout.affair"></el-input></el-col>
          </el-row>
          <br />  
          <el-row>  
            <el-col :span="5">进入时间</el-col>
            <el-col :span="16"><el-input v-model="carout.enterTime" type="date"></el-input></el-col>
          </el-row>
          <br /> 
          <el-row>  
            <el-col :span="5">离开时间</el-col>
            <el-col :span="16"><el-input v-model="carout.departureTime" type="date"></el-input></el-col>
          </el-row>
          <br />  
        <div style="text-align: right;">
          <el-button @click="SaveCarout">保存</el-button>
          <el-button @click="caroutAddTag = false">取 消</el-button>
        </div>
    </el-dialog>
        
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return { 
      name: "",
      page:1,
      pageInfo: {},
      pageInfo2: {}, 
      row: {},
      //车辆信息
      caroutInfoTag:false,
      caroutAddTag:false, 
      carout:{},
      //人员登记
      accesstoInfoTag:false,
      accessto:{},
      props: [
        { prop: "aid", lable: "编号" },
        { prop: "aname", lable: "姓名" },
        { prop: "colidentityCard", lable: "身份证号" },
        { prop: "affair", lable: "事件" },
        { prop: "phone", lable: "电话号码" },
        { prop: "entryTimeString", lable: "进入时间"},
        { prop: "departureTimeString", lable: "离开时间" }
      ],
    carouts: [
        { prop: "cid", lable: "编号",width:"30"},
        { prop: "plateNumber", lable: "车牌号" },
        { prop: "cname", lable: "姓名" },
        { prop: "phone", lable: "电话号码" },
        { prop: "affair", lable: "事件" },
        { prop: "enterTimeString", lable: "进入时间"},
        { prop: "departureTimeString", lable: "离开时间" }
    ]
    };
  },
  components: {},
  computed: {
    host() {
      return this.$axios.defaults.baseURL;
    }
  },
  methods: {
      //车辆出入信息登记
      SaveCarout(){
          let url="http://localhost:9090/InAndOut/saveCarout";
            this.$axios.post(url,this.carout).then(resp=>{ 
                this.$message.success(resp.data.message);
                this.caroutAddTag=false; 
                this.findCar();
                this.carout={};
            }).catch(ex=>{});
      },
    //人员出入信息登记
      SaveAccressto(){
          let url="http://localhost:9090/InAndOut/saveAccessto";
            this.$axios.post(url,this.accessto).then(resp=>{ 
                this.$message.success(resp.data.message);
                this.accesstoInfoTag=false;
                this.findCome(this.pageInfo.pageNum,this.pageInfo.pageSize);
                this.accessto={};
            }).catch(ex=>{});
      },
    //人员出入信息
    findCome(page = 1, pageSize = 5) {
        console.log(this.name);
      let url = "http://localhost:9090/InAndOut/findPagestoAcc?page=" +page + "&pageSize=" + pageSize +"&aname="+this.name;
       axios.post(url).then(resp => {
         this.pageInfo = resp.data;
          console.log( this.pageInfo);
        }).catch(ex => {
          console.log(ex);
        });
    },
    //分页
    handleCurrentChange(page) {
      this.findCome(page, this.pageInfo.pageSize);
    },
    handleSizeChange(pageSize) {
      this.findCome(this.pageInfo.pageNum, pageSize);
    },
    //人员出入信息
    findCar(page = 1, pageSize = 5) { 
      let url = "http://localhost:9090/InAndOut/findPagestoCar?page=" +page + "&pageSize=" + pageSize;
       axios.post(url).then(resp => {
         this.pageInfo2 = resp.data;
          console.log( this.carout);
        }).catch(ex => {
          console.log(ex);
        });
    },
    //分页
    handleCurrentChange2(page) {
      this.findCar(page, this.pageInfo2.pageSize);
    },
    handleSizeChange2(pageSize) {
      this.findCar(this.pageInfo2.pageNum, pageSize);
    }, 
  },

  
  mounted() {
    this.findCome();
    this.findCar();
  }
};
</script>

<style  scoped>
</style>
