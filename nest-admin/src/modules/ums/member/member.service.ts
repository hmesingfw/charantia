import { Injectable } from "@nestjs/common";
import { Member } from "./member.entity";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";

@Injectable()
export class MemberService {
    constructor(
        @InjectRepository(Member)
        private readonly repository: Repository<Member>
    ) { }

    findAll(): Promise<Member[]> {
        return this.repository.find()
    }

}