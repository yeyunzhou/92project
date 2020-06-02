import * as types from './types'

export default{
    [types.ADD_MUTI](state,count){
        state.vone=Number(count.vtwo)+Number(count.vthree);
    },
    [types.MIN_MUTI](state,count){
        state.vone=count.vtwo-count.vthree;
    },
    [types.TIMES_MUTI](state,count){
        state.vone=count.vtwo*count.vthree;
    },
    [types.DIVIDE_MUTI](state,count){
        state.vone=count.vtwo/count.vthree;
    },
}