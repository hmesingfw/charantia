import { Injectable } from '@nestjs/common';

@Injectable()
export class SysService {

    /**
     * 返回hello
     */
    getHello(): string {
        return 'Hello World!';
    }

    /**
     * 登录
     */
    login(): object {
        return { type: 1, list: 2 };
    }
}
