import axios from '@/config/axios-config'
import api from '@/config/api'
import { Code } from '@/config/index'

import { ActionContext } from 'vuex'

interface State {
    account: string,
    name: string,
    role: string,
    mobile: string,
    token: string,
}

const state: State = {
    account: '',
    name: '',
    mobile: '',
    token: '',
    role: ''
}

const mutations = {
    // 保存用户信息
    SET_USER(state: State, user: State) {
        state.token = user.token;
        state.name = user.name;
    }
}

interface UserInfo {
    account: string,
    password: string,
}
const actions = {
    async login(context: ActionContext<State, any>, from: UserInfo) {
        const res: any = await axios.post(api.sys.login, from)

        const { code, data, message } = res;
        if (code === Code.SUCCESS) {
            context.commit('SET_USER', data)
        }
        return {
            code, message
        }

    },
}

export default {
    namespaced: true,
    state, mutations, actions

}