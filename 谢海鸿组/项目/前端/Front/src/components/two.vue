<template>
    <div>
        <el-main>
            <h2><a style="color:blue">数字政府</a></h2><br/>
            <span style="width: 90%;font-size:17px">拓维信息拥有端到端“内容+平台+服务”的综合优势，和在多个领域积累多年的技术实力，<br/>面向政府的智慧城市建设与公共服务需求，基于华为云打造九大公有云行业解决方案，推进政府实现全方位数字化运营</span>
            <div style="height:20px;"></div>
            <img src="@/assets/two-1.jpg" style="width: 90%; height: 300p"><br/>
            <el-row>
              <el-col :span="8" style="font-size:22px;color:gray;"><router-link to="/two_1">智慧城市(智能体iCity)</router-link></el-col>
              <el-col :span="8" style="font-size:22px;color:gray;"><router-link to="/two_1">智慧园区集成服务解决方案</router-link></el-col>
              <el-col :span="8" style="font-size:22px;color:gray;"><router-link to="/two_1">鲲鹏适配服务解决方案</router-link></el-col>
            </el-row>
            <br/>
            <h2><a style="color:blue">智慧教育</a></h2><br/>
            <span style="width: 90%;font-size:17px">拓维信息智慧教育以连接、内容、社会责任为出发点，<br/>借助科技力量、丰富的数字内容积累，促进教育发展，助力教育公平化、个性化、智慧化目标的实现。</span>
            <div style="height:20px;"></div>
            <img src="@/assets/two-2.jpg" style="width: 90%; height: 300p"><br/>
            <el-row>
              <el-col :span="8" style="font-size:22px;color:gray;"><router-link to="/two_1">智慧教育解决方案</router-link></el-col>
              <el-col :span="8" style="font-size:22px;color:gray;"><router-link to="/two_1">智慧幼教管理解决方案</router-link></el-col>
              <el-col :span="8" style="font-size:22px;color:gray;"><router-link to="/two_1">智慧校园解决方案</router-link></el-col>
            </el-row>
            <br/>
            <h2><a style="color:blue;">智慧交通</a></h2><br/>
            <span style="width: 90%;font-size:17px">基于十九大明确“交通强国”建设目标，拓维信息基于近20年的交通运输信息化经验，打造了<br/>多流水融合+全场景AI的智慧高速联网解决方案、以及智慧服务区服务解决方案，助力交通行业客户构建智慧高速交通体系，促进数字化和智能化转型。</span>
            <div style="height:20px;"></div>
            <img src="@/assets/two-3.jpg" style="width: 90%; height: 300p"><br/>
            <el-row>
              <el-col :span="8" style="font-size:22px;color:gray;"><router-link to="/two_1">高速计费稽查联合解决方案</router-link></el-col>
            </el-row>
            <br/>
            <h2><a style="color:blue">智能制造</a></h2><br/>
            <span style="width: 90%;font-size:17px">中国制造2025”的提出大力推进由制造大国向制造强国的转变，拓维信息结合自身数字化经验与实践，<br/>为制造业客户在生产制造执行、设备管理、企业大数据、工业物联网、安全生产等方面提供信息规划及落地支撑服务。</span>
            <div style="height:20px;"></div>
            <img src="@/assets/two-4.jpg" style="width: 90%; height: 300p"><br/>
            <el-row>
              <el-col :span="8" style="font-size:22px;color:gray;text-align:right"><router-link to="/two_1">智慧园区(制造园区)集成服务解决方案</router-link></el-col>
              <el-col :span="8" style="font-size:22px;color:gray;"><router-link to="/two_1">工业园区联合解决方案</router-link></el-col>
              <el-col :span="8" style="font-size:22px;color:gray;"><router-link to="/two_1">敏捷物联联合解决方案</router-link></el-col>
            </el-row>
        </el-main>
        <el-backtop></el-backtop>
        
    </div>
</template>

<script>
export default {
    
}
</script>

<style scoped>
.el-main,.el-header {
    color: #333;
    text-align: center;
  }
  .router-link-active {
    text-decoration: none;
  }
</style>