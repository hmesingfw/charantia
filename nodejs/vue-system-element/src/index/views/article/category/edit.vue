<template>
    <dialog-alert v-model="value" title="资讯信息" width="500px" @submit="handleUpdate" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="50px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="标题" prop="title">
                <el-input v-model="form.title" maxlength="32"></el-input>
            </el-form-item>

            <el-form-item label="图标" prop="iconId">
                <c-file v-model="form.iconId" fileUrl="api"></c-file>
            </el-form-item>

            <el-form-item label="排序" prop="sort">
                <el-input-number v-model="form.sort" :min="1" :max="1000"></el-input-number>
            </el-form-item>
            <el-form-item label="状态" prop="status">
                <el-switch class="switch-style" v-model="form.status" v-bind="ConfigParmas.switchValue"></el-switch>
            </el-form-item>
            <el-form-item label="审核" prop="needAudit">
                <el-switch class="switch-style" v-model="form.needAudit" v-bind="ConfigParmas.switchValue2"></el-switch>
            </el-form-item>
            <el-form-item label="显示" prop="isShow">
                <el-switch class="switch-style" v-model="form.isShow" v-bind="ConfigParmas.switchValue"></el-switch>
            </el-form-item>
        </el-form>
    </dialog-alert>
</template>
<script>
import { mapState } from 'vuex';
export default {
    components: {
    },
    computed: {
        ...mapState({
            statusList: state => state.enumList.data.statusList,
        })
    },
    props: {
        value: { type: [Boolean, String] },
        form: Object,
        requestType: String,
        callback: Function,
        url: String,
    },
    data() {
        return {
            rules: {
                title: [{ required: true, message: '请输入标题', trigger: 'blur' },],
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