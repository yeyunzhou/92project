export default{
    getUser(state){
       return state.users;
    },
    getUsername(state){
        return state.users!=null?state.users.ename:null;
    }
}