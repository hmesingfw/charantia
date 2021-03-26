import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from '@/store/index'
import axios from 'axios'
import './plugins/element.js'
import './icons/index.js'

import 'normalize.css/normalize.css' // a modern alternative to CSS resets
import '@/plugins/import-component'
// import './styles/element-variables.scss'

import '@/styles/index.scss' // global css
import '@/styles/sys.scss' // 配置后台系统样式

import '@/directive/permission'

import '@/utils/vue-prototype-func'
import api from '@/config/api'

const app = createApp(App);
app.use(router)
app.use(store)

app.config.productionTip = false;

app.config.globalProperties.$api = api;
app.config.globalProperties.$http = axios;
app.mount('#app');

