<template>
    <el-tabs type="border-card" class="margin-8 pu-padding">
        <el-tab-pane>
            <span slot="label">
                <i class="el-icon-date"></i> 角色信息列表
            </span>
            <el-form :inline="true" :model="QueryParam" class="demo-form-inline">
                <el-form-item label="角色名">
                    <el-input v-model="QueryParam.name" placeholder="角色名"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button @click="query(1)" icon="el-icon-search"></el-button>
                </el-form-item>
                <el-form-item class="handle-button-right">
                    <transition name="el-zoom-in-center">
                        <el-button type="danger" @click="delAll" v-show="multipleSelection.length>0">批量删除</el-button>
                    </transition>
                    <el-button @click="handleAdd()">新增</el-button>
                </el-form-item>
            </el-form>

            <el-table :data="tableData" :height="tableHeight" style="width: 100%" @selection-change="handleSelectionChange" header-row-class-name="table-header-color">
                <el-table-column type="selection" width="42"></el-table-column>
                <el-table-column prop="name" label="角色名称" show-overflow-tooltip></el-table-column>
                <el-table-column prop="description" label="角色描述" show-overflow-tooltip></el-table-column>
                <el-table-column label="操作" width="200">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" @click="handleEdit(scope.row)">编辑</el-button>

                        <el-button size="mini" type="text" @click="handleTreeEdit(scope.row)">权限管理</el-button>
                        <el-button size="mini" type="text" class="font-color-del" @click="handleDelete(scope.row)">删除</el-button>
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
                    <el-form-item label="角色名称:" prop="name">
                        <el-input v-model="form.name" maxlength="20"></el-input>
                    </el-form-item>
                    <el-form-item label="角色描述:" prop="description">
                        <el-input v-model="form.description" maxlength="1000"></el-input>
                    </el-form-item>
                    <el-form-item label="角色标题:" prop="title">
                        <el-input v-model="form.title" maxlength="20"></el-input>
                    </el-form-item>
                    <el-form-item label="序号:" prop="orders">
                        <el-input-number v-model="form.orders" :min="0"></el-input-number>
                    </el-form-item>
                </el-form>
            </dialog-model>
            <dialog-model v-model="dialogTreeValue" title="权限列表" :type="requestType" @submit="handleTreeUpdate" :loading-button="loadingButton2" @changeLoadingButton="loadingButton2 = false">
                <permission-tree ref="permissionRole" :value="rolePerValue" v-if="reFresh"></permission-tree>
            </dialog-model>
        </el-tab-pane>
    </el-tabs>
</template>
<script>
import { GetHeight, DeepCopy, ErrorLog, starLoading, closeLoading } from "@/utils/sys";
import api from "@/config/api";
import PermissionTree from "@/components/Sys/PermissionTree";

export default {
    components: {
        PermissionTree
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
                name: [
                    {
                        required: true,
                        message: "请输入角色名名称"
                    }
                ],
                password: [
                    {
                        required: true,
                        message: "请输入角色标题"
                    }
                ],
                description: [
                    {
                        required: true,
                        message: "请输入角色描述"
                    }
                ]
            },

            reFresh: true,
            /* 权限列表 */
            dialogTreeValue: false,             // 弹出框控制
            tempSaveRole: '',
            rolePerValue: [],
            loadingButton: false, // 新增或编辑 禁止重复点击
            loadingButton2: false, // 权限管理禁止重复点击
        };
    },
    created() {
        this.query();
    },
    methods: {
        /* 查询操作 */
        query(flag) {
            starLoading()
            if (flag == 1) this.pagination.page = 1;         // 查询时，让页面等于1
            let param = {
                ...this.pagination,
                ...this.QueryParam
            };
            this.$http.post(api.sys.sysroleList, param).then(res => {
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
                orders: 1
            }
        },
        // 编辑
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
            this.$http.delete(`${api.sys.sysrole}`, { data: ids }).then(res => {
                if (res.data.flag === false) {
                    this.$message.error(res.data.message);
                } else {
                    this.$message.success('删除成功');
                }
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
                        this.$http.post(api.sys.sysrole, this.form).then(res => {

                            this.dialogValue = false;
                            this.$message.success("添加成功");
                            this.query();
                        }).catch(err => {
                            this.dialogValue = false;
                            ErrorLog(err);

                        });
                    } else {
                        this.$http.put(api.sys.sysrole, this.form).then(res => {
                            this.dialogValue = false;
                            this.$message.success("修改成功");
                            this.query();
                        }).catch(err => {
                            this.dialogValue = false;
                            ErrorLog(err)
                        });
                    }
                } else {
                    return false;
                }
            });
        },

        /* ----------- */
        /* 权限管理 */
        handleTreeEdit(row) {
            this.dialogTreeValue = true;

            this.$http.post(api.sys.queryRolePermission, { roleId: row.id }).then(res => {
                let data = res.data.data;

                this.rolePerValue = data.map(item => item.id);
                this.tempSaveRole = row.id;

                this.reFresh = false
                this.$nextTick(() => {
                    this.reFresh = true
                })

            }).catch(err => {
                this.dialogTreeValue = false;
                ErrorLog(err);
            });
        },
        /* 保存权限配置至后台 */
        handleTreeUpdate() {
            let keys = this.$refs.permissionRole.getCheckedKeys();
            let arr = keys.map(item => item.id);
            this.loadingButton2 = true
            this.$http.post(api.sys.sysrolepermission, { roleId: this.tempSaveRole, permissionIds: arr }).then(res => {

                if (res.data.message == 'success') {
                    this.$message.success('成功保存角色权限信息');
                }
                this.dialogTreeValue = false;
            }).catch(err => {
                this.dialogTreeValue = false;
                ErrorLog(err);
            });

        },
    }
};
</script>

<style lang="scss">
</style>
