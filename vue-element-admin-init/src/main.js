import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from '@/store/index'
import axios from 'axios'
import i18n from './lang'
import './plugins/element.js'
import './icons/index.js'

import 'normalize.css/normalize.css' // a modern alternative to CSS resets

import 'animate.css'
import './styles/element-variables.scss'

import '@/styles/index.scss' // global css

// import './directive/index'

Vue.config.productionTip = false
Vue.prototype.$http = axios;

new Vue({
  router,
  store,
  i18n,
  render: h => h(App),
}).$mount('#app')