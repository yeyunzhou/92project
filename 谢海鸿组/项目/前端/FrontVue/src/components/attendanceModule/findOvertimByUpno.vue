<template>
  <div class>
    <el-table
      ref="multipleTable"
      :data="pageInfo.list"
      style="width: 100%"
      stripe
      border
      :default-sort="{prop: 'date', order: 'ascending'}"
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
          <el-button @click="findOvertimByKey(scope.row)" type="text" size="small">详细信息</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      layout="prev, pager, next, jumper"
      :page-size="5"
      :total="pageInfo.total"
      @current-change="handleChangePage"
      @size-change="handleChangePageSize"
    ></el-pagination>

    <el-dialog title="申请详细信息" :visible.sync="findOvertimById" width="40%" :before-close="handleClose">
      
        <el-row>          
          <el-col :span="4" class="font1">编号：</el-col>
          <el-col :span="10">
            {{overtim.overtimid}}
          </el-col>
        </el-row>
      <el-row>
        <el-col :span="4" class="font1">申请原因：</el-col>
        <el-col :span="10">{{overtim.overtimreason}}</el-col>
      </el-row>

      
        <el-table-column label=""></el-table-column>
      <span slot="footer" class="dialog-footer">
        <el-button @click="findOvertimById = false">退 出</el-button>
        <el-button type="primary" @click="updateOvertimByUpnoPage = true">审批处理</el-button>
      </span>
    </el-dialog>

    
    <el-dialog title="审批处理" :visible.sync="updateOvertimByUpnoPage" width="40%" :before-close="handleCloseByUpno">
      <el-form :model="overtimByUpno">
        <el-form-item label="活动区域" :label-width="formLabelWidth">
          <el-select v-model="form.overtimstate" placeholder="审批结果">
            <el-option label="同意" value="同意"></el-option>
            <el-option label="需修改" value="需修改"></el-option>
            <el-option label="不同意" value="不同意"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="审批建议" :label-width="formLabelWidth">
          <el-input v-model="form.overtimreason" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>

      
        <el-table-column label=""></el-table-column>
      <span slot="footer" class="dialog-footer">
        <el-button @click="handleCloseByUpno">退 出</el-button>
        <el-button type="primary" @click="updateOvertimByUpno">提 交</el-button>
      </span>
    </el-dialog>
  </div>
</template>


<script>
export default {
  name: "",
  data() {
    return {
      page: 1,
      pageInfo: {},
      overtimDto: {},
      overtim: {},
      findOvertimById: false,
      updateOvertimByUpnoPage:false,
      props: [
        { prop: "user.realname", label: "申请人", widht: "100" },
        { prop: "overtimedatedString", label: "申请时间", widht: "200" },
        { prop: "overtimtype", label: "申请状态", widht: "100" },
      ],
      form: {
        },
        formLabelWidth: '120px',
    };
  },
  components: {},
  methods: {
    //分页查询
    findOvertimByUpno(page = 1, pageSize = 6) {
      let url = "overtim/findOvertimByUpno";
      this.overtimDto.upno = this.$store.state.login.users.userid;
      this.overtimDto.page = page;
      this.overtimDto.pageSize = pageSize;
      this.$axios
        .post(url, this.overtimDto)
        .then(resp => {
          this.pageInfo = resp.data.data;
          console.log( resp.data.data);
        })
        .catch(ex => {
          console.log(ex);
        });
    },
    handleChangePage(page) {
      this.findOvertimByUpno(page, this.pageInfo.pageSize);
    },
    handleChangePageSize(pageSize) {
      this.findOvertimByUpno(this.pageInfo.pageNum, pageSize);
    },

    findOvertimByKey(row) {
      this.findOvertimById=true;
      this.overtim=row;
    },
    handleCloseByUpno(){
        this.$confirm('您确定要取消本次审批吗?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
            this.updateOvertimByUpnoPage=false;
          this.$message({
            type: 'success',
            message: '退出成功!'
          });
            this.form={};
        }).catch(() => {});
    },
    updateOvertimByUpno(){
      let url = "overtim/updateOvertimByUpno";
      this.form.overtimid=this.overtim.overtimid;
      this.form.approver=this.$store.state.login.users.userid;

      this.$axios.post(url,this.form).then(resp => {
        if(resp.data.data!=null){
          this.form={};          
            this.findOvertimByUpno(1,6);
          this.updateOvertimByUpnoPage=false;
          this.$message.success(resp.data.message);
        }else{          
          this.$message.success(resp.data.message);
        }
      }).catch(ex => {
        console.log(ex);
      });

    },
  },
  mounted() {
    this.findOvertimByUpno();
  }
};
</script>

<style  scoped>
</style>
