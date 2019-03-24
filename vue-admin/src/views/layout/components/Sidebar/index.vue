<template>
    <div class="sidebar">
        <el-menu
            default-active="1-4-1"
            class="el-menu-vertical-demo menu"
            :collapse="sidebar.opened"
            :collapse-transition="false"
            background-color="#304156"
            text-color="#bfcbd9"
            active-text-color="#40a0ff"
        >
            <sidebar-item v-for="route in routers" :key="route.path" :item="route"></sidebar-item>
            <el-menu-item index="2">
                <i class="el-icon-menu"></i>
                <span slot="title">导航二</span>
            </el-menu-item>
        </el-menu>
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
    height: 100%;
    position: fixed;
    font-size: 0px;
    top: 0;
    bottom: 0;
    left: 0;
    z-index: 1001;
    overflow: hidden;

    .el-submenu__title {
        width: 180px;
    }
    .menu {
        overflow: auto;
        height: 100%;
        width: 197px;
        overflow-x: hidden;
        border-right: 1px solid #e6e6e6;
    }
}
</style>
