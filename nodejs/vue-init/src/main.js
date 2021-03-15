import Vue from 'vue'
import App from './App.vue'
import router from '@/router'
import store from '@/store/index'
import axios from 'axios'
import api from '@/config/api'
 

import '@/icons/index.js'
import './http.js'                              // 全局请求配置

import 'normalize.css/normalize.css' // a modern alternative to CSS resets

/* element 样式 */
import Element from 'element-ui'
import '@/styles/element-variables.scss'

import '@/styles/sys.scss'

import '@/styles/index.scss' // global css

import '@/plugins/import-component.js'              //  封装引用的全局组件
import '@/directive/permission/index';


Vue.config.productionTip = false
Vue.prototype.$http = axios;
Vue.prototype.$api = api;
Vue.use(Element)
import '@/utils/vue-prototype-func.js'              //  引用全局方法
new Vue({
    router,
    store,
    render: h => h(App),
}).$mount('#app')