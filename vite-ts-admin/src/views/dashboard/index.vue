<template>
    <div class="dashboard-editor-container">
        <el-button type="primary">111</el-button>
    </div>
</template>

<script>
import { defineComponent } from 'vue'
export default defineComponent({
    name: 'DashboardAdmin',
    data() {
        return {
        }
    },
    methods: {

    }
})
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
    padding: 32px;
    background-color: rgb(240, 242, 245);
    position: relative;

    .chart-wrapper {
        background: #fff;
        padding: 16px 16px 0;
        margin-bottom: 32px;
    }
}

@media (max-width: 1024px) {
    .chart-wrapper {
        padding: 8px;
    }
}
</style>
