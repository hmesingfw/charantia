<template>
    <div class="layout-settings">
        <div class="shade" v-show="!panel.status"></div>
        <div class="panel" :style="{width: panel.width }">
            <div class="settings" @click="OpenSetting">
                <i class="el-icon-setting action-icon" v-if="panel.status"></i>
                <i class="el-icon-close action-icon" v-if="!panel.status"></i>
            </div>
        </div>
    </div>
</template>

<script>
import { ref, reactive } from 'vue'
export default {
    setup() {
        const drawer = ref(false);
        // 设置面板属性
        const panel = reactive({ width: '0px', status: true });
        // 打开 关闭面板的操作
        function OpenSetting() {
            panel.width = panel.status ? '300px' : '0px';
            panel.status = !panel.status;
        }
        return { drawer, panel, OpenSetting }
    },
}
</script>

<style lang="scss">
.layout-settings {
    .shade {
        position: fixed;
        width: 100%;
        height: 100vh;
        top: 0;
        left: 0;
        background: #000;
        opacity: 0.45;
        z-index: 1;
    }
    .panel {
        z-index: 10;
        position: fixed;
        right: 0;
        height: 100vh;
        background: #fff;
        transition: width 0.8s ease;
        -webkit-transition: width 0.8s ease;

        .settings {
            height: 60px;
            width: 60px;
            border-radius: 6px 0 0 6px;
            position: absolute;
            left: -60px;
            top: 20vh;
            background-color: #13c2c2;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }
    }

    .action-icon {
        font-size: 40px;
    }
}
</style>