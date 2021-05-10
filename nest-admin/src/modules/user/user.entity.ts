import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn, AfterLoad } from 'typeorm';

@Entity()
export class User {
    @PrimaryGeneratedColumn()
    id: string;

    @Column()
    account: string;

    @Column()
    name: string;

    @Column()
    password: string;

    @Column()
    password_salt: string;

    @Column()
    mobile: string;

    @Column()
    role: number;
    @AfterLoad()
    updateCounters() {
        this.role = 10000;
    }

    @Column()
    user_status: number;

    @Column()
    create_by: string;

    @CreateDateColumn()
    create_time: Date;

    @Column()
    update_by: string;

    @UpdateDateColumn()
    update_time: Date;

}