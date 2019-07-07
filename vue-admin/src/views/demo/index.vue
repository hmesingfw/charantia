<template>
    <el-tabs type="border-card" v-model="activeName">
        <el-tab-pane name="list">
            <span slot="label">
                <i class="el-icon-date"></i> 列表
            </span>

            <el-form :model="query" label-width="80px" :inline="true" @submit.native.prevent>
                <el-form-item label="姓名">
                    <el-input v-model="query.name" placeholder="请输入"></el-input>
                </el-form-item>
                <el-form-item label="性别">
                    <el-select v-model="query.sex" placeholder="请选择">
                        <el-option
                            v-for="item in sexEnum"
                            :key="item.id"
                            :label="item.labelZh"
                            :value="item.value"
                        ></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item>
                    <el-button
                        type="primary"
                        icon="el-icon-search"
                        @click="queryHandle"
                        native-type="submit"
                    >查询</el-button>
                    <el-button type="primary" icon="el-icon-edit" @click="addHandle">增加</el-button>
                </el-form-item>
            </el-form>

            <el-table :data="tableData" style="width: 100%" :height="tableHeight">
                <el-table-column prop="name" label="姓名"></el-table-column>
                <el-table-column prop="sex" label="性别"></el-table-column>
                <el-table-column prop="adress" label="地址"></el-table-column>
                <el-table-column prop="code" label="编码 "></el-table-column>
                <el-table-column fixed="right" label="操作" width="100">
                    <template slot-scope="scope">
                        <el-button type="text" @click="editHandle(scope.row)">编辑</el-button>
                        <el-button type="text" @click="delHandle(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <el-pagination
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="currentPage"
                :page-sizes="[15, 32, 64]"
                :page-size="pageSize"
                :total="total"
                layout="total, sizes, prev, pager, next, jumper"
                class="pagination"
            ></el-pagination>
        </el-tab-pane>

        <el-tab-pane label="编辑" name="edit">
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="姓名" prop="name">
                    <el-input v-model="form.name"></el-input>
                </el-form-item>
                <el-form-item label="性别" prop="sex">
                    <el-select v-model="form.sex" placeholder="请选择">
                        <el-option
                            v-for="item in sexEnum"
                            :key="item.id"
                            :label="item.labelZh"
                            :value="item.value"
                        ></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="地址" prop="adress">
                    <el-input v-model="form.adress"></el-input>
                </el-form-item>
                <el-form-item label="编码" prop="code">
                    <el-input v-model="form.code"></el-input>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="onSubmit">立即创建</el-button>
                    <el-button @click="activeName = 'list'">取消</el-button>
                </el-form-item>
            </el-form>
        </el-tab-pane>
    </el-tabs>
</template>
<script>
import { getHeight } from "@/utils/sys";
import { mapState } from "vuex";
export default {
    data () {
        return {
            activeName: "list", // tabs 状态

            query: {},      // 查询条件
            selectOptions: [],
            tableData: [],  // 表格数据
            tableHeight: '',

            /** 分页 */
            currentPage: 1,
            pageSize: 16,
            total: 1,

            form: {},   // 表单
            rules: {
                name: [
                    { required: true, message: '请输入', trigger: 'blur' },
                ],
            },   // 验证

            sexEnum: [],
        }
    },
    created () {
        this.setHeight();
        this.queryHandle();


        this.enumList.forEach(data => {
            // 性别
            if (data.type == 'sex') {
                this.sexEnum.push(data);
            }
        });
    },
    computed: mapState({
        enumList: state => state.sys.enumList
    }),
    methods: {
        getHeight,
        /** 分页 */
        handleSizeChange (val) {
            this.pageSize = val;
            this.queryHandle();
        },
        handleCurrentChange (val) {
            this.currentPage = val;
            this.queryHandle();
        },


        /** 表单查询方法 */
        queryHandle () {
            let condition = {
                query: this.query,
                currentPage: this.currentPage,
                pageSize: this.pageSize,
            }
            this.$http.post(`/egg/sys/datas`, condition).then(res => {
                this.tableData = res.data.data;
                this.total = res.data.total;
            }).catch(err => {
                this.$message(err);
            })
        },
        /** 增加表单 */
        addHandle () {
            this.activeName = 'edit';
            this.form = {
                name: '',
                sex: '1',
                adress: '',
                code: ''
            }
        },
        /** 编辑表单 */
        editHandle (row) {
            this.activeName = 'edit';
            this.form = { ...row };
        },
        /** 删除表单 */
        delHandle (row) {
            this.$confirm(this.$t('basic.comfirmDelete'), this.$t('basic.prompt'), {
                confirmButtonText: this.$t('basic.define'),
                cancelButtonText: this.$t('basic.cancel'),
                type: 'warning'
            }).then(() => {
                this.$http.post(`/egg/sys/delete`, { id: row.id }).then(res => {
                    if (res.data == 1) {
                        this.queryHandle();
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
        // 保存与修改
        onSubmit () {
            this.$refs.form.validate((valid) => {
                if (valid) {
                    this.$http.post(`/egg/sys/save`, this.form).then(res => {
                        if (res.data == '1') {
                            this.$message.success(this.$t('basic.saveSuc'))
                            this.queryHandle();
                            this.activeName = 'list';
                        } else {
                            this.$message(this.$t('basic.saveFail'));
                        }
                    }).catch(err => {
                        this.$message(err);
                    })
                } else {
                    return false;
                }
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

.el-form {
    display: flex;
    flex-wrap: wrap;

    .el-form-item {
        width: 50%;
    }
}
</style>
