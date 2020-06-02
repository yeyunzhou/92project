<template>
    <div>
          <el-row>
        <el-col :span="5">
          <el-button type="primary" @click="insert" >添加</el-button>
          <el-button type="danger" @click="dels()">批量删除</el-button>
        </el-col>
        <el-col :span="19">
         <el-input placeholder="请输入内容" v-model="uname">
      <el-button slot="append" icon="el-icon-search" @click="sech()">搜索</el-button>
  </el-input>
        </el-col>
      </el-row>
 <el-table
      :data="pageInfo.list"
      ref="singleTable"
      style="width: 100%">
        <el-table-column
      type="selection"
      width="55">
    </el-table-column>
      <el-table-column
        prop="eid"
        label="编号"
        width="180">
      </el-table-column>
      <el-table-column
        prop="ename"
        label="姓名"
        width="180">
      </el-table-column>
      <el-table-column
        prop="age"
        label="年龄">
      </el-table-column>
       <el-table-column
        prop="sex"
        label="性别">
      </el-table-column>

       <el-table-column
      label="操作"
      width="200">
      <template slot-scope="scope" >
        <el-button @click="del(scope.row)" type="text" size="small">删除</el-button>
        <el-button @click="update(scope.row)"   type="text" size="small">编辑</el-button>
        <el-button @click="select(scope.row)"   type="text" size="small">详细</el-button>
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
  title="编辑"
  :visible.sync="dialogVisible"
  width="50%"
  :before-close="handleClose">
 <el-form  label-width="100px" class="demo-ruleForm">
             <el-form-item label="姓名：" prop="upwd">
                   <el-input v-model="row.ename"></el-input>
            </el-form-item>
            <el-form-item label="身份证号:" prop="upwd2">
                    <el-input v-model="row.identityCard"></el-input>
            </el-form-item>
             <el-form-item label="年龄:" prop="upwd2">
                 						
      <div class="gw_num">
    <em class="jian" @click="jian">-</em>
    <input type="text"  class="num"  v-model="row.age"/>
    <em class="add" @click="jia">+</em>
</div>
             </el-form-item>
<el-form-item label="性别:" prop="upwd2">
  <el-radio v-model="row.sex" label="男">男</el-radio>
  <el-radio v-model="row.sex" label="女" >女</el-radio>
 </el-form-item>
         
      
            <el-form-item label="用户名:" prop="upwd2">
                    <el-input v-model="row.userName"></el-input>
            </el-form-item>
  <el-form-item label="密码:" prop="upwd2">
                    <el-input v-model="row.pwd"  show-password ></el-input>
            </el-form-item>

         </el-form>
   
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible=false">取 消</el-button>
    <el-button type="primary" @click="update2()">确 定</el-button>
  </span>
</el-dialog>



<el-dialog
  title="添加"
  :visible.sync="dialogVisible2"
  width="50%"
  >
 <el-form  label-width="100px" class="demo-ruleForm">
             <el-form-item label="姓名：" prop="upwd">
                   <el-input v-model="row.ename"></el-input>
            </el-form-item>
            <el-form-item label="身份证号:" prop="upwd2">
                    <el-input v-model="row.identityCard"></el-input>
            </el-form-item>
         <el-form-item label="年龄:" prop="upwd2">
                 						
      <div class="gw_num">

    <em class="jian" @click="jian2">-</em>
    <input type="text"  class="num"  v-model="age"/>
    <em class="add" @click="jia2">+</em>

</div>
           </el-form-item>
<el-form-item label="性别:" prop="upwd2">
    <template>
  <el-radio v-model="sex" label="男">男</el-radio>
  <el-radio v-model="sex" label="女" >女</el-radio>
    </template>
 </el-form-item>
         
 <el-form-item label="用户名:" prop="upwd2">
                    <el-input v-model="row.userName"></el-input>
 </el-form-item>
  <el-form-item label="密码:" prop="upwd2">
                    <el-input v-model="row.pwd"  show-password ></el-input>
            </el-form-item>
         </el-form>
   
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible=false">取 消</el-button>
    <el-button type="primary" @click="save()">确 定</el-button>
  </span>
</el-dialog>



<el-dialog
  title="详细"
  :visible.sync="dialogVisible3"
  width="50%"
  :before-close="handleClose">
 <el-form  label-width="100px" class="demo-ruleForm">
             <el-form-item label="姓名：" prop="upwd">
                  {{row.ename}} 
            </el-form-item>
            <el-form-item label="身份证号:" prop="upwd2">
                    {{row.identityCard}}   
            </el-form-item>
             <el-form-item label="年龄:" prop="upwd2">
                 				 {{row.age}}   		
             </el-form-item>
<el-form-item label="性别:" prop="upwd2">
    {{row.sex}}   	
 </el-form-item>
            <el-form-item label="用户名:" prop="upwd2">
                 {{row.userName}}  
            </el-form-item>

         </el-form>
   
  <span slot="footer" class="dialog-footer">
   <el-button @click="dialogVisible3=false">取 消</el-button>
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
            uname:null,
            dialogVisible:false,
            dialogVisible2:false,
            dialogVisible3:false,
            age:18,
            sex:'男',
            row:{},
        }
    },
    components: {},
    methods: {
   findByid(page=1,pageSize=6){
             let url="Employee/selectAll";
              let params= new URLSearchParams();
            params.append("page",page);
            params.append("pageSize",pageSize);
              if(this.uname!=""&&this.uname!=null){
                      params.append("name",this.uname);
            }
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

           sech(){
            this.findByid();
      },

      del(row){
             this.$confirm("确认删除?", "提示", {})
        .then(() => {
             let url="Employee/delete";
              let params= new URLSearchParams();
            params.append("eid",row.eid);
            axios.post(url,params).then((response)=>{
                if(response.data>0){
                this.$message.success('删除成功');
                this.findByid();
              }else{
                  this.$message.error('删除失败');
                this.findByid();
              }
             
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });

               })  .catch(() => {});
            
      },

      update(row){
          this.row=row;
          this.dialogVisible=true;
      },

      update2(){
           let url="Employee/update";
            axios.post(url,this.row).then((response)=>{
                if(response.data>0){
                this.$message.success('修改成功');
                 this.dialogVisible=false;
                this.findByid();
              }else{
                  this.$message.error('修改失败');
                this.findByid();
              }
             
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });

      },


       jia(){
          if(this.row.age>99){
            this.row.age=100;

          }else{
              this.row.age++;
             
          }

        },
        jian(){

          if(this.row.age<=1){
            this.row.age=1;

          }else{
              this.row.age--;
             
             
          }

        },

        jia2(){
          if(this.age>99){
            this.age=100;

          }else{
              this.age++;
             
          }

        },
        jian2(){

          if(this.age<=1){
            this.age=1;

          }else{
              this.age--;
             
             
          }

        },

        insert(){
            this.row={};
            this.dialogVisible2=true;
        },
        save(){
            this.row.age=this.age;
            this.row.sex=this.sex;
             let url="Employee/save";
            axios.post(url,this.row).then((response)=>{
                if(response.data>0){
                this.$message.success('添加成功');
                 this.dialogVisible2=false;
                this.findByid();
              }else{
                  this.$message.error('添加失败');
                   this.dialogVisible2=false;
                this.findByid();
              }
             
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });


        },

        dels(){

             this.$confirm("确认删除?", "提示", {})
        .then(() => {
          var rows=this.$refs.singleTable.selection;
           rows.forEach(row => {
            let url="Employee/delete";
              let params= new URLSearchParams();
            params.append("eid",row.eid);
            axios.post(url,params).then((response)=>{
                if(response.data>0){
                this.$message.success('删除成功');
                this.findByid();
              }else{
                  this.$message.error('删除失败');
                this.findByid();
              }
             
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });

               })  .catch(() => {});
          });

        },

        select(row){
         this.row=row;
          this.dialogVisible3=true;
        }



    },
 

      mounted(  ) {
         this.findByid();
    
  }



}
</script>

<style  scoped>



.gw_num{

            border: 1px solid #dbdbdb;

            width: 110px;line-height: 35px;

            overflow: hidden;

        }

        .gw_num em{display: block;

            height: 35px;

            width: 31px;

            float: left;

            color: #7A7979;

            border-right: 1px solid #dbdbdb;

            text-align: center;

            cursor: pointer;

            font-style:normal;

        }

        .gw_num .num{display: block;

            float: left;

            text-align: center;

            width: 42px;

            font-style: normal;

            font-size: 14px;

            line-height: 35px;

            border: 0;

        }

        .gw_num em.add{

            float: right;

            border-right: 0;

            border-left: 1px solid #dbdbdb;

        }

</style>
