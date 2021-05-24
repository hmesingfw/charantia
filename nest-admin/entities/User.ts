import { Column, Entity } from "typeorm";

@Entity("user", { schema: "nest" })
export class User {
  @Column("varchar", { primary: true, name: "id", length: 13 })
  id: string;

  @Column("varchar", { name: "account", length: 40 })
  account: string;

  @Column("varchar", { name: "name", length: 40 })
  name: string;

  @Column("varchar", { name: "password", length: 255 })
  password: string;

  @Column("varchar", { name: "password_salt", length: 255 })
  passwordSalt: string;

  @Column("varchar", { name: "mobile", length: 20 })
  mobile: string;

  @Column("int", { name: "role" })
  role: number;

  @Column("int", { name: "user_status" })
  userStatus: number;

  @Column("varchar", { name: "create_by", length: 13 })
  createBy: string;

  @Column("datetime", {
    name: "create_time",
    default: () => "'CURRENT_TIMESTAMP(6)'",
  })
  createTime: Date;

  @Column("varchar", { name: "update_by", length: 13 })
  updateBy: string;

  @Column("datetime", {
    name: "update_time",
    default: () => "'CURRENT_TIMESTAMP(6)'",
  })
  updateTime: Date;
}
