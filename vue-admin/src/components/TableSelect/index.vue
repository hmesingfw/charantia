<template>
    <div class="table">
        <el-select v-model="value" placeholder="请选择" filterable clearable :loading="loading">
            <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value"
            ></el-option>
        </el-select>
        <el-button type="primary" @click="selectTable">选择</el-button>
    </div>
</template>
<script>
export default {

    data () {
        return {
            options: [],
            value: '',
            loading: true,
        }
    },
    created () {
        this.init();
    },
    methods: {
        /** 加载数据库中的所有表信息 */
        init () {
            this.$http(`/egg/getAllTableName`).then(res => {
                this.options = res.data.map(item => {
                    return {
                        label: item.table_name,
                        value: item.table_name,
                    }
                })
                this.loading = false;
            }).catch(err => {
                this.$message(err);
            })
        },

        /** 选择表信息 */
        selectTable () {
            // this.value
            if (!this.value) {
                this.$message('请选择表信息')
                return false;
            }

            this.$emit('getTableName', this.value)
        }
    }
}
</script>

<style lang="less" scoped>
.table {
    .el-select {
        width: 100%;
    }
    .el-button {
        margin-top: 10px;
        width: 80px;
    }
}
</style>
