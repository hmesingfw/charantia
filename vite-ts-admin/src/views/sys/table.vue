<template>
    <div style="padding:16px">
        <el-card>
            <h-query-form :model="queryModel" :params="queryParams" />
            <h-table ref="tTableRef" v-model:selection="multipleSelection" url="https://mock.yonyoucloud.com/mock/8636/table" :params="tableParams" />
        </el-card>
        <h-drawer v-model="drawer" title="弹框">
            <div v-for="i in 1000" :key="i">sdff</div>

            <template #footer>
                <el-button @click="query">取 消</el-button>
            </template>
        </h-drawer>
    </div>
</template>

<script lang="tsx">
import { defineComponent } from "vue";
export default defineComponent({
    data() {
        return {
            multipleSelection: [], // 多选选中的值
            tableParams: [
                {
                    prop: "selection",
                    label: "选择",
                    attr: { type: "selection", width: 46 },
                },
                { prop: "title", label: "标题", attr: { width: 160 } },
                { prop: "sex_text", label: "性别", attr: { width: 160 } },
                { prop: "content", label: "内容", attr: { width: 160 } },
                { prop: "createtime", label: "创建时间", attr: { width: 160 } },
                {
                    prop: "size",
                    label: "文件大小",
                    attr: { width: 100 },
                },
                {
                    prop: "md5",
                    label: "x张三",
                    labelF: (row) => <div>x张三</div>,
                    formatF: (row) => row.sex_text,
                },
                {
                    prop: "status",
                    label: "操作",
                    attr: { width: 500 },
                    formatF: (row) => (
                        <div>
                            <el-button
                                type="text"
                                onClick={() => this.query(row)}
                                icon="el-icon-delete"
                            >
                                查询
                            </el-button>
                            <el-button
                                type="text"
                                onClick={() => this.openDrawer(row)}
                                icon="el-icon-delete"
                            >
                                打开弹框
                            </el-button>
                            <el-button
                                type="text"
                                onClick={() => this.handleTableRef(row)}
                                icon="el-icon-delete"
                            >
                                打开Ref
                            </el-button>
                        </div>
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
                        <div>
                            <el-button
                                type="text"
                                onClick={() => this.query()}
                                icon="el-icon-delete"
                            >
                                查询
                            </el-button>
                        </div>
                    ),
                },
            ],
        };
    },

    watch: {
        multipleSelection(val) {
            console.log(val);
        },
    },
    methods: {
        handleTableRef() {
            const ref = this.$refs.tTableRef.getTableRef();
            ref.clearSelection();
        },
        query() {
            this.$refs.tTableRef.query({ page: 1 });
        },
        openDrawer() {
            this.drawer = true;
        },
    },
});
</script>
