<template>
    <el-scrollbar class="scrollbar">
        <el-row class="app-main-table">
            <el-form :inline="true" :model="tagQueryParam" class="header-query-form">
                <generate-form :datalist="queryComponentData" :model="tagQueryParam" @change="queryTag(1)"></generate-form>
            </el-form>
        </el-row>

        <el-card class="app-main-table" v-for="(group, index) in tagList" :key="group.id">
            <el-row slot="header" class="clearfix">
                <span style="margin-right:20px" :style="{color:group.color,borderColor:group.color}">{{ group.title }}</span>

                <el-button type="text" @click="handleEdit(group, 'put')" icon="el-icon-edit"></el-button>
                <el-button type="text" @click="handleDeleteTag(group)" icon="el-icon-delete"></el-button>

                <el-button
                    v-if="index+1 == tagList.length"
                    style="float: right;"
                    @click="handleEdit({  color: '#000', pid: 0, tagTarget: data.value, tenantId: userInfo.id }, 'post')"
                    type="primary"
                    icon="el-icon-plus"
                >新增</el-button>
            </el-row>
            <el-row class="tag-group">
                <div v-for="item in group.children" :key="item.id + 'radio'" class="tag-item" :style="{color:item.color,borderColor:item.color}">
                    <span @click="handleEdit(item,'put')">{{ item.title }}</span>
                    <i @click="handleDeleteTag(item)" class="el-icon-close"></i>
                </div>

                <el-button class="button-new-tag" size="small" @click="handleEdit({  color: '#000', pid: group.id, tagTarget: data.value, tenantId: userInfo.id }, 'post')">+ 标签</el-button>
            </el-row>
        </el-card>

        <el-card class="app-main-table" v-if="!tagList || tagList.length == 0" style="text-align:center">
            <el-button @click="handleEdit({  color: '#000', pid: 0, tagTarget: data.value, tenantId: userInfo.id }, 'post')" type="primary" icon="el-icon-plus">新增标签类型</el-button>
        </el-card>
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
    </el-scrollbar>
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
            userInfo: 'info'
        })
    },
    props: {
        data: Object
    },
    watch: {
        data: {
            handler(val) {
                this.queryTag(val);
            },
            deep: true
        },
    },
    data() {
        return {
            treeHeight: GetHeight(90),
            apiUrl: this.$api.sys.tag,          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                value: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            tagList: [],
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
        this.queryTag(this.data);
    },
    methods: {
        /* 查询tab列表信息 */
        queryTag() {
            this.tableLoading = true;
            let from = {
                ...this.tagQueryParam,
                tagTarget: this.data.value,
                tenantId: this.userInfo.id,
            }
            this.$http.get(this.apiUrl, { params: from }).then(res => {
                let array = res.data.data || [];
                this.tagList = array;
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
        handleEdit(row = { color: '#000', pid: 0, tagTarget: this.data.value, tenantId: this.userInfo.id }, requestType = 'post') {
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
                        this.queryTag();
                    } else {
                        this.loadingButton = false;
                    }
                }
            });
        },
        handleAddGroup() {

        },

        /* 删除标签 */
        handleDeleteTag(row) {
            let arr = [];
            arr.push(row);
            this.HandleDelete(this.apiUrl, arr, this.queryTag);
            // if (row) {
            //     // 单选删除
            //     this.HandleDelete('/sys/tag', row, this.tagQuery());
            // } else {
            //     // 全选删除
            //     let list = this.tagGroupVal.filter(item => item.checked == true);
            //     if (!list.length > 0) {
            //         this.$message.info('请勾选标签');
            //         return false;
            //     }
            //     this.HandleDelete('/sys/tag', list, this.tagQuery());
            // }
        },
        // /* 多选操作 */
        // handleEditCheckbox(item) {
        //     item.checked = !item.checked;

        //     if (item.checked == false) {
        //         this.multipleSelection = this.multipleSelection.filter(obj => obj.id == item.id);
        //     } else {
        //         this.multipleSelection.push(item);
        //     }

        // },
        /* 改变字体颜色 */
        changeColor(val) {
            this.$refs.colorInput.$refs.input.style.color = val;
        },

    }
};

</script>

<style lang="scss">
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