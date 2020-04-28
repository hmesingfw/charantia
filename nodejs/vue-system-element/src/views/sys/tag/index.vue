<template>
    <div>
        <el-form :inline="true" :model="QueryParam" class="header-query-form">
            <generate-form :model="QueryParam" :datalist="queryComponentData" @change="query(1)"></generate-form>
            <el-form-item>
                <el-button @click="query(1)" icon="el-icon-search" circle></el-button>
                <el-button @click="handleEdit()" circle type="primary" icon="el-icon-plus"></el-button>
                <el-button @click="HandleDelete(apiUrl, multipleSelection, query);" icon="el-icon-delete" circle type="danger" v-show="multipleSelection.length>0"></el-button>
            </el-form-item>
        </el-form>

        <div class="article-table">
            <el-table :data="tableData" @selection-change="val => multipleSelection = val" v-loading="tableLoading" :stripe="true" header-row-class-name="table-header-color">
                <el-table-column type="selection" width="42"></el-table-column>
                <el-table-column prop="title" label="标题" show-overflow-tooltip></el-table-column>
                <el-table-column prop="color" label="颜色"></el-table-column>
                <el-table-column prop="type" label="类型"></el-table-column>
                <el-table-column prop="sort" label="排序" :render-header="renderHeader">
                    <template slot-scope="scope">
                        <el-input-number v-model="scope.row.sort" controls-position="right" class="el-input-number-table" :min="1" :max="10"></el-input-number>
                    </template>
                </el-table-column>

                <el-table-column label="状态">
                    <template slot-scope="scope">
                        <z-update-switch :data="scope.row" data-key="status" :url="apiUrl" :callback="query"></z-update-switch>
                    </template>
                </el-table-column>

                <el-table-column prop="updatedAt" label="更新时间" width="140"></el-table-column>

                <el-table-column label="操作" width="160" fixed="right">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" @click="handleEdit(scope.row, 'put')">编辑</el-button>
                        <el-button size="mini" type="text" @click="HandleDelete(apiUrl, scope.row, query)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <pagination :data="pagination" :callback="query" :total="totalCount" />
        </div>

        <dialog-alert v-model="dialogValue" title="信息录入" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="标题" prop="title">
                    <el-input v-model="form.title" maxlength="32"></el-input>
                </el-form-item>
                <el-form-item label="类型" prop="type">
                    <el-input v-model="form.type" maxlength="32"></el-input>
                </el-form-item>
                <el-form-item label="颜色" prop="color">
                    <el-input v-model="form.color" maxlength="32"></el-input>
                </el-form-item>
                <el-form-item label="排序" prop="sort">
                    <el-input-number v-model="form.sort" :max="99" :min="1"></el-input-number>
                </el-form-item>
                <el-form-item label="备注" prop="details">
                    <el-input v-model="form.details" maxlength="32"></el-input>
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
            statusList: state => state.enumList.data.statusList,
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.tag,          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            /* ------------ */
            QueryParam: {},             //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'title', label: "枚举名称", attr: { placeholder: '请输入' } },
                { name: 'el-input', key: 'value', label: "状态", option: 'statusList', attr: { placeholder: '请输入' } },
            ],
            tableData: [],
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
                this.totalCount = res.data.count;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row = { sort: 1, status: '0' }, requestType = 'post') {
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

    }
};
</script>

