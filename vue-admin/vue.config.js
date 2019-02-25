const path = require('path');
const utils = require('./src/utils/webpack-utils')

function resolve(dir) {
    return path.join(__dirname, dir)
}
console.log(resolve('src/icons/svg/'));
module.exports = {
    chainWebpack: config => {
        config.module
            .rule('svg-sprite-loader')
            .test(/\.svg$/)
            .include.add(resolve('src/icons')).end()
            .use('svg-sprite-loader')
            .loader('svg-sprite-loader')
            .options({
                symbolId: 'icon-[name]'
            })
        config.module
            .rule('url-loader')
            .test(/\.(png|jpe?g|gif|svg)(\?.*)?$/)
            .exclude.add(resolve('src/icons/svg')).end()
            .use('url-loader')
            .loader('url-loader')
            .options({
                limit: 10000,
                name: utils.assetsPath('img/[name].[hash:7].[ext]')
            })

        // {
        //     test: /\.svg$/,
        //     loader: 'svg-sprite-loader',
        //     include: [resolve('src/icons')],
        //     options: {
        //         symbolId: 'icon-[name]'
        //     }
        // }, {
        //     test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
        //     loader: 'url-loader',
        //     exclude: [resolve('src/icons')],
        //     options: {
        //         limit: 10000,
        //         name: utils.assetsPath('img/[name].[hash:7].[ext]')
        //     }
        // },
    }
}