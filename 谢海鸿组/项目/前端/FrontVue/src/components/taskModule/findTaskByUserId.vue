<template>
    <div>
    <div class="block" style="padding-bottom:10px">
          <el-date-picker
            value-format="yyyy-MM-dd"  
            v-model="begindate"
            align="right"
            type="date"
            placeholder="选择日期">
          </el-date-picker>
          &nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;
          <el-date-picker
            value-format="yyyy-MM-dd"  
            v-model="enddate"
            align="right"
            type="date"
            placeholder="选择日期">
          </el-date-picker>&nbsp;&nbsp;&nbsp;
          <el-button type="primary" icon="el-icon-search" @click="find()">搜索</el-button>
        </div>

        <el-table :data="pageInfo.list" border style="width: 100%" stripe 
        :default-sort = "{prop:'taskid',order:'descending'}" ref="multipleTable">
          <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label" 
          :width="item.width"> 
          </el-table-column>
          <!--操作列-->
        <el-table-column
        label="操作">
        <template slot-scope="scope">
            <el-button  @click="findPlan(scope.row)"
            type="button" size="small">
                查看计划
            </el-button>
            <el-button  @click="associateWith(scope.row)"
            type="button" size="small">
                任务反馈
            </el-button>
        </template>
        </el-table-column>
        </el-table>

        <!-- 分页 -->
        <div class="block">
        <el-pagination
            layout="total, sizes, prev, pager, next, jumper"
            :page-sizes="[3, 5, 8, 10]"
            :page-size="5"
            :total="pageInfo.total"
            @current-change="handleChangePage"
            @size-change="handleChangePageSize"
            >
        </el-pagination>
        </div>

        <el-dialog
        title="查看计划"
        :visible.sync="findPlanTag"
        top="10px"
        width="80%"
        :close-on-click-modal="false">
           <span style="text-align:center;font-size:20px;padding-bottom:10px">
          任务名称：{{taskName}}
          </span>
          <el-table :data="planList.list" border style="width: 100%" stripe 
           ref="multipleTable">
            <el-table-column v-for="item in propsPlan" :key="item.prop" :prop="item.prop" :label="item.label" 
            :width="item.width"> 
            </el-table-column>
            <!--操作列-->
          <el-table-column
          label="操作">
          <template slot-scope="scope">
              <el-button  @click="update(scope.row)"
              type="button" size="small">
                  计划反馈
              </el-button>
          </template>
          </el-table-column>
          </el-table>

          <!-- 分页 -->
          <div class="block">
          <el-pagination
              layout="total, sizes, prev, pager, next, jumper"
              :page-sizes="[2, 5, 8, 10]"
              :page-size="2"
              :total="planList.total"
              @current-change="handleChangePage2"
              @size-change="handleChangePageSize2"
              >
          </el-pagination>
          </div>
          <div class="block">
          <el-button @click="findPlanTag = false" type="primary">关 闭</el-button>
        </div>

        <!--2.修改-->
        <el-dialog
        title="反馈信息"
        :visible.sync="updateTag"
        top="10px"
        width="50%"
        append-to-body
        :close-on-click-modal="false">
        <el-row>
          <el-col :span="3" class="font1">计划名称</el-col>
          <el-col :span="10">
            <el-input v-model="row.planname" readonly ></el-input>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">状态</el-col>
          <el-col :span="10" style="text-align:left;">
            <el-select v-model="row.state" placeholder="请选择">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">结束日期</el-col>
          <el-col :span="10">
          <el-col :span="10">
            <el-date-picker
            v-model="row.endtimeString"
            type="date"
            placeholder="选择日期"
            value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-col>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">计划描述</el-col>
          <el-col :span="10">
            <el-input type="textarea" v-model="row.plandesc"></el-input>
          </el-col>
        </el-row>
        <span slot="footer" class="dialog-footer">
            <el-button @click="updateTag = false">取 消</el-button>
            <el-button type="primary" @click="doUpdate">确 定</el-button>
        </span>
        </el-dialog>
        </el-dialog>

        <el-dialog
        title="任务反馈"
        :visible.sync="associateWithTag"
        top="10px"
        width="50%"
        :close-on-click-modal="false">
          <el-row>
            <el-col :span="3" class="font1">任务名称</el-col>
            <el-col :span="10">
              <el-input v-model="rowassociate.taskname" readonly ></el-input>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="3" class="font1">状态</el-col>
            <el-col :span="10" style="text-align:left;">
              <el-select v-model="rowassociate.status" placeholder="请选择">
                <el-option
                  v-for="item in optionsTask"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="3" class="font1">结束日期</el-col>
            <el-col :span="10">
            <el-col :span="10">
              <el-date-picker
              v-model="rowassociate.enddateString"
              type="date"
              placeholder="选择日期"
              value-format="yyyy-MM-dd">
              </el-date-picker>
            </el-col>
            </el-col>
          </el-row>
          <el-row>
          <el-col :span="3" class="font1">任务描述</el-col>
          <el-col :span="10">
            <el-input type="textarea" v-model="rowassociate.taskdesc"></el-input>
          </el-col>
        </el-row>
          <span slot="footer" class="dialog-footer">
            <el-button @click="associateWithTag = false">取 消</el-button>
            <el-button type="primary" @click="doUpdateTask">确 定</el-button>
        </span>
        </el-dialog>
    </div>
     
</template>

<script>
export default {
    data() {
      return {
        page:1,
        pageInfo:{},
        begindate:'',
        enddate:'',
        props:[
          {prop:"taskid",label:"编号",width:"50"},
          {prop:"taskname",label:"任务名称",width:"120"},
          {prop:"user.realname",label:"实施人",width:"120"},
          {prop:"begindateString",label:"开始日期",width:"170"},
          {prop:"enddateString",label:"结束日期",width:"170"},
          {prop:"status",label:"状态",width:"80"},
          {prop:"reason",label:"意见",width:"100"},
        ],

        pagePlan:1,
        planList:{},
        plan:{},
        row:{},
        propsPlan:[
          {prop:"planid",label:"编号",width:"100"},
          {prop:"planname",label:"计划名称",width:"120"},
          {prop:"state",label:"计划状态",width:"100"},
          {prop:"begintimeString",label:"开始日期",width:"200"},
          {prop:"endtimeString",label:"结束日期",width:"200"},
        ],
        
        options: [
           {value: '未完成',label: '未完成'},
           {value: '未反馈',label: '未反馈'},
           {value: '已反馈',label: '已反馈'},
           {value: '已完成',label: '已完成'},
         ],
         optionsTask: [
           {value: '待实施',label: '待实施'},
           {value: '未实施',label: '未实施'},
           {value: '未反馈',label: '未反馈'},
           {value: '已反馈',label: '已反馈'},
           {value: '已完成',label: '已完成'},
         ],
        updateTag:false,
        findPlanTag:false,
        value: '',
        userid:null,
        rowassociate:{},
        associateWithTag:false,
        taskName:null,
      };
    },
    computed:{
        host(){
            return this.$axios.defaults.baseURL;
        }
    },
    methods:{
        //分页
        find(page=1,pageSize=5){
          let userid=this.$store.state.login.users.userid;
          let url="task/findTaskByUserId?page="+page+"&pageSize="+pageSize+"&userid="+userid;
          this.$axios.get(url).then(resp=>{
            this.pageInfo=resp.data.data;
          }).catch((ex)=>{
            console.log(ex);
          });
        },
        handleChangePage(page){
             this.find(page,this.pageInfo.pageSize);
        },
        handleChangePageSize(pageSize){
          this.find(this.pageInfo.pageNum,pageSize);
        },
        changeSort({ column, prop, order }){
             console.group(column);
             console.log(prop);
             console.log(order); 
        },
        findPlan(row){
          this.findPlanTag=true;
          this.row=row;
          this.doFindPlan();
        },
        doFindPlan(page=1,pageSize=2){
          let url="plan/findPlanById?page="+page+"&pageSize="+pageSize+"&taskid="+this.row.taskid;
          this.$axios.get(url).then(resp=>{
            this.taskName=this.row.taskname;
            this.planList=resp.data.data;
          }).catch((ex)=>{
            console.log(ex);
          });
        },
        handleChangePage2(page){
             this.doFindPlan(page,this.planList.pageSize);
        },
        handleChangePageSize2(pageSize){
          this.doFindPlan(this.planList.pageNum,pageSize);
        },
        update(row){
          if("已完成"==row.state){
                this.updateTag=false;
                this.$message.error("此计划已完成，不能再进行修改了哦");
                this.doFindPlan(this.planList.pageNum,this.planList.pageSize);
              }else{
                this.updateTag=true;
                this.row=row;
              }
        },
        doUpdate(){
            let url="plan/update";
            this.$axios.post(url,this.row).then(resp=>{
                this.updateTag=false;
                this.doFindPlan(this.planList.pageNum,this.planList.pageSize);
                this.$message.success(resp.data.message);
            }).catch(ex=>{console.log(ex);});
        },
        associateWith(rowassociate){
          if("已完成"==rowassociate.status){
                this.associateWithTag=false;
                this.$message.error("此计划已完成，不能再进行交接了哦");
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
              }else{
                this.associateWithTag=true;
                this.rowassociate=rowassociate;
              }
        },
        doUpdateTask(){
          let url="task/update";
            this.$axios.post(url,this.rowassociate).then(resp=>{
                this.associateWithTag=false;
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
                this.$message.success(resp.data.message);
            }).catch(ex=>{console.log(ex);});
        },
    },
    mounted(){
      this.find();
    },
}
</script>

<style scoped>
.el-table .warning-row {
    background: oldlace;
  }

  .el-table .success-row {
    background: #f0f9eb;
  }
</style>