<template>
  <div class>
    <el-table
      ref="multipleTable"
      :data="pageInfo.list"
      style="width: 100%"      
      stripe
      border
    :default-sort = "{prop: 'date', order: 'ascending'}"
    >
      <el-table-column
        v-for="item in props"
        :key="item.prop"
        :prop="item.prop"
        :label="item.label"
        :width="item.widht"
      ></el-table-column>
      <!--操作-->
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button @click="findAfficheById(scope.row)" type="text" size="small">详细信息</el-button>
        </template>
      </el-table-column>
    </el-table>    
    <el-pagination
            layout="prev, pager, next, jumper"
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
  name: "",
  data() {
    return {
      page: 1,
      pageInfo: {},
      affiche: {},
      row: {},
      value: "",
      afficheDto:{},
      props: [
        { prop: "afficheid", label:"编号", widht: "100" },
        { prop: "title", label: "标题", widht: "300" },
        { prop: "releasetimeString", label: "日期", widht: "200" },    
      ]
    };
  },
  components: {},
  methods: {
    //分页查询
    findAffiches(page = 1, pageSize = 6) {
        
      let url ="affiche/findAffiches?page=" +page +"&pageSize=" +pageSize +"&userid="+this.$store.state.login.users.userRoles[0].userid;
      this.$axios
        .get(url)
        .then(resp => {
          this.pageInfo = resp.data.data;
          console.log("pageInfo:" + resp.data.data);
        })
        .catch(ex => {
          console.log(ex);
        });
    },
    
        handleChangePage(page){
             this.findAffiches(page,this.pageInfo.pageSize);
        },
        handleChangePageSize(pageSize){
          this.findAffiches(this.pageInfo.pageNum,pageSize);
        },
  },
  mounted() {
    this.findAffiches();
  }
};
</script>

<style  scoped>
</style>
