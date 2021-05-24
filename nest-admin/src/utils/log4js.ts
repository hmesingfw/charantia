import * as Path from 'path';
import * as Log4js from 'log4js';
import * as StackTrace from 'stacktrace-js';
import config from './../config/log4js';

// 日志级别
export enum LoggerLevel {
    ALL = 'ALL',
    MARK = 'MARK',
    TRACE = 'TRACE',
    DEBUG = 'DEBUG',
    INFO = 'INFO',
    WARN = 'WARN',
    ERROR = 'ERROR',
    FATAL = 'FATAL',
    OFF = 'OFF',
}

// 注入配置
Log4js.configure(config);

// 实例化
const logger = Log4js.getLogger();

export class Logger {

    static log(...args) {
        logger.warn(Logger.getStackTrace(), ...args);
    }

    static info(...args) {
        const loggerCustom = Log4js.getLogger('info');
        loggerCustom.info(Logger.getStackTrace(), ...args);
    }

    static warn(...args) {
        const loggerCustom = Log4js.getLogger('warn');
        loggerCustom.warn(Logger.getStackTrace(), ...args);
    }

    static error(...args) {
        const loggerCustom = Log4js.getLogger('error');
        loggerCustom.error(Logger.getStackTrace(), ...args);

    }


    // 日志追踪，可以追溯到哪个文件、第几行第几列
    static getStackTrace(deep: number = 2): string {
        const stackList: StackTrace.StackFrame[] = StackTrace.getSync();
        const stackInfo: StackTrace.StackFrame = stackList[deep];

        const lineNumber: number = stackInfo.lineNumber;
        const columnNumber: number = stackInfo.columnNumber;
        const fileName: string = stackInfo.fileName;
        const basename: string = Path.basename(fileName);
        return `${basename}(line: ${lineNumber}, column: ${columnNumber}): \n`;
    }
}