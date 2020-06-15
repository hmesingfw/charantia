<template>
    <el-row :style="{height:treeHeight}">
        <el-col :sm="2" :xs="4" class="page-router">
            <el-scrollbar class="scrollbar">
                <el-tree
                    ref="treeMenu"
                    :data="treeData"
                    :props="{children: 'children',label: 'label'}"
                    @node-click="data => handleNodeClick(data, 'put')"
                    :default-expand-all="true"
                    :expand-on-click-node="false"
                ></el-tree>
            </el-scrollbar>
        </el-col>
        <el-col :sm="22" :xs="20">
            <el-row class="app-main-table">
                <el-form :inline="true" :model="tagQueryParam" class="header-query-form">
                    <generate-form :datalist="queryComponentData" :model="tagQueryParam" @change="query(1)"></generate-form>
                </el-form>
            </el-row>
            <el-row class="app-main-table">
                <generate-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection">
                    <el-radio-group v-model="handleType" style="float:right" @change="handleTypeChange">
                        <el-radio-button label="radio">单选</el-radio-button>
                        <el-radio-button label="checkbox">多选</el-radio-button>
                    </el-radio-group>
                </generate-handle>
                <el-row class="tag-group">
                    <div v-show="handleType == 'radio'" v-for="item in tagGroupVal" :key="item.id + 'radio'" class="tag-item" :style="{color:item.color,borderColor:item.color}">
                        <span @click="handleEdit(item)">{{ item.title }}</span>
                        <i @click="handleDeleteTag(item)" class="el-icon-close"></i>
                    </div>
                    <div
                        v-show="handleType == 'checkbox'"
                        v-for="item in tagGroupVal"
                        :key="item.id + 'chechbox'"
                        class="tag-item"
                        :style="item.checked == false ? {color:item.color,borderColor:item.color} : {color:'#fff',backgroundColor:item.color}"
                    >
                        <span @click="handleEditCheckbox(item)">{{ item.title }}</span>
                    </div>
                </el-row>
            </el-row>
        </el-col>

        <dialog-alert
            v-model="dialogValue"
            :title="requestType == 'post' ? '新增' : '详情'"
            :type="requestType"
            @submit="handleUpdate"
            :loading-button="loadingButton"
            @changeLoadingButton="loadingButton = false"
        >
            <el-form label-width="0px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item prop="title">
                    <el-row type="flex" :gutter="8">
                        <el-col :span="20">
                            <el-input v-model="form.title" maxlength="8" show-word-limit ref="colorInput" :style="{color:form.color}" style="width:100%"></el-input>
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
import { mapState } from 'vuex'
export default {
    computed: {
        ...mapState({
        })
    },
    data() {
        return {
            treeHeight: GetHeight(90),
            apiUrl: 'https://mock.yonyoucloud.com/mock/8636/tag',          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                value: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },

            treeData: [{
                label: '一级 1',
            }, {
                label: '一级 1',
            }, {
                label: '一级 1',
            }],
            defaultProps: {
                children: 'children',
                label: 'label'
            },
            tagGroupVal: [],
            tagQueryParam: {},

            handleType: 'radio',        // 操作类型
            predefineColors: ['#000000', '#ff4500', '#ff8c00', '#ffd700', '#38EB26', '#90ee90', '#00ced1', '#1e90ff', '#c71585', '#EE1B1B',],
            /* 基本不变------------ */
            QueryParam: {},             //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'title', label: "标题", attr: { placeholder: '请输入标题' } },
            ],
            tableData: [],

            tableLoading: false,
            multipleSelection: [],      // 多选选中的值

            /* 表单 */
            dialogValue: false,
            requestType: '',            // 请求类型
            loadingButton: false,
            form: {},
        };
    },
    created() {
        this.query();
        this.queryTab();
    },
    methods: {
        /* 查询操作 */
        query(flag) {
            if (flag == 1) this.pagination.page = 1;         // 查询时，让页面等于1
            let param = {
                ...this.pagination,
                ...this.QueryParam
            };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, { params: param }).then(res => {
                this.tableData = res.data.rows;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 查询tab列表信息 */
        queryTab() {
            this.tableLoading = true;
            this.$http.get(this.apiUrl, { params: this.tagQueryParam }).then(res => {
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
                        this.query();

                        this.$store.dispatch('enumList/getEnum');
                    } else {
                        this.loadingButton = false;
                    }
                }
            });
        },
        /* 到这里基本不变----------- */
        handleNodeClick(data) {
            this.queryTab(data);
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
        /* 改变操作方式 */
        handleTypeChange(val) {
            if (val == 'radio') this.multipleSelection = [];
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
.tag-group {
    padding: 20px;
    .tag-item {
        display: inline-flex;
        margin: 10px;
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
}
</style>