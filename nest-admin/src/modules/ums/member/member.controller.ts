import { Controller, Get, Post, Req, Body, HttpCode, HttpException, HttpStatus } from '@nestjs/common';
import { MemberService } from "./member.service";

import { ApiQuery, ApiBody, ApiTags, ApiResponse, ApiOperation } from "@nestjs/swagger";

@ApiTags('ums-member -- 会员信息')
@Controller('api/member')
export class MemberController {
    constructor(private readonly memberService: MemberService) { }

    @Get('')
    @ApiOperation({ summary: '会员列表信息' })
    findAll(): Promise<any> {
        return this.memberService.findAll()
    }



}
