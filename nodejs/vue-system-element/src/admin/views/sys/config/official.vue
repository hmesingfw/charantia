<template>
    <el-row>
        <div class="app-main-table">
            <el-row style="padding:20px 40px 40px">
                <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                    <h4 class="info-column-title">公众号配置</h4>
                    <el-divider></el-divider>

                    <el-col :xl="14" :md="18">
                        <el-form-item label="appid" prop="name">
                            <el-input v-model="form.name" maxlength="128" :disabled="false"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="14" :md="18">
                        <el-form-item label="appsecret" prop="conact">
                            <el-input v-model="form.conact" maxlength="32" :disabled="false"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="14" :md="18">
                        <el-form-item label="域名地址" prop="mobile">
                            <el-input v-model="form.mobile" maxlength="32" :disabled="false"></el-input>
                        </el-form-item>
                    </el-col>
                </el-form>
            </el-row>
        </div>
    </el-row>
</template>
<script>
import { mapState } from 'vuex';
export default {
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
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