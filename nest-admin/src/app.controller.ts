import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { ApiQuery, ApiBody, ApiTags, ApiResponse } from "@nestjs/swagger";


@ApiTags('默认index 接口')
@Controller()
export class AppController {
    constructor(private readonly appService: AppService) { }

    @Get()
    getHello(): string {
        return this.appService.getHello();
    }
}
