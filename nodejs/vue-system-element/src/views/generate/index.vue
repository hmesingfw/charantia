<template>
    <el-tabs type="border-card" class="margin-8" v-model="tabsActiveName">
        <el-tab-pane name="list">
            <span slot="label">
                <i class="el-icon-date"></i> 我的表单
            </span>
            <div>
                <el-form :inline="true" :model="QueryParam">
                    <el-form-item label="姓名">
                        <el-input v-model="QueryParam.title" placeholder="请输入"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button @click="query(1)" icon="el-icon-search" circle></el-button>
                        <el-button @click="handleEdit({sort:1,status:'0'}, 'post')" circle type="primary" icon="el-icon-plus"></el-button>
                        <el-button @click="handleDelete(apiUrl, multipleSelection, query);" icon="el-icon-delete" circle type="danger" v-show="multipleSelection.length>0"></el-button>
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
        </el-tab-pane>
        <el-tab-pane name="tableList">
            <span slot="label">
                <i class="el-icon-date"></i> 数据库
            </span>
            <el-form :model="tableForm">
                <el-form-item label="表">
                    <el-select v-model="tableForm.title" filterable placeholder="请选择" @change="generateField">
                        <el-option v-for="item in tableNameList" :key="item.table_name" :value="item.table_name">{{item.table_comment ? item.table_name + ' : ' +item.table_comment: item.table_name}}</el-option>
                    </el-select>
                </el-form-item>
            </el-form>
        </el-tab-pane>
        <el-tab-pane label="生成" name="fielsList">
            <el-form :model="fieldList" class="demo-form-inline">
                <el-table :data="fieldList.data" style="width: 100%" v-loading="fieldLoading">
                    <el-table-column prop="field" label="字段" width="180">
                        <template slot-scope="scope">
                            <el-input v-model="scope.row.field"></el-input>
                        </template>
                    </el-table-column>
                    <el-table-column prop="comment" label="说明" width="180">
                        <template slot-scope="scope">
                            <el-input v-model="scope.row.comment"></el-input>
                        </template>
                    </el-table-column>
                    <el-table-column prop="component" label="组件" width="180">
                        <template slot-scope="scope">
                            <el-select v-model="scope.row.component">
                                <el-option v-for="item in components" :key="item.id" :label="item.title" :value="item.value"></el-option>
                            </el-select>
                        </template>
                    </el-table-column>
                    <el-table-column prop="key" label="主键" width="50" align="center">
                        <template slot-scope="scope">
                            <el-checkbox v-model="scope.row.key"></el-checkbox>
                        </template>
                    </el-table-column>
                    <el-table-column prop="key" label="隐藏" width="50" align="center">
                        <template slot-scope="scope">
                            <el-checkbox v-model="scope.row.isHidden"></el-checkbox>
                        </template>
                    </el-table-column>
                    <el-table-column prop="key" label="必填" width="50" align="center">
                        <template slot-scope="scope">
                            <el-checkbox v-model="scope.row.isNull"></el-checkbox>
                        </template>
                    </el-table-column>
                    <el-table-column prop="key" label="查询" width="50" align="center">
                        <template slot-scope="scope">
                            <el-checkbox v-model="scope.row.isQuery"></el-checkbox>
                        </template>
                    </el-table-column>
                    <el-table-column prop="key" label="列表" width="50" align="center">
                        <template slot-scope="scope">
                            <el-checkbox v-model="scope.row.isTable"></el-checkbox>
                        </template>
                    </el-table-column>
                    <el-table-column prop="key" label="排序" width="50" align="center">
                        <template slot-scope="scope">
                            <el-checkbox v-model="scope.row.isSort"></el-checkbox>
                        </template>
                    </el-table-column>

                    <el-table-column prop="matchType" label="匹配方式" width="180">
                        <template slot-scope="scope">
                            <el-input v-model="scope.row.matchType"></el-input>
                        </template>
                    </el-table-column>
                    <el-table-column prop="enumType" label="字典类型" width="180">
                        <template slot-scope="scope">
                            <el-input v-model="scope.row.enumType"></el-input>
                        </template>
                    </el-table-column>
                </el-table>
            </el-form>
        </el-tab-pane>
    </el-tabs>
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
            apiUrl: this.$api.sys.tag,          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            tableHeight: GetHeight(280), // 列表高度       
            QueryParam: {},             //  搜索条件
            tableData: [],
            tableLoading: false,
            multipleSelection: [],      // 多选选中的值
            pagination: {
                page: 1,
                size: localStorage.getItem('pageSize') || 10,
            },
            totalCount: 0,      // 总共多少条

            /*  */
            tabsActiveName: 'list',
            /* 数据库 */
            tableForm: {},
            tableNameList: [],  // 已有数据表
            fieldList: {
                rules: {},
                data: [],
            },
            fieldLoading: false,
        };
    },
    created() {
        this.query();
        this.init();
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
        /* 编辑 */
        handleEdit() { },
        /* 字段列表 */
        generateField(tableName) {
            this.fieldLoading = true;
            this.$http.get(`${this.$api.generate.tableField}?name=${tableName}`).then(res => {
                this.fieldList.data = this.analyseField(res.data.rows);
                this.tabsActiveName = 'fielsList';
                this.fieldLoading = false;
            }).catch(() => {
                this.fieldLoading = false;
            })
        },
        /* 分析字段信息 */
        analyseField(fieldList) {
            return fieldList.map(item => {
                let type = item.type.match(/^[^(]*/);           //  匹配类型
                let maxlength = item.type.match(/\d+/);               //  匹配数字

                let component = type == 'datetime' ? 'el-date-picker' : '';

                let isHidden = item.field == 'created_at' || item.field == 'updated_at' || item.field == 'is_del' || item.key == 'PRI' ? true : false;  // 是否隐藏
                let isNull = item.key == 'PRI' || item.isNull == 'NO' ? true : false;  //   true 必填   false 非必填
                let isQuery = item.field == 'is_del' ? true : false;                // 查询
                let isSort = item.field == 'updated_at' || type == 'int' ? true : false;                 // 排序
                let isTable = item.field == 'created_at' || item.field == 'updated_at' || item.field == 'is_del' || item.key == 'PRI' ? false : true;                 // 列表
                return {
                    field: item.field,
                    comment: item.comment,
                    key: item.key || item.key == 'PRI' ? true : false,
                    component: component,
                    type: type,
                    maxlength: maxlength,

                    isHidden: isHidden,
                    isNull: isNull,
                    isQuery: isQuery,
                    isSort: isSort,
                    isTable: isTable,
                    enumType: '',
                    matchType: '',
                }
            })
        },

    }
};
</script>

<style lang="scss">
</style>
