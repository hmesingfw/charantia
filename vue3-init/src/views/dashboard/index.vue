<template>
    <div class="dashboard-editor-container">
        <div>111</div>
    </div>
</template>

<script>
export default {
    name: 'DashboardAdmin',
    data() {
        return {
            lineChartData: lineChartData.newVisitis
        }
    },
    methods: {
        handleSetLineChartData(type) {
            this.lineChartData = lineChartData[type]
        }
    }
}
</script>

<style lang="less" scoped>
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
