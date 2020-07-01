<template>
    <div>
        <generate-group :data="groupList"></generate-group>
        <div class="app-main-table">
            <div style="margin:14px" class="result-tabs">
                <el-tabs v-model="activeName">
                    <el-tab-pane label="概况" name="second">
                        <pro></pro>
                    </el-tab-pane>
                    <el-tab-pane label="详情" name="first">
                        <user></user>
                    </el-tab-pane>
                </el-tabs>
            </div>
        </div>
    </div>
</template>
<script> 
import user from './user'
import pro from './pro'
export default {
    components: {
        user, pro
    },

    data() {
        return {
            activeName: 'second',
            groupList: [
                { code: 'item', title: "总投票", endVal: 1000, class: 'icon-people', icon: 'peoples' },
                { code: 'day', title: "七日投票", endVal: 1000, class: 'icon-people', icon: 'peoples' },
                { code: 'num', title: "投票选项", endVal: 1000, class: 'icon-people', icon: 'peoples' },
                { code: 'auto', title: "待审核", endVal: 1000, class: 'icon-people', icon: 'peoples' },
            ],
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

