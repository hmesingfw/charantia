<template>
    <el-row>
        <div class="app-main-table">
            <el-row style="padding:20px 40px 40px">
                <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
                    <h4 class="info-column-title">基础信息</h4>
                    <el-divider></el-divider>
                    <el-col :xl="16" :md="12">
                        <el-row :gutter="20">
                            <el-col :xl="10" :md="20">
                                <el-form-item label="租户名称" prop="name">
                                    <el-input v-model="form.name" maxlength="32" :disabled="false" show-word-limit></el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :xl="10" :md="20">
                                <el-form-item label="管理员" prop="conact">
                                    <el-input v-model="form.conact" maxlength="20" :disabled="false"></el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :xl="10" :md="20">
                                <el-form-item label="手机号码" prop="mobile">
                                    <el-input v-model="form.mobile" maxlength="20" :disabled="false"></el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :xl="10" :md="20">
                                <el-form-item label="电子邮箱" prop="email">
                                    <el-input v-model="form.email" maxlength="32" :disabled="false"></el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :xl="10" :md="20">
                                <el-form-item label="公司地址" prop="address">
                                    <el-input v-model="form.address" maxlength="128" :disabled="false" show-word-limit></el-input>
                                </el-form-item>
                            </el-col>
                        </el-row>
                    </el-col>

                    <el-col :xl="8" :md="12">
                        <el-form-item label="logo" prop="logo">
                            <c-file v-model="form.logo" fileUrl="updateAPI"></c-file>
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
                    if (issucc) {

                    }
                    this.loadingButton = false;
                }
            });
        },
    }
}
</script>