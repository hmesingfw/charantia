import { Injectable } from '@nestjs/common';
import { MemberDto } from './dto/member.dto';
import { Member } from "./entities/member.entity";
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class MemberService {
    constructor(
        @InjectRepository(Member)
        private readonly memberRepository: Repository<Member>
    ) {

    }
    create(Member: Member) {
        return this.memberRepository.save(Member);
    }

    async findAll() {
        const list = await this.memberRepository.find({
            skip: 0,
            take: 2
        });
        const total = await this.memberRepository.count();
        return { list, total }
    }

    findOne(id: number) {
        return this.memberRepository.findOne(id);
    }

    update(id: number, member: Member) {
        return this.memberRepository.update(id, member);
    }

    remove(id: number) {
        return this.memberRepository.delete(id);
    }
}
