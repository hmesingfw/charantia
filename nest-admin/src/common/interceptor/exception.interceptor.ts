import { Injectable, NestInterceptor, ExecutionContext, InternalServerErrorException, CallHandler, RequestTimeoutException } from '@nestjs/common';
import { Observable, throwError, TimeoutError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Logger } from "./../../utils/log4js";

@Injectable()
export class ErrorsInterceptor implements NestInterceptor {
    intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
        return next
            .handle()
            .pipe(catchError(err => {

                const logFormat = err;
                Logger.error(logFormat);

                if (err instanceof TimeoutError) {
                    return throwError(new RequestTimeoutException());
                }
                return throwError(err);
            }));
    }
}