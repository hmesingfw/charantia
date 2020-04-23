 <template>
     <dialog-alert v-model="value" title="信息录入" @submit="handleUpdate"  @colse="colse" :isColse="false"
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
</template>
<script>
export default {
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