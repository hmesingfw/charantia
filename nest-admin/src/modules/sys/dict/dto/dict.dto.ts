import { ApiProperty } from "@nestjs/swagger";
export class DictInfo {
    @ApiProperty({
        type: 'string',
        description: '字典编号',
        maxLength: 32
    })
    readonly dictKey: string;

    @ApiProperty({
        type: 'string',
        description: '字典标题',
        maxLength: 32
    })
    readonly dictLabel: string;

    @ApiProperty({
        type: 'string',
        description: '字典值',
        maxLength: 32
    })
    readonly dictValue: string;

    @ApiProperty({
        type: 'string',
        description: '备注',
        required: false,
        maxLength: 32
    })
    readonly dictDesc: string;
}