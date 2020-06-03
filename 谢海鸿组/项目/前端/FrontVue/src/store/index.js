import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex);
//何辉 人事管理
import login from './login'
//谢海鸿 任务管理
import task from './task'
//龙珊 薪资管理
import wage from './wage'
//周怡珊 考勤管理
import attendance from './attendance'
//陈良吉 公告管理 2020-05-03
import affiche from './affiche'
import evection from './evection'
import leave from './leave'
import overtim from './overtim'
//陈良吉 公告管理
import evectionaccount from './evectionaccount'


import getters from './getters'
import axios from 'axios'

import ElementUI from 'element-ui';


export default new Vuex.Store({
    getters,
state:{
    ElementUI,
    axios,
    returnMessage:"",
    app_view:sessionStorage.getItem("app_view")||'login',
    elMain:"welcome",
    set:[], //何辉---》查看权限时的显示用户所具有的权限
    userId:"",//何辉---》查看是什么人
    show:{},//何辉 ---》
},
modules:{
'login':login,
'task':task,
'wage':wage,
'attendance':attendance,
//陈良吉 2020-05-04
'affiche':affiche,
'evection':evection,
'leave':leave,
'overtim':overtim,
'evectionaccount':evectionaccount,
},

})