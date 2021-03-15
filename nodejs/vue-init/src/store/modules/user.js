import axios from 'axios'
import { setToken } from '@/utils/local-storage-auto'
import api from '@/config/api';
import { TogetherRouter } from '@/utils/sys';

const state = {
    name: '',  // 好像无用
    roles: [],
    /* 平台 */
    token: '',
    info: {},
    /* 租户 */
    info_index: {},
    token_index: '',

};
const mutations = {
    SET_TOKEN: (state, token) => {
        state.token = token
    },
    SET_INFO: (state, info) => {
        state.info = info;
    },
    SET_ROLES: (state, info) => {
        state.roles = info;
    },

    SET_TOKEN_INDEX: (state, token) => {
        state.token_index = token
    },
    SET_INFO_INDEX: (state, info) => {
        state.info_index = info;
    },
}
const actions = {
    // 平台登录
    login_admin({
        commit
    }, userInfo) {
        userInfo.account = userInfo.account.trim()
        return new Promise((resolve, reject) => {

            axios.post(api.sys.userLogin, userInfo).then(response => {
                const data = response.data.data;
                if (response.data.code != 200) {
                    resolve(data);
                }

                const sysMenu = data.menus;

                let routerArr = [];
                routerArr = TogetherRouter(sysMenu);
                routerArr.push({ path: '*', redirect: '/404', hidden: true }); /* 404 页面 */
                commit('permission/SET_SQLROUTES', sysMenu, { root: true });

                commit('SET_INFO', data.user);

                commit('SET_TOKEN', data.token);
                /* 按钮权限 */
                // const buttons = data.roles.map(item => item.par);
                // commit('SET_ROLES', buttons);

                setToken(data.token)
                resolve(routerArr);

            }).catch(error => {
                reject(error)
            })
        })
    },

    logout() { },
}


export default {
    namespaced: true,
    state, mutations, actions
}