<template>
    <el-tabs type="border-card" class="margin-8 pu-padding">
        <el-tab-pane>
            <span slot="label">
                <i class="el-icon-date"></i> 人员信息列表
            </span>
            <el-form :inline="true" :model="QueryParam" class="demo-form-inline">
                <el-form-item label="用户名">
                    <el-input v-model="QueryParam.username" placeholder="用户名"></el-input>
                </el-form-item>

                <el-form-item>
                    <el-button @click="query(1)" icon="el-icon-search"></el-button>
                </el-form-item>
                <el-form-item class="handle-button-right" >
                    <transition name="el-zoom-in-center">
                        <el-button type="danger" @click="delAll" v-show="multipleSelection.length>0">批量删除</el-button>
                    </transition>
                    <el-button @click="handleAdd()">新增</el-button>
                </el-form-item>
            </el-form>

            <el-table :data="tableData" :height="tableHeight" style="width: 100%" @selection-change="handleSelectionChange" header-row-class-name="table-header-color">
                <el-table-column type="selection" width="42"></el-table-column>
                <el-table-column prop="username" label="用户名称" show-overflow-tooltip></el-table-column>
                <el-table-column prop="realname" label="真实姓名" show-overflow-tooltip></el-table-column>
                <el-table-column prop="sex" label="性别" width="100">
                    <template slot-scope="scope">{{scope.row.sex==1?'男':'女'}}</template>
                </el-table-column>
                <el-table-column prop="phone" label="手机号码" show-overflow-tooltip></el-table-column>
                <el-table-column prop="email" label="邮箱" show-overflow-tooltip></el-table-column>
                <el-table-column prop="locked" label="状态" width="150">
                    <template slot-scope="scope">
                        <el-switch
                            class="switchStyle"
                            @change="switchFlag(scope.$index,scope.row)"
                            v-model="scope.row.locked"
                            active-text="启用"
                            inactive-text="锁定"
                            :active-value="0"
                            :inactive-value="1"
                        ></el-switch>
                    </template>
                </el-table-column>

                <el-table-column label="操作" width="240" >
                    <template slot-scope="scope">
                        <el-button type="text" size="mini" @click="handleEdit(scope.row)">编辑</el-button>
                        <el-button type="text" size="mini" @click="handleEditRole(scope.row)">分配角色</el-button>

                        <el-button type="text" size="mini" @click="handleReset(scope.row)">重置密码</el-button>

                        <el-button type="text" class="font-color-del" size="mini" @click="handleDelete(scope.row)">删除</el-button>
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

            <dialog-model v-model="dialogValue" title="人员信息" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
                <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                    <el-form-item label="用户名:" prop="username">
                        <el-input v-model="form.username" maxlength="20"></el-input>
                    </el-form-item>
                    <el-form-item label="密码:" prop="password" v-if="requestType == 'post'">
                        <el-input v-model="form.password" maxlength="32"></el-input>
                    </el-form-item>
                    <el-form-item label="真实姓名:" prop="realname">
                        <el-input v-model="form.realname" maxlength="20"></el-input>
                    </el-form-item>
                    <el-form-item label="性别" prop="sex">
                        <el-select v-model="form.sex">
                            <el-option label="男" :value="1"></el-option>
                            <el-option label="女" :value="0"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="手机号码:" prop="phone">
                        <el-input v-model="form.phone" maxlength="20"></el-input>
                    </el-form-item>
                    <el-form-item label="邮箱:" prop="email">
                        <el-input v-model="form.email" maxlength="50"></el-input>
                    </el-form-item>
                    <el-form-item label="状态:">
                        <el-switch class="switchStyle" v-model="form.locked" active-text="启用" inactive-text="锁定" :active-value="0" :inactive-value="1"></el-switch>
                    </el-form-item>
                </el-form>
            </dialog-model>

            <dialog-model
                v-model="dialogValueRole"
                title="角色分配信息"
                :width="536"
                :type="requestType"
                @submit="handleRoleUpdate"
                :loading-button="loadingButton2"
                @changeLoadingButton="loadingButton2 = false"
            >
                <user-role v-model="userRoleValue"></user-role>
            </dialog-model>
        </el-tab-pane>
    </el-tabs>
</template>
<script>
import { GetHeight, DeepCopy, ErrorLog, starLoading, closeLoading } from "@/utils/sys";
import api from "@/config/api";

import UserRole from '@/components/Sys/UserRole'
export default {
    components: {
        UserRole
    },
    data() {

        return {
            tableHeight: GetHeight(274), // 列表高度
            dialogValue: false, // 弹出框
            requestType: "post",
            pagination: {
                page: 1,
                size: 10,
                totalCount: 0
            },
            QueryParam: {},
            tableData: [],      // 表格数据
            form: {},           // 表单数据
            multipleSelection: [],    // 多选框，选中的值
            rules: {
                username: [
                    {
                        required: true,
                        message: "请输入用户名名称"
                    }
                ],
                password: [
                    {
                        required: true,
                        message: "请输入密码"
                    }
                ],
                realname: [
                    {
                        required: true,
                        message: "请输入真实的姓名"
                    }
                ],
                phone: [
                    {
                        required: true,
                        message: "请输入电话号码"
                    },
                ],
                sex: [
                    {
                        required: true
                    },
                ]
            },


            /* 分配角色 */
            dialogValueRole: false,
            tempSaveUser: '',    // 临时保存用户
            userRoleValue: [],   // 用户的角色信息
            loadingButton: false, // 新增或编辑 禁止重复提交
            loadingButton2: false // 分配角色禁止重复提交

        };
    },
    created() {
        this.query();
    },
    methods: {
        query(flag) {
            starLoading()
            if (flag == 1) this.pagination.page = 1;         // 查询时，让页面等于1
            let param = {
                ...this.pagination,
                ...this.QueryParam
            };
            this.$http.post(api.sys.sysuserList, param).then(res => {
                let data = res.data.data;
                this.tableData = data.list;
                this.pagination.size = data.pageSize;
                this.pagination.totalCount = data.totalCount;
                closeLoading()
            }).catch(err => {
                ErrorLog(err);
            });
        },
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
        /* 新增 */
        handleAdd() {
            this.dialogValue = true;
            this.requestType = "post";
            this.form = {
                email: '',
                sex: 1,
                locked: 0
            }
        },
        /* 编辑 */
        handleEdit(row) {
            this.dialogValue = true;
            this.requestType = "put";
            this.form = DeepCopy(row);
        },
        /* 删除 */
        handleDelete(row) {
            this.$confirm("此操作将永久删除信息, 是否继续?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "error"
            }).then(() => {
                let ids = [];
                ids.push(row.id);
                this.deleteRequestData(ids);
            }).catch(() => {
                this.dialogValue = false;
            });
        },
        /* 多选获取值 */
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        /* 批量删除 */
        delAll() {
            this.$confirm("此操作将永久删除信息, 是否继续?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "error"
            }).then(() => {
                let ids = this.multipleSelection.map(item => item.id);
                this.deleteRequestData(ids);
            }).catch(() => {
                this.dialogValue = false;
            });
        },
        /* 发送删除请求给后台 */
        deleteRequestData(ids) {
            this.$http.delete(`${api.sys.sysuser}`, { data: ids })
                .then(res => {
                    this.$message.success("删除成功");
                    this.dialogValue = false;
                    this.query();
                }).catch(err => {
                    this.dialogValue = false;
                    ErrorLog(err);
                });
        },
        /** 保存数据 */
        handleUpdate(requestType) {
            this.$refs.ruleForm.validate(valid => {
                if (valid) {
                    this.loadingButton = true
                    if (requestType == "post") {
                        this.$http.post(api.sys.sysuser, this.form).then(res => {
                            if (res.data.code == 500) {
                                this.$message.info(`${res.data.message}`)
                                this.loadingButton = false
                            } else {
                                this.dialogValue = false;
                                this.$message.success("添加成功");
                                this.query();
                            }
                        }).catch(err => {
                            this.dialogValue = false;
                            ErrorLog(err);
                        });
                    } else {
                        this.$http.put(api.sys.sysuser, this.form).then(res => {
                            this.dialogValue = false;
                            this.$message.success("修改成功");
                            this.query();
                        }).catch(err => {
                            this.dialogValue = false;
                            ErrorLog(err);
                        });
                    }
                } else {
                    // console.log("error submit!!");
                    return false;
                }
            });
        },




        /* 分配角色信息 */
        handleEditRole(row) {
            this.dialogValueRole = true;
            this.$http.post(api.sys.queryUserRole, { userId: row.id, userType: 0 }).then(res => {
                let data = res.data.data;
                this.userRoleValue = data.map(item => item.id);
                this.tempSaveUser = row.id;
            }).catch(err => {
                this.dialogValueRole = false;
                ErrorLog(err);
            });
        },
        /* 保存角色信息 */
        handleRoleUpdate() {
            let data = {
                userId: this.tempSaveUser,
                roleIds: this.userRoleValue,
                userType: 0
            }
            this.loadingButton2 = true
            this.$http.post(api.sys.sysuserrole, data).then(res => {
                if (res.data.message == 'success') {
                    this.$message.success('成功保存角色信息');
                }
                this.dialogValueRole = false;
            }).catch(err => {
                this.dialogValueRole = false;
                ErrorLog(err);
            });
        },
        // 按钮状态
        switchFlag(index, val) {
            this.$confirm('是否进行状态管理?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                // 参数
                let from = {
                    id: val.id,
                    locked: val.locked
                }
                this.$http.put(api.sys.sysuser, from).then(res => {
                    this.$message.success("修改成功");
                }).catch(err => {
                    ErrorLog(err)
                });
            }).catch(() => {
                // 状态取消修改 将状态变成原来的值
                if (val.locked) this.tableData[index].locked = 0
                else this.tableData[index].locked = 1
            });

        },
        /* 重置密码 */
        handleReset(row) {
            let form = {
                ...row,
                password: '123456',
            }
            this.$confirm("确认重置该账号的密码！", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "info"
            }).then(() => {

                this.$http.put(api.sys.sysuser, form).then(res => {
                    this.$message.success("重置成功");
                }).catch(err => {
                    ErrorLog(err);
                });

            })
        },
    }
};
</script>

<style lang="scss">
</style>
