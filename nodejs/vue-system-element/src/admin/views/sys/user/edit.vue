 <template>
    <dialog-alert v-model="value" title="创建账号" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="70px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="账号" prop="account">
                <el-input v-model="form.account" maxlength="16" :disabled="false" show-word-limit></el-input>
            </el-form-item>

            <el-form-item label="密码" prop="password">
                <el-input v-model="form.password" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>

            <el-form-item label="状态" prop="status">
                <el-switch class="switch-style" v-model="form.status" v-bind="ConfigParmas.switchValue"></el-switch>
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
                account: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                password: [{ required: true, message: '请输入内容', trigger: 'blur' },],
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