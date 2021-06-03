import { Injectable } from '@nestjs/common';
import { Dict } from "./entities/dict.entity";
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class DictService {
    constructor(
        @InjectRepository(Dict)
        private readonly dictRepository: Repository<Dict>
    ) { }
    create(dict: Dict) {
        return 'This action adds a new dict';
    }

    async findAll() {
        const list = await this.dictRepository.find({
            skip: 0,
            take: 2
        });
        const total = await this.dictRepository.count();
        return { list, total }
    }

    findOne(id: number) {
        return `This action returns a #${id} dict`;
    }

    update(id: number, dict: Dict) {
        return `This action updates a #${id} dict`;
    }

    remove(id: number) {
        return `This action removes a #${id} dict`;
    }
}
