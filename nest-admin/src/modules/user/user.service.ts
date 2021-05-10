import { Injectable, } from '@nestjs/common';
import { User } from './user.entity'
import { Repository } from 'typeorm';
import { InjectRepository } from "@nestjs/typeorm";

@Injectable()
export class UserService {
    constructor(
        @InjectRepository(User)
        private readonly userRepository: Repository<User>
    ) { }

    findAll(): Promise<User[]> {
        return this.userRepository.find();
    }


    findId(id: string): Promise<User> {
        return this.userRepository.findOne(id);
    }

    findMobile(mobile: string): Promise<User> {
        return this.userRepository.findOne({ mobile });
    }

    findAccount(account: string): Promise<User> {
        return this.userRepository.findOne({ account });
    }
}
