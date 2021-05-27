import { Controller, Get, Post, Req, Body, HttpCode, HttpException, HttpStatus } from '@nestjs/common';
import { UserService } from './user.service';
import { Request } from 'express';
import { LoginAccount } from "./dto/user";
import { JwtService } from '@nestjs/jwt';
import { ApiQuery, ApiBody, ApiTags, ApiResponse } from "@nestjs/swagger";

@ApiTags('user - 用户模块')
@Controller('user')
export class UserController {
    constructor(private readonly userService: UserService, private readonly jwtService: JwtService) { }

    @Get()
    getHello(): Promise<any> {
        throw new HttpException('异常', HttpStatus.FORBIDDEN);

        return this.userService.findAll();
    }

    @Post('/login')
    @ApiBody({ type: LoginAccount, description: '用户登录' })
    @ApiResponse({ status: 200, description: 'success' })
    async login(@Body() loginAccount: LoginAccount): Promise<any> {

        const account = loginAccount.account;
        const userInfo = await this.userService.findAccount(account);
        if (!userInfo) {
            return { message: '账号不存在，请联系管理人员', code: 2001, data: '' }
        }
        if (userInfo.password == loginAccount.password) {
            const { account, name, mobile, role } = userInfo;

            const token = this.jwtService.sign({ account, name, mobile, role });
            return { account, name, mobile, role, token };
        } else {
            return { message: '密码错误', code: 2001, data: '' }
        }
    }
}
