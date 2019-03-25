import Vue from 'vue'
import Router from 'vue-router'

import layout from '@/views/layout/layout'

Vue.use(Router)


export const routerMap = [{
	path: '/login',
	component: () => import('@/views/login/index'),
	hidden: true, // 在路由面板隐藏此链接
	// hidden: true
}, {
	path: '',
	component: layout,
	meta: {
		title: 'dashboard',
		icon: 'dashboard',
		noCache: true // 非缓存  缓存等下
	}
}, {
	path: '/dashboard',
	component: layout,
	children: [{
		path: 'dashboard',
		component: () => import('@/views/dashboard/index'),
		name: 'Dashboard',
		meta: {
			title: 'dashboard',
			icon: 'dashboard',
			noCache: true // 非缓存  缓存等下
		}
	}],
	meta: {
		title: 'dashboard',
		icon: 'dashboard',
		noCache: true // 非缓存  缓存等下
	}
}]


export default new Router({
	scrollBehavior: () => ({
		y: 0
	}),
	routes: routerMap
})