<template>
    <div class="navbar">
        <div class="left">
            <hamburger
                :is-active="sidebar.opened"
                :toggle-click="toggleSideBar"
                class="hamburger-container"
            />
            <el-breadcrumb separator="/" class="breadcrumb">
                <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
                <el-breadcrumb-item>
                    <a href="/">活动管理</a>
                </el-breadcrumb-item>
                <el-breadcrumb-item>活动列表</el-breadcrumb-item>
                <el-breadcrumb-item>活动详情</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="right">
            <screen-full class="margin"></screen-full>
            <lang-select class="margin set-language"></lang-select>
        </div>
    </div>
</template>

<script>
// :toggle-click="toggleSideBar"
import Hamburger from '@/components/Hamburger/index.vue'
import LangSelect from '@/components/LangSelect'
import ScreenFull from '@/components/ScreenFull'

import { mapState } from 'vuex'
export default {

    name: 'navbar',
    data () {
        return {
            isCollapse: true,
        };
    },
    components: {
        Hamburger,
        LangSelect,
        ScreenFull
    },
    computed: mapState({
        sidebar: state => state.app.sidebar
    }),
    methods: {
        toggleSideBar () {
            this.$store.dispatch('toggleSideBar')
        },
    },
}
</script>
<style lang="less" >
.navbar {
    height: 42px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #e6e6e6;
    font-size: 12px;
    .left {
        display: flex;
        justify-content: space-between;
        align-items: center;
        .hamburger-container {
            margin-left: 10px;
        }
        .breadcrumb {
            margin-left: 20px;
        }
    }
    .right {
        display: flex;
        justify-content: space-between;
        align-items: center;

        .margin {
            margin-right: 10px;
        }
        .set-language {
            font-size: 24px;
            cursor: pointer;
            margin-right: 20px;
        }
    }
    .svg-icon {
        height: 28px !important;
    }

    /**  element */

    .el-breadcrumb {
        font-size: 12px;
    }
}
</style>

