<template>
    <div :class="className" :style="{height:height,width:width}" />
</template>
<script>
import echarts from 'echarts';
require('echarts/theme/macarons'); // echarts theme

export default {
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
            default: '300px'
        },
        titleList: {
            type: Array,
        },
        dataList: {
            type: Array,
        }
    },
    mounted() {
        this.$nextTick(() => {
            this.initChart();
        });
    },
    data() {
        return {
            chart: null
        }
    },
    beforeDestroy() {
        if (!this.chart) {
            return;
        }
        this.chart.dispose();
        this.chart = null;
    },
    methods: {
        initChart() {
            // var xAxisData = ['北京地区', '西南地区', '华南地区', '华北地区', '西北地区'];
            // var seriesData = [120, 200, 150, 80, 70];
            var xAxisData = this.titleList;
            var seriesData = this.dataList;

            this.chart = echarts.init(this.$el, 'macarons');
            this.chart.setOption({
                color: '#1785ef',
                backgroundColor: '#ffffff',
                xAxis: {
                    type: 'category',
                    data: xAxisData,
                    nameTextStyle: {
                        color: '#8f8f9b',
                        fontSize: 14
                    },
                    splitLine: {
                        show: false
                    },
                    axisTick: {
                        show: false
                    },
                    axisLine: {
                        lineStyle: {
                            type: 'solid',
                            color: '#8f8f9b',
                        }
                    },
                    axisLabel: {
                        show: true,
                        rotate: 0,
                        interval: 0,
                        fontSize: 18,
                        textStyle: {
                            color: '#8f8f9b',
                        }
                    }
                },
                yAxis: {
                    name: '票数',
                    minInterval: 1,
                    nameTextStyle: {
                        color: '#8f8f9b',
                        fontSize: 14
                    },
                    type: 'value',
                    splitLine: {
                        show: false
                    },
                    axisTick: {
                        show: false
                    },
                    axisLine: {
                        lineStyle: {
                            type: 'solid',
                            color: '#8f8f9b'
                        }
                    },
                    axisLabel: {
                        show: true,
                        rotate: 0,
                        fontSize: 14,
                        textStyle: {
                            color: '#8f8f9b',
                        }
                    }
                },
                series: [{
                    data: seriesData,
                    type: 'bar',
                    barWidth: '60px',
                    itemStyle: {
                        normal: {
                            barBorderRadius: [6, 6, 0, 0],
                        }
                    },
                    label: {
                        normal: {
                            show: true,
                            textStyle: {
                                color: '#000',
                                fontSize: 18
                            },
                            position: 'top'
                        }
                    }
                }]
            });
        }
    }
};
</script>