<template>
    <el-dropdown trigger="click" >
        <img src="http://iph.href.lu/24x24?text=h" class="img">

        <el-dropdown-menu slot="dropdown">
            <el-dropdown-item>首页</el-dropdown-item>
            <el-dropdown-item>个人中心</el-dropdown-item>
        </el-dropdown-menu>
    </el-dropdown>
</template>

<script>
export default {
    name: 'Personal',
    data () {
        return { 
        }
    }
}
</script>

<style lang="less" scoped>
.img {
    width: 26px;
    height: 26px;
    border-radius: 4px;
}
</style>
