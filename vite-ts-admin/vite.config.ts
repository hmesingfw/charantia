// @ts-ignore: Unreachable code error
import path from 'path'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueJsx from '@vitejs/plugin-vue-jsx'

function resolve(dir) {
    // @ts-ignore: Unreachable code error
    return path.resolve(__dirname, dir)
}

const port = 3001 // dev port

// https://vitejs.dev/config/
export default defineConfig({
    server: {
        port,               // 设置端口
        // open: true, // 设置服务启动时是否自动打开浏览器
        cors: true, // 允许跨域
        proxy: {
            // 字符串简写写法
            '/api': 'http://localhost:3000',
            // 选项写法
            // '/api': {
            //     target: 'http://127.0.0.1:3000',
            //     changeOrigin: true,
            //     rewrite: (path) => path.replace(/^\/api/, '')
            // },
            // // 正则表达式写法
            // '^/fallback/.*': {
            //     target: 'http://jsonplaceholder.typicode.com',
            //     changeOrigin: true,
            //     rewrite: (path) => path.replace(/^\/fallback/, '')
            // }
        }
    },
    resolve: {
        alias: {
            '@': resolve('src'),
        },
    },
    plugins: [vueJsx(), vue()],
    esbuild: {
        jsxFactory: 'h',
        jsxFragment: 'Fragment'
    },

})
