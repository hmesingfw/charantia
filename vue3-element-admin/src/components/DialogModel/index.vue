<template>
    <div class="model-model">
        <el-drawer :title="title" :size="width + 'px'" :modal="false" :visible="value" direction="rtl" :before-close="close" :modal-append-to-body="modalAppendToBody" :wrapper-closable="wrapper">
            <div class="dialog">
                <!-- 文本框内容 -->
                <div class="main-body">
                    <el-scrollbar wrap-class="scrollbar-wrapper">
                        <div :style="{height:divHeight}" style="display: flow-root;overflow-x: hidden;padding-top: 20px;">
                            <slot />
                        </div>
                    </el-scrollbar>
                </div>
                <!-- 按钮 -->
                <div class="handle">
                    <el-button v-if="isSubmit" v-loading="loadingButton" type="primary" :disabled="loadingButton" @click="submit">确定</el-button>
                    <el-button v-if="showColse" @click="close">{{ isSubmit ? '取消' : '关闭' }}</el-button>
                </div>
            </div>
        </el-drawer>
    </div>
</template>
<script>
import { GetHeight } from '@/utils/sys';

export default {
    props: {
        value: { type: [Boolean], default: false }, // 状态值，是否打开关闭窗体
        title: { type: String, default: '提示' }, // 窗体标题
        width: { type: [Number, String], default: document.documentElement.clientWidth - 230 }, // 窗体宽度

        loadingButton: { type: [Boolean], default: false },

        isSubmit: { type: Boolean, default: true }, // 是否显示确认按钮
        isColse: { type: Boolean, default: true }, // 关闭回调
        showColse: { type: Boolean, default: true }, // 显示关闭

        modalAppendToBody: { type: Boolean, default: false }, // 遮罩层是否插入至 body 元素上，若为 false，则遮罩层会插入至 Drawer 的父元素上

        wrapper: { type: Boolean, default: true }, // 点击遮罩层是否可以关闭 Drawer
    },
    data() {
        return {
            divHeight: GetHeight(106), // 列表高度
        };
    },
    methods: {
        // 关闭窗口
        close() {
            this.$emit('input', false);
            this.$emit('colse');
        },
        // 提交数据
        submit() {
            this.$emit('submit');
        },
    },
    watch: {
        value(val) {
            if (val === true) {
                this.$emit('changeLoadingButton'); //  关闭按钮loading
            }
        }
    }
};
</script>
<style lang="scss">
.model-model {
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
    .el-drawer__header {
        margin-bottom: 0;
        padding-bottom: 10px;
        border-bottom: 1px solid #ebeef5;
        span {
            outline: none;
        }
    }
}
</style>
