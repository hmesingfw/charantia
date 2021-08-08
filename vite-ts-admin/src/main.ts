import { createApp } from 'vue'
import App from './App.vue'

import ElementPlus from 'element-plus'
import 'element-plus/lib/theme-chalk/index.css'
import locale from 'element-plus/lib/locale/lang/zh-cn'


import router from './router/index'
import { createStore } from "./store/index";

import HCust from '@/components/HCust/index'
import './styles/element-variables.scss'
import './styles/index.scss'
import './styles/main.scss'

import Http from "./utils/http";
import api from './config/api'
import { Code } from './config/index'
import utilsGlobal from './utils'

const app = createApp(App)
app.use(ElementPlus, { locale, size: 'mini' })
app.use(router)
app.use(createStore)


/** 引入组件 */
HCust(app);
/* 引入全局方法 */
utilsGlobal(app);

/**  全局配置 */
app.config.globalProperties.$api = api;
app.config.globalProperties.$http = Http;
app.config.globalProperties.$code = Code;
app.mount('#app')
