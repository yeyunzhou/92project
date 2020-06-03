<template>
    <div>
        <el-table :data="pageInfo.list" border style="width: 100%" stripe @sort-change="changeSort"
        :default-sort = "{prop:'evectionid',order:'descending'}" ref="multipleTable">
          <el-table-column v-for="item in props" :key="item.prop" :prop="item.prop" :label="item.label" 
          :width="item.width"> 
          </el-table-column>

           <!--操作列-->
          <el-table-column  label="操作" width="150px">
          <template slot-scope="scope">

              <el-button @click="updateState(scope.row)" type="text" size="small" width="190px">同意</el-button>
              <el-button @click="tagShow(scope.row)" type="text" size="small" width="190px" >驳回</el-button>
          </template>
          </el-table-column>
        </el-table>

        
  <el-dialog title="重新修改" :visible.sync="tag" width="50%" :before-close="tagCloce" :close-on-click-modal="false">
      <el-row>
        <el-col :span="3" class="font1">驳回原因：</el-col>
        <el-col :span="10">
          <el-input
            type="textarea"
            placeholder="请输入内容"
            v-model="evection.remark"
            :autosize="{ minRows: 2, maxRows: 8}"
          ></el-input>
        </el-col>
      </el-row>
          <span slot="footer" class="dialog-footer">1
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
        evection:{},
        page:1,
        pageInfo:{},
        props:[
           {prop:"evectionid",label:"编号",width:"100"},
          {prop:"userid",label:"员工编号",width:"100"},
          {prop:"evectiondate",label:"开始出差时间",width:"100"},
          {prop:"evectionaddress",label:"出差地点",width:"200"},
          {prop:"evectionreason",label:"原因",width:"200"},
          {prop:"stoPevection",label:"出差结束时间",width:"200"},
          {prop:"evectionstate",label:"状态",width:"200"},
          {prop:"approver",label:"审批人",width:"100"},
          {prop:"remark",label:"备注",width:"100"},
          {prop:"user.username",label:"员工名称",width:"200"},
        ],
      };
        
    },
    methods:{
        //分页
        find(page=1,pageSize=5){
          let url="evection/findAal2?page="+page+"&pageSize="+pageSize;
          this.$axios.get(url).then(resp=>{
            console.log(resp.data);
            this.pageInfo=resp.data.data;
          }).catch((ex)=>{
            
            console.log(ex);
          });
        },

        // exportTable(){
        //   let url="excel/export";
        //   this.$axios({
        //       url: url,//获取文件流的接口路径
        //       method: 'post',
        //       data: {//请求参数
        //       "wageid":"13"
        //       },
        //       responseType: 'blob' // 表明返回服务器返回的数据类型 很重要！！
        //   }).then((res) => {
        //       //将文件流转成blob形式
        //       const blob = new Blob([res.data],{type: 'application/vnd.ms-excel'});
        //       let filename ='1.xls';
        //       //创建一个超链接，将文件流赋进去，然后实现这个超链接的单击事件
        //       const elink = document.createElement('a');
        //       elink.download = filename;
        //       elink.style.display = 'none';
        //       elink.href = URL.createObjectURL(blob);
        //       document.body.appendChild(elink);
        //       elink.click();
        //       URL.revokeObjectURL(elink.href); // 释放URL 对象
        //       document.body.removeChild(elink);
        //   }).catch(error => {
        //       this.$message.error('导出失败');
        //       // console.log(error)
        //   })
        // },
  tagShow(row){
            this.evection=row
            this.tag=true;
        },
         tagCloce(done){
          this.$confirm('确认关闭')
          .then(_ => {
            done();
          })
          .catch(_ => {});
        },
        updateState(row){
            console.log(row.evectionid);
            let url="evection/updateState?evectionid="+row.evectionid;
            this.$axios.get(url).then(resp=>{
            console.log(row.evectionid);
                this.$message.success(resp.data.message);
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
            }).catch(ex=>{});

        },
        updateState2(row){
            console.log(row.evectionid);
               console.log(this.$store.state.login.users.userRoles[0].userid);
            let approver=this.$store.state.login.users.userRoles[0].userid;
            let url="evection/updateState3?evectionid="+row.evectionid+"&approver="+approver;
            this.$axios.get(url).then(resp=>{
            console.log(row.leaveid);
           
                this.$message.success(resp.data.message);
                this.find(this.pageInfo.pageNum,this.pageInfo.pageSize);
            }).catch(ex=>{});

        },
        update3(){
            console.log(this.evection.evectionid);
            let url="evection/updateState3?evectionid="+this.evection.evectionid+"&remark="+this.evection.remark;
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