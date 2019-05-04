<template>
    <el-dropdown trigger="click" @command="handleSetLanguage">
        <div>
            <svg-icon class-name="international-icon" icon-class="peoples"/>
        </div>

        <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="index">首页</el-dropdown-item>
            <el-dropdown-item command="personal">个人中心</el-dropdown-item>
        </el-dropdown-menu>
    </el-dropdown>
</template>

<script>
export default {
    name: 'Personal',
    data () {
        return {
        }
    },
    methods: {
        handleSetLanguage (size) {
            console.log(size);

        },
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
