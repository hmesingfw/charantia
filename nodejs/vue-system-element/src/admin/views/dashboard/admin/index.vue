<template>
    <div class="dashboard-editor-container">
        <panel-group @handleSetLineChartData="handleSetLineChartData" :data="panelGroupValue" />

        <el-row style="background:#fff;padding:16px 16px 0;margin-bottom:32px;">
            <line-chart :chart-data="lineChartDataValue" />
        </el-row>

        <el-row :gutter="32">
            <el-col :xs="24" :sm="24" :lg="8">
                <div class="chart-wrapper">
                    <raddar-chart />
                </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
                <div class="chart-wrapper">
                    <pie-chart />
                </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
                <div class="chart-wrapper">
                    <bar-chart />
                </div>
            </el-col>
        </el-row>
    </div>
</template>

<script> 
require('echarts/theme/macarons') // echarts theme   引入echarts 样式，全局这要一个地方引入就行

import PanelGroup from './components/PanelGroup'
import LineChart from './components/LineChart'
import RaddarChart from './components/RaddarChart'
import PieChart from './components/PieChart'
import BarChart from './components/BarChart'

const lineChartData = {
    newVisitis: {
        expectedData: [100, 120, 161, 134, 105, 160, 165],
        actualData: [1200, 820, 910, 1540, 1620, 1400, 145]
    },
    messages: {
        expectedData: [200, 192, 120, 144, 160, 130, 140],
        actualData: [180, 160, 151, 106, 145, 150, 130]
    },
    purchases: {
        expectedData: [80, 100, 121, 104, 105, 90, 100],
        actualData: [120, 90, 100, 138, 142, 130, 130]
    },
    shoppings: {
        expectedData: [130, 140, 141, 142, 145, 150, 160],
        actualData: [120, 82, 91, 154, 162, 140, 130]
    }
}

export default {
    name: 'DashboardAdmin',
    components: {
        PanelGroup,
        LineChart,
        RaddarChart,
        PieChart,
        BarChart,
    },
    data() {
        return {
            lineChartData: lineChartData.newVisitis,
            conut: {},
            panelGroupValue: {},
            lineChartDataValue: {
                title: [],
                doctor: [],
                patient: [],
            },
        }
    },
    methods: {
        handleSetLineChartData(type) {
            this.lineChartData = lineChartData[type]
        },
        init() {
            this.$http.get(`${this.$api.sys.dashboard}/chart`).then(res => {
                let data = res.data.data;
                this.panelGroupValue = {
                    tenantTotal: data.tenantTotal,
                    userTotal: data.userTotal,
                }
                /* 线性图 */
                let title = data.registerChart.map(item => item.key + '月');
                let doctor = data.registerChart.map(item => item.value);
                let patient = data.registerChart.map(item => item.value);
                this.lineChartDataValue = {
                    title, doctor, patient
                }
            })
        },
    },
    created() {
        this.init();
    },
}
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
