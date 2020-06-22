<template>
    <div :class="className" :style="{height:height,width:width}" />
</template>

<script>
import echarts from 'echarts'
require('echarts/theme/macarons') // echarts theme
import resize from './mixins/resize'

export default {
    mixins: [resize],
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
            default: '350px'
        },
        autoResize: {
            type: Boolean,
            default: true
        },
        chartData: {
            type: Object,
            required: true
        }
    },
    data() {
        return {
            chart: null
        }
    },
    watch: {
        chartData: {
            deep: true,
            handler(val) {
                this.setOptions(val)
            }
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
            this.setOptions(this.chartData)
        },
        setOptions({ doctor, patient, title } = {}) {
            this.chart.setOption({
                title: { text: '租户注册' },
                xAxis: {
                    data: title,
                    boundaryGap: false,
                    axisTick: {
                        show: false
                    }
                },
                grid: {
                    left: 10,
                    right: 10,
                    bottom: 20,
                    top: 30,
                    containLabel: true
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross'
                    },
                    padding: [5, 10]
                },
                yAxis: {
                    axisTick: {
                        show: false
                    },
                    minInterval: 1,
                },
                legend: {
                    show: false,
                    data: ['会员人数', '专家人数',],
                    selected: {
                        '专家人数': true, '会员人数': true
                    }
                },
                series: [{
                    name: '会员人数',
                    data: patient,
                    itemStyle: {
                        normal: {
                            color: '#38d4fa',
                            borderWidth: 10,

                        },
                    },
                    color: '#38d4fa',
                    smooth: true,
                    type: 'line',
                    animationDuration: 2800,
                    animationEasing: 'cubicInOut',
                    lineStyle: {
                        normal: {
                            width: 5,
                            color: {
                                type: 'linear',

                                colorStops: [{
                                    offset: 0,
                                    color: '#47e9eb' // 0% 处的颜色
                                }, {
                                    offset: 0.4,
                                    color: '#38d4fa' // 100% 处的颜色
                                }, {
                                    offset: 1,
                                    color: '#3888fa' // 100% 处的颜色
                                }],
                                globalCoord: false // 缺省为 false
                            },
                            shadowColor: 'rgba(245,128,128, 0.5)',
                            shadowBlur: 10,
                            shadowOffsetY: 7
                        }
                    },
                }, {
                    name: '专家人数',

                    data: doctor,
                    itemStyle: {
                        normal: {
                            color: '#F58080',
                            borderWidth: 10,

                        },
                    },
                    color: '#F58080',
                    smooth: true,
                    type: 'line',
                    animationDuration: 2800,
                    animationEasing: 'cubicInOut',
                    lineStyle: {
                        normal: {
                            width: 5,
                            color: {
                                type: 'linear',

                                colorStops: [{
                                    offset: 0,
                                    color: '#FFCAD4' // 0% 处的颜色
                                }, {
                                    offset: 0.4,
                                    color: '#F58080' // 100% 处的颜色
                                }, {
                                    offset: 1,
                                    color: '#F58080' // 100% 处的颜色
                                }],
                                globalCoord: false // 缺省为 false
                            },
                            shadowColor: 'rgba(245,128,128, 0.5)',
                            shadowBlur: 10,
                            shadowOffsetY: 7
                        }
                    },
                },]
            })
        }
    }
}
</script>
