<template>
    <div class="h-i">
        <panel-title />

        <div>
            <el-row>
                <el-col :span="6" class="i-padding-7">
                    <div class="i-title-background">
                        <span class="i-font-color">病床动态</span>
                    </div>
                    <div class="i-between-body">
                        <div class="i-charts">
                            <canvas-circle :percent="percentVal" id="lok1" v-if="flashCircle"></canvas-circle>
                        </div>
                        <div class="i-charts-title">
                            <div class="i-charts-title-c">
                                <span class="left">空余床位</span>
                                <span class="right">
                                    <span>{{ sickbedcountVal.useTotal }}</span>
                                    <span>位</span>
                                </span>
                            </div>
                        </div>
                        <div class="i-charts-title">
                            <div class="i-charts-title-c">
                                <span class="left">总计床位</span>
                                <span class="right">
                                    <span>{{ sickbedcountVal.sickbedTotal }}</span>
                                    <span>位</span>
                                </span>
                            </div>
                        </div>
                    </div>
                </el-col>

                <el-col :span="8" class="i-padding-2">
                    <div class="i-title-background">
                        <span class="i-font-color">医师动态</span>
                    </div>
                    <div class="i-between-body">
                        <doctor-echarts :list="doctorList" :legend="legendValue" v-if="flashEcharts" />
                    </div>
                </el-col>
                <el-col :span="10" class="i-padding-2 i-padding-right-7">
                    <div class="i-title-background">
                        <span class="i-font-color">重点护理项目</span>
                    </div>
                    <div class="i-between-body">
                        <doctor-echarts-c :list="doctorListKey" :legend="legendValueKey" v-if="flashEcharts" />
                    </div>
                </el-col>
            </el-row>

            <el-row class="foot">
                <el-col :span="8" class="i-padding-7">
                    <div class="i-title-background">
                        <span class="i-font-color">当日出入院</span>
                    </div>
                    <el-row class="i-foot-body-220">
                        <el-col :span="12">
                            <canvas-circle :percent="1" id="lok2"></canvas-circle>
                            <div class="title">出院</div>
                        </el-col>
                        <el-col :span="12">
                            <canvas-circle :percent="2" id="lok3"></canvas-circle>
                            <div class="title">入院</div>
                        </el-col>
                    </el-row>
                    <div class="i-foot-body-coumt">
                        <div class="i-inout-max">
                            <span style="color:#fff">入院总人数</span>
                            <span style="color:#F7A22F">{{ inoutVal.sickTotal }}</span>
                        </div>
                    </div>
                </el-col>

                <el-col :span="16" class="i-padding-2 i-padding-right-7">
                    <div class="i-title-background">
                        <span class="i-font-color">护理动态</span>
                    </div>
                    <div class="i-foot-body">
                        <el-carousel :interval="10000" arrow="always" style="height:100%;">
                            <el-carousel-item v-for="(item, index) in patientList" :key="index">
                                <el-row class="i-table">
                                    <el-col :span="8" v-for="obj in item" :key="obj.id" class="i-table-b">
                                        <div class="i-table-c">
                                            <span>{{ obj.name }}</span>
                                            <span>{{ obj.sickTotal }}</span>
                                        </div>
                                    </el-col>
                                </el-row>
                            </el-carousel-item>
                        </el-carousel>
                    </div>
                </el-col>
            </el-row>
        </div>
    </div>
</template>

<script>
import echarts from 'echarts'
require('echarts/theme/macarons') // echarts theme
import panelTitle from './panel-title'
import doctorEcharts from './doctor-echatrs'
import doctorEchartsC from './doctor-echatrs-c'

import canvasCircle from '@/components/CanvasCircle'
import { GetHeight, deleteRequestData, DeepCopy, ErrorLog } from "@/utils/sys";
import api from "@/config/api";
export default {
    components: {
        panelTitle, doctorEcharts, doctorEchartsC, canvasCircle
    },
    data() {
        return {
            doctorList: [],
            legendValue: [],


            doctorListKey: [],
            legendValueKey: [],

            sickbedcountVal: {},
            percentVal: 0,
            inoutVal: {},

            flashCircle: true,
            flashEcharts: true,

            patientList: [],
        }
    },
    created() {
        this.init();
    },
    methods: {
        init() {
            /* 医师动态 */
            this.$http.get(api.panel.dynamic).then(res => {
                this.doctorList = res.data.data.map(item => ({
                    name: item.name,
                    value: item.sickTotal,
                }));

                this.legendValue = res.data.data.map(item => item.name);
                this.flashEcharts = false;
                this.$nextTick(() => {
                    this.flashEcharts = true;
                })
            })
            /* 统计重点项目关联的病人数 、其他为非重点项目的总和 */
            this.$http.get(api.panel.majorProjectcount).then(res => {

                this.doctorListKey = res.data.data.map(item => ({
                    name: item.name,
                    value: item.sickTotal,
                }));

                this.legendValueKey = res.data.data.map(item => item.name);
                this.flashEcharts = false;
                this.$nextTick(() => {
                    this.flashEcharts = true;
                })
            })

            /* 统计当日病床信息 总床位、已用床位、剩余床位 */
            this.$http.get(api.panel.sickbedcount).then(res => {
                this.sickbedcountVal = res.data.data;
                let ic = (this.sickbedcountVal.useTotal / this.sickbedcountVal.sickbedTotal).toFixed(2);
                this.percentVal = ic * 100;

                this.flashCircle = false;
                this.$nextTick(() => {
                    this.flashCircle = true;
                })
            })
            /* 统计当日入院人数、出院人数 入院总人数             */
            this.$http.get(api.panel.inoutcount).then(res => {
                this.inoutVal = res.data.data;
                // this.flashCircle = false;
                // this.$nextTick(() => {
                //     this.flashCircle = true;
                // })
            })

            /* 统计所有护理项目中病人的数量             */
            this.$http.get(api.panel.patientcount).then(res => {
                let arr = res.data.data;
                let rearr = [];         // 返回拼接后的数组
                let temp = 16;               // 每页数量
                let len = Math.ceil(arr.length / temp);         // 共多少页
                /* 拼接 */
                for (let i = 0; i < len; i++) {
                    let iarr = arr.slice(temp * i, temp * (i + 1));
                    rearr.push(iarr);
                }

                this.patientList = rearr;
            })
        },


    }
}
</script>
<style lang="scss">
.h-i {
    background: url("../../assets/index.jpg");
    background-size: 100% 100%;
    height: 100%;
    position: fixed;
    width: 100%;

    .i-padding-7 {
        padding-left: 7%;
    }
    .i-padding-right-7 {
        padding-right: 7%;
    }
    .i-padding-2 {
        padding-left: 2%;
    }
    .i-between-body {
        height: 420px;

        width: 100%;
        border: 1px solid #04ecf0;
        margin-top: 10px;

        .i-charts {
            height: 250px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .i-charts-title {
            width: 100%;
            margin-top: 20px;
            color: #fff;
            display: flex;
            justify-content: center;
            .i-charts-title-c {
                width: 60%;
                height: 36px;
                background: #063b6f;
                border-left: 2px solid #3bcefe;
                border-right: 2px solid #3bcefe;
                display: flex;
                align-items: center;
                justify-content: space-between;
                .left {
                    padding-left: 20px;
                }
                .right {
                    padding-right: 20px;

                    span:last-child {
                        font-size: 12px;
                    }
                }
            }
        }
    }

    .i-title-background {
        background: url("../../assets/title-backgroup.png") no-repeat;
        padding: 2px 0px 2px 10px;
    }
    .i-font-color {
        color: #04ecf0;
    }

    .foot {
        padding-top: 20px;
        .i-foot-body-220 {
            height: 220px;

            width: 100%;
            border: 1px solid #04ecf0;
            margin-top: 10px;

            .el-col {
                padding-top: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                .title {
                    padding-top: 10px;
                    color: #9bafd1;
                    font-size: 20px;
                }
            }
        }
        .i-foot-body-coumt {
            height: 120px;

            width: 100%;
            border: 1px solid #04ecf0;
            margin-top: 20px;

            display: flex;
            justify-content: center;
            align-items: center;
            .i-inout-max {
                height: 40px;
                width: 60%;
                font-size: 28px;

                display: flex;
                justify-content: space-between;
                align-items: center;
            }
        }

        .i-foot-body {
            height: 360px;

            width: 100%;
            border: 1px solid #04ecf0;
            margin-top: 10px;

            .i-table {
                margin: 80px 80px 40px;
                color: #fff;
                border-top: 1px solid #2b4b61;
                border-left: 1px solid #2b4b61;
                .i-table-b {
                    width: 25%;

                    .i-table-c {
                        width: 100%;
                        display: flex;
                        justify-content: space-between;
                        span {
                            width: 50%;
                            height: 40px;
                            font-size: 18px;
                            display: flex;
                            justify-content: center;
                            align-items: center;

                            border-right: 1px solid #2b4b61;
                            border-bottom: 1px solid #2b4b61;
                        }
                    }
                }
            }
        }
    }
}
</style>