import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import './plugins/element.js'
import axios from 'axios'
import il8n from './lang'

Vue.config.productionTip = false
Vue.prototype.$http = axios
new Vue({
    router,
    store,
    il8n,
    render: h => h(App)
}).$mount('#app')
