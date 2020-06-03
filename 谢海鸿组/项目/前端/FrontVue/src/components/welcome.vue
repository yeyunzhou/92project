<template>
  <div class>
    <h1>今日通告</h1>
    <el-table ref="multipleTable" :data="affiche" style="width: 100%" stripe border>
      <el-table-column
        v-for="item in props"
        :key="item.prop"
        :prop="item.prop"
        :label="item.label"
        :width="item.widht"
      ></el-table-column>
    </el-table>

    <el-button type="text" v-if="tag" @click="clockinstate" disabled="true">上班打卡</el-button>
    <el-button type="text" @click="clockoutstate = true">下班打卡</el-button>

    <el-dialog
      title="欢迎登录皇帝诏曰内部系统"
      :visible.sync="clockinstate"
      width="30%"
      :before-close="handleClose"
    >
      <h1>{{nowTime}}，上班打卡</h1>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="saveAttendance">打 卡</el-button>
      </span>
    </el-dialog>

    <el-dialog
      title="欢迎登录皇帝诏曰内部系统"
      :visible.sync="clockoutstate"
      width="30%"
      :before-close="handleClose2"
    >
      <h1>2020年5月15日/星期五，下班打卡</h1>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="updateAttendance">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      affiche:{},
      nowTime: "",
      tag:false,
      clockinstate: false,
      clockoutstate: false,
      attendance: {},
      props: [
        { prop: "title", label: "标题", widht: "300" },
        { prop: "affichecontent", label: "内容", widht: "300" },
        { prop: "user.description", label: "发布人职位", widht: "218" },
        { prop: "user.realname", label: "发布人名字", widht: "210" }
      ]
    };
  },
  components: {},
  methods: {
    //分页查询
    findAfficheByDate() {
       if (this.$store.state.login.users.userid != 1) {
      this.findAttendanceByUserId();
    }
    if (this.$store.state.login.users.userid != 2) {
      this.findAttendanceByUserId();
    }
      this.currentTime = new Date();
      let url = "affiche/findAfficheByDate";
      this.$axios
        .get(url)
        .then(resp => {
          this.affiche = resp.data.data;
          console.log(resp.data.data);
        })
        .catch(ex => {
          console.log(ex);
        });
    },

    handleClose(done) {
      this.$confirm("您今日还没上班打卡哦！");
    },
    handleClose2(done) {
      this.$confirm("下班要打卡哦！");
    },
    saveAttendance() {
      this.attendance.userid = this.$store.state.login.users.userid;
      let url = "attendance/save";
      this.$axios
        .post(url, this.attendance)
        .then(resp => {
          this.$message.success(resp.data.message);
          if (resp.data.data != null) {
            this.attendance = resp.data.data;
            this.clockinstate = false;
          }
        })
        .catch(ex => {
          console.log(ex);
        });
    },
    updateAttendance() {
      let url = "attendance/update";
      console.log(this.attendance);
      this.$axios
        .post(url, this.attendance)
        .then(resp => {
          this.$message.success(resp.data.message);
          if (resp.data.data != null) {
            this.clockoutstate = false;
          }
        })
        .catch(ex => {
          console.log(ex);
        });
    },
    findAttendanceByUserId() {
      let url =
        "attendance/findAttendanceByUserId?userid=" +
        this.$store.state.login.users.userid;
      this.$axios
        .get(url)
        .then(resp => {
          // this.$message.success(resp.data.message);
          if (resp.data.data != null) {
            this.clockinstate = false;
          } else {
            this.clockinstate = true;
            this.currentTime = new Date();
          }
        })
        .catch(ex => {
          console.log(ex);
        });
    },
    nowTimes() {
      this.timeFormate(new Date());
      //setInterval(this.nowTimes, 1000);
      //this.clear()
    },
    //显示当前时间（年月日时分秒）
    timeFormate(timeStamp) {
      let year = new Date(timeStamp).getFullYear();
      let month = new Date(timeStamp).getMonth() + 1 < 10 ? "0" + (new Date(timeStamp).getMonth() + 1) : new Date(timeStamp).getMonth() + 1;
      let date = new Date(timeStamp).getDate() < 10 ? "0" + new Date(timeStamp).getDate() : new Date(timeStamp).getDate();
      let hh = new Date(timeStamp).getHours() < 10 ? "0" + new Date(timeStamp).getHours() : new Date(timeStamp).getHours();
      let mm = new Date(timeStamp).getMinutes() < 10 ? "0" + new Date(timeStamp).getMinutes() : new Date(timeStamp).getMinutes();
      let ss = new Date(timeStamp).getSeconds() < 10 ? "0" + new Date(timeStamp).getSeconds() : new Date(timeStamp).getSeconds();
      let week = new Date(timeStamp).getDay();
      let weeks = ["日", "一", "二", "三", "四", "五", "六"];
      let getWeek = "星期" + weeks[week];
      this.nowTime = year + "年" + month + "月" + date + "日" + " " + hh + ":" + mm + ":" + ss + getWeek;
    }
  },
  mounted() {
    this.nowTimes();
   
    this.findAfficheByDate();
  }
};
</script>

<style  scoped>
</style>
