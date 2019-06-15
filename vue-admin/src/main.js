import './config/axios-config'

import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import i18n from './lang'
import './plugins/element.js'
import './icons/index.js'

import './directive/index'

Vue.config.productionTip = false
Vue.prototype.$http = axios;


import {
  getRouter
} from "./utils/route-menus";

new Vue({
  router,
  store,
  i18n,
  render: h => h(App),
  created() {
    getRouter.then(routes => {
      this.$router.addRoutes(routes);
      this.$store.dispatch('FlashNavMenu', true);
    })
  },
}).$mount('#app')