<template>
    <div>
        <el-table :data="pageInfo.list" border style="width: 100%" stripe  @sort-change="changeSort"
        :default-sort=" {prop:'evectionid',order:'descending'}" ref="multipleTable" >
        <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label"
         :width="item.width">
          </el-table-column>
            <el-table-column  label="操作" width="150px">
          <template slot-scope="scope"  >
              <el-tag v-if="scope.row.evectionstate==null"  type="text">等待审批</el-tag>
              <el-button v-if="scope.row.evectionstate=='驳回'" @click="tagShow(scope.row)" type="text">再次申请</el-button>
              <el-tag v-else-if="scope.row.evectionstate=='同意'" type="text">申请成功</el-tag>
          </template>
          </el-table-column> 
        </el-table>
  <el-dialog title="重新修改" :visible.sync="tag" width="50%" :before-close="tagCloce" :close-on-click-modal="false">
  <el-form ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <span>驳回原因：{{evection.remark}}</span>
          <div style="margin: 20px;"></div>
         <el-row>
          <el-col :span="3" class="font1">开始时间</el-col>
          <el-col :span="10">
          <el-col :span="10">
            <el-date-picker
            v-model="evection.evectiondate"
            type="date"
            placeholder="选择日期"
            value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-col>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">出差地点</el-col>
          <el-col :span="16">
            <el-input name="pwd" v-model="evection.evectionaddress" ></el-input>
          </el-col>
        </el-row>
         <el-row>
          <el-col :span="3" class="font1">出差原因</el-col>
          <el-col :span="16">
            <el-input name="pwd" v-model="evection.evectionreason"></el-input>
          </el-col>
        </el-row>
         <el-row>
          <el-col :span="3" class="font1">结束时间</el-col>
          <el-col :span="10">
          <el-col :span="10">
            <el-date-picker
            v-model="evection.stopevection"
            type="date"
            placeholder="选择日期"
            value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-col>
          </el-col>
        </el-row>
        </el-form>
          <span slot="footer" class="dialog-footer">
            <el-button @click="tag = false">取 消</el-button>
            <el-button type="primary" @click="update">确 定</el-button>
          </span>
        </el-dialog>
         <!-- 分页 -->
         <el-pagination
           layout="total, sizes, prev, pager, next, jumper"
            :page-sizes="[ 5, 8, 10]"
            :page-size="3"
            :total="pageInfo.total"
            @current-change="handleChangePage"
            @size-change="handleChangePageSize">
              </el-pagination>
    </div>
</template>
<script>
export default {
    data() {
      return {
        tag:false,
        page:1,
        evection:{},
        pageInfo:{},
        props:[
          {prop:"evectionid",label:"编号",width:"100"},
          {prop:"userid",label:"员工编号",width:"100"},
          {prop:"EvectiondateString",label:"开始出差时间",width:"100"},
          {prop:"evectionaddress",label:"出差地点",width:"200"},
          {prop:"evectionreason",label:"原因",width:"200"},
          {prop:"StopevectionString",label:"出差结束时间",width:"200"},
          {prop:"evectionstate",label:"状态",width:"200"},
          {prop:"approver",label:"审批人",width:"100"},
          {prop:"remark",label:"备注",width:"100"},
          {prop:"user.username",label:"员工名称",width:"200"},
        ],
      };
    },
    methods:{
        //分页
        find(page=1,pageSize=5){
          let url="evection/findlhl?page="+page+"&pageSize="+pageSize;
          this.$axios.get(url).then(resp=>{
            console.log(resp.data.data);
            this.pageInfo=resp.data.data;
          }).catch((ex)=>{
            console.log(ex);
          });
        },
         tagShow(row){
            this.evection=row
            this.tag=true;
        },
         tagCloce(done){
          this.$confirm('确认关闭')
          .then(_ => {
            done();
          })
          .catch(_ => {});
        },
      update(){
            console.log(this.evection.evectionid);
            let url="evection/updatelhl2?evectionid="+this.evection.evectionid+"&evectiondate="+this.evection.evectiondate+"&evectionaddress="+this.evection.evectionaddress+"&evectionreason="+this.evection.evectionreason+"&stopevection"+this.evection.stopevection;
            this.$axios.get(url).then(resp=>{
            console.log(222);
            this.tag=false;
                this.$message.success(resp.data.message);
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
            }).catch(ex=>{});
        },
        updatelhl(row){
            console.log(row.evectionid);
            let url="evection/updateState?evectionid="+row.evectionid;
            this.$axios.get(url).then(resp=>{
            console.log(row.evectionid);
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