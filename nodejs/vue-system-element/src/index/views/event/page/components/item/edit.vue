 <template>
    <dialog-alert v-model="value" title="编辑" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="50px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="票名" prop="ticketTitle">
                <el-input v-model="form.ticketTitle" maxlength="20" :disabled="false"></el-input>
            </el-form-item>

            <el-form-item label="价格" prop="ticketPrice">
                <el-input-number v-model="form.ticketPrice" maxlength="20" :disabled="false"></el-input-number>
                <br />
                <span>* 金额输入 0 时为免费票</span>
            </el-form-item>

            <el-form-item label="库存" prop="ticketStock">
                <el-input-number v-model="form.ticketStock" maxlength="20" :disabled="false" :min="1" :max="1000"></el-input-number>
            </el-form-item>

            <el-form-item label="状态" prop="status">
                <el-switch class="switch-style switch-form" v-model="form.status" v-bind="ConfigParmas.switchValue"></el-switch>
            </el-form-item>
        </el-form>
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