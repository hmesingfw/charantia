<template>
    <div class="padding-8">
        <div>
            <div></div>
            <el-form :inline="true" :model="QueryParam">
                <el-form-item label="姓名">
                    <el-input v-model="QueryParam.title" placeholder="请输入"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button @click="query(1)" icon="el-icon-search" circle></el-button>
                    <el-button @click="handleEdit({sort:1,status:1}, 'post')" circle type="primary" icon="el-icon-plus"></el-button>
                    <el-button @click="handleDelete({})" icon="el-icon-delete" circle type="danger" v-show="multipleSelection.length>0"></el-button>
                </el-form-item>
            </el-form>
        </div>

        <el-table
            :data="tableData"
            :height="tableHeight"
            @selection-change="handleSelectionChange"
            v-loading="tableLoading"
            style="width: 100%"
            :stripe="true"
            header-row-class-name="table-header-color"
        >
            <el-table-column type="selection" width="42"></el-table-column>
            <el-table-column prop="title" label="活动标题" show-overflow-tooltip></el-table-column>
            <el-table-column prop="sort" label="排序" show-overflow-tooltip></el-table-column>
            <el-table-column label="状态" show-overflow-tooltip>
                <template slot-scope="scope">{{ scope.row.status == 0 ? '启用' : '禁用'}}</template>
            </el-table-column>
            <el-table-column prop="createTime" label="创建时间" show-overflow-tooltip></el-table-column>

            <el-table-column label="操作" width="160" fixed="right">
                <template slot-scope="scope">
                    <el-button size="mini" type="text" @click="handleEdit(scope.row, 'put')">编辑</el-button>
                    <el-button size="mini" type="text" @click="handleDelete(scope.row)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>

        <div class="pu-pagination">
            <el-pagination
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="pagination.page"
                :page-sizes="[10, 20, 30, 50]"
                :page-size="pagination.size"
                layout="total, sizes, prev, pager, next, jumper"
                :total="totalCount"
            ></el-pagination>
        </div>

        <dialog-alert v-model="dialogValue" title="信息录入" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="活动标题" prop="title">
                    <el-input v-model="form.title" maxlength="50"></el-input>
                </el-form-item>
                <el-form-item label="排序" prop="sort">
                    <el-input-number v-model="form.sort" :max="99" :min="1"></el-input-number>
                </el-form-item>

                <el-form-item label="状态" prop="status">
                    <el-radio-group v-model="form.status">
                        <el-radio :label="1">启用</el-radio>
                        <el-radio :label="0">禁用</el-radio>
                    </el-radio-group>
                </el-form-item>
            </el-form>
        </dialog-alert>
    </div>
</template>
<script>
import { GetHeight, deleteRequestData, DeepCopy, ErrorLog, reqData } from '@/utils/sys';
import { mapState } from 'vuex';

export default {
    computed: {
        ...mapState({
        })
    },
    data() {
        return {
            apiUrl: 'api.sys.event',          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },

            /* 基本不变------------ */
            tableHeight: GetHeight(200), // 列表高度       
            QueryParam: {},             //  搜索
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
            requestType: '',
            loadingButton: false,
            form: {},
        };
    },
    created() {
        this.query();
    },
    methods: {
        deleteRequestData, reqData,
        /* 改变每页大小 */
        handleSizeChange(val) {
            this.pagination.size = val;
            this.query();
        },
        /* 改变当前页 */
        handleCurrentChange(val) {
            this.pagination.page = val;
            this.query();
        },
        /* 查询操作 */
        query(flag) {
            if (flag == 1) this.pagination.page = 1;         // 查询时，让页面等于1
            let param = {
                ...this.pagination,
                ...this.QueryParam
            };
            this.tableLoading = true;
            this.$http.get(this.$api.sys.tag, { params: param }).then(res => {
                let data = res.data.data;
                this.tableData = data.records;

                this.pagination.size = data.size;
                this.totalCount = data.total;
                this.tableLoading = false;
            }).catch(err => {
                ErrorLog(err);
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row, requestType) {
            this.dialogValue = true;
            this.form = DeepCopy(row);
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
        /* 多选获取值 */
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        async handleDelete(row) {
            let ids = [];
            if (row.id) {
                ids.push(row.id);
            } else {
                ids = this.multipleSelection.map(item => item.id);
            }
            let message = await this.deleteRequestData(this.apiUrl, ids);
            if (message) this.query();
        },

        /* 到这里基本不变----------- */
    }
};
</script>

<style lang="scss">
</style>
