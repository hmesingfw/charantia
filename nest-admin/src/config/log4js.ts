import * as path from 'path';
const baseLogPath = path.resolve(__dirname, '../../logs'); // 日志要写入哪个目录

const log4jsConfig = {
    appenders: {
        out: { type: 'console' },  // 类型： 输入日志 
        info: {
            type: 'dateFile',
            filename: `${baseLogPath}/info.log`,
            alwaysIncludePattern: true,   // 是否总有后缀名
            layout: {
                type: 'pattern',
                pattern: '{"date":"%d","level":"%p","category":"%c","host":"%h","pid":"%z","data":\'%m\'}',
            },
            pattern: 'yyyy-MM-dd', // 日志文件按日期（天）切割， 后缀，以一天来讯息
            daysToKeep: 60,
            // maxLogSize: 10485760,
            numBackups: 3,
            keepFileExt: true,
        },
        warn: {
            type: 'dateFile',
            filename: `${baseLogPath}/warn.log`,
            alwaysIncludePattern: true,
            layout: {
                type: 'pattern',
                pattern: '{"date":"%d","level":"%p","category":"%c","host":"%h","pid":"%z","data":\'%m\'}',
            },
            // 日志文件按日期（天）切割
            pattern: 'yyyy-MM-dd',
            daysToKeep: 60,
            // maxLogSize: 10485760,
            numBackups: 3,
            keepFileExt: true,
        },
        error: {
            type: 'dateFile',
            filename: `${baseLogPath}/error.log`,
            alwaysIncludePattern: true,
            layout: {
                type: 'pattern',
                pattern: '{"date":"%d","level":"%p","category":"%c","host":"%h","pid":"%z","data":\'%m\'}',
            },
            // 日志文件按日期（天）切割
            pattern: 'yyyy-MM-dd',
            daysToKeep: 60,
            // maxLogSize: 10485760,
            numBackups: 3,
            keepFileExt: true,
        },

    },
    categories: {
        /**
         * appenders 实现上面appenders
         * level 输入类型要大于等于当前
         */
        //appenders:采用的appender,取上面appenders项,level:设置级别

        warn: { appenders: ['warn'], level: 'warn' },
        error: { appenders: ['error'], level: 'error' },
        default: {
            appenders: ['info',],
            level: 'DEBUG',
        },
    },
    pm2: true, // 使用 pm2 来管理项目时，打开
    pm2InstanceVar: 'INSTANCE_ID', // 会根据 pm2 分配的 id 进行区分，以免各进程在写日志时造成冲突
};

export default log4jsConfig;