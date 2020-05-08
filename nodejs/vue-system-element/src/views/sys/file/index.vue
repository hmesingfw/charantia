<template>
    <div>
        <el-form :inline="true" :model="QueryParam" class="header-query-form">
            <generate-form :datalist="queryComponentData" :model="QueryParam" @change="query(1)"></generate-form>
            <generate-query :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-query>
        </el-form>

        <div class="article-table">
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" v-loading="tableLoading"></generate-table>
            <pagination :data="pagination" :callback="query" :total="totalCount" />
        </div>

        <c-file v-model="dialogValue" :callback="getFile"></c-file>
    </div>
</template>
<script>
import { mapState } from 'vuex';

export default {

    computed: {
        ...mapState({
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.file, // 请求路很                

            /* ------------ */
            QueryParam: { "id": "" }, //  搜索条件
            queryComponentData: [],
            tableData: [],
            tableParams: [{ prop: 'fileName', label: '文件名', },
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
                prop: 'isImg', label: '是否图片',

            },
            {
                prop: 'status', label: "操作",
                formatF: row => <div>
                    <el-button size="mini" type="text" on-click={() => this.handleEdit(row, 'put')}>编辑</el-button>
                    <el-button size="mini" type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)}>删除</el-button>
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
        handleEdit(row, requestType = 'post') {
            this.dialogValue = true;
            this.requestType = requestType;
        },

        getFile(fileurl) {
            console.log(fileurl);
            this.query();
        },
    }
};
</script>