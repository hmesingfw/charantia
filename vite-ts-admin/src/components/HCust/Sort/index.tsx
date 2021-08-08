import { defineComponent, reactive, ref } from "vue";
import Http from "@/utils/http";
export default defineComponent({
    name: 'HStatus',
    render() {
        const scopedSlots = {
            reference: () => <el-input-number model-value={this.numberVal} min={1} max={99} size="mini" controls-position="right" onChange={this.HandleChange} />
        }
        return <el-popconfirm title="确认操作" onConfirm={this.Confirm} v-slots={scopedSlots}></el-popconfirm>
    },
    emits: ['update:modelValue', 'call'],
    computed: {
        numberVal: {
            get(): number {
                return this.value
            },
            set(value: number): void {
                this.$emit('update:modelValue', value)
            }
        }
    },
    props: {
        value: {
            type: Number,
            required: true,
            default: 0
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
        const http = new Http(url);
        let selectValue = ref(value)

        function HandleChange(val: number) {
            emit('update:modelValue', val);
            selectValue.value = val;
        }
        async function Confirm() {
            let data: any = {};
            data[params.id] = id
            data[params.value] = selectValue.value;
            await http.Save(url, data);
            emit('call', data)
        }

        function onKeyDownchange(e: any) {
            /* 回车事件 */
            if (e.keyCode == 13) {
                Confirm();
            }
        }
        return { HandleChange, Confirm, onKeyDownchange }
    },
})