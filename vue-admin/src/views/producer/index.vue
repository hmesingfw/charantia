
<template>
    <el-tabs type="border-card" v-model="activeName">
        <el-tab-pane name="tableList">
            <span slot="label">
                <i class="el-icon-date"></i>我的表
            </span>
            我的表
        </el-tab-pane>
        <el-tab-pane label="数据库表" class="tableName" name="tableSelect">
            <table-select @getTableName="getTableName"></table-select>
        </el-tab-pane>
        <el-tab-pane label="详细信息" name="tableFiled">
            <table-filed :table-name="selectTableName" v-if="selectStatus"></table-filed>
            <span v-if="!selectStatus">请选择</span>
        </el-tab-pane>
    </el-tabs>
</template>
<script>
import TableSelect from "@/components/TableSelect";
import TableFiled from "@/components/TableFiled";
export default {
    data () {
        return {
            activeName: 'tableList',     //  激活的tab页
            selectTableName: '',    // 选择的表单
            selectStatus: false,     //选择表---状态 
        }
    },
    components: {
        TableSelect,
        TableFiled
    },
    methods: {
        getTableName (val) {
            this.selectStatus = false;
            this.$nextTick(() => {
                this.selectTableName = val;
                this.activeName = 'tableFiled';
                this.selectStatus = true;
            })
        }
    }
}
</script>
<style lang="less" scoped>
.tableName {
    height: 100px;
}
</style>
