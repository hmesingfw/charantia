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
        console.log(dict)
        return await this.dictRepository.insert(dict);
    }

    async createChildren(id: number, dictList: Array<Dict>) {
        Promise.all(
            dictList.map(async (dict: Dict) => {
                dict.parentId = id;
                await this.dictRepository.save(dict);
            })
        ).then(res => {
            console.log(res)
        })
        return "保存成功"
    }

    async findAll(params) {
        if (params.size && params.page) {
            /* 处理页数偏移 */
            const page = {
                skip: params.size * (params.page - 1),
                take: params.size
            }
            const list = await this.dictRepository.find({
                order: { sort: "DESC" },
                ...page,
            });
            const total = await this.dictRepository.count();
            return { list, total }
        } else {
            console.log(params)
            const data = {
                where: params,
                order: { 'sort': 'DESC' }
            }  //  ??? 这里使用不可以
            return this.dictRepository.find({ where: params, order: { sort: 'DESC' } })
        }
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
