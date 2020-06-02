export default {
    state:{
        //user:null,
        user:JSON.parse(sessionStorage.getItem("sesUser"))||null,
    },
    mutations:{
        setUser(state,user){
            state.user=user;
            //方案1
        //sessionStorage默认只能处理字符串，不能处理js对象，
        //JSON.stringify将对象转换为json格式的字符串
        //JSON.parse将json格式的字符串转换为js对象
        //sessionStorage.setItem("sesUser",JSON.stringify(user));
         //方案2，在App.vue
        }
    },
    getters:{
        getSessionUser(state){
            return state.user;
        },
        getUserName(state){
            if(state.user!=null){
            return state.user.uname;
            }else{
                return null;
            }
        },
        getidentityCard(state){
            if(state.user!=null){
            return state.user.proprietor.identityCard;
            }else{
                return null;
            }
        },
        getPhone(state){
            if(state.user!=null){
            return state.user.proprietor.phone;
            }else{
                return null;
            }
        },
        getSex(state){
            if(state.user!=null){
            return state.user.proprietor.sex;
            }else{
                return null;
            }
        },
    },
    actions:{
        login({commit},user){
            commit("setUser",user);
        },
        logout({commit}){
            commit("setUser",null);
        }
    }
}