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
import { mapGetters } from 'vuex'

export default {
    components: {
        edit
    },
    computed: {
        ...mapGetters({
            info: 'info'
        })
    },
    data() {
        return {
            apiUrl: this.$api.menber.article,          // 请求路很CCCC

            /* ------------ 表格 */
            QueryParam: {
                status: ''
            },             //  搜索条件
            queryComponentData: [
                { name: 'el-switch', key: 'status', label: "状态", option: 'statusList', attr: { placeholder: '请输入' } },
                { name: 'el-input', key: 'name', label: "名称", attr: { placeholder: '请输入角色名称' } },
            ],
            tableData: [],
            tableParams: [
                { prop: 'title', label: "标题", minWidth: 80, },
                { prop: 'author', label: "作者", width: 120, },

                { prop: 'viewCount', label: "阅读数", width: 80, },
                { prop: 'commentCount', label: "评论数", width: 80, },
                { prop: 'collectionCount', label: "收藏数", width: 80, },


                {
                    prop: 'sort', label: '排序', width: 120,
                    formatF: row => <c-number data={row} data-key="sort" url={this.apiUrl} callback={this.query}></c-number>
                },
                {
                    prop: 'postStatus', width: 80,
                    labelF: () => <generate-label label='状态' data-key='postStatus' option='statusList6' params={this.QueryParam} callback={this.query}></generate-label>,
                    formatF: row => <c-switch data={row} data-key="postStatus" url={this.apiUrl} callback={this.query} configtitle="switchValue6"></c-switch>
                },
                {
                    prop: 'isTop', width: 80,
                    labelF: () => <generate-label label='置顶' data-key='isTop' option='statusList2' params={this.QueryParam} callback={this.query}></generate-label>,
                    formatF: row => <c-switch data={row} data-key="isTop" url={this.apiUrl} callback={this.query} configtitle="switchValue2"></c-switch>
                },
                {
                    prop: 'isRecommend', width: 80,
                    labelF: () => <generate-label label='推荐' data-key='isRecommend' option='statusList2' params={this.QueryParam} callback={this.query}></generate-label>,
                    formatF: row => <c-switch data={row} data-key="isRecommend" url={this.apiUrl} callback={this.query} configtitle="switchValue2"></c-switch>
                },
                { prop: 'postTime', label: "发布时间", width: 160 },
                {
                    prop: 'status', label: "操作", width: 240,
                    formatF: row => <div>
                        <el-button type="text" on-click={() => this.handleEdit(row, 'put')} icon="el-icon-edit" >编辑</el-button>
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
        async  handleEdit(row = { sort: 1, status: 1 }, requestType = 'post') {
            this.form = this.DeepCopy(row);
            this.$set(this.form, 'tenantId', this.info.id);

            let content = await this.$http.get(this.apiUrl + '/' + row.id + '/detail')

            this.$set(this.form, 'content', content.data.data.content || "");

            this.dialogValue = true;
            this.requestType = requestType;
        },

    }
};
</script>

