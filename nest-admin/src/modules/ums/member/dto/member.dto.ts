import { ApiProperty } from "@nestjs/swagger";
export class MemberDto {
    @ApiProperty({
        type: 'number',
        description: 'ID'
    })
    readonly id: number;

    @ApiProperty({
        type: 'number',
        description: '会员等级'
    })
    readonly member_level_id: number;

    @ApiProperty({
        type: 'string',
        description: '昵称'
    })
    readonly username: string;

    @ApiProperty({
        type: 'string',
        description: '密码'
    })
    readonly password: string;

    @ApiProperty({
        type: 'string',
        description: '真实姓名'
    })
    readonly nickname: string;

    @ApiProperty({
        type: 'string',
        description: '手机号'
    })
    readonly phone: string;

    @ApiProperty({
        type: 'number',
        description: '状态'
    })
    readonly status: number;

    @ApiProperty({
        type: 'string',
        description: '头像'
    })
    readonly icon: string;

    @ApiProperty({
        type: 'number',
        description: '性别'
    })
    readonly gender: number;

    @ApiProperty({
        type: 'string',
        description: '生日'
    })
    readonly birthday: string;

    @ApiProperty({
        type: 'string',
        description: '城市'
    })
    readonly city: string;

    @ApiProperty({
        type: 'string',
        description: '职业'
    })
    readonly job: string;

    @ApiProperty({
        type: 'string',
        description: '个性签名'
    })
    readonly personalized_signature: string;

    @ApiProperty({
        type: 'number',
        description: '用户来源'
    })
    readonly source_type: number;

    @ApiProperty({
        type: 'number',
        description: '积分'
    })
    readonly integration: number;


    @ApiProperty({
        type: 'number',
        description: '成长值'
    })
    readonly growth: number;


    @ApiProperty({
        type: 'number',
        description: '剩余抽奖次数'
    })
    readonly luckey_count: number;

    @ApiProperty({
        type: 'number',
        description: '历史积分数量'
    })
    readonly history_integration: number;

    @ApiProperty({
        type: 'string',
        description: '注册时间'
    })
    readonly create_time: string;
}

