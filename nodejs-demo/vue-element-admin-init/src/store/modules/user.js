const state = {
    token: '',
    name: '',
    roles: []
}
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
            resolve()
        })
    },
}

export default {
    namespaced: true,
    state, mutations, actions
}
