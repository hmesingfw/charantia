import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { DictService } from './dict.service';
import { ApiTags, ApiOperation } from '@nestjs/swagger';
import { Dict } from "./entities/dict.entity";


@ApiTags('dict - 系统数据字典')
@Controller('dict')
export class DictController {
    constructor(private readonly dictService: DictService) { }

    @Post()
    create(@Body() dict: Dict) {
        return this.dictService.create(dict);
    }

    @ApiOperation({ summary: '数据字典列表' })
    @Get()
    findAll() {
        return this.dictService.findAll();
    }

    @Get(':id')
    findOne(@Param('id') id: string) {
        return this.dictService.findOne(+id);
    }

    @Patch(':id')
    update(@Param('id') id: string, @Body() dict: Dict) {
        return this.dictService.update(+id, dict);
    }

    @Delete(':id')
    remove(@Param('id') id: string) {
        return this.dictService.remove(+id);
    }
}
