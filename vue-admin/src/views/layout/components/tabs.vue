<template>
    <el-scrollbar wrap-class="scrollbar-wrapper">
        <div class="tabs-views">
            <el-tag
                v-for="(tag, key, index) in tags"
                :key="index"
                closable
                :type="tag.type"
                @click="handleClick(tag)"
                @close="handleClose(tag)"
            >
                <span class="title">{{generateTitle(tag.item.path)}}</span>
            </el-tag>
        </div>
    </el-scrollbar>
</template>

<script>
import { mapState } from 'vuex'
import { generateTitle } from '@/utils/lang'
export default {
    name: 'tabs',
    data () {
        return {
        };
    },
    methods: {
        generateTitle,
        handleClose (tag) {
            // 删除tag 标签路径
            this.$store.dispatch('DelRouterToTags', tag)
        },
        handleClick (tag) {
            // 跳转路由
            this.$router.push({ path: tag.path });
            // 添加tags 路径
            this.$store.dispatch('AddRouterToTags', tag);
        }
    },
    computed: mapState({
        tags: state => state.routers.tags
    })
}
</script>
<style lang="less" scoped>
.tabs-views {
    height: 36px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    padding-right: 33px;
    border-bottom: 1px solid #e6e6e6;

    .el-tag {
        margin-left: 10px;
    }
    .title {
        cursor: pointer;
    }
}

.scrollbar-wrapper {
    overflow-x: hidden !important;
}
</style>
