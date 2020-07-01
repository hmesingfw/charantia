<template>
    <div :class="className" :style="{height:height,width:width}" />
</template>

<script>
import echarts from 'echarts'

export default {
    props: {
        className: {
            type: String,
            default: 'chart'
        },
        width: {
            type: String,
            default: '100%'
        },
        height: {
            type: String,
            default: '300px'
        }
    },
    data() {
        return {
            chart: null
        }
    },
    mounted() {
        this.$nextTick(() => {
            this.initChart()
        })
    },
    beforeDestroy() {
        if (!this.chart) {
            return
        }
        this.chart.dispose()
        this.chart = null
    },
    methods: {
        initChart() {
            this.chart = echarts.init(this.$el, 'macarons')

            this.chart.setOption({
                tooltip: {
                    trigger: 'item',
                    formatter: '{a} <br/>{b} : {c} ({d}%)'
                },
                legend: {
                    left: 'center',
                    bottom: '10',
                    data: ['选项1', '选项2', '选项3', '选项4', '选项5']
                },
                series: [
                    {
                        name: 'WEEKLY WRITE ARTICLES',
                        type: 'pie',
                        roseType: 'radius',
                        radius: [15, 95],
                        center: ['50%', '38%'],
                        data: [
                            { value: 320, name: '选项1' },
                            { value: 240, name: '选项2' },
                            { value: 149, name: '选项3' },
                            { value: 100, name: '选项4' },
                            { value: 59, name: '选项5' }
                        ],
                        animationEasing: 'cubicInOut',
                        animationDuration: 2600
                    }
                ]
            })
        }
    }
}
</script>
