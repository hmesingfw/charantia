import { createApp } from 'vue'
import App from './App.vue'
import router from './router/index'
import vuex from './store/index'
import element from './plugins/element'
// import sytle
import './styles/index.scss'

const app = createApp(App)
element(app)
app.use(router)
app.use(vuex)
app.mount('#app')
