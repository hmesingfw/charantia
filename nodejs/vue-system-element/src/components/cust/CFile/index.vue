<template>
    <dialog-alert v-model="value" title="角色信息" width="500px" @submit="handleUpdate" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <el-form label-position="right" label-width="50px" :rules="rules" :model="form" ref="ruleForm">
            <el-upload class="upload-demo" :action="fileUrl" :on-preview="handlePreview" :on-remove="handleRemove" :file-list="fileList" :headers="header()" list-type="picture">
                <el-button size="small" type="primary">点击上传</el-button>
                <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
            </el-upload>
        </el-form>
    </dialog-alert>
</template>
<script>
import Cookies from 'js-cookie';
import { mapGetters } from 'vuex';

export default {
    props: {
        value: { type: [Boolean, String] },
        form: Object,
        callback: Function,
        url: String,
    },
    computed: {
        // 使用对象展开运算符将 getter 混入 computed 对象中
        ...mapGetters([
            'token'
        ])
    },
    data() {
        return {
            fileUrl: this.$api.sys.file,
            rules: {
                code: [{ required: true, message: '请输入内容', trigger: 'blur' },],
                name: [{ required: true, message: '请输入内容', trigger: 'blur' },],
            },
            loadingButton: false,
            fileList: []

        }
    },
    methods: {
        /* 保存 */
        async handleUpdate() {
            this.$refs.ruleForm.validate(async valid => {
                if (valid) {
                    this.loadingButton = true;
                    let issucc = await this.ReqData(this.url, this.form, 'post');
                    if (issucc) {

                        this.callback();
                        this.$emit('input', false);
                    }
                    this.loadingButton = false;
                }
            });
        },
        handleRemove(file, fileList) {
            console.log(file, fileList);
        },
        handlePreview(file) {
            console.log(file);
        },

        colse() {
            this.$emit('input', false);
        },
        header() {
            return {
                'x-csrf-token': Cookies.get('csrfToken'),
                authorization: this.token
            }
        }
    }
}
</script>