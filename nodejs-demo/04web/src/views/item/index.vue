<template>
    <div>
        <el-tabs type="border-card" class="margin-8 pu-padding" v-model="actionTabs">
            <el-tab-pane name="list">
                <span slot="label">
                    <i class="el-icon-date"></i> 项目信息
                </span>
                <el-form :inline="true" :model="QueryParam" class="demo-form-inline">
                    <el-form-item label="项目名称">
                        <el-input v-model="QueryParam.name" placeholder="请输入"></el-input>
                    </el-form-item>
                    <!-- <el-form-item label="显示规格">
                        <el-select v-model="QueryParam.showFormat" clearable>
                            <el-option v-for="item in norms" :key="item.id" :label="item.name" :value="item.id"></el-option>
                        </el-select>
                    </el-form-item>-->

                    <el-form-item>
                        <el-button @click="fitler()" icon="el-icon-search"></el-button>
                        <el-button @click="handleEdit({parentId:0,isShow:1,autoHide:1,isTotal:1,index:1}, 'post')" icon="el-icon-edit"></el-button>
                        <el-button @click="handleDelete({})" icon="el-icon-delete" v-show="multipleSelection.length>0"></el-button>
                    </el-form-item>
                </el-form>

                <el-table
                    :data="tableData"
                    :height="tableHeight"
                    default-expand-all
                    style="width: 100%"
                    row-key="id"
                    :tree-props="{children: 'children'}"
                    @selection-change="handleSelectionChange"
                    header-row-class-name="table-header-color"
                >
                    <el-table-column type="selection" width="42"></el-table-column>
                    <el-table-column prop="name" label="项目名称" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="index" label="排序" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="formatValue.name" label="显示规格" show-overflow-tooltip></el-table-column>
                    <el-table-column label="是否显示" show-overflow-tooltip>
                        <template slot-scope="scope">{{ scope.row.isShow == 1 ? '是' : '否'}}</template>
                    </el-table-column>
                    <el-table-column label="为空自动隐藏" show-overflow-tooltip>
                        <template slot-scope="scope">{{ scope.row.autoHide == 1 ? '是' : '否'}}</template>
                    </el-table-column>
                    <el-table-column label="重要项目" show-overflow-tooltip>
                        <template slot-scope="scope">{{ scope.row.isTotal == 1 ? '是' : '否'}}</template>
                    </el-table-column>

                    <el-table-column label="操作" width="260" fixed="right">
                        <template slot-scope="scope">
                            <el-button size="mini" type="text" @click="handleEdit(scope.row, 'put')">编辑</el-button>
                            <el-button size="mini" type="text" @click="handleDelete(scope.row)">删除</el-button>
                            <el-button size="mini" type="text" @click="handleOpenItem(scope.row)">病人设置</el-button>
                            <el-button size="mini" type="text" @click="handleEdit(scope.row, 'post', 'child')" v-if="scope.row.parentId == 0">添加子项目</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-tab-pane>
        </el-tabs>
        <dialog-model v-model="dialogValue" title="信息录入" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="所属" v-if="parenName.name">{{ parenName.name }}</el-form-item>

                <el-form-item label="项目名称" prop="name">
                    <el-input v-model="form.name" maxlength="50"></el-input>
                </el-form-item>
                <el-form-item label="排序" prop="index">
                    <el-input-number v-model="form.index" :min="1" :max="99"></el-input-number>
                </el-form-item>
                <el-form-item label="显示规格" prop="showFormat">
                    <el-select v-model="form.showFormat">
                        <el-option v-for="item in norms" :key="item.id" :label="item.name" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="是否显示" prop="isShow">
                    <el-radio-group v-model="form.isShow">
                        <el-radio :label="1">是</el-radio>
                        <el-radio :label="0">否</el-radio>
                    </el-radio-group>
                </el-form-item>

                <el-form-item label="为空自动隐藏" prop="autoHide">
                    <el-radio-group v-model="form.autoHide">
                        <el-radio :label="1">是</el-radio>
                        <el-radio :label="0">否</el-radio>
                    </el-radio-group>
                </el-form-item>

                <el-form-item label="重要项目" prop="isTotal">
                    <el-radio-group v-model="form.isTotal">
                        <el-radio :label="1">是</el-radio>
                        <el-radio :label="0">否</el-radio>
                    </el-radio-group>
                </el-form-item>
            </el-form>
        </dialog-model>

        <dialog-model v-model="dialogItemValue" title="病人信息" width="800" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-divider content-position="left">项目信息</el-divider>
            <el-form label-position="right" label-width="100px" :model="form">
                <el-form-item label="项目名称：">{{form.name}}</el-form-item>
            </el-form>

            <el-divider content-position="left">病人信息</el-divider>
            <el-table :data="tableDataPatients" :height="tablePatientsHeight" style="width: 100%" header-row-class-name="table-header-color">
                <el-table-column type="selection" width="42"></el-table-column>
                <el-table-column prop="name" label="姓名" show-overflow-tooltip></el-table-column>
                <el-table-column prop="doctorId" label="主治医生" show-overflow-tooltip></el-table-column>
                <el-table-column prop="nurseId" label="责任护士" show-overflow-tooltip></el-table-column>
                <el-table-column prop="sickbedId" label="床号" show-overflow-tooltip></el-table-column>

                <el-table-column prop="inDate" label="入院时间" show-overflow-tooltip></el-table-column>
                <el-table-column prop="outDate" label="出院时间" show-overflow-tooltip></el-table-column>

                <el-table-column prop="sex" label="性别" show-overflow-tooltip></el-table-column>
                <el-table-column prop="age" label="年龄" show-overflow-tooltip></el-table-column>
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
            norms: state => state.enums.norms,
        })
    },
    data() {
        return {
            actionTabs: 'list',
            tableHeight: GetHeight(260), // 列表高度       
            tablePatientsHeight: GetHeight(300), // 列表高度       
            QueryParam: {
                name: ''
            },
            tableData: [],
            tableDataPatients: [],       // 病人信息列表
            multipleSelection: [],      // 多选选中的值




            dialogValue: false,
            requestType: '',
            loadingButton: false,


            form: {},
            rules: {
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            parenName: {},
            /* 病人信息 */
            dialogItemValue: false,
            itemId: '',
            pagination: {
                page: 1,
                size: 10,
                totalCount: 0
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
            this.$http.get(api.sys.nurseItems).then(res => {
                this.tableData = res.data.data;
                this.tableDataTemp = res.data.data;
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
                    index: 1, parentId: row.id, isShow: 1, autoHide: 1, isTotal: 1
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
                        this.$http.post(api.sys.nurseItem, this.form).then(res => {
                            this.dialogValue = false;
                            this.$message.success(res.data.message);
                            this.query();
                        }).catch(err => {
                            this.dialogValue = false;
                            ErrorLog(err)
                        });
                    } else {
                        this.$http.put(api.sys.nurseItem, this.form).then(res => {
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
            let temp = this.filterTree(this.tableDataTemp, this.shopfilterNode, 'optionValues');
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
            let message = await this.deleteRequestData(api.sys.nurseItem, ids);
            if (message) this.query();
        },




        /* 看护项目 */
        handleOpenItem(row) {
            this.dialogItemValue = true;
            this.form = row;
            this.itemId = row.id;
            this.patientsQuery();

            //  查询已分配的病人信息
            this.$http.get(api.sys.nurses, { params: { nurseId: row.id } }).then(res => {
                console.log(res);
            }).catch(err => {
                ErrorLog(err);
            });
        },
        patientsQuery() {
            let param = {
                ...this.pagination,
            };
            this.$http.get(api.sys.patients, { params: param }).then(res => {
                let data = res.data.data;
                this.tableDataPatients = data.list;

                this.pagination.size = data.pageSize;
                this.pagination.totalCount = data.totalCount;
            }).catch(err => {
                ErrorLog(err);
            });
        },
        handleSizeChange(val) {
            this.pagination.size = val;
            this.patientsQuery();
        },
        /* 改变当前页 */
        handleCurrentChange(val) {
            this.pagination.page = val;
            this.patientsQuery();
        },
        handleItemUpdate() {
            this.dialogItemValue = false;
        },
    }
};
</script>

<style lang="scss">
</style>
