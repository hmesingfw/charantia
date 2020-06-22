<template>
    <el-row>
        <div class="app-main-table">
            <el-row style="padding:20px 40px 40px">
                <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                    <h4 class="info-column-title">{{ info.title }}</h4>
                    <el-divider></el-divider>

                    <el-col :span="16" v-loading="tableLoading">
                        <el-form-item v-for="(item,i) in dataList" :key="i" :label="item.title" :prop="item.name" class="config-table">
                            <span v-if="item.type == 'input'">
                                <el-input v-model="item.value" :placeholder="item.remark"></el-input>
                            </span>
                            <span>
                                <el-select v-if="item.type == 'select'" v-model="item.value" placeholder="请选择类型">
                                    <el-option v-for="opt in item.options" :key="opt.id" :label="opt.title" :value="opt.id"></el-option>
                                </el-select>
                                <el-button v-if="item.type == 'select'" type="primary" icon="el-icon-plus" circle style="margin-left:20px" @click="handleaddOption(item)"></el-button>
                            </span>
                            <span style="float:right">
                                <el-button type="primary" icon="el-icon-top" circle style="margin-left:20px" v-if="i != 0" @click="handleMoveUp(dataList, i)"></el-button>
                                <el-button type="primary" icon="el-icon-bottom" circle style="margin-left:20px" v-if="i != dataList.length-1" @click="handleMoveBottom(dataList, i)"></el-button>
                                <el-button type="primary" icon="el-icon-minus" circle style="margin-left:20px" @click="handleDel(dataList, i)"></el-button>
                                <el-button type="primary" icon="el-icon-plus" circle style="margin-left:20px" v-if="i == dataList.length-1" @click="handleEdit"></el-button>
                            </span>
                        </el-form-item>
                    </el-col>

                    <el-col>
                        <el-form-item>
                            <el-button type="primary" @click="handleEdit" v-if="dataList.length == 0">新增项</el-button>
                            <el-button type="primary" @click="handleUpdate">保存</el-button>
                        </el-form-item>
                    </el-col>
                </el-form>
            </el-row>
        </div>
        <el-dialog title="编辑" :visible.sync="dialogFormVisible" width="500px">
            <el-form :model="form" label-width="80px">
                <el-form-item label="参数名称" prop="name">
                    <el-input v-model="form.name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="参数标题" prop="title">
                    <el-input v-model="form.title" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="参数说明" prop="remark">
                    <el-input v-model="form.remark" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item label="活动区域" prop="type">
                    <el-select v-model="form.type" placeholder="请选择类型">
                        <el-option label="输入框" value="input"></el-option>
                        <el-option label="选择框" value="select"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleSave">确 定</el-button>
            </div>
        </el-dialog>
        <el-dialog title="选项" :visible.sync="dialogFormVisibleOption" width="500px">
            <el-form :model="form" label-width="80px">
                <el-form-item label="参数名称" v-for="(item, i) in optionList" :key="i" class="config-option">
                    <el-input v-model="item.title" autocomplete="off"></el-input>
                    <el-button type="primary" icon="el-icon-minus" circle style="margin-left:20px" @click="handleDel(optionList, i)"></el-button>
                    <el-button type="primary" icon="el-icon-plus" circle style="margin-left:20px" @click="handleEditOption"></el-button>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="handleSaveOption">确 定</el-button>
            </div>
        </el-dialog>
    </el-row>
</template>
<script>
import { mapState } from 'vuex';
export default {
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    props: {
        info: Object
    },
    data() {
        return {
            apiUrl: this.$api.sys.config,
            form: {},
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,

            dialogFormVisible: false,
            dialogFormVisibleOption: false,
            dataList: [],               // 整个form数据列表
            optionList: [],             // select 列表
            tempOption: [],
            tableLoading: false,
            requestType: 'put',
        }
    },
    created() {
        this.query();
    },
    methods: {
        query() {
            let param = {
                category: this.info.value
            };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, {
                params: param
            }).then(res => {
                this.dataList = res.data.data || [];
                if (!this.dataList.length > 0) this.requestType = 'post'
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 保存 */
        async handleUpdate() {
            if (!this.dataList.length > 0) {
                this.HandleDelete(`${this.apiUrl}/${this.info.value}`, {}, this.query);
                return false;
            } else {
                this.$refs.ruleForm.validate(async valid => {
                    if (valid) {
                        this.loadingButton = true;
                        let i = 199;
                        let arr = this.dataList.map(item => ({
                            ...item,
                            sort: i--,
                            category: this.info.value
                        }))
                        let issucc = await this.ReqData(this.apiUrl, arr, this.requestType);
                        if (issucc) { }
                        this.loadingButton = false;
                    }
                });
            }
        },

        handleEdit() {
            this.dialogFormVisible = true;
            this.form = {
                type: 'input'
            };
        },
        handleSave() {
            this.dataList.push(this.form);
            this.dialogFormVisible = false;
        },

        handleDel(arr, i) {
            arr.splice(i, 1);
        },
        handleMoveUp(arr, i) {
            let obj = this.DeepCopy(arr[i]);
            arr.splice(i, 1);
            arr.splice(i - 1, 0, obj);
        },
        handleMoveBottom(arr, i) {
            let obj = this.DeepCopy(arr[i]);
            arr.splice(i, 1);
            arr.splice(i + 1, 0, obj);
        },

        /* select 选择内容 */
        handleaddOption(item) {
            this.tempOption = item;
            if (!item.option) {
                this.$set(item, 'options', [{ title: '' }]);
            }
            this.optionList = item.options;
            this.dialogFormVisibleOption = true;
        },
        handleEditOption() {
            this.optionList.push({ 'title': '' })
        },
        /* 保存选项值 */
        handleSaveOption() {
            let i = 1;
            let arr = this.optionList.map(item => ({
                ...item,
                id: i++,
            }))
            this.$set(this.tempOption, 'options', arr);
            this.dialogFormVisibleOption = false;
        },
    }
}
</script>

<style lang="scss">
.config-table {
    .el-input {
        width: 280px;
    }
}
.config-option {
    .el-input {
        width: 200px;
    }
}
</style>