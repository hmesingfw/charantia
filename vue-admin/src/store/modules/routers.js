import routerMap from '@/router';

const routers = {
    state: {
        routers: routerMap, //router 路由列表信息
        tags: [], // tabs 列表
    },
    mutations: {
        PUSH_TABS: (state, arr) => {
            state.tags.push(arr);
        }
    },
    actions: {
        PushRouterToTabs({
            commit
        }, data) { 
            data.type = 'success'
            commit('PUSH_TABS', data);
        }
    },

}

export default routers;