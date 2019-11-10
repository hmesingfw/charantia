<template>
    <div class="h-i">
        <panel-title />

        <el-row>
            <el-col :span="7" class="i-content-left">
                <div class="i-title-background margin-10">
                    <span class="i-font-color">注意事项</span>
                </div>
                <dv-border-box-7>
                    <el-carousel :interval="10000" direction="vertical" indicator-position="none" class="i-carousel" style="height:100%;">
                        <el-carousel-item v-for="(item, index) in precautionsList" :key="index" class="i-carousel-item">
                            <div v-for="obj in item" :key="obj.id" class="i-title-content">{{ obj.notice }}</div>
                        </el-carousel-item>
                    </el-carousel>
                </dv-border-box-7>
            </el-col>
            <el-col :span="17" class="i-content-right">
                <el-carousel :interval="1000000" indicator-position="none" class="i-carousel" style="height:920px;">
                    <el-carousel-item v-for="(item, index) in nursinginfoList" :key="index+'max'">
                        <el-row>
                            <el-col v-for="(obj, index) in item" :key="obj.id + index+''" :span="obj.spanLength * 3" class="i-content-right-col">
                                <div class="i-title-background margin-10">
                                    <span class="i-font-color">{{ obj.name }}</span>
                                </div>
                                <el-row>
                                    <el-col :span="24 / obj.spanLength" v-for="(child, index) in obj.children" :key="child.id + index+''">
                                        <div class="i-body-title">{{child.name}}</div>

                                        <el-carousel :interval="10000" direction="vertical" arrow="never" indicator-position="none" class="i-carousel" style="height:860px;">
                                            <el-carousel-item v-for="(nas, index) in child.nameList" :key="index+child.id +'-nameList'">
                                                <div class="i-body-content" v-for="i in nas" :key="i.id">{{i.sickEntity.name}}</div>
                                            </el-carousel-item>
                                        </el-carousel>
                                    </el-col>
                                </el-row>
                            </el-col>
                        </el-row>
                    </el-carousel-item>
                </el-carousel>
            </el-col>
        </el-row>
    </div>
</template>

<script>
import panelTitle from './panel-title'
import { GetHeight, deleteRequestData, DeepCopy, ErrorLog } from "@/utils/sys";
import api from "@/config/api";
export default {
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
                // console.log(res.data.data.list, '-----');

                let list = res.data.data.list;
                let rArr = [];
                let iconsult = 8;/* 每行几个 */
                let tempi = 0;
                let pushArr = [];

                list.forEach((element, index) => {
                    let obj = this.setArrayName(element);
                    let childLength = obj.children.length;

                    if (tempi + childLength < iconsult) {
                        pushArr.push(obj);
                        tempi = tempi + childLength;

                        this.$set(obj, 'spanLength', childLength);/* span 占比 */

                        /* 最后补全 */
                        if (index == list.length - 1) {
                            rArr.push(DeepCopy(pushArr));
                        }

                    } else if (tempi + childLength == iconsult) {
                        pushArr.push(obj);
                        rArr.push(DeepCopy(pushArr));
                        /* 重新赋值 */
                        tempi = 0;
                        pushArr = [];

                        this.$set(obj, 'spanLength', childLength)

                    } else {
                        let i = iconsult - tempi;           // 长度差
                        let inobj = DeepCopy(obj);
                        inobj.children.splice(i, childLength)
                        this.$set(inobj, 'spanLength', i)
                        pushArr.push(inobj);
                        rArr.push(DeepCopy(pushArr));

                        /* 超出部分 */
                        let inobx = DeepCopy(obj);
                        inobx.children.splice(0, i);
                        tempi = childLength - i;
                        pushArr = [];
                        this.$set(inobx, 'spanLength', tempi)
                        pushArr.push(inobx);

                        /* 最后补全 */
                        if (index == list.length - 1) {
                            pushArr.push(obj);
                            rArr.push(DeepCopy(pushArr));
                        }
                    }
                });
                console.log(rArr, '----s');
                this.nursinginfoList = rArr;
            })
        },
        /* 设置名称，组成数据组 */
        setArrayName(obj) {
            // console.log(obj.children, '---');
            let temp = 21;               // 每页数量

            obj.children.forEach(item => {
                let arr = item.hospitalized;
                let rearr = [];         // 返回拼接后的数组
                let len = Math.ceil(arr.length / temp);         // 共多少页
                /* 拼接 */
                for (let i = 0; i < len; i++) {
                    let iarr = arr.slice(temp * i, temp * (i + 1));
                    rearr.push(iarr);
                }
                this.$set(item, 'nameList', rearr);
            })
            return obj;
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

    .i-title-background {
        background: url("../../assets/title-backgroup.png") no-repeat;
        padding: 2px 0px 2px 10px;
    }
    .i-font-color {
        color: #04ecf0;
        font-size: 18px;
        font-weight: 700;
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

        .i-body-content {
            color: #0da3ac;
            border: 1px dashed #0da3ac;
            border-top: none;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 18px;
            font-weight: 700;
        }
        .i-body-content:nth-child(2n) {
            color: #7ab3b3;
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