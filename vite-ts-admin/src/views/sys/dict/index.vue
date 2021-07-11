<template>
    <div style="padding: 16px">
        <el-card>
            <h-query-form :model="queryModel" :params="queryParams" />
            <h-table ref="tSysDictRef" v-model:selection="multipleSelection" :url="$api.sys.dict" :params="tableParams" @edit="edit" />
        </el-card>
        <h-drawer v-model="drawer" title="弹框" :attrs="{size:'800px'}">
            <dict></dict>

            <template #footer>
                <el-button @click="drawer = false">取 消</el-button>
            </template>
        </h-drawer>
        <h-dialog v-model="dialogStatus" @success="infoSave">
            <el-form :model="info" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
                <el-form-item label="所属模块" prop="dictModule">
                    <el-input v-model="info.dictModule" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="字典编码" prop="dictKey">
                    <el-input v-model="info.dictKey" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="字典名称" prop="dictLabel">
                    <el-input v-model="info.dictLabel" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="字典值" prop="dictValue">
                    <el-input v-model="info.dictValue" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="排序" prop="sort">
                    <el-input-number v-model="info.sort" :min="1" :max="999"></el-input-number>
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
import dict from "./dict.vue";
import api from "@/config/api";

export default defineComponent({
    props: {},
    components: {
        dict,
    },
    data() {
        return {
            value: 1,
            multipleSelection: [], // 多选选中的值
            tableParams: [
                { prop: "selection" },
                { prop: "id", label: "id" },
                { prop: "dictModule", label: "所属模块" },
                { prop: "dictKey", label: "字典编码" },
                { prop: "dictLabel", label: "字典标题" },
                { prop: "dictDesc", label: "备注" },
                {
                    prop: "isLock",
                    label: "内置字典",
                    formatF: (row) => (row.isLock == "1" ? "内置" : "非内置 "),
                },
                {
                    prop: "status",
                    label: "状态",
                    formatF: (row) => (
                        <h-switch
                            data={row}
                            id={row.id}
                            url={api.sys.dict}
                            inactive-text="禁用"
                            active-text="启用"
                            active-value={1}
                            inactive-value={0}
                            onCall={() => {
                                this.query();
                            }}
                        />
                    ),
                },
                {
                    prop: "sort",
                    label: "排序",
                    formatF: (row) => (
                        <h-sort
                            v-model={[row.sort, "value"]}
                            id={row.id}
                            url={api.sys.dict}
                            onCall={() => {
                                this.query();
                            }}
                        />
                    ),
                },
                {
                    prop: "handle",
                    label: "操作",
                    formatF: (row) => (
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
                                onClick={() => this.infoDel(row)}
                                icon="el-icon-delete"
                            >
                                删除
                            </el-button>
                            <el-button
                                type="text"
                                onClick={() => this.openDrawer(row)}
                                icon="el-icon-delete"
                            >
                                数据值
                            </el-button>
                        </>
                    ),
                },
            ],
            drawer: false,

            /* 查询表单 */
            queryModel: {
                name: "221",
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
                        { label: "女", value: 2 },
                    ],
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
                    ),
                },
            ],
            dialogStatus: false,
            info: {},
            rules: {
                dictModule: [
                    {
                        required: true,
                        message: "请选择所属模块",
                        trigger: "blur",
                    },
                ],
                dictKey: [
                    {
                        required: true,
                        message: "请输入字典编码",
                        trigger: "blur",
                    },
                ],
                dictLabel: [
                    {
                        required: true,
                        message: "请输入字典标题",
                        trigger: "blur",
                    },
                ],
                dictValue: [
                    {
                        required: true,
                        message: "请输入字典值",
                        trigger: "blur",
                    },
                ],
            },
            http: new this.$Http(api.sys.dict),
        };
    },
    watch: {
        multipleSelection(val) {
            console.log(val);
        },
    },

    methods: {
        edit(info = { isLock: 0, sort: 1 }) {
            this.info = this.$DeepCopy(info);
            this.dialogStatus = true;
        },
        infoSave() {
            this.$refs.ruleForm.validate(async (vali) => {
                if (vali) {
                    await this.$HttpSave(this.$api.sys.dict, this.info);
                    this.$refs.tSysDictRef.query();
                    this.dialogStatus = false;
                }
            });
        },
        infoDel(row) {
            this.http.Del(row.id, () => this.query());
        },
        query() {
            this.$refs.tSysDictRef.query();
        },
        openDrawer() {
            this.drawer = true;
        },
    },
});
</script>
