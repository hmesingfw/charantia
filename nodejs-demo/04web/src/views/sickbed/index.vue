<template>
    <div>
        <el-tabs type="border-card" class="margin-8 pu-padding" v-model="actionTabs">
            <el-tab-pane name="list">
                <span slot="label">
                    <i class="el-icon-date"></i> 病床信息
                </span>
                <el-form :inline="true" :model="QueryParam" class="demo-form-inline">
                    <el-form-item label="住院楼">
                        <el-input v-model="QueryParam.roofBeam" placeholder="请输入"></el-input>
                    </el-form-item>
                    <el-form-item label="楼层">
                        <el-input v-model="QueryParam.floor" placeholder="请输入"></el-input>
                    </el-form-item>
                    <el-form-item label="病房号">
                        <el-input v-model="QueryParam.room" placeholder="请输入"></el-input>
                    </el-form-item>
                    <el-form-item label="病床号">
                        <el-input v-model="QueryParam.bed" placeholder="请输入"></el-input>
                    </el-form-item>

                    <el-form-item>
                        <el-button @click="query(1)" icon="el-icon-search"></el-button>
                        <el-button @click="handleEdit({parentId:0,level:0}, 'post')" icon="el-icon-edit"></el-button>
                        <el-button @click="handleDelete({})" icon="el-icon-delete" v-show="multipleSelection.length>0"></el-button>
                    </el-form-item>
                </el-form>

                <el-table
                    :data="tableData"
                    :height="tableHeight"
                    @selection-change="handleSelectionChange"
                    row-key="id"
                    :tree-props="{children: 'children'}"
                    style="width: 100%"
                    header-row-class-name="table-header-color"
                >
                    <el-table-column type="selection" width="42"></el-table-column>
                    <el-table-column prop="name" label="信息" show-overflow-tooltip></el-table-column>

                    <el-table-column label="操作" width="240" fixed="right">
                        <template slot-scope="scope">
                            <el-button size="mini" type="text" @click="handleEdit(scope.row, 'put')">编辑</el-button>
                            <el-button size="mini" type="text" @click="handleDelete(scope.row)">删除</el-button>
                            <el-button size="mini" type="text" v-if="scope.row.level<3" @click="handleEdit(scope.row, 'post', 'child')">添加子项目</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-tab-pane>
        </el-tabs>
        <dialog-model v-model="dialogValue" title="信息录入" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                <el-form label-position="right" label-width="100px" :inline="true" v-if="parenName.name">
                    <el-form-item label="所属：">{{parenName.name}}</el-form-item>
                </el-form>

                <el-form-item label="信息项" prop="name">
                    <el-input v-model="form.name" maxlength="50"></el-input>
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
            patientsAge: state => state.enums.patientsAge,
        })
    },
    data() {
        return {
            actionTabs: 'list',
            tableHeight: GetHeight(240), // 列表高度       
            QueryParam: {},
            tableData: [],
            tableDataTemp: [],
            multipleSelection: [],      // 多选选中的值

            dialogValue: false,
            requestType: '',
            loadingButton: false,

            form: {},
            parenName: {},
            rules: {
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
        };
    },
    created() {
        this.query();
    },
    methods: {
        deleteRequestData,

        /* 查询操作 */
        query(flag) {
            this.$http.get(api.sys.sickbeds, { params: this.QueryParam }).then(res => {
                let data = res.data.data;
                this.tableData = data;
                // this.tableDataTemp = data;
            }).catch(err => {
                ErrorLog(err);
            });
        },
        /* 编辑 */
        handleEdit(row, requestType, isChild) {
            this.parenName = {};

            if (requestType == 'put') {
                this.form = DeepCopy(row);
            } else if (isChild == 'child') {
                this.parenName = row;
                let temp = {
                    index: 1,
                    parentId: row.id,
                    level: row.level + 1
                }
                this.form = temp;
            } else {
                this.form = row;
            }
            this.dialogValue = true;
            this.requestType = requestType;
        },
        /* 保存 */
        handleUpdate() {
            this.$refs.ruleForm.validate(valid => {
                if (valid) {
                    this.loadingButton = true;

                    if (this.requestType == "post") {
                        this.$http.post(api.sys.sickbed, this.form).then(res => {
                            this.dialogValue = false;
                            this.$message.success(res.data.message);
                            this.query();
                        }).catch(err => {
                            this.dialogValue = false;
                            ErrorLog(err)
                        });
                    } else {
                        this.$http.put(api.sys.sickbed, this.form).then(res => {
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
        /* 树形结构过滤信息 */
        fitler() {
            let temp = this.filterTree(this.tableDataTemp, this.shopfilterNode, 'children');
            this.tableData = temp;
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
            return this.QueryParam.name == '' || data.name.indexOf(this.QueryParam.name) != -1;
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
            let message = await this.deleteRequestData(api.sys.sickbed, ids);
            if (message) this.query();
        },
    }
};
</script>

<style lang="scss">
</style>
