<template>
    <div>
        <el-table :data="pageInfo.list" border style="width: 100%" stripe  @sort-change="changeSort"
        :default-sort=" {prop:'evectionaccountid',order:'descending'}" ref="multipleTable" >
        <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label"
         :width="item.width">
        </el-table-column>
        </el-table>
         <!-- 分页 -->
         <el-pagination
           layout="total, sizes, prev, pager, next, jumper"
            :page-sizes="[ 5, 8, 10]"
            :page-size="3"
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
        page:1,
        pageInfo:{},
        props:[
          {prop:"evectionaccountid",label:"编号",width:"100"},
          {prop:"userid",label:"员工编号",width:"100"},
          {prop:"evectionid",label:"出差编号",width:"100"},
          {prop:"subsidy",label:"补贴",width:"200"},
          {prop:"evectiondays",label:"出差天数",width:"200"},
          {prop:"total",label:"总计",width:"200"},
          {prop:"evectionaccountstate",label:"状态",width:"200"},
          {prop:"user.username",label:"员工名称",width:"200"},
          {prop:"approver",label:"审批人",width:"100"},
        ],
      };
        
    },
    methods:{
        //分页
        find(page=1,pageSize=5){
          let url="evectionaccount/findAal?page="+page+"&pageSize="+pageSize;
          this.$axios.get(url).then(resp=>{
            console.log(resp.data.data);
            this.pageInfo=resp.data.data;
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
.el-table .warning-row {
    background: oldlace;
  }

  .el-table .success-row {
    background: #f0f9eb;
  }
</style>