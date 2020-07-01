<template>
    <el-row v-loading="tableLoading">
        <div class="title-divider app-main-table">
            <h4 class="info-column-title">{{ info.title }}</h4>
            <el-divider></el-divider>
        </div>
        <el-row class="app-main-table" style="padding:20px 50px">
            <el-col :xs="20" :md="12">
                <el-form label-position="right" label-width="50px" :rules="rules" :model="form" ref="ruleForm">
                    <el-form-item v-for="item in dataList" :key="item.id" :label="item.title" prop="title">
                        <el-input v-if="item.type == 'input'" v-model="form[item.name]" maxlength="32" :placeholder="item.remark"></el-input>

                        <el-select v-if="item.type == 'select'" v-model="form[item.name]" placeholder="请选择内容">
                            <el-option v-for="opt in item.options" :key="opt.id" :label="opt.label" :value="opt.id"></el-option>
                        </el-select>
                    </el-form-item>
                    <div style="text-align: center;width:100%">
                        <el-button @click="handleUpdate" type="primary" v-loading="tableLoading">保存</el-button>
                    </div>
                </el-form>
            </el-col>
        </el-row>
    </el-row>
</template>
<script>
import { mapState, mapGetters } from 'vuex';
export default {
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        }),
        ...mapGetters({
            userInfo: 'info'
        })
    },
    props: {
        info: Object
    },
    data() {
        return {
            apiUrl: this.$api.sys.config,
            saveUrl: this.$api.menber.config,
            form: {},
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,

            dataList: [],               // 整个form数据列表
            optionList: [],             // select 列表
            tempOption: [],
            tableLoading: false,
            requestType: 'put',

            fieldType: [
                { title: '输入文本', value: 'input', },
                { title: '单选值', value: 'radio', },
            ],
        }
    },
    created() {
        this.query();
    },
    methods: {
        async  query() {
            /* 取到已有的数据 */
            const body = {
                tenantId: this.userInfo.id,
            }
            let repo = await this.$http.get(this.saveUrl, { params: body });
            let saveList = repo.data.data;


            let param = {
                category: this.info.value
            };
            this.tableLoading = true;
            let res = await this.$http.get(this.apiUrl, { params: param });
            this.dataList = res.data.data || [{}];
            this.dataList = this.dataList.map(item => {
                /* 初始化 form 需要 加载的值 */
                for (let index = 0; index < saveList.length; index++) {
                    const element = saveList[index];
                    if (element.confId == item.id) {
                        this.$set(this.form, item.name, element.confValue);
                        break;
                    }
                }
                /* 重组数组，主要是options的json转义 */
                item.options = item.options || [];
                return {
                    ...item,
                    options: JSON.parse(item.options)
                }
            })


            this.tableLoading = false;
        },
        /* 保存 */
        async handleUpdate() {
            this.tableLoading = true;
            let arr = this.dataList.map(item => ({
                confId: item.id,
                confValue: this.form[item.name],
                tenantId: this.userInfo.id,
            }))
            let res = await this.$http.put(this.saveUrl, arr);
            this.$message.success(res.data.message)
            this.tableLoading = false;
        },
    }
}
</script>


<style lang="scss">
.title-divider {
    padding: 0px 20px;
}
</style>