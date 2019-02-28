import Vue from 'vue'
import Router from 'vue-router'

import layout from '@/views/layout/layout'

Vue.use(Router)

export default new Router({
	mode: 'history',
	base: process.env.BASE_URL,
	routes: [{
		path: '/login',
		component: () => import('@/views/login/index'),
		// hidden: true
	}, {
		path: '/layout',
		component: layout
	}, {
		path: '',
		component: () => import('@/views/dashboard/index')
	}]
})