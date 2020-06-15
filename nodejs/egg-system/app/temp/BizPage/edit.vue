 <template>
     <dialog-alert v-model="value" title="信息录入" @submit="handleUpdate"  @colse="colse" :isColse="false"
        :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="自增ID" prop="id">
                <el-input v-model="form.id" maxlength="20" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="单页类型" prop="pageType">
                <el-input v-model="form.pageType" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="标题" prop="title">
                <el-input v-model="form.title" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="描述" prop="description">
                <el-input v-model="form.description" maxlength="255" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="内容" prop="content">
                <el-input v-model="form.content" maxlength="2048" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="分组" prop="pageGroup">
                <el-input v-model="form.pageGroup" maxlength="1" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="数据状态" prop="status">
                <el-select v-model="form.status" maxlength="1" :disabled="false">
                	<el-option v-for="item in statusList" :key="item.id" :label="item.title" :value="item.value"></el-option>
                </el-select>
            </el-form-item>
				
            <el-form-item label="创建时间" prop="createdTime">
                <el-date-picker v-model="form.createdTime" type="date" placeholder="选择日期"></el-date-picker>
            </el-form-item>
				
            <el-form-item label="创建人" prop="createdBy">
                <el-input v-model="form.createdBy" maxlength="20" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="更新时间" prop="updatedTime">
                <el-date-picker v-model="form.updatedTime" type="date" placeholder="选择日期"></el-date-picker>
            </el-form-item>
				
            <el-form-item label="更新人" prop="updatedBy">
                <el-input v-model="form.updatedBy" maxlength="20" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="租户ID" prop="tenantId">
                <el-input v-model="form.tenantId" maxlength="20" :disabled="false" show-word-limit></el-input>
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