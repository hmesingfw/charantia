 <template>
     <dialog-alert v-model="value" title="信息录入" @submit="handleUpdate"  @colse="colse" :isColse="false"
        :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="编码" prop="dictCode">
                <el-input v-model="form.dictCode" maxlength="16" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="名称" prop="dictName">
                <el-input v-model="form.dictName" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="描述" prop="description">
                <el-input v-model="form.description" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="数据状态" prop="status">
                <el-radio-group v-model="form.status" maxlength="1" :disabled="false">
                	<el-radio v-for="item in statusList" :key="item.id" :label="item.value">{{item.title}}</el-radio>
                </el-radio-group>
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