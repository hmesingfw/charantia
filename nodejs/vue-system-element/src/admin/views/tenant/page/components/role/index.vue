<template>
    <div>
        <div class="app-main-table">
            <generate-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-handle>
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" v-loading="tableLoading"></generate-table>
            <pagination :data="pagination" :callback="query" :total="totalCount" />
        </div>

        <edit v-model="dialogValue" :form="form" :requestType="requestType" :callback="query" :url="apiUrl"></edit>
        <auto v-model="dialogAuto" :row="autoinfo" :roleMenuList="roleMenuList" :callback="query"></auto>
    </div>
</template>
<script>
import { mapState } from 'vuex';
import edit from './edit.vue'
import auto from './auto'
export default {
    components: {
        edit, auto
    },
    props: {
        info: Object,
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
            regType: state => state.enumList.data.regType,
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.role, // 请求路很                

            /* ------------ */
            QueryParam: {}, //  搜索条件 
            tableData: [],
            tableParams: [
                {
                    prop: 'name', label: '角色名称', width: 300, 'show-overflow-tooltip': true,
                },
                {
                    prop: 'isSystem', label: '平台添加', width: 160,
                    formatF: row => this.ListMatchField('statusList2', row.isSystem)
                },
                {
                    prop: 'description', label: '描述', 'show-overflow-tooltip': true,
                },
                {
                    prop: 'status', label: '状态', width: 160,
                    formatF: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></c-switch>
                },
                {
                    prop: 'status', label: "操作", width: 240,
                    formatF: row => <div>
                        <el-button type="text" on-click={() => this.handleAuto(row)} icon="el-icon-edit">授权</el-button>
                        <el-button type="text" on-click={() => this.handleEdit(row, 'put')} icon="el-icon-edit">编辑</el-button>
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


            /*  */
            roleMenuList: [],
            dialogAuto: false,
            autoinfo: {},
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
                tenantId: this.info.tenantId,
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
            this.$set(this.form, 'tenantId', this.info.tenantId);
            this.$set(this.form, 'isSystem', 1);

            this.requestType = requestType;
        },
        handleAuto(row) {
            this.dialogAuto = true;
            this.autoinfo = row;
            this.$http.get(`${this.$api.sys.roleMenu}?roleId=${row.id}`).then(res => {
                this.roleMenuList = res.data.data;
            });
        },
    }
};
</script>