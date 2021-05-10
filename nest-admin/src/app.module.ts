import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { SysModule } from './modules/sys/sys.module'
import { AuthModule } from './modules/auth/auth.module'
import { UserModule } from './modules/user/user.module'
import { TypeOrmModule } from '@nestjs/typeorm'
import { Connection } from 'typeorm'

@Module({
    imports: [SysModule, AuthModule, UserModule,
        TypeOrmModule.forRoot(),
        // TypeOrmModule.forRoot({
        //     type: 'mysql',
        //     host: 'localhost',
        //     port: 3306,
        //     username: 'root',
        //     password: 'woxihuanni',
        //     database: 'nest', // 自己提前建好数据库, 无需建表
        //     entities: ['src/**/**.entity{.ts,.js}'], // 实体存放的目录, 目前只能靠文件后缀识别
        //     synchronize: false, // 项目一运行就根据实体自动创建表结构
        //     logging: true,
        // }),
    ],
    controllers: [AppController],
    providers: [AppService],
})
export class AppModule {
    constructor(private readonly connection: Connection) { }
}
