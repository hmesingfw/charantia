<template>
    <dialog-alert v-model="value" title="图片上传" width="500px" :loading-button="loadingButton" :is-colse="false" @submit="handleUpdate" @colse="colse" @changeLoadingButton="loadingButton = false">
        <el-form ref="ruleForm" label-position="right" label-width="50px" :rules="rules" :model="form">
            <el-form-item label="图片" prop="code" />
        </el-form>
    </dialog-alert>
</template>
<script>
export default {
    props: {
        value: { type: [Boolean, String] },
        form: Object,
        requestType: String,
        callback: Function,
        url: String,
    },
    data() {
        return {
            rules: {},
            loadingButton: false,

        }
    },
    methods: {
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;

                    // let issucc = await this.ReqData(this.url, this.form, this.requestType);
                    // if (issucc) {

                    this.callback();
                    //     this.$emit('input', false);
                    // }
                    this.loadingButton = false;
                }
            });
        },
        colse() {
            this.$emit('input', false);
        },
    }
}
</script>
