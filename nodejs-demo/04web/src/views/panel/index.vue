<template>
    <div class="h-i">
        <panel-title></panel-title>

        <div>
            <el-row>
                <el-col :span="6" class="i-padding-7">
                    <div class="i-title-background">
                        <span class="i-font-color">当日病床</span>
                    </div>
                    <div class="i-between-body"></div>
                </el-col>

                <el-col :span="8" class="i-padding-2">
                    <div class="i-title-background">
                        <span class="i-font-color">医师动态</span>
                    </div>
                    <div class="i-between-body"></div>
                </el-col>
                <el-col :span="10" class="i-padding-2 i-padding-right-7">
                    <div class="i-title-background">
                        <span class="i-font-color">重点护理项目</span>
                    </div>
                    <div class="i-between-body"></div>
                </el-col>
            </el-row>

            <el-row class="foot">
                <el-col :span="8" class="i-padding-7">
                    <div class="i-title-background">
                        <span class="i-font-color">当日出入院</span>
                    </div>
                    <div class="i-foot-body-220"></div>
                    <div class="i-foot-body-coumt"></div>
                </el-col>

                <el-col :span="16" class="i-padding-2 i-padding-right-7">
                    <div class="i-title-background">
                        <span class="i-font-color">护理动态</span>
                    </div>
                    <div class="i-foot-body"></div>
                </el-col>
            </el-row>
        </div>
    </div>
</template>

<script>
import panelTitle from './panel-title'
export default {
    components: {
        panelTitle
    },
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
        }
        .i-foot-body-coumt {
            height: 120px;

            width: 100%;
            border: 1px solid #04ecf0; 
            margin-top: 20px;
        }

        .i-foot-body {
            height: 360px;

            width: 100%;
            border: 1px solid #04ecf0;
            margin-top: 10px;
        }
    }
}
</style>