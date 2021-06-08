<template>
    <div style="padding:16px">
        <el-card>
            <h-query-form :model="queryModel" :params="queryParams" />
            <h-table ref="tSysDictRef" v-model:selection="multipleSelection" :url="$api.sys.dict" :params="tableParams" @edit="edit" />
        </el-card>
        <h-drawer v-model="drawer" title="弹框">
            <div v-for="i in 1000" :key="i">sdff</div>

            <template #footer>
                <el-button @click="query">取 消</el-button>
            </template>
        </h-drawer>
        <h-dialog v-model="dialogStatus" @success="infoSave">
            <el-form :model="info" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
                <el-form-item label="字典编码" prop="dictKey">
                    <el-input v-model="info.dictKey" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="字典名称" prop="dictLabel">
                    <el-input v-model="info.dictLabel" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="字典值" prop="dictValue">
                    <el-input v-model="info.dictValue" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="备注" prop="dictDesc">
                    <el-input v-model="info.dictDesc" maxlength="32" show-word-limit></el-input>
                </el-form-item>
            </el-form>
        </h-dialog>
    </div>
</template>

<script lang="tsx">
import { defineComponent } from "vue";
export default defineComponent({
    props: {},
    data() {
        return {
            multipleSelection: [], // 多选选中的值
            tableParams: [
                { prop: "id", label: "id" },
                { prop: "dictKey", label: "字典编码" },
                { prop: "dictLabel", label: "字典标题" },
                // { prop: "dict_value", label: "值", },
                { prop: "dictDesc", label: "备注" },
                {
                    prop: "isLock",
                    label: "内置字典",
                    formatF: row => (row.is_lock == 1 ? "内置" : "非内置 ")
                },
                {
                    prop: "status",
                    label: "状态",
                    formatF: row => (row.is_lock == 1 ? "启用" : "禁用 ")
                },
                {
                    prop: "handle",
                    label: "操作",
                    formatF: row => (
                        <>
                            <el-button
                                type="text"
                                onClick={() => this.edit(row)}
                                icon="el-icon-delete"
                            >
                                编辑
                            </el-button>
                            <el-button
                                type="text"
                                onClick={() => this.openDrawer(row)}
                                icon="el-icon-delete"
                            >
                                打开弹框
                            </el-button>
                        </>
                    )
                }
            ],
            drawer: false,

            /* 查询表单 */
            queryModel: {
                name: "221"
            },
            queryParams: [
                { label: "姓名：", prop: "name", type: "input" },
                { label: "姓名：", prop: "name", type: "input" },
                { label: "姓名：", prop: "name", type: "input" },
                {
                    label: "性别：",
                    prop: "sex",
                    type: "select",
                    option: [
                        { label: "男", value: 1 },
                        { label: "女", value: 2 }
                    ]
                },
                {
                    formatF: () => (
                        <el-button
                            type="text"
                            onClick={() => this.query()}
                            icon="el-icon-delete"
                        >
                            查询
                        </el-button>
                    )
                }
            ],
            dialogStatus: false,
            info: {},
            rules: {
                dictKey: [
                    {
                        required: true,
                        message: "请输入字典编码",
                        trigger: "blur"
                    }
                ],
                dictLabel: [
                    {
                        required: true,
                        message: "请输入字典标题",
                        trigger: "blur"
                    }
                ],
                dictValue: [
                    {
                        required: true,
                        message: "请输入字典值",
                        trigger: "blur"
                    }
                ]
            }
        };
    },
    watch: {
        multipleSelection(val) {
            console.log(val);
        }
    },
    methods: {
        edit(info) {
            this.dialogStatus = true;
        },
        infoSave() {
            this.$refs.ruleForm.validate(async vali => {
                if (vali) {
                    const res = await this.$http.post(
                        this.$api.sys.dict,
                        this.info
                    );
                    console.log(res);
                }
            });
        },
        query() {
            this.$refs.tTableRef.query({ page: 1 });
        },
        openDrawer() {
            this.drawer = true;
        }
    }
});
</script>
