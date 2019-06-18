<template>
    <div class="sidebar">
        <el-scrollbar wrap-class="scrollbar-wrapper">
            <el-menu
                default-active="2"
                class="el-menu-vertical-demo"
                active-text-color="#409EFF"
                :collapse-transition="false"
                :collapse="sidebar.opened"
            >
                <sidebar-item
                    v-for="route in routers"
                    :key="route.path"
                    :item="route"
                    :base-path="route.path"
                ></sidebar-item>
            </el-menu>
        </el-scrollbar>
    </div>
</template>

<script>

import { mapState } from 'vuex'
import sidebarItem from './sidebarItem'
import {
    getRouter
} from "@/utils/route-menus";
export default {
    name: 'SidebarMenu',
    components: {
        sidebarItem
    },
    computed: mapState({
        sidebar: state => state.app.sidebar,// 控制开关伸缩
        routers: state => state.routers.routers,    //  加载左侧展示路由

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
