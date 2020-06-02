<template>
    <div>
       <el-row>
         <el-col :span="5">
          <el-button type="primary" @click="insert" >添加车辆</el-button>
        </el-col>
      </el-row>
 <el-table
      :data="pageInfo"
      ref="singleTable"
      style="width: 100%">
      <el-table-column
        prop="vid"
        label="编号"
        width="180">
      </el-table-column>
      <el-table-column
        prop="licencePlate"
        label="车牌号"
        width="180">
      </el-table-column>
       <el-table-column
       prop='colour'
        label="颜色">
      </el-table-column>
       <el-table-column
      label="操作"
      width="200">
      <template slot-scope="scope" >
        <el-button @click="updated(scope.row)"   type="text" size="small">编辑</el-button>
        <el-button @click="deleted(scope.row)"   type="text" size="small">删除</el-button>
      </template>
    </el-table-column>
    </el-table>

<el-dialog
  title="编辑"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible"
  width="60%"
 >

  <el-form  label-width="100px" class="demo-ruleForm">
            <el-form-item label="编号：" prop="uname">
              <span> {{row.vid}} </span> 
            </el-form-item>

             <el-form-item label="车牌号：" prop="upwd">
                   <el-input v-model="row.licencePlate"></el-input>
            </el-form-item>
            <el-form-item label="颜色:" prop="upwd2">
                    <el-input v-model="row.colour"></el-input>
            </el-form-item>
         </el-form>
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible = false">取 消</el-button>
    <el-button type="primary" @click="update2">确 定</el-button>
  </span>
   
</el-dialog>




<el-dialog
  title="添加车辆"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible2"
  width="60%"
 >
  <el-form  label-width="100px" class="demo-ruleForm">
             <el-form-item label="车牌号：" prop="upwd">
                   <el-input v-model="row.licencePlate"></el-input>
            </el-form-item>
            <el-form-item label="颜色:" prop="upwd2">
                    <el-input v-model="row.colour"></el-input>
            </el-form-item>
         </el-form>
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible2= false">取 消</el-button>
    <el-button type="primary" @click="save">确 定</el-button>
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
            pageInfo:null,
            row:{},
            dialogVisible:false,
            dialogVisible2:false,

        }
    },
    components: {},
    methods: {
   findByid(page=1,pageSize=6){
             let url="Vehicle/findBypid";
              let params= new URLSearchParams();
            params.append("page",page);
            params.append("pageSize",pageSize);
            axios.post(url,params).then((response)=>{
               this.pageInfo=response.data;
               console.log(this.pageInfo);
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });
            

        },

        updated(row){
       this.row=row;
       this.dialogVisible=true;

        },

          update2(){
           let url="Vehicle/update";
             this.$axios.post(url,this.row).then(resp=>{
                 if(resp.data>0){
                    this.$message.success("修改成功");
                    this.dialogVisible=false;
                      this.findByid();
                 }
             }).catch(ex=>{});
      },

      deleted(row){
         this.$confirm("确认删除?", "提示", {})
        .then(() => {
             let url="Vehicle/delete";
              let params= new URLSearchParams();
            params.append("id",row.vid);
             this.$axios.post(url,params).then(resp=>{
                 if(resp.data>0){
                    this.$message.success("删除成功");
                      this.findByid();
                    
                 }
             }).catch(ex=>{});

         
        })
        .catch(() => {});

      
      },

      insert(){
         this.row={};
         this.dialogVisible2=true;

      },

      save(){

         let url="Vehicle/save";
             this.$axios.post(url,this.row).then(resp=>{
                 if(resp.data>0){
                    this.$message.success("添加成功");
                    this.findByid();
                    this.dialogVisible2=false;
                 }
             }).catch(ex=>{});

      }

    },
     mounted(  ) {
         this.findByid();

         
      // this.TransactionsfindByid();
    
  }
}
</script>

<style  scoped>
</style>
