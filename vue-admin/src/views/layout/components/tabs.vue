<template>
    <el-scrollbar wrap-class="scrollbar-wrapper">
        <div class="tabs-views">
            <el-tag
                v-for="(tag, key, index) in tags"
                :key="index"
                closable
                :type="tag.type"
                size="small"
            >{{tag.name}}</el-tag>
        </div>
    </el-scrollbar>
</template>

<script>
export default {
    name: 'tabs',
    data () {
        return {
            tags: [
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },
                { name: '标签一', type: '' },
                { name: '标签二', type: 'success' },
                { name: '标签三', type: 'info' },
                { name: '标签四', type: 'warning' },

                { name: '标签五', type: 'danger' }
            ]
        };
    },
    methods: {

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

    .el-tag{
        margin-left: 10px;
    }
}

.scrollbar-wrapper {
    overflow-x: hidden !important;
}
</style>
