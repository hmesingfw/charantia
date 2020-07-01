<template>
    <dialog-alert v-model="value" title="商会圈消息" width="1200" @submit="handleUpdate" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="70px" :rules="rules" :model="form" ref="ruleForm" style="padding: 0 20px;">
            <el-row>
                <el-col :span="12">
                    <el-form-item label="标题" prop="title">
                        <el-input v-model="form.title" maxlength="32" show-word-limit></el-input>
                    </el-form-item>

                    <el-form-item label="内容" prop="content">
                        <el-input type="textarea" :rows="4" v-model="form.content" maxlength="500" show-word-limit></el-input>
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
        </el-form>
    </dialog-alert>
</template>
<script>
import { mapState } from 'vuex';
export default {
    components: {

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
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
        }
    },
    created() {
    },
    methods: {

        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let issucc = await this.ReqData(this.url, this.form, this.requestType);
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