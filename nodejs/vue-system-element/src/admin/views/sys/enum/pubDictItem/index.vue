<template>
    <dialog-model v-model="value" title="字典详情信息列表" width="700" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
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
    </dialog-model>
</template>
<script>
import {
    mapState
} from 'vuex';
import edit from './edit.vue'

export default {
    props: {
        data: { type: Object },
        value: { type: [Boolean, String] },
        callback: Function,

    },
    components: {
        edit
    },
    computed: {
        ...mapState({
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.enumDetail, // 请求路很                

            /* ------------ */
            QueryParam: {}, //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'itemLabel', label: "标题", attr: { placeholder: '请输入标题' } },

            ],
            tableData: [],
            tableParams: [
                {
                    prop: 'itemLabel', label: '标题',
                },
                {
                    prop: 'itemValue', label: '数据值',
                },
                {
                    prop: 'status', label: "操作",
                    formatF: row => <div>
                        <el-button type="text" on-click={() => this.handleEdit(row, 'put')} icon="el-icon-edit">编辑</el-button>
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
            loadingButton: false,

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
                dictCode: this.data.dictCode,
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
            this.$set(this.form, 'dictCode', this.data.dictCode);
            this.requestType = requestType;
        },
        /* 确定按钮 */
        async handleUpdate() {
            this.callback();
            this.$emit('input', false);
        },
        colse() {
            this.$emit('input', false);
        }
    }
};
</script>