import { RouteRecordRaw, createRouter, createWebHashHistory } from 'vue-router';

/* Layout */
import Layout from '@/layout/index.vue'

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes: Array<RouteRecordRaw> = [
    {
        path: '/redirect',
        component: Layout,
        children: [
            {
                path: '/redirect/:path*',
                component: () => import('@/views/redirect/index.vue'),
            },
        ]
    },
    {
        path: '/',
        component: () => import('@/views/login/index.vue'),
    },
    {
        path: '/dashboard',
        component: Layout,
        children: [
            {
                path: '/z',
                component: () => import('@/views/dashboard/index.vue'),
                meta: { title: '首页1', icon: 'el-icon-setting', affix: true, }
            },
        ]
    },
    {
        path: '/sys',
        component: Layout,
        name: 'Sys',
        meta: { title: '系统配置', icon: 'el-icon-setting', affix: true, },
        children: [
            {
                path: 'table',
                component: () => import('@/views/sys/table.vue'),
                meta: { title: '表格', icon: 'el-icon-setting', affix: true, }
            },
            {
                path: 'dict',
                component: () => import('@/views/sys/dict/index.vue'),
                meta: { title: '数据字典', icon: 'el-icon-setting', affix: true, }
            },
        ]
    },
    {
        path: '/member',
        component: Layout,
        name: 'Member',
        meta: { title: '会员管理', icon: 'el-icon-setting', affix: true, },
        children: [
            {
                path: 'info',
                component: () => import('@/views/member/info/index.vue'),
                meta: { title: '会员信息', icon: 'el-icon-setting', affix: true, }
            },
        ]
    },


    // { path: '*', redirect: '/404', hidden: true }
]

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
// export function resetRouter() {
//     const newRouter = createRouter()
//     router.matcher = newRouter.matcher // reset router
// }

const router = createRouter({
    history: createWebHashHistory(),
    routes: constantRoutes
})

export default router 
