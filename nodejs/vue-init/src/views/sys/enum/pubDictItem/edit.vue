 <template>
     <dialog-alert v-model="value" title="信息录入" @submit="handleUpdate"  @colse="colse" :isColse="false"
        :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="字典值" prop="dictCode">
                <el-input v-model="form.dictCode" maxlength="16" :disabled="false" show-word-limit placeholder="请输入字典值"></el-input>
            </el-form-item>
				
            <el-form-item label="文本标题" prop="itemLabel">
                <el-input v-model="form.itemLabel" maxlength="32" :disabled="false" show-word-limit placeholder="请输入文本标题"></el-input>
            </el-form-item>
				
            <el-form-item label="数据值" prop="itemValue">
                <el-input v-model="form.itemValue" maxlength="16" :disabled="false" show-word-limit placeholder="请输入数据值"></el-input>
            </el-form-item>
				
            <el-form-item label="数据状态" prop="status">
                <el-input v-model="form.status" maxlength="1" :disabled="false" show-word-limit placeholder="请输入数据状态"></el-input>
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