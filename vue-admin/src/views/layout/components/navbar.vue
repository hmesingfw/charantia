<template>
    <div>
        <el-radio-group v-model="isCollapse" style="margin-bottom: 20px;">
            <el-radio-button :label="false">展开</el-radio-button>
            <el-radio-button :label="true">收起</el-radio-button>
        </el-radio-group>

        <hamburger :is-active="sidebar.opened" class="hamburger-container"/>
    </div>
</template>

<script>
// :toggle-click="toggleSideBar"
import hamburger from '@/components/Hamburger/index.vue'
export default {

    name: 'navbar',
    data () {
        return {
            isCollapse: true,
            sidebar: {
                opened: true
            }
        };
    },
    components: {
        hamburger
    },
    methods: {
        handleOpen (key, keyPath) {
            console.log(key, keyPath);
        },
        handleClose (key, keyPath) {
            console.log(key, keyPath);
        }
    }
}
</script>
<style lang="less" scoped>
</style>

