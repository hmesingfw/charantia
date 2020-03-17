<template>
    <div class="margin-8">
        <el-form :inline="true" :model="QueryParam">
            <el-form-item label="姓名">
                <el-input v-model="QueryParam.title" placeholder="请输入"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button @click="query(1)" icon="el-icon-search" circle></el-button>
                <el-button @click="tableName = '';dialogVisible = true;" circle type="primary" icon="el-icon-plus"></el-button>
                <el-button @click="HandleDelete(apiUrl, multipleSelection, query);" icon="el-icon-delete" circle type="danger" v-show="multipleSelection.length>0"></el-button>
            </el-form-item>
        </el-form>

        <el-table
            :data="tableData"
            :height="tableHeight"
            @selection-change="val => multipleSelection = val"
            v-loading="tableLoading"
            style="width: 100%"
            :stripe="true"
            header-row-class-name="table-header-color"
        >
            <el-table-column type="selection" width="42"></el-table-column>
            <el-table-column prop="tableName" label="表名" show-overflow-tooltip></el-table-column>
            <el-table-column prop="comment" label="表说明" show-overflow-tooltip></el-table-column>
            <el-table-column prop="author" label="作者" show-overflow-tooltip></el-table-column>

            <el-table-column prop="updatedAt" label="更新时间" width="140"></el-table-column>

            <el-table-column label="操作" width="160" fixed="right">
                <template slot-scope="scope">
                    <el-button size="mini" type="text" @click="handlePage(scope.row)">生成</el-button>
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

        <el-dialog title="提示" :visible.sync="dialogVisible" width="40%">
            <el-form ref="ruleForm" :model="form" :rules="rules" label-width="120px" class="demo-ruleForm">
                <el-form-item label="表名" prop="tableName">
                    <el-select v-model="form.tableName" filterable placeholder="请选择">
                        <el-option v-for="item in tableNameList" :key="item.table_name" :value="item.table_name">{{item.table_comment ? item.table_name + ' : ' +item.table_comment: item.table_name}}</el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleSaveNew()">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>
<script>
import { GetHeight } from '@/utils/sys';
import { mapState } from 'vuex';

export default {
    computed: {
        ...mapState({
            components: state => state.enumList.enumList.components
        })
    },
    data() {
        return {
            apiUrl: this.$api.generate.index,          // 请求路很
            rules: {
                tableName: [{ required: true, message: '请选择表名', trigger: 'blur' },],
            },
            tableHeight: GetHeight(200), // 列表高度         
            QueryParam: {},             //  搜索条件
            tableData: [],
            tableLoading: false,
            multipleSelection: [],      // 多选选中的值
            pagination: {
                page: 1,
                size: localStorage.getItem('pageSize') || 10,
            },
            totalCount: 0,      // 总共多少条


            dialogVisible: false,   // 弹出框
            form: {},
            tableNameList: [],      // 已有数据表

        };
    },
    created() {
        this.init();
        this.query();
    },
    methods: {
        init() {
            this.$http.get(this.$api.generate.tableName).then(res => {
                this.tableNameList = res.data.rows;
            })
        },
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
        handleSaveNew() {
            this.$refs.ruleForm.validate((vali) => {
                if (vali) {
                    this.dialogVisible = false;
                    this.handleEdit({}, 'post');
                }
            })
        },
        /* 编辑 */
        handleEdit(row, type) {
            if (type == 'post') {
                this.$router.push({ path: '/generate/table-detail', query: { name: this.form.tableName } })
            } else {
                this.$router.push({ path: '/generate/table-detail', query: { id: row.id } })
            }
        },
        /* 生成页面 */
        handlePage(row) {
            this.$http.get(this.$api.generate.tableGenerate, { params: { id: row.id } }).then(res => {
                if (res.data.message) {
                    this.$message.success('生成成功');
                }
            })
        },
    }
};
</script>

<style lang="scss">
</style>
