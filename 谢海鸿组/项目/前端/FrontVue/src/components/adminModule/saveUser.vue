<template>
    <div class="">
   

<el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">

 <el-form-item label="用户名：" prop="username">
    <el-input type="text"  maxlength="10" show-word-limit  v-model="ruleForm.username" autocomplete="on"></el-input>
  </el-form-item>
  <el-form-item label="密码：" prop="password">
    <el-input type="password"  maxlength="10"  v-model="ruleForm.password" show-password  autocomplete="off"></el-input>
  </el-form-item>
  <el-form-item label="确认密码：" prop="checkPass">
    <el-input type="password" maxlength="10" v-model="ruleForm.checkPass" show-password  autocomplete="off"></el-input>
  </el-form-item>
  <el-form-item label="年龄：" prop="age">
    <el-input v-model.number="ruleForm.age"></el-input>
  </el-form-item>
  <el-form-item label="联系方式：" prop="telephone">
    <el-input type="text"  maxlength="11"
    onkeyup="this.value=this.value.replace(/[^\d.]/g,'');" show-word-limit  v-model="ruleForm.telephone" autocomplete="on"></el-input>
  </el-form-item>
  <el-form-item label="学历：" prop="education">
 <el-select v-model="ruleForm.education" placeholder="请选择" autocomplete="off">
    <el-option
      v-for="item in options"
      :key="item.value"
      :label="item.label"
      :value="item.value">
    </el-option>
  </el-select>
</el-form-item>
<el-form-item label="性别：">
<el-radio v-model="ruleForm.sex" label="男">男</el-radio>
  <el-radio v-model="ruleForm.sex" label="女">女</el-radio>
</el-form-item>

 <el-form-item
    prop="email"
    label="邮箱："
    :rules="[
      { required: true, message: '请输入邮箱地址', trigger: 'blur' },
      { type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] }
    ]"
  >
    <el-input v-model="ruleForm.email"></el-input>
  </el-form-item>
<el-form-item label="部门" prop="deptid">
 <el-select v-model="ruleForm.deptid" @change="cli" placeholder="请选择" autocomplete="off">
    <el-option
      v-for="item in deptOptions"
      :key="item.value"
      :label="item.label"
      :value="item.value">
    </el-option>
  </el-select>
</el-form-item>
<el-form-item label="上级" prop="upno">
 <el-select v-model="ruleForm.upno" placeholder="请选择" autocomplete="off">
    <el-option
      v-for="item in higherLevel"
      :key="item.userid"
      :label="item.realname"
      :value="item.userid">
    </el-option>
  </el-select>
</el-form-item>
<el-form-item label="地址：" prop="address" style="width: 630px;">
 <el-cascader
 style="margin-left: 0px;text-align:left;"
      size="large"
      :options="ruleForm.optionsChina"
      v-model="ruleForm.selectedOptions"
      @change="handleChange">
    </el-cascader>
    <el-input maxlength="30" v-model="ruleForm.address" style="width: 250px;" placeholder="请填写具体位置"></el-input>
</el-form-item>

<!--<el-tree
  :data="data"
  show-checkbox
  default-expand-all
  node-key="id"
  ref="tree"
  highlight-current
  :props="defaultProps">
</el-tree>

<div class="buttons">
  <el-button @click="getCheckedNodes">通过 node 获取</el-button>
  <el-button @click="getCheckedKeys">通过 key 获取</el-button>
  <el-button @click="setCheckedNodes">通过 node 设置</el-button>
  <el-button @click="setCheckedKeys">通过 key 设置</el-button>
  <el-button @click="resetChecked">清空</el-button>
</div>-->

   <el-form-item>
    <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
    <el-button @click="resetForm('ruleForm')">重置</el-button>
  </el-form-item>
</el-form>

    </div>
</template>
<script>
import { provinceAndCityData, regionData, provinceAndCityDataPlus, regionDataPlus, CodeToText, TextToCode } from 'element-china-area-data'
// 1.provinceAndCityData是省市二级联动数据（不带“全部”选项）
// 2.regionData是省市区三级联动数据（不带“全部”选项）
// 3.provinceAndCityDataPlus是省市区三级联动数据（带“全部”选项）
// 4.regionDataPlus是省市区三级联动数据（带“全部”选项）
// 5."全部"选项绑定的value是空字符串""
// 6.CodeToText是个大对象，属性是区域码，属性值是汉字 用法例如：CodeToText['110000']输出北京市
// 7.TextToCode是个大对象，属性是汉字，属性值是区域码 用法例如：TextToCode['北京市'].code输出110000,TextToCode['北京市']['市辖区'].code输出110100,TextToCode['北京市']['市辖区']['朝阳区'].code输出110105
export default {
    data() {
        var validatePass = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入密码'));
        } else {
          if (this.ruleForm.checkPass !== '') {
            this.$refs.ruleForm.validateField('checkPass');
          }
          callback();
        }
      };

       var checkAge = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('年龄不能为空'));
        }
        setTimeout(() => {
          if (!Number.isInteger(value)) {
            callback(new Error('请输入数字值'));
          } else {
            if (value < 18) {
              callback(new Error('必须年满18岁'));
            } else {
              callback();
            }
          }
        }, 1000);
      };
      var validatePass = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入密码'));
        } else {
          if (this.ruleForm.checkPass !== '') {
            this.$refs.ruleForm.validateField('checkPass');
          }
          callback();
        };
      };
      
      var validateUpno = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请选择上级'));
        } 
         callback();
      };
      var validateEducation = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请选择学历'));
        } 
         callback();
      };
      var validateDeptid = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请选择部门'));
        } 
         callback();
      };
      var validateAddress = (rule, value, callback) => {
          console.log(value);
        if (value === '' || this.province === '' || this.city==='' || this.area==='') { 
            console.log(this.province);
          callback(new Error('请选择并填入具体地址'));
        } 
         callback();
      };
      var validateUserName = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入用户名'));
        } 
         callback();
      };
      var validateTelephone = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入手机号码'));
        } 
         callback();
      };
      var validatePass2 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请再次输入密码'));
        } else if (value !== this.ruleForm.password) {
          callback(new Error('两次输入密码不一致!'));
        } else {
          callback();
        }
      };
      return {
        
        ruleForm: {
           username:'',
            password:'',
          checkPass: '',
          age: '',
          telephone:'',
          education: '',
          upno:'',
          deptid:'',
          sex:'男',
           email: '',
           optionsChina: regionDataPlus,
        selectedOptions: [],
        province:'',
        city:'',
        area:'',
        address:'',
        },
        higherLevel:[],
        deptid:null,
        options: [{
          value: '中专',
          label: '中专'
        }, {
          value: '高中',
          label: '高中'
        }, {
          value: '大专',
          label: '大专'
        }, {
          value: '本科',
          label: '本科'
        }, {
          value: '研究生',
          label: '研究生'
        }, {
          value: '硕士',
          label: '硕士'
        }, {
          value: '博士',
          label: '博士'
        }],
        deptOptions: [{
          value: 2,
          label: '人事部'
        },  {
          value: 3,
          label: '开发部'
        }, {
          value: 4,
          label: '运维部'
        },
        {
          value: 5,
          label: '测试部'
        },{
          value: 6,
          label: '财务部'
        }],
        rules: {
          upno:[
                { validator: validateUpno, trigger: 'blur' }
            ],
            deptid:[
                { validator: validateDeptid, trigger: 'blur' }
            ],
            education:[
                { validator: validateEducation, trigger: 'blur' }
            ],
            username: [
                { validator: validateUserName, trigger: 'blur' }
            ],
            telephone: [
                { validator: validateTelephone, trigger: 'blur' }
            ],
          password: [
            { validator: validatePass, trigger: 'blur' }
          ],
          checkPass: [
            { validator: validatePass2, trigger: 'blur' }
          ],
          age: [
            { validator: checkAge, trigger: 'blur' }
          ],
          address: [
              { validator: validateAddress, trigger: 'blur' }
          ],
        },
        msg:{},
         data: [
        //    {
        //   id: 3,
        //   label: '一级 3',
        //   children: [{
        //     id: 7,
        //     label: '二级 3-1'
        //   }, {
        //     id: 8,
        //     label: '二级 3-2'
        //   }]
        // }
        ],
        defaultProps: {
          children: 'children',
          label: 'label'
        }
      };

    },
    components: {},
    methods: {
      tree(){
        let url="admin/tree";
        this.$axios.get(url).then(resp=>{
          console.log(resp.data.data);
         for(let i=0;i<resp.data.data.length;i++){
           if(resp.data.data[i].pid==null){
             continue;
           }
            if(resp.data.data[i].pid==1){
              let msg={id:resp.data.data[i].id,label:resp.data.data[i].name,children:[]}
          this.data.push(msg);
            }else{
              let msg={id:resp.data.data[i].id,label:resp.data.data[i].name}
              this.data[this.data.length-1].children.push(msg);
            }
          }
        }).catch(ex => {
          console.log(ex);
        });
      },
      getCheckedNodes() {
        console.log(this.$refs.tree.getCheckedNodes());
      },
      getCheckedKeys() {
        console.log(this.$refs.tree.getCheckedKeys());
      },
      setCheckedNodes() {
        this.$refs.tree.setCheckedNodes([{
          id: 5,
          label: '二级 2-1'
        }, {
          id: 9,
          label: '三级 1-1-1'
        }]);
      },
      setCheckedKeys() {
        this.$refs.tree.setCheckedKeys([3]);
      },
      resetChecked() {
        this.$refs.tree.setCheckedKeys([]);
      },
        //三级联动
        handleChange (value) {
        this.ruleForm.province=CodeToText[value[0]];
        this.ruleForm.city=CodeToText[value[1]];
        this.ruleForm.area=CodeToText[value[2]];
      },
         submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            let url="user/save";
              this.$axios.post(url,this.ruleForm).then(resp=>{
                this.ruleForm={};
                this.$message.success(resp.data.message);
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
      cli(){
        this.findDeptMager();
      },
      findDeptMager(){
        let url="user/findDeptMager?deptid="+this.ruleForm.deptid;
          this.$axios.get(url).then(resp=>{
            console.log("---------");
            console.log(resp.data.data);
            this.higherLevel=resp.data.data;
          }).catch((ex)=>{
            console.log(ex);
          });
      },
    },
    mounted() {
    this.tree();
  },
  };
  
</script>

<style  scoped>
.el-form-item{
    width: 300px;
}
</style>
