import { getToken, setToken, removeToken} from '@/utils/auth'
import axios from 'axios'

const user = {
    state:{
        token: '',
    },
    mutations:{
        SET_TOKEN: (state, token) => {
            state.token = token
        },
    },
    actions: {
        // 用户名登录
        LoginByUsername({
            commit
        }, userInfo) {
            userInfo.username = userInfo.username.trim()
            return new Promise((resolve, reject) => {

                axios.get('/api/login/login', {
                    params: userInfo
                }).then(response => {

                    console.log(response);
                    const data = response.data
                    commit('SET_TOKEN', data.token)
                    setToken(response.data.token)
                    resolve()
                }).catch(error => {
                    reject(error)
                })
                
            })
        },
    }
}

export default user