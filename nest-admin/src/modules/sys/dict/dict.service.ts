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

    async findOne(id: number) {
        return await this.dictRepository.findOne(id);
    }

    async update(id: number, dict: Dict) {
        const info = await this.findOne(id);
        console.log(info)
        return await this.dictRepository.save(dict);
    }

    remove(id: number) {
        return this.dictRepository.delete(id);
    }
}
