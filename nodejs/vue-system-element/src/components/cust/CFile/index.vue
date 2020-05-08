<template>
    <dialog-alert v-model="value" title="文件管理" width="500px" @submit="handleUpdate" :loading-button="loadingButton" @colse="colse" :isColse="false" @changeLoadingButton="loadingButton = false">
        <div v-if="type == 'image'" class="c-upload-image">
            <el-upload class="avatar-uploader" :action="fileUrl" :headers="header()" :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload">
                <img v-if="imageUrl" :src="imageUrl" class="avatar" />
                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
        </div>

        <el-upload v-if="type == 'images'" class="upload-demo" :action="fileUrl" :on-preview="handlePreview" :file-list="fileList" :headers="header()" list-type="picture">
            <el-button size="small" type="primary">点击上传</el-button>
        </el-upload>
    </dialog-alert>
</template>
<script>
import Cookies from 'js-cookie';
import { mapGetters } from 'vuex';

export default {
    props: {
        value: { type: [Boolean, String] },
        callback: Function,
        url: { type: String },
        type: { type: String, default: 'image' },       // 文件上传类型，  image 单图片  images 多图片 file 文件
    },
    computed: {
        // 使用对象展开运算符将 getter 混入 computed 对象中
        ...mapGetters([
            'token'
        ])
    },
    watch: {
        value(val) {
            if (val) {
                this.init();
            }
        }
    },
    data() {
        return {
            fileUrl: this.$api.sys.file,
            loadingButton: false,
            fileList: [],
            imageUrl: ''
        }
    },
    methods: {
        init() {
            this.fileList = [];
            this.imageUrl = '';
        },
        /* 保存 */
        async handleUpdate() {
            this.callback('192301850127');
            this.$emit('input', false);
        },
        handlePreview(file) {
            console.log(file);
        },
        handleAvatarSuccess(res, file) {
            console.log(res, file);
            this.imageUrl = URL.createObjectURL(file.raw);
        },
        beforeAvatarUpload(file) {
            const isJPG = file.type === 'image/jpeg';
            const isLt2M = file.size / 1024 / 1024 < 2;

            if (!isJPG) {
                this.$message.error('上传头像图片只能是 JPG 格式!');
            }
            if (!isLt2M) {
                this.$message.error('上传头像图片大小不能超过 2MB!');
            }
            return isJPG && isLt2M;
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
<style lang="scss">
.c-upload-image {
    text-align: center;

    .avatar-uploader {
        .el-upload {
            border: 1px dashed #d9d9d9;
            border-radius: 6px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        .el-upload:hover {
            border-color: #409eff;
        }
    }
    .avatar-uploader-icon {
        font-size: 28px;
        color: #8c939d;
        width: 178px;
        height: 178px;
        line-height: 178px;
        text-align: center;
    }
    .avatar {
        width: 178px;
        height: 178px;
        display: block;
    }
}
</style>