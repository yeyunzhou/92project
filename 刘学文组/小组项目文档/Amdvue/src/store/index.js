import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

import logins from './logins'
import counters from './counters'

export default new Vuex.Store({
    
    //子模块
    modules:{
        logins,
        counters
    }
});