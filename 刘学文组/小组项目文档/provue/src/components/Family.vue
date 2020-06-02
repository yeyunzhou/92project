<template>
    <div>
         <el-row>
         <el-col :span="5">
          <el-button type="primary" @click="save" >添加</el-button>
        </el-col>
      </el-row>
 <el-table
      :data="pageInfo"
      ref="singleTable"
      style="width: 100%">
      <el-table-column
        prop="fid"
        label="编号"
        width="180">
      </el-table-column>
      <el-table-column
        prop="fname"
        label="姓名"
        width="180">
      </el-table-column>
       <el-table-column
       prop='identityCard'
        label="身份证号">
      </el-table-column>
       <el-table-column
        prop="relation"
        label="与业主关系">
      </el-table-column>
     
       <el-table-column
      label="操作"
      width="200">
      <template slot-scope="scope" >
        <el-button @click="updated(scope.row)"   type="text" size="small">编辑</el-button>
           <el-button @click="deletes(scope.row)"   type="text" size="small">删除</el-button>
        
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
              <span> {{row.fid}} </span> 
            </el-form-item>
             <el-form-item label="姓名：" prop="upwd">
                   <el-input v-model="row.fname"></el-input>
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
                   <el-form-item label="关系:" prop="upwd2">
                    <el-input v-model="row.relation"></el-input>  
            </el-form-item>
       <el-form-item label="性别:" prop="upwd2">
  <el-radio v-model="row.sex" label="男">男</el-radio>
  <el-radio v-model="row.sex" label="女" >女</el-radio>
 </el-form-item>


         </el-form>
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible = false">取 消</el-button>
    <el-button type="primary" @click="updates">确 定</el-button>
  </span>
   
</el-dialog>


    <el-dialog
  title="添加"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible2"
  width="60%"
 >
  <el-form  label-width="100px" class="demo-ruleForm">
             <el-form-item label="姓名：" prop="upwd">
                   <el-input v-model="row.fname"></el-input>
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
                   <el-form-item label="关系:" prop="upwd2">
                    <el-input v-model="row.relation"></el-input>  
            </el-form-item>
       <el-form-item label="性别:" prop="upwd2">
  <el-radio v-model="sex" label="男">男</el-radio>
  <el-radio v-model="sex" label="女" >女</el-radio>
 </el-form-item>


         </el-form>
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible2= false">取 消</el-button>
    <el-button type="primary" @click="insert">确 定</el-button>
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
            dialogVisible:null,
            dialogVisible2:null,
            sex:'男',
            row:{},
            age:1,
        }
    },
    components: {},
    methods: {

         findByid(){
             let url="Family/finBypid";
            axios.post(url).then((response)=>{
               this.pageInfo=response.data;
               console.log( this.pageInfo);
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

        updated(row){
          this.dialogVisible=true;
          this.row=row;
         

               


        },

         updates(){
           console.log(this.row);
             let url="Family/update";
             this.$axios.post(url,this.row).then(resp=>{
                console.log(resp.date);
               
                 if(resp.data>0){
                    this.dialogVisible=false;
                       this.$message.success("修改成功");
                       this.findByid();
                 }
             }).catch(ex=>{});
      },

      save(){
        this.dialogVisible2=true;
        this.row={};
         this.age=1;
       

      },
      insert(){
        console.log(this.row);
        this.row.sex=this.sex;
          this.row.age=this.age;
             let url="Family/save";
             this.$axios.post(url,this.row).then(resp=>{
                console.log(resp.date);
                 if(resp.data>0){
                    this.dialogVisible2=false;
                       this.$message.success("添加成功");
                       this.findByid();
                 }
             }).catch(ex=>{});

      },
      deletes(row){
           this.$confirm("确认删除?", "提示", {})
        .then(() => {
         let params= new URLSearchParams();
            params.append("id",row.fid);
         let url="Family/delete";
             this.$axios.post(url,params).then(resp=>{
                console.log(resp.date);
                 if(resp.data>0){
                    this.dialogVisible2=false;
                       this.$message.success("删除成功");
                       this.findByid();
                 }
             }).catch(ex=>{});

               }).catch(ex=>{});

      }
         
    },
     mounted() {
         this.findByid();
    
  },


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
