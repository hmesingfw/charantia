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
	children: [{
		path: 'dashboard',
		component: () => import('@/views/dashboard/index'),
		name: 'Dashboard',
	}],
	meta: {
		title: 'index',
		icon: 'el-icon-document',
		noCache: true // 非缓存  缓存等下
	}
}, {
	path: '/dashboard',
	component: layout,
	children: [{
		path: 'wangwi',
		component: () => import('@/views/dashboard/index'),
		name: 'Dashboard_r',
		meta: {
			title: 'wangwi',
			icon: 'el-icon-document',
			noCache: true // 非缓存  缓存等下
		},

	}, {
		path: 'wangwu',
		component: () => import('@/views/dashboard/index'),
		name: 'Dashboard_us',
		meta: {
			title: 'wangwu',
			icon: 'el-icon-document',
			noCache: true // 非缓存  缓存等下
		},
		children: [{
			path: 'zhang',
			component: () => import('@/views/dashboard/index'),
			name: 'zhang',
			meta: {
				title: 'zhang',
				icon: 'el-icon-document',
				noCache: true // 非缓存  缓存等下
			},

		}, {
			path: 'liosti',
			component: () => import('@/views/dashboard/index'),
			name: '/liosti',
			meta: {
				title: 'liosti',
				icon: 'el-icon-document',
				noCache: true // 非缓存  缓存等下
			}
		}],
	}],
	meta: {
		title: 'title',
		icon: 'el-icon-document',
		noCache: true // 非缓存  缓存等下
	}
}]


export default new Router({
	scrollBehavior: () => ({
		y: 0
	}),
	routes: routerMap
})