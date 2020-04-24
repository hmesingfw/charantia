 <template>
    <dialog-alert v-model="value" width="600px" title="信息录入" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="手机号" prop="phone">
                <el-input v-model="form.phone" maxlength="16" :disabled="false" show-word-limit></el-input>
            </el-form-item>

            <el-form-item label="密码" prop="password">
                <el-input v-model="form.password" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>

            <el-form-item label="姓名" prop="name">
                <el-input v-model="form.name" maxlength="128" :disabled="false" show-word-limit></el-input>
            </el-form-item>

            <el-form-item label="状态" prop="status">
                <el-switch class="switch-style" v-model="form.status" active-value="0" active-text="启用" inactive-value="1" inactive-text="禁用"></el-switch>
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