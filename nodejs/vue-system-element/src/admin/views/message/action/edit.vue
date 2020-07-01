 <template>
    <dialog-alert v-model="value" title="编辑" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="动作标识" prop="action">
                <el-input v-model="form.action" maxlength="16" :disabled="requestType == 'put'"></el-input>
            </el-form-item>

            <el-form-item label="动作名称" prop="cnAction">
                <el-input v-model="form.cnAction" maxlength="20" :disabled="false"></el-input>
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
                action: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                cnAction: [{ required: true, message: '请输入内容', trigger: 'blur' },],
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
                    let issucc = await this.ReqData(this.url, this.form, this.requestType, { idKey: 'action' });
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