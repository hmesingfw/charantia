<template>
    <dialog-model v-model="value" title="资讯信息" width="1200" @submit="handleUpdate" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="70px" :rules="rules" :model="form" ref="ruleForm" style="padding: 0 20px;">
            <el-row>
                <el-col :span="12">
                    <el-form-item label="分类" prop="categoryId">
                        <el-select v-model="form.categoryId" placeholder="请选择分类">
                            <el-option v-for="cate in cateData" :key="cate.id" :label="cate.title" :value="cate.id"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="标题" prop="title">
                        <el-input v-model="form.title" maxlength="32" show-word-limit></el-input>
                    </el-form-item>

                    <el-form-item label="描述" prop="description">
                        <el-input type="textarea" :rows="4" v-model="form.description" maxlength="255" show-word-limit></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="封面" prop="coverId">
                        <c-file
                            v-model="form.coverId"
                            :fileUrl="$api.sys.upload"
                            group="article"
                            :fixedNumber="[4,4]"
                            auto-crop-width="400"
                            auto-crop-height="400"
                            tip="只能上传jpg/png文件，且不超过2M,推荐分辨率 400x400"
                        ></c-file>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="8">
                    <el-form-item label="作者" prop="author">
                        <el-input v-model="form.author" maxlength="32" style="width:270px"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="8">
                    <el-form-item label="发布" prop="postTime">
                        <el-date-picker v-model="form.postTime" type="datetime" placeholder="选择发布日期时间" value-format="yyyy-MM-dd mm:HH:ss"></el-date-picker>
                    </el-form-item>
                </el-col>
                <el-col :span="8">
                    <el-form-item label="状态" prop="postStatus">
                        <el-switch class="switch-style" v-model="form.postStatus" v-bind="ConfigParmas.switchValue6"></el-switch>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-form-item label="内容" prop="content" class="vue-ueditor-wrap-s">
                <vue-ueditor-wrap v-model="form.content" :config="myConfig"></vue-ueditor-wrap>
            </el-form-item>
        </el-form>
    </dialog-model>
</template>
<script>
import { mapState } from 'vuex';
import VueUeditorWrap from 'vue-ueditor-wrap'; // ES6 Module
import { ueConfig } from '@/utils/sys';
export default {
    components: {
        VueUeditorWrap
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    props: {
        value: { type: [Boolean, String] },
        form: Object,
        requestType: String,
        callback: Function,
        url: String,
    },
    data() {
        return {
            category: this.$api.menber.articleCategory,          // 分类路很

            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
            myConfig: ueConfig,
            cateData: [],
        }
    },
    created() {
        this.init();
    },
    methods: {
        init() {
            let param = {
                page: 1,
                limit: 1000,
                status: 1
            };
            this.tableLoading = true;
            this.$http.get(this.category, { params: param }).then(res => {
                this.cateData = res.data.data.list;
            })
        },
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let issucc = await this.ReqData(this.url, this.form, this.requestType);
                    await this.$http[this.requestType](this.url + '/' + this.form.id + '/detail', this.form);
                    if (issucc) {
                        this.callback();
                        this.$emit('input', false);
                    }

                    this.loadingButton = false;
                }
            });
        },
        colse() {
            this.$emit('input', false);
        }
    }
}
</script>