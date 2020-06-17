 <template>
    <dialog-alert v-model="value" title="角色信息" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-row>
            <el-form label-width="80px" :rules="rules" :model="form" ref="ruleForm">
                <el-form-item label="标识" prop="code">
                    <el-input v-model="form.code" maxlength="20" :disabled="false" placeholder="请输入标识"></el-input>
                </el-form-item>

                <el-form-item label="角色名称" prop="name">
                    <el-input v-model="form.name" maxlength="20" :disabled="false" placeholder="请输入角色名称"></el-input>
                </el-form-item>

                <el-form-item label="描述" prop="description">
                    <el-input type="textarea" :row="5" v-model="form.description" maxlength="200" show-word-limit :disabled="false" placeholder="请输入内容"></el-input>
                </el-form-item>

                <el-form-item label="状态" prop="status">
                    <el-switch class="switch-style" v-model="form.status" v-bind="ConfigParmas.switchValue"></el-switch>
                </el-form-item>
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