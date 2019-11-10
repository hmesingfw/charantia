import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'

/* Router Modules */
// import componentsRouter from './modules/components'
// import chartsRouter from './modules/charts'
// import nestedRouter from './modules/nested'

/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'             the icon show in the sidebar
    noCache: true                if set true, the page will no be cached(default is false)
    affix: true                  if set true, the tag will affix in the tags-view
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
  }
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [{
        path: '/redirect',
        component: Layout,
        hidden: true,
        children: [{
            path: '/redirect/:path*',
            component: () => import('@/views/redirect/index')
        }]
    },
    {
        path: '/login',
        component: () => import('@/views/login/index'),
        hidden: true
    },
    {
        path: '/auth-redirect',
        component: () => import('@/views/login/auth-redirect'),
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
        path: '/admin',
        component: Layout,
        redirect: '/dashboard',
        children: [{
            path: 'dashboard',
            component: () => import('@/views/dashboard/index'),
            name: 'Dashboard',
            meta: {
                title: '首页',
                icon: 'dashboard',
                affix: true
            }
        }]
    },
    {
        path: '/icon',
        component: Layout,
        hidden: true,
        children: [{
            path: 'index',
            component: () => import('@/views/icons/index'),
            name: 'Icons',
            meta: {
                title: '图标',
                icon: 'icon',
                noCache: true
            }
        }]
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
        children: [{
                path: '401',
                component: () => import('@/views/error-page/401'),
                name: 'Page401',
                meta: {
                    title: '401',
                    noCache: true
                }
            },
            {
                path: '404',
                component: () => import('@/views/error-page/404'),
                name: 'Page404',
                meta: {
                    title: '404',
                    noCache: true
                }
            }
        ]
    },


    {
        path: '/canvas',
        component: Layout,
        hidden: true,
        children: [{
            path: 'index',
            component: () => import('@/views/temp/canvas'),
            name: 'canvas',
            meta: {
                title: '样例',
                icon: 'user'
            }
        }]
    },



    {
        path: '/patients',
        component: Layout,
        children: [{
            path: 'index',
            component: () => import('@/views/patients/index'),
            name: 'patients',
            meta: {
                title: '病人信息',
                icon: 'icon',
                noCache: true
            }
        }]
    },
    {
        path: '/doctor',
        component: Layout,
        children: [{
            path: 'index',
            component: () => import('@/views/doctor/index'),
            name: 'doctor',
            meta: {
                title: '医生信息',
                icon: 'icon',
                noCache: true
            }
        }]
    },
    {
        path: '/sickbed',
        component: Layout,
        children: [{
            path: 'index',
            component: () => import('@/views/sickbed/index'),
            name: 'sickbed',
            meta: {
                title: '病床信息',
                icon: 'icon',
                noCache: true
            }
        }]
    },
    {
        path: '/item',
        component: Layout,
        children: [{
            path: 'index',
            component: () => import('@/views/item/index'),
            name: 'item',
            meta: {
                title: '项目信息',
                icon: 'icon',
                noCache: true
            }
        }]
    },
    {
        path: '/notes',
        component: Layout,
        children: [{
            path: 'index',
            component: () => import('@/views/notes/index'),
            name: 'notes',
            meta: {
                title: '重要事项',
                icon: 'icon',
                noCache: true
            }
        }]
    },

    {
        path: '/basedata',
        component: Layout,
        children: [{
            path: 'index',
            component: () => import('@/views/basedata/index'),
            name: 'basedata',
            meta: {
                title: '基础数据',
                icon: 'icon',
                noCache: true
            }
        }]
    },




    {
        path: '/sys',
        component: Layout,
        meta: {
            title: '平台管理',
            icon: 'dashboard',
            affix: true
        },
        children: [{
            path: 'sysuser',
            component: () => import('@/views/sysuser/index'),
            name: 'sysuser',
            meta: {
                title: '人员管理',
                icon: 'icon',
                noCache: true
            }
        }, {
            path: 'sysrole',
            component: () => import('@/views/sysrole/index'),
            name: 'sysrole',
            meta: {
                title: '角色管理',
                icon: 'icon',
                noCache: true
            }
        }, {
            path: 'syspermission',
            component: () => import('@/views/router-view/index'),
            name: 'syspermission',
            meta: {
                title: '菜单管理',
                icon: 'icon',
                noCache: true
            }
        }]
    },

    {
        path: '/list',
        component: () => import('@/views/panel/list'),
        hidden: true
    },
    {
        path: '/oldindex',
        component: () => import('@/views/panel/index'),
        hidden: true
    },
    {
        path: '/',
        component: () => import('@/views/panel/newIndex'),
        hidden: true
    },

    {
        path: '*',
        redirect: '/404',
        hidden: true
    }
]

const createRouter = () => new Router({
    // mode: 'history', // require service support
    scrollBehavior: () => ({
        y: 0
    }),
    routes: constantRoutes
})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
    const newRouter = createRouter()
    router.matcher = newRouter.matcher // reset router
}

export default router