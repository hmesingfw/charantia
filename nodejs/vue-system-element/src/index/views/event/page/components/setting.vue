<template>
    <el-row>
        <div class="app-main-table">
            <el-row style="padding:40px">
                <el-form label-position="right" label-width="100px" :rules="rules" :model="info" ref="ruleForm">
                    <!-- <span class="info-column-title">基础信息</span> -->
                    <!-- <el-divider></el-divider> -->
                    <el-col :xl="4" :md="4" style="height:10px"></el-col>
                    <el-col :xl="8" :md="8">
                        <el-form-item label="开启验证码" prop="isVerify">
                            <el-switch class="switch-style" v-model="form.isVerify" v-bind="ConfigParmas.switchValue2"></el-switch>
                        </el-form-item>
                        <el-form-item label="收费" prop="isFree">
                            <el-switch class="switch-style" v-model="form.isFree" v-bind="ConfigParmas.switchValue2"></el-switch>
                        </el-form-item>

                        <el-form-item label="游客投票" prop="allowGuest">
                            <el-switch class="switch-style" v-model="form.allowGuest" v-bind="ConfigParmas.switchValue"></el-switch>
                        </el-form-item>

                        <el-form-item label="需要登陆" prop="allowLogin">
                            <el-switch class="switch-style" v-model="form.allowLogin" v-bind="ConfigParmas.switchValue2"></el-switch>
                        </el-form-item>
                        <el-form-item label="微信通知" prop="allowWechat">
                            <el-switch class="switch-style" v-model="form.allowWechat" v-bind="ConfigParmas.switchValue2"></el-switch>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="8" :md="8">
                        <el-form-item label="活动人数" prop="limitCount">
                            <el-input-number v-model="form.limitCount" :max="1000" :min="0"></el-input-number>
                            <span>/人</span>
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
    components: {

    },
    props: {
        info: Object,
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
                    await this.ReqData(this.$api.sys.tenant, this.info, 'put');

                    this.loadingButton = false;
                }
            });
        },
    }
}
</script>