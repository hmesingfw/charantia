<template>
    <div class="c-upload-image">
        <el-upload class="avatar-uploader" :action="fileUrl" :headers="header()" :on-change="filechange" :auto-upload="false" :show-file-list="false" accept="image/*">
            <el-image v-if="value" :src="this.$api.file.download + '/' + value" class="avatar" fit="cover" accept="image/*" />
            <i v-else class="el-icon-plus avatar-uploader-icon" />
            <div slot="tip" class="el-upload__tip" style="margin:0">{{ tip }}</div>
        </el-upload>

        <el-dialog title="裁剪" :visible.sync="dialogValue" width="900px" center :close-on-click-modal="false" :show-close="false" :append-to-body="true">
            <div style="width:850px; height: 422px; border: dashed #cacaca 1px; text-align: center;">
                <div class="cropper" style="max-width: 100%;height:100%;">
                    <vueCropper
                        ref="cropper"
                        :img="imageUrl"
                        :output-size="option.size"
                        :output-type="option.outputType"
                        :info="true"
                        :full="option.full"
                        :can-move="option.canMove"
                        :can-move-box="option.canMoveBox"
                        :original="option.original"
                        :auto-crop="option.autoCrop"
                        :auto-crop-width="autoCropWidth"
                        :auto-crop-height="autoCropHeight"
                        :fixed-box="option.fixedBox"
                        :fixed="option.fixed"
                        :fixed-number="fixedNumber"
                    />
                </div>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button v-loading="loadingButton" @click="closeImg">取 消</el-button>
                <el-button v-loading="loadingButton" type="primary" @click="uploadImg()">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>
<script>
// import Cookies from 'js-cookie';
import { mapGetters } from 'vuex';
import { VueCropper } from 'vue-cropper';

export default {
    props: {
        fileUrl: { type: [String] }, // 图片上传地址   this.$api.sys.file,

        value: { type: [String, Number] },
        fixedNumber: { type: Array, default: () => [16, 9] }, // 截图框比例  (默认:[1:1])

        autoCropWidth: { type: String, default: '1960' }, // 默认生成截图框宽度  (无数值默认:80%)
        autoCropHeight: { type: String, default: '1080' }, // 默认生成截图框高度  (无数值默认:80%)
        fixedBox: { type: Boolean, default: false }, // 固定截图框大小 不允许改变  (默认:false)
        tip: { type: String, default: '仅支持jpg/png格式文件，且文件大小不超过2M' },

        group: { type: String, default: '' },
        tenantId: { type: [String, Number], default: '' },

    },
    components: {
        VueCropper
    },
    computed: {
        // 使用对象展开运算符将 getter 混入 computed 对象中
        ...mapGetters([
            'token'
        ])
    },

    data() {
        return {
            imageUrl: '',

            cropperFile: null, // 上传的图片
            /* 裁剪面板 */
            dialogValue: false,
            loadingButton: false,
            option: {
                outputSize: 1, // 裁剪生成图片的质量  (默认:1)
                full: false, // 是否输出原图比例的截图 选true生成的图片会非常大  (默认:false)
                outputType: 'png', // 裁剪生成图片的格式  (默认:jpg)
                canMove: false, // 上传图片是否可以移动  (默认:true)
                original: false, // 上传图片按照原始比例渲染  (默认:false)
                canMoveBox: true, // 截图框能否拖动  (默认:true)
                autoCrop: true, // 是否默认生成截图框  (默认:false)
                fixedBox: false, // 固定截图框大小 不允许改变  (默认:false)
                fixed: true, // 是否开启截图框宽高固定比例  (默认:true)
                enlarge: 1,
            },
        }
    },
    methods: {

        /* 上传文件改变钩子,   单文件上传时用于裁剪 */
        filechange(file) {
            this.cropperFile = file.raw;

            const url = URL.createObjectURL(file.raw);
            this.imageUrl = url;
            this.dialogValue = true;
        },

        uploadImg() {
            // 将剪裁好的图片回传给父组件
            this.loadingButton = true;
            this.$refs.cropper.getCropBlob(data => {
                var file = new File([data], 'file.png');
                var formdata = new FormData();
                formdata.append('file', file);
                this.group && formdata.append('group', this.group);
                this.tenantId && formdata.append('tenantId', this.tenantId);

                this.$http.post(this.fileUrl, formdata, {
                    'Content-Type': 'multipart/form-data'
                }).then(res => {
                    this.$emit('input', res.data.data);
                    this.loadingButton = false;
                    this.dialogValue = false;
                }).catch(() => {
                    this.dialogValue = false;
                    this.loadingButton = false;
                });
            });
        },

        closeImg() {
            this.dialogValue = false;
            this.loadingButton = false;
        },

        close() {
            this.$emit('input', false);
        },
        header() {
            return {
                authorization: 'Bearer ' + this.token,
            }
        }
    }
}
</script>
<style lang="scss">
.c-upload-image {
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
        line-height: 178px;
        text-align: center;
    }
    .avatar {
        width: 178px;
        display: block;
    }
}
</style>
