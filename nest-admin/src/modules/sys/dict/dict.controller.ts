import {
    Controller,
    Get,
    Post,
    Body,
    Patch,
    Param,
    Delete,
    Query,
} from '@nestjs/common';
import { DictService } from './dict.service';
import { ApiTags, ApiOperation, ApiBody } from '@nestjs/swagger';
import { Dict } from './entities/dict.entity';
import { DictInfo } from './dto/dict.dto';

@ApiTags('dict - 系统数据字典')
@Controller('sys/dict')
export class DictController {
    constructor(private readonly dictService: DictService) { }

    @ApiOperation({ summary: '新增数据字典' })
    @ApiBody({ type: DictInfo })
    @Post()
    create(@Body() dict: Dict) {
        return this.dictService.create(dict);
    }

    @ApiOperation({ summary: '新增数据字典,保存子类' })
    @ApiBody({ type: DictInfo })
    @Post(':id')
    children(@Param('id') id: number, @Body() dict: Array<Dict>) {
        return this.dictService.createChildren(id, dict);
    }


    @ApiOperation({ summary: '数据字典列表' })
    @Get()
    findAll(@Query() params) {
        return this.dictService.findAll(params);
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
