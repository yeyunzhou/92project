import Vue from 'vue'
import Router from 'vue-router'
import login from '@/components/login'
import index from '@/components/index'
import createUser from '@/components/adminModule/createUser'
import welcome from '@/components/welcome'
import createTask from '@/components/taskModule/createTask'
import findTask from '@/components/taskModule/findTask'
import findWage from '@/components/wageModule/findWage'
import issueWage from '@/components/wageModule/issueWage'
import findWageState from '@/components/wageModule/findWageState'
import findWageByUserId from '@/components/wageModule/findWageByUserId'
import saveWage from '@/components/wageModule/saveWage'
import findAffiches from '@/components/affiche/findAffiches'
import selectOvertim from '@/components/overtimModule/selectOvertim'
import selectLeave from '@/components/leaveModule/selectLeave'
import createLeave from '@/components/leaveModule/createLeave'
import selectEvection from '@/components/evectionModule/selectEvection'
import updateEvection from '@/components/evectionModule/updateEvection'
import saveAffiche from '@/components/affiche/saveAffiche'
import findTaskByUserId from '@/components/taskModule/findTaskByUserId'
import associateWith from '@/components/taskModule/associateWith'
import createPlan from '@/components/taskModule/createPlan'
import checkTask from '@/components/taskModule/checkTask'
import addDimission from '@/components/adminModule/addDimission'
import PersonnelAdjustment from '@/components/adminModule/PersonnelAdjustment'
import showDimission from '@/components/adminModule/showDimission'
import saveOvertim from '@/components/attendanceModule/saveOvertim'
import findOvertimByUpno from '@/components/attendanceModule/findOvertimByUpno'
import showUser from '@/components/adminModule/showUser'
import saveUser from '@/components/adminModule/saveUser'
import updateLeave from '@/components/leaveModule/updateLeave'
import updateLeave2 from '@/components/leaveModule/updateLeave2'
import selectEvectionaccount from '@/components/evectionAccountModule/selectEvectionaccount'
import selectAttendance from '@/components/attendanceModule/selectAttendance'
import isMe from '@/components/adminModule/isMe'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/index',
      name: 'index',
      component: index
    },
    {
      path: '/',
      name: 'login',
      component: login
    },
    {
      path: '/welcome',
      name: 'welcome',
      component: welcome
    },
    {
      path: '/createTask',
      name: 'createTask',
      component: createTask
    },
    {
      path: '/findTask',
    name: 'findTask',
    component: findTask
  },
    {
      path: '/findWage',
      name: 'findWage',
      component: findWage
    },
    {
      path: '/issueWage',
      name: 'issueWage',
      component: issueWage
    },
    {
      path: '/findWageState',
      name: 'findWageState',
      component: findWageState
    },
    {
      path: '/findWageByUserId',
      name: 'findWageByUserId',
      component: findWageByUserId
    },
    {
      path: '/saveWage',
      name: 'saveWage',
      component: saveWage
    },
    {
      path: '/createUser',
      name: 'createUser',
      component: createUser
    },
    {
      path: '/selectOvertim',
      name: 'selectOvertim',
      component: selectOvertim
    },
    {
      path: '/selectEvection',
      name: 'selectEvection',
      component: selectEvection
    },
    {
      path: '/selectLeave',
      name: 'selectLeave',
      component: selectLeave
    },
    {
      path: '/updateLeave',
      name: 'updateLeave',
      component: updateLeave
    },
    {
      path: '/updateLeave2',
      name: 'updateLeave2',
      component: updateLeave2
    },
    {
      path: '/saveAffiche',
      name: 'saveAffiche',
      component: saveAffiche
    },
    {
      path: '/findAffiches',
      name: 'findAffiches',
      component: findAffiches
    },
    {
      path: '/findTaskByUserId',
      name: 'findTaskByUserId',
      component: findTaskByUserId
    },
    {
      path: '/associateWith',
      name: 'associateWith',
      component: associateWith
    },
    {
      path: '/createPlan',
      name: 'createPlan',
      component: createPlan
    },
    {
      path: '/checkTask',
      name: 'checkTask',
      component: checkTask
    },
    {path: '/addDimission',
      name: 'addDimission',
      component: addDimission
    },
    {
      path: '/showDimission',
      name: 'showDimission',
      component: showDimission
    },
    {
      path: '/saveOvertim',
      name: 'saveOvertim',
      component: saveOvertim
    },
    {
      path: '/findOvertimByUpno',
      name: 'findOvertimByUpno',
      component: findOvertimByUpno
    },
    { path: '/showUser',
      name: 'showUser',
      component: showUser
    },
    {
      path: '/PersonnelAdjustment',
      name: 'PersonnelAdjustment',
      component: PersonnelAdjustment
    },
    {
      path: '/saveUser',
      name: 'saveUser',
      component: saveUser
    },
    
    {
      path: '/createLeave',
      name: 'createLeave',
      component: createLeave
    },
    
    {
      path: '/updateEvection',
      name: 'updateEvection',
      component: updateEvection
    },
    {
      path: '/selectEvectionaccount',
      name: 'selectEvectionaccount',
      component: selectEvectionaccount
    },
    {
      path: '/selectAttendance',
      name: 'selectAttendance',
      component: selectAttendance
    },
    {
      path: '/isMe',
      name: 'isMe',
      component: isMe
    },
    // {name:'saveTask',path:"/saveTask",component:saveTask},
    // {name:'welcome',path:"/welcome",component:welcome},
  ]
})
