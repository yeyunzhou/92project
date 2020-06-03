export default{
    login(state,obj){
        state.users=obj;
        
    },
    logOut(state,obj){
        state.users=obj;
    },
    createUser(state,obj){
        console.log("set");
        state.users=obj;
    },
}