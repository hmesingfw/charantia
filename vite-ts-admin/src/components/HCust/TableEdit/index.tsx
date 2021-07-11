import { h, ref, defineComponent, reactive } from "vue";
import { VueDraggableNext } from "vue-draggable-next";

export default defineComponent({
    name: 'HTableEdit',
    components: {
        draggable: VueDraggableNext
    },
    render() {
        return <el-form model={this.form} ref="ruleForm" class="h-table-edit">
            <draggable list={this.form.data} draggable=".item-drag" animation="300" onEnd={this.ChangeSettingsCol()}>
                <el-table data={this.form.data} row-class-name="item-drag" {...this.$attrs}>
                    {this.selection && <el-table-column type="selection" width="42"></el-table-column>}
                    <el-table-column width="32" class-name="item-drag">
                        <i class="el-icon-sort edit-sort "></i>
                    </el-table-column>
                    {
                        this.columnData?.map((item: any, index: number) => {
                            return <el-table-column label={item.label} {...item.colAttrs}  >
                                {{
                                    default: ({ row, $index }: any) => {
                                        let dom = row[item.prop];
                                        if (item.formatF) {
                                            dom = item.formatF(row);
                                        } else {
                                            dom = this.GetItem(item, row)
                                        }
                                        return <el-form-item {...this.GetRules(item)} prop={`data.${$index}.${item.prop}`}>{dom}</el-form-item>
                                    }
                                }}
                            </el-table-column>
                        })
                    }
                </el-table>
            </draggable>
        </el-form>
    },
    props: {
        tableData: { type: Array },
        columnData: { type: Array },
        selection: { type: Boolean, default: false, }
    },
    setup(props, { attrs, slots, emit }) {
        const { tableData } = props;
        const rules = reactive({});
        const form = reactive({
            data: tableData
        });
        // TODO: 排序功能暂时没有
        function ChangeSettingsCol() {

        }
        /**
         * 生成验证方法
         * @param item 字段层
         * @returns 验证对象
         */
        function GetRules(item: any) {
            if (item?.required) {
                return { rules: [{ required: true, message: '请输入内容', trigger: 'blur' }], 'inline-message': true }
            } else if (item?.rules) {
                return { rules: item.rules, 'inline-message': true };
            }
        }
        /**
         * 生成form-item
         * @param item 字段层
         * @param row 数据层
         * @returns 渲染DOM
         */
        function GetItem(item: any, row: any) {
            let attr = {};
            switch (item.type) {
                case 'el-input':
                    attr = {
                        placeholder: '请输入内容', 'show-word-limit': true,
                        ...item.typeAttrs
                    }
                    return <el-input vModel={row[item.prop]} {...attr}></el-input>
                case 'el-input-number':
                    attr = {
                        min: 0, max: 99, 'controls-position': 'right', placeholder: '请输入内容',
                        ...item.typeAttrs
                    }
                    return <el-input-number vModel={row[item.prop]} {...attr}></el-input-number>
                default:
                    return row[item.prop]
            }
        }

        return { form, rules, ChangeSettingsCol, GetItem, GetRules }
    },
})