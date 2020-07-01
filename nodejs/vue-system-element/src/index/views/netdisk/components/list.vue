<template>
    <div>
        <div class="app-main-table">
            <el-form :inline="true" :model="QueryParam" class="header-query-form">
                <generate-form :model="QueryParam" :datalist="queryComponentData" @change="query(1)"></generate-form>
            </el-form>
        </div>
        <div class="app-main-table">
            <el-row class="handle-container">
                <el-button @click="handleEdit()" type="primary" icon="el-icon-upload2">上传</el-button>
                <el-button @click="handleEdit()" type="primary" icon="el-icon-folder-add">新建文件夹</el-button>
                <el-button @click="HandleDelete(apiUrl, multipleSelection, query);" icon="el-icon-delete" type="danger" v-show="multipleSelection.length>0">批量删除</el-button>
            </el-row>
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" v-loading="tableLoading"></generate-table>
            <pagination :data="pagination" :total="totalCount" :callback="query" />
        </div>

        <ufile v-model="dialogValue" :form="form" :requestType="requestType" :callback="query" :url="apiUrl"></ufile>
    </div>
</template>
<script> 
import ufile from './ufile'
export default {
    components: {
        ufile
    },

    data() {
        return {
            apiUrl: 'https://mock.yonyoucloud.com/mock/8636/netdisk',          // 请求路很

            /* ------------ 表格 */
            QueryParam: {
                status: ''
            },             //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'fileName', label: "文件名", attr: { placeholder: '请输入文件名' } },
            ],
            tableData: [],
            tableParams: [
                {
                    prop: 'fileName', label: "文件名",
                    formatF: row => <div>
                        <svg-icon icon-class="link" class-name="svg-class" />
                        <span class="app-netdisk-fileName">
                            {row.fileName}
                        </span>
                    </div>
                },
                {
                    prop: 'size', label: "文件大小", width: 160,
                    formatF: row => <div>{row.size} M</div>
                },

                { prop: 'updatedTime', label: "更新时间", width: 160 },

                {
                    prop: 'status', label: "操作", width: 240,
                    formatF: row => <div>
                        <el-button type="text" on-click={() => this.handleEdit(row, 'put')} icon="el-icon-edit" >重命名</el-button>
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
<style lang="scss">
.app-netdisk-fileName {
    font-size: 14px;
    padding-left: 10px;
}
</style>

