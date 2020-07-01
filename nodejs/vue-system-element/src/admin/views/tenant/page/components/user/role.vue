 <template>
    <dialog-model
        v-model="value"
        title="角色权限配置"
        width="360"
        @submit="handleUpdate"
        @colse="colse"
        :isColse="false"
        :loading-button="loadingButton"
        @changeLoadingButton="loadingButton = false"
        :modal-append-to-body="false"
    >
        <div class="role-radio-group">
            <el-radio-group v-model="radio">
                <el-radio v-for="item in tableData" :key="item.id" :label="item.id">{{ item.name}}</el-radio>
            </el-radio-group>
        </div>
    </dialog-model>
</template>
<script>
export default {
    props: {
        value: { type: [Boolean, String] },
        form: Object,
        info: Object,
    },
    data() {
        return {
            loadingButton: false,
            radio: '',
            tableData: [],

        }
    },
    watch: {
        form: {
            handler(val) {
                this.radio = val.roleId
            },
            deep: true
        }
    },
    created() {
        this.query();
        this.radio = this.form.roleId

    },
    methods: {
        query() {
            let param = {
                tenantId: this.info.tenantId,
                limit: 1000, page: 1,
            };
            this.$http.get(this.$api.sys.role, {
                params: param
            }).then(res => {
                this.tableData = res.data.data.list;
            })
        },
        /* 保存 */
        async handleUpdate() {
            let form = {
                uid: this.form.id,
                roleId: this.radio
            }
            if (this.radio) {
                let suc = await this.$http.put(this.$api.sys.roleUser, form);
                this.$message.success(suc.data.message);
            } else {
                await this.$http.delete(`${this.$api.sys.roleUser}/${this.form.id}`);

            }

            this.$emit('input', false);

        },
        colse() {
            this.$emit('input', false);
        }
    }
}
</script>
<style lang="scss">
.role-radio-group {
    padding: 0 20px;
    .el-radio-group {
        width: 100%;

        .el-radio {
            width: 100%;
            line-height: 30px;
        }
    }
}
</style>