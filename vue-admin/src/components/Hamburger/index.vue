<template>
    <div class="hamburger">
        <i class="el-icon-s-operation font-size"  @click="toggleClick"></i>
    </div>
</template>

<script>
// @click="toggleClick"
export default {
    name: 'Hamburger',
    props: {
        isActive: {
            type: [Boolean, String],
            default: false
        },
        toggleClick: {
            type: Function,
            default: null
        }
    },
}
</script>

<style lang="less" scoped>
.hamburger {
    display: inline-block;
    cursor: pointer;
    line-height: 38px;
    width: 30px;
    height: 30px;

    .font-size{
        font-size: 24px;
    }
}

</style>
