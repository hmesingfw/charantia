<template>
    <div>
        <el-tabs type="border-card" class="margin-8 pu-padding" v-model="actionTabs">
            <el-tab-pane name="list">
                <span slot="label">
                    <i class="el-icon-date"></i> 医生信息
                </span>
                <el-form :inline="true" :model="QueryParam" class="demo-form-inline">
                    <el-form-item label="姓名">
                        <el-input v-model="QueryParam.name" placeholder="请输入"></el-input>
                    </el-form-item>
                    <el-form-item label="科室">
                        <el-select v-model="QueryParam.department" placeholder="请选择" clearable>
                            <el-option v-for="item in sectionOffice" :key="item.id" :label="item.name" :value="item.id"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="类型">
                        <el-select v-model="QueryParam.type" placeholder="请选择" clearable>
                            <el-option v-for="item in type" :key="item.id" :label="item.name" :value="item.id"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="职称">
                        <el-select v-model="QueryParam.level" placeholder="请选择" clearable>
                            <el-option v-for="item in doctor" :key="item.id" :label="item.name" :value="item.id"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item>
                        <el-button @click="query(1)" icon="el-icon-search"></el-button>
                        <el-button @click="handleEdit({}, 'post')" icon="el-icon-edit"></el-button>
                        <el-button @click="handleDelete({})" icon="el-icon-delete" v-show="multipleSelection.length>0"></el-button>
                    </el-form-item>
                </el-form>

                <el-table :data="tableData" :height="tableHeight" @selection-change="handleSelectionChange" style="width: 100%" header-row-class-name="table-header-color">
                    <el-table-column type="selection" width="42"></el-table-column>
                    <el-table-column prop="name" label="姓名" show-overflow-tooltip></el-table-column>

                    <el-table-column prop="age" label="年龄" show-overflow-tooltip></el-table-column>
                    <el-table-column label="性别" show-overflow-tooltip>
                        <template slot-scope="scope">{{ scope.row.sex == 1 ? '男' : '女'}}</template>
                    </el-table-column>

                    <el-table-column label="职称" show-overflow-tooltip>
                        <template slot-scope="scope">{{ scope.row.levelEntity ? scope.row.levelEntity.name : ''}}</template>
                    </el-table-column>
                    <el-table-column label="科室" show-overflow-tooltip>
                        <template slot-scope="scope">{{ scope.row.departEntity ? scope.row.departEntity.name : '' }}</template>
                    </el-table-column>
                    <el-table-column prop="type" label="类型" show-overflow-tooltip>
                        <template slot-scope="scope">
                            <div v-for="item in type" :key="item.id">
                                <span v-if="scope.row.type == item.id">{{item.name}}</span>
                            </div>
                        </template>
                    </el-table-column>

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
                <el-form-item label="姓名" prop="name">
                    <el-input v-model="form.name" maxlength="50"></el-input>
                </el-form-item>

                <el-form-item label="性别" prop="sex">
                    <el-radio-group v-model="form.sex">
                        <el-radio :label="1">男</el-radio>
                        <el-radio :label="0">女</el-radio>
                    </el-radio-group>
                </el-form-item>

                <el-form-item label="年龄" prop="age">
                    <el-input-number v-model="form.age" :min="10" :max="150"></el-input-number>
                </el-form-item>

                <el-form-item label="类型" prop="type">
                    <el-select v-model="form.type">
                        <el-option v-for="item in type" :key="item.id" :label="item.name" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="职称" prop="level">
                    <span v-if="!form.type" class="color-font">请选择类型</span>
                    <el-select v-model="form.level" v-if="form.type == enumval.doctor">
                        <el-option v-for="item in doctor" :key="item.id" :label="item.name" :value="item.id"></el-option>
                    </el-select>
                    <el-select v-model="form.level" v-if="form.type ==  enumval.nurseType">
                        <el-option v-for="item in nurseType" :key="item.id" :label="item.name" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="科室" prop="department">
                    <el-select v-model="form.department">
                        <el-option v-for="item in sectionOffice" :key="item.id" :label="item.name" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
        </dialog-model>
    </div>
</template>
<script>
import { GetHeight, deleteRequestData, DeepCopy, ErrorLog } from "@/utils/sys";
import api from "@/config/api";
import { mapState } from 'vuex'

export default {
    computed: {
        ...mapState({
            sectionOffice: state => state.enums.sectionOffice,
            type: state => state.enums.type,
            doctor: state => state.enums.doctor,
            nurseType: state => state.enums.nurseType,
            enumval: state => state.enumsValue.enumval,
        })
    },
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
                name: [{ required: true, message: '请输入姓名', trigger: 'blur' },],
                doctorId: [{ required: true, message: '请选择', trigger: 'blur' },],
                sickbedId: [{ required: true, message: '请选择', trigger: 'blur' },],
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
            this.$http.get(api.sys.doctor, { params: param }).then(res => {
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
                        this.$http.post(api.sys.doctor, this.form).then(res => {
                            this.dialogValue = false;
                            this.$message.success(res.data.message);
                            this.query();
                        }).catch(err => {
                            this.dialogValue = false;
                            ErrorLog(err)
                        });
                    } else {
                        this.$http.put(api.sys.doctor, this.form).then(res => {
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
            let message = await this.deleteRequestData(api.sys.doctor, ids);
            if (message) this.query();
        },
    }
};
</script>

<style lang="scss">
</style>
