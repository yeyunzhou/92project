<template>
  <div>
    <el-row>
      <el-col :span="12">
        <el-input placeholder="请输入搜索关键字" v-model="name" type="text"></el-input>
      </el-col>
      <el-col :span="2">
        <el-button type="primary" icon="el-icon-search" circle @click="findHouses()"></el-button>
      </el-col>
      <el-col :span="10">
        <el-button @click="CarDetailTag=true" size="small" round>车库缴费信息</el-button>
        <el-button @click="carInfoTag()" size="small" round>车库缴费明细</el-button>
        <el-button @click="DetailTag =true" size="small" round>物业费用缴费明细</el-button>
      </el-col>
    </el-row>
    <br />
    <el-table :data="pageInfo.list" border ref="multipleTable" style="width: 100%;">
      <el-table-column v-for="item in props" :key="item.id" :prop="item.prop" :label="item.lable"></el-table-column>
      <!--操作列-->
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
            @click="detailInfo(scope.row)"
            type="text"
            size="small"
            v-if="scope.row.state=='已售出'"
          >缴费</el-button>
          <el-button type="text" size="small" v-else></el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      :page-sizes="[3, 5, 8, 10]"
      :page-size="5"
      @current-change="handleCurrentChange"
      @size-change="handleSizeChange"
      layout="total, sizes, prev, pager, next, jumper"
      :total="pageInfo.total"
    ></el-pagination>
    <!--缴费信息-->
    <el-dialog title="缴费信息" :visible.sync="detailInfoTag">
      <div>
        <el-row>
          <el-col :span="5">房屋编号</el-col>
          <el-col :span="16">
            <el-input name="houseNumber" v-model="row.houseNumber" readonly></el-input>
          </el-col>
        </el-row>
        <br />
        <el-row>
          <el-col :span="5">结束时间</el-col>
          <el-col :span="16">
            <el-input name="endTimeString" v-model="row.endTimeString" type="date"></el-input>
          </el-col>
        </el-row>
        <br />
        <el-row>
          <el-col :span="5">缴纳时间</el-col>
          <el-col :span="16">
            <el-select v-model="value"  placeholder="请选择" @change="currentSel">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </el-col>
        </el-row>
        <br />
        <el-row>
          <el-col :span="5">缴纳费用</el-col>
          <el-col :span="16">
            <el-input  v-model="row.count1"></el-input>
          </el-col>
        </el-row>
        <br />
      </div>
      <br />
      <div style="text-align: right;">
        <el-button @click="saveHouseInfo">保存</el-button>
        <el-button @click="detailInfoTag = false">取 消</el-button>
      </div>
    </el-dialog>

    <!--车库费用缴费信息-->
    <el-dialog title="车库费用缴费信息" :visible.sync="CaroutTag" width="1350px">
      <div>
        <el-table :data="pageAndCarInfo.list"  border ref="multipleTable" style="width: 100%;"> 
          <el-table-column v-for="item in CarInfoDetail" :key="item.gpid" :prop="item.prop" :label="item.lable"> 
          </el-table-column> 
        </el-table> 
        <br/>
         <el-pagination
            :page-sizes="[3, 5, 8, 10]"
            :page-size="5"
            @current-change="handleCurrentChange4"
            @size-change="handleSizeChange4"
            layout="total, sizes, prev, pager, next, jumper"
            :total="pageAndCarInfo.total"
          ></el-pagination>
      </div>
      <br />
      <div style="text-align: right;"> 
        <el-button @click="CaroutTag = false">取 消</el-button>
      </div>
    </el-dialog>

    <!--车库租用信息-->
    <el-dialog title="车库租用信息" :visible.sync="CarDetailTag" width="1450px">
      <div>
        <el-table :data="CarDetailsInfo.list" border ref="multipleTable" >
            <el-table-column v-for="item in CarDetail" :key="item.id" :prop="item.prop" :label="item.lable"> 
            </el-table-column>   
            <!--操作列-->
            <el-table-column label="操作">
              <template slot-scope="scope">
                <el-button v-if="scope.row.proprietor!=null" @click="SaveCarDetails(scope.row)" 
                type="text" size="small" >续费</el-button>  
             <!--   <el-button 
                v-if="scope.row.garageProprietortostring=='未过期'"
                type="text" size="small" style="color: red;" @click="constraint(scope.row)">强制过期</el-button>-->
              </template>
            </el-table-column>
          </el-table>
          <el-pagination
            :page-sizes="[3, 5, 8, 10]"
            :page-size="5"
            @current-change="handleCurrentChange3"
            @size-change="handleSizeChange3"
            layout="total, sizes, prev, pager, next, jumper"
            :total="CarDetailsInfo.total"
          ></el-pagination>
      </div>
      <br />
      <div style="text-align: right;"> 
        <el-button @click="CarDetailTag = false">关闭</el-button>
      </div>
    </el-dialog>

      <el-dialog title="车库费用续费" :visible.sync="CarDetailsTag">
         <el-row>
            <el-col :span="5">业主姓名:</el-col>
            <el-col :span="16"><el-input v-model="gpname"></el-input></el-col>
          </el-row> 
        <br /> 
        <!--<el-row>
            <el-col :span="5">车牌号码:</el-col>
            <el-col :span="16"><el-input v-model="licencePlate"></el-input></el-col>
          </el-row> 
        <br /> 
        -->
        <el-row>
            <el-col :span="5">到期时间:</el-col>
            <el-col :span="16"><el-input v-model="endTimeString" type="date"></el-input></el-col>
          </el-row> 
        <br /> 
        <el-row>
            <el-col :span="5">续租时间:</el-col>
            <el-col :span="16">
                <el-input-number v-model="num" @change="handleChange" :min="1" :max="12"> 
                </el-input-number>
                <span>月份</span>
            </el-col> 
          </el-row> 
        <br /> 
         <el-row>
            <el-col :span="5">租用金额:</el-col>
            <el-col :span="16"><el-input v-model="gprice"></el-input></el-col>
          </el-row> 
        <br /> 
      <div style="text-align: right;">  
        <el-button @click="saveCarInfo()">保存</el-button>
        <el-button @click="CarDetailsTag = false">关闭</el-button>
      </div>
      </el-dialog> 

    <el-dialog title="物业费用缴费信息" :visible.sync="DetailTag">
      <div>
        <el-table :data="detailsInfo.list" border ref="multipleTable" width="700px">
            <el-table-column v-for="item in details" :key="item.id" :prop="item.prop" :label="item.lable"> 
            </el-table-column>
          </el-table>
          <el-pagination
            :page-sizes="[3, 5, 8, 10]"
            :page-size="5"
            @current-change="handleCurrentChange2"
            @size-change="handleSizeChange2"
            layout="total, sizes, prev, pager, next, jumper"
            :total="detailsInfo.total"
          ></el-pagination>
      </div>
      <br />
      <div style="text-align: right;"> 
        <el-button @click="DetailTag = false">关闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      options: [
        {value: "1",label: "一个月"},
        {value: "2",label: "两个月"},
        {value: "3",label: "三个月"},
        {value: "6",label: "六个月"},
        {value: "12",label: "一年"}
      ],
      value: "",
      dialogVisible: false,
      selVal: "",
      name: "",
      page: 1,
      pageInfo: {},
      //房屋缴费信息
      detailInfoTag: false,
      //车库缴费信息
      CaroutTag: false,
      CarDetailsInfo:{}, 
      CarDetailsTag:false,
      licencePlate:"",
      endTimeString:"",
      gprice:"",
      num: "",
      gpid:"",
      gpname:"",
      //车库费用缴费情况
      CarDetailTag:false,
      //车库费用缴纳明细
      //CarInfo:"",
      pageAndCarInfo:{},
      //物业费用缴费情况
      DetailTag:false,
      detailsInfo:{},
      row: {},
      house: {},
      radio: "1",
      props: [
        { prop: "hid", lable: "房屋编号" },
        // { prop: "tower", lable: "单元" },
        //  { prop: "floor", lable: "楼层" },
        { prop: "houseNumber", lable: "房号" },
        //  { prop: "timeString", lable: "建筑年份" },
        { prop: "checkTimeString", lable: "入住年份" },
        { prop: "propertyRight", lable: "产权(年)" },
        { prop: "area", lable: "房屋面积(cm²)" },
        { prop: "structure", lable: "房屋户型" },
        { prop: "state", lable: "房屋状态" },
        { prop: "price", lable: "物业费用" },
        { prop: "endTimeString", lable: "物业费到期时间" }
      ],
      details:[  
        { prop: "did", lable: "编号" },
        { prop: "hid", lable: "房屋编号" },
        { prop: "price", lable: "缴纳金额" },
        { prop: "beginTimeString", lable: "开始时间" },
        { prop: "endTimeString", lable: "结束时间" },
        { prop: "way", lable: "缴费方式" },
        { prop: "employee.ename", lable: "操作人" }
      ],
      CarDetail:[
      //  { prop: "proprietor.pid", lable: "用户编号" },     
        { prop: "proprietor.pid", lable: "用户编号" },     
      //{ prop: "garageProprietor.gpid", lable: "租聘编号" }, 
        { prop: "proprietor.pname", lable: "业主姓名" },
        { prop: "proprietor.phone", lable: "电话号码" },  
        { prop: "garageProprietor.endTimeString", lable: "到期时间" }, 
        { prop: "garageProprietor.state", lable: "租用状态" }, 
       // { prop: "garage.gid", lable: "车库编号" }
        { prop: "garage.location", lable: "车库位置" },
        { prop: "garage.price", lable: "租用金额" },
      ],
      CarInfoDetail:[
        { prop: "transactions.gpid", lable: "缴费编号" },
        { prop: "proprietor.pname", lable: "业主姓名" },
        { prop: "proprietor.phone", lable: "电话号码" }, 
        { prop: "garageProprietor.type", lable: "买(0)租(1)" },
        { prop: "transactions.beginTimeString", lable: "缴费时间" },
        { prop: "transactions.endTimeString", lable: "到期时间" }, 
        { prop: "transactions.price", lable: "支付金额" }, 
        { prop: "transactions.way", lable: "支付方式" }, 
        { prop: "employee.ename", lable: "操作员工" }
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
    carInfoTag(){
        this.CaroutTag=true;
        this.findCarInfoDetails();
        console.log(this.pageAndCarInfo);
        
    },
      //车库费用缴纳明细
    findCarInfoDetails(page = 1, pageSize = 5) {
      let url ="http://localhost:9090/Detail/findCarInfoDetails?page=" +page +"&pageSize=" +pageSize;
      axios.post(url).then(resp => {
          this.pageAndCarInfo = resp.data; 
        }).catch(ex => {
          console.log(ex);
        });
    },

   //分页
    handleCurrentChange4(page) {
      this.findCarInfoDetails(page, this.pageAndCarInfo.pageSize);
    },
    handleSizeChange4(pageSize) {
      this.findCarInfoDetails(this.pageAndCarInfo.pageNum, pageSize);
    },
    //车库费用缴纳详情 
    findCarDetails(page = 1, pageSize = 5) {
      let url ="http://localhost:9090/Detail/findCarDetails?page=" +page +"&pageSize=" +pageSize;
      axios.post(url).then(resp => {
          this.CarDetailsInfo = resp.data;
          console.log(this.CarDetailsInfo);
        }).catch(ex => {
          console.log(ex);
        });
    },

     //分页
    handleCurrentChange3(page) {
      this.findCarDetails(page, this.CarDetailsInfo.pageSize);
    },
    handleSizeChange3(pageSize) {
      this.findCarDetails(this.CarDetailsInfo.pageNum, pageSize);
    },

        //物业费用缴纳详情 
    findHouseDetails(page = 1, pageSize = 5) {
      let url ="http://localhost:9090/Detail/findHouseDetails?page=" +page +"&pageSize=" +pageSize;
      axios.post(url).then(resp => {
          this.detailsInfo = resp.data;
        }).catch(ex => {
          console.log(ex);
        });
    }, 
  //分页
    handleCurrentChange2(page) {
      this.findHouseDetails(page, this.detailsInfo.pageSize);
    },
    handleSizeChange2(pageSize) {
      this.findHouseDetails(this.detailsInfo.pageNum, pageSize);
    },
    //车库续费
    saveCarInfo(row){
      let url="http://localhost:9090/Detail/saveTransaction?endTimeString="+
       this.endTimeString+"&month="+this.num+"&gpid="+this.gpid+"&price="+this.gprice; 
          this.$axios.post(url).then(resp=>{  
            this.$message.success(resp.data.message); 
            this.CarDetailsTag=false;
            this.findCarDetails();
          }).catch(ex=>{});
    }, 
    //车库续费月份
    handleChange(row,value) {
      this.gprice=(value+1)*this.row.garage.price;
        //console.log(value);
      }, 
    //车库续费
    SaveCarDetails(row){
      this.CarDetailsTag=true;
      this.row=row;
      //console.log(this.row.garageProprietor.endTimeString);
      //console.log(this.row.proprietor.pname);
      this.gpname=this.row.proprietor.pname;
      this.endTimeString=this.row.garageProprietor.endTimeString;
      this.gprice=this.row.garage.price; 
      this.gpid=this.row.garageProprietor.gpid; 
    }, 
    //强制过期
    constraint(row){

       console.log(row);
      this.row=row; 
      this.endTimeString=this.row.garageProprietor.endTimeString;
      this.gpid=this.row.garageProprietor.gpid;
       let url="http://localhost:9090/GarageProprietor/findEndTime?endTimeString="+this.endTimeString+"&gpid="+this.gpid;
          this.$axios.post(url).then(resp=>{  
            if(this.$message==true){                
              this.$message.success(resp.data.message);  
            }else{
              this.$message.error(resp.data.message);
            }
            this.findCarDetails();
            console.log(endTimeString);
          }).catch(ex=>{});
    },

    //续费
    saveHouseInfo(selVal,row){
       let url="http://localhost:9090/Detail/updateHouse?endTimeString="+
       this.row.endTimeString+"&selVal="+this.selVal+"&hid="+this.row.hid+"&price="+this.row.count1; 
          this.$axios.post(url).then(resp=>{  
            this.$message.success(resp.data.message); 
            this.detailInfoTag=false;
            this.findHouses();
          }).catch(ex=>{});
    },
    
    //计算物业费用
    currentSel(selVal,row) {
      this.selVal = selVal; 
      this.row.count1=this.row.count*this.selVal;
      this.dialogVisible = true;
    },

    //房屋信息
    findHouses(page = 1, pageSize = 5) {
      let url ="http://localhost:9090/House/findPages?page=" +page +"&pageSize=" +pageSize +"&houseNumber=" +
        this.name;
      axios.post(url).then(resp => {
          this.pageInfo = resp.data;
        }).catch(ex => {
          console.log(ex);
        });
    },
    //查询房屋信息
    findHouse() {
      let url = "http://localhost:9090/Detail/findHouse?hid=" + this.row.hid;
      axios
        .post(url)
        .then(resp => {
          this.house = resp.data;
          // console.log(resp.data);
        })
        .catch(ex => {
          console.log(ex);
        });
    },
    //分页
    handleCurrentChange(page) {
      this.findHouses(page, this.pageInfo.pageSize);
    },
    handleSizeChange(pageSize) {
      this.findHouses(this.pageInfo.pageNum, pageSize);
    },
    detailInfo(row) {
      this.detailInfoTag = true;
      this.row = row;
      this.row.count = this.row.area * this.row.price;
      this.findHouse(row.hid);
    }
  }, 
  mounted() {
    this.findHouses();
    this.findHouseDetails();
    this.findCarDetails();
    //this.findCarInfoDetails();
  }
};
</script>

<style  scoped>
</style>
