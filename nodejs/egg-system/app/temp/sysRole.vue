<template>
    <div>
        <el-form :inline="true" :model="QueryParam" class="header-query-form">
            <generate-form :datalist="queryComponentData" :model="QueryParam" @change="query(1)"></generate-form>

            <generate-query :edit="handleEdit" :url="apiUrl" :callback="query" :multipleSelection="multipleSelection"></generate-query>
        </el-form>

        <div class="article-table">
            <generate-table :data="tableData" :params="tableParams" @selection-change="val => multipleSelection = val" v-loading="tableLoading"></generate-table>
            <pagination :data="pagination" :callback="query" />
        </div>

        <dialog-alert v-model="dialogValue" title="信息录入" :type="requestType" @submit="handleUpdate"
            :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="标识" prop="code">
                    <el-input v-model="form.code" maxlength="32" :disabled="false"></el-input>
                </el-form-item>
				
                <el-form-item label="名称" prop="name">
                    <el-input v-model="form.name" maxlength="32" :disabled="false"></el-input>
                </el-form-item>
				
                <el-form-item label="状态" prop="status">
                	<el-switch class="switch-style" v-model="form.status" active-value="0" active-text="启用" inactive-value="1" inactive-text="禁用"></el-switch>             
                </el-form-item>
				
                <el-form-item label="备注" prop="remark">
                    <el-input v-model="form.remark" maxlength="200" :disabled="false"></el-input>
                </el-form-item>
				
            </el-form>
        </dialog-alert>
    </div>
</template>
<script>
    import { mapState } from 'vuex';

    export default {
        computed: {
            ...mapState({
            	statusList: state => state.enumList.data.statusList,
	
            })
        },
        data() {
            return {
                apiUrl: this.$api.sys.tag, // 请求路很
                rules: {
                    title: [{
                        required: true,
                        message: '请输入内容',
                        trigger: 'blur'
                    }, ],
                },

                /* ------------ */  
                QueryParam: {}, //  搜索条件
                queryComponentData: [{"name":"el-input","key":"code","label":"标识","attr":{"placeholder":"请输入内容"}},{"name":"el-input","key":"name","label":"名称","attr":{"placeholder":"请输入内容"}},{"name":"el-switch","key":"status","label":"状态","attr":{"placeholder":"请选择内容","clearable":true},"option":"statusList"}],
                tableData: [],
                tableParams: [                	{ prop:'code',label:'标识',	 },                	{ prop:'name',label:'名称',	 },                	{ prop:'status',label:'状态', f: row => <z-update-switch data={row} data-key="status" url={this.apiUrl} callback={this.query}></z-update-switch>,	 },                	{ prop:'remark',label:'备注',	 },                	{ prop:'updatedAt',label:'更新时间',	 },            
                    { prop: 'status', label: "操作", f: row => <div><el-button size="mini" type="text" on-click={() => this.handleEdit(row, 'put')}>编辑</el-button><el-button size="mini" type="text" on-click={() => this.HandleDelete(this.apiUrl, row, this.query)}>删除</el-button></div> },],
                tableLoading: false,
                multipleSelection: [], // 多选选中的值

                pagination: {
                    page: 1,
                    size: localStorage.getItem('pageSize') || 10,
                },
                totalCount: 0, // 总共多少条
                /* 表单 */
                dialogValue: false,
                requestType: '', // 请求类型
                loadingButton: false,
                form: {},
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
                    this.tableData = res.data.rows;
                    this.totalCount = res.data.count;
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
            /* 保存 */
            async handleUpdate() {
                this.$refs.ruleForm.validate(async valid => {
                    if (valid) {
                        this.loadingButton = true;
                        let issucc = await this.ReqData(this.apiUrl, this.form, this.requestType);
                        if (issucc) {
                            this.loadingButton = false;
                            this.dialogValue = false;
                            this.query();
                        } else {
                            this.loadingButton = false;
                        }
                    }
                });
            },
        }
    };
</script>