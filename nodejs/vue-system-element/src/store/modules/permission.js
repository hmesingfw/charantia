import { constantRoutes as tenanlRouters } from '@index/router'
import { constantRoutes as adminRouters } from '@admin/router'
import axios from 'axios'
import api from '@/config/api'

/**
 * Use meta.role to determine if the current user has permission
 * @param roles
 * @param route
 */

const state = {
    routes: [],
    sqlRouter: [],       // 数据库存的路由地址

}

const mutations = {
    SET_ROUTES_TENANL: (state, routes) => {
        state.routes = tenanlRouters.concat(routes);
    },
    SET_ROUTES_ADMIN: (state, routes) => {
        state.routes = adminRouters.concat(routes);
    },
    SET_SQLROUTES: (state, routes) => {
        state.sqlRouter = routes;
    }
}

const actions = {
    // 添加链接信息
    ADD_ROUTES({
        commit
    }, routes) {
        commit('SET_ROUTES', routes);
    },

    /* 查询数据库存储的菜单信息 */
    ADD_SQLROUTES({
        commit
    }, routes) {
        axios.get(api.sys.menu, { params: { status: 0 } }).then(res => {
            let data = res.data.rows;
            commit('SET_SQLROUTES', data);
        });
    }
}

export default {
    namespaced: true,
    state,
    mutations,
    actions
}
