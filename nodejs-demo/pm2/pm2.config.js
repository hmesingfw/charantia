module.exports = {
    "apps": [{
        name: 'http1',// 应用名称
        script: './src/http1.js',
        cwd: './',
        exec_mode: "fork_mode",                // 应用启动模式，支持fork和cluster模式
        "ignore_watch": [                           // 不用监听的文件
            "node_modules",
            "logs"
        ],
        error_file: "./logs/app-err.log",         // 错误日志文件
        out_file: "./logs/app-out.log",           // 正常日志文件
        merge_logs: true,                         // 设置追加日志而不是新建日志
        log_date_format: "YYYY-MM-DD HH:mm:ss",   // 指定日志文件的时间格式
        env: {
            HTTP1: 3001
        },
        env_dev: {
            HTTP1: 3001
        },
    }, {
        name: 'http2',// 应用名称
        script: './src/http2.js',
        cwd: './',
        exec_mode: "fork_mode",                // 应用启动模式，支持fork和cluster模式
        env: {
            HTTP2: 3002
        },
        env_dev: {
            HTTP2: 3002
        },
    }]
}