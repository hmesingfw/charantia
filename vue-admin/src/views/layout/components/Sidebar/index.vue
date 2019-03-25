<template>
    <div class="sidebar">
        <el-scrollbar wrap-class="scrollbar-wrapper">
            <!-- <el-menu
                default-active="1-4-1"
                class="el-menu-vertical-demo menu"
                :collapse="sidebar.opened"
                :collapse-transition="false"
                background-color="#304156"
                text-color="#bfcbd9"
                active-text-color="#40a0ff"
            ></el-menu>-->
            <sidebar-item v-for="route in routers" :key="route.path" :item="route"></sidebar-item>
        </el-scrollbar>
    </div>
</template>

<script>

import { mapState } from 'vuex'
import sidebarItem from './sidebarItem'
export default {
    components: {
        sidebarItem
    },
    data () {
        return {
        };
    },
    methods: {},
    created () {
        console.log(this.routers);
    },
    computed: mapState({
        sidebar: state => state.app.sidebar,            // 控制开关伸缩
        routers: state => state.routers.routers.options.routes
    })
}
</script>

<style lang="less">
.sidebar {
    .el-submenu__title {
        width: 180px;
    }
    .menu {
        width: 100%;
        overflow: auto;
        height: 100%;
        margin-right: -17px;
        overflow-x: hidden;
    }
    .el-menu {
        border-right: none;
    }
    .el-menu-item-group__title {
        padding: 0;
    }
    .el-scrollbar {
        height: 100%;
        border-right: solid 1px #e6e6e6;
    }
    .scrollbar-wrapper {
        overflow-x: hidden !important;
    }
}
</style>
