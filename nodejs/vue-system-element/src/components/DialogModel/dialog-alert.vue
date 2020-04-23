<template>
    <div class="dialog-alert">
        <el-dialog :title="title" :visible.sync="value" :width="width" :show-close="false" :close-on-click-modal="false">
            <div class="main-body">
                <slot></slot>
                <!-- <el-scrollbar wrap-class="scrollbar-wrapper">
                    <div v-bind:style="{height:divHeight}" style="display: flow-root;">
                        <slot></slot>
                    </div>
                </el-scrollbar>-->
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="close">取 消</el-button>
                <el-button type="primary" @click="submit" v-if="isSubmit" v-loading="loadingButton" :disabled="loadingButton">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>
<script>
import { GetHeight } from '@/utils/sys';
export default {
    props: {
        value: { type: [Boolean], default: false }, // 状态值，是否打开关闭窗体
        title: { type: String, default: '提示' }, // 窗体标题
        width: { type: [Number, String], default: '60%' }, // 窗体宽度
        loadingButton: { type: [Boolean], default: false },
        height: { type: [Number, String], default: 400 }, // 窗体高度度

        isSubmit: { type: Boolean, default: true },         // 是否显示确认按钮
        isColse: { type: Boolean, default: true }
    },
    name: 'Detail',
    data() {
        return {
            divHeight: GetHeight(400), // 列表高度
        };
    },
    methods: {
        // 关闭窗口
        close() {
            if (this.isColse) {
                this.$emit('input', false);
            }
            this.$emit('colse');
        },
        // 提交数据
        submit() {
            this.$emit('submit');
        }
    },
    watch: {
        value(val) {
            if (val === true) {
                this.$emit('changeLoadingButton');
            }
        }
    }
};
</script>
<style lang="scss">
.dialog-alert {
    .el-dialog__header {
        border-bottom: 1px solid #efefef;
    }
}
.dialog {
    .main-body {
        padding: 10px 20px;
    }
    .handle {
        background: #fff;
        position: absolute;
        height: 50px;
        width: 100%;
        bottom: 0px;
        right: 0;
        display: flex;
        flex-direction: row-reverse;
        align-items: center;

        border-top: 1px solid #ebeef5;

        .el-button {
            margin-right: 20px;
        }
    }
}
</style>
