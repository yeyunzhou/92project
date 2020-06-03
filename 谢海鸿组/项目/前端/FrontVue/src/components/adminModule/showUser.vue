<template>
    <div class="">
           <el-table
    :data="pageInfo.list"
    border
    style="width: 100%"
    >
    <el-table-column
      prop="userid"
      label="员工编号"
      sortable
      width="105"
      >
    </el-table-column>
    <el-table-column
      prop="realname"
      label="姓名"
      width="100">
    </el-table-column>
    <el-table-column
      prop="sex"
      label="性别"
      width="100">
    </el-table-column>
    <el-table-column
      prop="description"
      label="职位"
      width="120">
    </el-table-column>
    <el-table-column
      prop="department.deptname"
      label="部门名称"
      width="100"
      :filters="deptName"
      :filter-method="filterTag"
      filter-placement="bottom-end">
      <template slot-scope="scope">
        {{scope.row.department.deptname}}
      </template>
    </el-table-column>

    <el-table-column
      prop="createtimeString"
      label="入职时间"
      width="200">
    </el-table-column>

    <el-table-column
      prop="locked" 
      label="状态" 
      width="200">
        <template slot-scope="scope">
 <div class="right">
    <el-tag v-if="scope.row.description === '董事长'" type="warning" >无法修改</el-tag>
    <el-tooltip v-else-if="scope.row.locked === 0" class="item" effect="dark" content="限制用户登录" placement="right-start">
      <el-button type="primary" plain size="mini" @click="xianzhi(scope.row)">登录正常</el-button>
    </el-tooltip>

    <el-tooltip v-else class="item" effect="dark" content="解除用户限制" placement="right-start">
      <el-button type="danger" plain size="mini" @click="jiechu(scope.row)">限制登录</el-button>
    </el-tooltip>
  </div>
      </template>
    </el-table-column>
    <el-table-column
      label="操作"
      width="200">
      <template slot-scope="scope">
       <el-tag v-if="scope.row.description === '董事长'" type="warning" >无法修改</el-tag>
  <el-button v-else icon="el-icon-search" type="success" size="mini" @click="showRoleResource(scope.row)" round>权限</el-button>
  </template>
    </el-table-column>
  </el-table>
   <!-- 分页 -->
        <div class="block">
        <el-pagination
            layout="total, sizes, prev, pager, next, jumper"
            :page-sizes="[3, 5, 8, 10]"
            :page-size="8"
            :total="pageInfo.total"
            @current-change="handleChangePage"
            @size-change="handleChangePageSize"
            >
        </el-pagination>
        </div>
    </div>

  

</template>

<script>
export default {
    name: "",
    data() {
        return {
          pageInfo:{},
        begindate:'',
        enddate:'',
            currentPage1: 5,
        currentPage2: 5,
        currentPage3: 5,
        currentPage4: 4,
             tableData: [
        //          {
        //   date: '2016-05-02',
        //   name: '王小虎',
        //   address: '上海市普陀区金沙江路 1518 弄'
        // }
        ],
        deptName: [],
        }
    },
    components: {
        
    },
    mounted() {
        this.find();
    },
    methods: {
        showRoleResource(row){
            let url="admin/showRoleResource?userid="+row.userid;
            this.$axios.get(url).then(resp=>{
                this.$store.dispatch("set",{a:resp.data.data,b:row.userid});
            }).catch(ex=>{
                console.log(ex);
            });
        },

        xianzhi(row){
            this.$confirm('确定限制用户登录?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
            let url="admin/updateLocked";
            this.$axios.post(url,{userid:row.userid,locked:1}).then(resp=>{
            if(resp.data.message=='操作成功'){
                this.$message({
                type: 'success',
                message: '操作成功!'
                });
                this.find();
            }else{
               this.$notify.error({
          title: '未知错误。。。',
          message: resp.data.message,
          showClose: false,
          duration: 1000,
        });
            }
            }).catch(ex=>{
            console.log(ex);
            });
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });          
        });
        },

      jiechu(row){
            this.$confirm('确定解除用户登录限制?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
            let url="admin/updateLocked";
            this.$axios.post(url,{userid:row.userid,locked:0}).then( resp=>{
            if(resp.data.message=='操作成功'){
                this.$message({
                type: 'success',
                message: '操作成功!'
                });
                this.find();
            }else{
               this.$notify.error({
          title: '未知错误。。。',
          message: resp.data.message,
          showClose: false,
          duration: 1000,
        });
            }
            }).catch(ex=>{
            console.log(ex);
            });

        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });          
        });
        },

         filterTag(value, row) {
           console.log(value);
        return row.deptname === value;
      },
        find(page=1,pageSize=8){
            let url="admin/showUser?page="+page+"&pageSize="+pageSize;
            this.$axios.get(url).then( resp=> {
              this.pageInfo=resp.data.data;

              console.log(resp.data.data);
                // if(this.tableData.length != 0){
                //     this.tableData.length=0;
                // }
            //     for(let i=0;i<resp.data.data.length;i++){
            //         this.tableData.push({
            //             userid:resp.data.data[i].userid,
            //             realname:resp.data.data[i].realname,
            //             description:resp.data.data[i].description, 
            //             locked:resp.data.data[i].locked,
            //             createtimeString:resp.data.data[i].createtimeString,
            //             sex:resp.data.data[i].sex,
            //             deptname:resp.data.data[i].department.deptname
            //             });
            // }
            for(let j=0;j<this.pageInfo.list.length;j++){
               this.deptName.push({text: this.pageInfo.list[j].department.deptname,value: this.pageInfo.list[j].department.deptname});
            }
            const res = new Map();
            let arr=this.deptName;
             this.deptName=arr.filter((arr) => !res.has(arr.text) && res.set(arr.text));
            }).catch( ex=>{
                console.log(ex);
            })
        },
        handleChangePage(page){
             this.find(page,this.pageInfo.pageSize);
        },
        handleChangePageSize(pageSize){
          this.find(this.pageInfo.pageNum,pageSize);
        },
        }
}
</script>

<style  scoped>

</style>
