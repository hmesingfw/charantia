 <template>
     <dialog-alert v-model="value" title="信息录入" @submit="handleUpdate"  @colse="colse" :isColse="false"
        :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="" prop="id">
                <el-input v-model="form.id" maxlength="10" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="文件名" prop="fileName">
                <el-input v-model="form.fileName" maxlength="2048" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="文件名" prop="saveName">
                <el-input v-model="form.saveName" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="文件路径" prop="savePath">
                <el-input v-model="form.savePath" maxlength="255" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="后缀" prop="ext">
                <el-input v-model="form.ext" maxlength="5" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="" prop="mime">
                <el-input v-model="form.mime" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="文件大小" prop="size">
                <el-input v-model="form.size" maxlength="20" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="" prop="md5">
                <el-input v-model="form.md5" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="" prop="sha1">
                <el-input v-model="form.sha1" maxlength="64" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="" prop="url">
                <el-input v-model="form.url" maxlength="255" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="是否图片" prop="isImg">
                <el-input v-model="form.isImg" maxlength="1" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="" prop="driver">
                <el-input v-model="form.driver" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
        </el-form>
    </dialog-alert>
</template>
<script>
export default {
    props: {
        value: { type: [Boolean, String] },
        form: Object,
        requestType: { type: String, default: '' },
        callback: Function,
        url: { type: String, default: '' },
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