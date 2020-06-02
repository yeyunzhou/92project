<template>
  <div>
    <el-row>
      <el-col :span="12">
        <el-input placeholder="请输入搜索关键字" v-model="name" type="text"></el-input>
      </el-col>
      <el-col :span="2">
        <el-button type="primary" icon="el-icon-search" circle @click="find()"></el-button>
      </el-col>
      <el-col :span="10">
        <el-button @click="addEquipment =true" size="small">添加设备</el-button>
        <el-button @click="outerVisible =true" size="small">车库信息</el-button>
        <el-button @click="outerVisible2 =true" size="small">巡查信息</el-button>
      </el-col>
    </el-row>
    <br />
    <el-table :data="pageInfo.list" border ref="multipleTable" style="width: 100%;">
      <el-table-column v-for="item in props" :key="item.id" :prop="item.prop" :label="item.lable"></el-table-column>
      <!--操作列-->
      <el-table-column label="操作">  
            <template slot-scope="scope">
                <el-button @click="maintain(scope.row)" type="text" size="small">维修登记</el-button>  
                <el-button @click="maintainInfo(scope.row)" type="text" size="small">维修信息</el-button> 
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
    <!--维修信息-->  
     <el-dialog title="维修信息" :visible.sync="maintainInfoTag" width="1000px">
        <div>  
          <el-table :data="maintenances" ref="multipleTable" style="width: 100%;">
            <el-table-column v-for="item in maintenanceInfo" :key="item.mid" :prop="item.prop" :label="item.lable"></el-table-column>
            <!--操作列-->
            <el-table-column label="操作">  
                  <template slot-scope="scope">
                      <el-button @click="maintainInfoState(scope.row)"
                      type="text" size="small">修改状态</el-button>   
                  </template> 
            </el-table-column>
          </el-table>
        </div>
        <br />
        <div style="text-align: right;">
          <el-button >保存</el-button>
          <el-button @click="maintainInfoTag = false">取 消</el-button>
        </div>
      </el-dialog>
      <!--维修信息修改状态-->
      <el-dialog title="修改状态" :visible.sync="maintainUpdateState">
        <el-row>
                <el-col :span="5" >维修编号:</el-col>
                <el-col :span="16"><el-input name="mid" v-model="row.mid" readonly ></el-input></el-col>
            </el-row>
        <br />
            <el-row>
                <el-col :span="5" >设备编号:</el-col>
                <el-col :span="16"><el-input name="eqid" v-model="row.eqid" readonly ></el-input></el-col>
            </el-row>
        <br />
        <br />
            <el-row>
                <el-col :span="5">维修时间:</el-col>
                <el-col :span="16"><el-input name="maintainTime"
                type="date" v-model="row.maintainTimeString"></el-input></el-col>
            </el-row>
            <br />
            <el-row>
                <el-col :span="5">维修费用:</el-col>
                <el-col :span="16"><el-input name="price" v-model="row.price" ></el-input></el-col>
            </el-row> 
            <br />
            <el-row>
                <el-col :span="5">维修原因:</el-col>
                <el-col :span="16"><el-input name="roadworkcause" v-model="row.roadworkcause" ></el-input></el-col>
            </el-row>
            <br />
            <el-row>
                <el-col :span="5">维修状态:</el-col>
                <el-col :span="16">
                  <el-radio-group v-model="row.state" name="state">
                    <el-radio label="未维修" name="state">未维修</el-radio>
                    <el-radio label="已维修" name="state">已维修</el-radio>
                  </el-radio-group> 
                </el-col>
            </el-row>
            <br />
            <el-row>
                <el-col :span="5">备注:</el-col>
                <el-col :span="16"><el-input   name="remark" v-model="row.remark"></el-input></el-col>
            </el-row> 
            <br/>
        <div style="text-align: right;">
          <el-button @click="doUpdateState">保存</el-button>
          <el-button @click="maintainUpdateState = false">取 消</el-button>
        </div>
        </el-dialog>  
    <!--维修登记-->  
     <el-dialog title="维修登记" :visible.sync="maintainTag" :close-on-click-modal="false">  
            <el-row>
                <el-col :span="5" >设备编号:</el-col>
                <el-col :span="16"><el-input name="eqid" v-model="row.eqid" readonly ></el-input></el-col>
            </el-row>
            <br />
            <el-row>
                <el-col :span="5">维修单位:</el-col>
                <el-col :span="16"><el-input name="roadworkunit" v-model="maintenance.roadworkunit"></el-input></el-col>
            </el-row>
            <br />
            <el-row>
                <el-col :span="5">维修时间:</el-col>
                <el-col :span="16"><el-input name="maintainTime" type="date" v-model="maintenance.maintainTime"></el-input></el-col>
            </el-row>
            <br />
            <el-row>
                <el-col :span="5">维修费用:</el-col>
                <el-col :span="16"><el-input name="price" v-model="maintenance.price" ></el-input></el-col>
            </el-row> 
            <br />
            <el-row>
                <el-col :span="5">维修原因:</el-col>
                <el-col :span="16"><el-input name="roadworkcause" v-model="maintenance.roadworkcause" ></el-input></el-col>
            </el-row>
            <br />
            <el-row>
                <el-col :span="5">维修状态:</el-col>
                <el-col :span="16">
                  <el-col :span="16">
                  <el-radio-group v-model="maintenance.state" name="state">
                    <el-radio label="未维修" name="state">未维修</el-radio>
                    <el-radio label="已维修" name="state">已维修</el-radio>
                  </el-radio-group> 
                </el-col> 
                </el-col>
            </el-row>
            <br />
            <el-row>
                <el-col :span="5">备注:</el-col>
                <el-col :span="16"><el-input   name="remark" v-model="maintenance.remark"></el-input></el-col>
            </el-row>  
        <br />
        <div style="text-align: right;">
          <el-button @click="doUpdate">保存</el-button>
          <el-button @click="maintainTag = false">取 消</el-button>
        </div>
      </el-dialog>
      <!--设备添加--> 
     <el-dialog title="设备添加" :visible.sync="addEquipment" :close-on-click-modal="false"> 
          <el-row>
            <el-col :span="5">设备名称:</el-col>
            <el-col :span="16"><el-input v-model="equipments.eqname"></el-input></el-col>
          </el-row>
          <el-row>
        <br />
            <el-col :span="5">设备位置:</el-col>
            <el-col :span="16"><el-input v-model="equipments.site"></el-input></el-col>
          </el-row>
          <el-row>
        <br />
            <el-col :span="5">设备状态:</el-col>
            <el-col :span="16"><el-input v-model="equipments.state"></el-input></el-col>
          </el-row>
          <br /> 
        <div style="text-align: right;">
          <el-button @click="doSaveEq">保存</el-button>
          <el-button @click="addEquipment = false">取 消</el-button>
        </div>
      </el-dialog>

    <el-dialog title="车库信息" :visible.sync="outerVisible">  
      <!--车库登记-->
      <el-dialog width="30%" title="车库登记" :visible.sync="innerVisible2" :close-on-click-modal="false" append-to-body>
        <div> 
          <el-row>
            <el-col :span="5">车库位置:</el-col>
            <el-col :span="16">
              <el-input v-model="garages.location"></el-input>
            </el-col>
          </el-row>
          <br />
          <el-row>
            <el-col :span="5">车库金额:</el-col>
            <el-col :span="16">
              <el-input v-model="garages.price"></el-input>
            </el-col>
          </el-row> 
        </div>
        <br />
        <div style="text-align: right;">
          <el-button @click="doSave">保存</el-button>
          <el-button @click="innerVisible2 = false">取 消</el-button>
        </div>
      </el-dialog>
        <!--车库信息-->
      <div class="dialog-footer">
        <el-table :data="pageInfo2.list" ref="multipleTable">
          <el-table-column
            v-for="item in garage"
            :key="item.id"
            :prop="item.prop"
            :label="item.lable"
          ></el-table-column> 
        </el-table>
        <br />
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
          <el-button @click="innerVisible2 = true">录 入</el-button>
          <el-button @click="outerVisible = false">取 消</el-button>
        </div>
      </div>
    </el-dialog>

    <el-dialog title="巡查信息" :visible.sync="outerVisible2">
      <el-table :data="pageInfo3.list" ref="multipleTable">  
        <el-table-column
          v-for="item in patrol"
          :key="item.id"
          :prop="item.prop"
          :label="item.lable"
        ></el-table-column>
      </el-table>
      <br />
      <el-pagination
        :page-sizes="[3, 5, 8, 10]"
        :page-size="5"
        @current-change="handleCurrentChange3"
        @size-change="handleSizeChange3"
        layout="total, sizes, prev, pager, next, jumper"
        :total="pageInfo3.total"
      ></el-pagination>
      <br/>
      <div style="text-align: right;">
        <el-button @click="reg = true">登 记</el-button>
        <el-button @click="outerVisible2 = false">取 消</el-button>
      </div>
    </el-dialog> 

    <el-dialog width="30%" title="巡查信息登记" 
    :visible.sync="reg" :close-on-click-modal="false" append-to-body > 
         <el-row>
            <el-col :span="5">巡查时间:</el-col>
            <el-col :span="16"><el-input type="date" v-model="patrols.patrolTime"></el-input></el-col>
          </el-row>
          <el-row>
        <br />
            <el-col :span="5">备注信息:</el-col>
            <el-col :span="16"><el-input v-model="patrols.remark"></el-input></el-col>
          </el-row> 
          <br /> 
        <div style="text-align: right;">
          <el-button @click="doSavePatrol">保存</el-button>
          <el-button @click="reg = false">取 消</el-button>
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
      patrols:{}, 
      reg:false,
      outerVisible: false,
      outerVisible2: false,
      //维修登记
      maintainTag: false, 
      maintenance:{},
      //维修信息
      maintenances: {},
      maintainInfoTag:false,
      //维修信息修改状态
      maintainUpdateState:false,
      row:{},
      outerVisible4: false,
      innerVisible: false,
      innerVisible2: false,
      //添加
      saveGarage:false,
      garages: {},
      equipments:{},
      addEquipment:false,
      page: 1,
      pageInfo: {},
      pageInfo2: {},
      pageInfo3: {},
      props: [
        { prop: "eqid", lable: "设备编号" },
        { prop: "eqname", lable: "设备名称" },
        { prop: "site", lable: "设备位置" },
        { prop: "state", lable: "设备状态" }
      ],
      garage: [
        { prop: "gid", lable: "车库编号" },
        { prop: "location", lable: "车库位置" },
        { prop: "price", lable: "车库价格" }
      ],
      patrol: [
        { prop: "patrol.pid", lable: "巡查编号" },
        { prop: "ename", lable: "员工姓名" },
        { prop: "sex", lable: "员工性别" },
        { prop: "patrol.patrolTimeString", lable: "巡查时间" }, 
        { prop: "patrol.remark", lable: "备注" }
      ],
      maintenanceInfo:[
        { prop: "mid", lable: "维修编号"},
        { prop: "eqid", lable: "设备编号"},
        { prop: "maintainTimeString", lable: "维修时间" },
        { prop: "roadworkunit", lable: "维修单位" },
        { prop: "price", lable: "维修金额" },
        { prop: "roadworkcause", lable: "维修原因" },
        { prop: "state", lable: "维修状态" },
        { prop: "remark", lable: "备注信息" },
      ]
    };
  },

  computed: {
    host() {
      return this.$axios.defaults.baseURL;
    }
  },
  methods: {
      //维修信息修改维修状态
      doUpdateState(){
        let url="http://localhost:9090/maintenance/updateMaintenanceState?eqid="+this.row.eqid+"&mid="+this.row.mid+"&state="+this.row.state;
        this.$axios.post(url).then(resp=>{ 
                this.$message.success(resp.data.message);
                this.maintainUpdateState=false;
                this.find();
            }).catch(ex=>{});
      },

     //维修信息
       doInfo(){ 
           let url="http://localhost:9090/maintenance/findMaintenance?eqid="+this.row.eqid;
           axios.post(url).then(resp => {
           this.maintenances = resp.data;
           console.log(this.maintenances);
          // console.log(resp.data); 
        }).catch(ex => {
          console.log(ex);
        }); 
      },
         maintainInfo(row){ 
            this.maintainInfoTag=true; 
            this.row=row;
            this.doInfo(row.eqid);
            
        },
         maintainInfoState(row){ 
            this.maintainUpdateState=true; 
            this.row=row; 
            
        },
      //维修信息登记
       doUpdate(){ 
            let url="http://localhost:9090/maintenance/saveMaintenance?eqid="+this.row.eqid;
            this.$axios.post(url,this.maintenance).then(resp=>{
                console.log(this.maintenance);
                this.$message.success(resp.data.message);
                this.maintainTag=false;
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
                this.maintenance={};
            }).catch(ex=>{});

        },
        maintain(row){
            this.maintainTag=true;
            this.row=row;
        },
       
       
         //巡查信息登记
       doSavePatrol(){
             let url="http://localhost:9090/patrol/savePatrol";
             this.$axios.post(url,this.patrols).then(resp=>{
                   this.$message.success(resp.data.message); 
                   this.findPatrol(this.pageInfo3.lastPage,this.pageInfo3.pageSize); 
                   this.reg=false; 
                   this.patrols={};
             }).catch(ex=>{});
           
        },
      //车库登记
       doSave(){
             let url="http://localhost:9090/garage/saveGarage";
             this.$axios.post(url,this.garages).then(resp=>{
                   this.$message.success(resp.data.message); 
                   this.findGarage(this.pageInfo2.lastPage,this.pageInfo2.pageSize);
                   this.innerVisible2=false; 
                   this.garages={};
             }).catch(ex=>{});
           
        },
        //设备登记
       doSaveEq(){
             let url="http://localhost:9090/equipment/saveEquipment";
             this.$axios.post(url,this.equipments).then(resp=>{
                   this.$message.success(resp.data.message);  
                   this.addEquipment=false; 
                   this.equipments={};
             }).catch(ex=>{});
           
        },
      
    //设备信息
    find(page = 1, pageSize = 5) {
      let url =
        "http://localhost:9090/equipment/findPages?page=" +page + "&pageSize=" + pageSize+"&eqname="+this.name;
      axios.post(url).then(resp => {
          this.pageInfo = resp.data;
        }).catch(ex => {
          console.log(ex);
        });
    },
    //分页
    handleCurrentChange(page) {
      this.find(page, this.pageInfo.pageSize);
    },
    handleSizeChange(pageSize) {
      this.find(this.pageInfo.pageNum, pageSize);
    },
    //车库信息
    findGarage(page = 1, pageSize = 5) {
      let url ="http://localhost:9090/garage/findPages?page=" +page +"&pageSize=" +pageSize;
      axios.post(url).then(resp => {
          this.pageInfo2 = resp.data;
        }).catch(ex => {
          console.log(ex);
        });
    },
    //分页
    handleCurrentChange2(page) {
      this.findGarage(page, this.pageInfo2.pageSize);
    },
    handleSizeChange2(pageSize) {
      this.findGarage(this.pageInfo2.pageNum, pageSize);
    },

    //设备巡查信息
    findPatrol(page = 1, pageSize = 5) {
      let url ="http://localhost:9090/patrol/findPages?page=" +page +"&pageSize=" +pageSize;
      axios.post(url).then(resp => {
          this.pageInfo3 = resp.data; 
        }).catch(ex => {
          console.log(ex);
        });
    },
    //分页
    handleCurrentChange3(page) {
      this.findPatrol(page, this.pageInfo3.pageSize);
    },
    handleSizeChange3(pageSize) {
      this.findPatrol(this.pageInfo3.pageNum, pageSize);
    }
  },
  mounted() {
    this.find();
    this.findGarage();
    this.findPatrol();
  }
};
</script>

<style  scoped>
</style>
