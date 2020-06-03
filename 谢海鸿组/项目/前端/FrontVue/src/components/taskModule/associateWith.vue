<template>
    <div class="">
        <el-table :data="task" border style="width: 100%" stripe 
        :default-sort = "{prop:'taskid',order:'descending'}" ref="multipleTable">
          <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label" 
          :width="item.width"> 
          </el-table-column>
          <!--操作列-->
        <el-table-column
        label="操作">
        <template slot-scope="scope">
            <el-button  @click="withs(scope.row)"
            type="button" size="small">
                任务交接
            </el-button>
        </template>
        </el-table-column>
        </el-table>

        <el-dialog
        title="任务交接"
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
          <el-col :span="3" class="font1">实施人</el-col>
          <el-col :span="10" style="text-align:left;padding-top:10px;">
            <el-select v-model="rowassociate.userid" placeholder="请选择">
              <el-option
                v-for="item in options"
                :key="item.userid"
                :label="item.realname"
                :value="item.userid">
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
          <span slot="footer" class="dialog-footer">
            <el-button @click="associateWithTag = false">取 消</el-button>
            <el-button type="primary" @click="handover">确 定</el-button>
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
        optionsTask: [
           {value: '未交接',label: '未交接'},
           {value: '已交接',label: '已交接'},
         ],
        options: [],
        rowassociate:{},
        associateWithTag:false,
        }
    },
    components: {},
    methods: {
        find(){
          let sharer=this.$store.state.login.users.userid;
          let url="task/findAssociateWith?sharer="+sharer;
          this.$axios.get(url).then(resp=>{
            this.task=resp.data.data;
          }).catch((ex)=>{
            console.log(ex);
          });
        },
        findUsers(){
          console.log(this.rowassociate);
          let url="task/findUsers?userid="+this.rowassociate.userid;
          this.$axios.get(url).then(resp=>{
            this.rowassociate.executant=this.rowassociate.userid;
            this.rowassociate.userid=null;
            this.options=resp.data.data;
          }).catch((ex)=>{
            console.log(ex);
          });
        },
        withs(row){
          this.associateWithTag=true;
          this.rowassociate=row;
          this.findUsers();
        },
        handover(){
          let url="task/handover";
            this.$axios.post(url,this.rowassociate).then(resp=>{
                this.associateWithTag=false;
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
