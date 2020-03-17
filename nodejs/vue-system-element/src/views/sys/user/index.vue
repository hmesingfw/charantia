<template>
    <div>
        <el-form :inline="true" :model="QueryParam" class="header-query-form">
            <generate-form :datalist="queryComponentData" :model="QueryParam"></generate-form>

            <el-form-item>
                <el-button @click="query(1)" icon="el-icon-search" circle></el-button>
                <el-button @click="handleEdit()" circle type="primary" icon="el-icon-plus"></el-button>
                <el-button @click="HandleDelete(apiUrl, multipleSelection, query);" icon="el-icon-delete" circle type="danger" v-show="multipleSelection.length>0"></el-button>
            </el-form-item>
        </el-form>

        <div class="article-table">
            <el-table :data="tableData" :height="tableHeight" @selection-change="val => multipleSelection = val" v-loading="tableLoading" :stripe="true" header-row-class-name="table-header-color">
                <el-table-column type="selection" width="42"></el-table-column>
                <el-table-column prop="phone" label="手机号" width="140"></el-table-column>

                <el-table-column prop="password" label="密码" width="140"></el-table-column>

                <el-table-column prop="name" label="姓名" width="140"></el-table-column>

                <el-table-column label="状态">
                    <template slot-scope="scope">
                        <el-switch class="switch-style" v-model="scope.row.status" active-value="0" active-text="启用" inactive-value="1" inactive-text="禁用"></el-switch>
                    </template>
                </el-table-column>

                <el-table-column prop="userId" label="操作人" width="140"></el-table-column>

                <el-table-column prop="details" label="备注" width="140"></el-table-column>

                <el-table-column label="操作" width="160" fixed="right">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" @click="handleEdit(scope.row, 'put')">编辑</el-button>
                        <el-button size="mini" type="text" @click="HandleDelete(apiUrl, scope.row, query)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <div class="pu-pagination">
                <el-pagination
                    @size-change="val => {pagination.size = val; query()}"
                    @current-change="val => {pagination.page = val; query()}"
                    :current-page="pagination.page"
                    :page-sizes="[10, 20, 30, 50]"
                    :page-size="pagination.size"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="totalCount"
                ></el-pagination>
            </div>
        </div>

        <dialog-alert v-model="dialogValue" title="信息录入" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="手机号" prop="phone">
                    <el-input v-model="form.phone" maxlength="16"></el-input>
                </el-form-item>

                <el-form-item label="密码" prop="password">
                    <el-input v-model="form.password" maxlength="32"></el-input>
                </el-form-item>

                <el-form-item label="姓名" prop="name">
                    <el-input v-model="form.name" maxlength="128"></el-input>
                </el-form-item>

                <el-form-item label="状态" prop="status">
                    <el-switch class="switch-style" v-model="form.status" active-value="0" active-text="启用" inactive-value="1" inactive-text="禁用"></el-switch>
                </el-form-item>
            </el-form>
        </dialog-alert>
    </div>
</template>
<script>
import { GetHeight } from '@/utils/sys';
import { mapState } from 'vuex';

export default {
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,

        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.user, // 请求路很
            rules: {
                title: [{
                    required: true,
                    message: '请输入内容',
                    trigger: 'blur'
                },],
            },

            /* ------------ */
            tableHeight: GetHeight(240), // 列表高度       
            QueryParam: { "is_del": "0" }, //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'phone', label: "手机号", attr: { placeholder: '请输入手机号' } },
                { name: 'el-select', key: 'status', label: "状态", attr: { placeholder: '请选择状态' }, option: 'statusList' },
            ],
            tableData: [],
            tableLoading: false,
            multipleSelection: [], // 多选选中的值

            pagination: {
                page: 1,
                size: localStorage.getItem('pageSize') || 10,
            },
            totalCount: 0, // 总共多少条
            /* 表单 */
            dialogValue: false,
            requestType: '', // 请求类型
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
            if (flag == 1) this.pagination.page = 1; // 查询时，让页面等于1
            let param = {
                ...this.pagination,
                ...this.QueryParam
            };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, {
                params: param
            }).then(res => {
                this.tableData = res.data.rows;
                this.totalCount = res.data.count;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row, requestType = 'post') {
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