<template>
    <div class="app-main-table padding-20">
        <el-timeline :reverse="true">
            <el-timeline-item timestamp="2018/4/12  12:00:00" placement="top" size="large">
                <el-card>
                    <el-row :gutter="20">
                        <el-col :span="6">管理端： v1.0.0</el-col>
                        <el-col :span="6">小程序： v1.0.0</el-col>
                        <el-col :span="6">服务端： v1.0.0</el-col>
                    </el-row>
                </el-card>
            </el-timeline-item>
        </el-timeline>
    </div>
</template> 
<script>
export default {

}
</script>
