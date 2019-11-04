<template>
    <div>
        <el-tabs type="border-card" class="margin-8 pu-padding" v-model="actionTabs">
            <el-tab-pane name="list">
                <span slot="label">
                    <i class="el-icon-date"></i> 病人信息
                </span>
                <el-form :inline="true" :model="QueryParam" class="demo-form-inline">
                    <el-form-item label="姓名">
                        <el-input v-model="QueryParam.sickName" placeholder="请输入"></el-input>
                    </el-form-item>
                    <el-form-item label="主治医生">
                        <el-input v-model="QueryParam.docName" placeholder="请输入"></el-input>
                    </el-form-item>
                    <el-form-item label="床号">
                        <el-input v-model="QueryParam.bedNum" placeholder="请输入"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button @click="query(1)" icon="el-icon-search"></el-button>
                        <el-button @click="handleEdit({sex:1}, 'post')" icon="el-icon-edit"></el-button>
                        <el-button @click="handleDelete({})" icon="el-icon-delete" v-show="multipleSelection.length>0"></el-button>
                    </el-form-item>
                </el-form>

                <el-table :data="tableData" :height="tableHeight" @selection-change="handleSelectionChange" style="width: 100%" header-row-class-name="table-header-color">
                    <el-table-column type="selection" width="42"></el-table-column>
                    <el-table-column prop="name" label="姓名" show-overflow-tooltip></el-table-column>
                    <el-table-column prop="sex" label="性别" show-overflow-tooltip>
                        <template slot-scope="scope">{{ scope.row.sex == 1 ? '男' : '女'}}</template>
                    </el-table-column>
                    <el-table-column prop="age" label="年龄" show-overflow-tooltip></el-table-column>

                    <el-table-column label="主治医生" show-overflow-tooltip>
                        <template slot-scope="scope">
                            <span v-if="scope.row.hospitalized.length>0">{{ scope.row.hospitalized[0].doctorName }}</span>
                        </template>
                    </el-table-column>
                    <el-table-column prop="nurseId" label="责任护士" show-overflow-tooltip>
                        <template slot-scope="scope">
                            <span v-if="scope.row.hospitalized.length>0">{{ scope.row.hospitalized[0].nurseName }}</span>
                        </template>
                    </el-table-column>
                    <el-table-column prop="sickbedId" label="床号" show-overflow-tooltip>
                        <template slot-scope="scope">
                            <span v-if="scope.row.hospitalized.length>0">{{ scope.row.hospitalized[0].sickbedDesc }}</span>
                        </template>
                    </el-table-column>

                    <el-table-column prop="inDate" label="入院时间" show-overflow-tooltip>
                        <template slot-scope="scope">
                            <span v-if="scope.row.hospitalized.length>0">{{ scope.row.hospitalized[0].inDate }}</span>
                        </template>
                    </el-table-column>
                    <el-table-column prop="outDate" label="出院时间" show-overflow-tooltip>
                        <template slot-scope="scope">
                            <span v-if="scope.row.hospitalized.length>0">{{ scope.row.hospitalized[0].outDate }}</span>
                        </template>
                    </el-table-column>

                    <el-table-column label="操作" width="360" fixed="right">
                        <template slot-scope="scope">
                            <el-button size="mini" type="text" @click="handleEdit(scope.row, 'put')">编辑</el-button>
                            <el-button size="mini" type="text" @click="handleDelete(scope.row)">删除</el-button>

                            <el-button size="mini" type="text" @click="handleOpenInOut(scope.row,'post','in')">入院</el-button>
                            <el-button size="mini" type="text" @click="handleOpenInOut(scope.row,'put','out')">出院</el-button>

                            <el-tooltip class="item" effect="dark" content="看护项目" placement="top">
                                <el-button size="mini" type="text" @click="handleOpenItem(scope.row)">看护</el-button>
                            </el-tooltip>
                            <el-tooltip class="item" effect="dark" content="出入院历史记录" placement="top">
                                <el-button size="mini" type="text" @click="handleInOutList(scope.row)">记录</el-button>
                            </el-tooltip>
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
                    <el-select v-model="form.age">
                        <el-option v-for="item in patientsAge" :key="item.id" :label="item.name" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="身份证号码" prop="cardId">
                    <el-input v-model="form.cardId" maxlength="18"></el-input>
                </el-form-item>
            </el-form>
        </dialog-model>

        <dialog-model v-model="dialoginOutValue" title="出入院信息录入" :type="requestType" @submit="handleInOutUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-divider content-position="left">病人信息</el-divider>
            <el-form label-position="right" label-width="100px" :model="inoutForm">
                <el-form-item label="病人姓名：">{{inoutForm.name}}</el-form-item>
            </el-form>

            <el-divider content-position="left">入院信息</el-divider>
            <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleInoutForm">
                <el-form-item label="主治医生" prop="doctorId">
                    <el-select v-model="form.doctorId" filterable placeholder="请选择">
                        <el-option v-for="item in doctorList" :key="item.id" :label="item.name" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="责任护士" prop="nurseId">
                    <el-select v-model="form.nurseId" filterable placeholder="请选择">
                        <el-option v-for="item in nurseTypeList" :key="item.id" :label="item.name" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="床号" prop="sickbedId">
                    <el-cascader ref="cascaderref" v-model="form.sickbedId" @change="changeSickbed" :options="sickbedList" :props="{ label: 'name',value: 'id',emitPath:false }"></el-cascader>
                </el-form-item>

                <el-form-item label="入院时间" prop="inDate">
                    <el-date-picker v-model="form.inDate" :disabled="inoutType == 'out'" type="date" placeholder="选择日期时间" align="right" :picker-options="pickerOptions"></el-date-picker>
                </el-form-item>

                <el-form-item label="出院时间" prop="outDate" v-if="inoutType != 'in'">
                    <el-date-picker v-model="form.outDate" type="date" placeholder="选择日期时间" align="right" :picker-options="pickerOptions"></el-date-picker>
                </el-form-item>
            </el-form>
        </dialog-model>

        <dialog-model v-model="dialoginOutListValue" title="出入院历史信息" width="800" @submit="dialoginOutListValue = false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-divider content-position="left">病人信息</el-divider>
            <el-form label-position="right" label-width="100px" :model="inoutForm">
                <el-form-item label="病人姓名：">{{inoutForm.name}}</el-form-item>
            </el-form>

            <el-table :data="tableDataInOutList" :height="tableHeight" style="width: 100%" header-row-class-name="table-header-color">
                <el-table-column prop="doctorName" label="主治医生" show-overflow-tooltip></el-table-column>
                <el-table-column prop="nurseName" label="责任护士" show-overflow-tooltip></el-table-column>
                <el-table-column prop="sickbedDesc" label="床号" show-overflow-tooltip></el-table-column>

                <el-table-column prop="inDate" label="入院时间" show-overflow-tooltip></el-table-column>
                <el-table-column prop="outDate" label="出院时间" show-overflow-tooltip></el-table-column>
            </el-table>
        </dialog-model>

        <dialog-model ref="refItemDialog" v-model="dialogItemValue" title="看护项目" @submit="handleItemUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-divider content-position="left">病人信息</el-divider>
            <el-form label-position="right" label-width="100px" :model="form" :inline="true">
                <el-form-item label="姓名：">{{form.name}}</el-form-item>
                <el-form-item label="年龄">{{form.age}}</el-form-item>
            </el-form>
            <el-divider content-position="left">项目信息</el-divider>

            <!-- <div class="pu-pagination">
                <el-transfer v-model="value" :data="tableData" :props="{key:'id', label:'name'}" :titles="['已有项目', '已选项目']"></el-transfer>
            </div>-->
            <el-table
                :data="tableItemchild"
                ref="multipleTableItem"
                :height="tableHeightItem"
                @selection-change="handleSelectionItemChange"
                style="width: 100%"
                header-row-class-name="table-header-color"
            >
                <el-table-column type="selection" width="42"></el-table-column>
                <el-table-column prop="name" label="项目名称" show-overflow-tooltip></el-table-column>
            </el-table>
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
            patientsAge: state => state.enums.patientsAge,
            type: state => state.enums.type,
            doctor: state => state.enums.doctor,
            enumval: state => state.enumsValue.enumval,

        })
    },
    data() {
        return {
            actionTabs: 'list',
            tableHeight: GetHeight(260), // 列表高度       
            tableHeightItem: GetHeight(280), // 列表高度       
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
                inDate: [{ required: true, message: '请选择', trigger: 'blur' },],
                outDate: [{ required: true, message: '请选择', trigger: 'blur' },],
            },

            doctorList: [],
            nurseTypeList: [],
            sickbedList: [],
            /* 看护项目 */
            dialogItemValue: false,
            tableItemchild: [],                 // 列表
            multipleSelectionItem: [],

            /* 出入院设置 */
            dialoginOutValue: false,            //   表单
            inoutType: '',                   // 判断是入院，还是出院

            // 历史记录
            dialoginOutListValue: false,
            tableDataInOutList: [],
            inoutForm: {},



            /* 快捷时间 */
            pickerOptions: {
                shortcuts: [{
                    text: '今天',
                    onClick(picker) {
                        picker.$emit('pick', new Date());
                    }
                }, {
                    text: '昨天',
                    onClick(picker) {
                        const date = new Date();
                        date.setTime(date.getTime() - 3600 * 1000 * 24);
                        picker.$emit('pick', date);
                    }
                }, {
                    text: '一周前',
                    onClick(picker) {
                        const date = new Date();
                        date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
                        picker.$emit('pick', date);
                    }
                }]
            },
        };
    },
    created() {
        this.query();
        this.initData();
    },
    methods: {
        deleteRequestData,
        initData() {

            this.$http.get(api.sys.doctor, { params: { type: this.enumval.doctor } }).then(res => {
                this.doctorList = res.data.data.list;
            })
            this.$http.get(api.sys.doctor, { params: { type: this.enumval.nurseType } }).then(res => {
                this.nurseTypeList = res.data.data.list;
            })
            this.$http.get(api.sys.sickbeds).then(res => {
                this.sickbedList = res.data.data;
            })
            this.$http.get(api.sys.nurseItems).then(res => {
                // 只要叶子节点
                res.data.data.forEach(obj => {
                    if (obj.children.length > 0) {
                        obj.children.forEach(item => {
                            this.tableItemchild.push(item);
                        })
                    } else {
                        this.tableItemchild.push(obj);
                    }
                });
            })
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
        /* 查询操作 */
        query(flag) {
            if (flag == 1) this.pagination.page = 1;         // 查询时，让页面等于1
            let param = {
                ...this.pagination,
                ...this.QueryParam
            };
            this.$http.get(api.sys.patients, { params: param }).then(res => {
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
                        this.$http.post(api.sys.patient, this.form).then(res => {
                            this.dialogValue = false;
                            this.$message.success(res.data.message);
                            this.query();
                        }).catch(err => {
                            this.dialogValue = false;
                            ErrorLog(err)
                        });
                    } else {
                        this.$http.put(api.sys.patient, this.form).then(res => {
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

        /* 出入院设置 */
        handleOpenInOut(row, requestType, inoutType) {
            this.dialoginOutValue = true;
            this.requestType = requestType;
            this.inoutForm = row;
            this.inoutType = inoutType;

            if (requestType == 'post') {
                /* 幅值 */
                this.form = {
                    sickId: row.id,
                    inDate: new Date(),
                }
            } else {
                console.log(row);
                if (row.hospitalized.length > 0) {
                    this.form = {
                        ...row.hospitalized[0],
                        sickId: row.id,
                        outDate: new Date(),
                    }
                }
            }

        },
        // 保存出入院设置 
        handleInOutUpdate() {


            this.$refs.ruleInoutForm.validate(valid => {
                if (valid) {
                    this.loadingButton = true;

                    if (this.requestType == "post") {
                        this.$http.post(api.sys.checkIn, this.form).then(res => {
                            this.dialoginOutValue = false;
                            this.$message.success(res.data.message);
                            this.query();
                        }).catch(err => {
                            this.dialoginOutValue = false;
                            ErrorLog(err)
                        });
                    } else {
                        this.$http.put(api.sys.leave, this.form).then(res => {
                            this.dialoginOutValue = false;
                            this.$message.success(res.data.message);
                            this.query();
                        }).catch(err => {
                            this.dialoginOutValue = false;
                            ErrorLog(err)
                        });
                    }
                }
            });
        },

        changeSickbed(data) {
            let sit = this.$refs.cascaderref.getCheckedNodes();
            if (sit.length > 0) {
                this.$set(this.form, 'sickbedDesc', sit[0].label);
            }
        },

        // 出入院历史记录
        handleInOutList(row) {
            this.dialoginOutListValue = true;
            this.tableDataInOutList = row.hospitalized;
            this.inoutForm = row;
        },
        /* 看护项目 */
        handleOpenItem(row) {
            this.dialogItemValue = true;
            this.form = row;

            this.$nextTick(() => {


                this.$refs.multipleTableItem.clearSelection();
                this.$http.get(api.sys.nursing, { params: { sickId: row.id } }).then(res => {

                    res.data.data.forEach(item => {
                        this.tableItemchild.forEach(child => {

                            if (item.nurseId == child.id) {
                                this.$refs.multipleTableItem.toggleRowSelection(child);
                            }
                        })
                    })
                }).catch(err => {
                    ErrorLog(err)
                });
            })
            // rows.forEach(row => {
            //     this.$refs.multipleTableItem.toggleRowSelection(row);
            // });
        },
        handleItemUpdate() {
            let list = this.multipleSelectionItem.map(item => ({
                sickId: this.form.id,
                nurseId: item.id
            }))

            this.$http.post(api.sys.patientItem, list).then(res => {
                this.dialogItemValue = false;
                this.$message.success(res.data.message);
            }).catch(err => {
                this.dialogItemValue = false;
                ErrorLog(err)
            });
        },
        /* 为病人选择看护项目 */
        handleSelectionItemChange(val) {
            this.multipleSelectionItem = val;
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
            let message = await this.deleteRequestData(api.sys.patient, ids);
            if (message) this.query();
        },
    }
};
</script>

<style lang="scss">
</style>
