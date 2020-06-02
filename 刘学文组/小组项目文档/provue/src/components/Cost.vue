<template>
    <div>
        <el-container>
       <el-menu
            :default-active="this.$router.path"
            class="el-menu-demo"
            mode="horizontal"
            router
          >
            <el-menu-item index="/cost">车库费用</el-menu-item>
            <el-menu-item index="/property">物业费用</el-menu-item>
          </el-menu>
        </el-container>
        <el-main class="app-body" >
          <template>
            <router-view />
          </template>
        </el-main>
    </div>

    
</template>

<script>
export default {
    name: "",
    data() {
        return {}
    },
    components: {},
    methods: {}
}
</script>

<style  scoped>
</style>
