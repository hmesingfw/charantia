import { Module } from '@nestjs/common';
import { MemberController } from "./member.controller";
import { MemberService } from "./member.service";
import { Member } from "./member.entity";
import { TypeOrmModule } from "@nestjs/typeorm";


@Module({
    imports: [
        TypeOrmModule.forFeature([Member]),
    ],
    controllers: [MemberController],
    providers: [MemberService],
})

export class MemberModule { }