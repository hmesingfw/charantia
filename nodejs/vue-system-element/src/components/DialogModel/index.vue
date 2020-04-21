<template>
    <div class="model-alert">
        <el-drawer :title="title" :size="width + 'px'" :modal="false" :visible="value" direction="rtl" :before-close="close">
            <div class="dialog">
                <!-- 文本框内容 -->
                <div class="main-body">
                    <el-scrollbar wrap-class="scrollbar-wrapper">
                        <div v-bind:style="{height:divHeight}" style="display: flow-root;overflow-x: hidden;">
                            <slot></slot>
                        </div>
                    </el-scrollbar>
                </div>
                <!-- 按钮 -->
                <div v-if="clickButton" class="handle">
                    <el-button type="primary" v-if="isSubmit" @click="submit" v-loading="loadingButton" :disabled="loadingButton">{{buttonTitle[0]}}</el-button>
                    <el-button type="primary" v-if="threebutton" @click="handleClose">{{buttonTitle[2]}}</el-button>

                    <el-button @click="close">{{buttonTitle[1]}}</el-button>
                </div>
            </div>
        </el-drawer>
    </div>
</template>
<script>
import { GetHeight } from '@/utils/sys';

export default {
    props: {
        clickButton: { type: Boolean, default: true }, // 是否显示按钮
        value: { type: [Boolean], default: false }, // 状态值，是否打开关闭窗体
        title: { type: String, default: '提示' }, // 窗体标题
        width: { type: [Number, String], default: document.documentElement.clientWidth - 230 }, // 窗体宽度
        type: { type: [String] }, // 主要用于判断是post请求还是put请求
        loadingButton: { type: [Boolean], default: false },

        buttonTitle: { type: Array, default: function () { return ['确定', '取消', '另存为']; } },        //  按钮名称
        threebutton: { type: Boolean, default: false },             // 是否返回取消事件
        isSubmit: { type: Boolean, default: true },         // 是否显示确认按钮
    },
    data() {
        return {
            divHeight: GetHeight(130), // 列表高度
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
            this.$emit('submit', this.type);
        },
        /* 第三个按钮 */
        handleClose() {
            this.$emit('threeHandle', this.type);
        },
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
.model-alert {
    .main-body {
        padding: 20px 20px;
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
        padding-bottom: 10px;
        border-bottom: 1px solid #ebeef5;
        span {
            outline: none;
        }
    }
}
</style>
