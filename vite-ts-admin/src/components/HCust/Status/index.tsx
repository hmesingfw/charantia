import { defineComponent, ref } from "vue";
import Http from "@/utils/http";

export default defineComponent({
    name: 'HStatus',
    render() {
        return <el-row class="h-status">
            <span class="item">顶</span>
        </el-row>
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
        const http = new Http(url)
        const status = ref(true);
        async function Change() {
            let data: any = {};
            data[params.id] = id;
            await http.Post(url, data);
        }

        return {
            status,
            Change
        }
    }
})

