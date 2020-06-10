<template>
    <el-row>
        <el-col :xl="5" :sm="4">
            <el-row style="padding:20px">
                <el-input placeholder="输入关键字进行过滤" v-model="filterText" style="margin-bottom:20px"></el-input>
                <el-tree ref="treeMenu" :data="tableData" :props="{children: 'children',label: 'title'}" :filter-node-method="filterNode" @node-click="data => handleNodeClick(data, 'put')"></el-tree>
            </el-row>
        </el-col>
        <el-col :xl="19" :sm="20">
            <!-- <el-row class="app-main-table">
                <el-form :inline="true" :model="QueryParam" class="header-query-form">
                    <generate-form :model="QueryParam" :datalist="queryComponentData"></generate-form>

                    <generate-query :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-query>
                </el-form>
            </el-row>-->
            <!-- <el-row class="app-main-table">
                <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" :table-attrs="tableAttrs" v-loading="tableLoading"></generate-table>
            </el-row>-->
            <el-row class="app-main-table padding-20" type="flex" justify="space-around" v-loading="formLoading">
                <!-- <dialog-alert v-model="dialogValue" title="菜单信息" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false"> -->
                <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                    <el-col :span="10" :offset="2">
                        <el-form-item label="标题" prop="title">
                            <el-input v-model="form.title" maxlength="128"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item label="路径" prop="path">
                            <el-input v-model="form.path" maxlength="255"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="10" :offset="2">
                        <el-form-item label="组件路径" prop="component">
                            <el-input v-model="form.component" maxlength="255"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item label="类型" prop="type">
                            <el-radio-group v-model="form.type">
                                <el-radio-button :label="1">目录</el-radio-button>
                                <el-radio-button :label="2">菜单</el-radio-button>
                                <el-radio-button :label="3">按钮</el-radio-button>
                            </el-radio-group>
                        </el-form-item>
                    </el-col>
                    <el-col :span="10" :offset="2">
                        <el-form-item label="权限" prop="par">
                            <el-input v-model="form.par" maxlength="64"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item label="图标" prop="icon">
                            <el-input v-model="form.icon" maxlength="255"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="10" :offset="2">
                        <el-form-item label="显示" prop="show">
                            <el-switch class="switch-style" v-model="form.show" v-bind="ConfigParmas.switchValue"></el-switch>
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item label="状态" prop="status">
                            <el-switch class="switch-style" v-model="form.status" v-bind="ConfigParmas.switchValue"></el-switch>
                        </el-form-item>
                    </el-col>
                    <el-col :span="10" :offset="2">
                        <el-form-item label="排序" prop="sort">
                            <el-input-number v-model="form.sort" :min="1" :max="100000"></el-input-number>
                        </el-form-item>
                    </el-col>
                    <el-col></el-col>
                    <el-col :span="10" :offset="2">
                        <el-form-item label="备注" prop="details">
                            <el-input type="textarea" :rows="2" v-model="form.details" maxlength="255"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="22" :offset="2">
                        <el-form-item>
                            <el-button type="primary" @click="handleUpdate" v-loading="loadingButton" style="width:160px;">保存</el-button>
                        </el-form-item>
                    </el-col>
                </el-form>
                <!-- </dialog-alert> -->
            </el-row>
        </el-col>
    </el-row>
</template>
<script>
import { mapState } from 'vuex';

export default {
    computed: {
        ...mapState({
        })
    },
    watch: {
        filterText(val) {
            this.$refs.treeMenu.filter(val);
        }
    },
    data() {
        return {
            apiUrl: this.$api.sys.menu,          // 请求路很
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
                    prop: 'sort', label: '排序', width: "120",
                    formatF: row => <c-number data={row} data-key="sort" url={this.apiUrl} callback={this.query}></c-number>
                },
                {
                    prop: 'show', label: "显示",
                    formatF: row => <c-switch data={row} data-key="show" url={this.apiUrl} callback={this.query}></c-switch>
                },
                {
                    prop: 'status', label: "状态", width: 80,
                    labelF: () => <generate-label label='状态' keys='status' option='statusList' params={this.QueryParam} call={this.query}></generate-label>,
                    formatF: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></c-switch>
                },
                { prop: 'updatedAt', label: "更新时间", width: '140' },
                {
                    prop: 'status', label: "操作",
                    formatF: row =>
                        <div>
                            <el-button size="mini" type="text" on-click={() => this.handleEdit(row, 'put')} v-permission='sys:role:edit'>编辑</el-button>
                            <el-button size="mini" type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)}>删除</el-button>
                            {row.type != 3 && <el-button size="mini" type="text" on-click={() => this.handleEdit({ sort: 1, status: '0', parentId: row.row.id, show: '0' }, 'post')}>添加值</el-button>}
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

            filterText: '',
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
                        this.query();
                    } else {
                        this.loadingButton = false;
                    }
                }
            });
        },
        /* 到这里基本不变----------- */
        handleNodeClick(row = { sort: 1, status: '0', parentId: '0', show: '0' }, requestType = 'post') {
            this.formLoading = true;
            this.form = this.DeepCopy(row);
            this.requestType = requestType;
            this.formLoading = false;
        },
        filterNode(value, data) {
            if (!value) return true;
            return data.title.indexOf(value) !== -1;
        }
    }
};
</script>

<style lang="scss">
</style>
