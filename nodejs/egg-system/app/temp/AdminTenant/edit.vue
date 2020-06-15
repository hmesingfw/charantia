 <template>
     <dialog-alert v-model="value" title="信息录入" @submit="handleUpdate"  @colse="colse" :isColse="false"
        :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="租户名称" prop="name">
                <el-input v-model="form.name" maxlength="128" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="logo" prop="logo">
                <el-input v-model="form.logo" maxlength="20" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="联系人" prop="conact">
                <el-input v-model="form.conact" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="手机号码" prop="mobile">
                <el-input v-model="form.mobile" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="电子邮箱" prop="email">
                <el-input v-model="form.email" maxlength="32" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="公司地址" prop="address">
                <el-input v-model="form.address" maxlength="128" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="域名前缀" prop="domain">
                <el-input v-model="form.domain" maxlength="128" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="注册类型" prop="regType">
                <el-input v-model="form.regType" maxlength="1" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="授权时间" prop="startTime">
                <el-date-picker v-model="form.startTime" type="date" placeholder="选择日期"></el-date-picker>
            </el-form-item>
				
            <el-form-item label="授权结束时间" prop="endTime">
                <el-date-picker v-model="form.endTime" type="date" placeholder="选择日期"></el-date-picker>
            </el-form-item>
				
            <el-form-item label="账号限制数" prop="accountLimit">
                <el-input v-model="form.accountLimit" maxlength="10" :disabled="false" show-word-limit></el-input>
            </el-form-item>
				
            <el-form-item label="网盘容量" prop="diskCapacity">
                <el-input v-model="form.diskCapacity" maxlength="10" :disabled="false" show-word-limit></el-input>
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