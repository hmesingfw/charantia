<template>
    <el-row>
        <div class="app-main-table">
            <el-row style="padding:20px 40px 40px" :gutter="20">
                <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                    <h4 class="info-column-title">基础设置</h4>
                    <el-divider></el-divider>
                    <el-col :xl="10" :md="20">
                        <el-form-item label="域名前缀" prop="domain">
                            <el-input v-model="form.domain" maxlength="128" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="10" :md="20">
                        <el-form-item label="账号限制数" prop="accountLimit">
                            <el-input v-model="form.accountLimit" maxlength="10" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="10" :md="20">
                        <el-form-item label="授权时间" prop="startTime">
                            <el-date-picker v-model="form.startTime" type="date" placeholder="选择日期"></el-date-picker>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="10" :md="20">
                        <el-form-item label="授权结束时间" prop="endTime">
                            <el-date-picker v-model="form.endTime" type="date" placeholder="选择日期"></el-date-picker>
                        </el-form-item>
                    </el-col>

                    <el-col :xl="10" :md="20">
                        <el-form-item label="网盘容量" prop="diskCapacity">
                            <el-input v-model="form.diskCapacity" maxlength="10" :disabled="false" show-word-limit></el-input>
                        </el-form-item>
                    </el-col>
                </el-form>
            </el-row>
        </div>
    </el-row>
</template>
<script>
export default {
    data() {
        return {
            url: 'http://',
            form: {},
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
                    let issucc = await this.ReqData(this.url, this.form, 'post');
                    if (issucc) { }
                    this.loadingButton = false;
                }
            });
        },
    }
}
</script>