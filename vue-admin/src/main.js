import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import i18n from './lang'
import './plugins/element.js'
import './icons/index.js'
import './directive/index'

import './config/axios-config'
Vue.config.productionTip = false
Vue.prototype.$http = axios;

new Vue({
  router,
  store,
  i18n,
  render: h => h(App)
}).$mount('#app')