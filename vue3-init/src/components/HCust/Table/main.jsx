
export default {
    props: {
        // 数据来源
        data: Array,
        params: Array,
        ref: String,
        // 表格自定义扩展参数
        tableAttrs: { type: Object, default: () => { } },
    },
    render() {
        return <el-table ref='hCustTableRef' data={this.data} onSelectionChange={this.selectionChange} {...this.tableAttrs} >
            {
                this.params.map(item => {
                    if (!item || !item.status) return;

                    return <el-table-column prop={item.prop} {...item.attr} formatter={this.formatter.bind(this, item)} >
                        {{
                            header: () => this.renderHeader(item)
                        }}
                    </el-table-column>
                })
            }
        </el-table>
    },
    methods: {
        formatter(item, row, column, cellValue, index) {
            if (item.formatF) {
                return item.formatF(row, column);
            }
            return item.prop ? row[item.prop] || '' : '';
        },
        /* 渲染表格表头  */
        renderHeader(item) {
            if (item.labelF) {
                return item.labelF()
            }
            return item.label;
        },
        /* 多选操作 */
        selectionChange(val) {
            this.$emit('selections', val);
        },
        getTableRef() {
            return this.$refs.hCustTableRef;
        },
    },
}
//  render-header={renderHeader.bind(this, item)}
