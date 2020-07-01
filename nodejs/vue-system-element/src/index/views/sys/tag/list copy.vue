<template>
    <el-row :style="{height:treeHeight}">
        <el-col :sm="2" :xs="4" class="page-router">
            <el-scrollbar class="scrollbar">
                <el-tree
                    ref="treeMenu"
                    :data="MODULE_TYPE"
                    :props="{children: 'children',label: 'title'}"
                    @node-click="data => handleNodeClick(data, 'put')"
                    :default-expand-all="true"
                    :expand-on-click-node="false"
                    :highlight-current="true"
                ></el-tree>
            </el-scrollbar>
        </el-col>
        <el-col :sm="22" :xs="20" class="tag-main">
            <el-scrollbar class="scrollbar">
                <el-row class="app-main-table">
                    <el-form :inline="true" :model="tagQueryParam" class="header-query-form">
                        <generate-form :datalist="queryComponentData" :model="tagQueryParam" @change="queryTag(1)"></generate-form>
                    </el-form>
                </el-row>

                <el-card class="app-main-table">
                    <el-row slot="header" class="clearfix">
                        <el-input
                            class="input-new-tag"
                            v-if="visible.tabPidVisible"
                            v-model="inputValue"
                            ref="saveTagPidInput"
                            @keyup.enter.native="handleInputConfirmPid('tabPidVisible')"
                            @blur="handleInputConfirmPid('tabPidVisible')"
                        ></el-input>
                        <span v-else style="margin-right:20px">分类名称</span>

                        <el-button type="text" @click="showInput('saveTagPidInput', 'tabPidVisible')" icon="el-icon-edit"></el-button>
                        <el-button type="text" @click="handleEdit({}, 'put')" icon="el-icon-delete"></el-button>

                        <el-button style="float: right;" type="primary" icon="el-icon-plus">新增</el-button>
                    </el-row>
                    <el-row class="tag-group">
                        <div v-for="item in tagGroupVal" :key="item.id + 'radio'" class="tag-item" :style="{color:item.color,borderColor:item.color}">
                            <span @click="handleEdit(item,'put')">{{ item.title }}</span>
                            <i @click="handleDeleteTag(item,'put')" class="el-icon-close"></i>
                        </div>

                        <el-input
                            class="input-new-tag"
                            v-if="visible.inputVisible"
                            v-model="inputValue"
                            ref="saveTagInput"
                            @keyup.enter.native="handleInputConfirm('inputVisible')"
                            @blur="handleInputConfirm('inputVisible')"
                        ></el-input>
                        <el-button v-else class="button-new-tag" size="small" @click="showInput('saveTagInput', 'inputVisible')">+ 标签</el-button>
                    </el-row>
                </el-card>
            </el-scrollbar>
        </el-col>

        <dialog-alert
            v-model="dialogValue"
            :title="requestType == 'post' ? '新增' : '编辑'"
            :type="requestType"
            @submit="handleUpdate"
            :loading-button="loadingButton"
            @changeLoadingButton="loadingButton = false"
        >
            <el-form label-width="50px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="标题" prop="title">
                    <el-row type="flex" :gutter="8">
                        <el-col :span="20">
                            <el-input v-model="form.title" maxlength="8" ref="colorInput" style="width:100%"></el-input>
                        </el-col>
                        <el-col :span="4">
                            <el-color-picker v-model="form.color" :predefine="predefineColors" @change="changeColor"></el-color-picker>
                        </el-col>
                    </el-row>
                </el-form-item>
            </el-form>
        </dialog-alert>
    </el-row>
</template>

<script>
import { GetHeight } from "@/utils/sys";
import { mapState, mapGetters } from 'vuex'
export default {
    computed: {
        ...mapState({
            MODULE_TYPE: state => state.enumList.data.MODULE_TYPE,
        }),
        ...mapGetters({
            info: 'info'
        })
    },
    data() {
        return {
            treeHeight: GetHeight(90),
            apiUrl: this.$api.sys.tag,          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                value: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },

            tagGroupVal: [],
            tagQueryParam: {},

            predefineColors: ['#000000', '#ff4500', '#ff8c00', '#ffd700', '#38EB26', '#90ee90', '#00ced1', '#1e90ff', '#c71585', '#EE1B1B',],
            /* 新标签输入框 */
            inputValue: '',
            /* 基本不变------------ */

            queryComponentData: [
                { name: 'el-input', key: 'title', label: "标题", attr: { placeholder: '请输入标题' } },
            ],


            tableLoading: false,
            multipleSelection: [],      // 多选选中的值

            /* 表单 */
            dialogValue: false,
            requestType: '',            // 请求类型
            loadingButton: false,
            form: {},

            /* 标签父级 */
            visible: {
                tabPidVisible: false,
                inputVisible: false,
            },
        };
    },
    created() {
        this.queryTag(this.MODULE_TYPE[0]);
    },
    methods: {

        /* 查询tab列表信息 */
        queryTag(data) {
            this.tableLoading = true;
            let from = {
                ...this.tagQueryParam,
                tagTarget: data.value,
                tenantId: this.info.id,
            }
            this.$http.get(this.apiUrl, { params: from }).then(res => {
                let array = res.data.rows || [];
                this.tagGroupVal = array.map(item => {
                    return {
                        ...item,
                        checked: false,
                    }
                });

                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row = { color: '#000' }, requestType = 'post') {
            this.dialogValue = true;
            this.form = this.DeepCopy(row);
            this.requestType = requestType;

            setTimeout(() => {
                this.changeColor(this.form.color);
            }, 0)
        },
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let issucc = await this.ReqData(this.apiUrl, this.form, this.requestType);
                    if (issucc) {
                        this.loadingButton = false;
                        this.dialogValue = false;

                        this.$store.dispatch('enumList/getEnum');
                    } else {
                        this.loadingButton = false;
                    }
                }
            });
        },
        /* 到这里基本不变----------- */
        handleNodeClick(data) {
            this.queryTag(data);
        },

        /* 删除标签 */
        handleDeleteTag(row) {
            if (row) {
                // 单选删除
                this.HandleDelete('/sys/tag', row, this.tagQuery());
            } else {
                // 全选删除
                let list = this.tagGroupVal.filter(item => item.checked == true);
                if (!list.length > 0) {
                    this.$message('请勾选标签');
                    return false;
                }
                this.HandleDelete('/sys/tag', list, this.tagQuery());
            }
        },
        /* 多选操作 */
        handleEditCheckbox(item) {
            item.checked = !item.checked;

            if (item.checked == false) {
                this.multipleSelection = this.multipleSelection.filter(obj => obj.id == item.id);
            } else {
                this.multipleSelection.push(item);
            }

        },
        /* 改变字体颜色 */
        changeColor(val) {
            this.$refs.colorInput.$refs.input.style.color = val;
        },
        showInput(refsName, inputVisible) {
            console.log(refsName, inputVisible, this.$refs);
            this.visible[inputVisible] = true;
            this.$nextTick(() => {
                this.$refs[refsName].$refs.input.focus();
            });
        },
        handleInputConfirm(inputVisible) {
            let inputValue = this.inputValue;
            if (inputValue) {
                let obj = { title: inputValue, checked: false }
                this.tagGroupVal.push(obj);
            }
            this.visible[inputVisible] = false;
            this.inputValue = '';
        },
        /* 父级确认框 */
        handleInputConfirmPid(inputVisible) {

            this.visible[inputVisible] = false;
        },
    }
};

</script>

<style lang="scss">
.page-router {
    height: 100%;
    background: #fff;

    .el-scrollbar__wrap {
        overflow-x: hidden;
    }
    .scrollbar {
        height: 100%;
    }

    .el-tree {
        height: 100%;
        padding: 20px;
    }
}
.tag-main {
    height: 100%;
    .el-scrollbar__wrap {
        overflow-x: hidden;
    }
    .scrollbar {
        height: 100%;
    }
}
.tag-group {
    .tag-item {
        display: inline-flex;
        margin: 0 10px 10px;
        padding: 0 8px;
        align-items: center;
        line-height: 27px;
        border: 1px solid;
        border-radius: 4px;
        box-sizing: border-box;
        white-space: nowrap;
        font-size: 12px;
        cursor: pointer;
        span {
            padding: 0 6px 0 2px;
        }
    }

    .el-tag + .el-tag {
        margin-left: 10px;
    }
    .button-new-tag {
        margin-left: 10px;
        height: 32px;
        line-height: 30px;
        padding-top: 0;
        padding-bottom: 0;
    }
    .input-new-tag {
        width: 90px;
        margin-left: 10px;
    }
}
</style>