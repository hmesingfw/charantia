import axios from 'axios'
import { setToken } from '@/utils/local-storage-auto'
import api from '@/config/api';
import { TogetherRouter } from '@/utils/sys';

const state = {
    token: '',
    name: '',
    roles: [],
    info: {},
};
const mutations = {
    SET_TOKEN: (state, token) => {
        state.token = token
    },
    SET_INFO: (state, info) => {
        state.info = info;
    }
}
const actions = {
    // 用户名登录
    login({
        commit
    }, userInfo) {
        userInfo.username = userInfo.username.trim()
        return new Promise((resolve, reject) => {

            axios.post(api.sys.userLogin, { params: userInfo }).then(response => {
                const data = response.data
                if (data.code === 4001) {
                    resolve(data);
                }

                const sysMenu = data.sysMenu;
                /* 提取出按钮权限标识 */
                // sysMenu.forEach(item => {
                //     item.children.forEach(obj => {
                //         obj.children.forEach(but => {
                //             buttons.push(but.perms);
                //         })
                //     })
                // });
                console.log(sysMenu);
                let routerArr = [];
                routerArr = TogetherRouter(sysMenu);
                routerArr.push({ path: '*', redirect: '/404', hidden: true }); /* 404 页面 */
                commit('permission/SET_SQLROUTES', sysMenu, { root: true });

                commit('SET_INFO', data.info);

                commit('SET_TOKEN', data.token);
                // commit('SET_ROLES', buttons);

                setToken(response.data.token)
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