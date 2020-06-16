<template>
    <dialog-alert v-model="value" title="图片上传" width="500px" @submit="handleUpdate" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="50px" :rules="rules" :model="form" ref="ruleForm">
            <el-form-item label="图片" prop="code">
                <c-file v-model="form.id" :fileUrl="$api.sys.file"></c-file>
            </el-form-item>
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
                    console.log(this.form);

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