<template>
    <div class="">
           <el-table
    :data="tableData"
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
      prop="age"
      label="年龄"
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
      prop="deptname"
      label="部门名称"
      width="100"
      :filters="deptName"
      :filter-method="filterTag"
      filter-placement="bottom-end">
      <template slot-scope="scope">
        {{scope.row.deptname}}
      </template>
    </el-table-column>

    <el-table-column
      prop="createtimeString"
      label="入职时间"
      width="200">
    </el-table-column>

    <el-table-column
    prop="istask"
      label="操作"
      width="200">
      <template slot-scope="scope">
      <el-tag v-if="scope.row.description === '董事长'" type="danger">没权限修改</el-tag>
  <el-button v-else-if=" scope.row.istask === '' " type="success"  @click="open(scope.row)" round>调整</el-button>
  <el-tag v-else type="success">存在任务</el-tag>
  <el-dialog title="人事调整" :visible.sync="dialogFormVisible" top="10px" width="50%" :close-on-click-modal="false">
  <el-form :model="form">
    <el-form-item label="姓名：" :label-width="formLabelWidth">
      <el-input v-model="form.realname" autocomplete="off" style="width:120px"></el-input>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      年龄： <el-input v-model="form.age" autocomplete="off" style="width:120px"></el-input>
    </el-form-item>
    <el-form-item label="邮箱：" :label-width="formLabelWidth">
      <el-input v-model="form.email" autocomplete="off" style="width:200px"></el-input>
    </el-form-item>
    <el-form-item label="电话：" :label-width="formLabelWidth">
      <el-input v-model="form.telephone" autocomplete="off" style="width:200px"></el-input>
    </el-form-item>
    <el-form-item label="部门：" :label-width="formLabelWidth1">
      <el-select v-model="form.deptname" placeholder="暂未分配部门">
        <el-option label="人事部" value="2"></el-option>
        <el-option label="开发部" value="3"></el-option>
        <el-option label="运维部" value="4"></el-option>
        <el-option label="测试部" value="5"></el-option>
      </el-select>
    </el-form-item>
     <el-form-item label="职位：" :label-width="formLabelWidth1">
      <el-select v-model="form.description" placeholder="暂未分配职位">
        <el-option label="员工" value="员工"></el-option>
        <el-option label="经理" value="经理"></el-option>
      </el-select>
    </el-form-item>

    <el-form-item label="性别" :label-width="formLabelWidth1">
     <el-radio v-model="form.sex" label="男">男</el-radio>
  <el-radio v-model="form.sex" label="女">女</el-radio>
    </el-form-item>
  </el-form>
  <div slot="footer" class="dialog-footer">
    <el-button @click="dialogFormVisible = false">取 消</el-button>
    <el-button type="primary" @click="yes">确 定</el-button>
  </div>
</el-dialog>

  </template>
  
    </el-table-column>
  </el-table>
    </div>

</template>

<script>
export default {
    name: "",
    data() {
        return {
        form: {},
        formLabelWidth: '120px',
        formLabelWidth1: '80px',
        formLabelWidth2: '120px',
          dialogFormVisible:false,
            currentPage1: 5,
        currentPage2: 5,
        currentPage3: 5,
        currentPage4: 4,
             tableData: [
        ],
        deptName: [],
        }
    },
    components: {
        
    },
   
    methods: {
      yes(){
        let url="admin/updateUser";
        this.$axios.post(url,this.form).then(resp=>{
          console.log(resp.data.message);
          if(resp.data.message=='操作成功'){
             this.$message({
          message: '操作成功',
          type: 'success'
        });
        this.find();
          }else{
          this.$message({
          message: '操作失败',
          type: 'warning'
        });
          }
          this.dialogFormVisible=false;
        }).catch(ex=>{
        this.$message.error('未知错误，请稍后再试');
        this.dialogFormVisible=false;
        });
      },
      open(row){
        this.form=row;
        
        this.dialogFormVisible = true;
      },
        showRoleResource(row){
            let url="admin/showRoleResource?userid="+row.userid;
            this.$axios.get(url).then(resp=>{
                this.$store.dispatch("set",{a:resp.data.data,b:row.userid});
            }).catch(ex=>{
                console.log(ex);
            });
        },

         filterTag(value, row) {
        return row.deptname === value;
      },
        find(){
            let url="admin/findUserTaskDept";
            this.$axios.get(url).then( resp=> {
                if(this.tableData.length != 0){
                    this.tableData.length=0;
                }
                console.log(resp.data);
                for(let i=0;i<resp.data.data.length;i++){
                  if(resp.data.data[i].description=='人事经理'){
                    resp.data.data[i].description='经理';
                  }
                  console.log(resp.data.data);
                    let istask='';
                    if(resp.data.data[i].tasks.length > 0){
                      istask='youzhi';
                    }
                    this.tableData.push({
                        userid:resp.data.data[i].userid,
                        realname:resp.data.data[i].realname,
                        age:resp.data.data[i].age,
                        description:resp.data.data[i].description, 
                        locked:resp.data.data[i].locked,
                        createtimeString:resp.data.data[i].createtimeString,
                        sex:resp.data.data[i].sex,
                        deptname:resp.data.data[i].department.deptname,
                        deptid:resp.data.data[i].deptid,
                        education:resp.data.data[i].education,
                        email:resp.data.data[i].email,
                        telephone:resp.data.data[i].telephone,
                        upno:resp.data.data[i].upno,
                        upnoname:resp.data.data[i].upnoname,
                        istask
                        });
            }
            for(let j=0;j<this.tableData.length;j++){
               this.deptName.push({text: this.tableData[j].deptname,value: this.tableData[j].deptname});
            }
            const res = new Map();
            let arr=this.deptName;
             this.deptName=arr.filter((arr) => !res.has(arr.text) && res.set(arr.text));
            }).catch( ex=>{
                console.log(ex);
            })
        },
        },
         mounted() {
        this.find();
    },
}
</script>

<style  scoped>

</style>
