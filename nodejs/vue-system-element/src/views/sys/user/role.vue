 <template>
    <dialog-alert v-model="value" width="600px" title="角色列表" @submit="handleUpdate" @colse="colse" :isColse="false" :loading-button="loadingButton" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="100px" :rules="rules" :model="role" ref="ruleForm">
            <el-form-item label-width="0" prop="id">
                <el-radio-group v-model="role.roleId" @change="chang1">
                    <el-radio v-for="item in roleList" :key="item.id" :label="item.id">{{ item.name }}</el-radio>
                </el-radio-group>
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
                roleId: [{ required: true, message: '请选择', trigger: 'blur' },],
            },
            loadingButton: false,
            roleList: [],
            role: {
                id: ''
            },
        }
    },
    watch: {
        form: {
            deep: true,
            handler(val) {
                if (val.role) {
                    console.log(val.role.roleId);
                    // this.$set(this.role, 'id', val.role.roleId);
                    this.role = this.DeepCopy(val.role);
                }
            },
        }
    },
    created() {
        this.init();
    },
    methods: {
        init() {
            this.$http.get(`${this.$api.sys.role}?status=0&page=1&size=100`).then(res => {
                this.roleList = res.data.rows;
            })
        },
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let issucc = await this.ReqData(this.$api.sys.roleUser, this.role, 'post');
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
        },
        chang1(val) {
            console.log(val);
        }
    }
}
</script>