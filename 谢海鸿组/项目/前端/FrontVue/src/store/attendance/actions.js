export default{
    selectAttendance({commit},obj){
        this.state.elMain='selectAttendance';  
    },
    saveOvertim({commit},obj){
        this.state.elMain='saveOvertim';  
    },
    findOvertimByUpno({commit},obj){
        this.state.elMain='findOvertimByUpno';  
    },
    
    creakAttendance({commit},obj){
        this.state.elMain='creakAttendance';  
    },
}