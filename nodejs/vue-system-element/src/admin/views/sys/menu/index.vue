<template>
    <el-row class="page-two" :style="{height:treeHeight}">
        <el-col :xl="2" :md="4" class="page-router">
            <el-scrollbar class="scrollbar">
                <el-tree
                    ref="treeMenu"
                    :data="treeData"
                    :props="{children: 'children',label: 'label'}"
                    :filter-node-method="filterNode"
                    @node-click="data => handleNodeClick(data, 'put')"
                    :default-expand-all="true"
                    :expand-on-click-node="false"
                ></el-tree>
            </el-scrollbar>
        </el-col>
        <el-col :xl="22" :md="20">
            <el-row class="page-main" :style="{height:treeHeight2}">
                <el-scrollbar class="scrollbar">
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

                                <el-form-item label="权限" prop="perms">
                                    <el-input v-model="form.perms" maxlength="60"></el-input>
                                </el-form-item>

                                <el-form-item label="图标" prop="icon">
                                    <c-icon-select v-model="form.icon"></c-icon-select>
                                </el-form-item>
                                <el-form-item label="类型" prop="menuType">
                                    <el-radio-group v-model="form.menuType">
                                        <el-radio-button :label="1">目录</el-radio-button>
                                        <el-radio-button :label="2">菜单</el-radio-button>
                                        <el-radio-button :label="3">按钮</el-radio-button>
                                    </el-radio-group>
                                </el-form-item>
                                <el-form-item label="显示" prop="isHidden">
                                    <el-switch class="switch-style switch-form" v-model="form.isHidden" v-bind="ConfigParmas.switchValue2"></el-switch>
                                </el-form-item>

                                <el-form-item label="状态" prop="status">
                                    <el-switch class="switch-style switch-form" v-model="form.status" v-bind="ConfigParmas.switchValue"></el-switch>
                                </el-form-item>

                                <el-form-item label="排序" prop="sort">
                                    <el-input-number v-model="form.sort" :min="1" :max="100000"></el-input-number>
                                </el-form-item>

                                <el-form-item label="备注" prop="description">
                                    <el-input v-model="form.description" maxlength="32" show-word-limit></el-input>
                                </el-form-item>
                            </el-form>
                        </dialog-model>
                    </el-row>
                </el-scrollbar>
            </el-row>
        </el-col>
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
            treeHeight: GetHeight(90),
            treeHeight2: GetHeight(130),
            treeData: [{
                label: '平台菜单',
                code: 'platform',
            }, {
                label: '租户菜单',
                code: 'admin',
            }, {
                label: '小程序菜单',
                code: 'app',
            },],


            apiUrl: this.$api.sys.menu,          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },

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
                        if (row.menuType == 1) {
                            return '目录'
                        } else if (row.menuType == 2) {
                            return '菜单'
                        } else if (row.menuType == 3) {
                            return '按钮'
                        }
                    }
                },
                { prop: 'perms', label: "权限" },
                { prop: 'icon', label: "图标" },
                {
                    prop: 'sort', label: '排序', width: 120,
                    formatF: row => <c-number data={row} data-key="sort" url={this.apiUrl} callback={this.query}></c-number>
                },
                {
                    prop: 'isHidden', label: "显示", width: 80,
                    formatF: row => <c-switch data={row} data-key="isHidden" url={this.apiUrl} callback={this.query} configtitle="switchValue2"></c-switch>
                },
                {
                    prop: 'status', label: "状态", width: 80,
                    labelF: () => <generate-label label='状态' data-key='status' option='statusList' params={this.QueryParam} callback={this.query}></generate-label>,
                    formatF: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></c-switch>
                },
                { prop: 'updatedTime', label: "更新时间", width: '160' },
                {
                    prop: 'status', label: "操作", width: 240,
                    formatF: row =>
                        <div>
                            <el-button type="text" on-click={() => this.handleEdit(row, 'put')} icon="el-icon-edit">编辑</el-button>
                            <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} icon="el-icon-delete">删除</el-button>
                            {row.type != 3 && <el-button type="text" on-click={() => this.handleEdit({ sort: 1, status: 1, pid: row.id, isHidden: 1 }, 'post')} icon="el-icon-plus">添加值</el-button>}
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

            /*  */
            appType: 'admin',

        };
    },
    created() {
        this.loadingContent(this.treeData);
        this.query();

    },

    methods: {
        /* 查询操作 */
        query() {
            let param = {
                type: this.appType,
            };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, { params: param }).then(res => {
                this.tableData = res.data.data;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row = { sort: 1, status: 1, pid: 0, isHidden: 1 }, requestType = 'post') {
            this.dialogValue = true;
            this.form = this.DeepCopy(row);
            this.$set(this.form, 'app', this.appType);
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

        /* 点击 */
        handleNodeClick(row) {
            this.appType = row.code;
            this.query();
        },
        /* 过滤 */
        filterNode(value, data) {
            if (!value) return true;
            return data.title.indexOf(value) !== -1;
        },
        /* 加载右侧面板 */
        loadingContent(tableData) {
            if (!tableData.length > 0) return;
            if (tableData[0].children && tableData[0].children.length > 0) {
                this.handleNodeClick(tableData[0].children[0]);
            } else {
                this.handleNodeClick(tableData[0]);
            }
        },
    }
};
</script>