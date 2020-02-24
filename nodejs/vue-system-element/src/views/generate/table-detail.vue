<template>
    <el-tabs type="border-card" class="margin-8" v-model="tabsActiveName">
        <el-tab-pane name="tableList">
            <span slot="label">
                <i class="el-icon-date"></i> 基本信息
            </span>
            <el-form :model="tableForm" label-width="140px" :rules="rules" ref="tableRef">
                <el-form-item label="表名" prop="tableName">
                    <el-select v-model="tableForm.tableName" filterable placeholder="请选择">
                        <el-option v-for="item in tableNameList" :key="item.table_name" :value="item.table_name">{{item.table_comment ? item.table_name + ' : ' +item.table_comment: item.table_name}}</el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="实体名称">
                    <el-input v-model="tableForm.tableClass" maxlength="128"></el-input>
                </el-form-item>
                <el-form-item label="表说明">
                    <el-input v-model="tableForm.comment" maxlength="255"></el-input>
                </el-form-item>
                <el-form-item label="作者">
                    <el-input v-model="tableForm.author" maxlength="128"></el-input>
                </el-form-item>
                <el-form-item label="备注">
                    <el-input v-model="tableForm.details" maxlength="255"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="generateField">下一步</el-button>
                </el-form-item>
            </el-form>
        </el-tab-pane>
        <el-tab-pane label="字段信息" name="fielsList">
            <el-form :model="fieldList" class="demo-form-inline">
                <el-table :data="fieldList.data" style="width: 100%" v-loading="fieldLoading" :height="fieldTableHeight">
                    <el-table-column prop="field" label="字段" width="100" show-overflow-tooltip>
                        <template slot-scope="scope">{{ scope.row.field }}</template>
                    </el-table-column>
                    <el-table-column prop="type" label="类型" width="100" show-overflow-tooltip>
                        <template slot-scope="scope">{{ scope.row.type }}</template>
                    </el-table-column>
                    <el-table-column prop="type" label="别名" width="180" show-overflow-tooltip>
                        <template slot-scope="scope">
                            <el-input v-model="scope.row.alias"></el-input>
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

                    <el-table-column prop="matchType" label="匹配方式" width="110">
                        <template slot-scope="scope">
                            <el-select v-model="scope.row.matchType">
                                <el-option v-for="item in matchTypeList" :key="item.id" :label="item.title" :value="item.value"></el-option>
                            </el-select>
                        </template>
                    </el-table-column>
                    <el-table-column prop="enumType" label="字典类型" width="180">
                        <template slot-scope="scope">
                            <el-input v-model="scope.row.enumType"></el-input>
                        </template>
                    </el-table-column>
                </el-table>
                <div class="pu-pagination" style="margin-top:20px">
                    <el-button type="primary" @click="handleSave">保存并生成代码</el-button>
                </div>
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
                tableName: [{ required: true, message: '请选择表名', trigger: 'blur' },],
            },
            fieldTableHeight: GetHeight(220), // 列表高度    
            /*  */
            tabsActiveName: 'tableList',
            /* 数据库 */
            tableForm: {},
            tableNameList: [],  // 已有数据表
            fieldList: {
                rules: {},
                data: [],
            },
            fieldLoading: false,


            /* 匹配方式 */
            matchTypeList: [{ id: '=', title: '=' }, { id: '!=', title: '!=' }, { id: 'like', title: 'like' }],
        };
    },
    created() {
        this.init();
    },
    methods: {
        init() {
            this.$http.get(this.$api.generate.tableName).then(res => {
                this.tableNameList = res.data.rows;
            })
        },
        /* 字段列表 */
        generateField() {
            this.$refs.tableRef.validate((valid) => {
                if (valid) {
                    this.tabsActiveName = 'fielsList';
                    this.fieldLoading = true;
                    this.$http.get(`${this.$api.generate.tableField}?name=${this.tableForm.tableName}`).then(res => {
                        this.fieldList.data = this.analyseField(res.data.rows);
                        this.fieldLoading = false;
                    }).catch(() => {
                        this.fieldLoading = false;
                    })
                }
            })
        },
        /* 分析字段信息 */
        analyseField(fieldList) {
            return fieldList.map(item => {
                let fieldType = item.type.match(/^[^(]*/);           //  匹配类型
                let maxlength = item.type.match(/\d+/);               //  匹配数字

                let component = fieldType == 'datetime' ? 'el-date-picker' : '';

                let isHidden = item.field == 'created_at' || item.field == 'updated_at' || item.field == 'is_del' || item.key == 'PRI' ? true : false;  // 是否隐藏
                let isNull = item.key == 'PRI' || item.isNull == 'NO' ? true : false;  //   true 必填   false 非必填
                let isQuery = item.field == 'is_del' ? true : false;                // 查询
                let isSort = item.field == 'updated_at' || fieldType == 'int' ? true : false;                 // 排序
                let isTable = item.field == 'created_at' || item.field == 'updated_at' || item.field == 'is_del' || item.key == 'PRI' ? false : true;                 // 列表
                return {
                    field: item.field,
                    type: item.type,
                    alias: this.toHump(item.field),
                    comment: item.comment,
                    key: item.key || item.key == 'PRI' ? true : false,
                    component: component,
                    fieldType: fieldType,
                    maxlength: maxlength,

                    isHidden: isHidden,
                    isNull: isNull,
                    isQuery: isQuery,
                    isSort: isSort,
                    isTable: isTable,
                    enumType: '',
                    matchType: '=',
                }
            })
        },
        /* 下划线转驼峰格式 */
        toHump(name) {
            return name.replace(/_(\w)/g, function (all, letter) {
                return letter.toUpperCase();
            });
        },


        handleSave() {
            console.log(this.fieldList);
        },

    }
};
</script>

<style lang="scss">
</style>
