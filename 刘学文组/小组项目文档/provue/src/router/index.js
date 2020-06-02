import Vue from 'vue'
import Router from 'vue-router'
import login  from '@/components/Login'
import register from '@/components/Register'
import index from '@/components/Index'
import family from '@/components/Family'
import car from '@/components/Car'
import cost from '@/components/Cost'
import feedback from '@/components/Feedback'
import maintain from '@/components/Maintain'

import garage from '@/components/cost/Garage'
import property from '@/components/cost/Property'
Vue.use(Router)

export default new Router({
  routes: [
    {path: '/', name: 'login', component: login, title:'登录',
    children:[ 
      
    ]
  
  },
    {path: '/register', name: 'register', component: register,title:'注册'},
    {path: '/index', name: 'index', component: index,title:'主界面',
        children:[ 
            {path: '/family', name: 'family', 
              component: family,title:'家庭信息'
            },  
            { path: '/car', name: 'car', 
              component: car,title:'车辆信息'
            }, 
            { path: '/cost', name: 'cost', 
              component: cost,title:'缴费信息',
              children:[ 
                {path: '/', name: 'garage', 
                  component: garage,title:'车库费用'
                },
                {path: '/property', name: 'property', 
                component: property,title:'车库费用'
              },
              
              ]
            }, 
            { path: '/feedback', name: 'feedback', 
            component: feedback,title:'反馈信息'
          }, 
          { path: '/maintain', name: 'maintain', 
          component: maintain,title:'维修信息'
        }, 
      ]}, 
   
  ]
})
