<template>
    <div class="">
    <span style="font-size:30px;">离 职 申 请</span>
    <br/>
    <br/>
    <br/>
<el-input
  type="textarea"
  :rows="5"
  placeholder="请输入您对公司的意见或建议。。。"
  v-model="dimission.feedback">
</el-input>
<el-row>
  <el-button type="primary" @click="dimission.feedback=''">取消</el-button>
  <el-button type="danger" @click="addDimission">确认离职</el-button>
</el-row>
    </div>
</template>

<script>
export default {
    name: "",
    data() {
        return {
            dimission:{},
           
        }
    },
    components: {},
    methods: {
        addDimission(){
            let url="admin/addDimission";
        this.$axios.post(url,this.dimission).then(resp=>{
            alert(resp.data.message);
        }).catch(ex => {
          console.log(ex);
        });
        }
    }
}
</script>

<style  scoped>
</style>