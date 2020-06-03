<template>
    <div class="">
        <form>
        <el-row>
          <el-col :span="3" class="font1">开始时间</el-col>
          <el-col :span="10">
          <el-col :span="10">
            <el-date-picker
            v-model="evection.evectiondate"
            type="date"
            placeholder="选择日期"
            value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-col>
          </el-col>
        </el-row>
        <el-row>
            <el-col :span="3" class="font1">出差地点</el-col>
            <el-col :span="10">
              <el-input v-model="evection.evectionaddress" ></el-input>
            </el-col>
          </el-row>
            <el-row>
            <el-col :span="3" class="font1">出差原因</el-col>
            <el-col :span="10">
              <el-input v-model="evection.evectionreason" ></el-input>
            </el-col>
          </el-row>
        <el-row>
          <el-col :span="3" class="font1">结束时间</el-col>
          <el-col :span="10">
          <el-col :span="10">
            <el-date-picker
            v-model="evection.stopevection"
            type="date"
            placeholder="选择日期"
            value-format="yyyy-MM-dd">
            </el-date-picker>
          </el-col>
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
            evection:{},
            user:{},
        }
    },
    components: {},
  methods: {
      save(){
         console.log(this.evection);
      let url ="evection/save";
      this.$axios.post(url,this.evection).then(resp => {
          this.$store.state.returnMessage = resp.data.data;
          this.$message.success(resp.data.message);
          this.evection={};
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

