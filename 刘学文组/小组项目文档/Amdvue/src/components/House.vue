<template>
    <div class="">

 <el-table
      :data="pageInfo.list"
      ref="singleTable"
      style="width: 100%">
       
      <el-table-column
        prop="hid"
        label="编号"
        >
      </el-table-column>
      <el-table-column
        prop="houseString"
        label="房间"
     >
      </el-table-column>
      <el-table-column
        prop="timeString"
        label="建筑年份"
     >
      </el-table-column>
          <el-table-column
        prop="area"
        label="面积"
     >
      </el-table-column>

        <el-table-column
        prop="structure"
        label="户型"
           width="180"
        >
      </el-table-column>
       <el-table-column
        prop="proprietor.pname"
        label="业主"
        >
      </el-table-column>
        <el-table-column
        prop="state"
        label="状态"
        >
      </el-table-column>

        <el-table-column
      label="操作"
      width="200">
      <template slot-scope="scope" >
        <el-button @click="selectData(scope.row)"   type="text" size="small">详细</el-button>
        <el-button v-if="scope.row.state=='已售出'"   @click="transfer(scope.row)"  type="text" size="small" >更改业主</el-button>
        <el-button v-else   @click="binding(scope.row)"  type="text" size="small" >绑定信息</el-button>
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

<!--  
    详细
-->

 <el-dialog
  title="详细"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible"
  width="60%"
 >
  <el-form  label-width="100px" class="demo-ruleForm">

             <el-form-item label="楼层：" prop="upwd">
                     <span> {{row.houseString}} </span> 
            </el-form-item>
            <el-form-item label="建筑年份：" prop="upwd2">
                   <span> {{row.timeString}} </span> 
            </el-form-item>
             <el-form-item label="面积:" prop="upwd2">
                   <span> {{row.area}} </span> 
            </el-form-item>
             <el-form-item label="户型:" prop="upwd2">
                   <span> {{row.structure}} </span> 
            </el-form-item>
                <el-form-item label="产权:" prop="upwd2">
                   <span> {{row.propertyRight}} </span> 
            </el-form-item>
          <el-form-item label="业主:" prop="upwd2">
                   <span> {{row.proprietorString}} </span> 
            </el-form-item>
                <el-form-item label="物业费用单价:" prop="upwd2">
                   <span> {{row.price}} </span> 
            </el-form-item>
           <el-form-item label="入住时间:" prop="upwd2">
                   <span> {{row.checkTimeString}} </span> 
            </el-form-item>

            <el-form-item label="状态:" prop="upwd2">
                   <span> {{row.state}} </span> 
            </el-form-item>


         </el-form>
  
</el-dialog>


<el-dialog
  title="房屋登记"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible3"
  width="60%"
 >
  <el-form  label-width="100px" class="demo-ruleForm">

             <el-form-item label="楼层：" prop="upwd">
                 <el-input  v-model="row.houseString"  :disabled="true">
                               </el-input>
            </el-form-item>
            <el-form-item label="建筑年份：" prop="upwd2">
                      <el-input  v-model="row.timeString"  :disabled="true">
                               </el-input>
            </el-form-item>
             <el-form-item label="面积:" prop="upwd2">
                     <el-input  v-model="row.area"  :disabled="true">
                               </el-input>
            </el-form-item>
             <el-form-item label="户型:" prop="upwd2">
                     <el-input  v-model="row.structure"  :disabled="true">
                               </el-input>
            </el-form-item>
                <el-form-item label="入住时间:" prop="upwd2">
            <el-date-picker
      v-model="row.checkTime"
      type="date"
      placeholder="选择日期">
    </el-date-picker>
                 
                </el-form-item>
            <el-form-item label="业主:" prop="upwd2">
              <el-col :span="6">
                <el-input  v-model="proprietor.pname" :span="5">  </el-input>
              </el-col>
                <el-col :span="6">
                <el-button @click="binding2"   type="primary" size="small">选择</el-button>
                </el-col>
            </el-form-item>
         </el-form>

           <span slot="footer" class="dialog-footer">
    <el-button @click="cancel">取 消</el-button>
    <el-button type="primary" @click="save">确 定</el-button>
  </span>
  
</el-dialog>



  <el-dialog
  title="选择"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible2"
  width="80%"
 >
       <el-table
      :data="pageInfo2.list"
      ref="singleTable"
      style="width: 100%">
      <el-table-column
        prop="pname"
        label="姓名"
     >
      </el-table-column>
        <el-table-column
        prop="identityCard"
        label="身份证"
           width="180"
        >
      </el-table-column>
          <el-table-column
        prop="phone"
        label="电话号码">
      </el-table-column>
       <el-table-column
        prop="sexString"
        label="性别">
      </el-table-column>
       <el-table-column
      label="操作"
      width="200">
      <template slot-scope="scope" >
        <el-button @click="transfer2(scope.row)"   type="text" size="small">选择</el-button>
      </template>
    </el-table-column>
    </el-table>
    
   <el-row>
      <el-col :span="5">
    <el-pagination
      @size-change="handleSizeChange2"
      @current-change="handleCurrentChange2"
      :page-sizes="[6, 10, 15]"
      :page-size="pageInfo2.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="pageInfo2.total">
    </el-pagination>
      </el-col>
    </el-row>

    </el-dialog>
    <el-dialog
  title="选择"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible4"
  width="80%"
 >
       <el-table
      :data="pageInfo2.list"
      ref="singleTable"
      style="width: 100%">
      <el-table-column
        prop="pname"
        label="姓名"
     >
      </el-table-column>
        <el-table-column
        prop="identityCard"
        label="身份证"
           width="180"
        >
      </el-table-column>
          <el-table-column
        prop="phone"
        label="电话号码">
      </el-table-column>
       <el-table-column
        prop="sexString"
        label="性别">
      </el-table-column>
       <el-table-column
      label="操作"
      width="200">
      <template slot-scope="scope" >
        <el-button @click="transfer3(scope.row)"   type="text" size="small">选择</el-button>
      </template>
    </el-table-column>
    </el-table>
   <el-row>
      <el-col :span="5">
    <el-pagination
      @size-change="handleSizeChange2"
      @current-change="handleCurrentChange2"
      :page-sizes="[6, 10, 15]"
      :page-size="pageInfo2.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="pageInfo2.total">
    </el-pagination>
      </el-col>
    </el-row>
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
            pageInfo2:{
                list:{}
            },
            dialogVisible:false,
            dialogVisible2:false,
            dialogVisible3:false,
            dialogVisible4:false,
            ProprietorHouse:{},
            proprietor:{},
            row:{
                proprietor:{
                  pname:'',
            
                },
            }
        }
    },
    components: {},
    methods: {
     findByid(page=1,pageSize=6){
           let url="House/selectAll";
            let params= new URLSearchParams();
            params.append("page",page);
            params.append("pageSize",pageSize);
            axios.post(url,params).then((response)=>{
                 this.pageInfo=response.data;
                 console.log(response.data);
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

          handleCurrentChange2(page){
          this.findByProprietor(page,this.pageInfo2.pageSize);

        },
        handleSizeChange2(pageSize){
           this.findByProprietor(this.pageInfo2.page,pageSize);
        },
        selectData(row){
            this.row=row;
            this.dialogVisible=true;
        },

         transfer(row){
        this.ProprietorHouse.hid=row.hid;
         this.findByProprietor();
         this.dialogVisible2=true;
         },

        transfer2(row){
        this.ProprietorHouse.pid=row.pid;

          let url="House/transfer";
              let params= new URLSearchParams();
            axios.post(url,this.ProprietorHouse).then((response)=>{
                 if(response.data>0){
                     this.$message.success('转让成功');
                 this.dialogVisible2=false;
                this.findByid();
                 }
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });
         
      
         },

           transfer3(row){
        this.proprietor=row;
        this.dialogVisible4=false;
         },
         findByProprietor(page=1,pageSize=6){
               let url="Proprietor/SelectAll";
              let params= new URLSearchParams();
            params.append("page",page);
            params.append("pageSize",pageSize);
            axios.post(url,params).then((response)=>{
               this.pageInfo2=response.data;
               console.log( this.pageInfo2);
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });


         },

         binding(row){
            this.row=row;
           this.dialogVisible3=true;
          
         },

           binding2(){
             this.findByProprietor();
           this.dialogVisible4=true;
          
         },

         save(){
           this.row.proprietor=this.proprietor;
             let url="House/save";
              let params= new URLSearchParams();
            axios.post(url,this.row).then((response)=>{
                 if(response.data>0){
                     this.$message.success('绑定成功');
                 this.dialogVisible3=false;
                 this.row={};
              this.proprietor={};
                this.findByid();
                 }
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });


         },

         cancel(){
           this.row={};
           this.proprietor={};
           this.dialogVisible3=false;

         },


    },

   

    

     mounted( ) {
        this.findByid();
    
  }
}
</script>

<style  scoped>
</style>
