import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)

import login from '@/components/Login'
import index from '@/components/Index'
import family from '@/components/Family'
import staff from '@/components/Staff'
import cost from '@/components/Cost'
import facility from '@/components/Facility'
import feedback from '@/components/Feedback'
import exit from '@/components/Exit'
import maintain from '@/components/Maintain'
import house from '@/components/House'



export default new Router({
  routes: [
    { path: '/', name: 'login', component: login, title: '注销' },
    {
      path: '/index', name: 'index', component: index, title: '首页',
      children: [
        {
          path: '/family', name: 'family',
          component: family, title: '家庭信息'
        },
        {
          path: '/staff', name: 'staff',
          component: staff, title: '员工信息'
        },
        {
          path: '/cost', name: 'cost',
          component: cost, title: '反馈信息'
        },
        {
          path: '/facility', name: 'facility',
          component: facility, title: '设备信息', 
        },
        {
          path: '/feedback', name: 'feedback',
          component: feedback, title: '反馈信息'
        },
        {
          path: '/exit', name: 'exit',
          component: exit, title: '出入管理'
        },
        {
          path: '/maintain', name: 'maintain',
          component: maintain , title: '维修管理'
        },
        {
          path: '/house', name: 'house',
          component: house , title: '房屋信息'
        },

      ]
    },
  ]
})
