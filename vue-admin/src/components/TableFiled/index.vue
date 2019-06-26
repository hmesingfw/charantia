<template>
    <el-form ref="form" :rules="form.rules" :model="form" v-loading="loading">
        <el-table :data="form.tableData" style="width: 100%" :height="tableHeight">
            <el-table-column fixed prop="Field" label="字段名" width="150"></el-table-column>
            <el-table-column fixed prop="FieldType" label="字段类型" width="150"></el-table-column>
            <el-table-column fixed prop="FieldLength" label="字段长度" width="150"></el-table-column>
            <el-table-column fixed label="组件类型" width="150">
                <template slot-scope="scope">
                    <el-form-item
                        :prop="'tableData.' + scope.$index + '.componentType'"
                        :rules="form.rules.select"
                    >
                        <el-select v-model="scope.row.componentType" placeholder="请选择">
                            <el-option
                                v-for="item in componentTypeList"
                                :key="item.id"
                                :label="language == 'zh' ? item.labelZh : item.labelEn"
                                :value="item.value"
                            ></el-option>
                        </el-select>
                    </el-form-item>
                </template>
            </el-table-column>
            <el-table-column fixed label="新增显示" width="50">
                <template slot-scope="scope">
                    <el-form-item :prop="'tableData.' + scope.$index + '.addShow'">
                        <el-checkbox v-model="scope.row.addShow"></el-checkbox>
                    </el-form-item>
                </template>
            </el-table-column>

            <el-table-column fixed label="编辑显示" width="50">
                <template slot-scope="scope">
                    <el-form-item :prop="'tableData.' + scope.$index + '.editShow'">
                        <el-checkbox v-model="scope.row.editShow"></el-checkbox>
                    </el-form-item>
                </template>
            </el-table-column>

            <el-table-column fixed label="列表显示" width="50">
                <template slot-scope="scope">
                    <el-form-item :prop="'tableData.' + scope.$index + '.listShow'">
                        <el-checkbox v-model="scope.row.listShow"></el-checkbox>
                    </el-form-item>
                </template>
            </el-table-column>

            <el-table-column fixed label="验证类型" width="150">
                <template slot-scope="scope">
                    <el-form-item
                        :prop="'tableData.' + scope.$index + '.validateType'"
                        :rules="form.rules.select"
                    >
                        <el-select v-model="scope.row.validateType" placeholder="请选择">
                            <el-option
                                v-for="item in validateList"
                                :key="item.id"
                                :label="language == 'zh' ? item.labelZh : item.labelEn"
                                :value="item.value"
                            ></el-option>
                        </el-select>
                    </el-form-item>
                </template>
            </el-table-column>
        </el-table>
        <el-form-item class="handle">
            <el-button type="primary" @click="onSubmit">立即创建</el-button>
        </el-form-item>
    </el-form>
</template>

<script>
import { getHeight } from "@/utils/sys";
import { mapState } from 'vuex';
export default {
    props: {
        tableName: [String]
    },
    created () {
        this.init();
        this.setHeight();
    },
    computed: {
        ...mapState({
            componentTypeList: state => state.sys.componentTypeList,
            language: state => state.app.language,
            validateList: state => state.sys.validateList,
        })
    },
    data () {
        return {
            loading: false,
            tableHeight: '250px',
            form: {
                rules: {
                    select: { type: "string", required: true, message: "必填字段", trigger: "change" },
                    show: { type: "string", required: true, message: "必填字段", trigger: "change" },
                },
                tableData: []
            }
        }
    },
    methods: {
        init () {
            this.loading = true;
            this.$http.get(`/egg/getTableFiled?tableName=${this.tableName}`).then(res => {
                // console.log(res);
                let list = res.data.map(item => {
                    // 过滤字段类型
                    let type = item.Type.indexOf('(') != -1 ? item.Type.substring(0, item.Type.indexOf('(')) : item.Type;
                    // 类型长度
                    let length = item.Type.indexOf('(') != -1 ? item.Type.substring(item.Type.indexOf('(') + 1, item.Type.indexOf(')')) : '';
                    return {
                        Field: item.Field,
                        FieldType: type,
                        FieldLength: length,

                        componentType: 'el-input',
                        addShow: true,
                        editShow: true,
                        listShow: true,
                        validateType: '',
                    }
                })
                this.$set(this.form, 'tableData', list);
                this.loading = false;

            }).catch(err => {
                this.loading = false;
                this.$message(err);
            })
        },

        /** 保存数据 */
        onSubmit () {
            // console.log(this.form.tableData);
            this.$http.post(`/egg/generate/single`).then(res => {
                console.log(res);
            }).catch(err => {
                this.$message(err);
            })
        },
        /** 设置表格高度，好适应屏幕 */
        setHeight () {
            // 200 为当面页面偏差
            this.tableHeight = getHeight(250);
        }
    }
}
</script>

<style lang="less" scoped>
.handle {
    text-align: center;
    padding-top: 10px;
    margin-bottom: 0px;
}
</style>
