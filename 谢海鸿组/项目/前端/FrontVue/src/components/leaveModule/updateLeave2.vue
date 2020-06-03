<template>
    <div>
        <el-table :data="pageInfo.list" border style="width: 100%" stripe @sort-change="changeSort"
        :default-sort = "{prop:'leaveid',order:'descending'}" ref="multipleTable">
          <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label" 
          :width="item.width"> 
          </el-table-column>

          <!--操作列-->
          <el-table-column  label="操作" width="150px">
          <template slot-scope="scope">

              <el-button @click="updateState(scope.row)" type="text" size="small" width="190px">同意</el-button>
              <el-button @click="tagShow(scope.row)" type="text" size="small" width="190px" >驳回</el-button>
          </template>
          </el-table-column>
        </el-table>

        
  <el-dialog title="重新修改" :visible.sync="tag" width="50%" :before-close="tagCloce" :close-on-click-modal="false">
      <el-row>
        <el-col :span="3" class="font1">驳回原因：</el-col>
        <el-col :span="10">
          <el-input
            type="textarea"
            placeholder="请输入内容"
            v-model="leave.remark"
            :autosize="{ minRows: 2, maxRows: 8}"
          ></el-input>
        </el-col>
      </el-row>
          <span slot="footer" class="dialog-footer">1
            <el-button @click="tag = false">取 消</el-button>
            <el-button type="primary" @click="update3">确 定</el-button>
          </span>
        </el-dialog>


        <!-- 分页 -->
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
</template>

<script>
export default {
    data() {
      return {
        tag:false,
        page:1,
        pageInfo:{},
        leave:{},
        props:[
          {prop:"leaveid",label:"编号",width:"100"},
          {prop:"userid",label:"员工编号",width:"100"},
          {prop:"leavereason",label:"原因",width:"100"},
          {prop:"leavetime",label:"开始时间",width:"200"},
          {prop:"stopleave",label:"结束时间",width:"200"},
          {prop:"context",label:"内容",width:"200"},
          {prop:"leavestate",label:"状态",width:"200"},
          {prop:"approval",label:"审批人",width:"100"},
          {prop:"finall",label:"最终结果",width:"200"},
          {prop:"approver",label:"终审人",width:"100"},
          {prop:"remark",label:"备注",width:"100"},
          {prop:"user.username",label:"员工名称",width:"200"},
          
        ],
      };
        
    },
    methods:{
        //分页
        find(page=1,pageSize=5){
          let url="leave/findlhl3?page="+page+"&pageSize="+pageSize;
          this.$axios.get(url).then(resp=>{
            console.log(resp.data);
            this.pageInfo=resp.data.data;
          }).catch((ex)=>{
            
            console.log(ex);
          });
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
        updateState(row){
            console.log(row.leaveid);
            let url="leave/updateState?leaveid="+row.leaveid;
            this.$axios.get(url).then(resp=>{
            console.log(row.leaveid);
           
                this.$message.success(resp.data.message);
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
            }).catch(ex=>{});

        },
        updateState2(row){
            console.log(row.leaveid);
               console.log(this.$store.state.login.users.userRoles[0].userid);
            let approver=this.$store.state.login.users.userRoles[0].userid;
            let url="leave/updateState3?leaveid="+row.leaveid+"&approver="+approver;
            this.$axios.get(url).then(resp=>{
            console.log(row.leaveid);
           
                this.$message.success(resp.data.message);
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
            }).catch(ex=>{});

        },
        update3(){
            console.log(this.leave.leaveid);
            let url="leave/updateState3?leaveid="+this.leave.leaveid+"&remark="+this.leave.remark;
            this.$axios.get(url).then(resp=>{
            console.log(222);
            this.tag=false;
                this.$message.success(resp.data.message);
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
            }).catch(ex=>{});

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