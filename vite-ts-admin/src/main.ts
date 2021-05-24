import { createApp } from 'vue'
import App from './App.vue'

import ElementPlus from 'element-plus'
import 'element-plus/lib/theme-chalk/index.css'

import router from './router/index'
import { createStore } from "./store/index";

import HCust from '@/components/HCust/index.ts'
import './styles/index.scss'
import './styles/main.scss'

import axios from './config/axios-config'
import api from './config/api'
import { Code } from './config/index'

const app = createApp(App)
app.use(ElementPlus)
app.use(router)
app.use(createStore)


/** 引入组件 */
HCust(app)

/**  全局配置 */
app.config.globalProperties.$api = api;
app.config.globalProperties.$http = axios;
app.config.globalProperties.$code = Code;
app.mount('#app')
