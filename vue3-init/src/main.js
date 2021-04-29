import { createApp } from 'vue'
import App from './App.vue'
import router from './router/index'
import vuex from './store/index'
import pluginsElement from './plugins/element'
import pluginsCcomponents from './plugins/component'
// import sytle
import './styles/index.scss'
import './styles/main.scss'

const app = createApp(App)
pluginsElement(app)
pluginsCcomponents(app)
app.use(router)
app.use(vuex)
app.mount('#app')
