<template>
    <div>
        <div class="app-main-table">
            <el-form :inline="true" :model="QueryParam" class="header-query-form">
                <generate-form :datalist="queryComponentData" :model="QueryParam" @change="query(1)"></generate-form>
            </el-form>
        </div>
        <div class="app-main-table">
            <generate-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-handle>
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" v-loading="tableLoading" :isSelection="false"></generate-table>
            <pagination :data="pagination" :callback="query" :total="totalCount" />
        </div>

        <edit v-model="dialogValue" :form="form" :requestType="requestType" :callback="query" :url="apiUrl"></edit>
        <pub-dict-item v-model="dialogValueItem" :data="form" :callback="query" v-if="flashItem"></pub-dict-item>
    </div>
</template>
<script>
import {
    mapState
} from 'vuex';
import edit from './edit.vue'
import pubDictItem from './pubDictItem/index'

export default {
    components: {
        edit, pubDictItem
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.enum, // 请求路很                

            /* ------------ */
            QueryParam: {}, //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'dictName', label: "标题", attr: { placeholder: '请输入标题' } },
            ],
            tableData: [],
            tableParams: [
                {
                    prop: 'dictCode', label: '编码',
                },
                {
                    prop: 'dictName', label: '标题',
                },
                {
                    prop: 'description', label: '描述',
                },
                {
                    prop: 'status', label: '状态', width: 160,
                    formatF: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query} idKey="dictCode"></c-switch>
                },
                {
                    prop: 'status', label: "操作", width: 300,
                    formatF: row => <div>
                        <el-button type="text" on-click={() => this.handleOpenItem(row)} icon="el-icon-setting">字典值</el-button>
                        <el-button type="text" on-click={() => this.handleEdit(row, 'put')} icon="el-icon-edit">编辑</el-button>
                        <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query, { idKey: 'dictCode' })} icon="el-icon-delete">删除</el-button>
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

            /* 子项目 */
            dialogValueItem: false,
            flashItem: true,
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
        handleEdit(row = { sort: 1, status: 1 }, requestType = 'post') {
            this.dialogValue = true;
            this.form = this.DeepCopy(row);
            this.requestType = requestType;
        },
        /* 编辑 */
        handleOpenItem(row) {
            this.flashItem = false;
            this.$nextTick(() => {
                this.flashItem = true;
            })
            this.dialogValueItem = true;
            this.form = this.DeepCopy(row);

        },

    }
};
</script>