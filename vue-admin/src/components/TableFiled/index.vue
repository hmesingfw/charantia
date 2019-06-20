<template>
    <el-form ref="form" :rules="form.rules" :model="form">
        <el-table :data="form.tableData" style="width: 100%" :height="tableHeight">
            <el-table-column fixed prop="Field" label="字段名" width="150"></el-table-column>
            <el-table-column fixed prop="FieldType" label="字段类型" width="150"></el-table-column>
            <el-table-column fixed prop="FieldLength" label="字段长度" width="150"></el-table-column>
        </el-table>
    </el-form>
</template>

<script>
export default {
    props: {
        tableName: [String]
    },
    created () {
        this.init();
        this.setHeight();
    },
    data () {
        return {
            tableHeight: '250px',
            form: {
                rules: {

                },
                tableData: []
            }
        }
    },
    methods: {
        init () {
            this.$http(`/egg/getTableFiled?tableName=${this.tableName}`).then(res => {
                console.log(res);
                let list = res.data.map(item => {
                    // 过滤字段类型
                    let type = item.Type.indexOf('(') != -1 ? item.Type.substring(0, item.Type.indexOf('(')) : item.Type;
                    // 类型长度
                    let length = item.Type.indexOf('(') != -1 ? item.Type.substring(item.Type.indexOf('(') + 1, item.Type.indexOf(')')) : '';
                    return {
                        Field: item.Field,
                        FieldType: type,
                        FieldLength: length,
                    }
                })
                console.log(list);
                this.$set(this.form, 'tableData', list);
            }).catch(err => {
                this.$message(err);
            })
        },
        /** 设置表格高度，好适应屏幕 */
        setHeight () {
            // 200 为当面页面偏差
            this.tableHeight = document.documentElement.clientHeight - 200 + 'px';
        }
    }
}
</script>
