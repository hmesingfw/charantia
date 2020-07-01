<template>
    <el-row class="result-pro">
        <div class="app-main-table">
            <el-card shadow="always">
                <div class="vote-item-title" slot="header">1.那位歌手能获得本次冠军</div>
                <el-row>
                    <el-col :xl="16" :md="12">
                        <div class="pro-progress">
                            <div class="title">
                                <span>选项1：</span>
                                <span>张学友</span>
                            </div>
                            <el-row>
                                <el-col :span="22">
                                    <el-progress :text-inside="true" :stroke-width="strokeWidth" :percentage="70.2"></el-progress>
                                </el-col>
                                <el-col :span="2">
                                    <span>36 人</span>
                                </el-col>
                            </el-row>
                        </div>
                        <div class="pro-progress">
                            <div class="title">
                                <span>选项2：</span>
                                <span>张学友</span>
                            </div>

                            <el-row>
                                <el-col :span="22">
                                    <el-progress :text-inside="true" :stroke-width="strokeWidth" :percentage="100" status="success"></el-progress>
                                </el-col>
                                <el-col :span="2">
                                    <span>36 人</span>
                                </el-col>
                            </el-row>
                        </div>
                        <div class="pro-progress">
                            <div class="title">
                                <span>选项3：</span>
                                <span>张学友</span>
                            </div>
                            <el-row>
                                <el-col :span="22">
                                    <el-progress :text-inside="true" :stroke-width="strokeWidth" :percentage="80" status="warning"></el-progress>
                                </el-col>
                                <el-col :span="2">
                                    <span>36 人</span>
                                </el-col>
                            </el-row>
                        </div>
                        <div class="pro-progress">
                            <div class="title">
                                <span>选项4：</span>
                                <span>张学友</span>
                            </div>
                            <el-row>
                                <el-col :span="22">
                                    <el-progress :text-inside="true" :stroke-width="strokeWidth" :percentage="50" status="exception"></el-progress>
                                </el-col>
                                <el-col :span="2">
                                    <span>36 人</span>
                                </el-col>
                            </el-row>
                        </div>
                    </el-col>
                    <el-col :xl="8" :md="12">
                        <div>
                            <pie-chart />
                        </div>
                    </el-col>
                </el-row>
            </el-card>
        </div>
    </el-row>
</template>
<script>
import PieChart from './PieChart'
export default {
    components: { PieChart },
    data() {
        return {
            strokeWidth: 14,
        }
    },
}
</script>
<style lang="scss">
.result-pro {
    .vote-item-title {
        font-size: 14px;
    }
    .pro-progress {
        margin-top: 20px;
        .title {
            margin-bottom: 10px;
        }
        .el-progress {
            padding-right: 10px;
            padding-left: 50px;
        }
        span {
            font-size: 14px;
        }
    }
}
</style>