const path = require('path');
const utils = require('./src/utils/webpack-utils')

function resolve(dir) {
    return path.join(__dirname, dir)
} 

module.exports = {
    devServer: {
        proxy: {
            '/egg': {
                target: 'http://localhost:7001',
                changeOrigin: true,
                pathRewrite: {
                    '^/egg': ''
                }
            }
        }
    },
    chainWebpack: config => {

        const svgRule = config.module.rule('svg')
        // 清除已有的所有 loader。
        // 如果你不这样做，接下来的 loader 会附加在该规则现有的 loader 之后。
        svgRule.uses.clear()

        // 添加要替换的 loader
        svgRule
            .test(/\.(svg)(\?.*)?$/)
            .exclude.add(resolve('src/icons/svg')).end()
            .use('vue-svg-loader')
            .loader('vue-svg-loader')

        config.module
            .rule('svg-sprite')
            .test(/\.svg$/)
            .include.add(resolve('src/icons')).end()
            .use('svg-sprite')
            .loader('svg-sprite-loader')
            .options({
                symbolId: 'icon-[name]'
            })
        config.module
            .rule('url')
            .test(/\.(png|jpe?g|gif|svg)(\?.*)?$/)
            .exclude.add(resolve('src/icons/svg')).end()
            .use('url')
            .loader('url-loader')
            .options({
                limit: 10000,
                name: utils.assetsPath('img/[name].[hash:7].[ext]')
            })
    },

}