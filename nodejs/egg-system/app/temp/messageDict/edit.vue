 <template>
     <dialog-alert v-model="value" title="信息录入" @submit="handleUpdate"  @colse="colse" :isColse="false"
        :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="消息分类" prop="msgCode">
                <el-input v-model="form.msgCode" maxlength="32" :disabled="false" show-word-limit placeholder="请输入消息分类"></el-input>
            </el-form-item>
				
            <el-form-item label="中文名称 如{用户名}" prop="name">
                <el-input v-model="form.name" maxlength="32" :disabled="false" show-word-limit placeholder="请输入中文名称 如{用户名}"></el-input>
            </el-form-item>
				
            <el-form-item label="参数名称 name" prop="paramName">
                <el-input v-model="form.paramName" maxlength="32" :disabled="false" show-word-limit placeholder="请输入参数名称 name"></el-input>
            </el-form-item>
				
            <el-form-item label="参数值" prop="paramValue">
                <el-input v-model="form.paramValue" maxlength="32" :disabled="false" show-word-limit placeholder="请输入参数值"></el-input>
            </el-form-item>
				
            <el-form-item label="数据状态" prop="status">
                <el-select v-model="form.status" maxlength="1" :disabled="false">
                	<el-option v-for="item in statusList" :key="item.id" :label="item.title" :value="item.value"></el-option>
                </el-select>
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