import routerMap from '@/router';

const routers = {
    state: {
        routers: routerMap, //router 路由列表信息
        tags: [], // tabs 列表
    },
    mutations: {
        FLASH_TABS: (state, arr) => {
            state.tags = arr;
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
                    obj.type = 'success'
                    status = false;
                } else {
                    obj.type = 'info'
                }
                return obj;
            });


            if (status) {
                data.type = 'success'
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
        }
    },

}

export default routers;