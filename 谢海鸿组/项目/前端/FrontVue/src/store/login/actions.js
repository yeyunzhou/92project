export default{
    login({commit},obj){
        let url="login/doLogin";
        this.state.axios.post(url,obj).then((response)=>{
            if(response.data.data==null){
                alert(response.data.message);
                this.state.returnMessage=response.data.message;
            return this.state.app_view='login';
               
            } 
            this.state.returnMessage="";
            commit('login',response.data.data[0]);
            this.state.show=response.data.data[1];
            sessionStorage.setItem("users",JSON.stringify(response.data.data[0]));
            sessionStorage.setItem("app_view","index");
            this.state.app_view='index';
            console.log(response.data.data[0]);
        }).catch((ex)=>{
            console.log(ex);
        });
        
    },
    logOut({commit},obj){
        let url="login/logout";
        this.state.elMain='welcome';
        this.state.axios.post(url).then((response)=>{
            if(response.data.data.message=='注销成功'){
                this.state.app_view='login';
                sessionStorage.clear();
                commit('logOut',obj);
            }
        }).catch((ex)=>{
            console.log(ex);
        });
        
    },

    //切换管理员界面 let url="";
    createUser({commit},obj){
        this.state.elMain='createUser';
    },
    addDimission({commit},obj){
        this.state.elMain='addDimission';
    },
    showDimission({commit},obj){
        this.state.elMain='showDimission';
    },
    showUser({commit},obj){
        this.state.elMain='showUser';
    },
    set({commit},obj){
        this.state.set=obj.a;
        console.log(this.state.set);
        this.state.userId=obj.b;
        this.state.elMain='createUser';
    },
    PersonnelAdjustment({commit},obj){
        this.state.elMain='PersonnelAdjustment';
    },
    saveUser({commit},obj){
        this.state.elMain='saveUser';
    },
    isMe({commit},obj){
        this.state.elMain='isMe';
    },
}