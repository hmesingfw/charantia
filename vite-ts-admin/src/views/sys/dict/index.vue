<template>
    <div style="padding: 16px">
        <el-card>
            <h-query-form :model="queryModel" :params="queryParams" />
            <h-table ref="tSysDictRef" v-model:selection="multipleSelection" :url="$api.sys.dict" :params="tableParams" @edit="edit" />
        </el-card>
        <h-drawer v-model="drawer" title="弹框" :attrs="{size:'1200px'}" @save="dictSave">
            <div>
                <el-alert title="消息提示的文案" type="info" :closable="false"></el-alert>
                <h-table-edit :column-data="columnData" :table-data="tableData" :selection="true" />
            </div>
        </h-drawer>
        <h-dialog v-model="dialogStatus" @success="infoSave" :title="info.id? '编辑': '新增'">
            <el-form :model="info" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
                <el-form-item label="所属模块" prop="dictModule">
                    <el-input v-model="info.dictModule" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="编码" prop="dictKey">
                    <el-input v-model="info.dictKey" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="名称" prop="dictLabel">
                    <el-input v-model="info.dictLabel" maxlength="32" show-word-limit></el-input>
                </el-form-item>
                <el-form-item label="值" prop="dictValue">
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
import api from "@/config/api";
import Http from "@/utils/http";

export default defineComponent({
    data() {
        return {
            http: new Http(api.sys.dict),

            value: 1,
            multipleSelection: [], // 多选选中的值
            tableParams: [
                { prop: "selection" },
                { prop: "id", label: "id" },
                { prop: "dictModule", label: "所属模块" },
                { prop: "dictKey", label: "编码" },
                { prop: "dictLabel", label: "标题" },
                { prop: "dictDesc", label: "备注" },
                {
                    prop: "isLock",
                    label: "内置",
                    formatF: (row: any) =>
                        row.isLock == "1" ? "内置" : "非内置 ",
                },
                {
                    prop: "status",
                    label: "状态",
                    formatF: (row: any) => (
                        <h-status id={row.id} url={api.sys.dict} />
                    ),
                },
                {
                    prop: "sort",
                    label: "排序",
                    formatF: (row: any) => (
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
                    formatF: (row: any) => (
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
                        message: "请输入编码",
                        trigger: "blur",
                    },
                ],
                dictLabel: [
                    {
                        required: true,
                        message: "请输入标题",
                        trigger: "blur",
                    },
                ],
            },

            columnData: [
                {
                    prop: "dictLabel",
                    label: "标题",
                    type: "el-input",
                    required: true,
                },
                {
                    prop: "dictValue",
                    label: "值",
                    type: "el-input",
                    required: true,
                },
                {
                    prop: "sort",
                    label: "排序",
                    type: "el-input-number",
                    required: true,
                },
                { prop: "status", label: "状态", type: "el-switch" },
                { prop: "dictDesc", label: "备注", type: "el-input" },
            ],
            tableData: [{ dictLabel: "", dictKey: "", dictModule: "" }],
            tempChildrenRow: {
                id: "",
            },
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
            this.$refs.ruleForm.validate(async (vali: any) => {
                if (vali) {
                    if ("id" in this.info) {
                        await this.http.Patch(this.$api.sys.dict, this.info);
                    } else {
                        await this.http.Post(this.$api.sys.dict, this.info);
                    }
                    this.$refs.tSysDictRef.query();
                    this.dialogStatus = false;
                }
            });
        },
        infoDel(row: any) {
            this.http.Del(row.id, () => this.query());
        },
        query() {
            this.$refs.tSysDictRef.query({ parentId: 0 });
        },
        async openDrawer(row: any) {
            const params = {
                parentId: row.id,
            };
            try {
                const res: any = await this.http.Get(params);
                const { data } = res;
                this.tableData = data;
            } catch (error) {
                this.$message.error("系统错误：" + error.message);
            }

            this.tempChildrenRow = row;
            this.drawer = true;
        },

        /** 保存字典值 */
        dictSave() {
            this.http.Post(
                `${api.sys.dict}/${this.tempChildrenRow.id}`,
                this.tableData
            );
            this.drawer = false;
        },
    },
});
</script>
