<template>
    <div class="navbar">
        <div class="left">
            <hamburger
                :is-active="sidebar.opened"
                :toggle-click="toggleSideBar"
                class="hamburger-container"                
            />
            <el-breadcrumb separator-class="el-icon-arrow-right" class="breadcrumb">
                <el-breadcrumb-item v-if="isLoading">{{ $t('basic.index') }}</el-breadcrumb-item>

                <el-breadcrumb-item
                    v-for="item in paths"
                    :key="item.path"
                >{{ generateTitleSlash(item.path) }}</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="right">
            <screen-full class="margin"></screen-full>
            <size-select class="margin font-24"></size-select>
            <lang-select class="margin font-24"></lang-select>
            <personal class="margin margin-24 font-24"></personal>
        </div>
    </div>
</template>

<script>
// :toggle-click="toggleSideBar"
import SizeSelect from '@/components/SizeSelect'
import Hamburger from '@/components/Hamburger/index.vue'
import LangSelect from '@/components/LangSelect'
import ScreenFull from '@/components/ScreenFull'
import Personal from '@/components/Personal'
import { generateTitleSlash } from '@/utils/lang'

import { mapState } from 'vuex'
export default {

    name: 'navbar',
    data () {
        return {
            paths: [],
            isLoading: true, // 是否显示多个首页
        };
    },
    components: {
        Hamburger,
        LangSelect,
        ScreenFull,
        Personal,
        SizeSelect
    },
    computed: mapState({
        sidebar: state => state.app.sidebar,
    }),
    methods: {
        generateTitleSlash,
        toggleSideBar () {
            this.$store.dispatch('toggleSideBar')
        },

    },
    watch: {
        $route (val) { 
            this.paths = val.matched;
            // 是否显示多个首页  过滤首页只显示一个
            if (val.matched.length == 1 && val.matched[0].path == '/index') {
                this.isLoading = false;
            } else {
                this.isLoading = true;
            }
        }
    }
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
            cursor: pointer;
        }
        .font-24 {
            font-size: 24px;
        }
        .margin-24 {
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

