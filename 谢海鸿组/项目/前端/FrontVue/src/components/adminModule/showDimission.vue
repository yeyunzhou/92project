<template>
    <div class="">
    <span style="font-size:30px;">离职人员列表</span>
     <el-table
    :data="tableData"
    ref="filterTable"
    style="width: 100%"
    highlight-current-row="true">
    <el-table-column type="expand">
      <template slot-scope="props">
        <el-form label-position="left" inline class="demo-table-expand">
          <el-form-item style="color:red;" label="离职反馈：">
            <span>{{ props.row.feedback }}</span>
          </el-form-item>
        </el-form>
      </template>
    </el-table-column>
    <el-table-column style="width:20%;"
      label="编号"
      prop="dmissionId">
    </el-table-column>
    <el-table-column
      label="申请时间"
      prop="dimDate">
    </el-table-column>
    <el-table-column
      label="姓名"
      prop="username">
    </el-table-column>
    <el-table-column
      label="职位"
      prop="position">
    </el-table-column>
    
    <el-table-column
      label="用户编号"
      prop="userid" disabled>
    </el-table-column>


     <el-table-column
      prop="existTask" 
      label="存在任务" 
      width="100" 
      :filters="[{ text: '是', value: '是' }, { text: '否', value: '否' }]" 
    :filter-method="filterTag" 
    filter-placement="bottom-end" >
        <template slot-scope="scope">
        <el-link v-if="scope.row.existTask === '是' " @click="handover(scope.row)" type="primary">需要交接</el-link>
        <span v-else type="info">否</span>
      </template>
    </el-table-column>
     <el-table-column label="操作">
     <template slot-scope="scope">
      <el-button size="mini" type="danger" @click.native.prevent="openNo(scope.$index,tableData)">驳回</el-button>
      <el-button size="mini" type="primary" v-if="scope.row.existTask === '是'" disabled >同意</el-button>
      <el-popover v-else
  placement="top"
  width="160"
  v-model="visible">
  <p>确定批准离职吗？</p>
  <div style="text-align: right; margin: 0">
    <el-button size="mini" type="text" @click="visible = false">取消</el-button>
    <el-button type="primary" size="mini" @click="yes(scope.$index,tableData)">确定</el-button>
  </div>
  <el-button size="mini" type="primary"  slot="reference">同意</el-button>
</el-popover>

     <!-- <el-button size="mini" type="primary" v-else @click.native.prevent="yes(scope.$index,tableData)">同意</el-button>-->

      </template>
    </el-table-column>
  </el-table>

  <el-dialog
        title="未交接任务"
        :visible.sync="dimHandover"
        top="10px"
        width="80%"
        :close-on-click-modal="false"
        @close="closeDialog">
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
        <div class="block">
          <el-button @click="dimHandover=false" type="primary">关 闭</el-button>
        </div>

    <el-dialog
        title="任务交接"
        :visible.sync="taskTag"
        top="10px"
        width="50%"
        append-to-body
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
            <el-button @click="taskTag = false">取 消</el-button>
            <el-button type="primary" @click="doHandover">确 定</el-button>
        </span>
        </el-dialog>
        </el-dialog>
    </div>
</template>

<script>
export default {
    name: "",
    data() {
        return {
             tableData: [
                 //{
        //   id: '12987122',
        //   name: '好滋好味鸡蛋仔',
        //   category: '江浙小吃、小吃零食',
        //   desc: '荷兰优质淡奶，奶香浓而不腻',
        //   address: '上海市普陀区真北路',
        //   shop: '王小虎夫妻店',
        //   shopId: '10333'
        // }, 
        ],
        taskTag:false,
        dimHandover:false,
        options: [],
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
        task:{},
        row:{},
        rowassociate:{},
        dmissionId:null,
        dimission:{},
        visible: false,
        }
    },
    components: {},
    methods: {
         openNo(index, rows) {
        this.$prompt('请输入驳回理由', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          inputType: 'textarea',
        }).then(({ value }) => {
            this.dimission.rejectReason=value;
          this.no(index, rows);
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '取消操作',
            duration: 1000,
          });       
        });
      },
        no(index, rows){
            this.dimission.dmissionId=rows[index].dmissionId;
             this.dimission.userid=rows[index].userid;
            let url="admin/reject";
            this.$axios.post(url,this.dimission).then(resp=>{
                if(resp.data.message=='操作成功'){
             this.$notify.success({
          title: '成功',
          message: '操作成功',
          showClose: false,
          duration: 1000,
        });
            rows.splice(index,1);
                }else{
                      this.$notify.error({
          title: '未知错误。。。',
          message: resp.data.message,
          showClose: false,
          duration: 1000,
        });
                }
            }).catch(ex => {
            console.log(ex);
            });
        },
        yes(index, rows){
            this.visible = false;
            this.dimission.dmissionId=rows[index].dmissionId;
             this.dimission.userid=rows[index].userid;
            let url="admin/ratify";
            this.$axios.post(url,this.dimission).then(resp=>{
                if(resp.data.message=='操作成功'){
             this.$notify.success({
          title: '成功',
          message: '操作成功',
          showClose: false,
          duration: 1000,
        });
            rows.splice(index,1);
                }else{
                      this.$notify.error({
          title: '未知错误。。。',
          message: resp.data.message,
          showClose: false,
          duration: 1000,
        });
                }
            }).catch(ex => {
            console.log(ex);
            });
        },
      filterTag(value,row) {
        return row.existTask === value;
      },
        find(){
            let url="admin/showDimission";
            this.$axios.get(url).then(resp=>{
              console.log(resp.data.data);
                for(let i=0;i<resp.data.data.list.length;i++){
                     this.tableData.push({dmissionId:resp.data.data.list[i].dmissionId,
                     dimDate:resp.data.data.list[i].dimDateString,
                     username:resp.data.data.list[i].user.username,
                     feedback:resp.data.data.list[i].feedback,
                     position:resp.data.data.list[i].position,
                     existTask:resp.data.data.list[i].existTask,
                     userid:resp.data.data.list[i].userid});
                }
            }).catch(ex =>{
              console.log(ex);
            });
        },
        handover(row){
          this.dimHandover=true;
          this.row=row;
          this.dmissionId=row.dmissionId;
          console.log(row.dmissionId);
          console.log(this.rowassociate.dmissionId);
          this.findTask();
        },
        findTask(){
          let userid=this.row.userid;
          let url="task/dimHandover?userid="+userid;
          this.$axios.get(url).then(resp=>{
            this.task=resp.data.data;
          }).catch((ex)=>{
            console.log(ex);
          });
        },
        withs(row){
          this.taskTag=true;
          this.rowassociate=row;
          this.findUsers();
        },
        findUsers(){
          let url="task/findUsers?userid="+this.row.userid;
          this.$axios.get(url).then(resp=>{
            this.rowassociate.executant=this.rowassociate.userid;
            this.rowassociate.userid=null;
            this.options=resp.data.data;
          }).catch((ex)=>{
            console.log(ex);
          });
        },
        doHandover(){
          let url="task/handover1";
          this.rowassociate.dmissionId=this.dmissionId;
            this.$axios.post(url,this.rowassociate).then(resp=>{
                this.taskTag=false;
                this.findTask();
                this.$message.success(resp.data.message);
            }).catch(ex=>{console.log(ex);});
        },
        //关闭弹框的事件
        closeDialog(){
           this.tableData=[];
        　this.find();
        }
    },
    mounted() {
        this.find();
    },
}
</script>
<style  scoped>
 .demo-table-expand {
    font-size: 0;
  }
  .demo-table-expand label {
    width: 90px;
    color: #99a9bf;
  }
  .demo-table-expand .el-form-item {
    margin-right: 0;
    margin-bottom: 0;
    width: 80%;
  }
</style>
