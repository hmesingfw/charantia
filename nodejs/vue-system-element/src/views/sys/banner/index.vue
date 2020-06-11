<template>
    <div>
        <div class="app-main-table">
            <el-form :inline="true" :model="QueryParam" class="header-query-form">
                <generate-form :datalist="queryComponentData" :model="QueryParam" @change="query(1)"></generate-form>
            </el-form>
        </div>
        <div class="app-main-table">
            <generate-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-handle>
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" v-loading="tableLoading"></generate-table>
            <pagination :data="pagination" :callback="query" :total="totalCount" />
        </div>

        <edit v-model="dialogValue" :form="form" :requestType="requestType" :callback="query" :url="apiUrl"></edit>
    </div>
</template>
<script>
import {
    mapState
} from 'vuex';
import edit from './edit.vue'

export default {
    components: {
        edit
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.banner, // 请求路很                

            /* ------------ */
            QueryParam: { "id": "" }, //  搜索条件
            queryComponentData: [],
            tableData: [],
            tableParams: [

                {
                    prop: 'coverId', label: '文件', width: 100,
                    formatF: row => <el-image src={this.$api.sys.getFile + '?id=' + row.coverId} preview-src-list={[this.$api.sys.getFile + '?id=' + row.coverId]}></el-image>
                },
                {
                    prop: 'title', label: '标题',
                },
                {
                    prop: 'startDate', label: '开始时间',
                },
                {
                    prop: 'endDate', label: '结束时间',
                },
                {
                    prop: 'sort', label: '排序',
                },
                {
                    prop: 'status', label: '状态', formatF: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query} > </c-switch>,
                },

                {
                    prop: 'status', label: "操作",
                    formatF: row => <div><el-button type="text" on-click={() => this.handleEdit(row, 'put')}>编辑</el-button>
                        <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)}>删除</el-button> </div>
                },],
            tableLoading: false,
            multipleSelection: [], // 多选选中的值

            pagination: {
                page: 1,
                size: localStorage.getItem('pageSize') || 10,
            },
            totalCount: 0, // 总共多少条
            /* 表单 */
            dialogValue: false,
            requestType: '', // 请求类型 
            form: {},
        };
    },
    created() {
        this.query();
    },
    methods: {
        /* 查询操作 */
        query(flag) {
            if (flag == 1) this.pagination.page = 1; // 查询时，让页面等于1
            let param = {
                ...this.pagination,
                ...this.QueryParam
            };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, {
                params: param
            }).then(res => {
                this.tableData = res.data.rows;
                this.totalCount = res.data.count;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row = { status: '0', sort: 1 }, requestType = 'post') {
            this.dialogValue = true;
            this.form = this.DeepCopy(row);
            this.requestType = requestType;
        },
    }
};
</script>