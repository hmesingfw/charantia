<template>
    <el-dropdown trigger="click" @command="handleSetLanguage">
        <img src="http://iph.href.lu/24x24?text=s" class="img">

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
            // In order to make the cached page re-rendered
            // const visitedViews = [...this.$store.getters.visitedViews].map(i => {
            //     i.meta.noCache = true
            //     return i
            // })

            // this.$store.dispatch('delAllViews', this.$route).then(() => {
            //     console.log(visitedViews)
            //     for (const i of visitedViews) {
            //         this.$store.dispatch('addVisitedViews', i)
            //     }
            // })

            const { path } = this.$route

            this.$router.replace({
                path: path
            })
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
