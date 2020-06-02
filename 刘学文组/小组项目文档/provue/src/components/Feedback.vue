<template>
    <div>

        <el-row>
         <el-col :span="5">
          <el-button type="primary" @click="save()" >投诉</el-button>
        </el-col>
      </el-row>
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
       prop='startDateString'
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

         <el-form  label-width="100px" class="demo-ruleForm">
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
            title="投诉"
            :visible.sync="dialogVisible2"
            width="50%"
            center
            :close-on-click-modal="false"
            top="10"
           > 
         <el-form label-width="100px" class="demo-ruleForm">
            <el-form-item label="投诉内容：" prop="uname">
               <el-input type="textarea"  rows="5" cols="5" v-model="rows.content" ></el-input>
            </el-form-item>

            <el-form-item>
            <el-button type="primary" @click="insert">保存</el-button>
            <el-button @click="dialogVisible2=false">取消</el-button>
        </el-form-item>
         </el-form>
        </el-dialog>



      
    </div>
</template>

<script>

import axios from "axios";
export default {
    name: "",
    data() {
        return {
    pageInfo: null,
    dialogVisible:false,
    dialogVisible2:false,
    row:{
        employee:{},
    },
    rows:{

    }

        }
    },
    components: {},
    methods: {

          findByid(page=1,pageSize=6){
             let url="Complaint/findbypid";
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

        handleCurrentChange(page){
          this.findByid(page,this.pageInfo.pageSize);

        },
        handleSizeChange(pageSize){
           this.findByid(this.pageInfo.page,pageSize);
        },

        selectdate(row){
            this.row=row;

            console.log(row);
            this.dialogVisible=true;

        },
        save(){
           this.rows={},
            this.dialogVisible2=true;



        },
        insert(){
              let url="Complaint/save";
              let params= new URLSearchParams();
            params.append("content",this.rows.content);
            axios.post(url,params).then((response)=>{
                this.dialogVisible2=false;
                this.findByid();
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });


        }
    },
    mounted(  ) {
         this.findByid();
  }
}
</script>

<style  scoped>
</style>
