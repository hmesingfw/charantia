import { ExceptionFilter, Catch, ArgumentsHost, HttpException } from '@nestjs/common';
import { Request, Response } from 'express';
import { Logger } from "./../../utils/log4js";


@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
    catch(exception: HttpException, host: ArgumentsHost) {
        /**
        *  无法处理 500  Internal server error 异常
        */
        const ctx = host.switchToHttp();
        const response = ctx.getResponse<Response>();
        const request = ctx.getRequest<Request>();
        const status = exception.getStatus();
        const message = exception.getResponse();


        if (status >= 400) {
            const logFormat = `Method: ${request.method} \n Request original url: ${request.originalUrl} \n IP: ${request.ip} \n Status code: ${status}  \n`;
            Logger.warn(logFormat);
        }
        response.status(status).json({
            code: status,
            timestamp: new Date(),
            path: request.url,
            message: message,
        });
    }
}