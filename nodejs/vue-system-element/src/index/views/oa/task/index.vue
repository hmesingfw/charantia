<template>
    <div>
        <div class="app-main-table">
            <el-form :inline="true" :model="QueryParam" class="header-query-form">
                <generate-form :model="QueryParam" :datalist="queryComponentData" @change="query(1)"></generate-form>
            </el-form>
        </div>
        <div class="app-main-table">
            <generate-handle :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-handle>
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" v-loading="tableLoading"></generate-table>
            <pagination :data="pagination" :total="totalCount" :callback="query" />
        </div>

        <edit v-model="dialogValue" :form="form" :requestType="requestType" :callback="query" :url="apiUrl"></edit>
    </div>
</template>
<script> 
import edit from './edit'
export default {
    components: {
        edit
    },

    data() {
        return {
            apiUrl: this.$api.sys.role,          // 请求路很

            /* ------------ 表格 */
            QueryParam: {
                status: ''
            },             //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'name', label: "姓名", attr: { placeholder: '请输入会员姓名' } },
            ],
            tableData: [],
            tableParams: [
                { prop: 'title', label: "标题" },
                { prop: 'description', label: "描述" },

                {
                    prop: 'title', label: "时间",
                    formatF: row => <div> {row.startTime && row.startTime.substring(0, 16)} - {row.endTime && row.endTime.substring(0, 16)} </div>
                },
                {
                    prop: 'taskStatus', width: 80,
                    labelF: () => <generate-label label='任务状态' data-key='taskStatus' option='statusList' params={this.QueryParam} callback={this.query}></generate-label>,
                    formatF: row => <div> {row.taskStatus} </div>
                },
                {
                    prop: 'important', width: 80,
                    labelF: () => <generate-label label='紧要程度' data-key='important' option='statusList' params={this.QueryParam} callback={this.query}></generate-label>,
                    formatF: row => <c-switch data={row} data-key="important" url={this.apiUrl} callback={this.query}></c-switch>
                },
                {
                    prop: 'status', width: 80,
                    labelF: () => <generate-label label='状态' data-key='status' option='statusList' params={this.QueryParam} callback={this.query}></generate-label>,
                    formatF: row => <c-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></c-switch>
                },

                {
                    prop: 'status', label: "操作", width: 160,
                    formatF: row => <div>
                        <el-button type="text" on-click={() => this.handleEdit(row, 'put')} icon="el-icon-edit" >编辑</el-button>
                        <el-button type="text" on-click={() => this.handleEdit(row, 'put')} icon="el-icon-setting" >设置</el-button>
                        <el-button type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)} icon="el-icon-delete" >删除</el-button>
                    </div>
                },
            ],
            tableLoading: false,
            multipleSelection: [],      // 多选选中的值
            pagination: {
                ...this.ConfigParmas.pagination
            },
            totalCount: 0,      // 总共多少条

            /* 表单 */
            dialogValue: false,
            requestType: '',            // 请求类型
            form: {},
        };
    },
    created() {
        this.query();
    },
    methods: {
        /* 查询操作 */
        query(flag) {
            if (flag == 1) this.pagination.page = 1;         // 查询时，让页面等于1
            let param = { ...this.pagination, ...this.QueryParam };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, { params: param }).then(res => {
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

    }
};
</script>

