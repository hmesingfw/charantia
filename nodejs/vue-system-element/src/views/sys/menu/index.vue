<template>
    <el-row>
        <el-row class="app-main-table">
            <generate-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-handle>
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" :table-attrs="tableAttrs" v-loading="tableLoading"></generate-table>
        </el-row>

        <dialog-model
            v-model="dialogValue"
            :title="requestType == 'post' ? '新增' : '详情'"
            width="600"
            :type="requestType"
            @submit="handleUpdate"
            :loading-button="loadingButton"
            @changeLoadingButton="loadingButton = false"
        >
            <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="标题" prop="title">
                    <el-input v-model="form.title" maxlength="28" show-word-limit></el-input>
                </el-form-item>

                <el-form-item label="路径" prop="path">
                    <el-input v-model="form.path" maxlength="100"></el-input>
                </el-form-item>

                <el-form-item label="组件路径" prop="component">
                    <el-input v-model="form.component" maxlength="100"></el-input>
                </el-form-item>

                <el-form-item label="权限" prop="par">
                    <el-input v-model="form.par" maxlength="60"></el-input>
                </el-form-item>

                <el-form-item label="图标" prop="icon">
                    <c-icon-select v-model="form.icon"></c-icon-select>
                </el-form-item>
                <el-form-item label="类型" prop="type">
                    <el-radio-group v-model="form.type">
                        <el-radio-button :label="1">目录</el-radio-button>
                        <el-radio-button :label="2">菜单</el-radio-button>
                        <el-radio-button :label="3">按钮</el-radio-button>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="显示" prop="show">
                    <el-switch class="switch-style switch-form" v-model="form.show" v-bind="ConfigParmas.switchValue"></el-switch>
                </el-form-item>

                <el-form-item label="状态" prop="status">
                    <el-switch class="switch-style switch-form" v-model="form.status" v-bind="ConfigParmas.switchValue"></el-switch>
                </el-form-item>

                <el-form-item label="排序" prop="sort">
                    <el-input-number v-model="form.sort" :min="1" :max="100000"></el-input-number>
                </el-form-item>

                <el-form-item label="备注" prop="details">
                    <el-input type="textarea" :rows="2" v-model="form.details" maxlength="255" show-word-limit></el-input>
                </el-form-item>
            </el-form>
        </dialog-model>
    </el-row>
</template>
<script>
import { mapState } from 'vuex';
import { GetHeight } from '@/utils/sys'
export default {
    computed: {
        ...mapState({
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.menu,          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            treeHeight: GetHeight(120),
            treeHeight2: GetHeight(180),
            /* 基本不变------------ */
            QueryParam: {},             //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'title', label: "标题", attr: { placeholder: '请输入标题' } },
            ],
            tableData: [],
            tableParams: [
                { prop: 'title', label: "标题" },
                { prop: 'path', label: "路径" },
                { prop: 'component', label: "组件路径", },
                {
                    prop: 'status', label: '类型', width: 80,
                    formatF: row => {
                        if (row.type == 1) {
                            return '目录'
                        } else if (row.type == 2) {
                            return '菜单'
                        } else if (row.type == 3) {
                            return '按钮'
                        }
                    }
                },
                { prop: 'par', label: "权限" },
                { prop: 'icon', label: "图标" },
                {
                    prop: 'sort', label: '排序', width: 120,
                    formatF: row => <c-number data={row} data-key="sort" url={this.apiUrl} callback={this.query}></c-number>
                },
                {
                    prop: 'show', label: "显示", width: 80,
                    formatF: row => <c-switch data={row} data-key="show" url={this.apiUrl} callback={this.query}></c-switch>
                },
                {
                    prop: 'status', label: "状态", width: 80,
                    labelF: () => <generate-label label='状态' keys='status' option='statusList' params={this.QueryParam} call={this.query}></generate-label>,
                    formatF: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></c-switch>
                },
                { prop: 'updatedAt', label: "更新时间", width: '160' },
                {
                    prop: 'status', label: "操作", width: 240,
                    formatF: row =>
                        <div>
                            <el-button type="text" on-click={() => this.handleEdit(row, 'put')} v-permission='sys:role:edit' icon="el-icon-edit">编辑</el-button>
                            <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} icon="el-icon-delete">删除</el-button>
                            {row.type != 3 && <el-button type="text" on-click={() => this.handleEdit({ sort: 1, status: '0', parentId: row.id, show: '0' }, 'post')} icon="el-icon-plus">添加值</el-button>}
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
            formLoading: false,

        };
    },
    created() {
        this.query();
    },

    methods: {
        /* 查询操作 */
        query() {
            let param = {
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
        handleEdit(row = { sort: 1, status: '0', parentId: '0', show: '0' }, requestType = 'post') {
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
                    } else {
                        this.loadingButton = false;
                    }
                }
            });
        },
    }
};
</script>