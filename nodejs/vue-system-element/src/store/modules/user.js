import axios from 'axios'
import { setToken } from '@/utils/local-storage-auto'
import api from '@/config/api';

const state = {
    token: '',
    name: '',
    roles: []
};
const mutations = {
    SET_TOKEN: (state, token) => {
        state.token = token
    },
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

                commit('SET_TOKEN', data.token)

                setToken(response.data.token)
                resolve(data)
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