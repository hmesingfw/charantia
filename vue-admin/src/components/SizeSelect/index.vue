<template>
    <el-dropdown trigger="click" @command="handleSetLanguage">
        <svg-icon class-name="international-icon" icon-class="size"/>
     

        <el-dropdown-menu slot="dropdown">
            <el-dropdown-item :disabled="size==='medium'" command="medium">Medium</el-dropdown-item>
            <el-dropdown-item :disabled="size==='small'" command="small">Small</el-dropdown-item>
            <el-dropdown-item :disabled="size==='mini'" command="mini">Mini</el-dropdown-item>
        </el-dropdown-menu>
    </el-dropdown>
</template>

<script>
export default {
    name: 'SizeSelect',
    inject: ['reload'],
    data () {
        return {
        }
    },
    computed: {
        size () {
            return this.$store.getters.size
        }
    },
    methods: {
        handleSetLanguage (size) {

            this.$ELEMENT.size = size;
            this.$store.dispatch('setSize', size)
            this.refreshView()
            this.$message({
                message: 'Switch Size Success',
                type: 'success'
            })
        },
        // 切换大小写
        refreshView () {            
            this.reload();          // 刷新页面
            const { path } = this.$route;

            this.$router.replace({
                path: path
            })
        }
    }
}
</script>

<style lang="less" scoped>
 
</style>
