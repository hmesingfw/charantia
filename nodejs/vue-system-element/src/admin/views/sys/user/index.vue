<template>
    <div>
        <!-- <div class="app-main-table">
            <el-form :inline="true" :model="QueryParam" class="header-query-form">
                <generate-form :datalist="queryComponentData" :model="QueryParam" @change="query(1)"></generate-form>
            </el-form>
        </div>-->
        <div class="app-main-table">
            <generate-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-handle>
            <generate-table :data="tableData" :params="tableParams" :isSelection="false" v-loading="tableLoading"></generate-table>
            <pagination :data="pagination" :callback="query" :total="totalCount" />
        </div>

        <edit v-model="dialogValue" :form="form" :requestType="requestType" :callback="query" :url="apiUrl"></edit>
        <!-- <role v-model="dialogValueRole" :form="form" :callback="query"></role> -->
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
            queryComponentData: [
                { "name": "el-switch", "key": "status", "label": "状态", "attr": { "placeholder": "请选择内容", "clearable": true }, "option": "statusList" },
            ],
            tableData: [],
            tableParams: [
                { prop: 'account', label: "账号", },
                { prop: 'lastLoginTime', label: '最后登录时间', },
                { prop: 'lastLoginIp', label: '登录IP', },
                { prop: 'loginCount', label: '登录次数', },
                { prop: 'createdBy', label: '创建人', },
                { prop: 'status', label: '状态', formatF: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></c-switch>, },
                {
                    prop: 'status', label: "操作", width: 240,
                    formatF: row =>
                        <div>
                            <el-button type="text" on-click={() => this.password(row)} icon="el-icon-refresh">重置密码</el-button>
                            <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} icon="el-icon-delete">删除</el-button>
                        </div>
                },],
            tableLoading: false,
            multipleSelection: [], // 多选选中的值

            pagination: {
                ...this.ConfigParmas.pagination,
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
        /* 分配角色 */
        handleEditRole(row) {
            this.dialogValueRole = true;
            this.form = this.DeepCopy(row);
        },

        password(row) {
            this.$confirm('确认重置当前账号密码', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'info'
            }).then(async () => {
                let issucc = await this.ReqData(this.$api.sys.userPwd, { id: row.id }, 'put');
                if (issucc) {
                    this.$message.success('密码重置成功');
                }
            });
        }
    }
};
</script>