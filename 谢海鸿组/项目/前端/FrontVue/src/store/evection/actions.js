export default{
    selectEvection({commit},obj){
        this.state.elMain='selectEvection';  
    },
    createEvection({commit},obj){
        this.state.elMain='createEvection';  
    },
    updateEvection({commit},obj){
        this.state.elMain='updateEvection';  
    },
}