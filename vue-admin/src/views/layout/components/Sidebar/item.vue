<template>
    <el-menu-item :index="index">
        <i :class="data.icon"></i>
        {{ data.title || data.name }}
    </el-menu-item>
</template>

<script>
export default {
    name: 'item',
    props: {
        data: [Object],
        index: [String]
    },
}
</script>

<style lang="less" scoped>
</style>
