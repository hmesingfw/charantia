import { defineComponent } from "vue";
export default defineComponent({
    name: 'HInputNumber',

    render() {
        const scopedSlots = {
            reference: () => <el-input-number model-value={this.value} min={1} max={99} size="mini" controls-position="right" onChange={this.HandleChange} />
        }
        return <el-popconfirm title="确认操作" onConfirm={this.Confirm} v-slots={scopedSlots}></el-popconfirm>
    },
    emits: ['update:value',],
    props: {
        value: {
            type: Number,
        },
        attrs: {
            type: Object,
            default: () => ({
                width: '30%',
                'close-on-click-modal': false,
            })
        },
    },
    setup(props, { attrs, slots, emit }) {
        function HandleChange(val: number) {
            emit('update:value', val);
        }
        function Confirm() {
            console.log(props.value)
        }
        return { HandleChange, Confirm }
    },
})