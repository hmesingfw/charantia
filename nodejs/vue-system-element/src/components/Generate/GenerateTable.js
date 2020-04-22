
export default {
    render(h) {

        return <el-table data={this.data} on-selection-change={this.selectionChange} stripe={this.stripe} header-row-class-name="table-header-color" >
            {this.isSelection && <el-table-column type="selection" width="42"></el-table-column>}
            {
                this.params.map(item => {
                    return <el-table-column {...{ attrs: item }} formatter={this.formatter.bind(this, item)}></el-table-column>
                })
            }
        </el-table>
    },
    props: {
        data: Array,                       // 数据来源
        params: Array,
        stripe: { type: Boolean, default: true },
        isSelection: { type: Boolean, default: true },  // 是否显示多选
    },
    methods: {
        selectionChange(val) {
            this.$emit('selection-change', val);
        },
        formatter(item, row, column, cellValue, index) {
            if (item.f) {
                return item.f(row);
            }
            return cellValue;
        }
    }
}
