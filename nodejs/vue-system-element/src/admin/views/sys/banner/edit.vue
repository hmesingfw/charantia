 <template>
    <dialog-alert v-model="value" title="广告位置信息" width="500px" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="位置标识" prop="posCode">
                <el-input v-model="form.posCode" maxlength="32" :disabled="requestType == 'put'" show-word-limit></el-input>
            </el-form-item>
            <el-form-item label="位置名称" prop="title">
                <el-input v-model="form.title" maxlength="60" :disabled="false" show-word-limit></el-input>
            </el-form-item>
            <!-- <el-form-item label="类型" prop="type">
                <el-select v-model="form.type" placeholder></el-select>
            </el-form-item>-->
            <el-form-item label="宽度" prop="width">
                <el-input-number v-model="form.width" :min="100" :max="2000"></el-input-number>
            </el-form-item>
            <el-form-item label="高度" prop="height">
                <el-input-number v-model="form.height" :min="100" :max="2000"></el-input-number>
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
                posCode: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                title: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                width: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                height: [{ required: true, message: '请输入内容', trigger: 'blur' },],
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
                    let issucc = await this.ReqData(this.url, this.form, this.requestType, { idKey: 'posCode' });
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