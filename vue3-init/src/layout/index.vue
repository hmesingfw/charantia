<template>
    <el-container class="layout">
        <el-scrollbar wrap-class="sidebar-scrollbar">
            <el-aside class="sidebar-container">
                <logo></logo>
                <sidebar></sidebar>
            </el-aside>
        </el-scrollbar>

        <el-container>
            <el-header class="header">
                <header-main></header-main>
            </el-header>
            <el-main>111</el-main>
        </el-container>

        <settings></settings>
    </el-container>
</template>

<script>
import sidebar from './components/sidebar/index.vue'
import logo from './components/logo/index.vue'
import headerMain from './components/header/index.vue'
import settings from './components/settings/index.vue'
export default {
    components: {
        sidebar, logo, headerMain, settings
    },

}
</script>

<style lang="scss" scoped>
.layout {
    height: 100vh;
    .el-scrollbar {
        z-index: 10;
        box-shadow: 1px 1px 3px #ccc;
        -moz-box-box-shadow: 1px 1px 3px #ccc;
    }

    .sidebar-scrollbar {
        height: 100%;
    }
    .el-scrollbar__wrap {
        overflow-x: hidden;
    }
    .sidebar-container {
        background-color: rgb(238, 241, 246);
        width: 256px;
        overflow-x: hidden;
    }

    .header {
        padding: 0;
    }
}
</style>