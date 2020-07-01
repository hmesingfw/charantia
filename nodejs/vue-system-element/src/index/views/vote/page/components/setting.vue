<template>
    <el-row>
        <div class="app-main-table">
            <el-row style="padding:40px">
                <!-- <span class="info-column-title">投票设置</span> -->
                <!-- <el-divider></el-divider> -->
                <el-form label-position="right" label-width="100px" :rules="rules" :model="info" ref="ruleForm">
                    <el-col :xl="4" :md="4" style="height:10px"></el-col>
                    <el-col :xl="8" :md="8">
                        <el-form-item label="开启验证码" prop="allowVertify">
                            <el-switch class="switch-style" v-model="form.allowVertify" v-bind="ConfigParmas.switchValue2"></el-switch>
                        </el-form-item>
                        <el-form-item label="完成查看结果" prop="allowView">
                            <el-switch class="switch-style" v-model="form.allowView" v-bind="ConfigParmas.switchValue2"></el-switch>
                        </el-form-item>
                        <el-form-item label="游客投票" prop="allowGuest">
                            <el-switch class="switch-style" v-model="form.allowGuest" v-bind="ConfigParmas.switchValue"></el-switch>
                        </el-form-item>

                        <el-form-item label="需要登陆" prop="allowLogin">
                            <el-switch class="switch-style" v-model="form.allowLogin" v-bind="ConfigParmas.switchValue2"></el-switch>
                        </el-form-item>
                        <el-form-item label="开启微信" prop="allowWechat">
                            <el-switch class="switch-style" v-model="form.allowWechat" v-bind="ConfigParmas.switchValue2"></el-switch>
                        </el-form-item>
                    </el-col>
                    <el-col :xl="8" :md="8">
                        <el-form-item label="每日可投票数" prop="voteLimit">
                            <el-input-number v-model="form.voteLimit" :max="100" :min="0"></el-input-number>
                            <span>/次</span>
                        </el-form-item>
                        <el-form-item label="投标间隔" prop="voteTimeNumber">
                            <el-input-number v-model="form.voteTimeNumber" :max="9999" :min="0"></el-input-number>
                            <span>/秒</span>
                        </el-form-item>
                    </el-col>
                </el-form>
            </el-row>
        </div>
    </el-row>
</template>
<script>
import vueUeditorWrap from 'vue-ueditor-wrap';
import { mapState } from 'vuex';
import { ueConfig } from '@/utils/sys';

export default {
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    components: {
        vueUeditorWrap
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
            myConfig: ueConfig,

        }
    },
    methods: {
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let issucc = await this.ReqData(this.$api.sys.tenant, this.info, 'put');
                    if (issucc) {
                        console.log('-');
                    }
                    this.loadingButton = false;
                }
            });
        },
    }
}
</script>