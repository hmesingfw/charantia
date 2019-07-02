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

import {
  initLang
} from "./utils/lang";


new Vue({
  router,
  store,
  i18n,
  render: h => h(App),
  beforeCreate() {
    this.$store.dispatch('flashEnumList'); //刷新枚举数据
  },
  created() {
    this.initLang();
    getRouter.then(routes => {
      this.$router.addRoutes(routes);
      this.$store.dispatch('FlashNavMenu'); //刷新左侧展示路由
    })
  },
  methods: {
    initLang
  }
}).$mount('#app')