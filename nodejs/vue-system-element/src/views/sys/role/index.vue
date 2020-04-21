<template>
    <div>
        <el-form :inline="true" :model="QueryParam" class="header-query-form">
            <generate-form :model="QueryParam" :datalist="queryComponentData" @change="query(1)"></generate-form>
            <el-form-item class="header-handle">
                <el-tooltip class="item" effect="dark" content="新增" placement="top">
                    <el-button @click="handleEdit()" circle type="primary" icon="el-icon-plus"></el-button>
                </el-tooltip>
            </el-form-item>
        </el-form>

        <div class="article-table">
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" v-loading="tableLoading"></generate-table>
            <pagination :data="pagination" :callback="query" />
        </div>

        <dialog-alert v-model="dialogValue" title="角色信息" width="500px" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-form label-position="right" label-width="50px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="标识" prop="code">
                    <el-input v-model="form.code" maxlength="32"></el-input>
                </el-form-item>
                <el-form-item label="名称" prop="name">
                    <el-input v-model="form.name" maxlength="32"></el-input>
                </el-form-item>

                <el-form-item label="备注" prop="remark">
                    <el-input v-model="form.remark" maxlength="200"></el-input>
                </el-form-item>

                <el-form-item label="状态" prop="status">
                    <el-switch class="switch-style" v-model="form.status" v-bind="ConfigParmas.switchValue"></el-switch>
                </el-form-item>
            </el-form>
        </dialog-alert>
        <dialog-model v-model="dialogValueAuto" title="权限信息" @submit="handleRoleUser" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <div class="role-list">
                <el-checkbox-group v-model="roleMenuList">
                    <div v-for="item in menuList" :key="item.id">
                        <div class="role-row">
                            <el-checkbox :label="item.id">{{ item.title }}</el-checkbox>
                        </div>
                        <div v-for="child in item.children" :key="child.id">
                            <div class="role-row padding-left">
                                <el-checkbox :label="child.id">{{ child.title }}</el-checkbox>
                            </div>
                            <div class="role-row handle-group padding-left-s" v-if="child.children && child.children.length>0">
                                <el-checkbox v-for="hand in child.children" :key="hand.id" :label="hand.id">{{ hand.title }}</el-checkbox>
                            </div>
                        </div>
                    </div>
                </el-checkbox-group>
            </div>
        </dialog-model>
    </div>
</template>
<script>
import { mapState } from 'vuex';

export default {
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.role,          // 请求路很
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            dialogValueAuto: false,


            menuList: [],       // 菜单列表
            tempRoleMenu: {},
            roleMenuList: [],   // 用户权限列表
            /* ------------ */
            QueryParam: {
                status: ''
            },             //  搜索条件
            queryComponentData: [
                { name: 'el-switch', key: 'status', label: "状态", option: 'statusList', attr: { placeholder: '请输入' } },
                { name: 'el-input', key: 'name', label: "名称", attr: { placeholder: '请输入角色名称' } },
            ],
            tableData: [],
            tableParams: [
                { prop: 'code', label: "标识" },
                { prop: 'name', label: "名称" },
                { prop: 'remark', label: "备注" },
                { prop: 'status', label: "状态", f: row => <z-update-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></z-update-switch> },
                { prop: 'updatedAt', label: "更新时间" },
                { prop: 'status', label: "点击授权", f: row => <el-button size="mini" type="text" on-click={() => this.handleOpenAuth(row)}>操作授权</el-button> },
                { prop: 'status', label: "操作", f: row => <div><el-button size="mini" type="text" on-click={() => this.handleEdit(row, 'put')}>编辑</el-button><el-button size="mini" type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)}>删除</el-button></div> },
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
            loadingButton: false,
            form: {},
        };
    },
    created() {
        this.query();
        this.init();
    },
    methods: {
        /* 查询操作 */
        init() {
            this.tableLoading = true;
            this.$http.get(this.$api.sys.menu).then(res => {
                this.menuList = res.data.rows;
            })
        },
        /* 查询操作 */
        query(flag) {
            if (flag == 1) this.pagination.page = 1;         // 查询时，让页面等于1
            let param = {
                ...this.pagination,
                ...this.QueryParam
            };
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
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let issucc = await this.ReqData(this.apiUrl, this.form, this.requestType);
                    if (issucc) {
                        this.dialogValue = false;
                        this.query();
                    }
                    this.loadingButton = false;
                }
            });
        },


        /* 授权 */
        handleOpenAuth(row) {
            this.roleMenuList = row.menuIds || [];
            this.tempRoleMenu = row;
            this.dialogValueAuto = true;
        },
        async handleRoleUser() {
            this.loadingButton = true;
            let map = this.roleMenuList.map(item => ({ roleId: this.tempRoleMenu.id, menuId: item }));
            let data = await this.$http.post(`${this.$api.sys.sysRoleMenu}`, map);
            this.$message.success(data.data.data);

            this.loadingButton = false;
            this.dialogValueAuto = false;
            this.query();

        }
    }
};
</script>

<style lang="scss">
.role-list {
    padding: 10px;
    .role-row {
        height: 40px;
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        border-bottom: 1px solid #ebeef5;
        .handle-group {
            display: flex;
            align-items: center;
        }
    }

    .padding-left {
        padding-left: 20px;
    }
    .padding-left-s {
        padding-left: 40px;
    }
}
</style>

