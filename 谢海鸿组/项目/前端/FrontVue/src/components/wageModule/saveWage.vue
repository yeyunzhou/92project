<template>
    <div>
        <el-table-column type="selection" width="55"> </el-table-column>
        <el-table :data="pageInfo.list" border style="width: 100%" stripe @sort-change="changeSort"
        :default-sort = "{prop: 'wageId', order: 'descending'}" ref="multipleTable">
          <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label" 
          :width="item.width"> 
          </el-table-column>
        </el-table>

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
      return {page:1,
        pageInfo:{},
        beginDate:'',
        endDate:'',
        props:[
          {prop:"user.username",label:"姓名",width:"100"},
          {prop:"dept.deptname",label:"部门",width:"100"},
          {prop:"user.basepay",label:"基本工资",width:"100"},
          {prop:"welfare.subsidy",label:"餐补",width:"100"},
          {prop:"welfare.carallwance",label:"车补",width:"100"},
          {prop:"welfare.housingsubsidy",label:"房补",width:"100"},
          {prop:"welfare.medicalinsurance",label:"医疗保险",width:"100"},
          {prop:"welfare.endowmentinsurance",label:"养老保险",width:"100"},
          {prop:"welfare.unemploymentinsurance",label:"生育保险",width:"100"},
          {prop:"welfare.birthinsurance",label:"工伤保险",width:"100"},
          {prop:"welfare.employmentinjuryinsurance",label:"失业保险",width:"100"},
          {prop:"welfare.reservedfunds",label:"公积金",width:"100"},
          {prop:"taxes",label:"税金",width:"100"},
          {prop:"netpay",label:"应发工资",width:"100"},
          {prop:"netpayroll",label:"实发工资",width:"100"},
          {prop:"wagedateString",label:"发放时间",width:"180"},
          {prop:"userissuer.username",label:"发放人",width:"100"},
          {prop:"attendance.remark",label:"迟到",width:"100"},
          {prop:"evectionAccount.total",label:"出差",width:"100"},
          {prop:"overtim.countsal",label:"加班",width:"100"},
        ],
      };
        
    },
    methods:{
        //分页
        find(page=1,pageSize=5){
          let url="wage/pageInfoByDate?page="+page+"&pageSize="+pageSize+"&beginDate="+this.beginDate+"&endDate="+this.endDate;
          this.$axios.get(url).then(resp=>{
           
            this.pageInfo=resp.data.data;
            console.log(this.pageInfo);
          }).catch((ex)=>{
            console.log(ex);
          });
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

</style>