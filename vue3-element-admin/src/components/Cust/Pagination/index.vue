<template>
    <div class="pu-pagination">
        <el-pagination
            @size-change="sizeChange"
            @current-change="currentChanage"
            :current-page="data.page"
            :page-sizes="pageSizes"
            :page-size="data.limit"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total"
        ></el-pagination>
    </div>
</template>
<script>
export default {
    props: {
        data: Object,                   // 分页参数
        callback: Function,             // 回调方法
        total: Number,                  // 总条数
        pageSizes: { type: Array, default: () => [10, 20, 30, 50] }
    },
    methods: {
        sizeChange(val) {
            this.data.limit = val;
            this.callback();
        },
        currentChanage(val) {
            this.data.page = val;
            this.callback();
        },
    }
}
</script>