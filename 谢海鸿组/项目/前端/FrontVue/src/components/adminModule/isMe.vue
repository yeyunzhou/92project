<template>
    <div class="">
      <el-form :model="user" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="姓名" prop="pass">
          <el-input v-model="user.realname"  autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="pass">
          <el-input type="password" show-password  v-model="user.password" autocomplete="off"></el-input>
        </el-form-item>
         <el-form-item label="性别" prop="pass">
          <el-radio-group v-model="user.sex">
              <el-radio label="男">男</el-radio>
              <el-radio label="女">女</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="联系方式" prop="telephone">
          <el-input v-model.number="user.telephone" maxlength="11" show-word-limit ></el-input>
        </el-form-item>
        <el-form-item prop="email" label="邮箱"
          :rules="[
            { required: true, message: '请输入邮箱地址', trigger: 'blur' },
            { type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] }
          ]"
        >
          <el-input v-model="user.email"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
          <el-button @click="resetForm('ruleForm')">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
    
</template>

<script>
export default {
    name: "",
    data() {
        var checkAge = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('电话号码不能为空'));
        }
        setTimeout(() => {
          if (!Number.isInteger(value)) {
            callback(new Error('请输入数字值'));
          } else {
            if (value < 11) {
              callback(new Error('必须为11位'));
            } else {
              callback();
            }
          }
        }, 1000);
      };
      var validatePass2 = (rule, value, callback) => {
          console.log(value);
        if (value === '') {
          callback(new Error('请再次输入密码'));
        } else if (value !== this.userForm.upwd) {
          callback(new Error('两次输入密码不一致!'));
        } else {
          callback();
        }
      };
      return {
        user: {
          // realname: '',
          // password:'',
          // checkpass: '',
          // sex: '',
          // telephone:null,
          // email:''
        },
        rules: {
          password:[
                { required: true, message: '请输入密码', trigger: 'blur' },
                { min: 6, max: 12, message: '长度在 6 到 12 个字符', trigger: 'blur' }
                ],
          checkpass:[{ validator: validatePass2, trigger: 'blur' }],
          telephone: [{ validator: checkAge, trigger: 'blur' }]
        }
      };
    },
    components: {},
    methods: {
      submitForm(formName) {        
        this.$refs[formName].validate((valid) => {
          if (valid) {
            let url="admin/updateUser";
            this.$axios.post(url,this.user).then(resp=>{
                this.$message.success(resp.data.message);
                this.task={};
            }).catch(ex=>{console.log(ex);});
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      },
      },
      mounted() {
        this.user=this.$store.state.login.users;
      },
    
}
</script>

<style  scoped>
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 50px;
    height: 50px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
</style>
