import {
    getRouter
} from "@/utils/route-menus";

const routers = {
    state: {
        routers: [], //router 路由列表信息
        tags: [{
            item: {
                path: '/index'
            },
            path: '/index',
            type: ''
        }], // tabs 列表 
    },
    mutations: {
        FLASH_TABS: (state, arr) => {
            state.tags = arr;
        },
        FLASH_NAVMENU: (state) => {
            getRouter.then(routers => {
                state.routers = routers;
            })
        }
    },
    actions: {
        AddRouterToTags({
            commit,
            state
        }, data) {
            let status = true;
            let arr = state.tags.map(obj => {
                if (obj.path == data.path) {
                    obj.type = ''
                    status = false;
                } else {
                    obj.type = 'info'
                }
                return obj;
            });


            if (status) {
                data.type = ''
                arr.push(data)
            }
            commit('FLASH_TABS', arr);
        },
        DelRouterToTags({
            commit,
            state
        }, data) {
            let arr = state.tags.filter(obj => {
                return obj.path != data.path;

            });
            commit('FLASH_TABS', arr);
        },
        /** 刷新左侧展示路由 */
        FlashNavMenu({
            commit,
        }, ) {
            commit('FLASH_NAVMENU');
        }
    },

}

export default routers;