import { createRouter, createWebHistory } from 'vue-router'

/* Layout */
import Layout from '@/layout'

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [
    {
        path: '/redirect',
        component: Layout,
        hidden: true,
        children: [
            {
                path: '/redirect/:path*',
                component: () => import('@/views/redirect/index')
            }
        ]
    },
    {
        path: '/',
        component: () => import('@/views/login/index'),
        hidden: true
    },
    {
        path: '/404',
        component: () => import('@/views/error-page/404'),
        hidden: true
    },
    {
        path: '/401',
        component: () => import('@/views/error-page/401'),
        hidden: true
    },
    {
        path: '/dashboard',
        component: Layout,
        children: [
            {
                path: '',
                component: () => import('@/views/dashboard/index'),
                name: 'Dashboard',
                meta: { title: '首页', icon: 'dashboard', affix: true }
            }
        ]
    },
    {
        path: '/icon',
        component: Layout,
        children: [
            {
                path: 'index',
                component: () => import('@/views/icons/index'),
                name: 'Icons',
                meta: { title: '图标', icon: 'icon', noCache: true }
            }
        ]
    },
    {
        path: '/error',
        component: Layout,
        redirect: 'noRedirect',
        hidden: true,
        name: 'ErrorPages',
        meta: {
            title: '错误页面',
            icon: '404'
        },
        children: [
            {
                path: '401',
                component: () => import('@/views/error-page/401'),
                name: 'Page401',
                meta: { title: '401', noCache: true }
            },
            {
                path: '404',
                component: () => import('@/views/error-page/404'),
                name: 'Page404',
                meta: { title: '404', noCache: true }
            }
        ]
    },
    {
        path: '/error-log',
        component: Layout,
        hidden: true,
        children: [
            {
                path: 'log',
                component: () => import('@/views/error-log/index'),
                name: 'ErrorLog',
                meta: { title: '错误日志', icon: 'guide' }
            }
        ]
    },
    {
        path: '/editor',
        component: Layout,
        meta: { title: '富文本', icon: 'guide' },
        children: [
            {
                path: 'router',
                component: () => import('@/views/editor/index'),
                meta: { title: '富文本', icon: 'guide' }
            }
        ]
    }, {
        path: '/sys',
        component: Layout,
        meta: { title: '系统配置', icon: 'guide' },
        children: [
            {
                path: 'menu',
                component: () => import('@/views/sys/menu/index'),
                name: 'sysMenu',
                meta: { title: '菜单管理', icon: 'icon' }
            }, {
                path: 'file',
                component: () => import('@/views/sys/file/index'),
                name: 'sysFile',
                meta: { title: '文件管理', icon: 'icon' }
            }, {
                path: 'verify',
                component: () => import('@/views/sys/verify/index'),
                name: 'sysVerify',
                meta: { title: '验证码', icon: 'icon' }
            }
        ]
    },

    { path: '*', redirect: '/404', hidden: true }
]

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
    const newRouter = createRouter()
    router.matcher = newRouter.matcher // reset router
}

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes: constantRoutes
})

export default router
