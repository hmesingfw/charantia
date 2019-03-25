<template>
    <!-- <div v-if="!item.hidden">
        <template if="!item.children || item.children.length==0">
            <i class="el-icon-location"></i>
            
        </template>

        <el-submenu :index="item.name || item.path">
            <template slot="title">
                <i class="el-icon-location"></i>
                <span slot="title">{{ item.meta.title }}</span>
            </template>

            <el-menu-item-group v-if="item.children">
                <item v-for="child in item.children" :key="child.path" :data="child.meta"></item>
            </el-menu-item-group>
             
        </el-submenu>
    </div>-->
    <el-menu
        default-active="2"
        class="el-menu-vertical-demo"
        active-text-color="#ffd04b"
        :collapse-transition="false"
        :collapse="sidebar.opened"
    >
        <el-submenu index="1">
            <template slot="title">
                <i class="el-icon-location"></i>
                <span>导航一</span>
            </template>
            <el-menu-item-group>
                <el-menu-item index="1-1">选项1</el-menu-item>
                <el-menu-item index="1-2">选项2</el-menu-item>
            </el-menu-item-group>
            <el-menu-item-group>
                <el-menu-item index="1-3">选项3</el-menu-item>
            </el-menu-item-group>
            <el-submenu index="1-4">
                <template slot="title">选项4</template>
                <el-menu-item index="1-4-1">选项1</el-menu-item>
            </el-submenu>
        </el-submenu>
        
    </el-menu>
</template>

<script>
import { mapState } from 'vuex'
import item from './item'
export default {
    name: 'sidebarItem',
    components: {
        item
    },
    created () {
        // console.log(this.item);
    },
    props: {
        item: [Object]
    },
    computed: mapState({
        sidebar: state => state.app.sidebar,            // 控制开关伸缩 
    })

}
</script>

 