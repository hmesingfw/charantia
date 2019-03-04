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
            <lang-select class="set-language"/>
        </div>
    </div>
</template>

<script>
// :toggle-click="toggleSideBar"
import hamburger from '@/components/Hamburger/index.vue'
import LangSelect from '@/components/LangSelect'

import { mapState } from 'vuex'
export default {

    name: 'navbar',
    data () {
        return {
            isCollapse: true,
        };
    },
    components: {
        hamburger,
        LangSelect
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
<style lang="less" scoped>
.navbar {
    height: 46px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #e6e6e6;
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

        .set-language {
            top: 3px;
            font-size: 24px;
            cursor: pointer;
        }
    }
}
</style>

