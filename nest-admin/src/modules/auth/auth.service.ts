import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
    constructor(
        // private readonly usersService: UsersService,
        private readonly jwtService: JwtService
    ) { }

    // async validateUser(username: string, pass: string): Promise<any> {
    //     return {
    //         username, pass
    //     }
    // }

    async getToken(user: any) {
        const payload = { username: user.username, sub: user.sub };

        return {
            access_token: this.jwtService.sign(payload),
        };
    }
}