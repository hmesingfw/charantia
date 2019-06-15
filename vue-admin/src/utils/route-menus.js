import axios from "axios";
import layout from '@/views/layout/layout'

/** 生成路由表 */
function handleTreeRouter(routerList) {
    if (routerList) {
        return routerList.map(el => {

            return {
                hidden: el.show,
                path: el.path,
                component: el.component == 'layout' ? layout : () => import(`@/views${el.component}`),
                meta: {
                    icon: el.icon,
                },
                children: handleTreeRouter(el.children)
            }
        });
    } else {
        return [];
    }

}

/** 从后端，获取路由信息 */
export var getRouter = new Promise(function (resolve, rejects) {
    axios.get(`/egg/getMenus`).then(res => {
        resolve(handleTreeRouter(res.data));
    }).catch(err => {
        rejects(err);
    })
})