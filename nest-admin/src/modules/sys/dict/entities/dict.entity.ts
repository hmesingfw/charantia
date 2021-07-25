import { Column, Entity, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn } from "typeorm";

@Entity("sys_dict", { schema: "nest" })
export class Dict {
    @PrimaryGeneratedColumn({ type: "bigint", name: "id" })
    id: string;

    @Column('bigint', {
        name: 'parent_id',
        comment: "父级ID",
    })
    parentId: number | 0;

    @Column("varchar", {
        name: "dict_module",
        nullable: true,
        comment: "字典模块",
        length: 32,
    })
    dictModule: string | null;

    @Column("varchar", {
        name: "dict_key",
        nullable: true,
        comment: "字典key",
        length: 32,
    })
    dictKey: string | null;

    @Column("varchar", {
        name: "dict_label",
        nullable: true,
        comment: "字典名称",
        length: 32,
    })
    dictLabel: string | null;

    @Column("varchar", {
        name: "dict_value",
        nullable: true,
        comment: "字典值",
        length: 32,
    })
    dictValue: string | null;

    @Column("varchar", {
        name: "dict_desc",
        nullable: true,
        comment: "字典描述",
        length: 32,
    })
    dictDesc: string | null;

    @Column("int", {
        name: "sort",
        comment: "排序",
    })
    sort: number | 0;

    @Column("char", {
        name: "is_lock",
        nullable: true,
        comment: "是否内置： 1内置， 0非内置",
        length: 1,
    })
    isLock: string | null;

    @Column("char", {
        name: "status",
        nullable: true,
        comment: "状态： 1 启用 0 禁用",
        length: 1,
    })
    status: string | null;


    /** 请在mysql 字段上，默认值  设置成 CURRENT_TIMESTAMP */
    @CreateDateColumn({ name: "create_time" })
    createTime: Date;

    @Column("varchar", { name: "create_by", nullable: true, length: 32 })
    createBy: string | null;

    @UpdateDateColumn({ name: "update_time", default: () => 'CURRENT_TIMESTAMP' })
    updateTime: Date;

    @Column("varchar", { name: "update_by", nullable: true, length: 32 })
    updateBy: string | null;
}
