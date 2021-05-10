import { ref, reactive, defineComponent } from 'vue'
export default defineComponent({
    name: 'HMenu',
    props: {
        data: Object,    //  
    },
    setup() {
        return {}
    },
    render(props) {
        return <el-menu-item index={this.data.path}>
            <i class="el-icon-setting"></i>
            {{
                title: () => this.data.title
            }}
        </el-menu-item>

    },
})
