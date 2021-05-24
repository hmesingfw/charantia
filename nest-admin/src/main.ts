import "reflect-metadata";

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { TransformInterceptor } from './common/interceptor/transform.interceptor';
import { ErrorsInterceptor } from "./common/interceptor/exception.interceptor";
import { HttpExceptionFilter } from "./common/Filter/http-exception.filter";

import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
async function bootstrap() {
    const app = await NestFactory.create(AppModule, {
        // logger: new MyLogger(),
    });

    /* 全局拦截器 */
    app.useGlobalInterceptors(new TransformInterceptor());
    app.useGlobalInterceptors(new ErrorsInterceptor());

    /* 全局过滤器 */
    app.useGlobalFilters(new HttpExceptionFilter());

    /**
     * swagger  */
    const config = new DocumentBuilder()
        .setTitle('接口文档')
        .setDescription('系统api请求地址文档')
        .setVersion('1.0')
        .build();
    const document = SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('doc', app, document);


    await app.listen(3000);
}
bootstrap();
