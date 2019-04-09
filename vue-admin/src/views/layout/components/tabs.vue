<template>
    <el-scrollbar wrap-class="scrollbar-wrapper">
        <div class="tabs-views">
            <el-tag
                v-for="(tag, key, index) in tags"
                :key="index"
                closable
                :type="tag.type"
                size="small"
            >{{generateTitle(tag.item.path)}}</el-tag>
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
        generateTitle
    },
    computed: mapState({
        tags: state => state.routers.tags
    }),

    watch: {
        tags (val) {
            console.log(val);
        }
    }
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
}

.scrollbar-wrapper {
    overflow-x: hidden !important;
}
</style>
