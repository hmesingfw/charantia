
export default {
    render(h) {
        return <el-table data={this.data} on-selection-change={this.selectionChange} stripe={this.stripe} header-row-class-name="table-header-color" >
            <el-table-column type="selection" width="42"></el-table-column>
            {
                this.params.map(item => {
                    return <el-table-column prop={item.prop} label={item.label} formatter={this.test.bind(this, item)} ></el-table-column>
                })
            }
        </el-table>
    },
    props: {
        data: Array,                       // 数据来源
        params: Array,
        stripe: { type: Boolean, default: true },
        url: { type: String, default: '' },
        callbacl: { type: Function, default: () => { } }

    },
    methods: {
        selectionChange(val) {
            this.$emit('selection-change', val);
        },
        test(item, row, column, cellValue, index) {
            if (item.f) {
                return item.f(row);
            }
            return <div >{cellValue}</div>;
        }
    }
}
