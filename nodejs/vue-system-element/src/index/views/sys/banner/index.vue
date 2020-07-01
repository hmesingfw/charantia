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

        <edit v-model="dialogValue" :form="form" :requestType="requestType" :callback="query" :url="apiUrl"></edit>
    </div>
</template>
<script>
import { mapState, mapGetters } from 'vuex';
import edit from './edit.vue'

export default {
    components: {
        edit
    },

    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        }),
        ...mapGetters({
            info: 'info'
        })
    },
    data() {
        return {
            apiUrl: this.$api.menber.banner, // 请求路很                

            /* ------------ */
            QueryParam: {}, //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'title', label: "标题", attr: { placeholder: '请输入标题' } },
            ],
            tableData: [],
            tableParams: [
                {
                    prop: 'images', label: '文件', width: 120,
                    formatF: row => <el-image src={this.$api.sys.download + '/' + row.images} style="width:60px" fit="contain"></el-image>

                },
                {
                    prop: 'title', label: '标题',
                },
                {
                    prop: 'positionTitle', label: '广告位置', width: 160,
                },
                {
                    prop: 'startDate', label: '时间', width: 300,
                    formatF: row => <div> {row.startDate && row.startDate.substring(0, 16)} - {row.endDate && row.endDate.substring(0, 16)} </div>
                },

                {
                    prop: 'sort', label: '排序', width: 160,
                    formatF: row => <c-number data={row} data-key="sort" url={this.apiUrl} callback={this.query} > </c-number>,

                },
                {
                    prop: 'status', label: '状态', width: 100,
                    formatF: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query} > </c-switch>,
                },
                {
                    prop: 'status', label: "操作", width: 200,
                    formatF: row => <div><el-button type="text" on-click={() => this.handleEdit(row, 'put')} icon="el-icon-edit">编辑</el-button>
                        <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} icon="el-icon-delete">删除</el-button> </div>
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
            form: {
                times: [],
            },
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
                tenantId: this.info.id,
                ...this.pagination,
                ...this.QueryParam
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
        handleEdit(row = { status: 1, sort: 1, positionId: 'index', startDate: '', endDate: '' }, requestType = 'post') {
            this.form = this.DeepCopy(row);
            this.$set(this.form, 'tenantId', this.info.id);
            this.requestType = requestType;
            this.dialogValue = true;
        },
    }
};
</script>