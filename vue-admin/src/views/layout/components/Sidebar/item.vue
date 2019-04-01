<template>
    <el-menu-item :index="index" @click="clickLink(data, $event)">
        <i :class="data.meta.icon"></i>
        {{ generateTitle(data.path) }}
    </el-menu-item>
</template>

<script>
import { generateTitle } from '@/utils/lang'
import path from 'path'
export default {
    name: 'item',
    props: {
        data: [Object],
        index: [String]
    },
    methods: {
        generateTitle,
        clickLink (routePath, e) {
            
            return false;
            if (!this.isExternalLink(routePath)) {
                e.preventDefault()
                const path = this.resolvePath(routePath)
                this.$router.push(path)
            }
        },
    }
}
</script>

<style lang="less" scoped>
</style>
