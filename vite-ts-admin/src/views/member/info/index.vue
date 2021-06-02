<template>
    <div style="padding:16px">
        <el-card>
            <h-query-form :model="queryModel" :params="queryParams" />
            <h-table ref="tTableRef" v-model:selection="multipleSelection" :url="$api.member.info" :params="tableParams" />
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
    props: {},
    data() {
        return {
            multipleSelection: [], // 多选选中的值
            tableParams: [
                {
                    prop: "selection",
                    label: "选择",
                    attr: { type: "selection", width: 46 }
                },
                { prop: "icon", label: "头像", attr: { width: 160 } },
                { prop: "username", label: "用户名", attr: { width: 160 } },
                { prop: "nickname", label: "昵称", attr: { width: 160 } },
                { prop: "phone", label: "手机号码", attr: { width: 160 } },
                { prop: "gender", label: "性别", attr: { width: 160 } },

                { prop: "birthday", label: "生日", attr: { width: 160 } },
                { prop: "city", label: "所在城市", attr: { width: 160 } },
                { prop: "job", label: "职业", attr: { width: 160 } },
                {
                    prop: "personalized_signature",
                    label: "个性签名",
                    attr: { width: 160 }
                },
                {
                    prop: "source_type",
                    label: "用户来源",
                    attr: { width: 160 }
                },
                { prop: "integration", label: "积分", attr: { width: 160 } },
                { prop: "growth", label: "成长值", attr: { width: 160 } },
                {
                    prop: "luckey_count",
                    label: "剩余抽奖次数",
                    attr: { width: 160 }
                },
                {
                    prop: "history_integration",
                    label: "历史积分数量",
                    attr: { width: 160 }
                },

                { prop: "status", label: "帐号状态", attr: { width: 160 } },
                {
                    prop: "create_time",
                    label: "创建时间",
                    attr: { width: 160 }
                },
                {
                    prop: "size",
                    label: "文件大小",
                    attr: { width: 100 }
                },
                {
                    prop: "md5",
                    label: "x张三",
                    labelF: row => <div>x张三</div>,
                    formatF: row => row.sex_text
                },
                {
                    prop: "status",
                    label: "操作",
                    attr: { width: 500 },
                    formatF: row => (
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
                        <div>
                            <el-button
                                type="text"
                                onClick={() => this.query()}
                                icon="el-icon-delete"
                            >
                                查询
                            </el-button>
                        </div>
                    )
                }
            ]
        };
    },
    watch: {
        multipleSelection(val) {
            console.log(val);
        }
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
        }
    }
});
</script>
