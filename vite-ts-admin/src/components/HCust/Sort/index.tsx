import { defineComponent, reactive, ref } from "vue";
import { HttpSave } from "@/utils/global";
export default defineComponent({
    name: 'HInputNumber',

    render() {
        const scopedSlots = {
            reference: () => <el-input-number model-value={this.value} min={1} max={99} size="mini" controls-position="right" onChange={this.HandleChange} />
        }
        return <el-popconfirm title="确认操作" onConfirm={this.Confirm} v-slots={scopedSlots}></el-popconfirm>
    },
    emits: ['update:value', 'call'],
    props: {
        value: {
            type: Number,
            required: true,
        },
        id: {
            type: [String, Number],
            required: true,
        },
        url: {
            type: String,
            required: true,
        },
        params: {
            type: Object,
            default: () => ({
                id: 'id',
                value: 'sort'
            })
        },
    },
    setup(props, { attrs, slots, emit }) {
        const { value, id, params, url } = props;
        let selectValue = ref(value)

        function HandleChange(val: number) {
            emit('update:value', val);
            selectValue.value = val;
        }
        async function Confirm() {
            let data: any = {};
            data[params.id] = id
            data[params.value] = selectValue.value;
            await HttpSave(url, data);
            emit('call', data)
        }

        function onKeyDownchange(e: any) {
            console.log('11')
            /* 回车事件 */
            if (e.keyCode == 13) {
                Confirm();
            }
        }
        return { HandleChange, Confirm, onKeyDownchange }
    },
})