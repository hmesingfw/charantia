import Vue from 'vue'
import Router from 'vue-router'
// import layout from '@/views/layout/layout'

Vue.use(Router)

export const routerMap = [
	// 	{
	// 	path: '/login',
	// 	component: () => import('@/views/login/index'),
	// 	hidden: true, // 在路由面板隐藏此链接
	// }, {
	// 	path: '/index',
	// 	component: layout,
	// 	children: [{
	// 		path: 'dashboard',
	// 		component: () => import('@/views/dashboard/index'),
	// 		name: 'Dashboard',
	// 	}],
	// 	meta: {
	// 		icon: 'el-icon-document',
	// 	}
	// }, {
	// 	path: '/sys',
	// 	component: layout,
	// 	children: [{
	// 		path: 'menus',
	// 		component: () => import('@/views/menus/index'),
	// 		meta: {
	// 			icon: 'el-icon-document',
	// 		},

	// 	}, {
	// 		path: 'demo2',
	// 		component: () => import('@/views/dashboard/index'),
	// 		name: 'demo2',
	// 		meta: {
	// 			icon: 'el-icon-document',
	// 		},

	// 	}],
	// 	meta: {
	// 		icon: 'el-icon-document',
	// 	}
	// }
]

export default new Router({
	scrollBehavior: () => ({
		y: 0
	}),
	routes: routerMap
})