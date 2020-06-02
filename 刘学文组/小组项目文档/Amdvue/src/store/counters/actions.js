import * as types from './types'

export default{
    ad({commit},count){
        switch(count.type){
            case types.ADD:commit(types.ADD_MUTI,count);break;
            case types.MIN:commit(types.MIN_MUTI,count);break;
            case types.TIMES:commit(types.TIMES_MUTI,count);break;
            case types.DIVIDE:commit(types.DIVIDE_MUTI,count);break;
        }
    },
}