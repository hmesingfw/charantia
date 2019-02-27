import axios from 'axios'
import store from '@/store'

axios.defaults.timeout = 4000

// request interceptor
axios.interceptors.request.use(
    config => {
        // Do something before request is sent
        if (store.getters.token) {
            // 让每个请求携带token-- ['X-Token']为自定义key 请根据实际情况自行修改
            // config.headers['X-Token'] = getToken()
        }
        return config
    },
    error => {
        // Do something with request error
        Promise.reject(error)
    }
)