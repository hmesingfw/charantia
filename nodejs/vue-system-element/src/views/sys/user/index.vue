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

        <edit v-model="dialogValue" :form="form" :requestType="requestType" :callback="query" :url="apiUrl"></edit>
        <role v-model="dialogValueRole" :form="form" :callback="query"></role>
    </div>
</template>
<script>
import { mapState } from 'vuex';
import edit from './edit.vue'
import role from './role'
export default {
    components: {
        edit, role
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.user, // 请求路很                

            /* ------------ */
            QueryParam: {
                status: ''
            }, //  搜索条件
            queryComponentData: [{ "name": "el-input", "key": "phone", "label": "手机号", "attr": { "placeholder": "请输入内容" } }, { "name": "el-input", "key": "name", "label": "姓名", "attr": { "placeholder": "请输入内容" } }, { "name": "el-switch", "key": "status", "label": "状态", "attr": { "placeholder": "请选择内容", "clearable": true }, "option": "statusList" }],
            tableData: [],
            tableParams: [
                { prop: 'phone', label: '手机号', },
                { prop: 'password', label: '密码', },
                { prop: 'name', label: '姓名', },
                { prop: 'status', label: '状态', f: row => <z-update-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></z-update-switch>, }, { prop: 'details', label: '备注', },
                { prop: 'status', label: "角色", f: row => <el-button size="mini" type="text" on-click={() => this.handleEditRole(row)}>分配角色</el-button> },
                { prop: 'status', label: "操作", f: row => <div><el-button size="mini" type="text" on-click={() => this.handleEdit(row, 'put')}>编辑</el-button><el-button size="mini" type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)}>删除</el-button></div> },],
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
            /* role */
            dialogValueRole: false,
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
        /* 编辑 */
        handleEditRole(row) {
            this.dialogValueRole = true;
            this.form = this.DeepCopy(row);
        },
    }
};
</script>