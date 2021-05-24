import { Column, Entity, Index, PrimaryGeneratedColumn } from "typeorm";

@Index("idx_username", ["username"], { unique: true })
@Index("idx_phone", ["phone"], { unique: true })
@Entity("ums_member", { schema: "nest" })
export class Member {
    @PrimaryGeneratedColumn({ type: "bigint", name: "id" })
    id: string;

    @Column("bigint", { name: "member_level_id", nullable: true })
    memberLevelId: string | null;

    @Column("varchar", {
        name: "username",
        nullable: true,
        unique: true,
        comment: "用户名",
        length: 64,
    })
    username: string | null;

    @Column("varchar", {
        name: "password",
        nullable: true,
        comment: "密码",
        length: 64,
    })
    password: string | null;

    @Column("varchar", {
        name: "nickname",
        nullable: true,
        comment: "昵称",
        length: 64,
    })
    nickname: string | null;

    @Column("varchar", {
        name: "phone",
        nullable: true,
        unique: true,
        comment: "手机号码",
        length: 64,
    })
    phone: string | null;

    @Column("int", {
        name: "status",
        nullable: true,
        comment: "帐号启用状态:0->禁用；1->启用",
    })
    status: number | null;

    @Column("datetime", {
        name: "create_time",
        nullable: true,
        comment: "注册时间",
    })
    createTime: Date | null;

    @Column("varchar", {
        name: "icon",
        nullable: true,
        comment: "头像",
        length: 500,
    })
    icon: string | null;

    @Column("int", {
        name: "gender",
        nullable: true,
        comment: "性别：0->未知；1->男；2->女",
    })
    gender: number | null;

    @Column("date", { name: "birthday", nullable: true, comment: "生日" })
    birthday: string | null;

    @Column("varchar", {
        name: "city",
        nullable: true,
        comment: "所做城市",
        length: 64,
    })
    city: string | null;

    @Column("varchar", {
        name: "job",
        nullable: true,
        comment: "职业",
        length: 100,
    })
    job: string | null;

    @Column("varchar", {
        name: "personalized_signature",
        nullable: true,
        comment: "个性签名",
        length: 200,
    })
    personalizedSignature: string | null;

    @Column("int", { name: "source_type", nullable: true, comment: "用户来源" })
    sourceType: number | null;

    @Column("int", { name: "integration", nullable: true, comment: "积分" })
    integration: number | null;

    @Column("int", { name: "growth", nullable: true, comment: "成长值" })
    growth: number | null;

    @Column("int", {
        name: "luckey_count",
        nullable: true,
        comment: "剩余抽奖次数",
    })
    luckeyCount: number | null;

    @Column("int", {
        name: "history_integration",
        nullable: true,
        comment: "历史积分数量",
    })
    historyIntegration: number | null;
}
