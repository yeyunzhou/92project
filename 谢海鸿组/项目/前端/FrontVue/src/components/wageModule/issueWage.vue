<template>
    <div> 
        <el-button-group>       
          <el-button type="primary" icon="el-icon-document" @click="exportTable">导出</el-button>
          <el-button type="success" @click="payWages" icon="el-icon-money">一键发放</el-button>
        </el-button-group>
        <el-table :data="pageInfo.list" border style="width: 100%" stripe @sort-change="changeSort"
        :default-sort = "{prop:'wageId',order:'descending'}" ref="multipleTable">
          <!--复选框-->
          <el-table-column type="selection" width="55"> </el-table-column>
          <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label" 
          :width="item.width"> 
          </el-table-column>

          <!--操作列-->
          <el-table-column  label="操作" width="150px">
          <template slot-scope="scope"  >
              <el-button v-if="scope.row.wagestate=='已审核'" @click="update(scope.row)" type="text" size="small" width="190px">发放工资(已审批)</el-button>
              <el-tag v-else-if="scope.row.wagestate=='未审核'"  type="danger">{{scope.row.wagestate}}</el-tag>
              <el-button v-if="scope.row.wagestate=='驳回'"  type="info" @click="tagShow(scope.row)">再次申请</el-button>
          </template>
          </el-table-column> 
        </el-table>

        <el-dialog title="重新修改" :visible.sync="tag" width="50%" :before-close="tagClose" :close-on-click-modal="false">
          
          <span>驳回原因：{{wage.remark}}</span>
          <div style="margin: 20px;"></div>
        <el-row>
          <el-col :span="3" class="font1">实发工资</el-col>
          <el-col :span="16">
            <el-input v-model="wage.netpayroll" ></el-input>
          </el-col>
        </el-row>
          
          <span slot="footer" class="dialog-footer">
            <el-button @click="tag = false">取 消</el-button>
            <el-button type="primary" @click="update3">确 定</el-button>
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
        tag:false,
        wage:{},
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
          {prop:"attendance.clockinstate",label:"是否迟到",width:"100"},
          {prop:"evectionaccount.total",label:"出差",width:"100"},
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
        tagShow(row){
            console.log(row);           
            this.wage=row;
             this.tag=true;
            console.log(this.wage);
        },
      //批量发放
      payWages(){
           var rows=this.$refs.multipleTable.selection;
           rows.forEach(item=>{
              console.log(item.wageid);
              let userid=this.$store.state.login.users.userRoles[0].userid;
              let url="wage/updateWage?userid="+userid+"&wageid="+item.wageid;
              this.$axios.get(url).then(resp=>{           
                  this.$message.success(resp.data.message);
                  this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
              }).catch(ex=>{});
           });
      },
        //分页
        find(page=1,pageSize=5){
          let url="wage/pageInfo?page="+page+"&pageSize="+pageSize;
          this.$axios.get(url).then(resp=>{
            console.log(resp.data.data);
            this.pageInfo=resp.data.data;
          }).catch((ex)=>{
            
            console.log(ex);
          });
        },
        tagClose(done) {
          this.$confirm('确认关闭？')
            .then(_ => {
              done();
            })
            .catch(_ => {});
        },
        exportTable(){
          let url="excel/export";
          this.$axios({
              url: url,//获取文件流的接口路径
              method: 'post',
              responseType: 'blob' // 表明返回服务器返回的数据类型 很重要！！
          }).then((res) => {
              //将文件流转成blob形式
              const blob = new Blob([res.data]);
              let filename ='1.xls';
              //创建一个超链接，将文件流赋进去，然后实现这个超链接的单击事件
              const elink = document.createElement('a');
              elink.download = filename;
              elink.style.display = 'none';
              elink.href = URL.createObjectURL(blob);
              document.body.appendChild(elink);
              elink.click();
              URL.revokeObjectURL(elink.href); // 释放URL 对象
              document.body.removeChild(elink);
          }).catch(error => {
              this.$message.error('导出失败');
              // console.log(error)
          })
        },

        update(row){
            console.log(row.wageid);
            console.log(this.$store.state.login.users.userRoles[0].id);
            let userid=this.$store.state.login.users.userRoles[0].id;
            let url="wage/updateWage?userid="+userid+"&wageid="+row.wageid;
            this.$axios.get(url).then(resp=>{           
                this.$message.success(resp.data.message);
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
            }).catch(ex=>{});

        },
        update3(){
            let url="wage/updateState3?wageid="+this.wage.wageid+"&netpayroll="+this.wage.netpayroll;
            this.$axios.get(url).then(resp=>{
            console.log(222);
            this.tag=false;
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