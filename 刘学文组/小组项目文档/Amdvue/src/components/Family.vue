<template>
    <div>
         <el-row>
        <el-col :span="3">
          <el-button type="primary" @click="insert" >添加</el-button>
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
        prop="pid"
        label="编号"
        width="180">
      </el-table-column>
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
        width="200"
        label="电话号码">
      </el-table-column>
      <el-table-column
        prop="age"
        label="年龄">
      </el-table-column>
       <el-table-column
        prop="sexString"
        label="性别">
      </el-table-column>

       <el-table-column
      label="操作"
      width="300">
      <template slot-scope="scope" >
        <el-button @click="update(scope.row)"    type="text" size="small">编辑</el-button>
        <el-button @click="deletes(scope.row)"   type="text" size="small">删除</el-button>
         <el-button @click="house(scope.row)"    type="text" size="small">房产信息</el-button>
           <el-button @click="vehicle(scope.row)"  type="text" size="small">车辆信息</el-button>
            <el-button @click="family(scope.row)"  type="text" size="small">家庭成员</el-button>
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
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible"
  width="50%"
 >
         <el-form   label-width="100px" class="demo-ruleForm">
            <el-form-item label="编号：" prop="uname">
                <span >{{row.pid}}</span>
            </el-form-item>

             <el-form-item label="姓名" prop="upwd">
                <el-input v-model="row.pname" placeholder=""></el-input>
            </el-form-item>
            <el-form-item label="身份证号:" prop="upwd2">
                     <el-input v-model="row.identityCard" placeholder=""></el-input>
            </el-form-item>

             <el-form-item label="性别："> 
                  <el-radio v-model="row.sexString" label="男">男</el-radio>
                  <el-radio v-model="row.sexString" label="女">女</el-radio>
            </el-form-item>
              <el-form-item label="年龄:" prop="upwd2">
                 						
      <div class="gw_num">
    <em class="jian" @click="jian">-</em>
    <input type="text"  class="num"  v-model="row.age"/>
    <em class="add" @click="jia">+</em>
</div>
             </el-form-item>

         </el-form>
      <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible = false">取 消</el-button>
    <el-button type="primary" @click="update2">确 定</el-button>
  </span>

    </el-dialog>

  <el-dialog
  title="添加"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible2"
  width="50%"
 >
         <el-form   label-width="100px" class="demo-ruleForm">
             <el-form-item label="姓名" prop="upwd">
                <el-input v-model="row.pname" placeholder=""></el-input>
            </el-form-item>
            <el-form-item label="身份证号:" prop="upwd2">
                     <el-input v-model="row.identityCard" placeholder=""></el-input>
            </el-form-item>
             <el-form-item label="电话号码:" prop="upwd2">
                     <el-input v-model="row.phone" placeholder=""></el-input>
            </el-form-item>

             <el-form-item label="性别：" prop="sex"> 
                  <el-radio v-model="sex" label="0">男</el-radio>
                  <el-radio v-model="sex" label="1" >女</el-radio>
            </el-form-item>
              <el-form-item label="年龄:" prop="upwd2">
                 						
      <div class="gw_num">
    <em class="jian" @click="jian2">-</em>
    <input type="text"  class="num"  v-model="age"/>
    <em class="add" @click="jia2">+</em>
</div>
             </el-form-item>

         </el-form>
      <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible2 = false">取 消</el-button>
    <el-button type="primary" @click="save">确 定</el-button>
  </span>

    </el-dialog>



<el-dialog
  title="房产信息"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible3"
  width="80%"
 >
 <el-table
      :data="pageInfo2"
      ref="singleTable"
      style="width: 100%">
       
      <el-table-column
        prop="hid"
        label="编号"
        width="180">
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
    </el-table>
         

    </el-dialog>



  <el-dialog
  title="车辆信息"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible5"
  width="80%"
 >

  <el-row>
         <el-col :span="5">
          <el-button type="primary" @click="insert2" >添加车辆</el-button>
        </el-col>
      </el-row>

 <el-table
      :data="vehicleInfo"
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
    <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible5 = false">取 消</el-button>
  </span>
   
  </el-dialog>


<el-dialog
  title="编辑"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible6"
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
    <el-button @click="dialogVisible6 = false">取 消</el-button>
    <el-button type="primary" @click="update3">确 定</el-button>
  </span>
   
</el-dialog>


<el-dialog
  title="添加车辆"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible7"
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
    <el-button @click="dialogVisible7= false">取 消</el-button>
    <el-button type="primary" @click="save2">确 定</el-button>
  </span>
   
</el-dialog>


<el-dialog
  title="家庭成员"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible8"
  width="80%"
 >
          <el-row>
         <el-col :span="5">
          <el-button type="primary" @click="save3" >添加</el-button>
        </el-col>
      </el-row>
<el-table
      :data="FamilypageInfo"
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
        <el-button @click="updated4(scope.row)"   type="text" size="small">编辑</el-button>
           <el-button @click="deletes4(scope.row)"   type="text" size="small">删除</el-button>
        
      </template>
    </el-table-column>
     
    </el-table>
</el-dialog>



 <el-dialog
  title="添加"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible9"
  width="60%"
 >
  <el-form  label-width="100px" class="demo-ruleForm">
             <el-form-item label="姓名：" prop="upwd">
                   <el-input v-model="familyrow.fname"></el-input>
            </el-form-item>
            <el-form-item label="身份证号:" prop="upwd2">
                    <el-input v-model="familyrow.identityCard"></el-input>
            </el-form-item>
             <el-form-item label="年龄:" prop="upwd2">
      <div class="gw_num">

    <em class="jian" @click="jian3">-</em>
    <input type="text"  class="num"  v-model="familyrowage"/>
    <em class="add" @click="jia3">+</em>

</div>
           </el-form-item>
                   <el-form-item label="关系:" prop="upwd2">
                    <el-input v-model="familyrow.relation"></el-input>  
            </el-form-item>
       <el-form-item label="性别:" prop="upwd2">
  <el-radio v-model="familysex" label="男">男</el-radio>
  <el-radio v-model="familysex" label="女" >女</el-radio>
 </el-form-item>


         </el-form>
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible9= false">取 消</el-button>
    <el-button type="primary" @click="insert3">确 定</el-button>
  </span>
   
   
</el-dialog>

 <el-dialog
  title="编辑"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible10"
  width="60%"
 >
  <el-form  label-width="100px" class="demo-ruleForm">
            <el-form-item label="编号：" prop="uname">
              <span> {{familyrow.fid}} </span> 
            </el-form-item>
             <el-form-item label="姓名：" prop="upwd">
                   <el-input v-model="familyrow.fname"></el-input>
            </el-form-item>
            <el-form-item label="身份证号:" prop="upwd2">
                    <el-input v-model="familyrow.identityCard"></el-input>
            </el-form-item>
             <el-form-item label="年龄:" prop="upwd2">
                 						
     <div class="gw_num">

    <em class="jian" @click="jian4">-</em>
    <input type="text"  class="num"  v-model="familyrow.age"/>
    <em class="add" @click="jia4">+</em>

</div>
            </el-form-item>
                   <el-form-item label="关系:" prop="upwd2">
                    <el-input v-model="familyrow.relation"></el-input>  
            </el-form-item>
       <el-form-item label="性别:" prop="upwd2">
  <el-radio v-model="familyrow.sex" label="男">男</el-radio>
  <el-radio v-model="familyrow.sex" label="女" >女</el-radio>
 </el-form-item>


         </el-form>
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible10= false">取 消</el-button>
    <el-button type="primary" @click="updates4">确 定</el-button>
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
            familyrow:{},
            pageInfo2:{

            },
            vehicleInfo:{},
            House:{

              list:{}
            },
            uname:null,
            dialogVisible:false,
            dialogVisible2:false,
            dialogVisible3:false,
            dialogVisible4:false,
            dialogVisible5:false,
            dialogVisible6:false,
            dialogVisible7:false,
              dialogVisible8:false,
              dialogVisible9:false,
              dialogVisible10:false,
            FamilypageInfo:{},
            familyrowage:18,
            pid:'',
            sex:'0',
            familysex:'男',
            age:18,
            row:{},
        }
    },
    components: {},
    methods: {
         findByid(page=1,pageSize=6){
             let url="Proprietor/SelectAll";
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

        update(row){
          this.sex=row.sex;
           console.log(this.sex);
            this.row=row;
            this.dialogVisible=true;
        },

        sech(){
            this.findByid();
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
         jia3(){
          if(this.familyrowage>99){
            this.familyrowage=100;

          }else{
              this.familyrowage++;
             
          }

        },
        jian3(){

          if(this.familyrowage<=1){
            this.familyrowage=1;

          }else{
              this.familyrowage--;
             
             
          }

        },

        jia4(){
          if(this.familyrow.age>99){
            this.familyrow.age=100;

          }else{
              this.familyrow.age++;
             
          }

        },
        jian4(){

          if(this.familyrow.age<=1){
            this.familyrow.age=1;

          }else{
              this.familyrow.age--;
             
             
          }

        },
        update2(){
          if(this.row.sexString=="男"){

               this.row.sex=0;
          }else{
            this.row.sex=1;
          }
           let url="Proprietor/update";
            axios.post(url,this.row).then((response)=>{
               this.pageInfo=response.data;
           if(response.data>0){
                 this.dialogVisible=false;
                   this.$message.success('修改成功');
                this.findByid(this.pageInfo.page,this.pageInfo.pageSize);
              }else{
                  this.$message.error('修改失败');
                this.findByid();
              }

              
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });

        },

        insert(){

          this.row={};
          this.dialogVisible2=true;
          
        },

        save(){

              this.row.age=this.age;
              this.row.sex=this.sex;
          let url="Proprietor/Save";
            axios.post(url,this.row).then((response)=>{
               this.pageInfo=response.data;
           if(response.data>0){
                this.$message.success('添加成功');
                 this.dialogVisible2=false;
                this.findByid();
              }else{
                  this.$message.error('添加失败');
               //his.findByid(this.pageInfo.page,this.pageInfo.pageSize);
                this.findByid();
                 this.row={};
              }

              
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });

        },




        deletes(row){
              let url="Proprietor/delete";
         let params= new URLSearchParams();
            params.append("id",row.pid);
            axios.post(url,params).then((response)=>{
               this.pageInfo=response.data;
           if(response.data>0){
                this.$message.success('删除成功');
                 this.dialogVisible=false;
                this.findByid();
              }else{
                  this.$message.error('您不能删除这个业主');
               //his.findByid(this.pageInfo.page,this.pageInfo.pageSize);
                  this.findByid();
              }

              
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });

        },

        house(row){

           let url="House/housepid";
              let params= new URLSearchParams();
            params.append("pid",row.pid);
            axios.post(url,params).then((response)=>{
              this.dialogVisible3=true;
               this.pageInfo2=response.data;
        
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });

          

        },
        vehicle(row){
              this.pid=row.pid;
              this.dialogVisible5=true;
             this.vehicleselect();
              

        },

        vehicleselect(){
           let url="Vehicle/selectVehicle";
              let params= new URLSearchParams();
            params.append("pid",this.pid);
            axios.post(url,params).then((response)=>{
               this.vehicleInfo=response.data;
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });


        },


         updated(row){
       this.row=row;
       this.dialogVisible6=true;

        },

          update3(){
           let url="Vehicle/update";
             this.$axios.post(url,this.row).then(resp=>{
                 if(resp.data>0){
                    this.$message.success("修改成功");
                    this.dialogVisible6=false;
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
                     this.vehicleselect();
                 }
             }).catch(ex=>{});

         
        })
        .catch(() => {});

      
      },



       insert2(){
         this.row={};
         this.dialogVisible7=true;

      },

      save2(){
         let url="Vehicle/save2";
           this.row.pid=this.pid;
             this.$axios.post(url,this.row).then(resp=>{
                 if(resp.data>0){
                    this.$message.success("添加成功");
                    this.dialogVisible7=false;
                      this.vehicleselect();
                 }
             }).catch(ex=>{});

      },

      family(row){
        this.pid=row.pid;
       this.familyselect();

      },

      familyselect(){
         let url="Family/finBypid2?pid="+this.pid;
            axios.post(url).then((response)=>{
               this.FamilypageInfo=response.data;
               this.dialogVisible8=true;
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });

      },

        save3(){
        this.dialogVisible9=true;
        this.familyrow={};
        this.familyrowage=18;
      },
      insert3(){
        console.log(this.row);
        this.familyrow.sex=this.familysex;
          this.familyrow.age=this.familyrowage;
          this.familyrow.pid=this.pid;
             let url="Family/save2";
             this.$axios.post(url,this.familyrow).then(resp=>{
                console.log(resp.date);
                 if(resp.data>0){
                    this.dialogVisible9=false;
                   this.$message.success("添加成功");
                    this.familyselect();
                 }
             }).catch(ex=>{});

      },
      deletes4(row){
           this.$confirm("确认删除?", "提示", {})
        .then(() => {
         let params= new URLSearchParams();
            params.append("id",row.fid);
         let url="Family/delete";
             this.$axios.post(url,params).then(resp=>{
                console.log(resp.date);
                 if(resp.data>0){
                       this.$message.success("删除成功");
                       this.familyselect();
                 }
             }).catch(ex=>{});

               }).catch(ex=>{});

      },

      updated4(row){
          this.dialogVisible10=true;
          this.familyrow=row;
        },

         updates4(){
           console.log(this.row);
             let url="Family/update";
             this.$axios.post(url,this.familyrow).then(resp=>{
                console.log(resp.date);
                 if(resp.data>0){
                    this.dialogVisible10=false;
                       this.$message.success("修改成功");
                       this.familyselect();
                 }
             }).catch(ex=>{});
      },

     


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
