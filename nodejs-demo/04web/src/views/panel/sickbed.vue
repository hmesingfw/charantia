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
            default: '180px'
        },

        data1: {
            type: [String, Number],
            default: 0,
        }, //  1-10
        data2: {
            type: String,
            default: '0%'
        }

    },
    mounted () {
        this.$nextTick(() => {
            this.initChart()
        })
    },
    data () {
        return {
            chart: null
        }
    },
    beforeDestroy () {
        if (!this.chart) {
            return
        }
        this.chart.dispose()
        this.chart = null
    },
    methods: {
        initChart () {

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
                    center: ["50%", "60%"], //仪表的位置 
                    type: "gauge", //统计图类型为仪表
                    radius: 80, //统计图的半径大小
                    min: 0, //最小刻度
                    max: 10, //最大刻度
                    splitNumber: 9, //刻度数量
                    startAngle: 225, //开始刻度的角度
                    endAngle: -45, //结束刻度的角度
                    axisLine: { //设置默认刻度盘上的刻度不显示，重新定义刻度盘
                        show: false,
                        lineStyle: {
                            width: 1,
                            color: [
                                [1, "rgba(255,255,255,0)"]
                            ]
                        }
                    }, //仪表盘轴线
                    axisLabel: { //仪表盘上的数据
                        show: false,
                        color: "#4d5bd1", //仪表盘上的轴线颜色
                        distance: 2, //图形与刻度的间距
                    }, //刻度标签。
                    axisTick: {
                        show: true,
                        splitNumber: 6, //刻度的段落数
                        lineStyle: {
                            color: '#00FCF7',
                            width: 2, //刻度的宽度
                            shadowColor: '#67FFFC',
                            shadowBlur: 2
                        },
                        length: 8 //刻度的长度
                    }, //刻度样式
                    pointer: { //表盘上的指针
                        show: true
                    },
                    itemStyle: {
                        color: '#18c8ff'
                    },
                    data: [{ name: '', value: 5 }],
                    splitLine: { //文字和刻度的偏移量
                        show: true,
                        length: 15, //便宜的长度
                        lineStyle: {
                            color: "#00FCF7",
                            width: 4,
                            shadowColor: '#67FFFC',
                            shadowBlur: 4
                        }
                    }, //分隔线样式
                },
                {
                    type: "gauge", //刻度轴表盘
                    radius: 186, //刻度盘的大小
                    center: ["50%", "60%"], //刻度盘的位置
                    splitNumber: 2, //刻度数量
                    startAngle: 15, //开始刻度的角度
                    endAngle: -45, //结束刻度的角度
                    z: 10,
                    pointer: { //表盘上的指针
                        show: false
                    },
                    axisLine: { //设置默认刻度盘上的刻度不显示，重新定义刻度盘
                        show: false,
                        lineStyle: {
                            width: 1,
                            color: [
                                [1, "rgba(255,255,255,0)"]
                            ]
                        }
                    }, //仪表盘轴线
                    //分隔线样式。
                    splitLine: { //表盘上的轴线
                        show: true,
                        length: 15, //便宜的长度
                        lineStyle: {
                            width: 4,
                            color: "#E55125",
                            shadowBlur: 4,
                            shadowColor: '#E55125'
                        }
                    },
                    axisLabel: { //表盘上的刻度数值文字
                        show: false
                    },
                    axisTick: { //表盘上的刻度线
                        show: true,
                        splitNumber: 6, //刻度的段落数
                        lineStyle: {
                            color: '#E55125',
                            width: 2, //刻度的宽度
                            shadowBlur: 2,
                            shadowColor: '#E55125'
                        },
                        length: 8 //刻度的长度
                    },
                    title: { //标题
                        show: true,
                        offsetCenter: [0, 26], // x, y，单位px
                        textStyle: {
                            color: "#fff",
                            fontSize: 14, //表盘上的标题文字大小
                            fontWeight: 400,
                            fontFamily: 'PingFangSC'
                        }
                    },
                    //仪表盘详情，用于显示数据。
                    detail: {
                        show: true,
                        offsetCenter: [0, 62],
                        color: '#ccc',
                        formatter: function (params) {
                            return '96%'
                        },
                        textStyle: {
                            fontSize: 24,
                            color: '#67FFFC',
                            fontFamily: 'PingFangSC',
                            fontWeight: 500
                        }
                    },
                    data: [ //当前数值的数据
                        {
                            name: "剩余",
                            value: 0
                        }
                    ]
                }]
            })
        }
    }
}
</script>