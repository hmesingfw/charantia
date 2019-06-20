<template>
    <div v-if="item.hidden == 1">
        <!-- 加载多个标题，判断是否存在子标题 -->
        <el-submenu v-if="item.children && item.children.length>0" :index="item.path">
            
            <template slot="title">
                <i :class="item.meta.icon"></i>
                <span>{{ generateTitle(item.path) }}</span>
            </template>

            <template v-for="child in item.children">
                <sidebar-item :key="child.path" :item="child" :base-path="resolvePath(child.path)"></sidebar-item>
            </template>
        </el-submenu>
        <!-- 加载一项，只加载一个标题 -->
        <item v-else :data="item" :index="item.path" :base-path="basePath"></item>
    </div>
</template>

<script>
import item from './item'
import { generateTitle } from '@/utils/lang'
import path from 'path'
export default {
    name: 'sidebarItem',
    components: {
        item
    },
    props: {
        item: [Object],
        basePath: [String], // 路由地址
    },  
    methods: {
        generateTitle,
        resolvePath (routePath) {
            return path.resolve(this.basePath, routePath)
        }
    }

}
</script>

 