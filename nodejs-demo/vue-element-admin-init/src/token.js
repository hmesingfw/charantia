import axios from 'axios';
import { Message } from 'element-ui'
import router from './router/index'
import { FilterTokenAdress } from "@/utils/filter-adress";
import { getToken, getUserId, clearToken } from '@/utils/local-storage-auto';

// 添加请求拦截器
axios.interceptors.request.use(function (config) {
    // 在发送请求之前做些什么

    if (FilterTokenAdress(config.url)) {
        return config;
    }    

    return config;
}, function (error) {
    // 对请求错误做些什么
    return Promise.reject(error);
});

// 添加响应拦截器
axios.interceptors.response.use(function (response) {
    // 对响应数据做点什么
    let code = response.data.code;
    if (code == 1001 || code == 1002 || code == 1004 || code == 403) {
        clearToken();    //.. 清除token 缓存
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
    // 对响应错误做点什么
    return Promise.reject(error);
});


