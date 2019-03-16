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
            <el-submenu index="1">
                <template slot="title">
                    <i class="el-icon-location"></i>
                    <span slot="title">导航一</span>
                </template>
                <el-menu-item-group>
                    <span slot="title">分组一</span>
                    <el-menu-item index="1-1">选项1</el-menu-item>
                    <el-menu-item index="1-2">选项2</el-menu-item>
                </el-menu-item-group>
                <el-menu-item-group title="分组2">
                    <el-menu-item index="1-3">选项3</el-menu-item>
                </el-menu-item-group>
                <el-submenu index="1-4">
                    <span slot="title">选项4</span>
                    <el-menu-item index="1-4-1">选项1</el-menu-item>
                </el-submenu>
            </el-submenu>
            <el-menu-item index="2">
                <i class="el-icon-menu"></i>
                <span slot="title">导航二</span>
            </el-menu-item>
        </el-menu>
    </div>
</template>

<script>

import { mapState } from 'vuex'
export default {
    data () {
        return {
            isCollapse: false
        };
    },
    methods: {},
    computed: mapState({
        sidebar: state => state.app.sidebar
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
