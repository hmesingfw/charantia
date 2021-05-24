import { Module, NestModule, MiddlewareConsumer, RequestMethod } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './modules/user/user.module'
import { MemberModule } from "./modules/ums/member/member.module";
import { TypeOrmModule } from '@nestjs/typeorm'
import { Connection } from 'typeorm'

import { LoggerMiddleware } from "./common/Middleware/logger.Middleware";

@Module({
    imports: [
        UserModule,
        MemberModule,
        TypeOrmModule.forRoot(),
    ],
    controllers: [AppController],
    providers: [AppService],
})
export class AppModule implements NestModule {
    constructor(private readonly connection: Connection) { }

    /** 日志中间件 */
    configure(consumer: MiddlewareConsumer) {
        consumer.apply(LoggerMiddleware).forRoutes('');
    }

}
