<template>
    <div>
        <el-table :data="pageInfo.list" border style="width: 100%" stripe  @sort-change="changeSort"
        :default-sort=" {prop:'leaveid',order:'descending'}" ref="multipleTable" >
        <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label"
         :width="item.width">
        </el-table-column>

         <!--操作列-->
          <el-table-column  label="操作" width="150px">
          <template slot-scope="scope"  >
              <el-tag v-if="scope.row.leavestate==null"  type="text">等待审批</el-tag>
              <el-button v-if="scope.row.leavestate=='驳回'" @click="tagShow(scope.row)" type="text">再次申请</el-button>
              <el-tag v-else-if="scope.row.leavestate=='同意'" type="text">申请成功</el-tag>
          </template>
          </el-table-column> 

        </el-table>

  <el-dialog title="重新修改" :visible.sync="tag" width="50%" :before-close="tagCloce" :close-on-click-modal="false">
  <el-form ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <span>驳回原因：{{leave.remark}}</span>
          <div style="margin: 20px;"></div>
        <el-row>
          <el-col :span="3" class="font1">请假原因</el-col>
          <el-col :span="16">
            <el-input name="pwd" v-model="leave.leavereason" ></el-input>
          </el-col>
        </el-row>
         <el-row>
          <el-col :span="3" class="font1">开始时间</el-col>
          <el-col :span="10">
          <el-col :span="10">
            <el-date-picker
            v-model="leave.leavetime"
            type="date"
            placeholder="选择日期"
            value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-col>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">结束时间</el-col>
          <el-col :span="10">
          <el-col :span="10">
            <el-date-picker
            v-model="leave.stopleave"
            type="date"
            placeholder="选择日期"
            value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-col>
          </el-col>
        </el-row>
         <el-row>
        <el-col :span="3" class="font1">内容：</el-col>
        <el-col :span="10">
          <el-input
            type="textarea"
            placeholder="请输入内容"
            v-model="leave.context"
            :autosize="{ minRows: 2, maxRows: 8}"
          ></el-input>
        </el-col>
      </el-row>
         <el-row>
          <el-col :span="3" class="font1">请假天数</el-col>
          <el-col :span="16">
            <el-input name="pwd" v-model="leave.duration"></el-input>
          </el-col>
        </el-row>
        </el-form>
          <span slot="footer" class="dialog-footer">
            <el-button @click="tag = false">取 消</el-button>
            <el-button type="primary" @click="updatelhl2">确 定</el-button>
          </span>
        </el-dialog>


         <!-- 分页 -->
         <el-pagination
           layout="total, sizes, prev, pager, next, jumper"
            :page-sizes="[ 5, 8, 10]"
            :page-size="3"
            :total="pageInfo.total"
            @current-change="handleChangePage"
            @size-change="handleChangePageSize"
         >
              </el-pagination>

    </div>
</template>
<script>
export default {
    data() {
      return {
        tag:false,
        leave:{},
        page:1,
        pageInfo:{},
        props:[
          {prop:"leaveid",label:"编号",width:"100"},
          {prop:"userid",label:"员工编号",width:"100"},
          {prop:"leavereason",label:"原因",width:"100"},
          {prop:"leavetimeString",label:"开始时间",width:"200"},
          {prop:"stopleaveString",label:"结束时间",width:"200"},
          {prop:"context",label:"内容",width:"200"},
          {prop:"leavestate",label:"状态",width:"200"},
          {prop:"approval",label:"审批人",width:"100"},
          {prop:"finall",label:"最终结果",width:"200"},
          {prop:"remarks",label:"驳回原因",width:"100"},
          {prop:"approver",label:"终审人",width:"100"},
          {prop:"remark",label:"驳回原因",width:"100"},
          {prop:"user.username",label:"员工名称",width:"200"},
          {prop:"duration",label:"请假天数",width:"200"},
        ],
      };
        
    },
    methods:{
        //分页
        find(page=1,pageSize=5){
          let url="leave/pageInfo?page="+page+"&pageSize="+pageSize;
          this.$axios.get(url).then(resp=>{
            console.log(resp.data.data);
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
        
         tagShow(row){
            this.leave=row
            this.tag=true;
        },

         tagCloce(done){
          this.$confirm('确认关闭')
          .then(_ => {
            done();
          })
          .catch(_ => {});
        },
        updatelhl2(){
            console.log(this.leave.leaveid);
            let url="leave/updatelhl2"
           this.$axios.post(url,this.leave).then(resp=>{
            this.tag=false;
                this.$message.success(resp.data.message);
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
            }).catch(ex=>{});

        },
        updatelhl(row){
            console.log(row.leaveid);
            let url="leave/updateState5?leaveid="+row.leaveid;
            this.$axios.get(url).then(resp=>{
            console.log(row.leaveid);
                this.$message.success(resp.data.message);
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
            }).catch(ex=>{});

        },

    },
    mounted(){
      this.find();
    },
    computed:{
        host(){
            return this.$axios.defaults.baseURL;
        }
    }
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