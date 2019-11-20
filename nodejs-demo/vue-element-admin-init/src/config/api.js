var baseURL = '';

if (process.env.NODE_ENV === 'development') {
    baseURL = 'http://192.168.31.135:10006'
} else {
    baseURL = window.g.Url || process.env.VUE_APP_URL
}
console.log(process.env.NODE_ENV, process.env);
export default {
    /* 系统管理 */
    sys: {
        eventCategory: baseURL + '/api/v1/eventCategory',   // 活动类型   

    },
    /* 平台登录  */
    user: {
        login: baseURL + '/api/v1/user/signIn',   // 登录接口
        queryButtonByPId: baseURL + '/sys/syspermission/queryButtonByPId',   // 用户获取按钮权限信息
        updatePwd: baseURL + '/sys/sysuser/updatePwd', // 修改密码
    },
}