<template>
    <div>
        <el-button type="success" @click="approve" icon="el-icon-document-checked">一键审批</el-button>
        <el-table :data="pageInfo.list" border style="width: 100%" stripe @sort-change="changeSort"
        :default-sort = "{prop:'wageId',order:'descending'}" ref="multipleTable">
          <!--复选框-->
          <el-table-column type="selection" width="55"> </el-table-column>
          <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label" 
          :width="item.width"> 
          </el-table-column>

          <!--操作列-->
          <el-table-column  label="操作" width="150px">
          <template slot-scope="scope">
              <el-button @click="update(scope.row)" type="text" size="small" width="190px">同意</el-button>
              <el-button @click="tagShow(scope.row)" type="text" size="small" width="190px" >不同意</el-button>
          </template>
          </el-table-column>
        </el-table>

        <el-dialog
          title="备注"
          :visible.sync="tag"
          width="30%"
          :before-close="tagClose">
          <el-input type="textarea" v-model="remark"></el-input>
          <span slot="footer" class="dialog-footer">
            <el-button @click="tag = false">取 消</el-button>
            <el-button type="primary" @click="update2()">确 定</el-button>
          </span>
        </el-dialog>

        <!-- 分页 -->
        <el-pagination
            layout="total, sizes, prev, pager, next, jumper"
            :page-sizes="[3, 5, 8, 10]"
            :page-size="5"
            :total="pageInfo.total"
            @current-change="handleChangePage"
            @size-change="handleChangePageSize"
            >
        </el-pagination>
    </div>
</template>

<script>
export default {
    data() {
      return {
        id:null,
        remark:"",
        tag:false,
        page:1,
        pageInfo:{},
        props:[
          {prop:"wageid",label:"编号",width:"100"},
          {prop:"user.username",label:"姓名",width:"100"},
          {prop:"dept.deptname",label:"部门",width:"100"},
          {prop:"user.basepay",label:"基本工资",width:"100"},
          {prop:"welfare.subsidy",label:"餐补",width:"100"},
          {prop:"welfare.carallwance",label:"车补",width:"100"},
          {prop:"welfare.housingsubsidy",label:"房补",width:"100"},
          {prop:"welfare.medicallnsuranc",label:"医疗保险",width:"100"},
          {prop:"welfare.endowmentinsurance",label:"养老保险",width:"100"},
          {prop:"welfare.unemploymentinsurance",label:"生育保险",width:"100"},
          {prop:"welfare.birthinsurance",label:"工伤保险",width:"100"},
          {prop:"welfare.employmentinjuryinsurance",label:"失业保险",width:"100"},
          {prop:"welfare.reservedfunds",label:"公积金",width:"100"},
          {prop:"taxes",label:"税金",width:"100"},
          {prop:"attendance.remark",label:"迟到",width:"100"},
          {prop:"evectionAccount.total",label:"出差",width:"100"},
          {prop:"overtim.countsal",label:"加班",width:"100"},
          {prop:"leave.saltotal",label:"请假",width:"100"},
          {prop:"netpay",label:"应发工资",width:"100"},
          {prop:"netpayroll",label:"实发工资",width:"100"},
          {prop:"wagestate",label:"审核状态",width:"100"},
          {prop:"wagedateString",label:"发放时间",width:"180"},
          {prop:"issuer",label:"发放人",width:"100"},
        ],
      };
        
    },
    methods:{
      //批量发放
      approve(){
           var rows=this.$refs.multipleTable.selection;
           rows.forEach(item=>{
              console.log("1 "+item.wageid);
              let url="wage/updateState?wageid="+item.wageid;
              this.$axios.get(url).then(resp=>{
                  console.log("2 "+item.wageid);
                  this.$message.success(resp.data.message);
                  this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
              }).catch(ex=>{});
           });
      },
        //分页
        find(page=1,pageSize=5){
          let url="wage/pageInfo2?page="+page+"&pageSize="+pageSize;
          this.$axios.get(url).then(resp=>{
            console.log(resp.data);
            this.pageInfo=resp.data.data;
          }).catch((ex)=>{
            
            console.log(ex);
          });
        },
        update(row){
            console.log(row.wageid);
            let url="wage/updateState?wageid="+row.wageid;
            this.$axios.get(url).then(resp=>{
            console.log(row.wageid);

                this.$message.success(resp.data.message);
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
            }).catch(ex=>{});
        },
        tagClose(done) {
          this.$confirm('确认关闭？')
            .then(_ => {
              done();
            })
            .catch(_ => {});
        },
        tagShow(row){
            this.tag=true;
            this.id=row.wageid;
            console.log(this.id);
        },
        update2(){
            this.tag=false;
            //console.log(row.wageid);
            console.log(this.remark);
            let url="wage/updateState2?wageid="+this.id+"&remark="+this.remark;
            this.$axios.get(url).then(resp=>{
                this.$message.success(resp.data.message);
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
            }).catch(ex=>{});

        },
        handleChangePage(page){
             this.find(page,this.pageInfo.pageSize);
        },
        handleChangePageSize(pageSize){
          this.find(this.pageInfo.pageNum,pageSize);
        },

        changeSort({ column, prop, order }){
             console.group(column);
             console.log(prop);
             console.log(order); 
        },
    },
    mounted(){
      this.find();
    },
    computed:{
        host(){
            return this.$axios.defaults.baseURL;
        }
    }
}
</script>

<style scoped>
.el-table .warning-row {
    background: oldlace;
  }

  .el-table .success-row {
    background: #f0f9eb;
  }
</style>