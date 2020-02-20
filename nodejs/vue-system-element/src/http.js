import axios from 'axios';
import { Message } from 'element-ui';
import router from './router/index';
import Cookies from 'js-cookie';
// import { FilterTokenAdress } from '@/utils/filter-adress';

// 添加请求拦截器
axios.interceptors.request.use(function (config) {
    // 在发送请求之前做些什么

    // if (FilterTokenAdress(config.url)) {
    //     return config;
    // }
    // console.log(config, Cookies.get('csrfToken'));
    if (config.method != 'get') {
        config.headers['x-csrf-token'] = Cookies.get('csrfToken');              // csrf 防御  egg框架
    }
    return config;
}, function (error) {
    // 对请求错误做些什么
    return Promise.reject(error);
});

// 添加响应拦截器
axios.interceptors.response.use(function (response) {
    // console.log(response);
    // 对响应数据做点什么
    let code = response.data.code;
    if (code == 1001 || code == 1002 || code == 1004 || code == 403 || code == 401) {

        Message({
            message: '身份验证过期，请重新登录',
            type: 'info'
        });
        router.push(`/login?redirect=${router.history.current.fullPath}`);      // 重新登录               
    } else if (code == 500) {
        Message.error('系统错误，请联系后台管理人员');
    }

    return response;
}, function (error) {
    console.log('----response error', error);
    // 对响应错误做点什么
    Message({
        message: '服务器异常，请联系管理人员',
        type: 'error'
    });
    return Promise.reject(error);
});


