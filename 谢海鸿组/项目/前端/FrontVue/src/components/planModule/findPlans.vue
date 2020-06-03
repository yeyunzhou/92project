<template>
    <div>
        <el-table :data="pageInfo.list" border style="width: 100%" stripe @sort-change="changeSort"
        :default-sort = "{prop:'planid',order:'descending'}" ref="multipleTable">
          <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label" 
          :width="item.width"> 
          </el-table-column>
          <!--操作列-->
        <el-table-column
        label="操作">
        <template slot-scope="scope">
            <el-button  @click="update(scope.row)"
            type="text" size="small">
                反馈信息
            </el-button>
        </template>
        </el-table-column>
        </el-table>

        <!-- 分页 -->
        
        <div class="block">
        <el-pagination
        :page-sizes="[3, 6, 8, 10]"
        :page-size="6"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pageInfo.total"
          @current-change="handleChangePage"
          @size-change="handleChangePageSize">
        </el-pagination>
      </div>

        <!--2.修改-->
        <el-dialog
        title="反馈信息"
        :visible.sync="updateTag"
        top="10px"
        width="50%"
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
        <span slot="footer" class="dialog-footer">
            <el-button @click="updateTag = false">取 消</el-button>
            <el-button type="primary" @click="doUpdate">确 定</el-button>
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
        plan:{},
        row:{},
        props:[
          {prop:"planid",label:"编号",width:"100"},
          {prop:"task.taskname",label:"任务名称",width:"120"},
          {prop:"planname",label:"计划名称",width:"120"},
          {prop:"state",label:"计划状态",width:"100"},
          {prop:"begintimeString",label:"开始日期",width:"200"},
          {prop:"endtimeString",label:"结束日期",width:"200"},
        ],
        updateTag:false,
         options: [
           {value: '未完成',label: '未完成'},
           {value: '未反馈',label: '未反馈'},
           {value: '已反馈',label: '已反馈'},
           {value: '已完成',label: '已完成'},
         ],
        value: ''
      };
    },
    computed:{
        host(){
            return this.$axios.defaults.baseURL;
        }
    },
    methods:{
        //分页
        find(page=1,pageSize=6){
          let url="plan/findplans?page="+page+"&pageSize="+pageSize;
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
        update(row){
          if("已完成"==row.state){
                this.updateTag=false;
                this.$message.error("此计划已完成，不能再进行修改了哦");
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
              }else{
                this.updateTag=true;
                this.row=row;
              }
            // this.updateTag=true;
            // this.row=row;
        },
        doUpdate(){
            let url="plan/update";
            this.$axios.post(url,this.row).then(resp=>{
                this.updateTag=false;
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