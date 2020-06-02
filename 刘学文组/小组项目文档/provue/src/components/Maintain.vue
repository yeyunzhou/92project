<template>
    <div>
       <el-row>
         <el-col :span="5">
          <el-button type="primary" @click="insert" >报修</el-button>
        </el-col>
      </el-row>
 <el-table
      :data="pageInfo.list"
      ref="singleTable"
      style="width: 100%">
      <el-table-column
        prop="mid"
        label="编号"
        width="180">
      </el-table-column>
      <el-table-column
        prop="house"
        label="维修房屋"
        width="180">
      </el-table-column>
       <el-table-column
        prop="specifics"
        label="维修原因"
        width="180">
      </el-table-column>
       <el-table-column
       prop='startTimeString'
        label="报修时间">
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
         <el-button v-if="scope.row.state=='未处理'"   @click="updates(scope.row)"  type="text" size="small" >编辑</el-button>
            	 <span v-else style="color:#00ff80">已结束</span>
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
  title="报修"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible2"
  width="60%"
 >
<el-form  label-width="100px" class="demo-ruleForm">
             <el-form-item label="维修原因：" prop="upwd">
                   <el-input v-model="row.specifics"></el-input>
            </el-form-item>
            <el-form-item label="维修房屋:" prop="upwd2">
                   <el-select v-model="row.house" placeholder="请选择">
    <el-option
      v-for="item in list"
      :key="item"
      :label="item"
      :value="item">
    </el-option>
   
  </el-select>
            </el-form-item>
         </el-form>
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible2= false">取 消</el-button>
    <el-button type="primary" @click="save">确 定</el-button>
  </span>
</el-dialog>



<el-dialog
  title="编辑"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible3"
  width="60%"
 >
<el-form  label-width="100px" class="demo-ruleForm">
             <el-form-item label="维修原因：" prop="upwd">
                   <el-input v-model="row.specifics"></el-input>
            </el-form-item>
            <el-form-item label="维修房屋:" prop="upwd2">
                   <el-select v-model="row.house" placeholder="请选择">
    <el-option
      v-for="item in list"
      :key="item"
      :label="item"
      :value="item">
    </el-option>
   
  </el-select>
            </el-form-item>
         </el-form>
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible3= false">取 消</el-button>
    <el-button type="primary" @click="updated">确 定</el-button>
  </span>
</el-dialog>







<el-dialog
  title="详细"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible"
  width="60%"
 >
  <el-form  label-width="100px" class="demo-ruleForm">
            <el-form-item label="编号：" prop="uname">
              <span> {{row.mid}} </span> 
            </el-form-item>

             <el-form-item label="报修时间：" prop="upwd">
                     <span> {{row.startTimeString}} </span> 
            </el-form-item>
            <el-form-item label="维修原因:" prop="upwd2">
                   <span> {{row.specifics}} </span> 
            </el-form-item>
             <el-form-item label="维修房屋:" prop="upwd2">
                   <span> {{row.house}} </span> 
            </el-form-item>

             <el-form-item label="报修时间:" prop="upwd2">
                   <span> {{row.startTimeString}} </span> 
            </el-form-item>
                <el-form-item label="处理时间:" prop="upwd2">
                   <span> {{row.endDateString}} </span> 
            </el-form-item>
           <el-form-item label="状态:" prop="upwd2">
                   <span> {{row.state}} </span> 
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
            pageInfo:null,
            dialogVisible:false,
            dialogVisible2:false,
              dialogVisible3:false,
            list:null,
            row:{},
        }
    },
    components: {},
    methods: {

         findByid(page=1,pageSize=6){
             let url="Maintain/findBypid";
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
            this.dialogVisible=true;

        },

        insert(){
             this.dialogVisible2=true;
             this.row={};
             this.findByhouseString();

        
        },
        save(){
             let url="Maintain/save";
              let params= new URLSearchParams();
            params.append("house",this.row.house);
            params.append("specifics",this.row.specifics);
            axios.post(url,params).then((response)=>{
                  this.dialogVisible2=false;
                  this.findByid();
        
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });
            

        },


        updates(row){
              this.row=row;
            this.dialogVisible3=true;
              this.findByhouseString();

        },

         updated(row){

             let url="Maintain/update";
             let params= new URLSearchParams();
            params.append("house",this.row.house);
            params.append("specifics",this.row.specifics);
              params.append("mid",this.row.mid);
            axios.post(url,params).then((response)=>{
              if(response.data>0){
                this.$message.success('修改成功');
                 this.dialogVisible3=false;
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





    findByhouseString(){
       let url="House/findByhouseString";
            axios.post(url).then((response)=>{
               console.log(response.data);
                  this.list=response.data;
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
