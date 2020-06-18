'use strict'
const path = require('path')
const CompressionPlugin = require("compression-webpack-plugin")
const defaultSettings = require('./src/settings.js')

function resolve(dir) {
    return path.join(__dirname, dir)
}

const name = defaultSettings.title || 'vue Element Admin' // page title

// If your port is set to 80,
// use administrator privileges to execute the command line.
// For example, Mac: sudo npm run
// You can change the port by the following method:
// port = 9527 npm run dev OR npm run dev --port = 9527
const port = process.env.port || process.env.npm_config_port || 9527 // dev port


// All configuration item explanations can be find in https://cli.vuejs.org/config/
module.exports = {
    /**
     * You will need to set publicPath if you plan to deploy your site under a sub path,
     * for example GitHub Pages. If you plan to deploy your site to https://foo.github.io/bar/,
     * then publicPath should be set to "/bar/".
     * In most cases please use '/' !!!
     * Detail: https://cli.vuejs.org/config/#publicpath
     */
    publicPath: '/',
    outputDir: 'dist',
    assetsDir: 'static',
    lintOnSave: process.env.NODE_ENV === 'development',
    productionSourceMap: false,
    devServer: {
        port: port,
        open: true,
        overlay: {
            warnings: false,
            errors: true
        },
        proxy: {
            '/api': {
                target: 'http://192.168.31.135:8081/',// http://coc.purete.cn // process.env.VUE_APP_URL,
                changeOrigin: true,
                pathRewrite: {
                    '^/api': 'api'
                }
            },
        },
        // // after: require('./mock/mock-server.js')
    },
    pages: {
        // admin: {
        //     // page 的入口
        //     entry: 'src/admin/main.js',
        //     // 模板来源
        //     template: 'public/index.html',
        //     // 在 dist/index.html 的输出
        //     filename: 'admin.html',
        //     // 当使用 title 选项时，
        //     // template 中的 title 标签需要是 <title><%= htmlWebpackPlugin.options.title %></title>
        //     title: '平台',
        //     // 在这个页面中包含的块，默认情况下会包含
        //     // 提取出来的通用 chunk 和 vendor chunk。
        //     chunks: ['chunk-vendors', 'chunk-common', 'index']
        // },
        // tenanl: {
        //     // page 的入口
        //     entry: 'src/tenanl/main.js',
        //     // 模板来源
        //     template: 'public/index.html',
        //     // 在 dist/index.html 的输出
        //     filename: 'tenanl.html',
        //     // 当使用 title 选项时，
        //     // template 中的 title 标签需要是 <title><%= htmlWebpackPlugin.options.title %></title>
        //     title: '租户',
        //     // 在这个页面中包含的块，默认情况下会包含
        //     // 提取出来的通用 chunk 和 vendor chunk。
        //     chunks: ['chunk-vendors', 'chunk-common', 'index']
        // },
        // 当使用只有入口的字符串格式时，
        // 模板会被推导为 `public/subpage.html`
        // 并且如果找不到的话，就回退到 `public/index.html`。
        // 输出文件名会被推导为 `subpage.html`。
        admin: 'src/admin/main.js',
        // index: 'src/index/main.js',
    },
    configureWebpack: (config) => {
        const baseConfig = {
            name: name,
            resolve: {
                alias: {
                    '@': resolve('src'),
                    '@index': resolve('src/index'),
                    '@admin': resolve('src/admin'),
                },

            }
        }
        if (process.env.NODE_ENV === 'production') {        // 生产环境 
            return {
                plugins: [
                    // 压缩代码
                    new CompressionPlugin({
                        test: /\.js$|\.html$|.\css/, // 匹配文件名
                        threshold: 10240, // 对超过10k的数据压缩
                        deleteOriginalAssets: false, // true 删除源文件 false 不删除源文件     建议不删除源文件
                    }),
                ],
                ...baseConfig,
            };
        } else {
            /* 开发环境 */
            return {
                ...baseConfig
            };
        }
    },
    chainWebpack(config) {
        /* 添加分析工具*/
        if (process.env.NODE_ENV === 'production') {
            // config.plugin('webpack-bundle-analyzer').use(require('webpack-bundle-analyzer').BundleAnalyzerPlugin).end();
        }

        config.plugins.delete('preload') // TODO: need test
        config.plugins.delete('prefetch') // TODO: need test  不预先加载模块

        // set svg-sprite-loader
        config.module.rule('svg').exclude.add(resolve('src/icons')).end()
        config.module
            .rule('icons')
            .test(/\.svg$/)
            .include.add(resolve('src/icons'))
            .end()
            .use('svg-sprite-loader')
            .loader('svg-sprite-loader')
            .options({
                symbolId: 'icon-[name]'
            }).end()

        // set preserveWhitespace
        config.module
            .rule('vue')
            .use('vue-loader')
            .loader('vue-loader')
            .tap(options => {
                options.compilerOptions.preserveWhitespace = true
                return options
            })
            .end()
    }
}
