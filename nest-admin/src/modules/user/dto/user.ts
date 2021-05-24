import { ApiProperty } from "@nestjs/swagger";
export class LoginAccount {
    @ApiProperty({
        type: 'string',
        description: '账号'
    })
    readonly account: string;
    @ApiProperty({
        type: 'string',
        description: '密码'
    })
    readonly password: string;
}