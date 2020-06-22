<template>
    <div>
        <div class="query-title search-title el-card el-card is-always-shadow">
            <el-form :inline="true" :model="QueryParam" size="mini">
                <el-form-item :label="getWidth() ? '状态' : ''" prop="status">
                    <el-radio-group v-model="QueryParam.status" @change="() => this.query(1)" class="radio-group">
                        <el-radio-button label>全部</el-radio-button>
                        <el-radio-button :label="0">启用</el-radio-button>
                        <el-radio-button :label="1">禁用</el-radio-button>
                    </el-radio-group>
                </el-form-item>
                <el-form-item :label="getWidth() ? '标题' : ''">
                    <el-input v-model="QueryParam.voteCategoryName" placeholder="请输入标题"></el-input>
                </el-form-item>

                <el-form-item>
                    <el-tooltip class="item" effect="dark" content="查询" placement="top">
                        <el-button @click="query(1);" type="primary" icon="el-icon-search" circle></el-button>
                    </el-tooltip>
                    <el-tooltip class="item" effect="dark" content="刷新" placement="top">
                        <el-button @click="queryClose(QueryParam);query();" icon="el-icon-refresh" circle></el-button>
                    </el-tooltip>
                </el-form-item>
            </el-form>
            <div>
                <el-tooltip class="item" effect="dark" content="新增" placement="top">
                    <el-button @click="handleEdit()" circle type="primary" icon="el-icon-plus" v-permission="'vote:sort:edit'"></el-button>
                </el-tooltip>
                <el-tooltip class="item" effect="dark" content="批量删除" placement="top">
                    <el-button @click="handleDelete({})" icon="el-icon-delete" circle type="danger" v-show="multipleSelection.length>0" v-permission="'vote:sort:delete'"></el-button>
                </el-tooltip>
            </div>
        </div>
        <div class="margin-28 el-card el-card is-always-shadow">
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
                <el-table-column prop="voteCategoryName" label="标题" show-overflow-tooltip></el-table-column>
                <el-table-column prop="remake" label="描述" show-overflow-tooltip></el-table-column>
                <el-table-column label="状态" width="60" align="center">
                    <template slot-scope="scope">
                        <!-- 0 是 1 否 -->
                        <i v-if=" scope.row.status == 0" class="table-activity-success" @click="SwitchStatus({url:apiUrl, form:scope.row, obj:{status:1}, isAlert:false}, ()=>{ query(); })"></i>
                        <i v-else class="table-activity-danger" @click="SwitchStatus({url:apiUrl, form:scope.row, obj:{status:0}, isAlert:false}, ()=>{ query(); })"></i>
                    </template>
                </el-table-column>

                <el-table-column prop="updateTime" label="更新时间" width="160"></el-table-column>

                <el-table-column label="操作" width="160" fixed="right">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" @click="handleEdit(scope.row, 'put')" v-permission="'vote:sort:edit'">编辑</el-button>
                        <el-button size="mini" type="text" @click="handleDelete(scope.row)" v-permission="'vote:sort:delete'">删除</el-button>
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

            <dialog-alert v-model="dialogValue" width="40%" title="投票分类" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
                <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                    <el-form-item label="标题" prop="voteCategoryName">
                        <el-input v-model="form.voteCategoryName" maxlength="50"></el-input>
                    </el-form-item>

                    <el-form-item label="状态" prop="status">
                        <el-radio-group v-model="form.status">
                            <el-radio :label="0">启用</el-radio>
                            <el-radio :label="1">禁用</el-radio>
                        </el-radio-group>
                    </el-form-item>
                    <el-form-item label="描述" prop="remake">
                        <el-input type="textarea" :row="4" v-model="form.remake" maxlength="200"></el-input>
                    </el-form-item>
                </el-form>
            </dialog-alert>
        </div>
    </div>
</template>
<script>
import { GetHeight, deleteRequestData, DeepCopy, ErrorLog, reqData } from '@/utils/sys';
import api from '@/config/api';
import { mapState } from 'vuex';

export default {
    computed: {
        ...mapState({
        })
    },
    data() {
        return {
            apiUrl: api.sys2.voteSort,          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },

            /* 基本不变------------ */
            tableHeight: GetHeight(260), // 列表高度       
            QueryParam: {
                status: ''
            },             //  搜索
            tableData: [],
            tableLoading: false,
            multipleSelection: [],      // 多选选中的值

            pagination: {
                page: 1,
                size: localStorage.getItem('pageSize') || this.getWidth() ? 20 : 10,
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
            this.$http.post(api.sys2.voteSortList, param).then(res => {
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
        handleEdit(row = { status: 0 }, requestType = 'post') {
            this.dialogValue = true;
            this.form = DeepCopy(row);
            this.requestType = requestType;
        },
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let issucc = await this.reqData(this.apiUrl, this.form, this.requestType, { isAlert: false });
                    if (issucc) {
                        this.$message.success('保存成功');
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
            let message = await this.deleteRequestData(this.apiUrl, ids, { isAlert: false });
            if (message) {
                this.$message.success('删除成功');
                this.query();
            }
        },

        /* 到这里基本不变----------- */
    }
};
</script>

<style lang="scss">
</style>
