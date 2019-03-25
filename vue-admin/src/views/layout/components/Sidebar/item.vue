<template>
    <el-menu-item index="1-3">{{ data.title }}</el-menu-item>
</template>

<script>
export default {
    name: 'item',
    props: {
        data: [Object]
    },
    created () {
        console.log(this.data);
    }
}
</script>

<style lang="less" scoped>
</style>
