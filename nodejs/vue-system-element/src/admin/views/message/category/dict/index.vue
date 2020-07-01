<template>
    <dialog-model v-model="value" title="字典详情信息列表" width="900" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
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
    components: {
        edit
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    props: {
        data: { type: Object },
        value: { type: [Boolean, String] },
        callback: Function,

    },
    data() {
        return {
            apiUrl: this.$api.message.dict, // 请求路很                

            /* ------------ */
            QueryParam: {}, //  搜索条件
            queryComponentData: [
                { "name": "el-input", "key": "title", "label": "标题", "attr": { "placeholder": "请输入标题" } },

            ],
            tableData: [],
            tableParams: [
                {
                    prop: 'name', label: '标题',
                },
                {
                    prop: 'paramName', label: '参数名称',
                },
                {
                    prop: 'paramValue', label: '参数值',
                },
                {
                    prop: 'status', label: '状态', width: 80,
                    formatF: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></c-switch>
                },
                {
                    prop: 'status', label: "操作", width: 160,
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

            category: [],   // 分类列表
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
                msgCode: this.data.code,
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
        handleEdit(row = { status: 1 }, requestType = 'post') {
            this.dialogValue = true;
            this.form = this.DeepCopy(row);
            this.form.msgCode = this.data.code;
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