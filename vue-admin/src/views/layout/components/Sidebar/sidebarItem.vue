<template>
    <div v-if="!item.hidden">
        <item v-if="hasOneShowingChild(item.children)" :data="item.meta" :index="item.path"></item>

        <el-submenu v-if="item.children.length>1" :index="item.path">
            <template slot="title">
                <i class="el-icon-location"></i>
                <span>{{ item.meta.title }}</span>
            </template>

            <template v-for="child in item.children">
                <item
                    :key="child.name || child.path"
                    :data="child.meta"
                    :index="child.path || child.name"
                ></item>

                <sidebar-item v-for="route in child.children" :key="route.path" :item="route"></sidebar-item>
            </template>
            <!-- <el-submenu index="1-4">
                <template slot="title">选项4</template>
                <el-menu-item index="1-4-1">选项1</el-menu-item>
            </el-submenu>-->
        </el-submenu>
    </div>
</template>

<script>
import { mapState } from 'vuex'
import item from './item'
export default {
    name: 'sidebarItem',
    components: {
        item
    },
    props: {
        item: [Object]
    },
    computed: mapState({
        sidebar: state => state.app.sidebar,            // 控制开关伸缩 
    }),
    created () {
        console.log(this.item);
    },
    methods: {
        hasOneShowingChild (children) {

            if (children && children.length === 1) {
                if (children[0].hidden) {
                    return false;
                } else {
                    return true;
                }
            }
            return false
        },
    }

}
</script>

 