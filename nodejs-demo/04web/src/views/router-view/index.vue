<template>
    <el-tabs type="border-card" class="margin-8 pu-padding">
        <el-tab-pane>
            <span slot="label">
                <i class="el-icon-date"></i> 菜单管理
            </span>

            <el-form :inline="true" :model="formQuery" class="demo-form-inline">
                <el-form-item label="名称">
                    <el-input v-model="formQuery.name" placeholder="名称"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button @click="fitler" icon="el-icon-search"></el-button>
                </el-form-item>
                <el-form-item class="handle-button-right">
                    <el-button @click="handleAdd({id:0})">新增父标签</el-button>
                </el-form-item>
            </el-form>
            <el-table
                :data="tableData"
                :height="tableHeight"
                style="width: 100%;"
                row-key="id"
                :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
                header-row-class-name="table-header-color"
            >
                <el-table-column prop="uri" label="路径" width="140"></el-table-column>
                <el-table-column prop="name" label="名称" show-overflow-tooltip></el-table-column>

                <el-table-column label="类型" width="100">
                    <template slot-scope="scope">
                        <span v-if="scope.row.type == '1'">目录</span>
                        <span v-if="scope.row.type == '2'">菜单</span>
                        <span v-if="scope.row.type == '3'">按钮</span>
                    </template>
                </el-table-column>
                <el-table-column prop="orders" label="序号" width="100"></el-table-column>
                <el-table-column prop="component" label="页面路径" width="140" show-overflow-tooltip></el-table-column>
                <el-table-column prop="value" label="权限" show-overflow-tooltip></el-table-column>

                <el-table-column label="状态" width="150">
                    <template slot-scope="scope">
                        <el-switch
                            class="switchStyle"
                            @change="switchFlag(scope.row)"
                            :disabled="scope.row.disabled"
                            v-model="scope.row.status"
                            active-text="启用"
                            inactive-text="禁用"
                            :active-value="0"
                            :inactive-value="1"
                        ></el-switch>
                    </template>
                </el-table-column>

                <el-table-column prop="icon" label="图标" width="150" show-overflow-tooltip></el-table-column>
                <el-table-column label="操作" width="180" fixed="right" header-align="center" align="right">
                    <template slot-scope="scope">
                        <el-button type="text" v-if="scope.row.type != '3'" @click="handleAdd(scope.row)">新增子标签</el-button>
                        <el-button type="text" @click="handleEdit(scope.row)">编辑</el-button>
                        <el-button type="text" class="font-color-del" @click="handleDelete(scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <dialog-model v-model="dialogValue" :type="requestType" title="菜单信息" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
                <el-form label-position="right" label-width="80px" :rules="rules" :model="form" ref="ruleForm">
                    <el-form-item label="路径:">
                        <el-input v-model="form.uri"></el-input>
                    </el-form-item>
                    <el-form-item label="名称:" prop="name">
                        <el-input v-model="form.name" maxlength="100"></el-input>
                    </el-form-item>

                    <el-form-item label="类型:" prop="type">
                        <el-select v-model="form.type">
                            <el-option label="目录" :value="1"></el-option>
                            <el-option label="菜单" :value="2"></el-option>
                            <el-option label="按钮" :value="3"></el-option>
                        </el-select>
                    </el-form-item>

                    <el-form-item label="图标:">
                        <el-input v-model="form.icon" maxlength="50"></el-input>
                    </el-form-item>

                    <el-form-item label="页面路径:">
                        <el-input v-model="form.component" maxlength="50"></el-input>
                    </el-form-item>
                    <el-form-item label="权限:">
                        <el-input v-model="form.value" maxlength="50"></el-input>
                    </el-form-item>

                    <el-form-item label="状态:">
                        <el-switch class="switchStyle" v-model="form.status" active-text="启用" inactive-text="禁用" :active-value="0" :inactive-value="1"></el-switch>
                    </el-form-item>

                    <el-form-item label="序号:">
                        <el-input-number v-model="form.orders" :min="0"></el-input-number>
                    </el-form-item>
                </el-form>
            </dialog-model>
        </el-tab-pane>
    </el-tabs>
</template>
<script>
import { GetHeight, DeepCopy, ErrorLog, starLoading, closeLoading } from "@/utils/sys";
import api from "@/config/api";

export default {
    // 路由视图
    data() {
        return {
            switchDg: Boolean,
            tableHeight: GetHeight(240), // 列表高度
            dialogValue: false,
            requestType: "post",
            tableData: [],
            tableDataTemp: [],
            form: {},
            formQuery: {},
            rules: {
                name: [
                    {
                        required: true,
                        message: "请输入菜单名称",
                        trigger: "blur"
                    }
                ],
                type: [
                    {
                        required: true,
                        message: "请选择标签类型",
                        trigger: "change"
                    }
                ]
            },
            loadingButton: false
        };
    },
    created() {
        this.query();
    },
    methods: {
        /** 查询数据 */
        query() {
            starLoading()
            this.$http.post(api.sys.syspermissionList, {
                page: 1,
                size: 1000
            }).then(res => {
                let data = res.data.data;
                this.tableData = data.list;
                this.tableDataTemp = data.list;
                this.dgg()
                closeLoading()
            }).catch(err => {
                ErrorLog(err);
            });
        },
        // 页面加载时调用递归tabledata实现启用禁用
        dgg() {
            for (let i = 0; i < this.tableData.length; i++) {
                this.switchDg = this.tableData[i].status
                this.digbl(this.tableData[i])
            }
        },
        // 递归树结构实现启用禁用
        digbl(obj) {
            if (obj.children.length) {
                for (let node in obj.children) {
                    if (this.switchDg == 0 && obj.status == 0) { // 最外层和上级都打开
                        this.$set(obj.children[node], 'disabled', false)
                    } else {
                        this.$set(obj.children[node], 'disabled', true)
                    }
                    this.digbl(obj.children[node])
                }
            }
        },
        // 按钮状态
        switchFlag(row) {
            this.$confirm('是否进行状态管理?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                // 参数
                let from = {
                    id: row.id,
                    status: row.status
                }
                this.$http.put(api.sys.syspermission, from).then(res => {
                    this.$message.success("修改成功");
                    this.switchDg = row.status
                    console.log(row)
                    console.log('switch:', this.switchDg)
                    this.digbl(row)
                }).catch(err => {
                    ErrorLog(err)
                });
            }).catch(() => {
                // 状态取消修改 将状态变成原来的值
                if (row.status) this.$set(row, 'status', 0)
                else this.$set(row, 'status', 1)
                this.switchDg = row.status
                console.log('switch:', this.switchDg)
                this.digbl(row)
            });

        },
        handleAdd(row) {
            this.dialogValue = true;
            let temp = {
                pid: row.id + "",
                status: 0,
                orders: 1
            };
            this.requestType = "post";
            this.form = temp;
        },
        /** 打开编辑表单 */
        handleEdit(row) {
            this.dialogValue = true;
            this.requestType = "put";
            this.form = DeepCopy(row);
        },
        /** 保存数据 */
        handleUpdate(requestType) {
            this.$refs.ruleForm.validate(valid => {
                if (valid) {
                    this.loadingButton = true
                    if (requestType == "post") {
                        this.$http.post(api.sys.syspermission, this.form)
                            .then(res => {
                                this.dialogValue = false;
                                this.$message.success("添加成功");
                                this.query();
                            }).catch(err => {
                                this.dialogValue = false;
                                ErrorLog(err);
                            });
                    } else {
                        this.$http.put(api.sys.syspermission, this.form)
                            .then(res => {
                                this.dialogValue = false;
                                this.$message.success("修改成功");
                                this.query();
                            }).catch(err => {
                                this.dialogValue = false;
                                ErrorLog(err);
                            });
                    }
                } else {
                    console.log("error submit!!");
                    return false;
                }
            });
        },
        /* 删除数据 */
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
        deleteRequestData(ids) {
            this.$http.delete(`${api.sys.syspermission}`, { data: ids }).then(res => {
                if (res.data.flag === false) {
                    this.$message.error(res.data.message);
                } else {
                    this.$message.success("删除成功");
                }
                this.dialogValue = false;
                this.query();
            }).catch(err => {
                this.dialogValue = false;
                ErrorLog(err);
            });
        },
        /* 树形结构过滤信息 */
        fitler() {
            // 不是查询操作不调用加载界面
            starLoading()
            let temp = this.filterTree(this.tableDataTemp, this.shopfilterNode);
            this.tableData = temp;
            closeLoading()
        },

        filterTree(nodes, predicate, childKey = "children") {
            //predicate过滤条件函数
            if (!nodes || !nodes.length) return void 0;
            const children = [];
            for (let node of nodes) {
                node = Object.assign({}, node);
                const sub = this.filterTree(
                    node[childKey],
                    predicate,
                    childKey
                );
                if ((sub && sub.length) || predicate(node)) {
                    sub && (node[childKey] = sub);
                    children.push(node);
                }
            }
            return children.length ? children : void 0;
        },
        shopfilterNode(data) {
            return data.name.indexOf(this.formQuery.name) != -1;
        }
    }
};
</script>
<style lang="scss">
.margin-16 {
    .el-tabs__content {
        padding: 15px 15px 10px 15px;
    }
}
</style>
