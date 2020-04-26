import axios from 'axios'
import api from '@/config/api'
const state = {
    data: {}
}

const mutations = {
    GET_ENUM: (state, data) => {
        state.data = data
    }
}

const actions = {
    /* 获取系统枚举值 */
    getEnum({
        commit
    }) {
        axios.get(api.sys.enum, { params: { status: 0 } }).then(res => {
            let data = {};
            res.data.rows.forEach(item => {
                data[item.value] = item.children
            });
            commit('GET_ENUM', data)
        });
    },
}

export default {
    namespaced: true,
    state,
    mutations,
    actions
}