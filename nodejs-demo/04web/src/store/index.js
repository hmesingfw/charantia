import Vue from 'vue'
import Vuex from 'vuex'
import app from './modules/app'
import user from './modules/user'
import tagsView from './modules/tagsView'
import permission from './modules/permission'
import settings from './modules/settings'
import getters from './getters'
import enums from './modules/enums'
import enumsValue from './modules/enumsValue'
Vue.use(Vuex)

export default new Vuex.Store({
    modules: {
        app,
        user,
        tagsView,
        permission,
        settings,
        enums,
        enumsValue
    },
    state: {

    },
    mutations: {

    },
    actions: {

    },
    getters
})