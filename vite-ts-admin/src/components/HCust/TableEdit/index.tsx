import { h, ref, defineComponent, reactive } from "vue";
import { VueDraggableNext } from "vue-draggable-next";

export default defineComponent({
    name: 'HTableEdit',
    components: {
        draggable: VueDraggableNext
    },
    render() {
        return <el-form model={this.form} ref="ruleForm" class="h-table-edit">
            {this.handles && <el-row type="flex" class="handles"  >
                <el-button type="primary" class="el-icon-plus" onClick={() => this.AddItem()}>添加</el-button>
                <el-button type="danger" class="el-icon-delete" onClick={() => this.DelItem()}>删除</el-button>
            </el-row>}
            <draggable list={this.form.data} draggable=".item-drag" animation="300" onEnd={this.ChangeSettingsCol()}>
                <el-table data={this.tableData} row-class-name="item-drag" onSelectionChange={this.SelectionChange} {...this.$attrs}>
                    {this.selection && <el-table-column type="selection" width="42"></el-table-column>}
                    {this.sort &&
                        <el-table-column width="32" class-name="item-drag">
                            <i class="el-icon-sort edit-sort "></i>
                        </el-table-column>
                    }
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
        selection: { type: Boolean, default: false, },
        sort: { type: Boolean, default: false },
        handles: { type: Boolean, default: true, }
    },
    setup(props, { attrs, slots, emit }) {
        const { tableData } = props;
        const rules = reactive({});
        const form = reactive({
            data: tableData
        });
        const selectTableVal: any = ref([]); //  表格选中的值  
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
                case 'el-switch':
                    attr = {
                        'active-text': "启用", 'inactive-text': '禁用', class: "switch-style", 'active-value': 1, 'inactive-value': 0,
                        ...item.typeAttrs
                    }
                    return <el-switch vModel={row[item.prop]} {...attr}></el-switch>
                default:
                    return row[item.prop]
            }
        }
        /**
         * 添加行
         */
        function AddItem() {
            tableData?.push({})
        }
        /**
         * 删除行
         */
        function DelItem() {
            selectTableVal.value.forEach((info: any) => {
                tableData?.splice(tableData?.findIndex(item => info === item), 1)
            });
        }

        /**
         * 
         */
        function SelectionChange(val: Array<any>) {
            selectTableVal.value = val;
        }

        return { form, rules, ChangeSettingsCol, GetItem, GetRules, AddItem, DelItem, SelectionChange }
    },
})