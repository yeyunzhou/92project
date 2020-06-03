<template>
    <div class="">
        <div class="block" style="padding-bottom:10px">
        <el-button type="success" @click="approve" icon="el-icon-document-checked">一键审批</el-button>
        </div>
        <el-table :data="task" border style="width: 100%" stripe 
        :default-sort = "{prop:'taskid',order:'descending'}" ref="multipleTable">
          <!--复选框-->
          <el-table-column type="selection" width="55"> </el-table-column>
          <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label" 
          :width="item.width"> 
          </el-table-column>
          <!--操作列-->
        <el-table-column
        label="操作">
        <template slot-scope="scope">
            <el-button  @click="notPass(scope.row)"
            type="button" size="small">
                未通过
            </el-button>
        </template>
        </el-table-column>
        </el-table>

        <el-dialog
        title="未通过"
        :visible.sync="tag"
        top="10px"
        width="50%"
        :close-on-click-modal="false">
        <el-row>
          <el-col :span="3" class="font1">任务名称</el-col>
          <el-col :span="10">
            <el-input v-model="row.taskname" readonly ></el-input>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">原因</el-col>
          <el-col :span="10">
            <el-input type="textarea" v-model="row.reason"></el-input>
          </el-col>
        </el-row>
        <span slot="footer" class="dialog-footer">
            <el-button @click="tag = false">取 消</el-button>
            <el-button type="primary" @click="reason">确 定</el-button>
        </span>
        </el-dialog>
    </div>
</template>

<script>
export default {
    name: "",
    data() {
        return {
          task:{},
          props:[
          {prop:"taskid",label:"编号",width:"50"},
          {prop:"taskname",label:"任务名称",width:"120"},
          {prop:"user.realname",label:"实施人",width:"120"},
          {prop:"begindateString",label:"开始日期",width:"170"},
          {prop:"enddateString",label:"结束日期",width:"170"},
          {prop:"status",label:"状态",width:"80"},
        ],
        row:{},
        tag:false,
        }
    },
    components: {},
    methods: {
        find(){
          let userid=this.$store.state.login.users.userid;
          let url="task/checkTask?userid="+userid;
          this.$axios.get(url).then(resp=>{
            this.task=resp.data.data;
          }).catch((ex)=>{
            console.log(ex);
          });
        },
        //批量审核
        approve(){
            var rows=this.$refs.multipleTable.selection;
            rows.forEach(item=>{
              let url="task/updateCheck?taskid="+item.taskid;
              this.$axios.get(url).then(resp=>{
                  this.$message.success(resp.data.message);
                  this.find();
              }).catch(ex=>{console.log(ex);});
           });
        },
        //未通过
        notPass(row){
            this.tag=true;
            this.row=row;
        },
        reason(){
            let url="task/updateReason";
            this.$axios.post(url,this.row).then(resp=>{
                this.tag=false;
                this.find();
                this.$message.success(resp.data.message);
            }).catch(ex=>{console.log(ex);});
        },
    },
    mounted(){
      this.find();
    },
}
</script>

<style  scoped>
</style>
