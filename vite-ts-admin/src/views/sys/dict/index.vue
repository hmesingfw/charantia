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
                <el-form-item label="活动名称" prop="name">
                    <el-input v-model="info.name"></el-input>
                </el-form-item>
                <el-form-item label="活动区域" prop="region">
                    <el-select v-model="info.region" placeholder="请选择活动区域">
                        <el-option label="区域一" value="shanghai"></el-option>
                        <el-option label="区域二" value="beijing"></el-option>
                    </el-select>
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
            rules: {}
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
            console.log("info-save");
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
