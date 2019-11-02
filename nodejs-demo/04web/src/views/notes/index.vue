<template>
    <div>
        <el-tabs type="border-card" class="margin-8 pu-padding" v-model="actionTabs">
            <el-tab-pane name="list">
                <span slot="label">
                    <i class="el-icon-date"></i> 医生信息
                </span>
                <el-form :inline="true" :model="QueryParam" class="demo-form-inline">
                    <el-form-item label="事项内容">
                        <el-input v-model="QueryParam.notice" placeholder="请输入"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button @click="query(1)" icon="el-icon-search"></el-button>
                        <el-button @click="handleEdit({}, 'post')" icon="el-icon-edit"></el-button>
                        <el-button @click="handleDelete({})" icon="el-icon-delete" v-show="multipleSelection.length>0"></el-button>
                    </el-form-item>
                </el-form>

                <el-table :data="tableData" :height="tableHeight" @selection-change="handleSelectionChange" style="width: 100%" header-row-class-name="table-header-color">
                    <el-table-column type="selection" width="42"></el-table-column>
                    <el-table-column prop="notice" label="事项内容" show-overflow-tooltip></el-table-column>

                    <el-table-column prop="index" label="排序" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="addTime" label="创建时间" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="modiTime" label="修改时间" show-overflow-tooltip></el-table-column>

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
                        :total="pagination.totalCount"
                    ></el-pagination>
                </div>
            </el-tab-pane>
        </el-tabs>
        <dialog-model v-model="dialogValue" title="信息录入" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="事项内容" prop="notice">
                    <el-input v-model="form.notice" maxlength="50"></el-input>
                </el-form-item>

                <el-form-item label="排序" prop="index">
                    <el-input-number v-model="form.index" :min="1" :max="99"></el-input-number>
                </el-form-item>
            </el-form>
        </dialog-model>
    </div>
</template>
<script>
import { GetHeight, deleteRequestData, DeepCopy } from "@/utils/sys";
import api from "@/config/api";
export default {
    data() {
        return {
            actionTabs: 'list',
            tableHeight: GetHeight(260), // 列表高度       
            QueryParam: {},
            tableData: [],
            multipleSelection: [],      // 多选选中的值

            pagination: {
                page: 1,
                size: 10,
                totalCount: 0
            },

            dialogValue: false,
            requestType: '',
            loadingButton: false,


            form: {},
            rules: {
                notice: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
        };
    },
    created() {
        this.query();
    },
    methods: {
        deleteRequestData,
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
            this.$http.get(api.sys.notices, { params: param }).then(res => {
                let data = res.data.data;
                this.tableData = data.list;

                this.pagination.size = data.pageSize;
                this.pagination.totalCount = data.totalCount;


            }).catch(err => {
                ErrorLog(err);
            });
        },
        /* 编辑 */
        handleEdit(row, requestType) {
            this.dialogValue = true;
            this.form = DeepCopy(row);
            this.requestType = requestType;
        },
        /* 保存 */
        handleUpdate() {
            this.$refs.ruleForm.validate(valid => {
                if (valid) {
                    this.loadingButton = true;

                    if (this.requestType == "post") {
                        this.$http.post(api.sys.notice, this.form).then(res => {
                            this.dialogValue = false;
                            this.$message.success(res.data.message);
                            this.query();
                        }).catch(err => {
                            this.dialogValue = false;
                            ErrorLog(err)
                        });
                    } else {
                        this.$http.put(api.sys.notice, this.form).then(res => {
                            this.dialogValue = false;
                            this.$message.success(res.data.message);
                            this.query();
                        }).catch(err => {
                            this.dialogValue = false;
                            ErrorLog(err)
                        });
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
            let message = await this.deleteRequestData(api.sys.notice, ids);
            if (message) this.query();
        },
    }
};
</script>

<style lang="scss">
</style>
