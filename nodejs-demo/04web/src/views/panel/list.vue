<template>
    <div class="h-i">
        <panel-title />

        <el-row style="margin-top:20px;">
            <el-col :span="7" class="i-content-left">
                <dv-border-box-7>
                    <div class="i-title-background-top">
                        <span class="i-font-color">注意事项</span>
                    </div>
                    <el-carousel :interval="10000" direction="vertical" indicator-position="none" class="i-carousel" style="height:100%;">
                        <el-carousel-item v-for="(item, index) in precautionsList" :key="index" class="i-carousel-item">
                            <div v-for="obj in item" :key="obj.id" class="i-title-content">{{ obj.notice }}</div>
                        </el-carousel-item>
                    </el-carousel>
                </dv-border-box-7>
            </el-col>
            <el-col :span="17" class="i-content-right">
                <dv-border-box-7>
                    <div class="i-title-background-top">
                        <span class="i-font-color">护理项目</span>
                    </div>
                    <el-tabs tab-position="left" style="height: 849px">
                        <el-tab-pane v-for="nur in nursinginfoList" :key="nur.id" :label="nur.name">
                            <el-scrollbar wrap-class="agreement">
                                <div v-for="(item, index) in nur.children" :key="'i' + nur.id + index">
                                    <div class="i-font-back">
                                        <span class="i-font-title">{{ item.name }}</span>
                                    </div>
                                    <el-row class="i-row-body">
                                        <el-col :span="4" v-for="obj in item.hospitalized" :key="obj.id">
                                            <span v-if="norms.nameTitle == item.showFormat" class="i-body-content">{{ obj.sickbedDesc + ' ' + obj.sickEntity.name }}</span>
                                            <span v-else-if="norms.title == item.showFormat" class="i-body-content">{{ obj.sickbedDesc }}</span>
                                            <span v-else class="i-body-content">{{ obj.sickEntity.name }}</span>
                                        </el-col>
                                    </el-row>
                                </div>
                            </el-scrollbar>
                        </el-tab-pane>
                    </el-tabs>
                </dv-border-box-7>
            </el-col>
        </el-row>
    </div>
</template>

<script>
import panelTitle from './panel-title'
import { GetHeight, deleteRequestData, DeepCopy, ErrorLog } from "@/utils/sys";
import api from "@/config/api";
import { mapState } from 'vuex'
export default {
    computed: {
        ...mapState({
            norms: state => state.enumsValue.enumval.norms,
        })
    },
    components: {
        panelTitle
    },
    data() {
        return {
            precautionsList: [],
            nursinginfoList: [],
        }
    },
    created() {
        this.init();
    },
    methods: {
        getKeyId() {
            return new Date().getTime();
        },
        init() {
            /* 获取注意事项信息             */
            this.$http.get(api.panel.precautions, { params: { page: 1, size: 10000 } }).then(res => {
                let arr = res.data.data.list;
                let rearr = [];         // 返回拼接后的数组
                let temp = 15;               // 每页数量
                let len = Math.ceil(arr.length / temp);         // 共多少页
                /* 拼接 */
                for (let i = 0; i < len; i++) {
                    let iarr = arr.slice(temp * i, temp * (i + 1));
                    rearr.push(iarr);
                }
                this.precautionsList = rearr;
            })
            this.$http.get(api.panel.nursinginfo, { params: { page: 1, size: 10000 } }).then(res => {
                console.log(res.data.data.list, '-----');

                this.nursinginfoList = res.data.data.list;
            })
        },

    }
}
</script>
<style lang="scss">
.h-i {
    .agreement {
        max-height: 850px;
    }
    background: url("../../assets/index.jpg");
    background-size: 100% 100%;
    height: 100%;
    position: fixed;
    width: 100%;

    .i-title-background {
        background: url("../../assets/title-backgroup.png") no-repeat;
        padding: 2px 0px 2px 10px;
        .i-font-color {
            color: #04ecf0;
            font-size: 18px;
            font-weight: 700;
        }
    }

    .i-title-background-top {
        background: url("../../assets/2.png") repeat-y;
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

    .i-font-back {
        background: url("../../assets/title-backgroup.png") repeat-y;
        padding: 2px 0px 2px 10px;
        height: 50px;
        display: flex;
        align-items: center;
        margin-top: 20px;
        .i-font-title {
            color: #fff;
            font-size: 18px;
            font-weight: 700;
        }
    }
    .margin-10 {
        margin-bottom: 10px;
    }
    .i-content-left {
        padding-left: 6%;
        height: 900px;
    }
    .i-content-right {
        padding-right: 6%;
        height: 900px;
        padding-left: 1%;

        .i-content-right-col {
            padding-left: 20px;
        }

        .i-body-title {
            border: 1px solid #0da3ac;
            color: #0da3ac;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 18px;
            font-weight: 700;
        }
        .i-row-body {
            .el-col {
                margin-bottom: 10px;
                padding-right: 10px;
            }
        }
        .i-body-content {
            color: #0da3ac;
            border-right: 1px solid rgba(54, 74, 121, 0.5);
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 16px;
            font-weight: 700;
        }
        .i-body-content:nth-child(2n) {
            color: #7ab3b3;
        }

        .el-tabs__item {
            color: #c3c3c3;
            font-size: 18px;
            font-weight: 700;
            height: 70px;
            line-height: 70px;
        }
        .el-tabs__nav-wrap::after {
            background-color: #777777;
        }
        .is-active {
            color: #c3c3c3;
            background: #74f7f938;
        }
    }

    .i-carousel {
        .el-carousel__container {
            height: 100%;
        }

        .i-carousel-item {
            padding: 20px;

            .i-title-content {
                color: #00c6c3;
                margin-top: 20px;
                font-size: 18px;
            }
            .i-title-content:nth-child(2n-1) {
                color: #7ab3b3;
            }
        }
    }
}
</style>