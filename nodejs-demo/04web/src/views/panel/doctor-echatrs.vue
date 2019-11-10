<template>
    <div :class="className" :style="{height:height,width:width}" />
</template>
<script>
import echarts from 'echarts'
require('echarts/theme/macarons') // echarts theme
import resize from '@/views/dashboard/admin/components/mixins/resize'

const animationDuration = 6000
export default {
    mixins: [resize],
    components: {},
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
            default: '420px'
        },
        list: {
            type: Array,
            default: []
        },
        legend: {
            type: Array,
            default: []
        }
    },
    mounted() {
        this.$nextTick(() => {
            this.initChart()
        })
    },
    data() {
        return {
            chart: null
        }
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
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    x: 'center',
                    y: 'bottom',
                    data: this.legend,
                    textStyle: {
                        color: '#fff',
                    }
                },
                calculable: true,
                series: [{
                    name: '面积模式',
                    type: 'pie',
                    radius: [80, 120],
                    // roseType: 'area',
                    data: this.list,
                    insideLabel: {
                        show: true
                    },
                    labelLine: {
                        show: true,
                        length: 15
                    },
                }]
            })
        }
    }
}
</script>