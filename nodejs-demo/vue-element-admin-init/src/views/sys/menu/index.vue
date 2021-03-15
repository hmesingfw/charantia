<template>
    <el-row class="page-main">
        <el-scrollbar class="scrollbar">
            <el-row>
                <el-row class="app-main-table">
                    <el-row style="padding:20px 0 0 20px; font-weight:700">
                        <i class="el-icon-info" />
                        <span>请勿修改菜单内容</span>
                    </el-row>
                    <g-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multiple-selection="multipleSelection" />
                    <g-table v-loading="tableLoading" :data="tableData" :params="tableParams" :table-attrs="tableAttrs" @selection-change="val => multipleSelection = val" />
                </el-row>

                <dialog-model
                    v-model="dialogValue"
                    :title="requestType == 'post' ? '新增' : '详情'"
                    width="600"
                    :type="requestType"
                    :loading-button="loadingButton"
                    @submit="handleUpdate"
                    @changeLoadingButton="loadingButton = false"
                >
                    <el-form ref="ruleForm" label-position="right" label-width="100px" :rules="rules" :model="form">
                        <el-form-item label="标题" prop="title">
                            <el-input v-model="form.title" maxlength="28" show-word-limit />
                        </el-form-item>

                        <el-form-item label="路径" prop="path">
                            <el-input v-model="form.path" maxlength="100" />
                        </el-form-item>

                        <el-form-item label="组件路径" prop="component">
                            <el-input v-model="form.component" maxlength="100" />
                        </el-form-item>

                        <el-form-item label="权限" prop="perms">
                            <el-input v-model="form.perms" maxlength="60" />
                        </el-form-item>

                        <el-form-item label="图标" prop="icon">
                            <c-icon-select v-model="form.icon" />
                        </el-form-item>
                        <el-form-item label="类型" prop="menuType">
                            <el-radio-group v-model="form.menuType">
                                <el-radio-button :label="1">目录</el-radio-button>
                                <el-radio-button :label="2">菜单</el-radio-button>
                                <el-radio-button :label="3">按钮</el-radio-button>
                            </el-radio-group>
                        </el-form-item>
                        <el-form-item label="显示" prop="isHidden">
                            <el-switch v-model="form.isHidden" class="switch-style swit ch-form" v-bind="ConfigParmas.switchValue2" />
                        </el-form-item>

                        <el-form-item label="状态" prop="status">
                            <el-switch v-model="form.status" class="switch-style switch-form" v-bind="ConfigParmas.switchValue" />
                        </el-form-item>

                        <el-form-item label="排序" prop="sort">
                            <el-input-number v-model="form.sort" :min="1" :max="100000" />
                        </el-form-item>

                        <el-form-item label="备注" prop="description">
                            <el-input v-model="form.description" maxlength="32" show-word-limit />
                        </el-form-item>
                    </el-form>
                </dialog-model>
            </el-row>
        </el-scrollbar>
    </el-row>
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
            apiUrl: this.$api.sys.menu, // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },

            /* 基本不变------------ */
            QueryParam: {}, //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'title', label: '标题', attr: { placeholder: '请输入标题' } },
            ],
            tableData: [],
            tableParams: [
                { prop: 'title', label: '标题', minWidth: 120, },
                { prop: 'path', label: '路径', minWidth: 120, },
                { prop: 'component', label: '组件路径', minWidth: 120, },
                {
                    prop: 'status', label: '类型', width: 80,
                    formatF: row => {
                        if (row.menuType == 1) {
                            return '目录'
                        } else if (row.menuType == 2) {
                            return '菜单'
                        } else if (row.menuType == 3) {
                            return '按钮'
                        }
                    }
                },
                { prop: 'perms', label: '权限' },
                {
                    prop: 'icon', label: '图标', width: 80,
                    formatF: row => {
                        if (!row.icon) {
                            return ''
                        } else if (row.icon.indexOf('el-') == -1) {
                            return <svg-icon icon-class={row.icon} style='font-size: 22px;' />
                        } else {
                            return <i class={row.icon} style='font-size: 24px;' />
                        }
                    },
                },
                {
                    prop: 'sort', label: '排序', width: 120,
                    formatF: row => <c-number data={row} data-key='sort' url={this.apiUrl} callback={this.query}></c-number>
                },
                // {
                //     prop: 'isHidden', label: '显示', width: 80,
                //     labelF: () => <g-label label='显示' data-key='status' option='statusList2' params={this.QueryParam} callback={this.query}></g-label>,
                //     formatF: row => <c-switch data={row} data-key='isHidden' url={this.apiUrl} callback={this.query} configtitle='switchValue2'></c-switch>
                // },
                // {
                //     prop: 'status', label: '状态', width: 80,
                //     labelF: () => <g-label label='状态' data-key='status' option='statusList' params={this.QueryParam} callback={this.query}></g-label>,
                //     formatF: row => <c-switch data={row} data-key='status' url={this.apiUrl} callback={this.query}></c-switch>
                // },
                // { prop: 'updatedTime', label: '更新时间', width: '160' },
                {
                    prop: 'status', label: '操作', width: 240, fixed: 'right',
                    formatF: row =>
                        <div>
                            <el-button type='text' on-click={() => this.handleEdit(row, 'put')} icon='el-icon-edit'>编辑</el-button>
                            <el-button type='text' on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} icon='el-icon-delete'>删除</el-button>
                            {row.menuType != 3 && <el-button type='text' on-click={() => this.handleEdit({ sort: 1, status: 1, parentId: row.id, isHidden: 1, appId: 'admin' }, 'post')} icon='el-icon-plus'>添加值</el-button>}
                        </div>
                },
            ],
            tableAttrs: {
                'row-key': 'id',
                'tree-props': { children: 'children', hasChildren: 'hasChildren' }
            },
            tableLoading: false,
            multipleSelection: [], // 多选选中的值

            /* 表单 */
            dialogValue: false,
            requestType: '', // 请求类型
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
            this.tableLoading = true;
            this.$http.get(this.$api.sys.menuTree).then(res => {
                this.tableData = res.data.data;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row = { sort: 1, status: 1, parentId: 0, isHidden: 1, appId: 'admin' }, requestType = 'post') {
            this.dialogValue = true;
            this.form = this.DeepCopy(row);
            this.requestType = requestType;
        },
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    const issucc = await this.ReqData(this.apiUrl, this.form, this.requestType);
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
