import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from '@/store/index'
import axios from 'axios'
import i18n from './lang'
import api from '@/config/api'
import './plugins/element.js'

import './icons/index.js'
import './http.js'                              // 全局请求配置

import 'normalize.css/normalize.css' // a modern alternative to CSS resets

import './styles/element-variables.scss'
import '@/styles/sys.scss'

import '@/styles/index.scss' // global css

import './plugins/import-component.js'              //  封装引用的全局组件


Vue.config.productionTip = false
Vue.prototype.$http = axios;
Vue.prototype.$api = api;

import '@/utils/vue-prototype-func.js'              //  引用全局方法
new Vue({
    router,
    store,
    i18n,
    render: h => h(App),
}).$mount('#app')