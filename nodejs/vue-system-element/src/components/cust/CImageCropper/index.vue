<template>
    <el-dialog title="图片裁剪" :visible.sync="dialogValue" width="900px" center :close-on-click-modal="false" :show-close="false" :append-to-body="true">
        <div style="width:850px; height: 422px; border: dashed #cacaca 1px; text-align: center;">
            <div class="cropper" style="max-width: 100%;height:100%;">
                <vueCropper
                    ref="cropper"
                    :img="baseHttp + value"
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
                    @realTime="realTime"
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
</template>
<script>
import { VueCropper } from 'vue-cropper';
export default {
    props: {
        value: { type: [String] },
        dialogValue: { type: [Boolean] },
        baseHttp: { type: [String], default: '' },
        file: { type: [Object, File], default: null },
        fixedNumber: { type: Array, default: () => [16, 9] },       // 截图框比例  (默认:[1:1])
        fileUpload: { type: String },
        autoCropWidth: { type: String, default: '80%' }, // 默认生成截图框宽度  (默认:80%)
        autoCropHeight: { type: String, default: '80%' }, // 默认生成截图框高度  (默认:80%)
        fixedBox: { type: Boolean, default: false }, // 固定截图框大小 不允许改变  (默认:false)
    },
    components: {
        VueCropper
    },
    data() {
        return {
            // fileUpload: this.$api.sys.sysFileBanner,        // 上传地址
            loadingButton: false,
            option: {
                outputSize: 1, // 裁剪生成图片的质量  (默认:1)
                full: false, // 是否输出原图比例的截图 选true生成的图片会非常大  (默认:false)
                outputType: 'png', // 裁剪生成图片的格式  (默认:jpg)
                canMove: false, // 上传图片是否可以移动  (默认:true)
                original: false, // 上传图片按照原始比例渲染  (默认:false)
                canMoveBox: true, // 截图框能否拖动  (默认:true)
                autoCrop: true, // 是否默认生成截图框  (默认:false)
                // autoCropWidth: 480, // 默认生成截图框宽度  (默认:80%)
                // autoCropHeight: 320, // 默认生成截图框高度  (默认:80%)
                fixedBox: false, // 固定截图框大小 不允许改变  (默认:false)
                fixed: true, // 是否开启截图框宽高固定比例  (默认:true)
                fixedNumber: [16, 9], // 截图框比例  (默认:[1:1])
                enlarge: 1,
            },
        };
    },

    methods: {
        realTime() {
            // 实时预览
            // this.previews = data;
        },
        uploadImg() {
            // 将剪裁好的图片回传给父组件
            this.loadingButton = true;
            this.$refs.cropper.getCropBlob(data => {

                var file = new File([data], 'file.png');
                var formdata = new FormData();
                formdata.append('file', file);

                this.$http.post(this.fileUpload, formdata, {
                    'Content-Type': 'multipart/form-data'
                }).then(res => {

                    this.loadingButton = false;
                    this.$emit('input', res.data.url);
                    this.$emit('getid', res.data.id);
                    this.$emit('close');
                }).catch(() => {
                    this.loadingButton = false;
                    this.$emit('close');
                });
            });

        },
        close() {
            this.$emit('input', '');
            this.$emit('close');
        },

    }
}; 
</script>