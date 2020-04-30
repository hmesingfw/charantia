<template>
    <div>
        <el-form :inline="true" :model="QueryParam" class="header-query-form">
            <generate-form :model="QueryParam" :datalist="queryComponentData" @change="query(1)"></generate-form>
            <generate-query :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-query>
        </el-form>

        <div class="article-table">
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" v-loading="tableLoading"></generate-table>
            <pagination :data="pagination" :total="totalCount" :callback="query" />
        </div>

        <edit v-model="dialogValue" :form="form" :requestType="requestType" :callback="query" :url="apiUrl"></edit>
        <auto v-model="dialogValueAuto" :roleMenuList="roleMenuList" :row="tempRoleMenu" :callback="query"></auto>
    </div>
</template>
<script> 
import edit from './edit'
import auto from './auto'
export default {
    components: {
        edit, auto
    },

    data() {
        return {
            apiUrl: this.$api.sys.role,          // 请求路很

            /* 权限 */
            dialogValueAuto: false,
            tempRoleMenu: {},
            roleMenuList: [],   // 用户权限列表
            /* ------------ 表格 */
            QueryParam: {
                status: ''
            },             //  搜索条件
            queryComponentData: [
                { name: 'el-switch', key: 'status', label: "状态", option: 'statusList', attr: { placeholder: '请输入' } },
                { name: 'el-input', key: 'name', label: "名称", attr: { placeholder: '请输入角色名称' } },
            ],
            tableData: [],
            tableParams: [
                { prop: 'code', label: "标识", width: 80 },
                { prop: 'name', label: "名称" },
                { prop: 'remark', label: "备注", },
                {
                    prop: 'status', width: 80,
                    l: () => <generate-label label='状态' keys='status' option='statusList' params={this.QueryParam} call={this.query}></generate-label>,
                    f: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></c-switch>
                },
                { prop: 'userName', label: "更新人" },
                { prop: 'updatedAt', label: "更新时间" },
                {
                    prop: 'status', label: "权限", permission: 'sys:role:auto',
                    f: row => <el-button size="mini" type="text" on-click={() => this.handleOpenAuth(row)}>分配权限</el-button>
                },
                {
                    prop: 'status', label: "操作",
                    f: row => <div>
                        <el-button size="mini" type="text" on-click={() => this.handleEdit(row, 'put')} v-permission='sys:role:edit'>编辑</el-button>
                        <el-button size="mini" type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} v-permission='sys:role:delete'>删除</el-button>
                    </div>
                },
            ],
            tableLoading: false,
            multipleSelection: [],      // 多选选中的值
            pagination: {
                page: 1,
                size: localStorage.getItem('pageSize') || 10,
            },
            totalCount: 0,      // 总共多少条

            /* 表单 */
            dialogValue: false,
            requestType: '',            // 请求类型 
            form: {},
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
                this.tableData = res.data.rows;
                this.totalCount = res.data.count;
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

        /* 授权 */
        handleOpenAuth(row) {
            this.roleMenuList = row.menus || [];
            this.tempRoleMenu = row;
            this.dialogValueAuto = true;
        },
    }
};
</script>

