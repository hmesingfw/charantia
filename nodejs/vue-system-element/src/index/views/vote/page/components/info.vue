<template>
    <el-row>
        <div class="app-main-table">
            <el-row style="padding:20px 40px 40px">
                <el-form label-position="right" label-width="100px" :rules="rules" :model="info" ref="ruleForm">
                    <span class="info-column-title">投票信息</span>
                    <el-divider></el-divider>
                    <el-col :xl="16" :md="12">
                        <el-form-item label="标题" prop="title">
                            <el-input v-model="form.title" maxlength="32"></el-input>
                        </el-form-item>
                        <el-form-item label="投票时间" prop="postTime">
                            <el-date-picker v-model="form.postTime" type="datetimerange" range-separator="-" start-placeholder="开始日期" end-placeholder="结束日期" format="yyyy-MM-dd mm:HH:ss"></el-date-picker>
                        </el-form-item>

                        <el-form-item label="描述" prop="description">
                            <el-input type="textarea" :rows="4" v-model="form.description" maxlength="512" show-word-limit></el-input>
                        </el-form-item>
                        <el-form-item label="内容" prop="content" class="vue-ueditor-wrap-s">
                            <vue-ueditor-wrap v-model="form.content" :config="myConfig"></vue-ueditor-wrap>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="8" :md="12">
                        <el-form-item label="封面" prop="thumb">
                            <c-file v-model="form.thumb" fileUrl="api"></c-file>
                        </el-form-item>
                    </el-col>

                    <!-- <el-col :xl="8" :md="12">
                        <span class="info-column-title">内容</span>
                        <el-form-item label="封面" prop="thumb">

                        <el-divider></el-divider>
                       
                    </el-col>-->
                </el-form>
            </el-row>
        </div>
    </el-row>
</template>
<script>
import vueUeditorWrap from 'vue-ueditor-wrap';
import { mapState } from 'vuex';
import { ueConfig } from '@/utils/sys';

export default {
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    components: {
        vueUeditorWrap
    },
    props: {
        info: Object,
    },
    data() {
        return {
            url: 'http://',
            form: {},
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
            myConfig: { ...ueConfig, initialFrameHeight: 400 },

        }
    },
    methods: {
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let issucc = await this.ReqData(this.$api.sys.tenant, this.info, 'put');
                    if (issucc) {
                        console.log('-');
                    }
                    this.loadingButton = false;
                }
            });
        },
    }
}
</script>