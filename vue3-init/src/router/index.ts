import { RouteRecordRaw, createRouter, createWebHistory } from 'vue-router';

/* Layout */
import Layout from '/@/layout/index.vue'

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes: RouteRecordRaw[] = [
    {
        path: '/redirect',
        component: Layout,

        children: [
            {
                path: '/redirect/:path*',
                component: () => import('/@/views/redirect/index'),
            }
        ]
    },
    {
        path: '/',
        component: () => import('/@/views/login/index.vue'),

    },
    {
        path: '/404',
        component: () => import('/@/views/error-page/404'),
     
    {
        path: '/401',
        component: () => import('@/views/error-page/401'),

    },
    {
        path: '/dashboard',
        component: Layout,
        children: [
            {
                path: '',
                component: () => import('/@/views/dashboard/index.vue'),
                name: 'Dashboard',
                meta: { title: '首页', icon: 'dashboard', affix: true }
            }
        ]
    },
    {
        path: '/sys',
        component: Layout,
        children: [
            {
                path: 'table',
                component: () => import('/@/views/sys/page/table.vue'),
                name: 'Table',
                meta: { title: '表单', icon: 'dashboard', affix: true }
            }
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
    history: createWebHistory(process.env.BASE_URL),
    routes: constantRoutes
})

export default { router }
