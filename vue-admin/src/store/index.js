import Vue from 'vue'
import Vuex from 'vuex'
import app from './modules/app'
import user from './modules/user'
import routers from './modules/routers'
import Config from './modules/config'
import getters from './getters'
Vue.use(Vuex)

export default new Vuex.Store({
	modules: {
		app,
		user,
		routers,
		Config
	},
	state: {

	},
	mutations: {

	},
	actions: {

	},
	getters
})