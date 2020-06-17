<template>
    <div>
        <div class="app-main-table">
            <generate-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-handle>
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" v-loading="tableLoading"></generate-table>
            <pagination :data="pagination" :callback="query" :total="totalCount" />
        </div>

        <edit v-model="dialogValue" :form="form" :requestType="requestType" :callback="query" :url="apiUrl"></edit>
    </div>
</template>
<script>
import { mapState } from 'vuex';
import edit from './edit.vue'
export default {
    components: {
        edit
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
            regType: state => state.enumList.data.regType,
        })
    },
    data() {
        return {
            apiUrl: 'https://mock.yonyoucloud.com/mock/8636/tenant', // 请求路很                

            /* ------------ */
            QueryParam: {}, //  搜索条件 
            tableData: [],
            tableParams: [
                {
                    prop: 'code', label: '标识', width: 100,
                },
                {
                    prop: 'name', label: '角色名称', width: 300, 'show-overflow-tooltip': true,
                },
                {
                    prop: 'isSystem', label: '平台添加', width: 160,
                    formatF: row => <c-switch data={row} data-key="show" url={this.apiUrl} callback={this.query} configtitle="switchValue2"></c-switch>
                },
                {
                    prop: 'description', label: '描述', 'show-overflow-tooltip': true,
                },
                {
                    prop: 'status', label: '状态', width: 160,
                    formatF: row => <c-switch data={row} data-key={row.status} url={this.apiUrl} callback={this.query}></c-switch>
                },
                {
                    prop: 'status', label: "操作", width: 160,
                    formatF: row => <div>
                        <el-button type="text" on-click={() => this.handleOpenInfo(row)} icon="el-icon-edit">编辑</el-button>
                        <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} icon="el-icon-delete">删除</el-button>
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
            this.form = this.DeepCopy(row);
            this.requestType = requestType;
        },
    }
};
</script>