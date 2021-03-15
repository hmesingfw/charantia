<template>
    <div>
        <div class="app-main-table">
            <el-form :inline="true" :model="QueryParam" class="header-query-form">
                <generate-form :datalist="queryComponentData" :model="QueryParam" @change="query(1)"></generate-form>
            </el-form>
        </div>
        <div class="app-main-table">
            <generate-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-handle>
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" v-loading="tableLoading"></generate-table>
            <pagination :data="pagination" :callback="query" :total="totalCount" />
        </div>
    </div>
</template>
<script>
import { mapState } from 'vuex';
export default {
    components: {
    },
    props: {
        info: Object,
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
            regType: state => state.enumList.data.regType,
            sexType: state => state.enumList.data.sexType,
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.tenantAdmin, // 请求路很                

            /* ------------ */
            QueryParam: {}, //  搜索条件 
            queryComponentData: [
                { name: 'el-input', key: 'name', label: "姓名", attr: { placeholder: '请输入会员姓名' } },
            ],
            tableData: [],
            tableParams: [
                {
                    prop: 'attendId', label: '报名编号',
                },
                {
                    prop: 'name', label: '姓名',
                },
                {
                    prop: 'mobile', label: '手机号',
                },
                {
                    prop: 'source', label: '签到方式',
                },
                {
                    prop: 'createTime', label: '签到时间',
                },
                {
                    prop: 'status', label: "操作", width: 240,
                    formatF: row => <div>
                        <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} icon="el-icon-delete">删除</el-button>
                    </div>
                },],
            tableLoading: false,
            multipleSelection: [], // 多选选中的值

            pagination: {
                ...this.ConfigParmas.pagination
            },
            totalCount: 0, // 总共多少条
            /* 表单 */
            dialogValue: false,
            requestType: '', // 请求类型 
            form: {},


            /*  */
            dialogValueAuto: false,
            autoInfo: {},
            flashRole: false,
        };
    },
    created() {
        this.query();
    },
    methods: {
        /* 查询操作 */
        query(flag) {
            if (flag == 1) this.pagination.page = 1; // 查询时，让页面等于1
            let param = {
                ...this.pagination,
                ...this.QueryParam,
                tenantId: this.info.tenantId,
            };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, {
                params: param
            }).then(res => {
                this.tableData = res.data.data.list;
                this.totalCount = res.data.data.totalCount;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row, requestType = 'post') {
            this.dialogValue = true;
            this.form = this.DeepCopy(row);
            this.requestType = requestType;
        },
        /* 编辑角色 */
        async handleOpenRole(row) {
            this.dialogValueAuto = true;
            this.autoInfo = row;
            this.flashRole = true;
            let res = await this.$http.get(`${this.$api.sys.roleUser}?uid=${row.id}`);

            this.$set(this.autoInfo, 'roleId', res.data.data.roleId);
            this.flashRole = false;
        },
    }
};
</script>