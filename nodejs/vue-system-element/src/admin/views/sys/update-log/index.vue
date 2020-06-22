<template>
    <div class="app-main-table padding-20">
        <el-timeline :reverse="true">
            <el-timeline-item :timestamp="data.web.updateTime" placement="top" size="large">
                <el-card>
                    <el-row :gutter="20">
                        <el-col :span="6">管理端： {{ data.web.version}}</el-col>
                        <el-col :span="6">小程序： {{ data.miniapp.version}}</el-col>
                        <el-col :span="6">服务端： {{ data.server.version}}</el-col>
                    </el-row>
                </el-card>
            </el-timeline-item>
        </el-timeline>
    </div>
</template> 
<script>
export default {
    data() {
        return {
            data: {}
        }
    },
    created() {
        this.init();
    },
    methods: {
        init() {
            this.$http.get(this.$api.sys.versionLog).then(res => {
                this.data = res.data.data;
            })
        },
    }
}

</script>
