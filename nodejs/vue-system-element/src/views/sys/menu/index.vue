<template>
    <el-row>
        <el-col :xl="5" :sm="4">
            <el-row class="border-shadow padding-20" :style="{margin:'14px 0 14px 14px',height:treeHeight}">
                <el-input placeholder="输入关键字进行过滤" v-model="filterText" style="padding-bottom:20px"></el-input>
                <el-row style="padding-bottom:20px">
                    <el-col>
                        <el-button @click="handleEdit({ parentId: '0', }, 'post')" type="primary" icon="el-icon-plus">新增</el-button>
                    </el-col>
                </el-row>
                <el-tree
                    ref="treeMenu"
                    :data="tableData"
                    :props="{children: 'children',label: 'title'}"
                    :filter-node-method="filterNode"
                    @node-click="data => handleNodeClick(data, 'put')"
                    :default-expand-all="true"
                    :expand-on-click-node="false"
                >
                    <span class="custom-tree-node" slot-scope="{ node, data }">
                        <span>{{ node.label }}</span>
                        <span>
                            <el-button type="text" @click.stop="() => handleEdit({ parentId: data.id, }, 'post')">新增</el-button>
                            <el-button type="text" @click.stop="() => HandleDelete(apiUrl, data, query)">删除</el-button>
                        </span>
                    </span>
                </el-tree>
            </el-row>
        </el-col>
        <el-col :xl="19" :sm="20" :style="{height:treeHeight2}">
            <el-row class="app-main-table" type="flex" style="height:100%;padding:70px 40px" justify="space-around" v-loading="formLoading">
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
            </el-row>
        </el-col>

        <el-dialog title="新增菜单" :visible.sync="dialogValue" width="500px">
            <el-form :model="form" label-width="80px">
                <el-form-item label="标题：">
                    <el-input v-model="form.title" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogValue = false">取 消</el-button>
                <el-button type="primary" @click="handleUpdate">确 定</el-button>
            </div>
        </el-dialog>
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
                            <el-button type="text" on-click={() => this.handleEdit(row, 'put')} v-permission='sys:role:edit'>编辑</el-button>
                            <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)}>删除</el-button>
                            {row.type != 3 && <el-button type="text" on-click={() => this.handleEdit({ sort: 1, status: '0', parentId: row.row.id, show: '0' }, 'post')}>添加值</el-button>}
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
.custom-tree-node {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 14px;
    padding-right: 8px;
}
</style>
