<template>
    <el-drawer ref="hCustDrawer" :model-value="value" :title="title" v-bind="setupAttrs" :before-close="handleClose">
        <div class="h-drawer">
            <div class="h-drawer-scrollbar">
                <el-scrollbar style="height:100%">
                    <div class="h-drawer__main" :style="{height:mainStyleHeight}">
                        <slot />
                    </div>
                </el-scrollbar>
            </div>
            <!-- 底部操作按钮，传入slot:footer 替换 -->
            <el-row type="flex" justify="end" class="h-drawer__footer">
                <slot name="footer">
                    <el-button @click="handleClose">取 消</el-button>
                    <el-button type="primary" :loading="loading">{{ loading ? '提交中 ...' : '确 定' }}</el-button>
                </slot>
            </el-row>
        </div>
    </el-drawer>
</template>

<script>
import { ref, onMounted } from 'vue'
export default {

    props: {
        value: { type: Boolean, default: false },
        title: { type: String, default: '' },
        attrs: { type: Object, default: () => { } },
    },

    methods: {

    },
    setup(props, { attrs, slots, emit }) {
        const loading = ref(false);
        const mainStyleHeight = ref(0);
        const setupAttrs = {
            size: '600px',
            ...props.attrs,
        }
        function handleClose() {
            emit('update:modelValue', false); // modelValue  默认绑定v-model
        }

        onMounted(() => {
            const clientHeight = document.documentElement.clientHeight; // 屏幕高度
            const titleHeight = !props.attrs ? 65 : 0; // 标题高度
            const footerHeight = 61; // 底部高度
            const padding = 20; // padding高度
            mainStyleHeight.value = (clientHeight - titleHeight - footerHeight - padding) + 'px';
        })

        return { handleClose, setupAttrs, loading, mainStyleHeight }
    }
}
</script>
