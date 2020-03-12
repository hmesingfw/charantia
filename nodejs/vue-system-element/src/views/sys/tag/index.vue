<template>
    <div>
        <el-form :inline="true" :model="QueryParam" class="header-query-form">
            <generate-form :model="QueryParam"></generate-form>

            <el-form-item>
                <el-button @click="query(1)" icon="el-icon-search" circle></el-button>
                <el-button @click="handleEdit({sort:1,status:'0'}, 'post')" circle type="primary" icon="el-icon-plus"></el-button>
                <el-button @click="handleDelete(apiUrl, multipleSelection, query);" icon="el-icon-delete" circle type="danger" v-show="multipleSelection.length>0"></el-button>
            </el-form-item>
        </el-form>

        <div class="article-table">
            <el-table :data="tableData" :height="tableHeight" @selection-change="val => multipleSelection = val" v-loading="tableLoading" :stripe="true" header-row-class-name="table-header-color">
                <el-table-column type="selection" width="42"></el-table-column>
                <el-table-column prop="title" label="标题" show-overflow-tooltip></el-table-column>
                <el-table-column prop="color" label="颜色"></el-table-column>
                <el-table-column prop="type" label="类型"></el-table-column>
                <el-table-column prop="sort" label="排序"></el-table-column>
                <el-table-column label="状态">
                    <template slot-scope="scope">{{ scope.row.status == '0' ? '启用' : '禁用'}}</template>
                </el-table-column>
                <el-table-column prop="updatedAt" label="更新时间" width="140"></el-table-column>

                <el-table-column label="操作" width="160" fixed="right">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" @click="handleEdit(scope.row, 'put')">编辑</el-button>
                        <el-button size="mini" type="text" @click="handleDelete(apiUrl, scope.row, query)">删除</el-button>
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
                    <el-radio-group v-model="form.status">
                        <el-radio label="0">启用</el-radio>
                        <el-radio label="1">禁用</el-radio>
                    </el-radio-group>
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
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.tag,          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },

            /* ------------ */
            tableHeight: GetHeight(240), // 列表高度       
            QueryParam: {},             //  搜索条件
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
                    let issucc = await this.reqData(this.apiUrl, this.form, this.requestType);
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

