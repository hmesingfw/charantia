<template>
    <div class="layout-settings">
        <div class="panel">
            <div class="settings">
                <i class="el-icon-setting action"></i>
                <i class="el-icon-close action" v-show="false"></i>
            </div>
        </div>
    </div>
</template>

<script>
import { ref } from 'vue'
export default {
    setup() {
        const drawer = ref(false);

        return { drawer }
    },
}
</script>

<style lang="less">
.layout-settings {
    .panel {
        position: fixed;
        right: 0;
        height: 100vh;
        width: 400px;
        background: #fff;

        .settings {
            height: 60px;
            width: 60px;
            border-radius: 6px 0 0 6px;
            position: absolute;
            left: -60px;
            top: 20vh;
            background-color: #13c2c2;
        }
    }
    .action {
        font-size: 40px;
    }
}
</style>