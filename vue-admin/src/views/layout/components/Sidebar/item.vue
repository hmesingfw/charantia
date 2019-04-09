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
        index: [String],
        basePath: [String]
    },
    methods: {
        generateTitle,
        clickLink (data, e) {

            this.$router.push({ path: this.basePath });
            this.$store.dispatch('PushRouterToTabs', { path: this.basePath, item: { path: data.path, name: data.name } })
            return false;
            if (!this.isExternalLink(data)) {
                e.preventDefault()
                const path = this.resolvePath(data)
                this.$router.push(path)
            }
        },
    }
}
</script>

<style lang="less" scoped>
</style>
