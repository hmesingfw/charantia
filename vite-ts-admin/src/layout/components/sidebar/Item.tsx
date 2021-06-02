
import { defineComponent } from "vue";
export default defineComponent({
    name: 'MenuItem',
    functional: true,
    props: {
        icon: {
            type: String,
            default: ''
        },
        title: {
            type: String,
            default: ''
        }
    },
    render() {
        const { icon, title } = this;

        if (icon) {
            return <svg-icon icon-class={icon} />
        }

        if (title) {
            return <span v-slots='title'>{(title)}</span>
        }
        return []
    }
})