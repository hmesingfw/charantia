<template>
    <div class="h-i">
        <panel-title />

        <el-row>
            <el-col :span="8" class="i-content-left">
                <dv-border-box-7 class="i-patients">
                    <div class="i-title-background">
                        <span class="i-font-color">病患动态</span>
                    </div>
                    <el-row>
                        <el-col :span="14" class="i-patients-right">
                            <dv-decoration-9 class="i-patients-right-ridao">
                                <span class="num">1125</span>
                                <span>病人总数</span>
                            </dv-decoration-9>
                        </el-col>
                        <el-col :span="10" class="i-patients-left">
                            <span class="num">30</span>
                            <span>今日入院</span>
                            <span class="num">10</span>
                            <span>今日出院</span>
                        </el-col>
                    </el-row>
                </dv-border-box-7>

                <dv-border-box-7 class="i-sickbed">
                    <div class="i-title-background">
                        <span class="i-font-color">病床动态</span>
                    </div>
                    <el-row>
                        <el-col :span="10" class="i-sickbed-left">
                            <span class="num">1000</span>
                            <span>总床位</span>
                        </el-col>
                        <el-col :span="14">
                            <sickbed></sickbed>
                        </el-col>
                    </el-row>
                </dv-border-box-7>

                <dv-border-box-7 class="i-icu">
                    <div class="i-title-background">
                        <span class="i-font-color">病区分布</span>
                    </div>
                    <icu-echarts />
                </dv-border-box-7>
            </el-col>
            <el-col :span="8" class="i-nurse">
                <dv-border-box-7>
                    <div class="i-title-background">
                        <span class="i-font-color">护理动态</span>
                    </div>
                    <div>
                        <nurse-echarts />
                    </div>
                    <div class="i-foot-body">
                        <el-row class="i-table">
                            <el-col :span="12" v-for="obj in 8" :key="obj" class="i-table-b">
                                <div class="i-table-c">
                                    <span>obj.name</span>
                                    <span class="i-font-size-20">obj.sickTotal</span>
                                </div>
                            </el-col>
                        </el-row>
                    </div>
                </dv-border-box-7>
            </el-col>
            <el-col :span="8" class="i-doctor">
                <dv-border-box-7>
                    <div class="i-title-background">
                        <span class="i-font-color">医护动态</span>
                    </div>
                    <div>
                        <el-row>
                            <el-col :span="12" class="i-doctor-top">
                                <span class="num">1000</span>
                                <span>总床位</span>
                            </el-col>
                            <el-col :span="12" class="i-doctor-top">
                                <span class="num-2">1000</span>
                                <span>总床位</span>
                            </el-col>
                        </el-row>
                    </div>
                    <div style="border-bottom:1px solid #fff;margin-top:10px;"></div>

                    <doctor-echarts-new />
                </dv-border-box-7>
            </el-col>
        </el-row>
    </div>
</template>

<script>
import panelTitle from './panel-title'
import sickbed from './sickbed'
import icuEcharts from './icu-echatrs'
import nurseEcharts from './nurse-echarts'
import doctorEchartsNew from './doctor-echatrs-new'
import { GetHeight, deleteRequestData, DeepCopy, ErrorLog } from "@/utils/sys";
import api from "@/config/api";
export default {
    components: {
        panelTitle, sickbed, icuEcharts, nurseEcharts, doctorEchartsNew
    },
    data () {
        return {

        }
    },
    created () {
        this.init();
    },
    methods: {
        init () {
            // /* 医师动态 */
            // this.$http.get(api.panel.dynamic).then(res => {
            //     this.doctorList = res.data.data.map(item => ({
            //         name: item.name,
            //         value: item.sickTotal,
            //     }));

            //     this.legendValue = res.data.data.map(item => item.name);
            //     this.flashEcharts = false;
            //     this.$nextTick(() => {
            //         this.flashEcharts = true;
            //     })
            // })
            // /* 统计重点项目关联的病人数 、其他为非重点项目的总和 */
            // this.$http.get(api.panel.majorProjectcount).then(res => {

            //     this.doctorListKey = res.data.data.map(item => ({
            //         name: item.name,
            //         value: item.sickTotal,
            //     }));

            //     this.legendValueKey = res.data.data.map(item => item.name);
            //     this.flashEcharts = false;
            //     this.$nextTick(() => {
            //         this.flashEcharts = true;
            //     })
            // })

            // /* 统计当日病床信息 总床位、已用床位、剩余床位 */
            // this.$http.get(api.panel.sickbedcount).then(res => {
            //     this.sickbedcountVal = res.data.data;

            //     this.flashCircle = false;
            //     this.$nextTick(() => {
            //         this.flashCircle = true;
            //     })
            // })
            // /* 统计当日入院人数、出院人数 入院总人数             */
            // this.$http.get(api.panel.inoutcount).then(res => {
            //     console.log(res.data.data, '----f');
            //     this.inoutVal = res.data.data;

            //     this.flashCircle = false;
            //     this.$nextTick(() => {
            //         this.flashCircle = true;
            //     })

            // })

            // /* 统计所有护理项目中病人的数量             */
            // this.$http.get(api.panel.patientcount).then(res => {
            //     let arr = res.data.data;
            //     let rearr = [];         // 返回拼接后的数组
            //     let temp = 16;               // 每页数量
            //     let len = Math.ceil(arr.length / temp);         // 共多少页
            //     /* 拼接 */
            //     for (let i = 0; i < len; i++) {
            //         let iarr = arr.slice(temp * i, temp * (i + 1));
            //         rearr.push(iarr);
            //     }

            //     this.patientList = rearr;
            // })
        },
    }
}
</script>
<style lang="scss">
.h-i {
    background: url('../../assets/index.jpg');
    background-size: 100% 100%;
    height: 100%;
    position: fixed;
    width: 100%;

    .i-title-background {
        background: url('../../assets/2.png') repeat-y;
        padding: 4px 0px 4px 10px;
        height: 50px;
        display: flex;
        align-items: center;
        .i-font-color {
            color: #04ecf0;
            font-size: 22px;
            font-weight: 700;
        }
    }
    .i-content-left {
        padding-left: 6%;

        .i-patients {
            height: 250px;
            .el-row {
                height: 200px;
            }
            .i-patients-right {
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: center;

                .i-patients-right-ridao {
                    width: 160px;
                    height: 160px;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;

                    & .num {
                        font-size: 28px;
                        color: #f7a12f;
                    }
                    span:last-child {
                        color: #c7c7c7;
                    }
                }
            }
            .i-patients-left {
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: center;

                span {
                    margin-bottom: 16px;
                    text-align: center;
                    color: #c7c7c7;
                    font-size: 18px;
                }

                & .num {
                    font-size: 30px;
                    margin-bottom: 10px;
                    font-weight: 700;
                }
            }
        }
    }
    .i-sickbed {
        margin-top: 20px;
        height: 250px;

        .i-sickbed-left {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;

            & .num {
                color: #f7a12f;
                font-size: 30px;
                margin-top: 60px;
            }
            span {
                margin-top: 10px;
                color: #c7c7c7;
                font-size: 18px;
                font-weight: 700;
            }
        }
    }

    .i-icu {
        margin-top: 20px;
        height: 360px;
    }
    .i-nurse {
        padding-left: 1%;
        height: 900px;

        .i-foot-body {
            height: 220px;
            width: 100%;
            margin-top: 10px;

            .i-table {
                margin: 10px 40px;
                color: #fff;
                border-top: 1px solid #2b4b61;
                border-left: 1px solid #2b4b61;
                .i-table-b {
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

    .i-doctor {
        padding-left: 1%;
        height: 900px;
        padding-right: 6%;

        .i-doctor-top {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;

            & .num {
                color: #f7a12f;
                font-size: 30px;
                margin-top: 60px;
            }
            & .num-2 {
                color: #46b64f;
                font-size: 30px;
                margin-top: 60px;
            }
            span {
                margin-top: 10px;
                color: #c7c7c7;
                font-size: 18px;
                font-weight: 700;
            }
        }
    }
}
</style>