<template>
    <div class="model-alert">
        <el-drawer :title="title" :size="width + 'px'" :modal="false" :visible="value" direction="rtl" :before-close="close">
            <div class="dialog">
                <!-- 文本框内容 -->
                <div class="main-body">
                    <el-scrollbar wrap-class="scrollbar-wrapper">
                        <div v-bind:style="{height:divHeight}" style="display: flow-root;overflow-x: hidden;padding-top: 20px;">
                            <slot></slot>
                        </div>
                    </el-scrollbar>
                </div>
                <!-- 按钮 -->
                <div class="handle">
                    <el-button type="primary" v-if="isSubmit" @click="submit" v-loading="loadingButton" :disabled="loadingButton">确定</el-button>
                    <el-button @click="close">取消</el-button>
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

        isSubmit: { type: Boolean, default: true },         // 是否显示确认按钮
        isColse: { type: Boolean, default: true },          // 关闭回调

    },
    data() {
        return {
            divHeight: GetHeight(130), // 列表高度
        };
    },
    methods: {
        // 关闭窗口  
        close() {
            this.isColse && this.$emit('input', false);
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
                this.$emit('changeLoadingButton');   //  关闭按钮loading
            }
        }
    }
};
</script>
<style lang="scss">
.model-alert {
    .main-body {
        padding: 0px 20px 40px;
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
