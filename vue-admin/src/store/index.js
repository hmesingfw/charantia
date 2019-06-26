import Vue from 'vue'
import Vuex from 'vuex'
import app from './modules/app'
import user from './modules/user'
import routers from './modules/routers'
import getters from './getters'
import sys from './modules/sys'
Vue.use(Vuex)

export default new Vuex.Store({
	modules: {
		app,
		user,
		routers,
		sys
	},
	state: {

	},
	mutations: {

	},
	actions: {

	},
	getters
})