<template>
    <div>
        <generate-group :data="groupList"></generate-group>
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
            groupList: [
                { code: 'item', title: "收入总计", endVal: 1000, class: 'icon-people', icon: 'peoples' },
                { code: 'day', title: "今日收入", endVal: 1000, class: 'icon-people', icon: 'peoples' },
                { code: 'num', title: "付款人数", endVal: 1000, class: 'icon-people', icon: 'peoples' },
                { code: 'auto', title: "待审核", endVal: 1000, class: 'icon-people', icon: 'peoples' },
            ],
            /* ------------ */
            QueryParam: {}, //  搜索条件 
            queryComponentData: [
                { name: 'el-input', key: 'name', label: "姓名", attr: { placeholder: '请输入用户姓名' } },
            ],
            tableData: [],
            tableParams: [
                {
                    prop: 'orderNo', label: '头像',
                },
                {
                    prop: 'uid', label: '姓名',
                },
                {
                    prop: 'content', label: '评论内容',
                },
                {
                    prop: 'createdTime', label: '评论时间', width: 160,
                },

                {
                    prop: 'status', label: "操作", width: 160,
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