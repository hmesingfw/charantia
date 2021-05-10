import { Controller, Get, UseGuards } from '@nestjs/common';
import { SysService } from './sys.service';
import { AuthService } from '../auth/auth.service'
@Controller('api/sys')
export class SysController {
    constructor(private readonly sysService: SysService, private readonly authService: AuthService) { }

    @Get('login')
    async getHello(): Promise<Object> {

        const token = await this.authService.getToken({ username: 1, sub: 1 });
        const data = {
            ...this.sysService.login(),
            ...token
        }
        return data;
    }

    @Get('find')
    find(): string {
        return this.sysService.getHello();
    }
}
