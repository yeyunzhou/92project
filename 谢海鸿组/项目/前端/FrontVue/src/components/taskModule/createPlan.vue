<template>
    <div class="">
        <form>
        <el-row>
          <el-col :span="3" class="font1">任务名称</el-col>
            <el-col :span="10" style="text-align:left;padding-top:10px;">
            <el-select v-model="plan.taskid" placeholder="请选择">
              <el-option
                v-for="item in options"
                :key="item.taskid"
                :label="item.taskname"
                :value="item.taskid">
              </el-option>
            </el-select>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">计划名称</el-col>
          <el-col :span="10">
            <el-input v-model="plan.planname" ></el-input>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">开始时间</el-col>
          <el-col :span="10">
          <el-col :span="10">
            <el-date-picker
            v-model="plan.begintime"
            type="date"
            placeholder="选择日期"
            value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-col>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">完成时间</el-col>
          <el-col :span="10">
          <el-col :span="10">
            <el-date-picker
            v-model="plan.endtime"
            type="date"
            placeholder="选择日期"
            value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-col>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">计划状态</el-col>
          <el-col :span="10" style="text-align:left;padding-top:10px;">
            未完成
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">计划描述</el-col>
          <el-col :span="10">
            <el-input type="textarea" v-model="plan.plandesc"></el-input>
          </el-col>
        </el-row>
        </form>
        <el-row>
          <el-col :span="10" :offset="6">
            <el-button>取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
          </el-col>
        </el-row>
    </div>
</template>

<script>
export default {
    name: "",
    data() {
        return {
            plan:{},
            user:{},
            options: [],
        }
    },
    computed:{
        host(){
            return this.$axios.defaults.baseURL;
        }
    },
    components: {},
    methods: {
        findTaskByUserid(){
          let userid=this.$store.state.login.users.userid;
          let url="task/findTaskByUserid?userid="+userid;
          this.$axios.get(url).then(resp=>{
            console.log(resp.data.data);
            this.options=resp.data.data;
            
          }).catch((ex)=>{
            console.log(ex);
          });
        },
        save(){
          let url="plan/save";
            this.$axios.post(url,this.plan).then(resp=>{
                this.$message.success(resp.data.message);
                this.plan={};
            }).catch(ex=>{console.log(ex);});
        },
    },
    mounted() {
      this.findTaskByUserid();
    },
}
</script>

<style  scoped>
  .avatar-uploader-icon, .avatar {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader-icon:hover, .avatar:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
</style>
