export default{
    getUsers(state){
        state.users=JSON.parse(sessionStorage.getItem("users"));
        return state.users;
    },
    
}