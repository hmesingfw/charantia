import { createStore } from 'vuex'

import app from './modules/app'
import user from './modules/user'
import tagsView from './modules/tagsView'
import settings from './modules/settings'
import getters from './getters'

export default createStore({
    modules: {
        app,
        user,
        tagsView,
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
