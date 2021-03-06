// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
import ElementUI from 'element-ui'
Vue.use(ElementUI)
import 'element-ui/lib/theme-chalk/index.css'


import  axios from 'axios'
axios.defaults.withCredentials=true;  
axios.defaults.baseURL="http://localhost:9090";

Vue.prototype.$axios=axios;


Vue.config.productionTip = false 



/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>',
  store
})
