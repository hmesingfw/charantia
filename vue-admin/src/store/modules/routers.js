import routerMap from '@/router';

const routers = {
    state: {
        routers: routerMap, //router 路由列表信息
        tags: [{
            item: {
                path: '/index'
            },
            path: '/index',
            type: ''
        }], // tabs 列表
        flashNavMenu: false, //刷新菜单信息
    },
    mutations: {
        FLASH_TABS: (state, arr) => {
            state.tags = arr;
        },
        FLASH_NAVMENU: (state, status) => {
            console.log(status);
            state.flashNavMenu = status;
            console.log(state.flashNavMenu);
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

        FlashNavMenu({
            commit,
        }, status) {
            commit('FLASH_NAVMENU', status);
        }
    },

}

export default routers;