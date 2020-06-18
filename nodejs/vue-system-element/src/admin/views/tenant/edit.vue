 <template>
    <dialog-alert v-model="value" width="600px" title="创建租户" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-row>
            <el-form label-width="80px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="租户名称" prop="name">
                    <el-input v-model="form.name" maxlength="32" :disabled="false" show-word-limit placeholder="请输入租户名称"></el-input>
                </el-form-item>

                <el-form-item label="联系人" prop="conact">
                    <el-input v-model="form.conact" maxlength="20" :disabled="false" placeholder="请输入联系人"></el-input>
                </el-form-item>

                <el-form-item label="手机号码" prop="mobile">
                    <el-input v-model="form.mobile" maxlength="24" :disabled="false" placeholder="请输入手机号码"></el-input>
                </el-form-item>
                <el-form-item label="地址" prop="address">
                    <el-input v-model="form.address" maxlength="24" :disabled="false" placeholder="请输入地址"></el-input>
                </el-form-item>
                <el-divider></el-divider>
                <div>
                    <i class="el-icon-info"></i>初始化账号：admin
                </div>
                <div>
                    <i class="el-icon-info"></i>初始化密码：当前手机号码
                </div>
                <!--
                <el-form-item label="账号" prop="account">
                    <el-input v-model="form.account" maxlength="24" :disabled="false" placeholder="请输入账号"></el-input>
                </el-form-item>
                <el-form-item label="密码" prop="password">
                    <el-input v-model="form.password" maxlength="24" :disabled="false" placeholder="请输入密码"></el-input>
                </el-form-item>-->
            </el-form>
        </el-row>
    </dialog-alert>
</template>
<script>
import { mapState } from 'vuex'
export default {
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
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
                code: [{ required: true, message: '请输入租户名称', trigger: 'blur' },],
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