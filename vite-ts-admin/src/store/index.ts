
import Vuex from 'vuex';
import user from './modules/user'
import createPersistedState from "vuex-persistedstate"
/**
 * 提供一个工厂函数创建 store
 */
export const createStore = new Vuex.Store<any>({
    plugins: [createPersistedState()],
    state: {},
    mutations: {},
    actions: {},
    modules: {
        user
    },
    getters: {},
});

