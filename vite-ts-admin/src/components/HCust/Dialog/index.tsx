import { h, defineComponent } from "vue";
export default defineComponent({
    props: {
        value: {
            type: Boolean,
            default: false,
        },
    },
    emits: { success: null, 'update:modelValue': null, },
    setup(props, { attrs, slots, emit }) {

        /**
         * 取消-点击事件
         */
        function Esc(): void {
            emit('update:modelValue', false);
        }
        /**
         * 确定-点击事件
         */
        function Success(): void {
            emit('update:modelValue', false);
            emit('success')
        }

        return { Success, Esc }
    },
    render() {
        const scopedSlots = {
            footer: () => <span class="dialog-footer">
                <el-button onClick={this.Esc}>取 消</el-button>
                <el-button type="primary" onClick={this.Success}>确 定</el-button>
            </span>,

        }
        return <el-dialog title="提示" model-value={this.value} width="30%" v-slots={scopedSlots}>
            {/* 好多的bug */}
            {h('div', {}, this.$slots.default())}
        </el-dialog>
    }
})