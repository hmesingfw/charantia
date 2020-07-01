 <template>
    <dialog-alert
        v-model="value"
        title="信息录入"
        @submit="handleUpdate"
        @colse="colse"
        :isColse="false"
        :loading-button="loadingButton"
        @changeLoadingButton="loadingButton = false"
        :modal-append-to-body="false"
    >
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="分类标识" prop="code">
                <el-input v-model="form.code" maxlength="16" :disabled="requestType == 'put'" placeholder="请输入分类标识"></el-input>
            </el-form-item>

            <el-form-item label="标题" prop="title">
                <el-input v-model="form.title" maxlength="20" :disabled="false" show-word-limit placeholder="请输入标题"></el-input>
            </el-form-item>

            <el-form-item label="目标表" prop="target">
                <el-input v-model="form.target" maxlength="32" :disabled="false" show-word-limit placeholder="请输入目标表"></el-input>
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
        requestType: { type: String, default: '' },
        callback: Function,
        url: { type: String, default: '' },
    },
    data() {
        return {
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                target: [{ required: true, message: '请输入内容', trigger: 'blur' },],
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
                    let issucc = await this.ReqData(this.url, this.form, this.requestType, { idKey: 'code' });
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