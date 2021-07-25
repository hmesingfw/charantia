import { defineComponent, ref } from "vue";
import { HttpSave } from "@/utils";

export default defineComponent({
    name: 'HSwitch',
    render() {
        if (true) {
            return <el-switch vModel={this.status} class="switch-style" {...this.$attrs} active-color="#4fc08d" />
        } else {
            return 'zhi';
        }
    },
    props: {
        data: {
            type: Object,
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
        const { data, params, url, id } = props;
        const status = ref(true);
        async function Change() {
            let data: any = {};
            data[params.id] = id;
            // data[params.value] = value;
            await HttpSave(url, data);
            // emit('call', data)
        }

        return {
            status,
            Change
        }
    }
})

