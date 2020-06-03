import Vue from 'vue'
import Router from 'vue-router'
import index from '@/components/index'
import one from '@/components/one'
import two from '@/components/two'
import two_1 from '@/components/two_1'
import about from '@/components/about'
import education_1 from '@/components/education_1'
import education_2 from '@/components/education_2'
import education_3 from '@/components/education_3'
import education_4 from '@/components/education_4'
import cooperation from '@/components/cooperation'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/education_4',
      name: 'education_4',
      component: education_4
    },
    {
      path: '/education_3',
      name: 'education_3',
      component: education_3
    },
    {
      path: '/education_2',
      name: 'education_2',
      component: education_2
    },
    {
      path: '/education_1',
      name: 'education_1',
      component: education_1
    },
    {
      path: '/cooperation',
      name: 'cooperation',
      component: cooperation
    },
    {
      path: '/index',
      name: 'index',
      component: index
    },
    {
      path: '/one',
      name: 'one',
      component: one
    },
    {
      path: '/two',
      name: 'two',
      component: two
    },
    {
      path: '/two_1',
      name: 'two_1',
      component: two_1
    },
    {
      path: '/about',
      name: 'about',
      component: about
    },
  ]
})
