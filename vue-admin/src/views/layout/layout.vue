<template>
    <div v-bind:class="[sidebar.opened?'layout-shrink':'layout-extend']">
        <sidebar class="sidebar-container"></sidebar>
        <div class="main-container">
            <navbar></navbar>
            <tabs></tabs>
            <app-main></app-main>
        </div>
    </div>
</template>

<script>
import Sidebar from './components/Sidebar/index.vue';
import navbar from './components/navbar.vue'
import tabs from './components/tabs.vue'
import appMain from './components/main.vue'
import { mapState } from 'vuex'
export default {
    name: 'layout',
    components: {
        Sidebar,
        navbar,
        tabs,
        appMain
    },
    computed: mapState({
        sidebar: state => state.app.sidebar
    }),
    methods: {

    }
}
</script>

<style lang="less" scoped>
.main-container {
    min-height: 100%;
    -webkit-transition: margin-left 0.28s;
    transition: margin-left 0.28s;
    margin-left: 180px;
    position: relative;
}
</style>


<style lang="less">
// 左侧菜单栏样式
.layout-extend {
    .sidebar {
        width: 180px;
    }
     
}
.layout-shrink {
    .sidebar {
        width: 36px;
        .menu {
            width: 53px;
        }
        .el-submenu__title {
            padding-left: 5px !important;
        }
        .el-menu-item {
            padding-left: 5px !important;
        }
        .el-tooltip {
            padding-left: 7px !important;
        }
    }
    .main-container {
        margin-left: 36px;
    }
    .el-menu--collapse {
        width: 32px;
    }
}

.sidebar-container {
    transition: width 0.28s;
    width: 180px;
    height: 100%;
    position: fixed;
    font-size: 0px;
    top: 0;
    bottom: 0;
    left: 0;
    z-index: 1001;
    overflow: hidden;
}
</style>

