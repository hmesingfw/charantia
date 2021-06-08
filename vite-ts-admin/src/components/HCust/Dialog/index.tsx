import { h, defineComponent } from "vue";
export default defineComponent({
    props: {
        value: {
            type: Boolean,
            default: false,
        },
        title: {
            type: String,
            default: '提示'
        },
        attrs: {
            type: Object,
            default: () => ({
                width: '30%',
                'close-on-click-modal': false,
            })
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
            emit('success')
        }
        /** 关闭前回调 */
        function BeforeClose() {
            emit('update:modelValue', false);
        }

        return { Success, Esc, BeforeClose }
    },
    render() {
        const scopedSlots = {
            footer: () => <span class="dialog-footer">
                <el-button onClick={this.Esc}>取 消</el-button>
                <el-button type="primary" onClick={this.Success}>确 定</el-button>
            </span>,

        }
        return <el-dialog title={this.title} model-value={this.value} {...this.attrs} v-slots={scopedSlots} before-close={this.BeforeClose}>
            {/* 好多的bug */}
            {h('div', {}, this.$slots.default())}
            {/* <div>{ctx.slots.default && ctx.slots.default()}</div> */}
        </el-dialog>
    }
})