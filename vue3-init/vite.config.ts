const path = require('path')

import vueJsx from '@vitejs/plugin-vue-jsx'
import vue from '@vitejs/plugin-vue';

// const CompressionPlugin = require('compression-webpack-plugin')
const defaultSettings = require('./src/settings.js')

function resolve(dir) {
    return path.resolve(__dirname, dir)
}

const name = defaultSettings.title || 'vue Element Admin' // page title

// port = 9527 npm run dev OR npm run dev --port = 9527
const port = process.env.port || process.env.npm_config_port || 9527 // dev port

// All configuration item explanations can be find in https://cn.vitejs.dev/
module.exports = {
    /**
     * vite config 
     */
    port,               // 设置端口
    alias: {
        '/@/': resolve('src'),
    },
    // 第三方配置需要引用后， 才能在项目内import 引用
    optimizeDeps: ['axios', 'vue-draggable-next'],
    // 引入插件
    plugins: [
        vueJsx({}),
        vue(),
    ],
}
