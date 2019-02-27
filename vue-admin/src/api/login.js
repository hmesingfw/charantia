import request from '@/utils/request'
import axios from 'axios'

export function loginByUsername(username, password) {
  const data = {
    username,
    password
  }
  // ?username=admin&password=1111'

  return request({
    url: '/login/login',
    method: 'post',
    data
  })
}

export function logout() {
  return request({
    url: '/login/logout',
    method: 'post'
  })
}

export function getUserInfo(token) {
  return request({
    url: '/user/info',
    method: 'get',
    params: {
      token
    }
  })
}