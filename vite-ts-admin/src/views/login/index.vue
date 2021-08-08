<template>
    <div class="login-container">
        <div class="login-content">
            <div class="title-container">
                <h3 class="title">Login Form</h3>
            </div>
            <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form" autocomplete="on" label-position="left">
                <el-form-item prop="account">
                    <el-input ref="account" v-model="loginForm.account" placeholder="请输入账号" type="text" tabindex="1" autocomplete="on" prefix-icon="el-icon-user" />
                </el-form-item>

                <el-form-item prop="password">
                    <el-input
                        ref="password"
                        v-model="loginForm.password"
                        type="password"
                        placeholder="请输入密码"
                        name="password"
                        tabindex="2"
                        autocomplete="on"
                        prefix-icon="el-icon-lock"
                        keyup.native="checkCapslock"
                        @blur="capsTooltip = false"
                        @keyup.enter="handleLogin"
                    />
                </el-form-item>
                <el-row type="flex" justify="space-between" class="other-login">
                    <el-checkbox v-model="automaticLogin">自动登录</el-checkbox>
                    <el-button type="text">忘记密码</el-button>
                </el-row>
                <el-button :loading="loading" type="primary" style="width:100%;margin-bottom:30px;" @click.prevent="handleLogin">登&nbsp;&nbsp;录</el-button>
            </el-form>
        </div>
    </div>
</template>

<script lang="tsx">
import { defineComponent } from "vue"
export default defineComponent({
    name: "Login",
    data() {
        const validatePassword = (
            rule: any,
            value: string,
            callback: Function
        ) => {
            if (value.length < 6) {
                callback(new Error("密码不能少于6位数字"))
            } else {
                callback()
            }
        }
        return {
            automaticLogin: true,

            loginForm: {
                account: "admin",
                password: "123456",
            },
            loginRules: {
                account: [
                    {
                        required: true,
                        trigger: "blur",
                        message: "请输入正确的用户名",
                    },
                ],
                password: [
                    {
                        required: true,
                        trigger: "blur",
                        validator: validatePassword,
                    },
                ],
            },
            capsTooltip: false,
            loading: false,
            redirect: undefined,
        }
    },
    watch: {
        $route: {
            handler: function (route) {
                const query = route.query
                if (query) {
                    this.redirect = query.redirect
                }
            },
            immediate: true,
        },
    },
    mounted() {
        if (this.loginForm.account === "") {
            this.$refs.account.focus()
        } else if (this.loginForm.password === "") {
            this.$refs.password.focus()
        }
    },
    methods: {
        checkCapslock({ shiftKey, key }: any = {}) {
            if (key && key.length === 1) {
                if (
                    (shiftKey && key >= "a" && key <= "z") ||
                    (!shiftKey && key >= "A" && key <= "Z")
                ) {
                    this.capsTooltip = true
                } else {
                    this.capsTooltip = false
                }
            }
            if (key === "CapsLock" && this.capsTooltip === true) {
                this.capsTooltip = false
            }
        },
        handleLogin() {
            this.$refs.loginForm.validate(async (valid: any) => {
                if (valid) {
                    this.loading = true
                    try {
                        const res = await this.$store.dispatch(
                            "user/login",
                            this.loginForm
                        )
                        const { code, message } = res
                        if (code === this.$code.SUCCESS) {
                            this.$message.success("登录成功")
                            this.$router.push({
                                path: this.redirect || "/dashboard",
                            })
                        } else {
                            this.$message.error(message)
                        }
                        this.loading = false
                    } catch (error) {
                        this.loading = false
                    }
                } else {
                    this.loading = false
                }
            })
        },
    },
})
</script>
 
<style lang="scss" scoped>
.login-container {
    display: flex;
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    flex-direction: column;
    height: 100vh;
    overflow: auto;
    background-color: #f0f2f5;
    background-image: url(https://gw.alipayobjects.com/zos/rmsportal/TVYTbAXWheQpRcWDaDMu.svg);
    background-repeat: no-repeat;
    background-position-x: center;
    background-position-y: 110px;
    background-size: 100%;
    .login-content {
        padding: 32px 0;

        .title-container {
            text-align: center;
            .title {
                font-size: 33px;
                color: rgba(0, 0, 0, 0.85);
                font-family: "Myriad Pro", "Helvetica Neue", Arial, Helvetica,
                    sans-serif;
                font-weight: 600;
                position: relative;
                top: 2px;
            }
        }

        .login-form {
            width: 368px;
            margin: 40px auto 0;
        }

        .other-login {
            line-height: 4;
        }
    }
    @media (min-width: 768px) {
        .login-content {
            padding: 112px 0 24px;
        }
    }
}
</style>