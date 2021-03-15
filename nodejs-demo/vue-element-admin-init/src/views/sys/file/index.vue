<template>
    <div>
        <div class="app-main-table">
            <el-form :inline="true" :model="QueryParam" class="header-query-form">
                <g-form :datalist="queryComponentData" :model="QueryParam" @change="query(1)" />
            </el-form>
        </div>
        <div class="app-main-table">
            <g-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multiple-selection="multipleSelection" />
            <g-table v-loading="tableLoading" :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" />
            <pagination :data="pagination" :callback="query" :total="totalCount" />
        </div>

        <edit v-model="dialogValue" :form="form" :request-type="requestType" :callback="query" :url="apiUrl" />
    </div>
</template>
<script>
import { mapState } from 'vuex';
import edit from './edit';
export default {
    components: {
        edit
    },
    computed: {
        ...mapState({
        })
    },
    data() {
        return {
            apiUrl: '', // 请求路很
            /* ------------ */
            QueryParam: { 'id': '' }, //  搜索条件
            queryComponentData: [],
            tableData: [],
            tableParams: [

                { prop: 'fileName', label: '文件名', },
                { prop: 'saveName', label: '文件名', },
                { prop: 'savePath', label: '文件路径', },
                { prop: 'ext', label: '后缀', },
                { prop: 'mime', label: 'mime', },
                {
                    prop: 'size', label: '文件大小', width: 100,
                },
                {
                    prop: 'md5', label: 'md5',
                },

                {
                    prop: 'status', label: '操作', width: 160,
                    formatF: row => <div>
                        <el-button type='text' on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} icon='el-icon-delete'>删除</el-button>
                    </div>
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
            const param = {
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
        handleEdit(row, requestType = 'post') {
            this.dialogValue = true;
            this.form = this.DeepCopy(row);
            this.requestType = requestType;
        },
    }
};
</script>
