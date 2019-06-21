<template>
    <div>
        <el-tabs type="border-card">
            <el-tab-pane>
                <span slot="label">
                    <i class="el-icon-date"></i> 枚举列表
                </span>

                <el-form :model="query" label-width="80px" :inline="true">
                    <el-form-item label="活动名称">
                        <el-input v-model="query.labelZh"></el-input>
                    </el-form-item>
                    <el-form-item label="活动名称">
                        <el-input v-model="query.labelEn"></el-input>
                    </el-form-item>
                    <el-form-item label="活动区域">
                        <el-select v-model="query.type" placeholder="请选择活动区域">
                            <el-option label="区域一" value="shanghai"></el-option>
                            <el-option label="区域二" value="beijing"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" icon="el-icon-search">查询</el-button>
                        <el-button type="primary" icon="el-icon-search" @click="addEnum">增加</el-button>
                    </el-form-item>
                </el-form>

                <el-table :data="tableData" style="width: 100%" :height="tableHeight">
                    <el-table-column prop="type" label="枚举类型" width="180"></el-table-column>
                    <el-table-column prop="labelZh" label="枚举名称-中文"></el-table-column>
                    <el-table-column prop="labelEn" label="枚举名称-英文"></el-table-column>
                    <el-table-column prop="value" label="枚举值 "></el-table-column>
                    <el-table-column fixed="right" label="操作" width="100">
                        <template slot-scope="scope">
                            <el-button type="text" @click="editEnum(scope.row)">编辑</el-button>
                            <el-button type="text" @click="delEnum(scope.row)">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table>

                <el-pagination
                    @size-change="handleSizeChange"
                    @current-change="handleCurrentChange"
                    :current-page="currentPage"
                    :page-sizes="[5, 30, 60]"
                    :page-size="pageSize"
                    :total="total"
                    layout="total, sizes, prev, pager, next, jumper"
                    class="pagination"
                ></el-pagination>
            </el-tab-pane>
        </el-tabs>

        <el-dialog title="提示" :visible.sync="dialogVisible" width="30%">
            <el-form ref="form" :model="form" :rules="rules" label-width="120px">
                <el-form-item label="枚举类型" prop="type">
                    <el-input v-model="form.type"></el-input>
                </el-form-item>
                <el-form-item label="枚举名称-中文" prop="labelZh">
                    <el-input v-model="form.labelZh"></el-input>
                </el-form-item>
                <el-form-item label="枚举名称-英文" prop="labelEn">
                    <el-input v-model="form.labelEn"></el-input>
                </el-form-item>
                <el-form-item label="枚举值" prop="value">
                    <el-input v-model="form.value"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">{{ $t('basic.cancel') }}</el-button>
                <el-button type="primary" @click="saveEnum">{{ $t('basic.save') }}</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import { getHeight } from "@/utils/sys";
export default {
    data () {
        return {
            dialogVisible: false,

            query: {
                labelZh: '',
                labelEn: '',
                type: ''
            },      // 查询表单
            tableData: [],


            currentPage: 1,
            pageSize: 5,
            total: 1,

            form: {},             // 表单
            rules: {
                type: [
                    { required: true, message: '请输入！', trigger: 'blur' },
                ],
                labelZh: [
                    { required: true, message: '请输入！', trigger: 'blur' },
                ],
                labelEn: [
                    { required: true, message: '请输入！', trigger: 'blur' },
                ],
                value: [
                    { required: true, message: '请输入！', trigger: 'blur' },
                ],
            },                      // 验证
            tableHeight: '',        //表格高度
        }
    },
    created () {
        this.init();
    },
    methods: {
        /** 分页 */
        handleSizeChange (val) {
            this.queryEnum();
        },
        handleCurrentChange (val) {
            this.queryEnum();
        },

        init () {
            this.queryEnum();
            this.setHeight();
        },
        /** 查询枚举 */
        queryEnum () {
            let condition = {
                query: this.query,
                currentPage: this.currentPage,
                pageSize: this.pageSize,
            }
            console.log(condition);
            this.$http.post(`/egg/getAllEnum`, condition).then(res => {
                console.log(res);
                this.tableData = res.data.data;
                this.total = res.data.total;
            })
        },

        /** 打开枚举表单面板 */
        addEnum () {
            this.dialogVisible = true;
            this.form = {
                type: '',
                labelZh: '',
                labelEn: '',
                value: ''
            }
        },
        /** 新增枚举 */
        saveEnum () {
            this.$refs.form.validate((valid) => {
                if (valid) {
                    this.$http.post(`/egg/addEnum`, this.form).then(res => {
                        console.log(res);
                        if (res.data == '1') {
                            this.$message.success(this.$t('basic.saveSuc'))
                        } else {
                            this.$message(this.$t('basic.saveFail'));
                        }
                        this.dialogVisible = false;
                    }).catch(err => {
                        this.$message(err);
                    })
                } else {
                    return false;
                }
            });
        },

        /** 编辑枚举 */
        editEnum (row) {
            this.dialogVisible = true;
            this.form = row;
        },
        /** 删除枚举 */
        delEnum (row) {
            this.$confirm(this.$t('basic.comfirmDelete'), this.$t('basic.prompt'), {
                confirmButtonText: this.$t('basic.define'),
                cancelButtonText: this.$t('basic.cancel'),
                type: 'warning'
            }).then(() => {
                this.$http.post(`/egg/delEnum`, { id: row.id }).then(res => {
                    if (res.data == 1) {
                        this.init();
                        this.$message.success(this.$t('basic.delSuc'));
                    } else {
                        this.$message(this.$t('basic.delFail'));
                    }
                }).catch(err => {
                    this.$message(err)
                })
            }).catch(() => {
                this.$message(this.$t('basic.delCancel'));
            });
        },
        /** 设置高度 */
        setHeight () {
            this.tableHeight = getHeight(290);
        },

    }
}
</script>

<style lang="less" scoped>
.pagination {
    text-align: center;
    padding-top: 12px;
}
</style>
