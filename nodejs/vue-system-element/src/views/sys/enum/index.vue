<template>
    <div>
        <el-form :inline="true" :model="QueryParam" class="header-query-form">
            <generate-form :model="QueryParam" :datalist="queryComponentData"></generate-form>

            <el-form-item>
                <el-button @click="query(1)" icon="el-icon-search" circle></el-button>
                <el-button @click="handleEdit({sort:1,status:'0',parentId:'0'}, 'post')" circle type="primary" icon="el-icon-plus"></el-button>
                <el-button @click="HandleDelete(apiUrl, multipleSelection, query);" icon="el-icon-delete" circle type="danger" v-show="multipleSelection.length>0"></el-button>
            </el-form-item>
        </el-form>
        <div class="article-table">
            <el-table
                :data="tableData"
                @selection-change="val => multipleSelection = val"
                v-loading="tableLoading"
                style="width: 100%"
                :stripe="true"
                row-key="id"
                :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
                header-row-class-name="table-header-color"
            >
                <el-table-column type="selection" width="42"></el-table-column>
                <el-table-column prop="title" label="标题" show-overflow-tooltip></el-table-column>
                <el-table-column prop="value" label="值" show-overflow-tooltip></el-table-column>
                <el-table-column prop="sort" label="排序" width="120">
                    <template slot-scope="scope">
                        <el-popconfirm title="修改排序" @onConfirm="UpdateField(scope.row, apiUrl, 'sort', query)">
                            <el-input-number slot="reference" v-model="scope.row.sort" controls-position="right" class="el-input-number-table" :min="1" :max="1000" size="mini"></el-input-number>
                        </el-popconfirm>
                    </template>
                </el-table-column>

                <el-table-column label="状态" width="80">
                    <template slot-scope="scope">
                        <el-switch
                            class="switch-style"
                            v-model="scope.row.status"
                            @change="UpdateSwitch(scope.row, apiUrl, 'status', query)"
                            active-value="0"
                            active-text="启用"
                            inactive-value="1"
                            inactive-text="禁用"
                        ></el-switch>
                    </template>
                </el-table-column>
                <el-table-column prop="details" label="备注" show-overflow-tooltip></el-table-column>
                <el-table-column prop="updatedAt" label="更新时间" width="140"></el-table-column>

                <el-table-column label="操作" width="160" fixed="right">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" @click="handleEdit(scope.row, 'put')">编辑</el-button>
                        <el-button size="mini" type="text" @click="HandleDelete(apiUrl, scope.row, query)">删除</el-button>
                        <el-button size="mini" type="text" v-if="scope.row.parentId == '0'" @click="handleEdit({sort:1,status:'0',parentId:scope.row.id} , 'post')">添加值</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>

        <dialog-alert v-model="dialogValue" title="枚举值" :type="requestType" @submit="handleUpdate" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
            <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="标题" prop="title">
                    <el-input v-model="form.title" maxlength="32"></el-input>
                </el-form-item>
                <el-form-item label="值" prop="value">
                    <el-input v-model="form.value" maxlength="32"></el-input>
                </el-form-item>
                <el-form-item label="排序" prop="sort">
                    <el-input-number v-model="form.sort" :min="1" :max="100000"></el-input-number>
                </el-form-item>
                <el-form-item label="备注" prop="details">
                    <el-input type="textarea" :rows="2" v-model="form.details" maxlength="255"></el-input>
                </el-form-item>

                <el-form-item label="状态" prop="status">
                    <el-switch class="switch-style" v-model="form.status" active-value="0" active-text="启用" inactive-value="1" inactive-text="禁用"></el-switch>
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
        })
    },
    data() {
        return {
            apiUrl: this.$api.sys.enum,          // 请求路很
            rules: {
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                value: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },

            /* 基本不变------------ */
            QueryParam: {},             //  搜索条件
            queryComponentData: [
                { name: 'el-input', key: 'title', label: "标题", attr: { placeholder: '请输入标题' } },
            ],
            tableData: [],
            tableLoading: false,
            multipleSelection: [],      // 多选选中的值

            /* 表单 */
            dialogValue: false,
            requestType: '',            // 请求类型
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
            if (flag == 1) this.pagination.page = 1;         // 查询时，让页面等于1
            let param = {
                ...this.pagination,
                ...this.QueryParam
            };
            this.tableLoading = true;
            this.$http.get(this.apiUrl, { params: param }).then(res => {
                this.tableData = res.data.rows;
                this.tableLoading = false;
            }).catch(() => {
                this.tableLoading = false;
            });
        },
        /* 编辑 */
        handleEdit(row, requestType) {
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

                        this.$store.dispatch('enumList/getEnum');
                    } else {
                        this.loadingButton = false;
                    }
                }
            });
        },
        /* 到这里基本不变----------- */
    }
};
</script>

<style lang="scss">
</style>
