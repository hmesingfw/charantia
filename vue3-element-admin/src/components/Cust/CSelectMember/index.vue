<template>
    <dialog-model v-model="value" title="工作人员" width="700" :loading-button="loadingButton" :is-colse="false" @submit="handleUpdate" @colse="colse" @changeLoadingButton="loadingButton = false">
        <div class="app-main-table">
            <el-form :inline="true" :model="QueryParam" class="header-query-form">
                <generate-form :datalist="queryComponentData" :model="QueryParam" @change="query(1)" />
            </el-form>
        </div>
        <div class="app-main-table">
            <generate-table v-loading="tableLoading" :data="tableData" :params="tableParams" :is-selection="false" @selection-change="val => multipleSelection = val" />
            <pagination :data="pagination" :total="totalCount" :callback="query" />
        </div>
    </dialog-model>
</template>
<script>
import { mapState, mapGetters } from 'vuex';

export default {
    components: {
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        }),
        ...mapGetters({
            userinfo: 'info'
        })
    },
    props: {
        value: { type: [Boolean, String] },
        form: { type: Object },
        url: {
            type: String, default() {
                return this.$api.sys.account
            }
        },
        extend: { type: Object, default: () => { } }
    },
    data() {
        return {
            /* ------------ 表格 */
            QueryParam: {
                status: ''
            }, //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'name', label: '姓名', attr: { placeholder: '请输入会员姓名' } },
            ],
            tableData: [],
            tableParams: [
                {
                    label: '账号',
                    formatF: row => row.accountEntity.account
                },
                {
                    label: '姓名',
                    formatF: row => row.user.name
                },
                {
                    label: '手机号',
                    formatF: row => row.user.mobile
                },
                {
                    label: '角色', prop: 'roleName',
                },
                {
                    prop: 'status', label: '操作', width: 80,
                    formatF: row => <div>
                        <el-button type='text' on-click={() => this.handleOpenItem(row)} icon='el-icon-setting' >选择</el-button>
                    </div>
                }
            ],
            tableLoading: false,
            multipleSelection: [], // 多选选中的值
            pagination: {
                ...this.ConfigParmas.pagination
            },
            totalCount: 0, // 总共多少条

            /* 表单 */
            dialogValue: false,
            requestType: '', // 请求类型

            loadingButton: false,

        };
    },
    watch: {
        value(val) {
            if (val) {
                this.query();
            }
        },
    },
    created() {
        this.query();
    },
    methods: {
        /* 查询操作 */
        query(flag) {
            if (flag == 1) this.pagination.page = 1; // 查询时，让页面等于1
            const param = {
                ...this.pagination,
                ...this.QueryParam,
            };
            this.tableLoading = true;
            this.$http.get(this.url, { params: param }).then(res => {
                this.tableData = res.data.data.list;
                this.totalCount = res.data.data.totalCount;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        handleOpenItem(row) {
            this.loadingButton = true;
            this.$emit('callback', row);
            this.loadingButton = false;
        },
        /* 保存 */
        async handleUpdate() {
            this.loadingButton = true;
            this.$emit('callback', this.multipleSelection);
            this.loadingButton = false;
        },
        colse() {
            this.$emit('input', false);
        },
    }
};
</script>

