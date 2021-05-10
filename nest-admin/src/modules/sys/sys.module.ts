import { Module } from '@nestjs/common';
import { SysController } from './sys.controller';
import { SysService } from './sys.service';
import { AuthModule } from '../auth/auth.module'
@Module({
    imports: [AuthModule],
    controllers: [SysController],
    providers: [SysService],
})
export class SysModule { }