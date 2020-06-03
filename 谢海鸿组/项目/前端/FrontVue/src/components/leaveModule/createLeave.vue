<template>
    <div class="">
        <form>
           
          <el-row>
            <el-col :span="3" class="font1">请假类型</el-col>
            <el-col :span="10">
              <el-input v-model="leave.leavereason" ></el-input>
            </el-col>
          </el-row>
        <el-row>
          <el-col :span="3" class="font1">开始时间</el-col>
          <el-col :span="10">
          <el-col :span="10">
            <el-date-picker
            v-model="leave.leavetime"
            type="date"
            placeholder="选择日期"
            value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-col>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="3" class="font1">结束时间</el-col>
          <el-col :span="10">
          <el-col :span="10">
            <el-date-picker
            v-model="leave.stopleave"
            type="date"
            placeholder="选择日期"
            value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-col>
          </el-col>
        </el-row>
         <el-row>
        <el-col :span="3" class="font1">内容：</el-col>
        <el-col :span="10">
          <el-input
            type="textarea"
            placeholder="请输入内容"
            v-model="leave.context"
            :autosize="{ minRows: 2, maxRows: 8}"
          ></el-input>
        </el-col>
      </el-row>
       <el-row>
            <el-col :span="3" class="font1">请假天数</el-col>
            <el-col :span="10">
              <el-input v-model="leave.duration" ></el-input>
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
            leave:{},
            user:{},
        }
    },
    components: {},
  methods: {
      save(){
         console.log(this.leave);
      let url ="leave/save";
      this.$axios.post(url,this.leave).then(resp => {
          this.$store.state.returnMessage = resp.data.data;
          this.$message.success(resp.data.message);
          this.leave={};
        })
        .catch(ex => {
          console.log(ex);
        });
        
      },
  }
};
</script>
<style  scoped>
</style>

