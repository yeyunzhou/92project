<template>
    <div>
          <el-table
      :data="pageInfo.list"
      ref="singleTable"
      style="width: 100%">
      <el-table-column
        prop="cid"
        label="编号"
        width="180">
      </el-table-column>
      <el-table-column
        prop="content"
        label="投诉内容"
        width="180">
      </el-table-column>
      <el-table-column
        prop="proprietor.pname"
        label="投诉业主"
        width="180">
      </el-table-column>
       <el-table-column
       prop='startDateString'
       width="200"
        label="投诉时间">
      </el-table-column>
       <el-table-column
        prop="state"
        label="状态">
      </el-table-column>
       <el-table-column
      label="操作"
      width="200">
      <template slot-scope="scope" >
        <el-button @click="selectdate(scope.row)"   type="text" size="small">详细</el-button>
        <el-button v-if="scope.row.state=='未处理'"   @click="update(scope.row)"  type="text" size="small" >处理</el-button>
            	 <span v-else style="color:#00ff80">已处理</span>
      </template>
    </el-table-column>

    </el-table>
    
    <el-row>
      <el-col :span="5">
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :page-sizes="[6, 10, 15]"
      :page-size="pageInfo.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="pageInfo.total">
    </el-pagination>
      </el-col>
    </el-row>
  
    <el-dialog
  title="详细信息"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible"
  width="50%"
 >
         <el-form :rules="userRules" ref="userForm" label-width="100px" class="demo-ruleForm">
            <el-form-item label="编号：" prop="uname">
                <span >{{row.cid}}</span>
            </el-form-item>

             <el-form-item label="投诉内容：" prop="upwd">
                  <span >{{row.content}}</span>
            </el-form-item>
            <el-form-item label="投诉时间:" prop="upwd2">
                    <span >{{row.startDateString}}</span>
            </el-form-item>

             <el-form-item label="处理时间：" prop="sex"> 
                   <span >{{row.endDateString}}</span>
                  
            </el-form-item>


            
             <el-form-item label="处理意见：" prop="sex"> 
                   <span >{{row.opinion}}</span>
                  
            </el-form-item>

            <el-form-item label="处理人：" prop="sex"> 
                
                   <span  >{{row.employeeString}}</span>
            </el-form-item>

         </el-form>

    </el-dialog>
    <el-dialog
  title="处理投诉"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible2"
  width="50%"
 >
         <el-form :rules="userRules" ref="userForm" label-width="100px" class="demo-ruleForm">
            <el-form-item label="编号：" prop="uname">
                <span >{{row.cid}}</span>
            </el-form-item>

             <el-form-item label="投诉内容：" prop="upwd">
                  <span >{{row.content}}</span>
            </el-form-item>
            <el-form-item label="投诉时间:" prop="upwd2">
                    <span >{{row.startDateString}}</span>
            </el-form-item>
             <el-form-item label="处理意见：" prop="sex"> 
                 <el-input v-model="row.opinion" placeholder=""></el-input>
            </el-form-item>
         </el-form>
          <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible2 = false">取 消</el-button>
    <el-button type="primary" @click="update2">确 定</el-button>
  </span>

    </el-dialog>


    </div>
</template>

<script>
import axios from "axios";
export default {
    name: "",
    data() {
        return {
            dialogVisible:false,
            dialogVisible2:false,
            row:{},
  pageInfo:{
      list:{}
  }
        }
    },
    components: {},
    methods: {

          findByid(page=1,pageSize=6){
             let url="Complaint/selectAll";
              let params= new URLSearchParams();
            params.append("page",page);
            params.append("pageSize",pageSize);
            axios.post(url,params).then((response)=>{
               this.pageInfo=response.data;
               console.log( this.pageInfo);
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });
            

        },

        selectdate(row){
            this.row=row;

            console.log(row);
            this.dialogVisible=true;

        },

          handleCurrentChange(page){
          this.findByid(page,this.pageInfo.pageSize);

        },
        handleSizeChange(pageSize){
           this.findByid(this.pageInfo.page,pageSize);
        },

        update(row){
            this.row=row;
            this.dialogVisible2=true;

        },
         update2(){
              let url="Complaint/update";
              let params= new URLSearchParams();
            axios.post(url,this.row).then((response)=>{

               
              if(response.data>0){
                this.$message.success('处理成功');
                 this.dialogVisible2=false;
                this.findByid();
              }else{
                  this.$message.error('处理失败');
                this.findByid();
              }
             
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });
           
        },


    },
      mounted(  ) {
         this.findByid();
  }
}
</script>

<style  scoped>
</style>
