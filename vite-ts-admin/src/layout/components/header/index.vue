<template>
    <el-row class="heander-container" type="flex" justify="space-between">
        <el-row class="right">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
                <el-breadcrumb-item>活动管理</el-breadcrumb-item>
                <el-breadcrumb-item>活动列表</el-breadcrumb-item>
                <el-breadcrumb-item>活动详情</el-breadcrumb-item>
            </el-breadcrumb>
        </el-row>
        <el-row class="left">
            <el-dropdown trigger="click">
                <el-row class="avatar">
                    <el-avatar :size="32" src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>
                    <span class="user-name">LISDFJ</span>
                </el-row>
                <template #dropdown>
                    <el-dropdown-menu>
                        <el-dropdown-item>黄金糕</el-dropdown-item>
                        <el-dropdown-item>狮子头</el-dropdown-item>
                        <el-dropdown-item>螺蛳粉</el-dropdown-item>
                        <el-dropdown-item>双皮奶</el-dropdown-item>
                        <el-dropdown-item>蚵仔煎</el-dropdown-item>
                    </el-dropdown-menu>
                </template>
            </el-dropdown>
        </el-row>
    </el-row>
</template>

<script>
export default {

}
</script>
<style lang="scss" scoped>
.heander-container {
    height: 64px;
    padding: 0 20px;
    align-items: center;
    background-color: #fff; // 背景色

    -moz-box-shadow: 4px 1px 3px #ccc; /* 老的 Firefox */
    box-shadow: 1px 1px 3px #ccc;

    .avatar {
        display: flex;
        align-items: center;
        .user-name {
            margin-left: 10px;
            color: inherit;
        }
    }
}
</style>