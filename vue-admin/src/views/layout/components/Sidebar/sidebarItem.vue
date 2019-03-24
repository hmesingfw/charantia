<template>
    <div v-if="!item.hidden && item.children">
        <el-submenu :index="item.name || item.path">
            <template slot="title">
                <i class="el-icon-location"></i>
                <span slot="title">导航一</span> 
            </template>


            <el-menu-item-group v-if="item.children">
                <el-menu-item  index="1-3">选项3</el-menu-item>
            </el-menu-item-group>


            <el-submenu index="1-4">
                <span slot="title">选项4</span>
                <el-menu-item index="1-4-1">选项1</el-menu-item>
            </el-submenu>
        </el-submenu>
    </div>
</template>

<script>
export default {
    name: 'sidebarItem',
    created () {
        console.log(this.item);
    },
    props: {
        item: [Object]
    }

}
</script>

 