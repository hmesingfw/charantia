import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity("sys_dict", { schema: "nest" })
export class SysDict {
  @PrimaryGeneratedColumn({ type: "bigint", name: "id" })
  id: string;

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

  @Column("datetime", { name: "create_time", nullable: true })
  createTime: Date | null;

  @Column("varchar", { name: "create_by", nullable: true, length: 32 })
  createBy: string | null;

  @Column("datetime", { name: "update_time", nullable: true })
  updateTime: Date | null;

  @Column("varchar", { name: "update_by", nullable: true, length: 32 })
  updateBy: string | null;
}
