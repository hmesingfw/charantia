<template>
    <el-row class="sidebar-logo" type="flex" justify="center">
        <el-image class="img" fil="cover" src="/@/assets/logo.png" alt />
        <h1 class="title">vue admin</h1>
    </el-row>
</template>

<script>
export default {

}
</script>

<style lang="scss" scoped>
.sidebar-logo {
    height: 64px;
    line-height: 64px;
    align-items: center;

    background-color: #002140; // 背景色
    .img {
        width: 32px;
        height: 32px;
    }
    .title {
        color: #fff;
        font-size: 20px;
        margin: 0 0 0 12px;
        display: inline-block;
        vertical-align: middle;
    }
}
</style>