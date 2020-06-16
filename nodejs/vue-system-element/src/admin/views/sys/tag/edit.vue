 <template>
     <dialog-alert v-model="value" title="信息录入" @submit="handleUpdate"  @colse="colse" :isColse="false"
        :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="" prop="id">
                <el-input v-model="form.id" maxlength="36" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="标题" prop="title">
                <el-input v-model="form.title" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="类型" prop="type">
                <el-input v-model="form.type" maxlength="36" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="颜色" prop="color">
                <el-input v-model="form.color" maxlength="16" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="排序" prop="sort">
                <el-input v-model="form.sort" maxlength="8" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="状态" prop="status">
                <el-input v-model="form.status" maxlength="1" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="备注" prop="details">
                <el-input v-model="form.details" maxlength="255" :disabled="false" show-word-limit></el-input>
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