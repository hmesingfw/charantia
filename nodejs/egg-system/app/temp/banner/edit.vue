 <template>
     <dialog-alert v-model="value" title="信息录入" @submit="handleUpdate"  @colse="colse" :isColse="false"
        :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="" prop="id">
                <el-input v-model="form.id" maxlength="36" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="标题" prop="title">
                <el-input v-model="form.title" maxlength="16" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="文件" prop="coverId">
                <el-input v-model="form.coverId" maxlength="11" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="开始时间" prop="startDate">
                <el-date-picker v-model="form.startDate" type="date" placeholder="选择日期"></el-date-picker>
            </el-form-item>
				
            <el-form-item label="结束时间" prop="endDate">
                <el-date-picker v-model="form.endDate" type="date" placeholder="选择日期"></el-date-picker>
            </el-form-item>
				
            <el-form-item label="排序" prop="sort">
                <el-input-number v-model="form.sort"></el-input-number>
            </el-form-item>
				
            <el-form-item label="状态" prop="status">
            	<el-switch class="switch-style" v-model="form.status" active-value="0" active-text="启用" inactive-value="1" inactive-text="禁用"></el-switch>             
            </el-form-item>
				
            <el-form-item label="" prop="createdAt">
                <el-date-picker v-model="form.createdAt" type="date" placeholder="选择日期"></el-date-picker>
            </el-form-item>
				
            <el-form-item label="" prop="updatedAt">
                <el-date-picker v-model="form.updatedAt" type="date" placeholder="选择日期"></el-date-picker>
            </el-form-item>
				
            <el-form-item label="" prop="userId">
                <el-input v-model="form.userId" maxlength="36" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="" prop="details">
                <el-input v-model="form.details" maxlength="255" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="" prop="isDel">
                <el-input v-model="form.isDel" maxlength="1" :disabled="false" show-word-limit></el-input>
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