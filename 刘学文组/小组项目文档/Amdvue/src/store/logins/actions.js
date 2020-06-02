export default{
    login({commit},users){
        commit("setUser",users);
    },
    logout({commit}){
        commit("setUser",null);
    }
}