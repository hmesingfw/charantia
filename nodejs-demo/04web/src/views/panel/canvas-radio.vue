<template>
    <div :class="className" :style="{height:height,width:width,'margin-top':marginTop}" />
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
            default: '400px'
        },
        marginTop: {
            type: String,
            default: '0'
        },

        ovalue: {
            type: [String, Number],
            default: 0
        },
        tvalue: {
            type: [String, Number],
            default: 100
        },
        // legend: {
        //     type: Array,
        //     default: []
        // }
        asstitle: {
            type: String,
            default: ''
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
        toPercent(num, total) {
            console.log(num, total);
            return (Math.round(num / total * 10000) / 100.00 + "%");// 小数点后两位百分比
        },
        initChart() {

            this.chart = echarts.init(this.$el, 'macarons')
            this.chart.setOption({
                title: {
                    text: this.toPercent(this.ovalue, this.tvalue) + this.asstitle,
                    x: 'center',
                    y: 'center',
                    textStyle: {
                        fontWeight: 'normal',
                        color: '#0580f2',
                        fontSize: '20'
                    }
                },
                color: ['rgba(176, 212, 251, 1)'],

                series: [{
                    type: 'pie',
                    clockWise: true,
                    radius: ['50%', '66%'],
                    itemStyle: {
                        normal: {
                            label: {
                                show: false
                            },
                            labelLine: {
                                show: false
                            }
                        }
                    },
                    hoverAnimation: false,
                    data: [{
                        value: this.ovalue,
                        name: '已使用',
                        itemStyle: {
                            normal: {
                                color: { // 完成的圆环的颜色
                                    colorStops: [{
                                        offset: 0,
                                        color: '#00cefc' // 0% 处的颜色
                                    }, {
                                        offset: 1,
                                        color: '#367bec' // 100% 处的颜色
                                    }]
                                },
                                label: {
                                    show: false
                                },
                                labelLine: {
                                    show: false
                                }
                            }
                        }
                    }, {
                        name: '未使用',
                        value: this.tvalue
                    }]
                }]
            })
        }
    }
}
</script>