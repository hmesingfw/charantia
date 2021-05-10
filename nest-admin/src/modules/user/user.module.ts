import { Module } from '@nestjs/common';
import { UserController } from './user.controller'
import { UserService } from './user.service'
import { User } from "./user.entity";
import { TypeOrmModule } from "@nestjs/typeorm";

/* jwt */
import { JwtModule } from '@nestjs/jwt';
import { jwtConstants } from "./auth/auth.constants";

@Module({
    imports: [
        TypeOrmModule.forFeature([User]),
        JwtModule.register({
            secret: jwtConstants.secret,
            signOptions: { expiresIn: '60s' },
        }),
    ],
    controllers: [UserController],
    providers: [UserService],
})

export class UserModule { }