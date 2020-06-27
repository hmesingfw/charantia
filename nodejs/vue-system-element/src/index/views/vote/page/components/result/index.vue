<template>
    <div style="margin:14px" class="result-tabs">
        <el-tabs v-model="activeName">
            <el-tab-pane label="统计" name="second">配置管理</el-tab-pane>
            <el-tab-pane label="投票" name="options">
                <item-option></item-option>
            </el-tab-pane>
            <el-tab-pane label="会员投票" name="first">
                <user></user>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>
<script> 
import user from './user'
import itemOption from './item-option'
export default {
    components: {
        user, itemOption
    },

    data() {
        return {
            activeName: 'first'
        };
    },
    created() {
        this.query();
    },
    methods: {
        /* 查询操作 */
        query(flag) {
            if (flag == 1) this.pagination.page = 1;         // 查询时，让页面等于1
            let param = { ...this.pagination, ...this.QueryParam };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, { params: param }).then(res => {
                this.tableData = res.data.data.list;
                this.totalCount = res.data.data.totalCount;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row = { sort: 1, status: 1 }, requestType = 'post') {
            this.dialogValue = true;
            this.form = this.DeepCopy(row);
            this.requestType = requestType;
        },

    }
};
</script>
<style lang="scss">
.result-tabs {
    margin: 0 14px;
    .el-tabs__nav-scroll {
        padding: 0 20px;
    }
}
</style>

