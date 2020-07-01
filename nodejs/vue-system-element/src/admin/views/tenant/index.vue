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
            apiUrl: this.$api.sys.tenant, // 请求路很                

            /* ------------ */
            QueryParam: {}, //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'name', label: "名称", attr: { placeholder: '请输入租户名称' } },
            ],
            tableData: [],
            tableParams: [
                {
                    prop: 'name', label: '租户名称', 'min-width': 300, 'show-overflow-tooltip': true,
                    formatF: row => <el-button type="text" on-click={() => this.handleOpenInfo(row)} >{row.name}</el-button>
                },
                {
                    prop: 'conact', label: '联系人', width: 200
                },
                {
                    prop: 'mobile', label: '手机号码', width: 160
                },
                {
                    prop: 'regType', label: '类型', width: 160,
                    formatF: row => this.ListMatchField('regType', row.regType)
                },
                {
                    prop: 'startTime', label: '授权时间', width: 240,
                    formatF: row => <div>{row.startTime && row.startTime.substring(0, 10)} - {row.endTime && row.endTime.substring(0, 10)}</div>
                },
                {
                    prop: 'accountLimit', label: '账号数', width: 100,
                },
                {
                    prop: 'status', label: '状态', width: 100,
                    formatF: row => <c-switch data={row} data-key='status' url={this.apiUrl} callback={this.query}></c-switch>
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
                ...this.ConfigParmas.pagination
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
                this.tableData = res.data.data.list;
                this.totalCount = res.data.data.totalCount;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row = { status: 1 }, requestType = 'post') {
            this.dialogValue = true;
            this.form = this.DeepCopy(row);
            this.requestType = requestType;
        },
        /* 租户信息 */
        handleOpenInfo(row) {
            this.$router.push({ path: '/tenant/detail', query: { id: row.tenantId } })
        },
    }
};
</script>