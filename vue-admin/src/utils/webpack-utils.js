const path = require('path')


const config = {
    build: {
        assetsSubDirectory: 'static',
    },
    dev: {
        assetsPublicPath: '/',
    }
}

exports.assetsPath = function (_path) {
    // let process = {
    //     env: '1111'
    // }
    // const assetsSubDirectory =
    //     process.env === 'production' ?
    //     config.build.assetsSubDirectory :
    //     config.dev.assetsSubDirectory
    return path.posix.join('/', _path)
}