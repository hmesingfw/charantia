import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { MemberService } from './member.service';
import { MemberDto } from './dto/member.dto';
import { Member } from "./entities/member.entity";
import { ApiTags, ApiOperation, ApiParam, ApiBody } from "@nestjs/swagger";

@ApiTags('member - 会员信息模块')
@Controller('member')
export class MemberController {
    constructor(private readonly memberService: MemberService) { }

    @ApiOperation({ summary: '新增会员' })
    @ApiBody({ type: MemberDto, description: '参数信息' })
    @Post()
    create(@Body() Member: Member) {
        return this.memberService.create(Member);
    }

    @ApiOperation({ summary: '会员列表' })
    @Get()
    findAll() {
        return this.memberService.findAll();
    }

    @ApiOperation({ summary: '查询会员详细' })
    @Get(':id')
    findOne(@Param('id') id: string) {
        return this.memberService.findOne(+id);
    }

    @ApiOperation({ summary: '更新会员' })
    @ApiParam({ name: 'id', description: '会员编号' })
    @ApiBody({ description: '更新实例', type: MemberDto })
    @Patch(':id')
    update(@Param('id') id: string, @Body() member: Member) {
        return this.memberService.update(+id, member);
    }

    @ApiOperation({ summary: '删除会员' })
    @ApiParam({ name: 'id', description: '会员编号' })
    @Delete(':id')
    remove(@Param('id') id: string) {
        return this.memberService.remove(+id);
    }
}
