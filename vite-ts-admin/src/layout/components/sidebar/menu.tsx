import { defineComponent, ref, onBeforeMount } from 'vue'

export default defineComponent({
    name: 'HMenu',
    props: {
        options: {
            type: Array,
            required: true
        },
    },
    setup(props) {
        const isCollapse = ref(false);

        onBeforeMount(() => {
            FormatOptions(props.options, '')
        })

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
            const { path, meta, fullPath } = menu;
            // 3.0 插槽的写法
            const scopedSlots = {
                title: () => <>
                    <i class={meta.icon}></i>
                    <span>{meta.title}</span>
                </>
            }
            return <el-menu-item index={fullPath} v-slots={scopedSlots} >
            </el-menu-item>
        }

        function HandleOpen(key: string, keyPath: string) {
            console.log(key, keyPath);
        }
        function HandleClose(key: string, keyPath: string) {
            console.log(key, keyPath);
        }

        /**
         * 循环为router 添加fullpath, 主要为menu-item上的index属性
         * @param options router list 对象
         * @param parentPath 父级路径
         */
        function FormatOptions(options: any, parentPath: string) {
            options.forEach((route: any) => {
                const isFullPath = route.path.substring(0, 1) == '/'
                route.fullPath = isFullPath ? route.path : parentPath + '/' + route.path
                if (route.children) {
                    FormatOptions(route.children, route.fullPath)
                }
            })
        }
        return {
            RenderMenu, RenderItem, RenderSubMenu, RenderItemMenu, isCollapse,
            HandleOpen, HandleClose, FormatOptions
        }
    },
    computed: {
        activeMenu(): any {
            /* 默认选中 */
            const route = this.$route
            const { meta, path } = route
            if (meta.activeMenu) {
                return meta.activeMenu
            }
            return path
        },
    },


    render() {
        return <el-menu default-active={this.activeMenu} class="layout-menu" collapse={this.isCollapse} on-open={this.HandleOpen} on-close={this.HandleClose} router={true} >
            {this.RenderMenu(this.options)}
        </el-menu>

    }
})

