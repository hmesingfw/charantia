import { mapGetters } from 'vuex';
export default {
    render() {
        return <el-table data={this.data} on-selection-change={this.selectionChange} stripe={this.stripe}  {...{ attrs: this.tableAttrs }} header-row-class-name={this.headerRowClassName} >
            {this.isSelection && <el-table-column type="selection" width="42"></el-table-column>}
            {
                this.params.map(item => {
                    if (item.permission) {
                        if (!this.roles.includes(item.permission)) return;
                    }
                    return <el-table-column {...{ attrs: item }} formatter={this.formatter.bind(this, item)} render-header={this.renderHeader.bind(this, item)}></el-table-column>
                })
            }
        </el-table>
    },
    computed: {
        // 使用对象展开运算符将 getter 混入 computed 对象中
        ...mapGetters([
            'roles'
        ])
    },
    props: {
        data: Array,                       // 数据来源
        params: Array,
        tableAttrs: {
            type: Object,
            default: () => ({})
        },           // 表格自定义扩展参数
        headerRowClassName: { type: String, default: 'table-header-color' },
        stripe: { type: Boolean, default: true },
        isSelection: { type: Boolean, default: true },  // 是否显示多选
        callback: { type: Function, default: () => { } }
    },
    methods: {
        selectionChange(val) {
            this.$emit('selection-change', val);
        },
        /* 渲染表头 */
        formatter(item, row, column, cellValue) {
            if (item.formatF) {
                return item.formatF(row);
            }
            return cellValue;
        },
        /* 渲染内容 */
        renderHeader(item, h, { column }) {
            if (item.labelF) {
                return item.labelF(column)
            }
            return item.label;

        },
    }
}
