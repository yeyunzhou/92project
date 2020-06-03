export default{
    selectLeave(state,obj){
        state.selectLeave=obj;
    },
    createLeave(state,obj){
        state.createLeave=obj;
    },
    updateLeave({commit},obj){
        this.state.elMain='updateLeave';  
    },
    updateLeave2({commit},obj){
        this.state.elMain='updateLeave2';  
    },
}