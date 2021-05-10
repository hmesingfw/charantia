import { Controller, Get, Post, Req, Body, HttpCode, HttpException } from '@nestjs/common';
import { UserService } from './user.service';
import { Request } from 'express';
import { LoginAccount } from "./dto/user";
import { JwtService } from '@nestjs/jwt';

@Controller('api/user')
export class UserController {
    constructor(private readonly userService: UserService, private readonly jwtService: JwtService) { }

    @Get()
    getHello(): Promise<any> {
        return this.userService.findAll();
    }

    @Post('/login')
    async login(@Body() loginAccount: LoginAccount): Promise<any> {

        const account = loginAccount.account;
        const userInfo = await this.userService.findAccount(account);

        if (!userInfo) {
            const errors = { User: ' not found' };
            throw new HttpException({ errors }, 401);
        }

        if (userInfo.password == loginAccount.password) {
            const { account, name, mobile, role } = userInfo;

            const token = this.jwtService.sign({ account, name, mobile, role });
            return { account, name, mobile, role, token };
        } else {
            return '密码错误'
        }
    }
}
