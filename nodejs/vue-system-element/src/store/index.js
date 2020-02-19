import Vue from 'vue'
import Vuex from 'vuex'
import app from './modules/app'
import user from './modules/user'
import tagsView from './modules/tagsView'
import permission from './modules/permission'
import settings from './modules/settings'
import getters from './getters'
import persistedState from 'vuex-persistedstate';

Vue.use(Vuex)

export default new Vuex.Store({
    plugins: [persistedState({
        reducer(val) {
            return {
                // 只储存state中的assessmentData
                // assessmentData: val.assessmentData
                app: val.app,
                company: val.company,
                permission: val.permission,
                user: val.user
            };
        }
    })],
    modules: {
        app,
        user,
        tagsView,
        permission,
        settings
    },
    state: {

    },
    mutations: {

    },
    actions: {

    },
    getters
})