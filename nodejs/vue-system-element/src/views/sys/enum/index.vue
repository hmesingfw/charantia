<template>
    <div>
        <el-row class="app-main-table">
            <el-form :inline="true" :model="QueryParam" class="header-query-form">
                <generate-form :model="QueryParam" :datalist="queryComponentData"></generate-form>
            </el-form>
        </el-row>
        <el-row class="app-main-table">
            <generate-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-handle>
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" :table-attrs="tableAttrs" v-loading="tableLoading"></generate-table>
        </el-row>

        <dialog-alert v-model="dialogValue" title="枚举值" width="500px" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-form label-position="right" label-width="50px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="标题" prop="title">
                    <el-input v-model="form.title" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="值" prop="value">
                    <el-input v-model="form.value" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="排序" prop="sort">
                    <el-input-number v-model="form.sort" :min="1" :max="100000"></el-input-number>
                </el-form-item>
                <el-form-item label="备注" prop="details">
                    <el-input type="textarea" :rows="2" v-model="form.details" maxlength="255" show-word-limit></el-input>
                </el-form-item>

                <el-form-item label="状态" prop="status">
                    <el-switch class="switch-style" v-model="form.status" v-bind="ConfigParmas.switchValue"></el-switch>
                </el-form-item>
            </el-form>
        </dialog-alert>
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
            apiUrl: this.$api.sys.enum,          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                value: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },

            /* 基本不变------------ */
            QueryParam: {},             //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'title', label: "标题", attr: { placeholder: '请输入标题' } },
            ],
            tableData: [],
            tableParams: [
                { prop: 'title', label: "标题" },
                { prop: 'value', label: "字典值" },
                {
                    prop: 'sort', label: '排序', width: "120",
                    formatF: row => <c-number data={row} data-key="sort" url={this.apiUrl} callback={this.query}></c-number>
                },
                {
                    prop: 'status', label: "状态", width: 80,
                    labelF: () => <generate-label label='状态' keys='status' option='statusList' params={this.QueryParam} call={this.query}></generate-label>,
                    formatF: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></c-switch>
                },
                { prop: 'details', label: "备注" },
                { prop: 'updatedAt', label: "更新时间", width: '160' },
                {
                    prop: 'status', label: "操作",
                    formatF: row =>
                        <div>
                            <el-button type="text" on-click={() => this.handleEdit(row, 'put')} v-permission='sys:role:edit' icon="el-icon-edit">编辑</el-button>
                            <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} icon="el-icon-delete">删除</el-button>
                            {row.parentId != '0' && <el-button type="text" on-click={() => this.handleEdit({ sort: 1, status: '0', parentId: row.row.id }, 'post')} icon="el-icon-plus">添加值</el-button>}
                        </div>
                },
            ],
            tableAttrs: {
                'row-key': "id",
                'tree-props': { children: 'children', hasChildren: 'hasChildren' }
            },
            tableLoading: false,
            multipleSelection: [],      // 多选选中的值

            /* 表单 */
            dialogValue: false,
            requestType: '',            // 请求类型
            loadingButton: false,
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
            let param = {
                ...this.pagination,
                ...this.QueryParam
            };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, { params: param }).then(res => {
                this.tableData = res.data.rows;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row, requestType) {
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
                        this.loadingButton = false;
                        this.dialogValue = false;
                        this.query();

                        this.$store.dispatch('enumList/getEnum');
                    } else {
                        this.loadingButton = false;
                    }
                }
            });
        },
        /* 到这里基本不变----------- */
    }
};
</script>

<style lang="scss">
</style>
