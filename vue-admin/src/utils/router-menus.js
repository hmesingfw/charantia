import axios from 'axios';
/**
 * 生成路由菜单信息
 */

function getMenus() {
    axios.get(`/egg/getMenus`).then(res => {
        console.log(res);
    }).catch(err => {

    })
}

export default getMenus;