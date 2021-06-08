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

    async create(dict: Dict) {
        return await this.dictRepository.save(dict);
    }

    async findAll(params) {
        /* 处理页数偏移 */
        let skip = params.size * (params.page - 1);
        // if (params.page > 1) skip--;

        const list = await this.dictRepository.find({
            skip,
            take: params.size
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
