<template>
    <div class="c-upload-image">
        <el-upload class="avatar-uploader" :action="fileUrl" :headers="header()" :on-change="filechange" :auto-upload="false" :show-file-list="false">
            <el-image v-if="value" :src="this.$api.sys.getFile + '?id=' + value" class="avatar" fit="cover"></el-image>
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>

        <el-dialog title="图片裁剪" :visible.sync="dialogValue" width="900px" center :close-on-click-modal="false" :show-close="false" :append-to-body="true">
            <div style="width:850px; height: 422px; border: dashed #cacaca 1px; text-align: center;">
                <div class="cropper" style="max-width: 100%;height:100%;">
                    <vueCropper
                        ref="cropper"
                        :img="imageUrl"
                        :outputSize="option.size"
                        :outputType="option.outputType"
                        :info="true"
                        :full="option.full"
                        :canMove="option.canMove"
                        :canMoveBox="option.canMoveBox"
                        :original="option.original"
                        :autoCrop="option.autoCrop"
                        :autoCropWidth="autoCropWidth"
                        :autoCropHeight="autoCropHeight"
                        :fixedBox="option.fixedBox"
                        :fixed="option.fixed"
                        :fixedNumber="fixedNumber"
                    ></vueCropper>
                </div>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="close" v-loading="loadingButton">取 消</el-button>
                <el-button type="primary" v-loading="loadingButton" @click="uploadImg()">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>
<script>
import Cookies from 'js-cookie';
import { mapGetters } from 'vuex';
import { VueCropper } from 'vue-cropper';

export default {
    props: {
        fileUrl: { type: String },          // 图片上传地址   this.$api.sys.file,

        value: { type: [String] },
        fixedNumber: { type: Array, default: () => [16, 9] },       // 截图框比例  (默认:[1:1])

        autoCropWidth: { type: String, default: '1960' }, // 默认生成截图框宽度  (无数值默认:80%)
        autoCropHeight: { type: String, default: '1080' }, // 默认生成截图框高度  (无数值默认:80%)
        fixedBox: { type: Boolean, default: false }, // 固定截图框大小 不允许改变  (默认:false)
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
    watch: {
        value(val) {
            console.log(val);
        }
    },
    data() {
        return {
            imageUrl: '',

            cropperFile: null,          // 上传的图片 
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

            let url = URL.createObjectURL(file.raw);
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

                this.$http.post(this.fileUrl, formdata, {
                    'Content-Type': 'multipart/form-data'
                }).then(res => {

                    this.$emit('input', res.data.id);
                    this.loadingButton = false;
                    this.dialogValue = false;
                }).catch(() => {
                    this.dialogValue = false;
                    this.loadingButton = false;
                });
            });

        },




        close() {
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