import { defineComponent } from 'vue'
export default defineComponent({
    name: 'HMenu',
    props: {
        options: {
            type: Array,
            required: true
        },
    },
    setup() {
        function RenderMenu(menuTree: Array<any>) {
            const menuArr: Array<Object> = []
            menuTree.forEach(menu => {
                const { meta, children } = menu;

                // 判断是否隐藏，是否存在meta
                if (meta && meta.invisible !== true) {
                    menuArr.push(RenderItem(menu))

                } else if (children && children.length > 0) {

                    const childArr: Array<Object> = children.filter((item: any) => {
                        return item.meta && item.meta.invisible !== true
                    });
                    // 只允许存在符合条件的一个子菜单 
                    if (childArr.length == 1) {
                        menuArr.push(RenderItemMenu(children[0]))
                    } else {
                        menuArr.push(RenderMenu(children))
                    }
                }
            })
            return menuArr
        }
        function RenderItem(menu: any) {
            const { children } = menu;
            // 多级子菜单
            if (children && children.length > 0) {
                return RenderSubMenu(menu);
            } else {
                return RenderItemMenu(menu);
            }

        }
        function RenderSubMenu(menu: any) {
            const { path, meta, children } = menu;

            const scopedSlots = {
                title: () => <>
                    <i class={meta.icon}></i>
                    <span>{meta.title}</span>
                </>
            }
            return <el-submenu index={path} v-slots={scopedSlots}>
                {RenderMenu(children)}
            </el-submenu>
        }

        function RenderItemMenu(menu: any) {
            const { path, meta } = menu;
            // 3.0 插槽的写法
            const scopedSlots = {
                title: () => <>
                    <i class={meta.icon}></i>
                    <span>{meta.title}</span>
                </>
            }
            return <el-menu-item index={path} v-slots={scopedSlots} ></el-menu-item>
        }
        return {
            RenderMenu, RenderItem, RenderSubMenu, RenderItemMenu
        }
    },

    render() {
        return this.RenderMenu(this.options);
    }
})
