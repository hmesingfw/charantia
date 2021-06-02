<template>
    <!-- <el-menu :default-active="activeMenu" class="layout-menu" @open="handleOpen" @close="handleClose" :collapse="isCollapse" :router="true"> -->
    <h-menu :options="permission_routes"></h-menu>
    <!-- </el-menu> -->
</template>

<script>
import HMenu from './menu.tsx'
import { constantRoutes } from '@/router/index'
export default {
    components: {
        HMenu
    },
    // computed: {

    //     activeMenu() {
    //         /* 默认选中 */
    //         const route = this.$route
    //         const { meta, path } = route
    //         if (meta.activeMenu) {
    //             return meta.activeMenu
    //         }
    //         return path
    //     },
    // },
    data() {
        return {
            // isCollapse: false,
            permission_routes: constantRoutes,   // 菜单信息
        };
    },
    methods: {
        // handleOpen(key, keyPath) {
        //     console.log(key, keyPath);
        // },
        // handleClose(key, keyPath) {
        //     console.log(key, keyPath);
        // }
    }
}
</script>
<style>
.layout-menu {
    overflow-x: hidden;
}
.layout-menu:not(.el-menu--collapse) {
    width: 100%;
}
</style>